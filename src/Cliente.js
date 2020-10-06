const { query } = require('express');
let Conexion = require('../conexion/conexion');
let conexion = new Conexion();

class Cliente{
    constructor(){}

    mostrar(){
        let sql = "select * from cliente_listar();";
        return conexion.consulta(sql);
    }

    insertar(nombre,telefono){
        let sql = "select * from cliente_insertar('@nombre',@telefono);";
        sql = sql.replace('@nombre',nombre);
        sql = sql.replace('@telefono',telefono);
        console.log(sql);
        return conexion.consulta(sql);
    }
}
module.exports = Cliente;