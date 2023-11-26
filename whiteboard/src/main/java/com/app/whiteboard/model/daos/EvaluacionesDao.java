package com.app.whiteboard.model.daos;

import com.app.whiteboard.model.beans.Curso;
import com.app.whiteboard.model.beans.Facultad;
import com.app.whiteboard.model.beans.Semestre;
import com.app.whiteboard.model.beans.Usuario;
import com.app.whiteboard.model.dtos.CursoEnLista;
import com.app.whiteboard.model.dtos.DocenteEnLista;
import com.app.whiteboard.model.dtos.EvaluacionEnLista;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class EvaluacionesDao extends DaoBase {


    public ArrayList<EvaluacionEnLista> totalList(String idCurso){

        ArrayList<EvaluacionEnLista> totalList = new ArrayList<>();

        String sql = "SELECT ev.idevaluaciones, ev.nombre_estudiantes, ev.codigo_estudiantes, ev.correo_estudiantes, ev.nota, ev.idcurso, ev.idsemestre, ev.fecha_registro, ev.fecha_edicion FROM evaluaciones ev\n" +
                "LEFT JOIN semestre s ON (ev.idsemestre = s.idsemestre) LEFT JOIN curso c ON (ev.idcurso = c.idcurso) WHERE ev.idcurso = ?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, idCurso);

            try (ResultSet rs = pstmt.executeQuery()) {

                while (rs.next()) {
                    EvaluacionEnLista evaluacion = new EvaluacionEnLista();

                    evaluacion.setIdEvaluaciones(rs.getInt(1));
                    evaluacion.setNombreEstudiantes(rs.getString(2));
                    evaluacion.setCodigoEstudiantes(rs.getString(3));
                    evaluacion.setCorreoEstudiantes(rs.getString(4));
                    evaluacion.setNota(rs.getInt(5));
                    evaluacion.setCurso(getCurso(rs.getString(6)));
                    evaluacion.setSemestre(getSemestre(rs.getString(7)));
                    evaluacion.setFechaRegistro(rs.getTimestamp(8));
                    evaluacion.setFechaEdicion(rs.getTimestamp(9));

                    totalList.add(evaluacion);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return totalList;
    }


    public ArrayList<EvaluacionEnLista> filterBySemester(String idCurso, String idSemestre){

        ArrayList<EvaluacionEnLista> totalList = new ArrayList<>();

        String sql = "SELECT ev.idevaluaciones, ev.nombre_estudiantes, ev.codigo_estudiantes, ev.correo_estudiantes, ev.nota, ev.idcurso, ev.idsemestre, ev.fecha_registro, ev.fecha_edicion FROM evaluaciones ev\n" +
                "LEFT JOIN semestre s ON (ev.idsemestre = s.idsemestre) LEFT JOIN curso c ON (ev.idcurso = c.idcurso) WHERE ev.idcurso = ? AND ev.idsemestre = ?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, idCurso);
            pstmt.setString(2, idSemestre);

            try (ResultSet rs = pstmt.executeQuery()) {

                while (rs.next()) {
                    EvaluacionEnLista evaluacion = new EvaluacionEnLista();

                    evaluacion.setIdEvaluaciones(rs.getInt(1));
                    evaluacion.setNombreEstudiantes(rs.getString(2));
                    evaluacion.setCodigoEstudiantes(rs.getString(3));
                    evaluacion.setCorreoEstudiantes(rs.getString(4));
                    evaluacion.setNota(rs.getInt(5));
                    evaluacion.setCurso(getCurso(rs.getString(6)));
                    evaluacion.setSemestre(getSemestre(rs.getString(7)));
                    evaluacion.setFechaRegistro(rs.getTimestamp(8));
                    evaluacion.setFechaEdicion(rs.getTimestamp(9));

                    totalList.add(evaluacion);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return totalList;
    }


    public ArrayList<Semestre> listSemesters(){
        ArrayList<Semestre> listSemesters = new ArrayList<>();

        String sql = "SELECT * FROM lab_9.semestre;";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            try (ResultSet rs = pstmt.executeQuery()) {

                while (rs.next()) {
                    Semestre semestre = new Semestre();
                    semestre.setIdSemestre(rs.getInt(1));
                    semestre.setNombre(rs.getString(2));
                    listSemesters.add(semestre);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return listSemesters;
    }

    public EvaluacionEnLista findEvaluacion(String idEvaluacion){

        EvaluacionEnLista evaluacion = new EvaluacionEnLista();

        String sql = "SELECT ev.idevaluaciones, ev.nombre_estudiantes, ev.codigo_estudiantes, ev.correo_estudiantes, ev.nota, ev.idcurso, ev.idsemestre, ev.fecha_registro, ev.fecha_edicion FROM evaluaciones ev\n" +
                "LEFT JOIN semestre s ON (ev.idsemestre = s.idsemestre) LEFT JOIN curso c ON (ev.idcurso = c.idcurso) WHERE ev.idevaluaciones = ?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, idEvaluacion);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {

                    evaluacion.setIdEvaluaciones(rs.getInt(1));
                    evaluacion.setNombreEstudiantes(rs.getString(2));
                    evaluacion.setCodigoEstudiantes(rs.getString(3));
                    evaluacion.setCorreoEstudiantes(rs.getString(4));
                    evaluacion.setNota(rs.getInt(5));
                    evaluacion.setCurso(getCurso(rs.getString(6)));
                    evaluacion.setSemestre(getSemestre(rs.getString(7)));
                    evaluacion.setFechaRegistro(rs.getTimestamp(8));
                    evaluacion.setFechaEdicion(rs.getTimestamp(9));

                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return evaluacion;
    }


    public ArrayList<CursoEnLista> cursosOfDocente(Usuario user, Facultad facultad) {

        ArrayList<CursoEnLista> listCursos = new ArrayList<>();
        int idDocente = user.getIdUsuario();

        String sql = "SELECT u.idusuario, c.idcurso, c.codigo, c.nombre, c.fecha_registro, c.fecha_edicion FROM usuario u\n" +
                "LEFT JOIN curso_has_docente c_d ON (u.idusuario = c_d.iddocente)\n" +
                "LEFT JOIN curso c ON (c_d.idcurso = c.idcurso AND c.idfacultad = ?)\n" +
                "LEFT JOIN facultad f ON (c.idfacultad = f.idfacultad)\n" +
                "WHERE u.idusuario = ?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, facultad.getIdFacultad());
            pstmt.setInt(2, idDocente);

            try (ResultSet rs = pstmt.executeQuery()) {

                while (rs.next()) {
                    CursoEnLista curso = new CursoEnLista();

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


    public Curso getCurso(String idCurso){

        Curso curso = new Curso();

        String sql = "SELECT * FROM curso WHERE idcurso =?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)){

            pstmt.setString(1, idCurso);

            try(ResultSet rs = pstmt.executeQuery()){

                while(rs.next()){
                    curso.setIdCurso(rs.getInt(1));
                    curso.setCodigo(rs.getString(2));
                    curso.setNombre(rs.getString(3));
                    curso.setIdFacultad(rs.getInt(4));
                    curso.setFechaRegistro(rs.getTimestamp(5));
                    curso.setFechaEdicion(rs.getTimestamp(6));
                }
            }
        } catch (SQLException e){
            throw new RuntimeException(e);
        }

        return curso;
    }

    public Semestre getSemestre(String idSemestre){

        Semestre semestre = new Semestre();
        String sql = "SELECT * FROM semestre WHERE idsemestre =?;";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)){

            pstmt.setString(1, idSemestre);

            try(ResultSet rs = pstmt.executeQuery()){

                while(rs.next()){
                    semestre.setIdSemestre(rs.getInt(1));
                    semestre.setNombre(rs.getString(2));
                    semestre.setHabilitado(rs.getBoolean(4));
                    semestre.setFechaRegistro(rs.getTimestamp(5));
                    semestre.setFechaEdicion(rs.getTimestamp(6));
                }
            }
        } catch (SQLException e){
            throw new RuntimeException(e);
        }
        return semestre;
    }


    public Semestre getCurrentSemestre(){

        Semestre semestre = new Semestre();
        String sql = "SELECT * FROM semestre WHERE habilitado=1;";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)){

            try(ResultSet rs = pstmt.executeQuery()){

                while(rs.next()){
                    semestre.setIdSemestre(rs.getInt(1));
                    semestre.setNombre(rs.getString(2));
                    semestre.setHabilitado(rs.getBoolean(4));
                    semestre.setFechaRegistro(rs.getTimestamp(5));
                    semestre.setFechaEdicion(rs.getTimestamp(6));
                }
            }
        } catch (SQLException e){
            throw new RuntimeException(e);
        }
        return semestre;
    }


    public void newEvaluacion(String nombre, String codigo, String correo, String nota, String idCurso){

        int nuevoId = 1;

        String sql = "INSERT INTO `lab_9`.`evaluaciones` (`idevaluaciones`, `nombre_estudiantes`, `codigo_estudiantes`, `correo_estudiantes`, `nota`, `idcurso`, `idsemestre`) \n" +
                "VALUES (?, ?, ?, ?, ?, ?, ?);";

        try(Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)){

            if (obtenerUltimoID() > 0){
                nuevoId = obtenerUltimoID() +1;
            }

            pstmt.setInt(1, nuevoId);
            pstmt.setString(2, nombre);
            pstmt.setString(3, codigo);
            pstmt.setString(4, correo);
            pstmt.setString(5, nota);
            pstmt.setString(6, idCurso);
            pstmt.setInt(7, getCurrentSemestre().getIdSemestre());

            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }


    public int obtenerUltimoID() {
        int ultimoID = -1;

        String sql = "SELECT MAX(idevaluaciones) AS ultimo_id FROM evaluaciones";

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


    public void editEvaluacion(String newNombre, String newCodigo, String newCorreo, String newNota, String idEvaluacionEdit){
        String sql = "UPDATE `lab_9`.`evaluaciones` SET `nombre_estudiantes` = ?, `codigo_estudiantes` = ?, `correo_estudiantes` = ?, `nota` = ? WHERE (`idevaluaciones` = ?);";
        try(Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1,newNombre);
            pstmt.setString(2,newCodigo);
            pstmt.setString(3,newCorreo);
            pstmt.setString(4,newNota);
            pstmt.setString(5,idEvaluacionEdit);
            pstmt.executeUpdate();

            updateDatesAtEdit(idEvaluacionEdit);

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }


    public void updateDatesAtEdit(String idEvaluacionEdit) {

        String sql = "UPDATE evaluaciones SET fecha_edicion = NOW() WHERE idevaluaciones = ?;";

        try (Connection conn = this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, idEvaluacionEdit);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    public void borrarEvaluacion(String idBorrar){

        String sql = "DELETE FROM evaluaciones WHERE idevaluaciones = ?";
        try(Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1,idBorrar);
            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

}
