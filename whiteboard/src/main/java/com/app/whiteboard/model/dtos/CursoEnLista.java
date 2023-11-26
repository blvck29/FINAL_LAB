package com.app.whiteboard.model.dtos;

import java.sql.Timestamp;

public class CursoEnLista {

    private int idCurso;
    private String codigo;
    private String nombre;
    private Timestamp fechaEdicion;
    private Timestamp fechaRegistro;
    private int cantDocentes;
    private int cantEvaluaciones;

    public int getIdCurso() {
        return idCurso;
    }

    public void setIdCurso(int idCurso) {
        this.idCurso = idCurso;
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
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

    public int getCantDocentes() {
        return cantDocentes;
    }

    public void setCantDocentes(int cantDocentes) {
        this.cantDocentes = cantDocentes;
    }

    public int getCantEvaluaciones() {
        return cantEvaluaciones;
    }

    public void setCantEvaluaciones(int cantEvaluaciones) {
        this.cantEvaluaciones = cantEvaluaciones;
    }
}
