<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../plugins/style/style.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
    <title>Document</title>
</head>
<body>


<div class="container-fluid">
<div class="row">
    <div class="col-md-3 " id="g6">
    <h2 class="text-white my-5 text-center"> Ruta Optima</h2>

        <div class="container" id="nombres">
        <!-- <p> <i class="fas fa-map-marker-alt text-primary"></i><span class="mx-3"> La Recoleta </span></p>
        <p> <i class="fas fa-map-marker-alt text-primary"></i><span class="mx-3"> Estadium </span></p>
        <p> <i class="fas fa-map-marker-alt text-primary"></i><span class="mx-3"> La Recoleta </span></p> -->

        </div>

    </div>
    <div class="col-md-9">

    
        <button class="btn btn-outline-success btn " onclick="calculoCaminoAuto('DRIVING')">Auto</button>
        <button class="btn btn-outline-success " onclick="calculoCaminoAuto('WALKING')">Caminando</button>
        <button class="btn btn-outline-success " onclick="calculoCaminoAuto('BICYCLING')">Bicicleta</button>
        <button class="btn btn-outline-success " onclick="location.reload();">Limpiar</button>


        <button class="btn btn-success " onclick="siguienteRuta()">>></button>
        <label for="">Ruta Total:</label>
        <select name="" id="rutatotal" class="form-control">
            <option value="">Todos</option>
            <option value="DRIVING">AUTO</option>
            <option value="WALKING">CAMINAR</option>
            <option value="BICYCLING">BICICLETA</option>
        </select>
        <div id="map" style="width: 100%; height: 300px"></div>

        <h2 class="text'center">Segundo Mapa</h2>
        <div id="otromap" style="width: 100%; height: 300px"></div>

    </div>
    </div>    
</div>

    
</body>
</html>
<!-- JavaScript Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js"></script>
<script src="scripts/calculosRutas.js"></script>
<script async defer
      src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBKTLXxqE5D5f5uBfQ1_Zv4xk24IwYgw3w&callback=initMap">
</script>