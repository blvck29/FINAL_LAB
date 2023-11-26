<%@ page import="com.app.whiteboard.model.beans.Usuario" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.app.whiteboard.model.dtos.DocenteEnLista" %>
<%@ page import="com.app.whiteboard.model.dtos.EvaluacionEnLista" %>
<%@ page import="com.app.whiteboard.model.beans.Semestre" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%
    Usuario user = (Usuario) session.getAttribute("usuario");
    if (user!= null && request.getSession(false) != null && user.getIdRol() == 4){
%>

<% ArrayList<EvaluacionEnLista> evaluacionesList = (ArrayList<EvaluacionEnLista>) request.getAttribute("evaluacionesList"); %>
<% String idCurso = (String) request.getAttribute("idCurso"); %>
<% Semestre semestreActual = (Semestre) request.getAttribute("semestre"); %>

<!DOCTYPE html>
<html lang="es">
<head>
    <title>Evaluaciones | Whiteboard</title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport'/>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">    <link rel="icon" type="image/png" href="favicon.png"/>

    <!-- DataTables -->
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.css">
    <script type="text/javascript" charset="utf8" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.js"></script>
    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css?family=Playfair+Display:400,700|Source+Sans+Pro:400,600,700" rel="stylesheet">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
    <script src="https://kit.fontawesome.com/9f54847310.js" crossorigin="anonymous"></script>
    <!-- Main CSS -->
    <link href="resources/css/main.css" rel="stylesheet"/>



</head>


<body>


<nav class="topnav navbar navbar-expand-lg navbar-light bg-no-white fixed-top">
    <div class="container">
        <div>
            <img src="favicon.png" width="50px" height="auto" alt="logo" style="padding-right: 10px; padding-bottom: 5px">
            <a class="navbar-brand" href="docente?action=home" style="letter-spacing: 3px;"><strong>WHITEBOARD</strong></a>
        </div>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarColor02" aria-controls="navbarColor02" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="navbar-collapse collapse" id="navbarColor02" style="">
            <ul class="navbar-nav mr-auto d-flex align-items-center">

                <li class="nav-item">
                    <a class="nav-link" href="docente?action=home">Inicio</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="docente?action=evaluaciones">Evaluaciones</a>
                </li>

            </ul>
            <ul class="navbar-nav ml-auto d-flex align-items-center">
                <li>
                    <strong><a class="nav-link" href="logout">Cerrar Sesión</a></strong>
                </li>
            </ul>
        </div>
    </div>
</nav>



<div class="container">

    <div class="row mt-5 pb-1">
        <div class="col-md-8">
            <h2 class="h3 font-weight-bold pb-1">
                Registrar nueva Nota
            </h2>

            <p>Los nuevos registros se harán sobre el semestre actual: <%=semestreActual.getNombre()%></p>
        </div>
    </div>
    <hr style="padding-top:0;margin-top:0;">

    <div class="pt-0 pb-0 position-relative">
        <div class="p-2 h-100 tofront">
            <div class="row">
                <form class="form-inline" method="POST" action="docente?action=new_evaluaciones">
                    <input type="hidden" name="idCurso" value="<%=idCurso%>">
                    <div class="col">
                        <input required type="text" class="form-control mb-2 mr-sm-2" name="nombre" placeholder="Nombre y Apellido">
                    </div>
                    <div class="col">
                        <input required type="text" class="form-control mb-2 mr-sm-2" name="codigo" placeholder="Código">
                    </div>
                    <div class="col">
                        <input required type="text" class="form-control mb-2 mr-sm-2" name="correo" placeholder="Correo">
                    </div>
                    <div class="col">
                        <input required type="text" class="form-control mb-2 mr-sm-2" name="nota" placeholder="Nota">
                    </div>
                    <div class="col">
                        <button type="submit" class="btn btn-primary mb-2">Crear</button>
                        <a href="docente?action=evaluaciones" class="btn btn-gray mb-2 ml-md-2">Cancelar</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <hr>
</div>


<div class="pt-4"></div>

<div class="container">

    <div class="row pb-1">
        <div class="col-md-6">
            <h2 class="h3 font-weight-bold pb-1">
                Lista de Notas del Curso
            </h2>
        </div>
    </div>
    <hr>

    <div class="pt-2 pb-0 position-relative">
        <div class="p-2 h-100 tofront">
            <div class="row justify-content-between">

                <div class="table-container">
                    <table class="table table-hover align-self-center table-bordered" id="evaluaciones_table">


                        <thead>
                        <tr>
                            <th scope="col">ID</th>
                            <th scope="col">Semestre</th>
                            <th scope="col">Nombre</th>
                            <th scope="col">Código</th>
                            <th scope="col">Correo</th>
                            <th scope="col">Nota</th>
                            <th scope="col">Fecha Creación</th>
                            <th scope="col">Fecha Edición</th>
                            <th scope="col">Editar</th>
                            <th scope="col">Borrar</th>
                        </tr>
                        </thead>

                        <tbody>

                        <% if (evaluacionesList.isEmpty() || evaluacionesList.get(0).getNombreEstudiantes() == null) { %>

                        <tr>
                            <td colspan="10">No hay evaluaciones registradas para este curso.</td>
                        </tr>

                        <% } else { %>

                        <%int i = 1;%>
                        <% for (EvaluacionEnLista evaluacion : evaluacionesList) { %>

                        <tr>
                            <td><%=i%></td>
                            <td><%=evaluacion.getSemestre().getNombre()%></td>
                            <td><%=evaluacion.getNombreEstudiantes()%></td>
                            <td><%=evaluacion.getCodigoEstudiantes()%></td>
                            <td><%=evaluacion.getCorreoEstudiantes()%></td>
                            <td><%=evaluacion.getNota()%></td>

                            <td>
                                <% if (evaluacion.getFechaRegistro() != null) {
                                    java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
                                    String formattedDate = dateFormat.format(evaluacion.getFechaRegistro());
                                %>
                                <%= formattedDate %>
                                <% } %>
                            </td>

                            <td>
                                <% if (evaluacion.getFechaEdicion() != null) {
                                    java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
                                    String formattedDate = dateFormat.format(evaluacion.getFechaEdicion());
                                %>
                                <%= formattedDate %>
                                <% } %>
                            </td>

                            <td class="text-center">
                                <a href="docente?action=edit_evaluaciones&id=<%=evaluacion.getIdEvaluaciones()%>&curso=<%=idCurso%>" class="btn btn-success">
                                    <i class="fa-solid fa-pen-to-square" style="color: #ffffff;"></i>
                                </a>
                            </td>

                            <%if(evaluacion.getSemestre().getIdSemestre() == semestreActual.getIdSemestre()){%>

                            <td class="text-center">
                                <a href="#" class="btn btn-danger btn-borrar" data-evaluacion-id="<%=evaluacion.getIdEvaluaciones()%>">
                                    <i class="fa-solid fa-xmark" style="color: #ffffff;"></i>
                                </a>
                            </td>

                            <%} else {%>

                            <td class="text-center">
                                <a href="#" class="btn btn-danger">
                                    <i class="fa-solid fa-xmark" style="color: #ffffff;"></i>
                                </a>
                            </td>

                            <%}%>

                        </tr>
                        <% i++; } %>

                        <% } %>

                        </tbody>

                    </table>
                </div>


            </div>
        </div>
    </div>
</div>


<div class="container mt-1">
    <footer class="bg-white border-top p-3 text-muted small">
        <div class="row align-items-center justify-content-between">
            <div>
                <span class="navbar-brand mr-2"><strong>Whiteboard</strong></span> Copyright &copy;
                <script>document.write(new Date().getFullYear())</script>
                . Todos los derechos reservados.
            </div>
        </div>
    </footer>
</div>




<!-- PopUp para confirmar borrado de docentes sin cursos -->
<div class="modal fade" id="confirmarBorradoModal" tabindex="-1" aria-labelledby="confirmarBorradoModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="confirmarBorradoModalLabel">Confirmar Borrado</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                ¿Está seguro de que desea borrar este registro?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-gray" data-bs-dismiss="modal">Cancelar</button>
                <form id="confirmarBorradoForm" method="POST" action="docente?action=borrar_evaluacion">
                    <input type="hidden" name="idCurso" value="<%=idCurso%>">
                    <input type="hidden" name="idDocenteBorrar" id="evaluacionIdInput" value="">
                    <button type="submit" class="btn btn-danger" id="confirmarBorradoBtn">Borrar</button>
                </form>
            </div>
        </div>
    </div>
</div>


<script>
    $(document).ready(function() {
        var table = $('#evaluaciones_table').DataTable();

        $('.btn-borrar').click(function() {
            var docenteId = $(this).data('evaluacion-id');

            $('#evaluacionIdInput').val(docenteId);
            $('#confirmarBorradoModal').modal('show');

        });
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
<script src="resources/js/main/popper.min.js" type="text/javascript"></script>
<script src="resources/js/main/functions.js" type="text/javascript"></script>

</body>
</html>

<% } else {request.getRequestDispatcher("/logout").forward(request, response);}%>