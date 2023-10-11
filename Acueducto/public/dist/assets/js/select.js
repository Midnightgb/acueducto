let formulario = document.getElementById('formulario');
let selectEmpresa = document.getElementById('selectEmpresa');
selectEmpresa.addEventListener('change', () => {
    formulario.submit();
});