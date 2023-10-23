import os
from dotenv import load_dotenv
from email.message import EmailMessage
import ssl
import smtplib


# funcion para enviar correo automaticos de las reuniones
# solo recibe los correos destinatarios
def enviar_correo_auto(destinatarios, nom_reunion, fecha, hora, lugar, nom_empresa):
    try:
        load_dotenv()

        correo_envia = "info.sistema.acueducto@gmail.com"
        contraseña = os.getenv("PASSWORD")

        asunto = f"Invitacion Reunión";
        cuerpo = f"""
                {nom_empresa} lo(a) invita a participar de la reunión: {nom_reunion}\n\n
                Hora: {hora}
                Fecha: {fecha}
                Lugar: {lugar}\n
                Esperamos su participación.
            """

        correo = EmailMessage()
        correo["From"] = correo_envia
        correo["To"] = destinatarios
        correo["Subject"] = asunto
        correo.set_content(cuerpo)

        contexto = ssl.create_default_context()

        with smtplib.SMTP_SSL("smtp.gmail.com", 465, context=contexto) as smtp:
            smtp.login(correo_envia, contraseña)

            for destinatario in destinatarios:
                correo.replace_header("To", destinatario)
                smtp.sendmail(correo_envia, destinatario, correo.as_string())

        print("Correo enviado.")
        return True
    except Exception as e:
        print(f"Error al enviar correo: {str(e)}")
        return False
