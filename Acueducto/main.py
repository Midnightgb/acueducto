from fastapi import HTTPException, Depends, Cookie, Response
from fastapi.responses import JSONResponse
from fastapi import HTTPException
from typing import Optional
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
from sqlalchemy.orm import Session
from funciones import *
from models import Empresa, Servicio, Usuario, Token, Vivienda
import bcrypt
from str_aleatorio import generar_random_id
from database import get_database
import urllib.parse

SUPER_ADMIN = "SuperAdmin"
ADMIN = "Admin"
ESTADO = "Activo"
datos_usuario = None

app = FastAPI()

# Agregando los archivos estaticos que están en la carpeta dist del proyecto
app.mount("/static", StaticFiles(directory="public/dist"), name="static")

template = Jinja2Templates(directory="public/templates")


@app.get("/", response_class=HTMLResponse, tags=["Login"])
def login(request: Request):
    return template.TemplateResponse("login.html", {"request": request})


@app.get("/index", response_class=RedirectResponse, tags=["Operacion Index"])
def inicio(
    request: Request, token: str = Cookie(None), db: Session = Depends(get_database)
):
    if token:
        is_valid = verificar_token(token, db)
        if is_valid:
            usuario = db.query(Usuario).filter(
                Usuario.id_usuario == is_valid).first()
            return template.TemplateResponse(
                "index.html", {"request": request, "usuario": usuario}
            )
        else:
            return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)
    else:
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
            if rol_usuario == SUPER_ADMIN or rol_usuario == ADMIN:
                datos_usuario = get_datos_usuario(is_token_valid, db)
                return template.TemplateResponse(
                    "censo.html", {"request": request,
                                   "usuario": datos_usuario}
                )
            else:
                alerta = {
                    "mensaje": "No tiene los permisos para esta acción",
                    "color": "warning",
                }
                return template.TemplateResponse(
                    "index.html", {"request": request, "alerta": alerta}
                )
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
            if rol_usuario == SUPER_ADMIN or rol_usuario == ADMIN:
                datos_usuario = get_datos_usuario(is_token_valid, db)
                return template.TemplateResponse(
                    "conceptos_basicos.html", {
                        "request": request, "usuario": datos_usuario}
                )
            else:
                alerta = {
                    "mensaje": "No tiene los permisos para esta acción",
                    "color": "warning",
                }
                return template.TemplateResponse(
                    "index.html", {"request": request, "alerta": alerta}
                )
        else:
            return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)
    else:
        return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)


# ESTATUTOS
@app.get("/estatutos", response_class=HTMLResponse, tags=["Operaciones Documentos"])
def pagEstatutos(
    request: Request, token: str = Cookie(None), db: Session = Depends(get_database)
):
    if token:
        is_token_valid = verificar_token(token, db)  # retorna el id_usuario

        if is_token_valid:
            rol_usuario = get_rol(is_token_valid, db)
            print(rol_usuario)
            if rol_usuario == SUPER_ADMIN or rol_usuario == ADMIN:
                datos_usuario = get_datos_usuario(is_token_valid, db)
                return template.TemplateResponse(
                    "estatutos.html", {"request": request,
                                       "usuario": datos_usuario}
                )
            else:
                alerta = {
                    "mensaje": "No tiene los permisos para esta acción",
                    "color": "warning",
                }
                return template.TemplateResponse(
                    "index.html", {"request": request, "alerta": alerta}
                )
        else:
            return RedirectResponse("/", status_code=status.HTTP_303_SEE_OTHER)
    else:
        return RedirectResponse("/", status_code=status.HTTP_303_SEE_OTHER)


# CONTRATO DE CONDICIONES UNIFORME
@app.get("/contrato_condiciones", response_class=HTMLResponse, tags=["Operaciones Documentos"])
def pagContrato_de_condiciones_uniformes(
    request: Request, token: str = Cookie(None), db: Session = Depends(get_database)
):
    if token:
        is_token_valid = verificar_token(token, db)  # retorna el id_usuario

        if is_token_valid:
            rol_usuario = get_rol(is_token_valid, db)
            print(rol_usuario)
            if rol_usuario == SUPER_ADMIN or rol_usuario == ADMIN:
                datos_usuario = get_datos_usuario(is_token_valid, db)
                return template.TemplateResponse(
                    "contrato_condiciones.html", {
                        "request": request, "usuario": datos_usuario}
                )
            else:
                alerta = {
                    "mensaje": "No tiene los permisos para esta acción",
                    "color": "warning",
                }
                return template.TemplateResponse(
                    "index.html", {"request": request, "alerta": alerta}
                )
        else:
            return RedirectResponse("/", status_code=status.HTTP_303_SEE_OTHER)
    else:
        return RedirectResponse("/", status_code=status.HTTP_303_SEE_OTHER)


# INVITACION A LA ASAMBLEA
@app.get("/invitacion_asamblea", response_class=HTMLResponse, tags=["Operaciones Documentos"])
def pagInvitacion_a_la_asamblea(
    request: Request, token: str = Cookie(None), db: Session = Depends(get_database)
):
    if token:
        is_token_valid = verificar_token(token, db)  # retorna el id_usuario

        if is_token_valid:
            rol_usuario = get_rol(is_token_valid, db)
            print(rol_usuario)
            if rol_usuario == SUPER_ADMIN or rol_usuario == ADMIN:
                datos_usuario = get_datos_usuario(is_token_valid, db)
                return template.TemplateResponse(
                    "invitacion_asamblea.html", {
                        "request": request, "usuario": datos_usuario}
                )
            else:
                alerta = {
                    "mensaje": "No tiene los permisos para esta acción",
                    "color": "warning",
                }
                return template.TemplateResponse(
                    "index.html", {"request": request, "alerta": alerta}
                )
        else:
            return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)
    else:
        return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)


# FIN 1.1


# -- 1.2 --


# LLAMADO A LISTA
@app.get("/llamado_lista", response_class=HTMLResponse, tags=["Operaciones Documentos"])
def pagLlamado(
    request: Request, token: str = Cookie(None), db: Session = Depends(get_database)
):
    if token:
        is_token_valid = verificar_token(token, db)  # retorna el id_usuario

        if is_token_valid:
            rol_usuario = get_rol(is_token_valid, db)
            print(rol_usuario)
            if rol_usuario == SUPER_ADMIN or rol_usuario == ADMIN:
                datos_usuario = get_datos_usuario(is_token_valid, db)
                return template.TemplateResponse(
                    "llamado_lista.html", {
                        "request": request, "usuario": datos_usuario}
                )
            else:
                alerta = {
                    "mensaje": "No tiene los permisos para esta acción",
                    "color": "warning",
                }
                return template.TemplateResponse(
                    "index.html", {"request": request, "alerta": alerta}
                )
        else:
            return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)
    else:
        return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)


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
            if rol_usuario == SUPER_ADMIN or rol_usuario == ADMIN:
                datos_usuario = get_datos_usuario(is_token_valid, db)
                return template.TemplateResponse(
                    "cuorum.html", {"request": request,
                                    "usuario": datos_usuario}
                )
            else:
                alerta = {
                    "mensaje": "No tiene los permisos para esta acción",
                    "color": "warning",
                }
                return template.TemplateResponse(
                    "index.html", {"request": request, "alerta": alerta}
                )
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
            if rol_usuario == SUPER_ADMIN or rol_usuario == ADMIN:
                datos_usuario = get_datos_usuario(is_token_valid, db)
                return template.TemplateResponse(
                    "orden_dia.html", {"request": request,
                                       "usuario": datos_usuario}
                )
            else:
                alerta = {
                    "mensaje": "No tiene los permisos para esta acción",
                    "color": "warning",
                }
                return template.TemplateResponse(
                    "index.html", {"request": request, "alerta": alerta}
                )
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
            if rol_usuario == SUPER_ADMIN or rol_usuario == ADMIN:
                datos_usuario = get_datos_usuario(is_token_valid, db)
                return template.TemplateResponse(
                    "eleccion_comision.html", {
                        "request": request, "usuario": datos_usuario}
                )
            else:
                alerta = {
                    "mensaje": "No tiene los permisos para esta acción",
                    "color": "warning",
                }
                return template.TemplateResponse(
                    "index.html", {"request": request, "alerta": alerta}
                )
        else:
            return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)
    else:
        return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)


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
            if rol_usuario == SUPER_ADMIN or rol_usuario == ADMIN:
                datos_usuario = get_datos_usuario(is_token_valid, db)
                return template.TemplateResponse(
                    "aprobacion_estatutos.html", {
                        "request": request, "usuario": datos_usuario}
                )
            else:
                alerta = {
                    "mensaje": "No tiene los permisos para esta acción",
                    "color": "warning",
                }
                return template.TemplateResponse(
                    "index.html", {"request": request, "alerta": alerta}
                )
        else:
            return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)
    else:
        return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)


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
            if rol_usuario == SUPER_ADMIN or rol_usuario == ADMIN:
                datos_usuario = get_datos_usuario(is_token_valid, db)
                return template.TemplateResponse(
                    "eleccion_junta_administradora.html", {
                        "request": request, "usuario": datos_usuario}
                )
            else:
                alerta = {
                    "mensaje": "No tiene los permisos para esta acción",
                    "color": "warning",
                }
                return template.TemplateResponse(
                    "index.html", {"request": request, "alerta": alerta}
                )
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
            if rol_usuario == SUPER_ADMIN or rol_usuario == ADMIN:
                datos_usuario = get_datos_usuario(is_token_valid, db)
                return template.TemplateResponse(
                    "aprobacion_acta_constitucion.html", {
                        "request": request, "usuario": datos_usuario}
                )
            else:
                alerta = {
                    "mensaje": "No tiene los permisos para esta acción",
                    "color": "warning",
                }
                return template.TemplateResponse(
                    "index.html", {"request": request, "alerta": alerta}
                )
        else:
            return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)
    else:
        return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)


# FIN 1.2

@app.get("/archivo_control_documental", response_class=HTMLResponse, tags=["Operaciones Documentos"])
def PagArchivo_control_documental(
    request: Request, token: str = Cookie(None), db: Session = Depends(get_database)
):
    if token:
        is_token_valid = verificar_token(token, db)  # retorna el id_usuario

        if is_token_valid:
            rol_usuario = get_rol(is_token_valid, db)
            print(rol_usuario)
            if rol_usuario == SUPER_ADMIN or rol_usuario == ADMIN:
                datos_usuario = get_datos_usuario(is_token_valid, db)
                return template.TemplateResponse(
                    "archivo_control_documental.html", {
                        "request": request, "usuario": datos_usuario}
                )
            else:
                alerta = {
                    "mensaje": "No tiene los permisos para esta acción",
                    "color": "warning",
                }
                return template.TemplateResponse(
                    "index.html", {"request": request, "alerta": alerta}
                )
        else:
            return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)
    else:
        return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)


@app.get("/registro_suscriptor", response_class=HTMLResponse, tags=["Operaciones Users"])
def PagRegistro_suscriptor(request: Request):
    return template.TemplateResponse("registro_suscriptor.html", {"request": request})


@app.get("/registro_comision", response_class=HTMLResponse, tags=["Operaciones Documentos"])
def PagRegistro_comiSion(request: Request):
    return template.TemplateResponse("registro_comision.html", {"request": request})


# FUNCIONES PARA LA TAREA DE DIEGO
# CREAR USUARIO
@app.get("/form_super_admin", response_class=HTMLResponse, tags=["Operaciones Users"])
def PagRegistro_comiSion(request: Request):
    return template.TemplateResponse("addUsuario.html", {"request": request})


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
    # Verificar si el correo electrónico ya está registrado
    existing_user = db.query(Usuario).filter(Usuario.correo == correo).first()
    if existing_user:
        raise HTTPException(
            status_code=400, detail="Correo electrónico ya registrado")

    # Genera un ID de usuario aleatorio
    id_usuario = generar_random_id()

    # Encriptar la contraseña antes de almacenarla
    hashed_password = bcrypt.hashpw(
        contrasenia.encode("utf-8"), bcrypt.gensalt())

    usuario_db = Usuario(
        id_usuario=id_usuario,
        rol=rol,
        empresa=empresa,
        nom_usuario=nom_usuario,
        apellido_usuario=apellido_usuario,
        correo=correo,
        tipo_doc=tipo_doc,
        num_doc=num_doc,
        direccion=direccion,
        municipio=municipio,
        contrasenia=hashed_password.decode(
            "utf-8"
        ),  # Almacena la contraseña encriptada
    )
    db.add(usuario_db)
    db.commit()
    db.refresh(usuario_db)
    return {"mensaje": "Super Admin creado exitosamente"}


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
        return template.TemplateResponse("login.html", {"request": request, "alerta": alerta})
        # return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)

    usuario = db.query(Usuario).filter(Usuario.correo == email).first()
    if usuario is None:
        alerta = {
            "mensaje": "El correo " + email + " es incorrecto.",
            "color": "danger",
        }
        return template.TemplateResponse("login.html", {"request": request, "alerta": alerta})
        # return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)

    if not bcrypt.checkpw(
        password.encode("utf-8"), usuario.contrasenia.encode("utf-8")
    ):
        alerta = {
            "mensaje": "La contraseña es incorrecta.",
            "color": "danger",
        }
        return template.TemplateResponse("login.html", {"request": request, "alerta": alerta})
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
        "index.html", {"request": request, "usuario": usuario}
    )
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
@app.post("/generar_docx_P01_F_03/", tags=["Operaciones Documentos"])
async def generar_docx_P01_F_03(
    nombre_de_la_asociacion: str = Form(...),
    nit: str = Form(...),
    direccion: str = Form(...),
    municipio: str = Form(...),
    departamento: str = Form(...),
    telefono: str = Form(...),
    web: str = Form(...),
    correo: str = Form(...),
    horario: str = Form(...),
    vereda: str = Form(...),
    sigla: str = Form(...),
    fecha: str = Form(...)
):
    datos = {
        '[Nombre de la Asociación]': nombre_de_la_asociacion,
        '[Campo NIT]': nit,
        '[Campo Dirección]': direccion,
        '[Campo Municipio]': municipio,
        '[Campo Departamento]': departamento,
        '[Campo Teléfonos]': telefono,
        '[Campo Página Web]': web,
        '[Campo Correo]': correo,
        '[Campo Horario Atención]': horario,
        '[SIGLA]': sigla,
        '[Vereda]': vereda,
        '[Municipio]': municipio,
        '[Departamento]': departamento,
        '[Fecha de Constitución]': fecha
    }

    archivo = 'public/dist/ArchivosDescarga/P01-F-03 Estatutos Asociación Suscriptores'
    documento_modificado = reemplazar_texto(archivo, datos)
    documento_modificado.save(
        'P01-F-03 Estatutos Asociación Suscriptores Editado.docx')

    return {"mensaje": "Archivo generado exitosamente!"}


@app.post("/generar_pdf_P01_F_03/", tags=["Operaciones Documentos"])
async def generar_pdf_P01_F_03():
    archivo_docx = 'P01-F-03 Estatutos Asociación Suscriptores Editado.docx'
    archivo_pdf = 'P01-F-03 Estatutos Asociación Suscriptores.pdf'
    convertir_a_pdf(archivo_docx, archivo_pdf)
    return {"mensaje": "Archivo PDF generado exitosamente!"}


# Otras importaciones necesarias (como SUPER_ADMIN, ADMIN, Usuario, verificar_token, get_rol, get_database, etc.)

# =============================================== BLOQUE PARA LA CREACION DEL USUARIO ===============================================

# --- FUNCION PARA DAR ACCESO AL REGISTRO DEL USUARIO
@app.get("/form_registro_usuario", response_class=HTMLResponse, tags=["Operaciones Users"])
def get_form_usuario(
    request: Request, token: str = Cookie(None), db: Session = Depends(get_database)
):
    if token:
        is_token_valid = verificar_token(token, db)  # retorna el id_usuario

        if is_token_valid:
            rol_usuario = get_rol(is_token_valid, db)
            print(rol_usuario)
            if rol_usuario == SUPER_ADMIN or rol_usuario == ADMIN:
                datos_usuario = get_datos_usuario(is_token_valid, db)
                empresas = db.query(Empresa).all()
                return template.TemplateResponse(
                    "registro_usuario.html", {"request": request, "usuario": datos_usuario, "empresas": empresas})
            else:
                alerta = {
                    "mensaje": "No tiene los permisos para esta accion",
                    "color": "warning",
                }
                return template.TemplateResponse(
                    "index.html", {"request": request, "alerta": alerta}
                )
        else:
            return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)
    else:
        return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)

# --- FUNCION PARA LA CREACION DE USUARIOS


@app.post("/crearUser", tags=["Operaciones Users"])
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

    empresa_existente = db.query(Empresa).filter(
        Empresa.id_empresa == empresa).first()
    if not empresa_existente:
        """         alerta = {
            "mensaje": "La empresa seleccionada, no existe.",
            "color": "danger",
        }
        return RedirectResponse(url="/form_registro_usuario", status_code=status.HTTP_303_SEE_OTHER, alerta=alerta) """
        return
    campos = ['correo', 'num_doc']
    valores = [correo, num_doc]
    if verificar_existencia(campos, valores, db):
        return

    if token:
        is_valid = verificar_token(token, db)
        if is_valid:
            usuario = db.query(Usuario).filter(
                Usuario.id_usuario == is_valid).first()
            if usuario.rol in [SUPER_ADMIN, ADMIN]:
                # Verificar si el correo electronico ya está registrado
                existing_user = db.query(Usuario).filter(
                    Usuario.correo == correo).first()
                if existing_user:
                    return {"error": "Usuario ya existe"}

                verificar_documento = db.query(Usuario).filter(
                    Usuario.num_doc == num_doc).first()
                if verificar_documento:
                    return {"no exitoso": "documento ya existente"}

                # Genera un ID de usuario aleatorio
                id_usuario = generar_random_id()
                user = (
                    db.query(Usuario).filter(
                        Usuario.id_usuario == id_usuario).first()
                )
                if user:
                    raise HTTPException(
                        status_code=400, detail="Id de usuario ya Existe"
                    )
                # Encriptar la contraseña antes de almacenarla
                hashed_password = bcrypt.hashpw(
                    contrasenia.encode("utf-8"), bcrypt.gensalt()
                )
                # Validar y crear el usuario en la base de datos con la contrasena encriptada
                usuario_db = Usuario(
                    id_usuario=id_usuario,
                    rol=rol,
                    empresa=empresa,
                    nom_usuario=nom_usuario,
                    apellido_usuario=apellido_usuario,
                    correo=correo,
                    tipo_doc=tipo_doc,
                    num_doc=num_doc,
                    direccion=direccion,
                    municipio=municipio,
                    contrasenia=hashed_password.decode(
                        "utf-8"
                    ),  # Almacena la contraseña encriptada
                )
                try:
                    db.add(usuario_db)
                    db.commit()
                    db.refresh(usuario_db)

                    # falta mostra el mensaje para cuando se almacene correctamnete el usuario
                    """ alerta = {
                        "mensaje": "creado correctamente",
                        "color": "success",
                    } """

                    return RedirectResponse(url="/form_registro_usuario", status_code=status.HTTP_303_SEE_OTHER)
                except Exception as e:
                    db.rollback()  # Realiza un rollback en caso de error para deshacer cambios
                    return {"mensaje": e}
            return {"mensaje": "Usuario creado exitosamente"}
        else:
            raise HTTPException(status_code=401, detail="No autorizado")
    else:
        raise HTTPException(status_code=401, detail="No autorizado")

# --- FUNCION PARA VERIFICAR CAMPOS EN LA CREACION DE USUARIOS


def verificar_existencia(campos, valores, db):
    query = db.query(Usuario)
    for campo, valor in zip(campos, valores):
        query = query.filter(getattr(Usuario, campo) == valor)
    return db.query(query.exists()).scalar()

# =============================================== FIN DEL BLOQUE DE LA CREACION DEL USUARIO ===============================================


# =============================================== BLOQUE USUARIOS(GENERAL) ===============================================

# --- FUNCION PARA MOSTRAR TODOS LOS USUARIOS(GENERAL)
@app.get("/usuarios", response_class=HTMLResponse, tags=["Operaciones Users"])
def consultarUsuario(request: Request, alerta_mensaje: str = Cookie(None), alerta_color: str = Cookie(None), token: str = Cookie(None), db: Session = Depends(get_database)):
    if token:
        token_valido = verificar_token(token, db)
        if token_valido:
            rol_usuario = get_rol(token_valido, db)
            usuario = db.query(Usuario).filter(
                Usuario.id_usuario == token_valido).first()
            if rol_usuario in [SUPER_ADMIN, ADMIN]:
                query_usuarios = db.query(Usuario)
                if query_usuarios:
                    alerta = {
                        "mensaje": alerta_mensaje,
                        "color": alerta_color,
                    }
                    return template.TemplateResponse("consultar_usuario.html",  {"request": request, "usuarios": query_usuarios, "usuario": usuario, "alerta": alerta})
                else:
                    raise HTTPException(
                        status_code=403, detail="No hay usuarios para consultar")
            else:
                raise HTTPException(
                    status_code=403, detail="No cuenta con los permisos")
        else:
            return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)
    else:
        return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)

# --- FUNCION PARA MOSTRAR LA PAGINA DONDE SE EDITA EL USUARIO(GENERAL)


@app.post("/EditarUsuarios/", response_class=HTMLResponse, tags=["Operaciones Users"])
def Editar_Usuarios(
        request: Request,
        id_usuario: str = Form(...),
        token: str = Cookie(None),
        db: Session = Depends(get_database),
):

    if token:
        token_valido = verificar_token(token, db)
        if token_valido:
            rol_usuario = get_rol(token_valido, db)
            usuario = db.query(Usuario).filter(
                Usuario.id_usuario == token_valido).first()
            if rol_usuario in [SUPER_ADMIN, ADMIN]:
                user = get_datos_usuario(id_usuario, db)
                viviendas = get_viviendas(id_usuario, db)
                return template.TemplateResponse("EditarUsuario.html", {"request": request, "user": user, "usuario": usuario, "viviendas": viviendas})
    raise HTTPException(
        status_code=403, detail="No tiene los permisos necesarios")

# --- FUNCION PARA ACTUALIZAR EL USUARIO(GENERAL)


@app.post("/updateUser/", tags=["Operaciones Users"], response_class=HTMLResponse)
def updateUser(
    request: Request,
    id_usuario: str = Form(...),
    nom_usuario: str = Form(...),
    apellido_usuario: str = Form(...),
    tipo_doc: str = Form(...),
    correo: str = Form(...),
    municipio: str = Form(...),
    direccion: str = Form(...),
    estado: str = Form(...),
    token: str = Cookie(None),
    db: Session = Depends(get_database),
):

    if token:
        token_valido = verificar_token(token, db)

        if token_valido:
            rol_usuario = get_rol(token_valido, db)
            usuario = db.query(Usuario).filter(
                Usuario.id_usuario == token_valido).first()
            if rol_usuario in [SUPER_ADMIN, ADMIN]:
                usuario_actualizar = db.query(
                    Usuario).filter_by(id_usuario=id_usuario).first()
                users = db.query(Usuario).all()
                if usuario_actualizar:

                    # Actualiza los campos con los nuevos valores
                    usuario_actualizar.nom_usuario = nom_usuario
                    usuario_actualizar.apellido_usuario = apellido_usuario
                    usuario_actualizar.correo = correo
                    usuario_actualizar.direccion = direccion
                    usuario_actualizar.municipio = municipio
                    usuario_actualizar.estado = estado
                    usuario_actualizar.tipo_doc = tipo_doc
                    # Guarda los cambios en la base de datos
                    db.commit()
                    # Compara los valores actuales con los nuevos valores
                    # Si son iguales, retorna un mensaje de error
                    if usuario_actualizar.nom_usuario == nom_usuario and usuario_actualizar.apellido_usuario == apellido_usuario and usuario_actualizar.correo == correo and usuario_actualizar.direccion == direccion and usuario_actualizar.municipio == municipio and usuario_actualizar.estado == estado and usuario_actualizar.tipo_doc == tipo_doc:

                        alerta = {
                            "mensaje": "No se han realizado cambios",
                            "color": "info",
                        }

                        # Create a RedirectResponse with the desired URL
                        redirect_response = RedirectResponse(
                            url="/usuarios", status_code=status.HTTP_303_SEE_OTHER)

                        # Set the cookie to store the alert data
                        redirect_response.set_cookie(
                            key="alerta_mensaje", value=alerta["mensaje"])
                        redirect_response.set_cookie(
                            key="alerta_color", value=alerta["color"])

                        # Return the RedirectResponse
                        return redirect_response
                    else:
                        print("Usuario actualizado correctamente")
                        return {"exitoso": "Usuario actualizado correctamente"}
                else:
                    return {"error": "Usuario no encontrado"}
            else:
                return {"error": "No tiene los permisos necesarios"}
        else:
            return {"error": "Token inválido"}
    else:
        return {"error": "Token no proporcionado"}


# ---FUNCION PARA CAMBIAR EL ESTADO DEL USUARIO EN EL TABLA


@app.post("/CambiarEstadoUsuario/{id_usuario}", tags=["Operaciones Users"])
def cambiar_estado_usuario(id_usuario: str, token: str = Cookie(None), db: Session = Depends(get_database)):
    try:
        # Comprueba si hay un token
        if token:
            # Verifica la validez del token
            token_valido = verificar_token(token, db)
            if not token_valido:
                raise HTTPException(status_code=403, detail="Token inválido")

            # Obtiene el rol del usuario a partir del token
            rol_usuario = get_rol(token_valido, db)

            # Validar que Super admin y admin puedan cambiar el estado
            if rol_usuario not in {SUPER_ADMIN, ADMIN}:
                raise HTTPException(
                    status_code=403, detail="No cuenta con los permisos para cambiar el estado")

            # Cambia el estado del usuario a "Inactivo"
            usuario_a_cambiar = db.query(Usuario).filter_by(
                id_usuario=id_usuario).first()
            if not usuario_a_cambiar:
                raise HTTPException(
                    status_code=404, detail="Usuario no encontrado")
            usuario_a_cambiar.estado = "Inactivo"
            db.commit()

            return {"exitoso": "Estado del usuario cambiado a 'Inactivo' correctamente"}
        else:
            raise HTTPException(
                status_code=403, detail="Token no proporcionado")
    except Exception as e:
        # Captura cualquier error inesperado
        return JSONResponse(status_code=500, content={"error": f"Error interno: {str(e)}"})

# =============================================== FIN BLOQUE USUARIOS(GENERAL) ===============================================


# ============================================ BLOQUE PARA EL PERFIL DEL USUARIO(PERSONAL) ============================================

# --- MOSTRAMOS PAGINA CON EL ACCESO AL PERFIL DEL USUARIO(PERSONAL)
@app.get("/perfil_usuario", response_class=HTMLResponse, tags=["Operaciones Users"])
def get_perfil_usuario(
    request: Request, token: str = Cookie(None), db: Session = Depends(get_database)
):
    if token:
        is_token_valid = verificar_token(token, db)  # retorna el id_usuario

        if is_token_valid:
            rol_usuario = get_rol(is_token_valid, db)

            if rol_usuario:
                datos_usuario = get_datos_usuario(is_token_valid, db)
                return template.TemplateResponse("perfil_usuario.html", {"request": request, "usuario": datos_usuario})
            else:
                alerta = {
                    "mensaje": "No tiene los permisos para esta acción", "color": "warning", }

                return template.TemplateResponse("index.html", {"request": request, "alerta": alerta})
        else:
            return RedirectResponse("/", status_code=status.HTTP_303_SEE_OTHER)
    else:
        return RedirectResponse("/", status_code=status.HTTP_303_SEE_OTHER)

# --- RUTA PARA QUE EL USUARIO PUEDA VER SU INFORMACION PERSONAL DESDE EL PERFIL


@app.post("/EditarUsuario/", response_class=HTMLResponse, tags=["Operaciones Users"])
def Editar_Usuario(
    request: Request,
    id_usuario: str = Form(...),
    token: str = Cookie(None),
    db: Session = Depends(get_database)
):
    usuario = get_datos_usuario(id_usuario, db)
    if token:
        token_valido = verificar_token(token, db)
        if token_valido:
            return template.TemplateResponse("perfil_usuario.html", {"request": request, "usuario": usuario})
    raise HTTPException(
        status_code=403, detail="Ha ocurrido un error.")

# --- FUNCI0N PARA ACTUALIZAR LOS DATOS DEL PERFIL (PERSONAL):


@app.post("/actualizarPerfil", tags=["Operaciones Users"])
def actualizar_perfil(
    request: Request,
    nom_usuario: str = Form(...),
    apellido_usuario: str = Form(...),
    tipo_doc: str = Form(...),
    num_doc: str = Form(...),
    email: str = Form(...),
    direccion: str = Form(...),
    token: str = Cookie(None),
    db: Session = Depends(get_database)
):

    if not nom_usuario:
        raise HTTPException(status_code=400, detail="El nombre es requerido")

    if not apellido_usuario:
        raise HTTPException(status_code=400, detail="El apellido es requerido")

    if not tipo_doc:
        raise HTTPException(
            status_code=400, detail="El tipo de documento es requerido")

    if not num_doc:
        raise HTTPException(
            status_code=400, detail="El número de documento es requerido")

    if not email:
        raise HTTPException(
            status_code=400, detail="El correo electrónico es requerido")

    if not direccion:
        raise HTTPException(
            status_code=400, detail="La dirección es requerida")

    if not nom_usuario or not apellido_usuario or not tipo_doc or not num_doc or not email or not direccion:
        raise HTTPException(
            status_code=400, detail="Todos los campos son requeridos")

    if token:
        token_valido = verificar_token(token, db)
        if token_valido:
            usuario = db.query(Usuario).filter(
                Usuario.id_usuario == token_valido).first()
            if usuario:
                # Validar si alguno de los campos está vacío o lleno de espacios

                usuario.nom_usuario = nom_usuario
                usuario.apellido_usuario = apellido_usuario
                usuario.tipo_doc = tipo_doc
                usuario.num_doc = num_doc
                usuario.correo = email
                usuario.direccion = direccion

                db.commit()

                # Redireccionar al perfil actualizado
                return RedirectResponse(url="/perfil_usuario", status_code=status.HTTP_303_SEE_OTHER)
            else:
                raise HTTPException(status_code=403, detail="No puede entrar")
        else:
            return RedirectResponse("/", status_code=status.HTTP_303_SEE_OTHER)
    else:
        return RedirectResponse("/", status_code=status.HTTP_303_SEE_OTHER)

# ============================================ FIN DE BLOQUE DEL PERFIL DEL USUARIO(PERSONAL) ============================================


# ============================================= BLOQUE PARA CREACION DE EMPRESA =============================================

# --- MOSTRAMOS LA PAGINA PARA REGISTRAR UNA EMPRESA
@app.get("/registro_empresa", response_class=HTMLResponse, tags=["Operaciones Empresas"])
def MostrarRegistroEmpresa(request: Request,
                           token: str = Cookie(None), db: Session = Depends(get_database)
                           ):
    if token:
        token_valido = verificar_token(token, db)
        if token_valido:
            rol_usuario = get_rol(token_valido, db)
            usuario = db.query(Usuario).filter(
                Usuario.id_usuario == token_valido).first()
            if rol_usuario in [SUPER_ADMIN, ADMIN]:
                return template.TemplateResponse("registro_empresa.html", {"request": request, "usuario": usuario})
            else:
                raise HTTPException(
                    status_code=403, detail="NO TIENES LOS PERMISOS PARA ACCEDER A ESTA PAGINA ")
        else:
            return RedirectResponse("/", status_code=status.HTTP_303_SEE_OTHER)
    else:
        return RedirectResponse("/", status_code=status.HTTP_303_SEE_OTHER)

# --- CREAMOS UNA EMPRESA


@app.post("/registrarEmpresa", tags=["Operaciones Empresas"])
def crearEmpresa(
    request: Request,
    nom_empresa: str = Form(...),
    direccion_empresa: str = Form(...),
    tel_fijo: str = Form(...),
    tel_cel: str = Form(...),
    email: str = Form(...),
    token: str = Cookie(None),
    db: Session = Depends(get_database),
):
    # Verificar si todos los campos fueron proporcionados
    if not nom_empresa or not direccion_empresa or not tel_fijo or not tel_cel or not email:
        raise HTTPException(
            status_code=400, detail="Todos los campos son requeridos")

    # Verificar si se proporciona un token válido en las cookies
    if token:
        is_valid = verificar_token(token, db)
        if is_valid:
            usuario = db.query(Usuario).filter(
                Usuario.id_usuario == is_valid).first()
            print(usuario.rol)
            if usuario.rol in [SUPER_ADMIN, ADMIN]:
                # Verificar si el correo electrónico de la empresa ya está registrado
                existing_correo = db.query(Empresa).filter(
                    Empresa.email == email).first()

                # Verificar si el nombre de la empresa ya está registrado
                existing_nombre = db.query(Empresa).filter(
                    Empresa.nom_empresa == nom_empresa).first()

                if existing_correo:
                    raise HTTPException(
                        status_code=400, detail="Correo de la empresa ya registrado")

                if existing_nombre:
                    raise HTTPException(
                        status_code=400, detail="Nombre de la empresa ya registrado")

                # Crear una instancia de la clase Empresa
                empresa_db = Empresa(
                    nom_empresa=nom_empresa,
                    direccion_empresa=direccion_empresa,
                    tel_fijo=tel_fijo,
                    tel_cel=tel_cel,
                    email=email
                )

                try:
                    db.add(empresa_db)
                    db.commit()
                    db.refresh(empresa_db)
                    return JSONResponse(status_code=201, content={"mensaje": "Empresa creada exitosamente"})
                except Exception as e:
                    db.rollback()
                    raise HTTPException(
                        status_code=500, detail="Error al registrar la empresa")
            else:
                raise HTTPException(
                    status_code=401, detail="No TIENE LOS PERMISOS")
        else:
            raise HTTPException(status_code=401, detail="No autorizado")
    else:
        raise HTTPException(status_code=401, detail="No autorizado")
# ============================================= FIN DE BLOQUE DE CREACION DE EMPRESA =============================================


# =============================================- BLOQUE PARA ACTUALIZAR EMPRESAS =============================================-

# --- FUNCION PARA MOSTRAR TODAS LA EMPRESAS
@app.get("/empresas/{page}", response_class=HTMLResponse, tags=["Operaciones Empresas"])
def consultarEmpresa(request: Request, page: int, token: str = Cookie(None), db: Session = Depends(get_database)):

    if token:
        token_valido = verificar_token(token, db)
        if token_valido:
            rol_usuario = get_rol(token_valido, db)
            usuario = db.query(Usuario).filter(
                Usuario.id_usuario == token_valido).first()
            if rol_usuario in [SUPER_ADMIN, ADMIN]:
                items_per_page = 10
                offset = (page - 1) * items_per_page
                query_empresas = db.query(Empresa).offset(
                    offset).limit(items_per_page).all()
                total_empresas = db.query(Empresa).count()
                total_pages = (total_empresas // items_per_page) + \
                    (1 if total_empresas % items_per_page > 0 else 0)

                if query_empresas:
                    return template.TemplateResponse("consultar_empresa.html", {"request": request, "empresa": query_empresas, "usuario": usuario, "page": page, "total_pages": total_pages})
                else:
                    raise HTTPException(
                        status_code=403, detail="No hay empresas que consultar")
            else:
                raise HTTPException(status_code=403, detail="No puede entrar")
        else:
            return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)
    else:
        return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)

# --- FUNCION PARA CAMBIAR EL ESTADO DE LA EMPRESA


@app.post("/CambiarEstadoEmpresa/{id_empresa}", tags=["Operaciones Empresas"])
def cambiar_estado_empresa(id_empresa: int, token: str = Cookie(None), db: Session = Depends(get_database)):
    try:
        # Comprueba si hay un token
        if token:
            # Verifica la validez del token
            token_valido = verificar_token(token, db)
            if not token_valido:
                raise HTTPException(status_code=403, detail="Token inválido")

            # Obtiene el rol del usuario a partir del token
            rol_usuario = get_rol(token_valido, db)

            # Validar que Super admin y admin puedan cambiar el estado
            if rol_usuario not in {SUPER_ADMIN, ADMIN}:
                raise HTTPException(
                    status_code=403, detail="No cuenta con los permisos para cambiar el estado")

            # Cambia el estado del usuario a "Inactivo"
            empresa_a_cambiar = db.query(Empresa).filter_by(
                id_empresa=id_empresa).first()
            if not empresa_a_cambiar:
                raise HTTPException(
                    status_code=404, detail="Empresa no encontrada")

            empresa_a_cambiar.estado = "Inactivo"
            db.commit()

            return {"exitoso": "Estado de la empresa cambiado a 'Inactivo' correctamente"}
        else:
            raise HTTPException(
                status_code=403, detail="Token no proporcionado")
    except Exception as e:
        # Captura cualquier error inesperado
        return JSONResponse(status_code=500, content={"error": f"Error interno: {str(e)}"})

# --- RUTA PARA MOSTRAR LA PAGUNA DONDE SE EDITA LA EMPRESA


@app.post("/EditarEmpresa/", response_class=HTMLResponse, tags=["Operaciones Empresas"])
def Editar_Empresas(request: Request,
                    id_empresa: int = Form(...),
                    token: str = Cookie(None),
                    db: Session = Depends(get_database)):
    if token:
        token_valido = verificar_token(token, db)
        if token_valido:
            rol_usuario = get_rol(token_valido, db)
            usuario = db.query(Usuario).filter(
                Usuario.id_usuario == token_valido).first()
            if rol_usuario == SUPER_ADMIN or rol_usuario == ADMIN:
                empresa = get_datos_empresa(id_empresa, db)
                return template.TemplateResponse("EditarEmpresa.html", {"request": request, "empresa": empresa, "usuario": usuario})
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
                return template.TemplateResponse("EditarUsuario.html", {"request": request, "user": user, "usuario": usuario, "viviendas": viviendas, "alerta": alerta})
            except Exception as e:
                db.rollback()
                alerta = {
                    "mensaje": "Error al registrar la vivienda",
                    "color": "error",
                }
                return template.TemplateResponse("EditarUsuario.html", {"request": request, "user": user, "usuario": usuario, "viviendas": viviendas, "alerta": alerta})
        else:
            raise HTTPException(
                status_code=403, detail="nada")
    else:
        return RedirectResponse("/", status_code=status.HTTP_303_SEE_OTHER)

# --- FUNCION PARA Eliminar vivienda del usuario


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
                return template.TemplateResponse("EditarUsuario.html", {"request": request, "user": user, "usuario": usuario, "viviendas": viviendas, "alerta": alerta})
            else:
                alerta = {
                    "mensaje": "Vivienda no encontrada",
                    "color": "error",
                }
                return template.TemplateResponse("EditarUsuario.html", {"request": request, "user": user, "usuario": usuario, "viviendas": viviendas, "alerta": alerta})
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
                return template.TemplateResponse("EditarUsuario.html", {"request": request, "user": user, "usuario": usuario, "viviendas": viviendas, "alerta": alerta})
            else:
                alerta = {
                    "mensaje": "Vivienda no encontrada",
                    "color": "error",
                }
                return template.TemplateResponse("EditarUsuario.html", {"request": request, "user": user, "usuario": usuario, "viviendas": viviendas, "alerta": alerta})
        else:
            raise HTTPException(
                status_code=403, detail="nada")
    else:
        return RedirectResponse("/", status_code=status.HTTP_303_SEE_OTHER)


# --- FUNCION PARA MOSTRAR TODAS LAS VIVIENDAS SIN USUARIO


@app.get("/viviendas", response_class=HTMLResponse, tags=["Operaciones Viviendas"])
def consultarVivienda(request: Request, token: str = Cookie(None), db: Session = Depends(get_database)):
    if token:
        token_valido = verificar_token(token, db)
        if token_valido:
            rol_usuario = get_rol(token_valido, db)
            usuario = db.query(Usuario).filter(
                Usuario.id_usuario == token_valido).first()
            if rol_usuario in [SUPER_ADMIN, ADMIN]:
                query_viviendas = db.query(Vivienda).filter(
                    Vivienda.id_usuario == None)
                if query_viviendas:
                    return template.TemplateResponse("consultar_viviendas.html", {"request": request, "viviendas": query_viviendas, "usuario": usuario})
                else:
                    raise HTTPException(
                        status_code=403, detail="No hay viviendas que consultar")
            else:
                raise HTTPException(status_code=403, detail="No puede entrar")
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
                return template.TemplateResponse("EditarVivienda.html", {"request": request, "vivienda": vivienda, "usuario": usuario, "users": users})
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
                return template.TemplateResponse("consultar_viviendas.html", {"request": request, "usuario": usuario, "viviendas": query_viviendas, "alerta": alerta})
            else:
                alerta = {
                    "mensaje": "Vivienda no encontrada",
                    "color": "error",
                }
                return template.TemplateResponse("consultar_viviendas.html", {"request": request, "usuario": usuario, "viviendas": query_viviendas, "alerta": alerta})
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
                return template.TemplateResponse("consultar_viviendas.html", {"request": request, "usuario": usuario, "viviendas": query_viviendas, "alerta": alerta})
            else:
                alerta = {
                    "mensaje": "Vivienda no encontrada",
                    "color": "error",
                }
                return template.TemplateResponse("consultar_viviendas.html", {"request": request, "usuario": usuario, "viviendas": query_viviendas, "alerta": alerta})
        else:
            raise HTTPException(
                status_code=403, detail="nada")
    else:
        return RedirectResponse("/", status_code=status.HTTP_303_SEE_OTHER)
