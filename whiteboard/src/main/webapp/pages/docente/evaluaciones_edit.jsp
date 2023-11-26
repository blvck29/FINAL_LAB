<%@ page import="com.app.whiteboard.model.beans.Usuario" %>
<%@ page import="com.app.whiteboard.model.dtos.EvaluacionEnLista" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%
    Usuario user = (Usuario) session.getAttribute("usuario");
    if (user!= null && request.getSession(false) != null && user.getIdRol() == 4){
%>

<% EvaluacionEnLista evaluacion = (EvaluacionEnLista) request.getAttribute("evaluacion"); %>
<% String idCurso = (String) request.getAttribute("idCurso"); %>

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

<div class="pt-4"></div>

<div class="container">

    <div class="row mt-4 pb-1">
        <div class="col-md-6">
            <h2 class="h3 font-weight-bold pb-1">
                Editar Evaluación
            </h2>
        </div>
    </div>
    <hr>

    <div class="pt-2 pb-0 position-relative">
        <div class="p-2 h-100 tofront">
            <div class="row">
                <form class="form-inline" method="POST" action="docente?action=edit_evaluaciones">
                    <input type="hidden" name="idCurso" value="<%=idCurso%>">
                    <input type="hidden" name="idEvaluacionEdit" value="<%=evaluacion.getIdEvaluaciones()%>">
                    <div class="col">
                        <input required type="text" class="form-control mb-2 mr-sm-2" name="nombre" value="<%=evaluacion.getNombreEstudiantes()%>">
                    </div>
                    <div class="col">
                        <input required type="text" class="form-control mb-2 mr-sm-2" name="codigo" value="<%=evaluacion.getCodigoEstudiantes()%>">
                    </div>
                    <div class="col">
                        <input required type="text" class="form-control mb-2 mr-sm-2" name="correo" value="<%=evaluacion.getCorreoEstudiantes()%>">
                    </div>
                    <div class="col">
                        <input required type="text" class="form-control mb-2 mr-sm-2" name="nota" value="<%=evaluacion.getNota()%>">
                    </div>
                    <div class="col">
                        <button type="submit" class="btn btn-primary mb-2">Guardar</button>
                        <a href="docente?action=list_evaluacion&id=<%=idCurso%>" class="btn btn-gray mb-2 ml-md-2">Cancelar</a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div class="row pt-2">
        <div class="col-md-4">
            <p>Última edición:
                <% String fEdit = null;
                    if (evaluacion.getFechaEdicion() != null) {
                        java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
                        fEdit = dateFormat.format(evaluacion.getFechaEdicion());
                    } else { fEdit = "Nunca editado"; } %>
                <%=fEdit%>
            </p>
        </div>

        <div class="col-md-4">
            <p>Fecha de Creación:
                <% String fCreation = null;
                    if (evaluacion.getFechaRegistro() != null) {
                        java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
                        fCreation = dateFormat.format(evaluacion.getFechaRegistro());
                    } else { fCreation = " "; }%>
                <%=fCreation%>
            </p>
        </div>
    </div>

    <hr>
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



<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
<script src="resources/js/main/popper.min.js" type="text/javascript"></script>
<script src="resources/js/main/functions.js" type="text/javascript"></script>



</body>
</html>

<% } else {request.getRequestDispatcher("/logout").forward(request, response);}%>