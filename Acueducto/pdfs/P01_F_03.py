from fastapi import HTTPException, Depends, Cookie, Response
from fastapi import HTTPException
import bcrypt
from fastapi.staticfiles import StaticFiles
from fastapi.templating import Jinja2Templates
from str_aleatorio import generar_random_id
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
from models import Documento, Usuario, Empresa
from fastapi.responses import JSONResponse, RedirectResponse

from sqlalchemy.orm import Session, aliased
from funciones import *
SUPER_ADMIN = "SuperAdmin"
datos_usuario = None

app = FastAPI()

# Agregando los archivos estaticos que están en la carpeta dist del proyecto
app.mount("/static", StaticFiles(directory="public/dist"), name="static")

template = Jinja2Templates(directory="public/templates")

def manejarDocumentos(nombre_documento, datos, nit, id_usuario, db):
    archivo = 'public/dist/ArchivosDescarga/'+nombre_documento+'.docx'
    documento_modificado = reemplazar_texto(archivo, datos)
    documento_modificado.save('public/dist/ArchivosDescarga/Generados/'+nombre_documento+'_Editado' + nit + '.docx')
    
    archivo_docx = 'public/dist/ArchivosDescarga/Generados/'+nombre_documento+'_Editado' + nit + '.docx'
    archivo_pdf = 'public/dist/ArchivosDescarga/Generados/'+nombre_documento+'' + nit + '.pdf'

    convertir_a_pdf(archivo_docx, archivo_pdf)

    nuevo_documento1 =   Documento(
        id_usuario=id_usuario,
        nom_doc= nombre_documento + nit,
        id_servicio=1,
        tipo='pdf',
        url='ArchivosDescarga/Generados/'+nombre_documento + nit + '.pdf'
    )

    db.add(nuevo_documento1)
    db.commit()
    db.refresh(nuevo_documento1)

def generarDocx_P01_F_03(
    request: Request, 
    token: str, 
    db: Session,
    nit: str,
    presidente: str,
    patrimonio: str,
    municipio: str,
    departamento: str,
    web: str,
    horario: str,
    sigla: str,
    vereda: str,
    fecha: str,
    especificaciones: str,
    diametro: str,
    caudal_permanente: str,
    rango_medicion: str
    ):

    if token:
        is_token_valid = verificar_token(token, db)  # retorna el id_usuario

        if is_token_valid:

            # Supongamos que tienes un ID de usuario específico

            rol_usuario = get_rol(is_token_valid, db)
            print(rol_usuario)
            headers = elimimar_cache()
            datos_usuario = get_datos_usuario(is_token_valid, db)
            if rol_usuario == SUPER_ADMIN:
                id_usuario = is_token_valid

            # Crea un alias para la tabla 'empresas' para la subconsulta
                empresas_alias = aliased(Empresa)

            # Realiza la consulta principal para obtener la información del usuario y su empresa relacionada
                usuario = db.query(Usuario).filter(Usuario.id_usuario == id_usuario).first()

                if usuario:
                    empresa = db.query(Empresa).filter(Empresa.id_empresa == usuario.empresa).first()
                    if empresa:
                        print(f'ID del Usuario: {usuario.id_usuario}')
                        print(f'Nombre del Usuario: {usuario.nom_usuario}')
                        print(f'Empresa del Usuario:')
                        print(f'  - ID: {empresa.id_empresa}')
                        print(f'  - Nombre: {empresa.nom_empresa}')

                        datos = {
                            '[Nombre de la Asociación]': empresa.nom_empresa,
                            '[Campo NIT]': nit,
                            '[Presidente Asociacion]': presidente,
                            '[Campo Patrimonio]': patrimonio,
                            '[Campo Dirección]': empresa.direccion_empresa,
                            '[Campo Municipio]': municipio,
                            '[Campo Departamento]': departamento,
                            '[Campo Teléfonos]': "Celular: "+empresa.tel_cel+" Telefono: :"+empresa.tel_fijo,
                            '[Campo Página Web]': web,
                            '[Campo Correo]': empresa.email,
                            '[Campo Horario Atención]': horario,
                            '[SIGLA]': sigla,
                            '[Dirección]': empresa.direccion_empresa,
                            '[Vereda]': vereda,
                            '[Municipio]': municipio,
                            '[Departamento]': departamento,
                            '[Fecha de Constitución]': fecha,
                            '[Campo Especificaiones]': especificaciones,
                            '[Campo Diametro]': diametro,
                            '[Campo Caudal Permanente]': caudal_permanente,
                            '[Campo Rango Medicion]': rango_medicion,
                        }
                        arreglo_rutas = []
                        #crear, guardar y convertir a pdf archivo 1
                        manejarDocumentos("P01-F-03_Estatutos_Asociación_Suscriptores", datos, nit, is_token_valid, db)
                        arreglo_rutas.append('ArchivosDescarga/Generados/P01-F-03_Estatutos_Asociación_Suscriptores'+ nit + '.pdf')
                        manejarDocumentos("P01-F-02_Formato_Contrato_Condiciones_Uniformes", datos, nit, is_token_valid, db)
                        arreglo_rutas.append('ArchivosDescarga/Generados/P01-F-02_Formato_Contrato_Condiciones_Uniformes'+ nit + '.pdf')
                        manejarDocumentos("P01-F-06_ActaConstitución", datos, nit, is_token_valid, db)
                        arreglo_rutas.append('ArchivosDescarga/Generados/P01-F-06_ActaConstitución'+ nit + '.pdf')
                        response = template.TemplateResponse(
                        "paso-1/paso1-3/archivo_control_documental.html", {"request": request, "usuario": datos_usuario, "rutas_pdf": arreglo_rutas}
                        )
                        response.headers.update(headers)  # Actualiza las cabeceras
                        return response

                    else:
                        print('El usuario no está asociado a ninguna empresa.')
                else:
                    print('No se encontró el usuario con el ID proporcionado.')
                response = template.TemplateResponse(
                    "paso-1/paso1-3/archivo_control_documental.html", {"request": request, "usuario": datos_usuario, "rutas_pdf": []}
                )
                response.headers.update(headers)  # Actualiza las cabeceras
                return response
            else:
                alerta = {
                    "mensaje": "No tiene los permisos para esta acción",
                    "color": "warning",
                }
                response = template.TemplateResponse(
                    "index.html", {"request": request, "alerta": alerta,"usuario": datos_usuario}
                )
                response.headers.update(headers)  # Actualiza las cabeceras
                return response
        else:
            return RedirectResponse(url="/", status_code=status.HTTP_403_FORBIDDEN)
    else:
        return RedirectResponse(url="/", status_code=status.HTTP_403_FORBIDDEN)