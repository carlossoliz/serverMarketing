let Conexion = require('../conexion/conexion');
let JsPert = require('js-pert');
let conexion = new Conexion();

class Actividad{
    constructor(){}

    mostrar(){
        let sql = "select * from actividad;";
        return conexion.consulta(sql);
    }

    calcularPert(fecha){
        
       return new Promise((resuelto , error)=>{
           let json = {};let i = 0 ;
            this.mostrarDatos(fecha).then(lista =>{
                let arrayLista = Array.from(lista);
                //console.log(arrayLista)
                arrayLista.forEach(actividad => {
                    let datoJson = {
                        "id": actividad.id,
                        "optimisticTime": Number(actividad.optimista),
                        "mostLikelyTime": Number(actividad.probable),
                        "pessimisticTime": Number(actividad.pesimista),
                        "predecessors": actividad.predecedor == null ? [] : actividad.predecedor
                    }
                    // console.log(actividad)
                   json[actividad.id] =datoJson ;
                   i = i+1;
                });
                //console.log(json)
                 let pert = JsPert.default(json);
                 console.log(pert)
                resuelto(pert)
            })
       })
    }

    mostrarDatos(fecha){
        let sql = "select * from actividad_mostrar('@fecha');";
        sql = sql.replace('@fecha', fecha);
        console.log(sql)
        return conexion.consulta(sql);
    }

    insertar(nombre , optimista , probable , pesimista , predecesor , hora , fecha , idcliente){
        let sql = "select * from actividad_insertar('@nombre',@optimista,@probable,@pesimista,'@predecesor','@hora','@fecha',@idcliente);";
        sql = sql.replace('@nombre',nombre);
        sql = sql.replace('@optimista',optimista);
        sql = sql.replace('@probable',probable);
        sql = sql.replace('@pesimista',pesimista);
        sql = sql.replace('@predecesor',predecesor == -1 ? null : predecesor);
        sql = sql.replace('@hora',hora);
        sql = sql.replace('@fecha',fecha);
        sql = sql.replace('@idcliente',idcliente);
        if (predecesor == -1) {
            sql = sql.replace("'null'", null);
        }
        console.log(sql) 
        return conexion.consulta(sql);  
    }
}

module.exports = Actividad;