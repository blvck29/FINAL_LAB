package com.app.whiteboard.model.daos;

import com.app.whiteboard.SHA256;
import com.app.whiteboard.model.beans.Facultad;
import com.app.whiteboard.model.beans.Universidad;
import com.app.whiteboard.model.beans.Usuario;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UsuarioDao extends DaoBase {

    public boolean login(String email, String password){

        boolean valido = false;
        String passwordHash = SHA256.cipherPassword(password);

        String sql = "SELECT u.correo, u.password FROM usuario u WHERE u.correo = ? AND u.password = ?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)){

            pstmt.setString(1, email);
            pstmt.setString(2, passwordHash);

            try(ResultSet rs = pstmt.executeQuery()){

                while(rs.next()){
                    String emailDB = rs.getString(1);
                    String passwordDB = rs.getString(2);

                    if (emailDB == null || passwordDB == null){
                        valido = false;
                    } else if (emailDB.equals(email) && passwordDB.equals(passwordHash)){
                        valido = true;
                        Usuario user = findUser(email,password);
                        updateDatesAtLogin(user);
                    }
                }

            }
        }catch (SQLException e){
            throw new RuntimeException(e);
        }
        return valido;
    }

    public Usuario findUser(String email, String password){

        password = SHA256.cipherPassword(password);
        Usuario user = new Usuario();

        String sql = "SELECT * FROM usuario u WHERE u.correo = ? AND u.password = ?;";


        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)){

            pstmt.setString(1, email);
            pstmt.setString(2, password);

            try(ResultSet rs = pstmt.executeQuery()){

                while(rs.next()){
                    user.setIdUsuario(rs.getInt(1));
                    user.setNombre(rs.getString(2));
                    user.setCorreo(rs.getString(3));
                    /* No guardo el password por seguridad */
                    user.setIdRol(rs.getInt(5));
                    user.setUltimoIngreso(rs.getTimestamp(6));
                    user.setCantidadIngresos(rs.getInt(7));
                    user.setFechaRegistro(rs.getTimestamp(8));
                    user.setFechaEdicion(rs.getTimestamp(9));
                }

            }
        }catch (SQLException e){
            throw new RuntimeException(e);
        }
        return user;
    }


    public Usuario getUser(int idUsuario) {
        Usuario user = new Usuario();

        String sql = "SELECT * FROM usuario u WHERE u.idusuario = ?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, idUsuario);

            try (ResultSet rs = pstmt.executeQuery()) {

                while (rs.next()) {
                    user.setIdUsuario(rs.getInt(1));
                    user.setNombre(rs.getString(2));
                    user.setCorreo(rs.getString(3));
                    /* No guardo el password por seguridad */
                    user.setIdRol(rs.getInt(5));
                    user.setUltimoIngreso(rs.getTimestamp(6));
                    user.setCantidadIngresos(rs.getInt(7));
                    user.setFechaRegistro(rs.getTimestamp(8));
                    user.setFechaEdicion(rs.getTimestamp(9));
                }

            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return user;
    }

    public void updateDatesAtLogin(Usuario user) {
        int idUsuario = user.getIdUsuario();
        int cantLogins = user.getCantidadIngresos();

        String sql = "UPDATE usuario SET ultimo_ingreso = NOW(), cantidad_ingresos = ? WHERE idusuario = ?;";

        try (Connection conn = this.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            int newCant = cantLogins + 1;
            pstmt.setInt(1, newCant);
            pstmt.setInt(2, idUsuario);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }


    public Facultad getFacultad(Usuario user){
        int idUser = user.getIdUsuario();
        Facultad facultad = new Facultad();

        String sql = "SELECT * FROM facultad_has_decano f_d INNER JOIN facultad f ON (f_d.iddecano = ?)";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)){

            pstmt.setInt(1, idUser);

            try(ResultSet rs = pstmt.executeQuery()){

                while(rs.next()){
                    facultad.setIdFacultad(rs.getInt(3));
                    facultad.setNombre(rs.getString(4));
                    facultad.setUniversidad(getUniversity(rs.getString(5)));
                    facultad.setFechaRegistro(rs.getTimestamp(6));
                    facultad.setFechaEdicion(rs.getTimestamp(7));
                }
            }
        } catch (SQLException e){
            throw new RuntimeException(e);
        }

        return facultad;
    }


    public Facultad getFacultadDocente(Usuario user){
        int idDocente = user.getIdUsuario();
        Facultad facultad = null;

        String sql = "SELECT c_d.iddocente, f.idfacultad, f.nombre, f.iduniversidad, f.fecha_registro, f.fecha_edicion FROM curso_has_docente c_d \n" +
                "INNER JOIN curso c ON (c_d.idcurso = c.idcurso)\n" +
                "INNER JOIN facultad f ON (c.idfacultad = f.idfacultad)\n" +
                "WHERE c_d.iddocente = ?";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)){

            pstmt.setInt(1, idDocente);

            try(ResultSet rs = pstmt.executeQuery()){

                if(rs.next()){
                    facultad = new Facultad();
                }

                while(rs.next()){
                    facultad.setIdFacultad(rs.getInt(2));
                    facultad.setNombre(rs.getString(3));
                    facultad.setUniversidad(getUniversity(rs.getString(4)));
                    facultad.setFechaRegistro(rs.getTimestamp(5));
                    facultad.setFechaEdicion(rs.getTimestamp(6));
                }
            }
        } catch (SQLException e){
            throw new RuntimeException(e);
        }
        return facultad;
    }


    public Universidad getUniversity(String idUniversidad) {
        Universidad universidad = new Universidad();
        String sql = "SELECT * FROM universidad u WHERE u.iduniversidad = ?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, idUniversidad);

            try (ResultSet rs = pstmt.executeQuery()) {

                while (rs.next()) {
                    universidad.setIdUniversidad(rs.getInt(1));
                    universidad.setNombre(rs.getString(2));
                    universidad.setLogoUrl(rs.getString(3));
                    universidad.setAdministrador(getUser(rs.getInt(4)));
                    universidad.setFechaRegistro(rs.getTimestamp(5));
                    universidad.setFechaEdicion(rs.getTimestamp(6));
                }

            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return universidad;
    }


}
