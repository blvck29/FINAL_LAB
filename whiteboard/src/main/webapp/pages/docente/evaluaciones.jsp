<%@ page import="com.app.whiteboard.model.beans.Usuario" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.app.whiteboard.model.dtos.DocenteEnLista" %>
<%@ page import="com.app.whiteboard.model.dtos.CursoEnLista" %>
<%@ page import="com.app.whiteboard.model.beans.Curso" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%
    Usuario user = (Usuario) session.getAttribute("usuario");
    if (user!= null && request.getSession(false) != null && user.getIdRol() == 4){
%>

<% ArrayList<CursoEnLista> cursosDelDocente = (ArrayList<CursoEnLista>) request.getAttribute("cursosDelDocente"); %>

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

    <div class="row pb-1">
        <div class="col-md-6">
            <h2 class="h3 font-weight-bold pb-1">
                Elija un Curso para continuar
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
                            <th scope="col">Curso</th>
                            <th scope="col">Fecha de Asignación</th>
                            <th scope="col">Última Modificación</th>
                            <th scope="col">Editar</th>

                        </tr>
                        </thead>

                        <tbody>

                        <% if (cursosDelDocente.isEmpty() || cursosDelDocente.get(0).getNombre() == null) { %>

                        <tr>
                            <td colspan="9">No hay evaluaciones registradas para este curso.</td>
                        </tr>

                        <% } else { %>


                        <%int i = 1;%>
                        <% for (CursoEnLista curso : cursosDelDocente) { %>

                        <tr>
                            <td><%=i%></td>

                            <td><%=curso.getCodigo()%> | <%=curso.getNombre()%></td>

                            <td>
                                <% if (curso.getFechaRegistro() != null) {
                                    java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
                                    String formattedDate = dateFormat.format(curso.getFechaRegistro());
                                %>
                                <%= formattedDate %>
                                <% } %>
                            </td>

                            <td>
                                <% if (curso.getFechaEdicion() != null) {
                                    java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
                                    String formattedDate = dateFormat.format(curso.getFechaEdicion());
                                %>
                                <%= formattedDate %>
                                <% } %>
                            </td>


                            <td class="text-center">
                                <a href="docente?action=list_evaluacion&id=<%=curso.getIdCurso()%>" class="btn btn-success">
                                    <i class="fa-solid fa-pen-to-square" style="color: #ffffff;"></i>
                                </a>
                            </td>


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



<script>
    $(document).ready(function() {
        var table = $('#evaluaciones_table').DataTable();
    });
</script>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
<script src="resources/js/main/popper.min.js" type="text/javascript"></script>
<script src="resources/js/main/functions.js" type="text/javascript"></script>

</body>
</html>

<% } else {request.getRequestDispatcher("/logout").forward(request, response);}%>