<?php

defined('BASEPATH') OR exit('No direct script access allowed');

require APPPATH . '/libraries/REST_Controller.php';
use Restserver\Libraries\REST_Controller;

class Dkm extends REST_Controller {

	public function __construct($config = 'rest'){
		parent::__construct($config);
		$this->load->database();
	}

	public function index_get(){
		$id_dkm = $this->get('Id_Dkm');
		$uname = $this->get('Uname_Dkm');
		$pass = $this->get('Pass_Dkm');

		if($uname != '' && $pass != ''){
			
			$this->db->where('uname_dkm',$uname);
			$this->db->where('pass_dkm',$pass);
			$dkm = $this->db->get('dkm')->result();
		} else {
			
			$this->db->where('uname_dkm',$uname);
			$dkm = $this->db->get('event')->result();
		}

		if($dkm){
			$this->response($dkm, 200);
		} else{
			$this->response(NULL, 400);
		}
	}

	public function index_post(){
		$data = array(
			'uname_dkm'		=> $this->post('Uname_Dkm'),
			'pass_dkm'		=> $this->post('Pass_Dkm'),
			'alamat_dkm'	=> $this->post('Alamat_Dkm'),
			'tlp_dkm'		=> $this->post('Tlp_Dkm'),
			'email_dkm'		=> $this->post('Email_Dkm'),
			'ketua_dkm'		=> $this->post('Ketua_Dkm'),
			'masjid_dkm'	=> $this->post('Masjid_Dkm'),
		);
		$insert = $this->db->insert('dkm', $data);
		if($insert){
			$this->response($data,200);
		} else{
			$this->response(array('status' => 'fail', 502));
		}

	}
/*
	public function index_post(){

		$params = json_decode(file_get_contents('php://input'), TRUE);
		
		$config['upload_path'] = './gambar_produk/';
		$config['allowed_types'] = 'gif|jpg|png';
		$config['max_size'] = 100;
		$config['max_width'] = 1024;
		$config['max_height'] = 768;

		$this->load->library('upload', $config);

		$encrypted_gambar = md5($params['orig_filename']);
		$params['orig_filename'] = $params['orig_filename'];
		$params['filename'] = $encrypted_gambar;
		$params['urlgambar']="https://eventmasjid.azurewebsites.net/index.php/gambar/$encrypted_gambar";

		$data = array(
			'id_event'		=> $this->post('id'),
			'nama_event'	=> $this->post('nama'),
			'pemateri'		=> $this->post('pemateri'),
			'gambar'		=> $params['filename'],
			'lokasi_event'	=> $this->post('lokasi'),
			'tlp_event'		=> $this->post('telpon'),
			'waktu_event'	=> $this->post('waktu')
		);
	

		$insert = $this->db->insert('event',$data);
		
		if($insert){
			$this->response($data,200);
		} else{
			$this->response(array('status' => 'fail', 502));
		}
	}
*/	

	public function index_put(){
		$id_event = $this->put('Id_Dkm');
		$uname = $this->put('Masjid_Dkm');

		$data = array(
			'alamat_dkm'	=> $this->put('Alamat_Dkm'),
			'tlp_dkm'		=> $this->put('Tlp_Dkm'),
			'email_dkm'		=> $this->put('Email_Dkm'),
			'ketua_dkm'		=> $this->put('Ketua_Dkm'),
			'masjid_dkm'	=> $this->put('Masjid_Dkm')
		);

		$this->db->where('id_event', $id_event);
		$update = $this->db->update('dkm', $data);

		$data_event = array(
			'dkm_pelaksana'		=> $this->put('masjid_dkm')
		);

		$this->db->where('uname_dkm',$uname);
		$update_event = $this->db->update('event',$data_event); 

		if($update && $update_event){
			$this->response($data,200);
		} else{
			$this->response(array('status' => 'fail', 502));
		}
	}

	

	public function index_delete(){
		$id = $this->delete('Id_Dkm');
		
		$this->db->where('id',$id_dkm);
		$delete = $this->db->delete('dkm');
		
		if($delete){
			$this->response(array('status' => 'success', 201));
		} else{
			$this->response(array('status' => 'fail', 502));
		}
	}
}