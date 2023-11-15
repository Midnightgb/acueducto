from sqlalchemy import Column, Integer, String, Enum, ForeignKey, Float, Date, Boolean, Time
from sqlalchemy.orm import declarative_base, relationship
from sqlalchemy.sql import func
from enum import Enum as PyEnum

Base = declarative_base()


class Empresa(Base):
    __tablename__ = 'empresas'
    id_empresa = Column(Integer, primary_key=True, autoincrement=True)
    nom_empresa = Column(String(50))
    direccion_empresa = Column(String(100))
    tel_fijo = Column(String(10))
    tel_cel = Column(String(10))
    email = Column(String(90))
    estado = Column(Enum('Activo', 'Inactivo'), default='Activo')
    create_at = Column(String, server_default=func.now(), nullable=False)
    update_at = Column(String, server_default=func.now(),
                       onupdate=func.now(), nullable=False)


class Servicio(Base):
    __tablename__ = 'servicios'
    id_servicio = Column(Integer, primary_key=True, autoincrement=True)
    nom_servicio = Column(String(80))
    paso = Column(Float(3, 1))
    modulo = Column(Integer, nullable=False)
    create_at = Column(String, server_default=func.now(), nullable=False)
    update_at = Column(String, server_default=func.now(),
                       onupdate=func.now(), nullable=False)


class Usuario(Base):
    __tablename__ = "usuarios"
    id_usuario = Column(String(30), primary_key=True)
    rol = Column(Enum('SuperAdmin', 'Admin', 'Tecnico', 'Suscriptor'))
    empresa = Column(Integer, nullable=True)
    nom_usuario = Column(String(50))
    apellido_usuario = Column(String(50))
    correo = Column(String(90))
    tipo_doc = Column(Enum('CC', 'CE', 'DNI', 'NIT'))
    num_doc = Column(String(12))
    direccion = Column(String(100))
    municipio = Column(String(50))
    contrasenia = Column(String(180))
    estado = Column(Enum('Activo', 'Inactivo'), default='Activo')

class Documento(Base):
    __tablename__ = 'documentos'
    id_doc = Column(Integer, primary_key=True)
    id_usuario = Column(String(30), ForeignKey('usuarios.id_usuario'))
    nom_doc = Column(String(80))
    id_servicio = Column(Integer)
    tipo = Column(Enum('pdf', 'docx', 'xlsx'))
    create_at = Column(String, server_default=func.now(), nullable=False)
    update_at = Column(String, server_default=func.now(),
                       onupdate=func.now(), nullable=False)
    url = Column(String(200))

class Reunion(Base):
    __tablename__ = "reuniones"
    id_reunion = Column(Integer, primary_key=True, autoincrement=True)
    id_empresa = Column(Integer)
    nom_reunion = Column(String(120))
    fecha = Column(Date)
    hora = Column(Time)
    lugar = Column(String)
    url_asistencia = Column(String(200))
    cuorum = Column(Boolean)

class Token(Base):
    __tablename__ = "tokens"

    id_token = Column(Integer, primary_key=True,
                      autoincrement=True, nullable=False)
    token = Column(String(255), nullable=False)


class Vivienda(Base):
    __tablename__ = "inmuebles_suscritor"
    id_inmueble = Column(Integer, primary_key=True, autoincrement=True)
    id_usuario = Column(String(30), ForeignKey('usuarios.id_usuario'))
    direccion = Column(String(100))
    estrato = Column(String(50))
    uso = Column(Enum('Doméstico', 'Industrial',
                 'Institucional', 'Comercial', 'Agropecuario'))
    numero_residentes = Column(Integer)
    create_at = Column(String, server_default=func.now(), nullable=False)
    update_at = Column(String, server_default=func.now(),
                       onupdate=func.now(), nullable=False)


class Lista_asistencia(Base):
    __tablename__ = "lista_asistencia"
    id_asistencia = Column(Integer, primary_key=True, autoincrement=True)
    id_usuario = Column(String(30), ForeignKey('usuarios.id_usuario'))
    id_reunion = Column(Integer, ForeignKey('reuniones.id_reunion'))
    asistencia = Column(Integer)
    
class Variable(Base):
    __tablename__ = 'variables'

    id_variable = Column(Integer, primary_key=True, autoincrement=True)
    pregunta = Column(String(100))

class DatosVariable(Base):
    __tablename__ = 'datos_variables'

    id_empresa = Column(Integer, ForeignKey('empresas.id_empresa'), primary_key=True)
    id_variable = Column(Integer, ForeignKey('variables.id_variable'), primary_key=True)
    respuesta = Column(String(100))