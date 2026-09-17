package com.dcl.tours.servlet;

import java.io.IOException;

import com.dcl.tours.daoImplClasses.PackageDAOImpl;
import com.dcl.tours.daoInterfaces.PackageDAO;
import com.dcl.tours.dto.Package;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/UpdatePackageServlet")
public class UpdatePackageServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        int pid = Integer.parseInt(request.getParameter("pid"));
        String pname = request.getParameter("pname");
        double price = Double.parseDouble(request.getParameter("price"));
        int days = Integer.parseInt(request.getParameter("days"));

        Package p = new Package();
        p.setPid(pid);
        p.setPname(pname);
        p.setPrice(price);
        p.setNo_of_days(days);

        PackageDAO dao = new PackageDAOImpl();
        dao.updatePackage(p);

        response.sendRedirect("admin");
    }
}