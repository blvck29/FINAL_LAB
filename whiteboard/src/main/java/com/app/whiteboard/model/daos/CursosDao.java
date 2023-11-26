package com.app.whiteboard.model.daos;

import com.app.whiteboard.model.beans.Facultad;
import com.app.whiteboard.model.dtos.CursoEnLista;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class CursosDao extends DaoBase {


    public ArrayList<CursoEnLista> listCursos(Facultad facultad) {

        ArrayList<CursoEnLista> listaCursos = new ArrayList<>();

        String sql = "SELECT c.idcurso, c.codigo, c.nombre, c.fecha_edicion, c.fecha_registro, COUNT(u.idusuario) AS cantidad_docentes FROM curso c \n" +
                "INNER JOIN curso_has_docente c_d ON (c_d.idcurso = c.idcurso)\n" +
                "INNER JOIN usuario u ON (u.idusuario = c_d.iddocente)\n" +
                "WHERE c.idfacultad = 1 GROUP BY c.idcurso, c.nombre, c.fecha_registro ORDER BY c.nombre;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, facultad.getIdFacultad());

            try (ResultSet rs = pstmt.executeQuery()) {

                while (rs.next()) {
                    CursoEnLista curso = new CursoEnLista();

                    curso.setIdCurso(rs.getInt(1));
                    curso.setCodigo(rs.getString(2));

                    listaCursos.add(curso);
                }

            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return listaCursos;
    }

}
