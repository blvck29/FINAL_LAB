package com.app.whiteboard.controllers;

import com.app.whiteboard.model.beans.Curso;
import com.app.whiteboard.model.beans.Facultad;
import com.app.whiteboard.model.beans.Usuario;
import com.app.whiteboard.model.daos.DocentesDao;
import com.app.whiteboard.model.daos.UsuarioDao;
import com.app.whiteboard.model.dtos.DocenteEnLista;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "DecanoServlet", value = "/decano")
public class DecanoServlet extends HttpServlet {

    UsuarioDao usuarioDao = new UsuarioDao();
    DocentesDao docentesDao = new DocentesDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session.getAttribute("usuario") != null){
            Usuario user = (Usuario) session.getAttribute("usuario");
            if(user.getIdRol() == 3){

                String action = request.getParameter("action") == null? "home" : request.getParameter("action");

                Facultad facultad = usuarioDao.getFacultad((Usuario) session.getAttribute("usuario"));

                switch (action){
                    case "home":

                        request.setAttribute("facultad", facultad);
                        request.getRequestDispatcher("pages/decano/home.jsp").forward(request, response);
                        break;

                    case "docentes":
                        ArrayList<DocenteEnLista> listDocentes = docentesDao.listDocentes(facultad);
                        request.setAttribute("listDocentes", listDocentes);
                        request.getRequestDispatcher("pages/decano/docentes.jsp").forward(request, response);
                        break;

                    case "edit_docentes":

                        String id = request.getParameter("id") == null? "null" : request.getParameter("id");

                        if (id.equals("null")){
                            request.getRequestDispatcher("pages/decano/docentes.jsp").forward(request, response);
                        } else {
                            DocenteEnLista docente = docentesDao.findDocente(id, facultad);
                            ArrayList<Curso> cursosDelDocente = docentesDao.cursosOfDocente(id,facultad);
                            request.setAttribute("docente", docente);
                            request.setAttribute("cursosDelDocente", cursosDelDocente);
                            request.getRequestDispatcher("pages/decano/docentes_edit.jsp").forward(request, response);
                        }
                        break;

                    case "cursos":
                        request.getRequestDispatcher("pages/decano/cursos.jsp").forward(request, response);
                        break;
                }


            }else {
                session.invalidate();
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }
        } else {
            session.invalidate();
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session.getAttribute("usuario") != null){
            Usuario user = (Usuario) session.getAttribute("usuario");
            if(user.getIdRol() == 3){

                String action = request.getParameter("action") == null? "home" : request.getParameter("action");

                switch (action) {

                    case "new_docentes":
                        String nombre = request.getParameter("nombre");
                        String correo = request.getParameter("correo");
                        String password = request.getParameter("password");

                        docentesDao.newDocente(nombre,correo,password);

                        response.sendRedirect(request.getContextPath() + "/decano?action=docentes");
                        break;

                    case "edit_docentes":
                        String idEditar = request.getParameter("idEditar");
                        String nuevoNombre = request.getParameter("nombre");

                        docentesDao.editDocente(idEditar,nuevoNombre);

                        response.sendRedirect(request.getContextPath() + "/decano?action=docentes");
                        break;

                    case "borrar_docentes":
                        String idDocente = request.getParameter("idDocenteBorrar");
                        docentesDao.borrarDocente(idDocente);
                        response.sendRedirect(request.getContextPath() + "/decano?action=docentes");
                        break;

                    case "home":
                        response.sendRedirect(request.getContextPath() + "/decano");
                        break;
                }

            }else {
                session.invalidate();
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }
        } else {
            session.invalidate();
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }




    }
}

