package com.dcl.tours.daoInterfaces;

import java.util.List;

import com.dcl.tours.dto.Image;

public interface ImageDAO {

	    void createImage(Image img);

	    void updateImage(Image img);

	    void deleteImage(Integer id);

	    List<Image> getAllImage();

	    List<Image> getImageById(Integer id);

	}


