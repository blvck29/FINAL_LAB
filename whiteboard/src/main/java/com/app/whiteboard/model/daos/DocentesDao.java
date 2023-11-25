package com.app.whiteboard.model.daos;

import com.app.whiteboard.model.beans.Facultad;
import com.app.whiteboard.model.beans.Usuario;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class DocentesDao extends DaoBase {

    public ArrayList<Usuario> listDocentes(Facultad facultad) {

        ArrayList<Usuario> listaDocentes = new ArrayList<>();

        String sql = "SELECT u.*, c.*, f.* FROM usuario u LEFT JOIN curso_has_docente c_d ON (c_d.iddocente=u.idusuario) LEFT JOIN curso c ON (c.idcurso = c_d.idcurso) LEFT JOIN facultad f ON (c.idfacultad = ?) WHERE idrol = 4;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, facultad.getIdFacultad());

            try (ResultSet rs = pstmt.executeQuery()) {

                while (rs.next()) {
                    Usuario user = new Usuario();




                }

            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return listaDocentes;
    }

}
