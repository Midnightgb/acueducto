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


def createReunion(
    id_empresa: int,
    nom_reunion: str,
    fecha: str,
    url_asistencia: str,
    cuorum: int,
    token: str,
    db: Session,
):
        # Verificar si todos los campos fueron proporcionados
    if not id_empresa or not nom_reunion or not fecha or not cuorum:
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
                cuorum=cuorum
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

