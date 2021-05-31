<?php 

include_once('../config/conexion.php');


class Rutas{

    public function listar(){
        $sql = "SELECT * FROM rutas";
        $query = pg_query($sql);
        return $query;
    }

    public function clientes(){
        $sql = "SELECT * FROM cliente";
        $query = pg_query($sql);
        return $query;
    } 

}

?>