
let rutasRecuperadas;
let nombresRecuperados;
let count= 0;
let transporte="";

let nombres;

document.addEventListener('DOMContentLoaded', ()=>{
    nombresLocalStorage()
})


// inicializamos el mapa con los puntos obtenidos y dibujamos poligonos
function initMap() {
    rutasRecuperadas = JSON.parse(localStorage.getItem("rutas"));
    
    map = new google.maps.Map(document.getElementById("map"), {
        center: { lat: -19.035219103028318, lng: -65.26106904444798 },
        zoom: 14,
    });
    
    map2 = new google.maps.Map(document.getElementById("otromap"), {
        center: { lat: -19.035219103028318, lng: -65.26106904444798 },
        zoom: 14,
    });
    

    for (let i = 0; i < rutasRecuperadas.length; i++) {
        lat = parseFloat(rutasRecuperadas[i]['lat']);
        long = parseFloat(rutasRecuperadas[i]['lng']);
        var marker = new google.maps.Marker({
          position: { lat: lat, lng: long },
          map: map2,
          title: "",
        });
    }

    var polyline = new google.maps.Polyline({
        path: rutasRecuperadas,
        strokeColor: 'rgb(255, 0, 0)',
        strokeOpacity: 1.0,
        strokeWeight: 2,
        geodesic: true,
        icons: [{
            icon: {path: google.maps.SymbolPath.FORWARD_CLOSED_ARROW},
            offset: '100%',
            repeat: '20px'
        }]
    });
    polyline.setMap(map2);
    polylines.Push(polyline);

    
}

//  Calcula el camino por el va ir ya sea en auto en bici o caminando
function calculoCaminoAuto(valor){
    transporte= valor;
    latOrigen = parseFloat(rutasRecuperadas[count]['lat']);
    longOrigen = parseFloat(rutasRecuperadas[count]['lng']);
    latDestino = parseFloat(rutasRecuperadas[count+1]['lat']);
    longDestino = parseFloat(rutasRecuperadas[count+1]['lng']);
    const directionsService = new google.maps.DirectionsService();
    const directionsRenderer = new google.maps.DirectionsRenderer();
    directionsRenderer.setMap(map);

   
    directionsService.route(
        {
          origin:`"${latOrigen},${longOrigen}"`,
          destination: `"${latDestino},${longDestino}"`,
          travelMode: valor,
        },
        (response, status) => {
            if(status == 'OK'){
                aa = response
                directionsRenderer.setDirections(aa)
            }else{
                alert(`No Existe Ruta en auto de Origen: ${latOrigen},${longOrigen} Destino: ${latDestino},${longDestino}` )
                
            }
        
        }
      ); 
}


function siguienteRuta(){
    count++;
    calculoCaminoAuto(transporte)
}

// Calculamos la ruta Total pasando por todos los puntos posibles
document.getElementById('rutatotal').addEventListener('change', ()=>{
    
    transporte = document.getElementById('rutatotal').value;
    for (let i = 0; i < rutasRecuperadas.length; i++) {  
        calculoCaminoAuto(transporte)
        count++;      
    }
})



function nombresLocalStorage(){
    nombres = document.getElementById('nombres');
    let html=""
    nombresRecuperados = JSON.parse(localStorage.getItem("nombres"));
    for (let i = 0; i < nombresRecuperados.length; i++) {
        html+= `<p> <i class="fas fa-map-marker-alt text-primary"></i><span class="mx-3">${nombresRecuperados[i]["nombre"]} </span></p>`;
    }
    nombres.innerHTML = html;
}