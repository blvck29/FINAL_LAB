package com.app.whiteboard.controllers;

import com.app.whiteboard.model.beans.Facultad;
import com.app.whiteboard.model.beans.Universidad;
import com.app.whiteboard.model.beans.Usuario;
import com.app.whiteboard.model.daos.EvaluacionesDao;
import com.app.whiteboard.model.daos.UsuarioDao;
import com.app.whiteboard.model.dtos.CursoEnLista;
import com.app.whiteboard.model.dtos.DocenteEnLista;
import com.app.whiteboard.model.dtos.EvaluacionEnLista;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "DocenteServlet", value = "/docente")
public class DocenteServlet extends HttpServlet {

    UsuarioDao usuarioDao = new UsuarioDao();
    EvaluacionesDao evaluacionesDao = new EvaluacionesDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session.getAttribute("usuario") != null){
            Usuario user = (Usuario) session.getAttribute("usuario");
            if(user.getIdRol() == 4){

                String action = request.getParameter("action") == null? "home" : request.getParameter("action");

                Facultad facultad = usuarioDao.getFacultadDocente((Usuario) session.getAttribute("usuario"));

                switch (action) {

                    case "evaluaciones":
                        ArrayList<CursoEnLista> cursosDelDocente = evaluacionesDao.cursosOfDocente(user, facultad);
                        request.setAttribute("cursosDelDocente", cursosDelDocente);
                        request.getRequestDispatcher("pages/docente/evaluaciones.jsp").forward(request, response);
                        break;

                    case "list_evaluacion":
                        ArrayList<CursoEnLista> cursosValidos = evaluacionesDao.cursosOfDocente(user, facultad);
                        String idCurso = request.getParameter("id") == null? "null" : request.getParameter("id");

                        boolean valid = false;

                        for (CursoEnLista cursoValido : cursosValidos) {
                            if(cursoValido.getIdCurso() == Integer.parseInt(idCurso)){
                                valid = true;
                            }
                        }

                        if(valid){
                            ArrayList<EvaluacionEnLista> evaluacionesList = evaluacionesDao.totalList(idCurso);
                            request.setAttribute("evaluacionesList", evaluacionesList);
                            request.setAttribute("idCurso",idCurso);
                            request.getRequestDispatcher("pages/docente/evaluaciones_list.jsp").forward(request, response);
                        } else {
                            request.setAttribute("facultad", facultad);
                            request.getRequestDispatcher("pages/docente/home.jsp").forward(request, response);
                        }
                        break;

                    case "edit_evaluaciones":
                        String idEvaluacionesEdit = request.getParameter("id") == null? "null" : request.getParameter("id");
                        String idCursoEdit = request.getParameter("curso") == null? "null" : request.getParameter("curso");

                        if (idEvaluacionesEdit.equals("null") || idCursoEdit.equals("null")){
                            request.getRequestDispatcher("pages/docente/evaluaciones.jsp").forward(request, response);
                        } else {
                            EvaluacionEnLista evaluacion = evaluacionesDao.findEvaluacion(idEvaluacionesEdit);
                            request.setAttribute("evaluacion", evaluacion);
                            request.setAttribute("idCurso", idCursoEdit);
                            request.getRequestDispatcher("pages/docente/evaluaciones_edit.jsp").forward(request, response);
                        }
                        break;

                    case "home":
                        request.setAttribute("facultad", facultad);
                        request.getRequestDispatcher("pages/docente/home.jsp").forward(request, response);
                        break;
                }


            } else {
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
            if(user.getIdRol() == 4){

                String action = request.getParameter("action") == null? "home" : request.getParameter("action");

                Facultad facultad = usuarioDao.getFacultadDocente((Usuario) session.getAttribute("usuario"));

                switch (action) {

                    case "new_evaluaciones":
                        String nombre = request.getParameter("nombre");
                        String codigo = request.getParameter("codigo");
                        String correo = request.getParameter("correo");
                        String nota = request.getParameter("nota");
                        String idCurso = request.getParameter("idCurso");

                        evaluacionesDao.newEvaluacion(nombre,codigo,correo,nota,idCurso);

                        response.sendRedirect(request.getContextPath() + "/docente?action=list_evaluacion&id=" + idCurso);
                        break;

                    case "edit_evaluaciones":
                        String newNombre = request.getParameter("nombre");
                        String newCodigo = request.getParameter("codigo");
                        String newCorreo = request.getParameter("correo");
                        String newNota = request.getParameter("nota");
                        String idCurso2 = request.getParameter("idCurso");
                        String idEvaluacionEdit = request.getParameter("idEvaluacionEdit");

                        evaluacionesDao.editEvaluacion(newNombre,newCodigo,newCorreo,newNota,idEvaluacionEdit);

                        response.sendRedirect(request.getContextPath() + "/docente?action=list_evaluacion&id=" + idCurso2);
                        break;

                    case "borrar_evaluacion":
                        String idDocenteBorrar = request.getParameter("idDocenteBorrar");
                        String idCurso1 = request.getParameter("idCurso");
                        evaluacionesDao.borrarEvaluacion(idDocenteBorrar);
                        response.sendRedirect(request.getContextPath() + "/docente?action=list_evaluacion&id=" + idCurso1);
                        break;

                    case "home":
                        request.setAttribute("facultad", facultad);
                        request.getRequestDispatcher("pages/docente/home.jsp").forward(request, response);
                        break;
                }



            } else {
                session.invalidate();
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }
        } else {
            session.invalidate();
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }
}

