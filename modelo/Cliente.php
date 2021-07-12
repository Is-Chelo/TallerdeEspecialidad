<?php 

include_once('../config/conexion.php');


class Cliente{


    public function listar(){
        $sql = "SELECT * FROM cliente";
        $query = pg_query($sql);
        return $query;
    }

}

?>