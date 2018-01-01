<?php

defined('BASEPATH') OR exit('No direct script access allowed');

require APPPATH . '/libraries/REST_Controller.php';
use Restserver\Libraries\REST_Controller;

class Pull extends REST_Controller {

	public function __construct($config = 'rest'){
		parent::__construct($config);
		$this->load->database();
	}

	public function index_get(){
		$id = $this->get('id_dkm');
		if($id == ''){
			$kontak = $this->db->get('dkm')->result();
		} else{
			$this->db->where('id_dkm',$id);
			$kontak = $this->db->get('dkm')->result();
		}
		$this->response($kontak, 200);
	}

	public function index_post(){
		$data = array(
			'id_dkm'		=> $this->post('id'),
			'uname_dkm'		=> $this->post('username'),
			'pass_dkm'		=> $this->post('password'),
			'alamat_dkm'	=> $this->post('alamat'),
			'tlp_dkm'		=> $this->post('telepon'),
			'email_dkm'		=> $this->post('email'),
			'ketua_dkm'		=> $this->post('ketua'),
			'masjid_dkm'	=> $this->post('masjid')
		);

		$insert = $this->db->insert('dkm',$data);
		if($insert){
			$this->response($data,200);
		} else{
			$this->response(array('status' => 'fail', 502));
		}
	}

	public function index_put(){
		$id_dkm = $this->put('id');
		$data = array(
			'id_dkm'		=> $this->put('id'),
			'uname_dkm'		=> $this->put('username'),
			'pass_dkm'		=> $this->put('password'),
			'alamat_dkm'	=> $this->put('alamat'),
			'tlp_dkm'		=> $this->put('telepon'),
			'email_dkm'		=> $this->put('email'),
			'ketua_dkm'		=> $this->put('ketua'),
			'masjid_dkm'	=> $this->put('masjid')
		);

		$this->db->where('id_dkm',$id_dkm);
		$update = $this->db->update('dkm',$data);
		if($update){
			$this->response($data,200);
		} else{
			$this->response(array('status' => 'fail', 502));
		}
	}

	public function index_delete(){
		$id_dkm = $this->delete('id');
		
		$this->db->where('id_dkm',$id_dkm);
		$delete = $this->db->delete('dkm');
		if($delete){
			$this->response(array('status' => 'success', 201));
		} else{
			$this->response(array('status' => 'fail', 502));
		}
	}
}