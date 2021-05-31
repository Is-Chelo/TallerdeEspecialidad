<?php
    include_once('../modelo/algoritmo.php');
    include_once("../modelo/Rutas.php");

    $rutas = new Rutas();

    switch($_GET['opcion']){

        
        case "listar":
            break;

            
        case "rutaOptimaMultiplesDestinos":
            $origen = $_GET['origen'];
            $dString = $_GET['destinos'];
            $destinos = explode(",", $dString);                
            $rutaOptima =  main($origen, $destinos);
            $rutaOptimaFinal=[];
            for ($i=0; $i < count($rutaOptima) ; $i++) { 
                $rutaOptimaFinal[]=($rutaOptima[$i][1]);
            }
            echo json_encode($rutaOptimaFinal);
        break;
       
        case "sacamosRutas":

            $rutasString = $_GET['rutasString'];
            $r = explode(",", $rutasString);
            

            $clientes = $rutas->clientes();
            
            $data=[];
            while($fila = pg_fetch_object($clientes)){    	
                if(array_search($fila->id, $r)){
                    $data[]=$fila;
                }
            }

            echo json_encode($data);
            

    }
?>