from fastapi import HTTPException, Depends, Cookie, Response
from fastapi import HTTPException
from fastapi import (
    FastAPI,
    Request,
    Form,
    UploadFile,
    status,
    Depends,
    HTTPException,
    Cookie,
    Query,
)
from fastapi.responses import JSONResponse

from sqlalchemy.orm import Session
from funciones import *
from models import Reunion

SUPER_ADMIN = "SuperAdmin"
ADMIN = "Admin"
ESTADO = "Activo"

def updateReunion(
    id_reunion: int ,
    nom_reunion: str,
    fecha: str,
    token: str,
    db: Session,
):
    
    if not nom_reunion:
        raise HTTPException(status_code=400, detail="El nombre es requerido")
    
    if not fecha:
        raise HTTPException(status_code=400, detail="La fecha es requerida")
    
    if not nom_reunion or not fecha:
        raise HTTPException(status_code=400, detail="Todos los campos son requeridos")

    if token:
        token_valido = verificar_token(token, db)
        if token_valido:
            rol_usuario = get_rol(token_valido, db)
            if rol_usuario in [SUPER_ADMIN, ADMIN]:
                update_reunion = db.query(Reunion).filter_by(
                    id_reunion=id_reunion).first()

                if update_reunion:
                    update_reunion.nom_reunion = nom_reunion
                    update_reunion.fecha = fecha
                    db.commit()
                    return True
                else:
                    raise HTTPException(
                        status_code=404, detail="Reunion no encontrada")
            else:
                raise HTTPException(
                    status_code=403, detail="No tienes permisos para actualizar reuniones")
        else:
            return False
    else:
        return False

def createReunion(
    id_empresa: int,
    nom_reunion: str,
    fecha: str,
    url_asistencia: str,
    token: str,
    db: Session,
):
        # Verificar si todos los campos fueron proporcionados
    if not id_empresa or not nom_reunion or not fecha:
        raise HTTPException(status_code=400, detail="Todos los campos son requeridos")
    
    # Verificar si se proporciona un token válido en las cookies
    if token:
        is_valid = verificar_token(token, db)
        if is_valid:
            # Verificar si el nombre de la reunion ya está registrado
            existing_nombre = db.query(Reunion).filter(Reunion.nom_reunion == nom_reunion).first()
            if existing_nombre: 
                raise HTTPException(status_code=400, detail="Nombre de la reunion ya registrado")
            # Crear una instancia de la clase Reunion
            reunion_db = Reunion(
                id_empresa=id_empresa,
                nom_reunion=nom_reunion,
                fecha=fecha,
                url_asistencia=url_asistencia,
            )
            try:
                db.add(reunion_db)
                db.commit()
                db.refresh(reunion_db)
                return JSONResponse(status_code=201, content={"mensaje": "Reunion creada exitosamente"})
            except Exception as e:
                db.rollback()
                raise HTTPException(status_code=500, detail="Error al registrar la Reunion")
        else:
            raise HTTPException(status_code=401, detail="No autorizado")
    else:
        raise HTTPException(status_code=401, detail="No autorizado")

