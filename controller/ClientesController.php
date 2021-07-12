<?php
    include_once('../modelo/Cliente.php');

    $cliente = new Cliente();

    $nombre = isset($_POST['nombre'])?$_POST['nombre']:"";
    $latitud = isset($_POST['latitud'])?$_POST['latitud']:"";
    $longitud = isset($_POST['longitud'])?$_POST['longitud']:"";


    switch($_GET['opcion']){

        case "listar":
            $respuesta = $cliente->listar();

            $data=array();
            while($fila=pg_fetch_object($respuesta)){
                $data[]=array(
                    "0" => $fila->id,
                    "1" => $fila->nombre,
                    "2" =>$fila->latitud,
                    "3" => $fila->longitud
                );
            }
            $results = array(
                "iTotalRecords"=>count($data), //el total de registros para el datatable
                "iTotalDisplayRecords"=>count($data),  //total de registros para visualizar
                "aaData"=>$data);
            echo json_encode($results);
}

?>