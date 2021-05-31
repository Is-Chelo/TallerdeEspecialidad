<?php
include("../config/conexion.php");


    function main($o, $d){
        $rutaTotalTotal=[];
        $nO=$o;
        $nD = $d;    
        for ($j=0; $j < count($d) ; $j++) { 
            for ($i=0; $i <count($nD); $i++) { 
                $palgoritmo = rutasMinima($nO, $nD);
                $rutaOptimaP = $palgoritmo[1];
                // print_r($putoAlgoritmo);
                // echo "<br><br>";
            } 
            $rutaTotalTotal[]=$palgoritmo;
            $nO= end($rutaOptimaP);
            $nD=nuevosDestinos($nO, $nD);       
        }
        return $rutaTotalTotal;
    }

    function nuevosDestinos($valor, $destinos){
        $nuevoArray=[];
        for ($i=0; $i <count($destinos) ; $i++) { 
            if($valor != $destinos[$i]){
                array_push($nuevoArray, $destinos[$i]);
            }
            
        }
        return $nuevoArray;
    }


    function rutasMinima($origen, $destinos){
        $costo=0;  
        $rutaOptima =[];
        $costoMinimo=[];
        for ($i=0; $i < count($destinos) ; $i++) { 
            $vertex=[];
            $sql = "SELECT * FROM algoritmo.dijkstra('SELECT * FROM rutas.graph', ".$origen.", ".$destinos[$i].")d INNER JOIN cliente c ON d.vertex = c.id
                    ORDER BY cost ASC";
            $query = pg_query($sql);
            
            while($fila=pg_fetch_object($query)){
                $costo = $fila->cost;
                $vertex[] = $fila->vertex;    
            }
            $costoMinimo[]=array($costo,$vertex);

        }
        $rutaOptima = sacamosMenor($costoMinimo);
        return $rutaOptima;

    }
    function sacamosMenor($array){
        sort($array);
        return $array[0];
    }


 
?>

