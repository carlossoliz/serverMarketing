const e = require('express');
const express = require('express')
const app = express()
 
////////////////// auxiliares ///////////////////////////
app.use(express.json());
app.use(express.urlencoded({extended : true}));

//app.enable('trust proxy');
app.use(function(req, res, next) {

    // Website you wish to allow to connect
    res.setHeader('Access-Control-Allow-Origin', '*');

    // Request methods you wish to allow
    //res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST');
    // Request headers you wish to allow
    //res.setHeader('Access-Control-Allow-Headers', 'X-Requested-With,content-type');
    res.setHeader('Access-Control-Allow-Headers', 'Access-Control-Allow-Headers, Origin,Accept, X-Requested-With, Content-Type, Access-Control-Request-Method, Access-Control-Request-Headers');
    // Set to true if you need the website to include cookies in the requests sent
    // to the API (e.g. in case you use sessions)
    res.setHeader('Access-Control-Allow-Credentials', true);

    // Pass to next layer of middleware
    next();
});

////////////// export //////////////////////////////////
let Actividad = require('../src/Actividad');
let Empleado = require('../src/Empleado');
let Ruta = require('../src/Ruta');
let ActividadEstado = require('../src/ActividadEstado');
let Estado = require('../src/Estado');
let Cliente = require('../src/Cliente');
/////////////////////  instancias ///////////////////////
let actividad = new Actividad();
let empleado = new Empleado();
let ruta = new Ruta();
let actividadEstado = new ActividadEstado();
let estado = new Estado();
let cliente = new Cliente();

app.get('/', function (req, res) {
  res.send('Hello World')
});

app.post('/actividad' , (req,res)=>{
    switch (req.body.accion) {
        case 'actividades':
            actividad.mostrar().then(datos =>{
                res.send(datos);
            });    
        break;
            
        case 'pert' : 
            actividad.calcularPert(req.body.fecha).then(datos=>{
                res.send(datos)
            })
        break;

        case 'insertar' :
            actividad.insertar(req.body.nombre,req.body.optimista,req.body.probable,req.body.pesimista,req.body.predecesor,req.body.hora,req.body.fecha,req.body.idcliente).then(datos=>{
                res.send(datos);
            });
        break;
        
        case 'actividadFecha' :
            actividad.mostrarDatos(req.body.fecha).then(datos=>{
                res.send(datos)
            })
        break;
        default:
            res.sendStatus(400);
        break;
    }
})

app.get('/pert' , (req,res)=>{
    actividad.calcularPert(req.query.fecha).then(datos=>{
        res.send(datos)
    })
});

app.post('/ruta' , (req,res)=>{
   switch (req.body.accion) {
       case 'insertar':
           ruta.insertar(req.body.latitud,req.body.longitud,req.body.descripcion,req.body.idactividad).then(datos=>{
               res.send(datos);
           })
        break;
        
        case 'mostrar' : 
           ruta.mostrar(req.body.fecha).then(datos=>{
               res.send(datos);
           })
        break;
       default:
           break;
   }
})

app.post('/empleado' , (req, res)=>{
    switch (req.body.accion) {
        case "mostrar":
             empleado.mostrar().then(datos=>{
                 res.send(datos);
             });
        break;
        case 'insertar':
             empleado.insertar(req.body.nombre,req.body.ci , req.body.rol).then(datos=>{
                 res.send(datos);
             });
        break;
        default:
            break;
    }
})

app.post('/ActividadEstado' , (req,res)=>{
    switch (req.body.accion) {
        case 'insertar':
            actividadEstado.insertar(req.body.idactividad,req.body.idestado,req.body.hora).then(datos=>{
                res.send(datos);
            })
        break;
    
        default:
            break;
    }
})


app.post('/estado' , (req,res)=>{
    switch (req.body.accion) {
        case 'mostrar':
            estado.mostrar().then(datos=>{
                res.send(datos);
            })
        break;
    
        default:
            break;
    }
})

app.post('/cliente' , (req,res)=>{
    switch (req.body.accion) {
        case 'mostrar':
            cliente.mostrar().then(datos=>{
                res.send(datos);
            })
        break;

        case 'insertar':
            cliente.insertar(req.body.nombre,req.body.telefono).then(datos=>{
                res.send(datos);
            })
        break;
    
        default:
            break;
    }
})
app.listen(8080);