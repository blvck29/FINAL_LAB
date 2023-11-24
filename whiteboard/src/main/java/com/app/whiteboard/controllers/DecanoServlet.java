package com.app.whiteboard.controllers;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "DecanoServlet", value = "/decano")
public class DecanoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session.getAttribute("usuario") != null){

            String action = request.getParameter("action") == null? "home" : request.getParameter("action");

            switch (action){
                case "home":
                    request.getRequestDispatcher("pages/decano/home.jsp").forward(request, response);
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

