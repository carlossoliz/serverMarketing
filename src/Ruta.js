let Conexion = require('../conexion/conexion');
let conexion = new Conexion();



class Ruta{
    constructor(){}

    insertar(latitud,longitud,descripcion,idactividad){
        let sql = "select * from ruta_insertar('@latitud','@longitud','@descripcion',@idactividad);";
        sql = sql.replace('@latitud',latitud);
        sql = sql.replace('@longitud',longitud);
        sql = sql.replace('@descripcion',descripcion);
        sql = sql.replace('@idactividad',idactividad);
        console.log(sql)
        return conexion.consulta(sql);
    }

    mostrar(fecha){
        let sql = "select * from ruta_mostrar('@fecha');";
         sql = sql.replace('@fecha',fecha);
         console.log(sql)
        return conexion.consulta(sql);
    }
}

module.exports = Ruta;