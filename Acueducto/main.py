from fastapi import HTTPException, Depends, Cookie, Response, Body
from fastapi import HTTPException
from typing import Optional
from cruds.EmpresasCrud import *
from cruds.ReunionesCrud import *
from cruds.UsuariosCrud import *
from cruds.SuperAdmin import *
from cruds.VariablesCrud import *
from pdfs.generarDocx import *
from fastapi import (
    FastAPI,
    Request,
    Form,
    status,
    Depends,
    HTTPException,
    Cookie,
    Query,
)
from fastapi.staticfiles import StaticFiles
from fastapi.responses import HTMLResponse, RedirectResponse
from fastapi.templating import Jinja2Templates
from sqlalchemy.orm import Session, joinedload
from funciones import *
from models import Empresa, Servicio, Usuario, Token, Vivienda
import bcrypt
from database import get_database
from funciones import get_datos_empresa
from typing import Union, List
from sqlalchemy import and_


SUPER_ADMIN = "SuperAdmin"
ADMIN = "Admin"
TECNICO = 'Tecnico'
ESTADO = "Activo"
datos_usuario = None

app = FastAPI()

# Agregando los archivos estaticos que están en la carpeta dist del proyecto
app.mount("/static", StaticFiles(directory="public/dist"), name="static")

template = Jinja2Templates(directory="public/templates")


@app.get("/", response_class=HTMLResponse, tags=["Login"])
def login(request: Request):
    headers = elimimar_cache()
    # return template.TemplateResponse("login.html", {"request": request})
    response = template.TemplateResponse("login.html", {"request": request})
    response.headers.update(headers)  # Actualiza las cabeceras
    return response


@app.get("/index", response_class=RedirectResponse, tags=["Operacion Index"])
def inicio(
    request: Request, token: str = Cookie(None), db: Session = Depends(get_database)
):
    if token:
        is_valid = verificar_token(token, db)
        if is_valid:
            usuario = db.query(Usuario).filter(
                Usuario.id_usuario == is_valid).first()
            headers = elimimar_cache()

            response = template.TemplateResponse(
                "index.html", {"request": request, "usuario": usuario}
            )
            response.headers.update(headers)  # Actualiza las cabeceras
            return response
        else:
            return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)

    return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)


# -- 1.1 --
# CENSO
@app.get("/censo", response_class=HTMLResponse, tags=["Operaciones Documentos"])
def pagCenso(
    request: Request, token: str = Cookie(None), db: Session = Depends(get_database)
):
    if token:
        is_token_valid = verificar_token(token, db)  # retorna el id_usuario

        if is_token_valid:
            rol_usuario = get_rol(is_token_valid, db)
            print(rol_usuario)
            datos_usuario = get_datos_usuario(is_token_valid, db)
            headers = elimimar_cache()
            if rol_usuario == SUPER_ADMIN or rol_usuario == ADMIN:
                response = template.TemplateResponse(
                    "paso-1/paso1-1/censo.html",
                    {"request": request, "usuario": datos_usuario},
                )
                response.headers.update(headers)  # Actualiza las cabeceras
                return response
            else:
                alerta = {
                    "mensaje": "No tiene los permisos para esta acción",
                    "color": "warning",
                }
                response = template.TemplateResponse(
                    "index.html",
                    {"request": request, "alerta": alerta, "usuario": datos_usuario},
                )
                response.headers.update(headers)  # Actualiza las cabeceras
                return response

        else:
            return RedirectResponse(url="/index", status_code=status.HTTP_303_SEE_OTHER)
    else:
        return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)


# CONCEPTOS BASICO
@app.get("/conceptos_basicos", response_class=HTMLResponse, tags=["Operaciones Documentos"])
def pagConceptosBasicos(
    request: Request, token: str = Cookie(None), db: Session = Depends(get_database)
):
    if token:
        is_token_valid = verificar_token(token, db)  # retorna el id_usuario

        if is_token_valid:
            rol_usuario = get_rol(is_token_valid, db)
            print(rol_usuario)
            datos_usuario = get_datos_usuario(is_token_valid, db)
            headers = elimimar_cache()
            if rol_usuario == SUPER_ADMIN or rol_usuario == ADMIN:
                response = template.TemplateResponse(
                    "paso-1/paso1-1/conceptos_basicos.html",
                    {"request": request, "usuario": datos_usuario},
                )
                response.headers.update(headers)  # Actualiza las cabeceras
                return response
            else:
                alerta = {
                    "mensaje": "No tiene los permisos para esta acción",
                    "color": "warning",
                }
                response = template.TemplateResponse(
                    "index.html",
                    {"request": request, "alerta": alerta, "usuario": datos_usuario},
                )
                response.headers.update(headers)  # Actualiza las cabeceras
                return response
        else:
            return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)
    else:
        return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)

# ESTATUTOS
@app.get("/estatutos", response_class=HTMLResponse, tags=["Operaciones Documentos"])
def pagEstatutos(
    request: Request, id_empresa: Union[str, None] = None, token: str = Cookie(None), db: Session = Depends(get_database),
):

    if token:
        is_token_valid = verificar_token(token, db)  # retorna el id_usuario

        if is_token_valid:
            ruta_pdf = None
            rol_usuario = get_rol(is_token_valid, db)
            datos_usuario = get_datos_usuario(is_token_valid, db)

            if rol_usuario == ADMIN:
                id_empresa = datos_usuario['empresa']
            if id_empresa:
                empresa_obtenida = db.query(Empresa).filter(
                    Empresa.id_empresa == id_empresa).first()
                if empresa_obtenida:
                    query = db.query(Documento).join(Usuario).join(Empresa, and_(
                        Usuario.empresa == Empresa.id_empresa, Empresa.id_empresa == id_empresa))
                    documentos_de_empresa = query.all()
                    for documento in documentos_de_empresa:
                        if documento.id_servicio == 1:
                            ruta_pdf = documento.url
                            break

            print(ruta_pdf)
            headers = elimimar_cache()
            if rol_usuario == ADMIN:

                response = template.TemplateResponse(
                    "paso-1/paso1-1/estatutos.html",
                    {"request": request, "usuario": datos_usuario,
                        "ruta_pdf": ruta_pdf},
                )
                response.headers.update(headers)  # Actualiza las cabeceras
                return response

            elif rol_usuario == SUPER_ADMIN:
                datos_empresas = db.query(Empresa).all()
                response = template.TemplateResponse(
                    "paso-1/paso1-1/estatutos.html",
                    {"request": request, "usuario": datos_usuario,
                        "ruta_pdf": ruta_pdf, "datos_empresas": datos_empresas},
                )
                response.headers.update(headers)  # Actualiza las cabeceras
                return response
            else:
                alerta = {
                    "mensaje": "No tiene los permisos para esta acción",
                    "color": "warning",
                }
                response = template.TemplateResponse(
                    "index.html",
                    {"request": request, "alerta": alerta, "usuario": datos_usuario},
                )
                response.headers.update(headers)  # Actualiza las cabeceras
                return response
        else:
            return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)
    else:
        return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)

'''
# CONTRATO DE CONDICIONES UNIFORME
@app.get("/contrato_condiciones", response_class=HTMLResponse, tags=["Operaciones Documentos"])
def pagContrato_de_condiciones_uniformes(
    request: Request, id_empresa: Union[str, None] = None, token: str = Cookie(None), db: Session = Depends(get_database)
):

    if token:
        is_token_valid = verificar_token(token, db)  # retorna el id_usuario

        if is_token_valid:
            ruta_pdf = None
            rol_usuario = get_rol(is_token_valid, db)
            datos_usuario = get_datos_usuario(is_token_valid, db)

            if rol_usuario == ADMIN:
                id_empresa = datos_usuario['empresa']
            if id_empresa:
                empresa_obtenida = db.query(Empresa).filter(
                    Empresa.id_empresa == id_empresa).first()
                if empresa_obtenida:
                    query = db.query(Documento).join(Usuario).join(Empresa, and_(
                        Usuario.empresa == Empresa.id_empresa, Empresa.id_empresa == id_empresa))
                    documentos_de_empresa = query.all()
                    for documento in documentos_de_empresa:
                        if documento.id_servicio == 2:
                            ruta_pdf = documento.url
                            break

            print(ruta_pdf)
            headers = elimimar_cache()
            if rol_usuario == ADMIN:

                response = template.TemplateResponse(
                    "paso-1/paso1-1/contrato_condiciones.html",
                    {"request": request, "usuario": datos_usuario,
                        "ruta_pdf": ruta_pdf},
                )
                response.headers.update(headers)  # Actualiza las cabeceras
                return response

            elif rol_usuario == SUPER_ADMIN:
                datos_empresas = db.query(Empresa).all()
                response = template.TemplateResponse(
                    "paso-1/paso1-1/contrato_condiciones.html",
                    {"request": request, "usuario": datos_usuario,
                        "ruta_pdf": ruta_pdf, "datos_empresas": datos_empresas},
                )
                response.headers.update(headers)  # Actualiza las cabeceras
                return response
            else:
                alerta = {
                    "mensaje": "No tiene los permisos para esta acción",
                    "color": "warning",
                }
                response = template.TemplateResponse(
                    "index.html",
                    {"request": request, "alerta": alerta, "usuario": datos_usuario},
                )
                response.headers.update(headers)  # Actualiza las cabeceras
                return response
        else:
            return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)
    else:
        return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)

'''

# INVITACION A LA ASAMBLEA
@app.get("/invitacion_asamblea", response_class=HTMLResponse, tags=["Operaciones Documentos"])
def pagInvitacion_a_la_asamblea(
    request: Request, id_empresa: Union[str, None] = None, token: str = Cookie(None), db: Session = Depends(get_database)
):

    if token:
        is_token_valid = verificar_token(token, db)  # retorna el id_usuario

        if is_token_valid:
            ruta_pdf = None
            rol_usuario = get_rol(is_token_valid, db)
            datos_usuario = get_datos_usuario(is_token_valid, db)

            if rol_usuario == ADMIN:
                id_empresa = datos_usuario['empresa']
            if id_empresa:
                empresa_obtenida = db.query(Empresa).filter(
                    Empresa.id_empresa == id_empresa).first()
                if empresa_obtenida:
                    query = db.query(Documento).join(Usuario).join(Empresa, and_(
                        Usuario.empresa == Empresa.id_empresa, Empresa.id_empresa == id_empresa))
                    documentos_de_empresa = query.all()
                    for documento in documentos_de_empresa:
                        if documento.id_servicio == 3:
                            ruta_pdf = documento.url
                            break

            print(ruta_pdf)
            headers = elimimar_cache()
            if rol_usuario == ADMIN:

                response = template.TemplateResponse(
                    "paso-1/paso1-1/invitacion_asamblea.html",
                    {"request": request, "usuario": datos_usuario,
                        "ruta_pdf": ruta_pdf},
                )
                response.headers.update(headers)  # Actualiza las cabeceras
                return response

            elif rol_usuario == SUPER_ADMIN:
                datos_empresas = db.query(Empresa).all()
                response = template.TemplateResponse(
                    "paso-1/paso1-1/invitacion_asamblea.html",
                    {"request": request, "usuario": datos_usuario,
                        "ruta_pdf": ruta_pdf, "datos_empresas": datos_empresas},
                )
                response.headers.update(headers)  # Actualiza las cabeceras
                return response
            else:
                alerta = {
                    "mensaje": "No tiene los permisos para esta acción",
                    "color": "warning",
                }
                response = template.TemplateResponse(
                    "index.html",
                    {"request": request, "alerta": alerta, "usuario": datos_usuario},
                )
                response.headers.update(headers)  # Actualiza las cabeceras
                return response
        else:
            return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)
    else:
        return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)


# FIN 1.1


# -- 1.2 --

@app.post("/crear_reunion")
async def crearReunion(
    id_empresa: str = Form(...),
    nom_reunion: str = Form(...),
    fecha: str = Form(...),
    hora: str = Form(...),
    lugar: str = Form(...),
    token: str = Cookie(None),
    db: Session = Depends(get_database),
):
    url_asistencia = "public/dist/ArchivoDescarga/P01-F-05_Listado de asistencia.xlsx - Hoja1.pdf"
    try:
        respuesta = createReunion(
            id_empresa,
            nom_reunion,
            fecha,
            hora,
            lugar,
            url_asistencia,
            token,
            db,
        )

        return respuesta
    except Exception as e:
        # Manejar cualquier excepción que pueda ocurrir
        return {"error": f"Error al procesar la solicitud: {str(e)}"}

# --- MOSTRAMOS LA PAGINA PARA CREAR UNA REUNION


@app.get("/reunion", response_class=HTMLResponse)
def MostrarFormReunion(
    request: Request, token: str = Cookie(None), db: Session = Depends(get_database)
):
    if token:
        token_valido = verificar_token(token, db)
        if token_valido:
            rol_usuario = get_rol(token_valido, db)
            usuario = (
                db.query(Usuario).filter(
                    Usuario.id_usuario == token_valido).first()
            )
            headers = elimimar_cache()
            if rol_usuario in [SUPER_ADMIN, ADMIN]:
                response = template.TemplateResponse(
                    "crud-reuniones/registro_reunion.html",
                    {"request": request, "usuario": usuario},
                )
                response.headers.update(headers)
                return response

            else:
                raise HTTPException(
                    status_code=403,
                    detail="NO TIENES LOS PERMISOS PARA ACCEDER A ESTA PAGINA ",
                )
        else:
            return RedirectResponse("/", status_code=status.HTTP_303_SEE_OTHER)
    else:
        return RedirectResponse("/", status_code=status.HTTP_303_SEE_OTHER)

#  Mostrar Reuniones


@app.get("/reuniones", response_class=HTMLResponse)
def consultarReuniones(
    request: Request, token: str = Cookie(None), db: Session = Depends(get_database)
):
    if token:
        token_valido = verificar_token(token, db)
        if token_valido:
            rol_usuario = get_rol(token_valido, db)
            usuario = (
                db.query(Usuario).filter(
                    Usuario.id_usuario == token_valido).first()
            )
            headers = elimimar_cache()
            if rol_usuario == SUPER_ADMIN:

                empresas = db.query(Empresa).all()
                if empresas:
                    response = template.TemplateResponse(
                        "crud-reuniones/consultar_reunion.html",
                        {
                            "request": request,
                            "empresas": empresas,
                            "usuario": usuario,

                        },
                    )
                    response.headers.update(headers)
                    return response
                else:
                    raise HTTPException(
                        status_code=403, detail="No hay reuniones que consultar"
                    )
            elif rol_usuario == ADMIN:
                id_empresa = get_empresa(token_valido, db)
                reuniones = obtenerReuAdmin(id_empresa, db)
                if reuniones:
                    response = template.TemplateResponse(
                        "crud-reuniones/consultar_reunion.html",
                        {
                            "request": request,
                            "reuniones": reuniones,
                            "usuario": usuario,
                        },
                    )
                    response.headers.update(headers)
                    return response
                else:
                    alerta = {
                        "mensaje": "No hay reuniones en la empresa",
                        "color": "warning",
                    }

                    response = template.TemplateResponse(
                        "crud-reuniones/consultar_reunion.html",
                        {"request": request, "alerta": alerta,
                            "usuario": usuario, "reuniones": None},
                    )
                    response.headers.update(headers)
                    return response
            else:
                raise HTTPException(status_code=403, detail="No puede entrar")
        else:
            return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)
    else:
        return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)

#DATOS DE VARIABLES

@app.post("/obtenerDatosVariablesTecnico")
def procesar_datos(request: Request, id_empresa: int = Form(...), token: str = Cookie(None), db: Session = Depends(get_database)):
    is_token_valid = verificar_token(token, db)
    datosReunion = obtenerVariablesT(db, id_empresa, is_token_valid, request)
    return datosReunion

@app.get("/listaVariables", response_class=HTMLResponse)
def consultarListavariables(
    request: Request, token: str = Cookie(None), db: Session = Depends(get_database)
):
    if token:
        token_valido = verificar_token(token, db)
        if token_valido:
            rol_usuario = get_rol(token_valido, db)
            usuario = (
                db.query(Usuario).filter(
                    Usuario.id_usuario == token_valido).first()
            )
            headers = elimimar_cache()
            if rol_usuario == TECNICO:

                empresas = db.query(Empresa).all()
                if empresas:
                    response = template.TemplateResponse(
                        "otros-archivos/lista_variables.html",
                        {
                            "request": request,
                            "empresas": empresas,
                            "usuario": usuario,

                        },
                    )
                    response.headers.update(headers)
                    return response
                else:
                    raise HTTPException(
                        status_code=403, detail="No hay reuniones que consultar"
                    )
            else:
                raise HTTPException(status_code=403, detail="No puede entrar")
        else:
            return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)
    else:
        return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)

# --- RUTA PARA MOSTRAR LA INFO DE LA REUNION SOBRE UNA EMPRESA


@app.post("/obtenerDatosReunionSuperAdmin")
def procesar_datos(request: Request, id_empresa: int = Form(...), token: str = Cookie(None), db: Session = Depends(get_database)):
    is_token_valid = verificar_token(token, db)
    datosReunion = obtenerDatosReunion(db, id_empresa, is_token_valid, request)
    return datosReunion


def obtenerDatosReunion(
    db: Session,
    id_empresa: int,
    token_valido: str,
    request: Request
):
    if token_valido:
        empresas = db.query(Empresa).all()
        usuario = (
            db.query(Usuario).filter(
                Usuario.id_usuario == token_valido).first()
        )
        headers = elimimar_cache()
        if usuario:
            reuniones = obtenerReuAdmin(id_empresa, db)
            empresa = db.query(Empresa).filter(Empresa.id_empresa == id_empresa).first()
            if reuniones:
                #return {"reuniones": reuniones}
                    
                response = template.TemplateResponse(
                    "crud-reuniones/consultar_reunion.html",
                    {
                        "request": request,
                        "reuniones": reuniones,
                        "empresas": empresas,
                        "usuario": usuario,
                        "empresa":empresa,
                    },
                )
                response.headers.update(headers)
                return response
            else:
                alerta = {
                    "mensaje": "No hay reuniones en la empresa",
                    "color": "warning",
                }

                response = template.TemplateResponse(
                    "crud-reuniones/consultar_reunion.html",
                    {"request": request, "alerta": alerta, "empresas": empresas,
                        "usuario": usuario, "reuniones": None},
                )
                response.headers.update(headers)
                return response
        else:
            return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)
    else:
        return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)

# --- REUNIONES POR FECHA


@app.post("/reunionesFecha", response_class=HTMLResponse)
async def reunionFecha(request: Request, fechaActual: str = Form(...), fechaHasta: str = Form(...), token: str = Cookie(None), db: Session = Depends(get_database),id_empresa : int = Form(None)):
    print(id_empresa)
    if token:
        token_valido = verificar_token(token, db)
        if token_valido:
            usuario = (
                db.query(Usuario).filter(
                    Usuario.id_usuario == token_valido).first()
            )
            reuniones_entre_fechas = None
            if usuario.rol == ADMIN:
                id_empresa = get_empresa(token_valido, db)
                reuniones_entre_fechas = db.query(Reunion).filter(Reunion.fecha.between(
                fechaActual, fechaHasta), Reunion.id_empresa == id_empresa).all()
            elif usuario.rol == SUPER_ADMIN:
                reuniones_entre_fechas = db.query(Reunion).filter(Reunion.fecha.between(
                fechaActual, fechaHasta), Reunion.id_empresa == id_empresa).all()
                

            headers = elimimar_cache()
            print(reuniones_entre_fechas)
            if reuniones_entre_fechas:
                alerta = {
                    "mensaje": "Reuniones encontradas, seleccione la reunion.",
                    "color": "success",
                }
                response = template.TemplateResponse(
                    "crud-reuniones/consultar_reunion.html",
                    {
                        "request": request,
                        "reuniones": reuniones_entre_fechas,
                        "usuario": usuario,
                        "alerta": alerta,
                    },
                )
                response.headers.update(headers)
                return response
            else:
                return RedirectResponse(url="/reuniones", status_code=status.HTTP_303_SEE_OTHER)

# --- RUTA PARA MOSTRAR LA PAGUNA DONDE SE EDITA LA REUNION


@app.post("/EditarReunion/", response_class=HTMLResponse)
def Editar_Reunion(
    request: Request,
    id_reunion: int = Form(...),
    token: str = Cookie(None),
    db: Session = Depends(get_database),
):
    if token:
        token_valido = verificar_token(token, db)
        if token_valido:
            rol_usuario = get_rol(token_valido, db)
            usuario = (
                db.query(Usuario).filter(
                    Usuario.id_usuario == token_valido).first()
            )
            headers = elimimar_cache()
            if rol_usuario == SUPER_ADMIN or rol_usuario == ADMIN:
                reunion = get_datos_reuniones(id_reunion, db)
                response = template.TemplateResponse(
                    "crud-reuniones/editar_reunion.html",
                    {"request": request, "reunion": reunion, "usuario": usuario},
                )
                response.headers.update(headers)
                return response
            else:
                raise HTTPException(status_code=403, detail="No puede entrar")
        else:
            return RedirectResponse("/", status_code=status.HTTP_303_SEE_OTHER)
    else:
        return RedirectResponse("/", status_code=status.HTTP_303_SEE_OTHER)


# --- FUNCION PARA ACTUALIZAR LA REUNION
@app.post("/updateReunion")
def obtenerDatos(
    id_reunion: int = Form(...),
    nom_reunion: str = Form(...),
    fecha: str = Form(...),
    token: str = Cookie(None),
    db: Session = Depends(get_database),
):
    respuesta = updateReunion(
        id_reunion, nom_reunion, fecha, token, db
    )
    if respuesta:
        return RedirectResponse("/reuniones", status_code=status.HTTP_303_SEE_OTHER)
    else:
        return RedirectResponse("/", status_code=status.HTTP_303_SEE_OTHER)


# LLAMADO A LISTA
@app.post("/llamado_lista", response_class=HTMLResponse, tags=["Operaciones Documentos"])
def pagLlamado(
    request: Request, token: str = Cookie(None), db: Session = Depends(get_database), id_reunion: int = Form(None)
):
    if token:
        is_token_valid = verificar_token(token, db)  # retorna el id_usuario

        if is_token_valid:
            rol_usuario = get_rol(is_token_valid, db)
            print(rol_usuario)
            datos_usuario = get_datos_usuario(is_token_valid, db)
            headers = elimimar_cache()
            if rol_usuario == ADMIN:
                suscriptores = obtenerSuscriptoresEmpresa(
                    db, is_token_valid, request, id_reunion)
                return suscriptores
            else:
                alerta = {
                    "mensaje": "No tiene los permisos para esta acción",
                    "color": "warning",
                }
                response = template.TemplateResponse(
                    "index.html",
                    {"request": request, "alerta": alerta, "usuario": datos_usuario},
                )
                response.headers.update(headers)  # Actualiza las cabeceras
                return response
        else:
            return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)
    else:
        return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)


# CALCULAR EL CUORUM
@app.post("/calcularCuorum", response_class=HTMLResponse)
def calcularmCuorum(request: Request, token: str = Cookie(None), db: Session = Depends(get_database), cantidadAsistentes: Optional[int] = Form(None), reunion_1: str = Form("")):
    if cantidadAsistentes is None:
        cantidadAsistentes = 0
    is_token_valid = verificar_token(token, db)
    cuorumCalculado = calcularCuorum(
        db, is_token_valid, request, cantidadAsistentes, reunion_1)
    return cuorumCalculado

@app.post("/listaAsistentes")
async def recibirDatos(request:Request, db: Session = Depends(get_database)):
    datos = await request.json()

    
    id_reunion = datos.get("id_reunion")
    print(id_reunion)

    if "datos" in datos:
        for id_usuario in datos["datos"]:
            insertarDatosReunion(id_usuario,id_reunion,db)
    
            



# VERIFICACION DEL CUORUM


@app.get("/cuorum", response_class=HTMLResponse, tags=["Operaciones Documentos"])
def pagCuorum(
    request: Request, token: str = Cookie(None), db: Session = Depends(get_database)
):
    if token:
        is_token_valid = verificar_token(token, db)  # retorna el id_usuario

        if is_token_valid:
            rol_usuario = get_rol(is_token_valid, db)
            print(rol_usuario)
            datos_usuario = get_datos_usuario(is_token_valid, db)
            headers = elimimar_cache()
            if rol_usuario == SUPER_ADMIN or rol_usuario == ADMIN:
                response = template.TemplateResponse(
                    "paso-1/paso1-2/cuorum.html",
                    {"request": request, "usuario": datos_usuario},
                )
                response.headers.update(headers)  # Actualiza las cabeceras
                return response
            else:
                alerta = {
                    "mensaje": "No tiene los permisos para esta acción",
                    "color": "warning",
                }
                response = template.TemplateResponse(
                    "index.html",
                    {"request": request, "alerta": alerta, "usuario": datos_usuario},
                )
                response.headers.update(headers)  # Actualiza las cabeceras
                return response
        else:
            return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)
    else:
        return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)


# ORDEN DEL DIA
@app.get("/orden_dia", response_class=HTMLResponse, tags=["Operaciones Documentos"])
def pagOrdenDia(
    request: Request, token: str = Cookie(None), db: Session = Depends(get_database)
):
    if token:
        is_token_valid = verificar_token(token, db)  # retorna el id_usuario

        if is_token_valid:
            rol_usuario = get_rol(is_token_valid, db)
            print(rol_usuario)
            datos_usuario = get_datos_usuario(is_token_valid, db)
            headers = elimimar_cache()
            if rol_usuario == SUPER_ADMIN or rol_usuario == ADMIN:
                response = template.TemplateResponse(
                    "paso-1/paso1-2/orden_dia.html",
                    {"request": request, "usuario": datos_usuario},
                )
                response.headers.update(headers)  # Actualiza las cabeceras
                return response
            else:
                alerta = {
                    "mensaje": "No tiene los permisos para esta acción",
                    "color": "warning",
                }
                response = template.TemplateResponse(
                    "index.html",
                    {"request": request, "alerta": alerta, "usuario": datos_usuario},
                )
                response.headers.update(headers)  # Actualiza las cabeceras
                return response
        else:
            return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)
    else:
        return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)


# ELECCION A LA COMISION
@app.get("/eleccion_comision", response_class=HTMLResponse, tags=["Operaciones Documentos"])
def pagEleccion(
    request: Request, token: str = Cookie(None), db: Session = Depends(get_database)
):
    if token:
        is_token_valid = verificar_token(token, db)  # retorna el id_usuario

        if is_token_valid:
            rol_usuario = get_rol(is_token_valid, db)
            print(rol_usuario)
            datos_usuario = get_datos_usuario(is_token_valid, db)
            headers = elimimar_cache()
            if rol_usuario == SUPER_ADMIN or rol_usuario == ADMIN:
                response = template.TemplateResponse(
                    "paso-1/paso1-2/eleccion_comision.html",
                    {"request": request, "usuario": datos_usuario},
                )
                response.headers.update(headers)  # Actualiza las cabeceras
                return response
            else:
                alerta = {
                    "mensaje": "No tiene los permisos para esta acción",
                    "color": "warning",
                }
                response = template.TemplateResponse(
                    "index.html",
                    {"request": request, "alerta": alerta, "usuario": datos_usuario},
                )
                response.headers.update(headers)  # Actualiza las cabeceras
                return response
        else:
            return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)
    else:
        return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)

'''
# APROBACION ESTATUTOS
@app.get("/aprobacion_estatutos", response_class=HTMLResponse, tags=["Operaciones Documentos"])
def pagAprobacion_estatutos(
    request: Request, token: str = Cookie(None), db: Session = Depends(get_database)
):
    if token:
        is_token_valid = verificar_token(token, db)  # retorna el id_usuario

        if is_token_valid:
            rol_usuario = get_rol(is_token_valid, db)
            print(rol_usuario)
            datos_usuario = get_datos_usuario(is_token_valid, db)
            headers = elimimar_cache()
            if rol_usuario == SUPER_ADMIN or rol_usuario == ADMIN:
                response = template.TemplateResponse(
                    "paso-1/paso1-2/aprobacion_estatutos.html",
                    {"request": request, "usuario": datos_usuario},
                )
                response.headers.update(headers)  # Actualiza las cabeceras
                return response
            else:
                alerta = {
                    "mensaje": "No tiene los permisos para esta acción",
                    "color": "warning",
                }
                response = template.TemplateResponse(
                    "index.html",
                    {"request": request, "alerta": alerta, "usuario": datos_usuario},
                )
                response.headers.update(headers)  # Actualiza las cabeceras
                return response
        else:
            return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)
    else:
        return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)

'''

# ELECCION DE LA JUNTA
@app.get("/eleccion_junta_administradora", response_class=HTMLResponse, tags=["Operaciones Documentos"])
def pagEleccion_junta_administradora(
    request: Request, token: str = Cookie(None), db: Session = Depends(get_database)
):
    if token:
        is_token_valid = verificar_token(token, db)  # retorna el id_usuario

        if is_token_valid:
            rol_usuario = get_rol(is_token_valid, db)
            print(rol_usuario)
            datos_usuario = get_datos_usuario(is_token_valid, db)
            headers = elimimar_cache()
            if rol_usuario == SUPER_ADMIN or rol_usuario == ADMIN:
                response = template.TemplateResponse(
                    "paso-1/paso1-2/eleccion_junta_administradora.html",
                    {"request": request, "usuario": datos_usuario},
                )
                response.headers.update(headers)  # Actualiza las cabeceras
                return response
            else:
                alerta = {
                    "mensaje": "No tiene los permisos para esta acción",
                    "color": "warning",
                }
                response = template.TemplateResponse(
                    "index.html",
                    {"request": request, "alerta": alerta, "usuario": datos_usuario},
                )
                response.headers.update(headers)  # Actualiza las cabeceras
                return response
        else:
            return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)
    else:
        return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)


# APROBACION DE LA ACTA


@app.get("/aprobacion_acta_constitucion", response_class=HTMLResponse, tags=["Operaciones Documentos"])
def PagAprobacion_acta_constitucion(
    request: Request, token: str = Cookie(None), db: Session = Depends(get_database)
):
    if token:
        is_token_valid = verificar_token(token, db)  # retorna el id_usuario

        if is_token_valid:
            rol_usuario = get_rol(is_token_valid, db)
            print(rol_usuario)
            datos_usuario = get_datos_usuario(is_token_valid, db)
            headers = elimimar_cache()
            if rol_usuario == SUPER_ADMIN or rol_usuario == ADMIN:
                response = template.TemplateResponse(
                    "paso-1/paso1-2/aprobacion_acta_constitucion.html",
                    {"request": request, "usuario": datos_usuario},
                )
                response.headers.update(headers)  # Actualiza las cabeceras
                return response
            else:
                alerta = {
                    "mensaje": "No tiene los permisos para esta acción",
                    "color": "warning",
                }
                response = template.TemplateResponse(
                    "index.html",
                    {"request": request, "alerta": alerta, "usuario": datos_usuario},
                )
                response.headers.update(headers)  # Actualiza las cabeceras
                return response
        else:
            return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)
    else:
        return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)


# FIN 1.2

@app.get("/generar_documentos", response_class=HTMLResponse)
def PagGenerarDocumentos(
    request: Request, id_empresa: Union[int, None] = None, token: str = Cookie(None), db: Session = Depends(get_database)
):
    if token:
        is_token_valid = verificar_token(token, db)  # retorna el id_usuario

        if is_token_valid:

            rol_usuario = get_rol(is_token_valid, db)
            datos_usuario = get_datos_usuario(is_token_valid, db)
            if id_empresa == None:
                documentos = db.query(Documento).filter(
                    Documento.id_usuario == is_token_valid).all()
            else:
                query = db.query(Documento).join(Usuario).join(Empresa, and_(
                    Usuario.empresa == Empresa.id_empresa, Empresa.id_empresa == id_empresa))
                documentos = query.all()

            arreglo_rutas_pdf = []
            for documento in documentos:
                arreglo_rutas_pdf.append(documento.url)
            print(arreglo_rutas_pdf)
            headers = elimimar_cache()
            if rol_usuario == ADMIN:
                response = template.TemplateResponse(
                    "paso-1/paso1-1/generar_documentos.html",
                    {"request": request, "usuario": datos_usuario,
                        "rutas_pdf": arreglo_rutas_pdf},
                )
                response.headers.update(headers)  # Actualiza las cabeceras
                return response

            elif rol_usuario == SUPER_ADMIN:
                datos_empresas = db.query(Empresa).all()
                response = template.TemplateResponse(
                    "paso-1/paso1-1/generar_documentos.html",
                    {"request": request, "usuario": datos_usuario,
                        "rutas_pdf": arreglo_rutas_pdf, "datos_empresas": datos_empresas},
                )
                response.headers.update(headers)  # Actualiza las cabeceras
                return response
            else:
                alerta = {
                    "mensaje": "No tiene los permisos para esta acción",
                    "color": "warning",
                }
                response = template.TemplateResponse(
                    "index.html",
                    {"request": request, "alerta": alerta, "usuario": datos_usuario},
                )
                response.headers.update(headers)  # Actualiza las cabeceras
                return response
        else:
            return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)
    else:
        return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)


@app.get("/registro_suscriptor", response_class=HTMLResponse, tags=["Operaciones Users"])
def PagRegistro_suscriptor(request: Request):
    headers = elimimar_cache()
    response = template.TemplateResponse(
        "registro_suscriptor.html", {"request": request}
    )
    response.headers.update(headers)
    return response


@app.get("/registro_comision", response_class=HTMLResponse)
def PagRegistro_comiSion(request: Request):
    headers = elimimar_cache()
    response = template.TemplateResponse(
        "registro_comision.html", {"request": request})
    response.headers.update(headers)
    return response


# FUNCIONES PARA LA TAREA DE DIEGO
# CREAR USUARIO
@app.get("/form_super_admin", response_class=HTMLResponse, tags=["Operaciones Users"])
def PagRegistro_comiSion(request: Request):
    headers = elimimar_cache()
    response = template.TemplateResponse(
        "crud-usuarios/addUsuario.html", {"request": request}
    )
    response.headers.update(headers)
    return response


# PARA CREAR SUPER ADMIN
@app.post("/crear_super_admin/", tags=["Operaciones Users"])
def create_super_admin(
    id_usuario: str = Form(...),
    rol: str = Form(...),
    empresa: int = Form(None),
    nom_usuario: str = Form(...),
    apellido_usuario: str = Form(...),
    correo: str = Form(...),
    tipo_doc: str = Form(...),
    num_doc: str = Form(...),
    direccion: str = Form(...),
    municipio: str = Form(...),
    contrasenia: str = Form(...),
    db: Session = Depends(get_database),
):
    respuesta = createSuper_admin(
        id_usuario,
        rol,
        empresa,
        nom_usuario,
        apellido_usuario,
        correo,
        tipo_doc,
        num_doc,
        direccion,
        municipio,
        contrasenia,
        db,
    )
    return respuesta


# INICIAR SESION
@app.post("/iniciarSesion", response_class=RedirectResponse, tags=["Operaciones sesiones"])
async def login(
    request: Request,
    email: Optional[str] = Form(""),
    password: Optional[str] = Form(""),
    db: Session = Depends(get_database),
):
    # SI EL FORMULARIO ESTA VACIO
    if not all([email, password]):
        alerta = {
            "mensaje": "Por favor ingrese los datos.",
            "color": "info",
        }
        return template.TemplateResponse(
            "login.html", {"request": request, "alerta": alerta}
        )
        # return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)

    usuario = db.query(Usuario).filter(Usuario.correo == email).first()
    if usuario is None:
        alerta = {
            "mensaje": "El correo " + email + " es incorrecto.",
            "color": "danger",
        }
        return template.TemplateResponse(
            "login.html", {"request": request, "alerta": alerta}
        )
        # return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)

    # EN CASO QUE EL USUARIO ESTE INACTIVO
    if usuario.estado == "Inactivo":
        alerta = {
            "mensaje": "El usuario " + email + " está inactivo.",
            "color": "warning",
        }
        return template.TemplateResponse(
            "login.html", {"request": request, "alerta": alerta}
        )

    if not bcrypt.checkpw(
        password.encode("utf-8"), usuario.contrasenia.encode("utf-8")
    ):
        alerta = {
            "mensaje": "La contraseña es incorrecta.",
            "color": "danger",
        }
        return template.TemplateResponse(
            "login.html", {"request": request, "alerta": alerta}
        )
        # return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)

    tokenge = generar_token(usuario.id_usuario)
    token = Token(token=tokenge)
    db.add(token)
    db.commit()

    # datos_usuario = get_datos_usuario(usuario.id_usuario, db)
    # Codificar el diccionario en la URL como un parametro
    # encoded_usuario = urllib.parse.urlencode(datos_usuario)

    # Construir la URL con el diccionario de usuario codificado
    redirect_url = f"/index"

    template.TemplateResponse(
        "index.html", {"request": request, "usuario": usuario})
    response = RedirectResponse(
        url=redirect_url, status_code=status.HTTP_303_SEE_OTHER)
    response.set_cookie(key="token", value=tokenge)
    return response


# CERRAR SESION
@app.post("/cerrarSesion", response_class=RedirectResponse, tags=["Operaciones sesiones"])
async def una_ruta(token: str = Cookie(None), db: Session = Depends(get_database)):
    if token:
        deleteToken = db.query(Token).filter(Token.token == token).first()
        if deleteToken:
            db.delete(deleteToken)
            db.commit()
            return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)
        else:
            return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)
    else:
        raise HTTPException(status_code=401, detail="No autorizado")


# GENERAR DOCUMENTOS PERSONALIZADOS
@app.post("/generar_docx/")
def generar_docx(
    request: Request,
    token: str = Cookie(None),
    db: Session = Depends(get_database),
    nit: str = Form(...),
    presidente: str = Form(...),
    patrimonio: str = Form(...),
    municipio: str = Form(...),
    departamento: str = Form(...),
    web: str = Form(...),
    horario: str = Form(...),
    vereda: str = Form(...),
    sigla: str = Form(...),
    fecha: str = Form(...),
    especificaciones: str = Form(...),
    diametro: str = Form(...),
    caudal_permanente: str = Form(...),
    rango_medicion: str = Form(...)
):
    if token:
        is_token_valid = verificar_token(token, db)  # retorna el id_usuario

        if is_token_valid:

            rol_usuario = get_rol(is_token_valid, db)
            print(rol_usuario)
            datos_usuario = get_datos_usuario(is_token_valid, db)
            headers = elimimar_cache()
            
            respuesta = generarDocx(
                request,
                token,
                db,
                nit,
                presidente,
                patrimonio,
                municipio,
                departamento,
                web,
                horario,
                vereda,
                sigla,
                fecha,
                especificaciones,
                diametro,
                caudal_permanente,
                rango_medicion,
            )
            return respuesta
        
        else:
            alerta = {
                "mensaje": "La contraseña es incorrecta.",
                "color": "danger",
            }
            return template.TemplateResponse(
            "generar_documentos.html", {"request": request, "alerta": alerta}
        )
    else:
        alerta = {
            "mensaje": "La contraseña es incorrecta.",
            "color": "danger",
        }
        return template.TemplateResponse(
            "generar_documentos.html", {"request": request, "alerta": alerta}
        )

    


# Otras importaciones necesarias (como SUPER_ADMIN, ADMIN, Usuario, verificar_token, get_rol, get_database, etc.)

# =============================================== BLOQUE PARA LA CREACION DEL USUARIO ===============================================


# --- FUNCION PARA DAR ACCESO AL REGISTRO DEL USUARIO
@app.get("/form_registro_usuario", response_class=HTMLResponse, tags=["Operaciones Users"])
def get_form_usuario(
    request: Request, token: str = Cookie(None), db: Session = Depends(get_database)
):
    respuesta = get_formUsuario(request, token, db)
    return respuesta


# --- FUNCION PARA LA CREACION DE USUARIOS
@app.post("/crearUser")
def create_usuario(
    rol: str = Form(...),
    empresa: int = Form(...),
    nom_usuario: str = Form(...),
    apellido_usuario: str = Form(...),
    correo: str = Form(...),
    tipo_doc: str = Form(...),
    num_doc: str = Form(...),
    direccion: str = Form(...),
    municipio: str = Form(...),
    contrasenia: str = Form(...),
    token: str = Cookie(None),
    db: Session = Depends(get_database),
):
    respuesta = createUsuario(
        rol,
        empresa,
        nom_usuario,
        apellido_usuario,
        correo,
        tipo_doc,
        num_doc,
        direccion,
        municipio,
        contrasenia,
        token,
        db,
    )

    return respuesta

# --- FUNCION PARA VERIFICAR CAMPOS EN LA CREACION DE USUARIOS


# =============================================== FIN DEL BLOQUE DE LA CREACION DEL USUARIO ===============================================


# =============================================== BLOQUE USUARIOS(GENERAL) ===============================================


# --- FUNCION PARA MOSTRAR TODOS LOS USUARIOS(GENERAL)
@app.post("/usuarios", response_class=HTMLResponse, tags=["Operaciones Users"])
def consultarUsuario(
    request: Request, token: str = Cookie(None), db: Session = Depends(get_database), id_empresa: str = Form(None)
):
    respuesta = consultarUsuarios(request, token, db, id_empresa)
    return respuesta


@app.post("/obtenerUsuariosEm", response_class=HTMLResponse, tags=["Operaciones Users"])
def obtenerUsuariosEmpresa(
    request: Request, token: str = Cookie(None), db: Session = Depends(get_database), id_empresa: str = Form(None)
):
    respuesta = consultarUsuarios(request, token, db)
    return respuesta


# --- FUNCION PARA MOSTRAR LA PAGINA DONDE SE EDITA EL USUARIO(GENERAL)


@app.post("/EditarUsuarios/", response_class=HTMLResponse, tags=["Operaciones Users"])
def Editar_Usuarios(
    request: Request,
    id_usuario: str = Form(...),
    token: str = Cookie(None),
    db: Session = Depends(get_database),
    id_empresa: str = Form(None)
):
    respuesta = EditarUsuarios(request, id_usuario, token, db, id_empresa)
    return respuesta


# --- FUNCION PARA ACTUALIZAR EL USUARIO(GENERAL)


@app.post("/updateUser/", tags=["Operaciones Users"], response_class=HTMLResponse)
def updateUser(
    id_usuario: str = Form(...),
    nom_usuario: str = Form(...),
    apellido_usuario: str = Form(...),
    tipo_doc: str = Form(...),
    num_doc: str = Form(...),
    correo: str = Form(...),
    municipio: str = Form(...),
    direccion: str = Form(...),
    estado: str = Form(...),
    token: str = Cookie(None),
    db: Session = Depends(get_database),
):
    respuesta = actualizarUsuario(
        id_usuario,
        nom_usuario,
        apellido_usuario,
        tipo_doc,
        num_doc,
        correo,
        municipio,
        direccion,
        estado,
        token,
        db,
    )
    return respuesta


# ---FUNCION PARA CAMBIAR EL ESTADO DEL USUARIO EN EL TABLA
@app.post("/CambiarEstadoUsuario/{id_usuario}", tags=["Operaciones Users"])
def cambiar_estado_usuario(
    id_usuario: str, token: str = Cookie(None), db: Session = Depends(get_database)
):
    respuesta = cambiarEstadoUsuario(id_usuario, token, db)
    return respuesta


# =============================================== FIN BLOQUE USUARIOS(GENERAL) ===============================================


# ============================================ BLOQUE PARA EL PERFIL DEL USUARIO(PERSONAL) ============================================


# --- MOSTRAMOS PAGINA CON EL ACCESO AL PERFIL DEL USUARIO(PERSONAL)
@app.get("/perfil_usuario", response_class=HTMLResponse, tags=["Operaciones Users"])
def get_perfil_usuario(
    request: Request, token: str = Cookie(None), db: Session = Depends(get_database)
):
    respuesta = getPerfilUsuario(request, token, db)
    return respuesta


# --- RUTA PARA QUE EL USUARIO PUEDA VER SU INFORMACION PERSONAL DESDE EL PERFIL


@app.post("/EditarUsuario/", response_class=HTMLResponse, tags=["Operaciones Users"])
def Editar_Usuario(
    request: Request,
    id_usuario: str = Form(...),
    token: str = Cookie(None),
    db: Session = Depends(get_database),
):
    respuesta = EditarUsuarioPerfil(request, id_usuario, token, db)
    return respuesta


# --- FUNCI0N PARA ACTUALIZAR LOS DATOS DEL PERFIL (PERSONAL):


@app.post("/actualizarPerfil", tags=["Operaciones Users"])
def actualizar_perfil(
    nom_usuario: str = Form(...),
    apellido_usuario: str = Form(...),
    tipo_doc: str = Form(...),
    num_doc: str = Form(...),
    email: str = Form(...),
    direccion: str = Form(...),
    token: str = Cookie(None),
    db: Session = Depends(get_database),
):
    respuesta = actualizarPerfil(
        nom_usuario, apellido_usuario, tipo_doc, num_doc, email, direccion, token, db
    )
    return respuesta


# ============================================ FIN DE BLOQUE DEL PERFIL DEL USUARIO(PERSONAL) ============================================


# ============================================= BLOQUE PARA CREACION DE EMPRESA =============================================


# --- MOSTRAMOS LA PAGINA PARA REGISTRAR UNA EMPRESA
@app.get("/registro_empresa", response_class=HTMLResponse, tags=["Operaciones Empresas"])
def MostrarRegistroEmpresa(
    request: Request, token: str = Cookie(None), db: Session = Depends(get_database)
):
    if token:
        token_valido = verificar_token(token, db)
        if token_valido:
            rol_usuario = get_rol(token_valido, db)
            usuario = (
                db.query(Usuario).filter(
                    Usuario.id_usuario == token_valido).first()
            )
            headers = elimimar_cache()
            if rol_usuario in [SUPER_ADMIN, ADMIN]:
                response = template.TemplateResponse(
                    "crud-empresas/registro_empresa.html",
                    {"request": request, "usuario": usuario},
                )
                response.headers.update(headers)
                return response

            else:
                raise HTTPException(
                    status_code=403,
                    detail="NO TIENES LOS PERMISOS PARA ACCEDER A ESTA PAGINA ",
                )
        else:
            return RedirectResponse("/", status_code=status.HTTP_303_SEE_OTHER)
    else:
        return RedirectResponse("/", status_code=status.HTTP_303_SEE_OTHER)


@app.post("/registrarEmpresa", tags=["Operaciones Empresas"])
def crearEmpresa(
    nom_empresa: str = Form(...),
    direccion_empresa: str = Form(...),
    tel_fijo: str = Form(...),
    tel_cel: str = Form(...),
    email: str = Form(...),
    token: str = Cookie(None),
    db: Session = Depends(get_database),
):
    respuesta = insertarEmpresa(
        nom_empresa, direccion_empresa, tel_fijo, tel_cel, email, token, db
    )
    return respuesta


# ============================================= FIN DE BLOQUE DE CREACION DE EMPRESA =============================================


# =============================================- BLOQUE PARA ACTUALIZAR EMPRESAS =============================================-


# --- FUNCION PARA MOSTRAR TODAS LA EMPRESAS
@app.get("/empresas/{page}", response_class=HTMLResponse, tags=["Operaciones Empresas"])
def consultarEmpresa(request: Request, page: int, token: str = Cookie(None), db: Session = Depends(get_database)):

    if token:
        token_valido = verificar_token(token, db)
        if token_valido:
            rol_usuario = get_rol(token_valido, db)
            usuario = (
                db.query(Usuario).filter(
                    Usuario.id_usuario == token_valido).first()
            )
            headers = elimimar_cache()
            if rol_usuario in [SUPER_ADMIN, ADMIN]:
                items_per_page = 20
                offset = (page - 1) * items_per_page
                query_empresas = db.query(Empresa).offset(
                    offset).limit(items_per_page).all()
                total_empresas = db.query(Empresa).count()
                total_pages = (total_empresas // items_per_page) + \
                    (1 if total_empresas % items_per_page > 0 else 0)
                if query_empresas:
                    response = template.TemplateResponse(
                        "crud-empresas/consultar_empresa.html",
                        {
                            "request": request,
                            "empresa": query_empresas,
                            "usuario": usuario,
                            "page": page,
                            "total_pages": total_pages
                        },
                    )
                    response.headers.update(headers)
                    return response
                else:
                    raise HTTPException(
                        status_code=403, detail="No hay empresas que consultar"
                    )
            else:
                raise HTTPException(status_code=403, detail="No puede entrar")
        else:
            return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)
    else:
        return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)


# --- FUNCION PARA CAMBIAR EL ESTADO DE LA EMPRESA
@app.post("/CambiarEstadoEmpresa/{id_empresa}", tags=["Operaciones Empresas"])
def cambiar_estado_empresa(
    id_empresa: int, token: str = Cookie(None), db: Session = Depends(get_database)
):
    respuesta = cambiarEstadoEmpresa(id_empresa, token, db)
    return respuesta


# --- RUTA PARA MOSTRAR LA PAGUNA DONDE SE EDITA LA EMPRESA
@app.post("/EditarEmpresa/", response_class=HTMLResponse, tags=["Operaciones Empresas"])
def Editar_Empresas(
    request: Request,
    id_empresa: int = Form(...),
    token: str = Cookie(None),
    db: Session = Depends(get_database),
):
    if token:
        token_valido = verificar_token(token, db)
        if token_valido:
            rol_usuario = get_rol(token_valido, db)
            usuario = (
                db.query(Usuario).filter(
                    Usuario.id_usuario == token_valido).first()
            )
            headers = elimimar_cache()
            if rol_usuario == SUPER_ADMIN or rol_usuario == ADMIN:
                empresa = get_datos_empresa(id_empresa, db)
                response = template.TemplateResponse(
                    "crud-empresas/EditarEmpresa.html",
                    {"request": request, "empresa": empresa, "usuario": usuario},
                )
                response.headers.update(headers)
                return response
            else:
                raise HTTPException(status_code=403, detail="No puede entrar")
        else:
            return RedirectResponse("/", status_code=status.HTTP_303_SEE_OTHER)
    else:
        return RedirectResponse("/", status_code=status.HTTP_303_SEE_OTHER)

# --- FUNCION PARA ACTUALIZAR LA EMPRESA


@app.post("/updateEmpresa", tags=["Operaciones Empresas"])
def updateEmpresa(

    id_empresa: int = Form(...),
    nom_empresa: str = Form(...),
    tel_fijo: str = Form(...),
    tel_cel: str = Form(...),
    email: str = Form(...),
    estado: str = Form(...),
    token: str = Cookie(None),
    db: Session = Depends(get_database),
):

    if not nom_empresa:
        raise HTTPException(status_code=400, detail="El nombre es requerido")

    if not tel_fijo:
        raise HTTPException(
            status_code=400, detail="El telefono fijo es requerido")

    if not tel_cel:
        raise HTTPException(
            status_code=400, detail="El telefono celular es requerido")

    if not email:
        raise HTTPException(status_code=400, detail="El correo es requerido")

    if not nom_empresa or not tel_fijo or not tel_cel or not email:
        raise HTTPException(
            status_code=400, detail="Todos los campos son requeridos")

    if token:
        token_valido = verificar_token(token, db)
        if token_valido:
            rol_usuario = get_rol(token_valido, db)

            if rol_usuario in [SUPER_ADMIN, ADMIN]:
                update_empresa = db.query(Empresa).filter_by(
                    id_empresa=id_empresa).first()

                if update_empresa:
                    update_empresa.nom_empresa = nom_empresa
                    update_empresa.tel_fijo = tel_fijo
                    update_empresa.tel_cel = tel_cel
                    update_empresa.email = email
                    update_empresa.estado = estado
                    db.commit()
                    return RedirectResponse(url="/empresas/1", status_code=status.HTTP_303_SEE_OTHER)
                else:
                    raise HTTPException(
                        status_code=404, detail="Empresa no encontrada")
            else:
                raise HTTPException(
                    status_code=403, detail="No tienes permisos para actualizar empresas")
        else:
            return RedirectResponse("/", status_code=status.HTTP_303_SEE_OTHER)
    else:
        return RedirectResponse("/", status_code=status.HTTP_303_SEE_OTHER)

# ============================================= FIN DE BLOQUE PARA ACTUALIZAR EMPRESA =============================================


@app.post("/registrarVivienda", tags=["Operaciones Viviendas"], response_class=HTMLResponse)
def crearVivienda(
    request: Request,
    id_usuario: str = Form(...),
    drcVivienda: str = Form(...),
    estrato: int = Form(...),
    tipoVivienda: str = Form(...),
    numPersonas: int = Form(...),
    token: str = Cookie(None),
    db: Session = Depends(get_database),
):
    if token:
        token_valido = verificar_token(token, db)
    if token_valido:
        rol_usuario = get_rol(token_valido, db)
        if rol_usuario in [SUPER_ADMIN, ADMIN]:

            vivienda_db = Vivienda(
                id_usuario=id_usuario,
                direccion=drcVivienda,
                estrato=estrato,
                uso=tipoVivienda,
                numero_residentes=numPersonas
            )
            usuario = db.query(Usuario).filter(
                Usuario.id_usuario == token_valido).first()
            user = get_datos_usuario(id_usuario, db)

            try:
                db.add(vivienda_db)
                db.commit()
                db.refresh(vivienda_db)
                alerta = {
                    "mensaje": "Vivienda creada exitosamente",
                    "color": "success",
                }
                viviendas = get_viviendas(id_usuario, db)
                return template.TemplateResponse("crud-usuarios/EditarUsuario.html", {"request": request, "user": user, "usuario": usuario, "viviendas": viviendas, "alerta": alerta})
            except Exception as e:
                db.rollback()
                alerta = {
                    "mensaje": "Error al registrar la vivienda",
                    "color": "error",
                }
                return template.TemplateResponse("crud-usuarios/EditarUsuario.html", {"request": request, "user": user, "usuario": usuario, "viviendas": viviendas, "alerta": alerta})
        else:
            raise HTTPException(
                status_code=403, detail="nada")
    else:
        return RedirectResponse("/", status_code=status.HTTP_303_SEE_OTHER)

# --- FUNCION PARA Desactivar vivienda del usuario


@app.post("/deleteVivienda", tags=["Operaciones Viviendas"], response_class=HTMLResponse)
def desactivarVivienda(
    request: Request,
    id_vivienda: int = Form(...),
    id_usuario: str = Form(...),
    token: str = Cookie(None),
    db: Session = Depends(get_database),
):

    if token:
        token_valido = verificar_token(token, db)
    if token_valido:
        rol_usuario = get_rol(token_valido, db)

        if rol_usuario in [SUPER_ADMIN, ADMIN]:
            vivienda = db.query(Vivienda).filter(
                Vivienda.id_inmueble == id_vivienda).first()
            usuario = db.query(Usuario).filter(
                Usuario.id_usuario == token_valido).first()
            user = get_datos_usuario(id_usuario, db)
            if vivienda:
                vivienda.id_usuario = None
                vivienda.numero_residentes = 0
                db.commit()
                viviendas = get_viviendas(id_usuario, db)
                alerta = {
                    "mensaje": "Vivienda desactivada exitosamente",
                    "color": "success",
                }
                return template.TemplateResponse("crud-usuarios/EditarUsuario.html", {"request": request, "user": user, "usuario": usuario, "viviendas": viviendas, "alerta": alerta})
            else:
                alerta = {
                    "mensaje": "Vivienda no encontrada",
                    "color": "error",
                }
                return template.TemplateResponse("crud-usuarios/EditarUsuario.html", {"request": request, "user": user, "usuario": usuario, "viviendas": viviendas, "alerta": alerta})
        else:
            raise HTTPException(
                status_code=403, detail="nada")
    else:
        return RedirectResponse("/", status_code=status.HTTP_303_SEE_OTHER)

# --- FUNCION PARA ACTUALIZAR LA VIVIENDA


@app.post("/updateVivienda", tags=["Operaciones Viviendas"], response_class=HTMLResponse)
def updateVivienda(
    request: Request,
    id_vivienda: int = Form(...),
    id_usuario: str = Form(...),
    drcViviendaEdit: str = Form(...),
    estratoEdit: int = Form(...),
    tipoViviendaEdit: str = Form(...),
    numPersonasEdit: int = Form(...),
    token: str = Cookie(None),
    db: Session = Depends(get_database),
):
    if token:
        token_valido = verificar_token(token, db)
    if token_valido:
        rol_usuario = get_rol(token_valido, db)

        if rol_usuario in [SUPER_ADMIN, ADMIN]:
            vivienda = db.query(Vivienda).filter(
                Vivienda.id_inmueble == id_vivienda).first()
            usuario = db.query(Usuario).filter(
                Usuario.id_usuario == token_valido).first()
            user = get_datos_usuario(id_usuario, db)
            if vivienda:
                vivienda.direccion = drcViviendaEdit
                vivienda.estrato = estratoEdit
                vivienda.uso = tipoViviendaEdit
                vivienda.numero_residentes = numPersonasEdit
                db.commit()
                viviendas = get_viviendas(id_usuario, db)
                alerta = {
                    "mensaje": "Vivienda actualizada exitosamente",
                    "color": "success",
                }
                return template.TemplateResponse("crud-usuarios/EditarUsuario.html", {"request": request, "user": user, "usuario": usuario, "viviendas": viviendas, "alerta": alerta})
            else:
                alerta = {
                    "mensaje": "Vivienda no encontrada",
                    "color": "error",
                }
                return template.TemplateResponse("crud-usuarios/EditarUsuario.html", {"request": request, "user": user, "usuario": usuario, "viviendas": viviendas, "alerta": alerta})
        else:
            raise HTTPException(
                status_code=403, detail="nada")
    else:
        return RedirectResponse("/", status_code=status.HTTP_303_SEE_OTHER)


# --- FUNCION PARA MOSTRAR TODAS LAS VIVIENDAS SIN USUARIO


@app.get("/viviendas/{alter}", response_class=HTMLResponse, tags=["Operaciones Viviendas"])
def consultarVivienda(request: Request, alter: int, token: str = Cookie(None), db: Session = Depends(get_database)):
    if token:
        token_valido = verificar_token(token, db)
        if token_valido:
            rol_usuario = get_rol(token_valido, db)
            usuario = db.query(Usuario).filter(
                Usuario.id_usuario == token_valido).first()
            if rol_usuario in [SUPER_ADMIN, ADMIN]:
                if alter == 1:
                    query_viviendas = db.query(Vivienda).filter(
                        Vivienda.id_usuario == None)
                    if query_viviendas:
                        return template.TemplateResponse("crud-viviendas/consultar_viviendas.html", {"request": request, "viviendas": query_viviendas, "usuario": usuario, "alter": alter})
                    else:
                        raise HTTPException(
                            status_code=403, detail="No hay viviendas que consultar")
                elif alter == 2:
                    query_viviendas = db.query(Vivienda).filter(
                        Vivienda.id_usuario != None)
                    if query_viviendas:
                        return template.TemplateResponse("crud-viviendas/consultar_viviendas.html", {"request": request, "viviendas": query_viviendas, "usuario": usuario, "alter": alter})
                    else:
                        raise HTTPException(
                            status_code=403, detail="No hay viviendas que consultar")
            else:
                raise HTTPException(
                    status_code=403, detail="Ud no cuenta con permisos para entrar a esta pagina")
        else:
            return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)
    else:
        return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)


# --- FUNCION PARA MOSTRAR LA PAGINA DONDE SE EDITA LA VIVIENDA


@app.post("/EditarVivienda", response_class=HTMLResponse, tags=["Operaciones Viviendas"])
def Editar_Viviendas(
    request: Request,
    id_vivienda: int = Form(...),
    token: str = Cookie(None),
    db: Session = Depends(get_database),
):
    if token:
        token_valido = verificar_token(token, db)
        if token_valido:
            rol_usuario = get_rol(token_valido, db)
            usuario = db.query(Usuario).filter(
                Usuario.id_usuario == token_valido).first()
            users = db.query(Usuario)
            if rol_usuario in [SUPER_ADMIN, ADMIN]:
                vivienda = get_datos_vivienda(id_vivienda, db)
                return template.TemplateResponse("crud-viviendas/EditarVivienda.html", {"request": request, "vivienda": vivienda, "usuario": usuario, "users": users})
            else:
                raise HTTPException(status_code=403, detail="No puede entrar")
        else:
            return RedirectResponse("/", status_code=status.HTTP_303_SEE_OTHER)
    else:
        return RedirectResponse("/", status_code=status.HTTP_303_SEE_OTHER)


# --- FUNCION PARA EDITAR LA VIVIENDA SIN USUARIO

@app.post("/updateViviendaNoOwner", tags=["Operaciones Viviendas"])
def updateViviendaNoOwner(
    request: Request,
    id_vivienda: int = Form(...),
    id_usuario: str = Form(default=None),
    drcViviendaEdit: str = Form(...),
    estratoEdit: int = Form(...),
    tipoViviendaEdit: str = Form(...),
    numPersonasEdit: int = Form(...),
    token: str = Cookie(None),
    db: Session = Depends(get_database),
):
    if token:
        token_valido = verificar_token(token, db)
    if token_valido:
        rol_usuario = get_rol(token_valido, db)

        if rol_usuario in [SUPER_ADMIN, ADMIN]:
            vivienda = db.query(Vivienda).filter(
                Vivienda.id_inmueble == id_vivienda).first()
            usuario = db.query(Usuario).filter(
                Usuario.id_usuario == token_valido).first()
            if vivienda:
                if id_usuario is None:
                    pass
                else:
                    vivienda.id_usuario = id_usuario
                vivienda.direccion = drcViviendaEdit
                vivienda.estrato = estratoEdit
                vivienda.uso = tipoViviendaEdit
                vivienda.numero_residentes = numPersonasEdit
                db.commit()
                query_viviendas = db.query(Vivienda).filter(
                    Vivienda.id_usuario == None)
                alerta = {
                    "mensaje": "Vivienda actualizada exitosamente",
                    "color": "success",
                }
                return template.TemplateResponse("crud-viviendas/consultar_viviendas.html", {"request": request, "usuario": usuario, "viviendas": query_viviendas, "alerta": alerta})
            else:
                alerta = {
                    "mensaje": "Vivienda no encontrada",
                    "color": "error",
                }
                return template.TemplateResponse("crud-viviendas/consultar_viviendas.html", {"request": request, "usuario": usuario, "viviendas": query_viviendas, "alerta": alerta})
        else:
            raise HTTPException(
                status_code=403, detail="nada")
    else:
        return RedirectResponse("/", status_code=status.HTTP_303_SEE_OTHER)


# --- FUNCION PARA ELIMINAR LA VIVIENDA SIN USUARIO


@app.post("/deleteViviendaNoOwner", tags=["Operaciones Viviendas"], response_class=HTMLResponse)
def eliminarViviendaNoOwner(
    request: Request,
    id_vivienda: int = Form(...),
    token: str = Cookie(None),
    db: Session = Depends(get_database),
):
    if token:
        token_valido = verificar_token(token, db)
    if token_valido:
        rol_usuario = get_rol(token_valido, db)

        if rol_usuario in [SUPER_ADMIN, ADMIN]:
            vivienda = db.query(Vivienda).filter(
                Vivienda.id_inmueble == id_vivienda).first()
            usuario = db.query(Usuario).filter(
                Usuario.id_usuario == token_valido).first()
            if vivienda:
                db.delete(vivienda)
                db.commit()
                query_viviendas = db.query(Vivienda).filter(
                    Vivienda.id_usuario == None)
                alerta = {
                    "mensaje": "Vivienda eliminada exitosamente",
                    "color": "success",
                }
                return template.TemplateResponse("crud-viviendas/consultar_viviendas.html", {"request": request, "usuario": usuario, "viviendas": query_viviendas, "alerta": alerta})
            else:
                alerta = {
                    "mensaje": "Vivienda no encontrada",
                    "color": "error",
                }
                return template.TemplateResponse("crud-viviendas/consultar_viviendas.html", {"request": request, "usuario": usuario, "viviendas": query_viviendas, "alerta": alerta})
        else:
            raise HTTPException(
                status_code=403, detail="nada")
    else:
        return RedirectResponse("/", status_code=status.HTTP_303_SEE_OTHER)


@app.post("/desvincularVivienda", tags=["Operaciones Viviendas"], response_class=HTMLResponse)
def desvincularVivienda(
    request: Request,
    id_vivienda: int = Form(...),
    token: str = Cookie(None),
    db: Session = Depends(get_database),
):
    if token:
        token_valido = verificar_token(token, db)
    if token_valido:
        rol_usuario = get_rol(token_valido, db)

        if rol_usuario in [SUPER_ADMIN, ADMIN]:
            vivienda = db.query(Vivienda).filter(
                Vivienda.id_inmueble == id_vivienda).first()
            usuario = db.query(Usuario).filter(
                Usuario.id_usuario == token_valido).first()
            if vivienda:
                vivienda.id_usuario = None
                vivienda.numero_residentes = 0
                db.commit()
                query_viviendas = db.query(Vivienda).filter(
                    Vivienda.id_usuario != None)
                viviendas_con_usuario = query_viviendas.all()
                alerta = {
                    "mensaje": "Vivienda desvinculada exitosamente",
                    "color": "success",
                }
                return template.TemplateResponse("crud-viviendas/consultarViviendasVinculadas.html", {"request": request, "usuario": usuario, "viviendas": viviendas_con_usuario, "alerta": alerta})
            else:
                alerta = {
                    "mensaje": "Vivienda no encontrada",
                    "color": "error",
                }
                return template.TemplateResponse("crud-viviendas/consultarViviendasVinculadas.html", {"request": request, "usuario": usuario, "viviendas": viviendas_con_usuario, "alerta": alerta})
        else:
            raise HTTPException(
                status_code=403, detail="nada")
    else:
        return RedirectResponse("/", status_code=status.HTTP_303_SEE_OTHER)



@app.post("/entrada_variables", response_class=RedirectResponse)
def ver_formulario(
    request: Request, token: str = Cookie(None), db: Session = Depends(get_database),id_empresa:int = Form(...)
):
    print(id_empresa)
    if token:
        is_valid = verificar_token(token, db)
        if is_valid:
            usuario = db.query(Usuario).filter(
                Usuario.id_usuario == is_valid).first()

            rol_usuario = get_rol(is_valid, db)
            if rol_usuario == TECNICO:
                headers = elimimar_cache()
                preguntas = preguntasId(db,id_empresa)
                if not preguntas:
                    preguntas = [0]
                else:
                    preguntas = [item[0] for item in preguntas]
                response = template.TemplateResponse(
                    "paso-3/paso-3-2/paso-3.html", {"request": request, "usuario": usuario,"id_empresa":id_empresa,"preguntas":preguntas}
                )
                response.headers.update(headers)  # Actualiza las cabeceras
                return response
            else:
                return RedirectResponse("/index", status_code=status.HTTP_303_SEE_OTHER)
        else:
            return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)

    return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)

@app.post("/diseño_acueducto")
async def datosDiseñoAcueducto(request:Request, db: Session = Depends(get_database), ):
        datos = await request.json()
        id_empresa = datos.get("id_empresa")
        lista_respuestas = datos.get("lista_respuestas")
        lista_variables = datos.get("lista_variables")
        if lista_respuestas and lista_variables:
            for respuesta, variable in zip(lista_respuestas, lista_variables):
                status = registrarVariables(db,id_empresa, variable, respuesta)
        
        if status:
            return {"status":True,"msg":"Variables registradas con exito"}
        else:
            return {"status":False,"msg":"No se pudo registrar la variable"}
       

