package com.app.whiteboard.controllers;

import com.app.whiteboard.model.beans.Usuario;
import com.app.whiteboard.model.daos.UsuarioDao;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "LoginServlet", value = "/login")
public class LoginServlet extends HttpServlet {

    UsuarioDao usuarioDao = new UsuarioDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action") == null? "login" : request.getParameter("action");
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action") == null? "login" : request.getParameter("action");

        switch (action){
            case "auth":

                String email = request.getParameter("email");
                String password = request.getParameter("password");

                if (usuarioDao.login(email,password)){

                    Usuario user = usuarioDao.findUser(email,password);

                    HttpSession session = request.getSession();
                    session.setAttribute("usuario", user);

                    session.setMaxInactiveInterval(1800); // 30 minutos

                    int idRol = user.getIdRol();

                    switch (idRol){
                        case 1: // Administrador
                            break;

                        case 2: // Rector
                            break;

                        case 3: // Decano
                            response.sendRedirect("decano");
                            break;

                        case 4: // Docente
                            response.sendRedirect("docente");
                            break;
                    }

                } else {
                    response.sendRedirect("login");
                }

                break;
        }


    }
}

