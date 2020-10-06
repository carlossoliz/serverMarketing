let Conexion = require('../conexion/conexion');
let conexion = new Conexion();



class Estado{
    constructor(){}

  
    mostrar(){
        let sql = "select * from estado_mostrar();";
        return conexion.consulta(sql);
    }
}

module.exports = Estado;