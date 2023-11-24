package com.app.whiteboard.controllers;

import com.app.whiteboard.model.beans.Facultad;
import com.app.whiteboard.model.beans.Usuario;
import com.app.whiteboard.model.daos.UsuarioDao;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "DecanoServlet", value = "/decano")
public class DecanoServlet extends HttpServlet {

    UsuarioDao usuarioDao = new UsuarioDao();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session.getAttribute("usuario") != null){

            String action = request.getParameter("action") == null? "home" : request.getParameter("action");

            switch (action){
                case "home":
                    Facultad facultad = usuarioDao.getFacultad((Usuario) session.getAttribute("usuario"));
                    request.setAttribute("facultad", facultad);
                    request.getRequestDispatcher("pages/decano/home.jsp").forward(request, response);
                    break;

                case "docentes":
                    request.getRequestDispatcher("pages/decano/docentes.jsp").forward(request, response);

                    break;

                case "cursos":
                    request.getRequestDispatcher("pages/decano/cursos.jsp").forward(request, response);

                    break;
            }




        } else {
            session.invalidate();
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}

