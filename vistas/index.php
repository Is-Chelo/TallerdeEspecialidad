<?php
include("../config/conexion.php");
$sql = "SELECT * FROM cliente";
?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- CSS only -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.24/css/jquery.dataTables.min.css">
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous" />
    
    <title>Document</title>
</head>

<body>
    <script>
        window.onload = function() {
            var carga = document.getElementById('carga');
            carga.style.visibility = 'hidden';
            carga.style.opacity = '0';
        }
    </script>

    <div id="carga" class="carga">
        <div class="loading-screen">
            <div class="loading">
                <span></span>
                <span></span>
                <span></span>
                <span></span>
            </div>
        </div>

    </div>

    <!-- Modal -->
    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content" style="width:113%">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">CLIENTES</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">

                    <div class="col-xs-6 col-md-6">
                        <div id="clientes" style="width: 90%; margin:30px;">
                            <table id="table" class="display" style="width:100%">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Nombre</th>
                                        <th>Latitud</th>
                                        <th>Longitud</th>
                                    </tr>
                                </thead>
                                <tbody>

                                </tbody>

                            </table>
                        </div>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    
    <div class="container p-5">
        <div class="row">

            <div class="col-xs-6 col-md-6 mt-5">

                <button type="button" class="btn btn-secondary px-2" style="position:absolute; z-index:10;left: 25%;
    top: 17.3%;" data-bs-toggle="modal" data-bs-target="#exampleModal">
                    <i class="fas fa-users"></i>
                </button>
                <div class="mapa" style="position: absolute;">
                    <div id="map" style="width: 500px;height: 500px;position: absolute;overflow: hidden;"></div>
                </div>

            </div>

            <div class="col-xs-6 col-md-6">
                <h2 class="text-center">La Ruta Optima es</h2>

                <div id="multiplesPuntos">
                    <label for="origen" class="form-label" id="origen">Origen: </label>
                    <select type="text" name="origen" id="origenM" class="form-control" >
                        <?php
                        $query = pg_query($sql);
                        while ($fila = pg_fetch_object($query)) {
                            echo "<option value=" . $fila->id . ">" . $fila->nombre . "</option>";
                        }
                        ?>
                    </select>
                    <label for="destino" class="form-label">Destino</label>
                    <input type="text" name="destinoM" id="destinoM" class="form-control">
                    <select type="text" name="selectDestinos" id="selectDestinos" class="form-control" multiple onchange="destinosenElLabel()" data-selectator-keep-open="true">
                        <?php
                        $query = pg_query($sql);
                        while ($fila = pg_fetch_object($query)) {
                            echo "<option id='" . $fila->id . "' value=" . $fila->id . " >" . $fila->nombre . "</option>";
                        }
                        ?>
                    </select>

                    <button onclick="enviarMultipleRutas(event);" class="btn btn-primary mt-3">Calcular</button>

                    <a id="btnGraficar" type="button" class="btn btn-primary mt-3" href="calculoRutas.php">graficar</a>
                    <div id="rutas"></div>
                </div>
            </div>
        </div>
        <br><br>


    </div>
    <br><br>
</body>

</html>

<!-- JavaScript Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js"></script>

<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBKTLXxqE5D5f5uBfQ1_Zv4xk24IwYgw3w&callback=initMap">
</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
<script src="scripts/script.js"></script>


<style>
    body {
        margin: 0;
        padding: 0;
    }

    #rutas {
        width: 100%;
        height: 100px;
        opacity: 0;
    }

    .carga {
        width: 100%;
        height: 100%;
        background-color: rgb(255, 255, 255);
        font-family: arial;
        display: flex;
        z-index: 100;
        position: absolute;
        top: 0px;
        left: 0px;
        transition: ease 1s all;
    }

    .loading-screen {
        width: 100%;
        height: 100vh;
        position: fixed;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .loading {
        width: 80px;
        display: flex;
        flex-wrap: wrap;
        animation: rotate 3s linear infinite;
    }

    @keyframes rotate {
        to {
            transform: rotate(360deg);
        }
    }

    .loading span {
        width: 32px;
        height: 32px;
        background-color: red;
        margin: 4px;
        animation: scale 1.5s linear infinite;
    }

    @keyframes scale {
        50% {
            transform: scale(1.2);
        }
    }

    .loading span:nth-child(1) {
        border-radius: 50% 50% 0 50%;
        background-color: #e77f67;
        transform-origin: bottom right;
    }

    .loading span:nth-child(2) {
        border-radius: 50% 50% 50% 0;
        background-color: #778beb;
        transform-origin: bottom left;
        animation-delay: .5s;
    }

    .loading span:nth-child(3) {
        border-radius: 50% 0 50% 50%;
        background-color: #f8a5c2;
        transform-origin: top right;
        animation-delay: 1.5s;
    }

    .loading span:nth-child(4) {
        border-radius: 0 50% 50% 50%;
        background-color: #f5cd79;
        transform-origin: top left;
        animation-delay: 1s;
    }
</style>