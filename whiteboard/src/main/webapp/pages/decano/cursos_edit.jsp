<%@ page import="com.app.whiteboard.model.beans.Usuario" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.app.whiteboard.model.dtos.DocenteEnLista" %>
<%@ page import="com.app.whiteboard.model.beans.Curso" %>
<%@ page import="com.app.whiteboard.model.dtos.CursoEnLista" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%
    Usuario user = (Usuario) session.getAttribute("usuario");
    if (user!= null && request.getSession(false) != null && user.getIdRol() == 3){
%>

<% CursoEnLista curso = (CursoEnLista) request.getAttribute("curso"); %>
<% ArrayList<DocenteEnLista> docentesDelCurso = (ArrayList<DocenteEnLista>) request.getAttribute("docentesDelCurso"); %>

<!DOCTYPE html>
<html lang="es">
<head>
    <title>Docentes | Whiteboard</title>
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

<div class="pt-4"></div>

<div class="container">

    <div class="row mt-4 pb-1">
        <div class="col-md-6">
            <h2 class="h3 font-weight-bold pb-1">
                Editar Docente
            </h2>
        </div>
    </div>
    <hr>

    <div class="pt-2 pb-0 position-relative">
        <div class="p-2 h-100 tofront">
            <div class="row">

                <form class="form-inline" method="POST" action="decano?action=edit_cursos">
                    <input type="hidden" name="idEditar" value="<%=curso.getIdCurso()%>">

                    <div class="row col-md-6">
                        <div class="col-md-12 mb-2">
                            <label for="nombre" style="text-align: left; display: block;">Nombre</label>
                            <input type="text" class="form-control-color" style="width: 30rem !important;" name="nombre" id="nombre" value="<%=curso.getNombre()%>">
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-2">
                            <label for="codigo" style="text-align: left; display: block;">Código</label>
                            <input disabled required type="text" class="form-control" name="codigo" id="codigo" value="<%=curso.getCodigo()%>">
                        </div>

                        <div class="col-md-6">
                            <div class="row">
                                <div class="col-md-6">
                                    <button type="submit" class="btn btn-primary btn-block mb-2">Guardar</button>
                                </div>
                                <div class="col-md-6">
                                    <a href="decano?action=cursos" class="btn btn-gray btn-block">Cancelar</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>

            </div>
        </div>
    </div>

    <div class="row pt-2">
        <div class="col-md-4">
            <p>Última edición:
                <% String fEdit = null;
                    if (curso.getFechaEdicion() != null) {
                        java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
                        fEdit = dateFormat.format(curso.getFechaEdicion());
                    } else { fEdit = "Nunca editado"; } %>
                <%=fEdit%>
            </p>
        </div>

        <div class="col-md-4">
            <p>Fecha de Creación:
                <% String fCreation = null;
                    if (curso.getFechaRegistro() != null) {
                        java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
                        fCreation = dateFormat.format(curso.getFechaRegistro());
                    } else { fCreation = " "; }%>
                <%=fCreation%>
            </p>
        </div>

        <div class="col-md-4">
            <p>Evaluaciones:
                <% String value = null;
                    if (curso.getCantEvaluaciones() > 0) {
                        int cantLogins = curso.getCantEvaluaciones();
                        value = String.valueOf(cantLogins) + " evaluaciones";
                    } else { value = "Ninguna"; }%>
                <%=value%>
            </p>
        </div>
    </div>

    <hr>



    <div class="pt-2 pb-0 position-relative">
        <div class="p-2 h-100 tofront">
            <div class="row justify-content-between">

                <div class="table-container">
                    <table class="table table-hover align-self-center table-bordered" id="cursos_table">


                        <thead>
                        <tr>
                            <th scope="col">ID</th>
                            <th scope="col">Docente</th>
                            <th scope="col">Fecha de Asignación</th>
                            <th scope="col">Última Modificación</th>


                        </tr>
                        </thead>

                        <tbody>

                        <% if (docentesDelCurso.isEmpty() || docentesDelCurso.get(0).getNombre() == null) { %>

                        <tr>
                            <td colspan="4">No hay docentes asignados a este curso.</td> <!-- Nunca sucede porque el curso debe tener un docente mínimo -->
                        </tr>

                        <% } else { %>

                        <%int i = 1;%>
                        <% for (DocenteEnLista docente : docentesDelCurso) { %>

                        <tr>
                            <td><%=i%></td>
                            <td><%=docente.getNombre()%></td>

                            <td>
                                <% if (docente.getFechaRegistro() != null) {
                                    java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
                                    String formattedDate = dateFormat.format(docente.getFechaRegistro());
                                %>
                                <%= formattedDate %>
                                <% } %>
                            </td>

                            <td>
                                <% if (docente.getFechaEdicion() != null) {
                                    java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
                                    String formattedDate = dateFormat.format(docente.getFechaEdicion());
                                %>
                                <%= formattedDate %>
                                <% } %>
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
        $('#cursos_table').DataTable();
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
<script src="resources/js/main/popper.min.js" type="text/javascript"></script>
<script src="resources/js/main/functions.js" type="text/javascript"></script>



</body>
</html>

<% } else {request.getRequestDispatcher("/logout").forward(request, response);}%>