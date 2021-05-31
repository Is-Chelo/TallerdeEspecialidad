<?php

    include("conexion.php");
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

    <title>Document</title>
</head>
<body>  
    <div id="clientes" style="width: 90%; margin:30px;">
        <h2 class="text-center">CLIENTES</h2>
        <table class="table">
            <tr>
                <th>ID</th>
                <th>Nombre</th>
                <th>Latitud</th>
                <th>Longitud</th>
            </tr>
            <tbody>
                <?php
                    $query = pg_query($sql);
                    while($fila=pg_fetch_object($query)){
                        echo "<tr>
                        <td>".$fila->id."</td>
                        <td>".$fila->nombre."</td>
                        <td>".$fila->latitud."</td>
                        <td>".$fila->longitud."</td>
                        </tr>";
                    }
                ?>
            </tbody>

        </table>
    </div>

    <div id="multiplesPuntos" style="width: 50%; margin:50px">
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
        <button onclick="enviarMultipleRutas(event);" class="btn btn-primary mt-3">Enviar</button>
        <h4 class="text-center">La Ruta Optima es</h4>
        <div id="rutas" class="mt-3">

        </div>
    </div>

</body>
</html>


<script>
 


function enviarMultipleRutas(e){
    document.getElementById("rutas").innerHTML ="";

    var o = document.getElementById('origenM').value;
    var d = document.getElementById('destinoM').value;
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
        datos = JSON.parse(this.responseText);
        for(let i =0 ;i<datos.length; i++){
            document.getElementById("rutas").innerHTML +=`<h3>${datos[i]}</h3>`;
        }
    }
  };
  xhttp.open("POST", "rutaOptimaMultiplesDestinos.php?origen="+o+"&"+"destinos="+d, true);
  xhttp.send();
}



</script>

<style>

    #rutas{
        width: 100%;
         height:100px;
    }

</style>