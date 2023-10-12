// Función para mostrar el loader
function mostrarLoader() {
    const loader = document.getElementById("loader");
    loader.style.display = "block";
}

// Función para ocultar el loader
function ocultarLoader() {
    const loader = document.getElementById("loader");
    loader.style.display = "none";
}
ocultarLoader()
// Agregar un manejador de eventos para el envío del formulario
document.getElementById("miFormulario").addEventListener("submit", function (event) {
    // Evita que el formulario se envíe de inmediato
    event.preventDefault();

    // Muestra el loader al enviar el formulario
    mostrarLoader();
    event.target.submit();

});
