/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.vzap.helpdeskprofe.servlets;

import com.vzap.helpdeskprofe.model.user.User;
import com.vzap.helpdeskprofe.restclients.AuthRestClient;
import jakarta.inject.Inject;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author rossb
 */
@WebServlet(name = "AuthServlet", urlPatterns = {"/AuthServlet"})
public class AuthServlet extends HttpServlet {

    private static final System.Logger LOG = System.getLogger(AuthServlet.class.getName());
    
    @Inject
    private AuthRestClient authClient;

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String submit = request.getParameter("submit");

        String forwardTo = switch (submit) {
            case "login" -> {
                User loggedIn = User.builder()
                        .email(request.getParameter("email"))
                        .fullName(request.getParameter("fullName"))
                        .passwordHash(request.getParameter("password"))
                        .build();
                try {
                    this.authClient.login(loggedIn, request);
                    yield "user-dashboard.jsp";
                } catch (IllegalArgumentException e) {
                    LOG.log(System.Logger.Level.ERROR, e);
                    yield "auth.jsp";
                }
            }
            case "register" -> {
                User created = User.builder()
                        .email(request.getParameter("email"))
                        .fullName(request.getParameter("fullName"))
                        .passwordHash(request.getParameter("password"))
                        .build();

                try {
                    created = authClient.register(created);
                    request.getSession(true).setAttribute("loggedIn", created);
                    yield "user-dashboard.jsp";
                } catch (IllegalArgumentException e) {
                    request.setAttribute("error", e.getMessage());
                    yield "auth.jsp";
                }
            }

            case "logout" -> {
                request.getSession().invalidate();
                yield "auth.jsp";
            }

            default ->
                "";
        };

        request.getRequestDispatcher(forwardTo).forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
