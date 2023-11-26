package com.app.whiteboard.model.daos;

import com.app.whiteboard.SHA256;
import com.app.whiteboard.model.beans.Curso;
import com.app.whiteboard.model.beans.Facultad;
import com.app.whiteboard.model.beans.Usuario;
import com.app.whiteboard.model.dtos.DocenteEnLista;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class DocentesDao extends DaoBase {

    public ArrayList<DocenteEnLista> listDocentes(Facultad facultad) {

        ArrayList<DocenteEnLista> listaDocentes = new ArrayList<>();

        String sql = "SELECT u.idusuario, u.nombre, u.correo, u.ultimo_ingreso, u.fecha_edicion, u.fecha_registro, u.cantidad_ingresos ,COALESCE(COUNT(c.idcurso), 0) AS cantidad_cursos FROM usuario u\n" +
                    "LEFT JOIN curso_has_docente c_d ON (u.idusuario = c_d.iddocente)\n" +
                    "LEFT JOIN curso c ON (c_d.idcurso = c.idcurso AND c.idfacultad = ?)\n" +
                    "LEFT JOIN facultad f ON (c.idfacultad = f.idfacultad)\n" +
                    "WHERE u.idrol = 4 GROUP BY u.idusuario, u.nombre, u.correo, u.ultimo_ingreso ORDER BY u.nombre;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, facultad.getIdFacultad());

            try (ResultSet rs = pstmt.executeQuery()) {

                while (rs.next()) {
                    DocenteEnLista docente = new DocenteEnLista();

                    docente.setIdDocente(rs.getInt(1));
                    docente.setNombre(rs.getString(2));
                    docente.setCorreo(rs.getString(3));
                    docente.setUltimoIngreso(rs.getTimestamp(4));
                    docente.setFechaEdicion(rs.getTimestamp(5));
                    docente.setFechaRegistro(rs.getTimestamp(6));
                    docente.setCantIngresos(rs.getInt(7));
                    docente.setCantCursos(rs.getInt(8));

                    listaDocentes.add(docente);
                }

            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return listaDocentes;
    }


    public DocenteEnLista findDocente(String idDocente, Facultad facultad){

        DocenteEnLista docente = new DocenteEnLista();

        String sql = "SELECT u.idusuario, u.nombre, u.correo, u.ultimo_ingreso, u.fecha_edicion, u.fecha_registro, u.cantidad_ingresos, COALESCE(COUNT(c.idcurso), 0) AS cantidad_cursos FROM usuario u\n" +
                "LEFT JOIN curso_has_docente c_d ON (u.idusuario = c_d.iddocente)\n" +
                "LEFT JOIN curso c ON (c_d.idcurso = c.idcurso AND c.idfacultad = ?)\n" +
                "LEFT JOIN facultad f ON (c.idfacultad = f.idfacultad)\n" +
                "WHERE u.idusuario = ? GROUP BY u.idusuario, u.nombre, u.correo, u.ultimo_ingreso;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, facultad.getIdFacultad());
            pstmt.setString(2, idDocente);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    docente.setIdDocente(rs.getInt(1));
                    docente.setNombre(rs.getString(2));
                    docente.setCorreo(rs.getString(3));
                    docente.setUltimoIngreso(rs.getTimestamp(4));
                    docente.setFechaEdicion(rs.getTimestamp(5));
                    docente.setFechaRegistro(rs.getTimestamp(6));
                    docente.setCantIngresos(rs.getInt(7));
                    docente.setCantCursos(rs.getInt(8));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return docente;
    }


    public ArrayList<Curso> cursosOfDocente(String idDocente,Facultad facultad) {

        ArrayList<Curso> listCursos = new ArrayList<>();

        String sql = "SELECT u.idusuario, c.idcurso, c.codigo, c.nombre, c.fecha_registro, c.fecha_edicion FROM usuario u\n" +
                "LEFT JOIN curso_has_docente c_d ON (u.idusuario = c_d.iddocente)\n" +
                "LEFT JOIN curso c ON (c_d.idcurso = c.idcurso AND c.idfacultad = ?)\n" +
                "LEFT JOIN facultad f ON (c.idfacultad = f.idfacultad)\n" +
                "WHERE u.idusuario = ?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, facultad.getIdFacultad());
            pstmt.setString(2, idDocente);

            try (ResultSet rs = pstmt.executeQuery()) {

                while (rs.next()) {
                    Curso curso = new Curso();

                    curso.setIdCurso(rs.getInt(2));
                    curso.setCodigo(rs.getString(3));
                    curso.setNombre(rs.getString(4));
                    curso.setFechaRegistro(rs.getTimestamp(5));
                    curso.setFechaEdicion(rs.getTimestamp(6));

                    listCursos.add(curso);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return listCursos;
    }


    public int obtenerUltimoID() {
        int ultimoID = -1;

        String sql = "SELECT MAX(idusuario) AS ultimo_id FROM usuario";

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


    public void updateDatesAtEdit(String idDocente) {

        String sql = "UPDATE usuario SET fecha_edicion = NOW() WHERE idusuario = ?;";

        try (Connection conn = this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, idDocente);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    public void newDocente(String nombre, String correo, String password){

        int nuevoId = 1;
        password = SHA256.cipherPassword(password);

        String sql = "INSERT INTO `lab_9`.`usuario` (`idusuario`, `nombre`, `correo`, `password`, `idrol`, `cantidad_ingresos`) VALUES (?, ?, ?, ?, '4', '0');";

        try(Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)){

            if (obtenerUltimoID() > 0){
                nuevoId = obtenerUltimoID() +1;
            }

            pstmt.setInt(1, nuevoId);
            pstmt.setString(2, nombre);
            pstmt.setString(3, correo);
            pstmt.setString(4, password);

            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }


    public void editDocente(String idEditar, String nuevoNombre){
        String sql = "UPDATE usuario SET nombre = ? WHERE (idusuario = ?)";
        try(Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1,nuevoNombre);
            pstmt.setString(2,idEditar);
            pstmt.executeUpdate();

            updateDatesAtEdit(idEditar);

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }


    public void borrarDocente(String idBorrar){

        String sql = "DELETE FROM usuario WHERE idusuario = ?";
        try(Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1,idBorrar);
            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

}
