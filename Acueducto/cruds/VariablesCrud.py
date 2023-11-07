from fastapi import HTTPException, Depends, Cookie, Response
from fastapi import HTTPException
from typing import Optional
from cruds.EmpresasCrud import *
from cruds.ReunionesCrud import *
from cruds.UsuariosCrud import *
from cruds.SuperAdmin import *
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
from models import Empresa, Usuario,Variable,DatosVariable
import bcrypt
from database import get_database
from funciones import get_datos_empresa
from typing import Union
from sqlalchemy import and_


SUPER_ADMIN = "SuperAdmin"
ADMIN = "Admin"
ESTADO = "Activo"
datos_usuario = None

app = FastAPI()

# Agregando los archivos estaticos que están en la carpeta dist del proyecto
app.mount("/static", StaticFiles(directory="public/dist"), name="static")

template = Jinja2Templates(directory="public/templates")

def obtenerVariablesT(
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
            preguntasRespuestas = obtenerVariables(id_empresa, db)
            if preguntasRespuestas:
                response = template.TemplateResponse(
                    "otros-archivos/lista_variables.html",
                    {
                        "request": request,
                        "variables": preguntasRespuestas,
                        "empresas": empresas,
                        "usuario": usuario,
                    },
                )
                response.headers.update(headers)
                return response
            else:
                alerta = {
                    "mensaje": "No hay variables de la empresa",
                    "color": "warning",
                }

                response = template.TemplateResponse(
                    "otros-archivos/lista_variables.html",
                    {"request": request, "alerta": alerta, "empresas": empresas,
                        "usuario": usuario, "reuniones": None},
                )
                response.headers.update(headers)
                return response
        else:
            return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)
    else:
        return RedirectResponse(url="/", status_code=status.HTTP_303_SEE_OTHER)


def obtenerVariables(id_empresa: int, db: Session):
    query = (
        db.query(Variable.pregunta, DatosVariable.respuesta)
        .join(Variable, Variable.id_variable == DatosVariable.id_variable)
        .filter(DatosVariable.id_empresa == id_empresa)
        .all()
    )
    
    if query:
        return query
    else:
        return None
