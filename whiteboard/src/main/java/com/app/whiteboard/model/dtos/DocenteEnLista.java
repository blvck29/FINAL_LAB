package com.app.whiteboard.model.dtos;

import java.sql.Timestamp;

public class DocenteEnLista {

    private int idDocente;
    private String nombre;
    private String correo;
    private Timestamp ultimoIngreso;
    private Timestamp fechaEdicion;
    private Timestamp fechaRegistro;
    private int cantIngresos;
    private int cantCursos;

    public int getIdDocente() {
        return idDocente;
    }

    public void setIdDocente(int idDocente) {
        this.idDocente = idDocente;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public Timestamp getUltimoIngreso() {
        return ultimoIngreso;
    }

    public void setUltimoIngreso(Timestamp ultimoIngreso) {
        this.ultimoIngreso = ultimoIngreso;
    }

    public Timestamp getFechaEdicion() {
        return fechaEdicion;
    }

    public void setFechaEdicion(Timestamp fechaEdicion) {
        this.fechaEdicion = fechaEdicion;
    }

    public Timestamp getFechaRegistro() {
        return fechaRegistro;
    }

    public void setFechaRegistro(Timestamp fechaRegistro) {
        this.fechaRegistro = fechaRegistro;
    }

    public int getCantIngresos() {
        return cantIngresos;
    }

    public void setCantIngresos(int cantIngresos) {
        this.cantIngresos = cantIngresos;
    }

    public int getCantCursos() {
        return cantCursos;
    }

    public void setCantCursos(int cantCursos) {
        this.cantCursos = cantCursos;
    }
}
