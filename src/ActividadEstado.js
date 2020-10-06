let Conexion = require('../conexion/conexion');
let conexion = new Conexion();

class ActividadEstado {
    constructor(){}

    insertar(idactividad,idestado,hora){
        let sql = "select * from actividadestado_insertarp(@idactividad,@idestado,'@hora');";
        sql = sql.replace('@idactividad',idactividad);
        sql = sql.replace('@idestado',idestado);
        sql = sql.replace('@hora',hora);
        console.log(sql)
        return conexion.consulta(sql);
    }
}

module.exports = ActividadEstado;