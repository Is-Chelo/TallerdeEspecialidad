document.addEventListener("DOMContentLoaded", function (event) {
  listar();
  initMap();

    
});

// Iniciamos el mapa con los puntos de los CLientes
function initMap() {
  map = new google.maps.Map(document.getElementById("map"), {
    center: { lat: -19.0543600132232, lng: -65.2539886472899 },
    zoom: 12,
  });

  var xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function () {
    if (this.readyState == 4 && this.status == 200) {
      respuesta = JSON.parse(this.responseText);
      datos = respuesta.aaData;
      for (let index = 0; index < datos.length; index++) {
        lat = parseFloat(datos[index][2]);
        long = parseFloat(datos[index][3]);
        var marker = new google.maps.Marker({
          position: { lat: lat, lng: long },
          map: map,
          title: datos[index][1],
        });
      }
    }
  };
  xhttp.open("GET", "../controller/ClientesController.php?opcion=listar", true);
  xhttp.send();
  
}

// Mostramos || Listamos Clientes
function listar() {
  $(document).ready(function () {
    $("#table").DataTable({
      iDisplayLength: 5, // Modificamos show Entries
      ajax: {
        url: "../controller/ClientesController.php?opcion=listar",
        type: "get",
        dataType: "json",
        error: function (e) {
          console.log(e.responseText);
        },
      },
    });
  });
}

//  traemos Las rutasOptimas y los pintamos en el HTML

function enviarMultipleRutas(e) {
  let rutasString = "";
  document.getElementById("rutas").innerHTML = "";

  var o = document.getElementById("origenM").value;
  var d = document.getElementById("destinoM").value;
  var xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function () {
    if (this.readyState == 4 && this.status == 200) {
      datos = JSON.parse(this.responseText);
      for (let i = 0; i < datos.length; i++) {
        rutasString += String(datos[i]) + ",";
      }
      document.getElementById("rutas").innerHTML += `<h3>${rutasString}</h3>`;
      GuardarLocalStorage()
    }
  };
  xhttp.open(
    "POST",
    "../controller/RutasControler.php?opcion=rutaOptimaMultiplesDestinos&origen=" +
      o +
      "&" +
      "destinos=" +
      d,
    true
  );
  xhttp.send();

  
}

function GuardarLocalStorage() {
  let arrayRutas = document.getElementById("rutas").innerText;
  traemosLatitudesyLongitudes(arrayRutas);
}

// Traemos las latitudes de las rutas optimas Calculadas
function traemosLatitudesyLongitudes(rutas) {
  let a=[{"lat": -19.0543600132232 ,"lng":  -65.2539886472899 }];
  var xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function () {
    if (this.readyState == 4 && this.status == 200) {
      datos = JSON.parse(this.responseText);
      for (let i = 0; i < datos.length; i++) {  
            a.push({"lat": parseFloat(datos[i]['latitud']) ,"lng": parseFloat(datos[i]['longitud']) });       
      }
      
      localStorage.setItem("rutas", JSON.stringify(a));

    }
  };
  xhttp.open(
    "GET",
    "../controller/RutasControler.php?opcion=sacamosRutas&rutasString=" + rutas,
    true
  );
  xhttp.send();
}

