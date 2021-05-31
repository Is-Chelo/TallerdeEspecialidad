
let rutasRecuperadas;




function initMap() {
    rutasRecuperadas = JSON.parse(localStorage.getItem("rutas"));

    map = new google.maps.Map(document.getElementById("map"), {
        center: { lat: -19.035219103028318, lng: -65.26106904444798 },
        zoom: 14,
    });
    
    for (let i = 0; i < rutasRecuperadas.length; i++) {
        lat = parseFloat(rutasRecuperadas[i]['lat']);
        long = parseFloat(rutasRecuperadas[i]['lng']);
        var marker = new google.maps.Marker({
          position: { lat: lat, lng: long },
          map: map,
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
    polyline.setMap(map);
    polylines.Push(polyline);



    
}
