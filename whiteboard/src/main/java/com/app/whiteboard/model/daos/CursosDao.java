package com.app.whiteboard.model.daos;

import com.app.whiteboard.SHA256;
import com.app.whiteboard.model.beans.Curso;
import com.app.whiteboard.model.beans.Facultad;
import com.app.whiteboard.model.beans.Usuario;
import com.app.whiteboard.model.dtos.CursoEnLista;
import com.app.whiteboard.model.dtos.DocenteEnLista;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class CursosDao extends DaoBase {


    public ArrayList<CursoEnLista> listCursos(Facultad facultad) {

        ArrayList<CursoEnLista> listaCursos = new ArrayList<>();

        String sql = "SELECT c.idcurso, c.codigo, c.nombre, c.fecha_edicion, c.fecha_registro, COUNT(u.idusuario) AS cantidad_docentes, COALESCE(COUNT(ev.idcurso), 0) AS cantidad_evaluaciones FROM curso c \n" +
                "INNER JOIN curso_has_docente c_d ON (c_d.idcurso = c.idcurso)\n" +
                "INNER JOIN usuario u ON (u.idusuario = c_d.iddocente)\n" +
                "LEFT JOIN evaluaciones ev ON (ev.idcurso = c.idcurso)\n" +
                "WHERE c.idfacultad = ? GROUP BY c.idcurso, c.nombre, c.fecha_registro ORDER BY c.nombre;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, facultad.getIdFacultad());

            try (ResultSet rs = pstmt.executeQuery()) {

                while (rs.next()) {
                    CursoEnLista curso = new CursoEnLista();

                    curso.setIdCurso(rs.getInt(1));
                    curso.setCodigo(rs.getString(2));
                    curso.setNombre(rs.getString(3));
                    curso.setFechaEdicion(rs.getTimestamp(4));
                    curso.setFechaRegistro(rs.getTimestamp(5));
                    curso.setCantDocentes(rs.getInt(6));
                    curso.setCantEvaluaciones(rs.getInt(7));

                    listaCursos.add(curso);
                }

            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return listaCursos;
    }


    public CursoEnLista findCurso(String idCurso){

        CursoEnLista curso = new CursoEnLista();

        String sql = "SELECT c.idcurso, c.codigo, c.nombre, c.fecha_edicion, c.fecha_registro, COUNT(u.idusuario) AS cantidad_docentes, COALESCE(COUNT(ev.idcurso), 0) AS cantidad_evaluaciones FROM curso c \n" +
                "INNER JOIN curso_has_docente c_d ON (c_d.idcurso = c.idcurso)\n" +
                "INNER JOIN usuario u ON (u.idusuario = c_d.iddocente)\n" +
                "LEFT JOIN evaluaciones ev ON (ev.idcurso = c.idcurso)\n" +
                "WHERE c.idcurso = ? GROUP BY c.idcurso, c.nombre, c.fecha_registro;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, idCurso);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    curso.setIdCurso(rs.getInt(1));
                    curso.setCodigo(rs.getString(2));
                    curso.setNombre(rs.getString(3));
                    curso.setFechaEdicion(rs.getTimestamp(4));
                    curso.setFechaRegistro(rs.getTimestamp(5));
                    curso.setCantDocentes(rs.getInt(6));
                    curso.setCantEvaluaciones(rs.getInt(7));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return curso;
    }


    public ArrayList<DocenteEnLista> docentesOfCurso(String idCurso) {

        ArrayList<DocenteEnLista> listDocentes = new ArrayList<>();

        String sql = "SELECT c.idcurso, u.idusuario, u.nombre, u.correo, u.ultimo_ingreso, u.fecha_edicion, u.fecha_registro, u.cantidad_ingresos FROM curso c \n" +
                "INNER JOIN curso_has_docente c_d ON (c_d.idcurso = c.idcurso)\n" +
                "INNER JOIN usuario u ON (u.idusuario = c_d.iddocente)\n" +
                "LEFT JOIN evaluaciones ev ON (ev.idcurso = c.idcurso)\n" +
                "WHERE c.idcurso = ?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, idCurso);

            try (ResultSet rs = pstmt.executeQuery()) {

                while (rs.next()) {
                    DocenteEnLista docente = new DocenteEnLista();

                    docente.setIdDocente(rs.getInt(2));
                    docente.setNombre(rs.getString(3));
                    docente.setCorreo(rs.getString(4));
                    docente.setUltimoIngreso(rs.getTimestamp(5));
                    docente.setFechaEdicion(rs.getTimestamp(6));
                    docente.setFechaRegistro(rs.getTimestamp(7));
                    docente.setCantIngresos(rs.getInt(8));

                    listDocentes.add(docente);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return listDocentes;
    }



    public void newCurso(String codigo, String nombre, String idDocente, Facultad facultad){

        int idFacultad = facultad.getIdFacultad();

        int nuevoId = 1;

        String sql = "INSERT INTO `lab_9`.`curso` (`idcurso`, `codigo`, `nombre`, `idfacultad`) VALUES (?, ?, ?, ?);";

        try(Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)){

            if (obtenerUltimoID() > 0){
                nuevoId = obtenerUltimoID() +1;
            }

            pstmt.setInt(1, nuevoId);
            pstmt.setString(2, codigo);
            pstmt.setString(3, nombre);
            pstmt.setInt(4, idFacultad);

            pstmt.executeUpdate();
            cursoHasDocente(String.valueOf(nuevoId),idDocente);

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }


    public void cursoHasDocente(String idCurso, String idDocente){
        String sql = "INSERT INTO curso_has_docente (`idcurso`, `iddocente`) VALUES (?, ?)";
        try(Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)){

            pstmt.setString(1, idCurso);
            pstmt.setString(2, idDocente);

            pstmt.executeUpdate();
            updateDatesAtEdit(idCurso);

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void updateDatesAtEdit(String idCurso) {

        String sql = "UPDATE curso SET fecha_edicion = NOW() WHERE idcurso = ?;";

        try (Connection conn = this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, idCurso);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    public int obtenerUltimoID() {
        int ultimoID = -1;

        String sql = "SELECT MAX(idcurso) AS ultimo_id FROM curso;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            try (ResultSet rs = pstmt.executeQuery()) {

                if (rs.next()) {
                    ultimoID = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return ultimoID;
    }


    public void borrarCurso(String idBorrar){

        String sql = "DELETE FROM curso_has_docente WHERE idcurso = ?";
        try(Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1,idBorrar);
            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

}
