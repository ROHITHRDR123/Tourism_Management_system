package com.dcl.tours.daoImplClasses;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.dcl.tours.daoInterfaces.ImageDAO;
import com.dcl.tours.dto.Image;
import com.dcl.tours.utility.Connector;

public class ImageDAOImpl implements ImageDAO {

    Connection con = null;

    public ImageDAOImpl() {
        con = Connector.requestConnection();
    }

    @Override
    public void createImage(Image img) {

        String query = "INSERT INTO image VALUE(0,?,?)";

        try {
            PreparedStatement ps = con.prepareStatement(query);

            ps.setString(1, img.getUrl());
            ps.setInt(2, img.getLid());

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    @Override
    public void updateImage(Image img) {

        String query = "UPDATE image SET url = ?, lid = ? WHERE img_id = ?";

        try {
            PreparedStatement ps = con.prepareStatement(query);

            ps.setString(1, img.getUrl());
            ps.setInt(2, img.getLid());
            ps.setInt(3, img.getImg_id());

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
      
    }

    @Override
    public void deleteImage(Integer id) {

        String query = "DELETE FROM image WHERE img_id = ?";

        try {
            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1, id);

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    @Override
    public List<Image> getAllImage() {

        String query = "SELECT * FROM image";

        Image img = null;
        List<Image> imageList = new ArrayList<>();

        try {

            PreparedStatement ps = con.prepareStatement(query);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                img = new Image();

                img.setImg_id(rs.getInt("img_id"));
                img.setUrl(rs.getString("url"));
                img.setLid(rs.getInt("lid"));

                imageList.add(img);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return imageList;
    }

    @Override
    public List<Image> getImageById(Integer id) {

        String query = "SELECT * FROM image WHERE img_id = ?";

        Image img = null;
        List<Image> imageList = new ArrayList<>();

        try {

            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                img = new Image();

                img.setImg_id(rs.getInt("img_id"));
                img.setUrl(rs.getString("url"));
                img.setLid(rs.getInt("lid"));

                imageList.add(img);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return imageList;      
    }

}            

