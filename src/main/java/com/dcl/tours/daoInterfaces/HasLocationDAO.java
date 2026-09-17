package com.dcl.tours.daoInterfaces;

import java.util.List;
import com.dcl.tours.dto.HasLocation;

public interface HasLocationDAO {

    void createHasLocation(HasLocation hl);

    void updateHasLocation(HasLocation hl);

    void deleteHasLocation(Integer id);

    List<HasLocation> getAllHasLocation();

    List<HasLocation> getHasLocationById(Integer id);
}