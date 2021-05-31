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
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.24/css/jquery.dataTables.min.css">
    <title>Document</title>
</head>
<body>  

<div class="container p-5">
    <div class="row">
        <h2 class="text-center">CLIENTES</h2>

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

        <div class="col-xs-6 col-md-6 mt-5">
            <div id="map" style="width: 500px; height: 500px"></div>
        </div>
    </div>
    <br><br>
    <div class="row">
    <h2 class="text-center">La Ruta Optima es</h2>
        <div class="col-xs-6 col-md-6">
            <div id="multiplesPuntos">
                <label for="origen" class="form-label">Origen: </label>
                <select type="text" name="origen" id="origenM" class="form-control">
                    <?php
                        $query = pg_query($sql);
                        while($fila= pg_fetch_object($query)){
                            echo "<option value=".$fila->id.">".$fila->nombre."</option>";
                        }
                    ?>
                </select>
                <label for="destino" class="form-label" >Destino</label>
                <input type="text" name="destinoM" id="destinoM" class="form-control" >
                <button onclick="enviarMultipleRutas(event);" class="btn btn-primary mt-3">Calcular</button>
                <a  id="btnGraficar" type="button" class="btn btn-primary mt-3" href="calculoRutas.php">graficar</a>

            </div>
        </div>
        <div class="col-xs-6 col-md-6">
            <div id="rutas" class="mt-3">
            </div>
            
        </div>
        <div id="otromap"></div>
    </div>
    
   
</div>
<br><br>
</body>
</html>


<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js"></script>

<script async defer
      src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBKTLXxqE5D5f5uBfQ1_Zv4xk24IwYgw3w&callback=initMap">
</script>

<script src="scripts/script.js"></script>


<style>
    body{
        margin:0;
        padding: 0;
    }
    #rutas{
        width: 100%;
         height:100px;
    }

</style>