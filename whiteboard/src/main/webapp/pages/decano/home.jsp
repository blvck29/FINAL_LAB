<%@ page import="com.app.whiteboard.model.beans.Usuario" %>
<%@ page import="com.app.whiteboard.model.beans.Facultad" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%
    Usuario user = (Usuario) session.getAttribute("usuario");
    if (user!= null && request.getSession(false) != null && user.getIdRol() == 3){
%>

<% Facultad facultad = (Facultad) request.getAttribute("facultad"); %>

<!DOCTYPE html>
<html lang="es">
<head>
    <title>Home | Whiteboard</title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport'/>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">    <link rel="icon" type="image/png" href="favicon.png"/>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css?family=Playfair+Display:400,700|Source+Sans+Pro:400,600,700" rel="stylesheet">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
    <!-- Main CSS -->
    <link href="resources/css/main.css" rel="stylesheet"/>
</head>


<body>

<nav class="topnav navbar navbar-expand-lg navbar-light bg-no-white fixed-top">
    <div class="container">
        <div>
            <img src="favicon.png" width="50px" height="auto" alt="logo" style="padding-right: 10px; padding-bottom: 5px">
            <a class="navbar-brand" href="decano?action=home" style="letter-spacing: 3px;"><strong>WHITEBOARD</strong></a>
        </div>
        
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarColor02" aria-controls="navbarColor02" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="navbar-collapse collapse" id="navbarColor02" style="">
            <ul class="navbar-nav mr-auto d-flex align-items-center">

                <li class="nav-item">
                    <a class="nav-link" href="decano?action=home">Inicio</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="decano?action=docentes">Docentes</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="decano?action=cursos">Cursos</a>
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

<div class="pt-3"></div>


<div class="container">
    <div class="jumbotron jumbotron-fluid mb-1 pt-0 pb-0 bg-main position-relative">
        <div class="pl-4 pr-0 h-100 tofront">
            <div class="row justify-content-between">
                <div class="col-md-6 pt-6 pb-6 align-self-center">
                    <h1 class="mb-3 font-weight-bold">Bienvenido, Decano <%=user.getNombre()%></h1>
                    <p class="mb-3">
                        Aquí podrá gestionar a los docentes y cursos de su facultad asignada.
                    </p>
                    <strong><p class="mb-1">Universidad: <%= facultad.getUniversidad().getNombre()%></p></strong>
                    <strong><p class="mb-3">Facultad: <%= facultad.getNombre()%></p></strong>
                </div>
                <div class="col-md-6 d-none d-md-block pr-0" style="background-size:cover;background-image:url('resources/images/img1.jpg');">	</div>
            </div>
        </div>
    </div>
</div>



<div class="container pt-3 pb-0">
    <hr>
    <div class="row">

        <div class="row pb-3">
            <div class="col-md-6">
                <h2 class="h3 font-weight-bold pb-3">
                    Cursos recientemente agregados
                </h2>
            </div>
            <div class="col-md-6 text-right">
                <a href="decano?action=cursos" class="btn btn-gray">→ Ver todos los cursos</a>
            </div>
        </div>

        <div class="col-lg-6">
            <div class="flex-md-row mb-1 box-shadow h-xl-300">

                <% for (int i = 0; i < 3; i++) {%>

                <div class="mb-3 d-flex align-items-center">
                    <img height="80" src="<%=facultad.getUniversidad().getLogoUrl()%>">
                    <div class="pl-3">
                        <h2 class="mb-2 h6 font-weight-bold">
                            CURSO: Teoría de Campos Electromagnéticos <span class="badge badge-secondary">TEL</span>
                        </h2>
                        <div class="card-text text-muted small">
                            Docente del curso:
                        </div>
                        <small class="text-muted"> Creado: Dec 12 2023</small>
                    </div>
                </div>

                <%}%>

            </div>
        </div>
        <div class="col-lg-6">
            <div class="flex-md-row mb-1 box-shadow h-xl-300">

                <% for (int i = 0; i < 3; i++) {%>

                <div class="mb-3 d-flex align-items-center">
                    <img height="80" src="<%=facultad.getUniversidad().getLogoUrl()%>">
                    <div class="pl-3">
                        <h2 class="mb-2 h6 font-weight-bold">
                            CURSO: Teoría de Campos Electromagnéticos <span class="badge badge-secondary">TEL</span>
                        </h2>
                        <div class="card-text text-muted small">
                            Docente del curso:
                        </div>
                        <small class="text-muted"> Creado: Dec 12 2023</small>
                    </div>
                </div>

                <%}%>

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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>

<script src="resources/js/main/jquery.min.js" type="text/javascript"></script>
<script src="resources/js/main/popper.min.js" type="text/javascript"></script>
<script src="resources/js/main/functions.js" type="text/javascript"></script>


</body>
</html>

<% } else {request.getRequestDispatcher("/logout").forward(request, response);}%>