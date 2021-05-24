<?php
include('algoritmo.php');

    $origen = $_GET['origen'];
    $dString = $_GET['destinos'];
    $destinos = explode(",", $dString);


       
    $rutaOptima =  main($origen, $destinos);
    $rutaOptimaFinal=[];
    for ($i=0; $i < count($rutaOptima) ; $i++) { 
        $rutaOptimaFinal[]=($rutaOptima[$i][1]);
    }
    echo json_encode($rutaOptimaFinal);
       
        

    
?>

