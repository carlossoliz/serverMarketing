let pg = require('pg');

class Conexion{
    constructor(){}

    consulta(sql){
        return new Promise((resuelto , error) =>{
            var cliente = new pg.Pool({user: 'admdb',host: '127.0.0.1',database: 'marketingtotal',password: 'm0f0c0d0',port: '5432'  }) ;
            cliente.query(sql  , (err , respuesta) =>{
                if (err) {
                    resuelto(err);
                } else {
                    resuelto(respuesta.rows);
                }
            })
        })
    }
}

module.exports = Conexion;