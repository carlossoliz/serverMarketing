const { query } = require('express');
let Conexion = require('../conexion/conexion');
let conexion = new Conexion();

class Empleado{
    constructor(){}

    mostrar(){
        let sql = "select * from empleado_mostrar();";
        return conexion.consulta(sql);
    }

    insertar(nombre,ci,rol){
        let sql = "select * from empleado_insertar('@nombre',@ci,'@rol');";
        sql = sql.replace('@nombre',nombre);
        sql = sql.replace('@ci',ci);
        sql = sql.replace('@rol',rol);
        console.log(sql);
        return conexion.consulta(sql);
    }
}
module.exports = Empleado;