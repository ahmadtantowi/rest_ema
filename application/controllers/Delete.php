<?php

defined('BASEPATH') OR exit('No direct script access allowed');

require APPPATH . '/libraries/REST_Controller.php';
use Restserver\Libraries\REST_Controller;

class Delete extends REST_Controller {

	public function __construct($config = 'rest'){
		parent::__construct($config);
		$this->load->database();
	}


	public function index_get(){

		$id_event = $this->get('Id_Event');
		$id_dkm = $this->get('Id_Dkm');

		if($id_dkm != ''){
			$this->db->where('id_dkm',$id_dkm);
			$delete = $this->db->delete('dkm');
		} else{
			$this->db->where('id_event',$id_event);
			$delete = $this->db->delete('event');
		}	

		if($delete){
			$this->response(array('status' => 'success', 201));
		} else{
			$this->response(array('status' => 'fail', 502));
		}	
	}

}