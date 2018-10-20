<?php

defined('BASEPATH') OR exit('No direct script access allowed');

require APPPATH . '/libraries/REST_Controller.php';
use Restserver\Libraries\REST_Controller;

class Pull extends REST_Controller {

	public function __construct($config = 'rest'){
		parent::__construct($config);
		$this->load->database();
	}

	public function dkm_get(){
		$id_event = $this->get('Id_Dkm');
		if($id_event == ''){
			$event = $this->db->get('dmk')->result();
		} else{
			$this->db->where('id_dkm',$id);
			$event = $this->db->get('dkm')->result();
		}
	}
	public function index_get(){
		$id_dkm = $this->get('Id_Event');
		if($id_dkm == ''){
			$kontak = $this->db->get('event')->result();
		} else{
			$this->db->where('id_event',$id);
			$kontak = $this->db->get('event')->result();
		}
		$this->response($kontak, 200);
	}

	public function dkm_post(){
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
		$insert = $this->db->insert('dkm', $data);
		if($insert){
			$this->response($data,200);
		} else{
			$this->response(array('status' => 'fail', 502));
		}

	}

	public function index_post(){

		$params = json_decode(file_get_contents('php://input'), TRUE);
		
		$config['upload_path'] = './gambar/';
		$config['allowed_types'] = 'gif|jpg|png';
		$config['max_size'] = 10000;

		$this->load->library('upload');
		$this->upload->initialize($config);

		if(! $this->upload->do_upload('Gambar')){
			
			$data = array(
				'id_event'		=> $this->post('Id_Event'),
				'uname_dkm'		=> $this->post('Uname_Dkm'),
				'dkm_pelaksana'	=> $this->post('Dkm_Pelaksana'),
				'nama_event'	=> $this->post('Nama_Event'),
				'pemateri'		=> $this->post('Pemateri'),
				'lokasi_event'	=> $this->post('Lokasi_Event'),
				'tlp_event'		=> $this->post('Tlp_Event'),
				'waktu_event'	=> $this->post('Waktu_Event')
			);
		

			$insert = $this->db->insert('event',$data);
			
			if($insert){
				$this->response($data,200);
			} else{
				$this->response(array('status' => 'fail', 502));
			}
		} else{

			if ( ! $this->upload->do_upload('Gambar')){
		        $error = array('error' => $this->upload->display_errors());
		         print_r($error);
		    } else{
		        $data = $this->upload->data();

		        $encrypted_gambar = $data['file_name'];
				$params['orig_filename'] = $data['file_name'];
				$params['filename'] = $encrypted_gambar;
				$params['urlgambar']="https://eventmasjid.azurewebsites.net/index.php/gambar/$encrypted_gambar";

				$data = array(
					'id_event'		=> $this->post('Id_Event'),
					'uname_dkm'		=> $this->post('Uname_Dkm'),
					'dkm_pelaksana'	=> $this->post('Dkm_Pelaksana'),
					'nama_event'	=> $this->post('Nama_Event'),
					'pemateri'		=> $this->post('Pemateri'),
					'gambar'		=> "https://eventmasjid.azurewebsites.net/gambar/".$params['filename'],
					'lokasi_event'	=> $this->post('Lokasi_Event'),
					'tlp_event'		=> $this->post('Tlp_Event'),
					'waktu_event'	=> $this->post('Waktu_Event')
				);
			

				$insert = $this->db->insert('event',$data);
				
				if($insert){
					$this->response($data,200);
				} else{
					$this->response(array('status' => 'fail', 502));
				}
		    }
		}
	}

	public function index_put(){
		
		$id_event = $this->put('Id_Event');

		if ($this->put('Gambar') == null) {
			
			$data = array(
				'dkm_pelaksana'	=> $this->put('Dkm_Pelaksana'),
				'nama_event'	=> $this->put('Nama_Event'),
				'pemateri'		=> $this->put('Pemateri'),
				'lokasi_event'	=> $this->put('Lokasi_Event'),
				'tlp_event'		=> $this->put('Tlp_Event'),
				'waktu_event'	=> $this->put('Waktu_Event')
			);

			$this->db->where('id_event',$id_event);
			$update = $this->db->update('event',$data);
		} else{
			
			$params = json_decode(file_get_contents('php://input'), TRUE);
		
			$config['upload_path'] = './gambar/';
			$config['allowed_types'] = 'gif|jpg|png';
			$config['max_size'] = 10000;

			$this->load->library('upload');
			$this->upload->initialize($config);

			if ( ! $this->upload->do_upload('Gambar')){
		        
		        $error = array('error' => $this->upload->display_errors());
		        print_r($error);
		    } else{
		        
		        $data = $this->upload->data();

		        $encrypted_gambar = $data['file_name'];
				$params['orig_filename'] = $data['file_name'];
				$params['filename'] = $encrypted_gambar;
				$params['urlgambar']="https://eventmasjid.azurewebsites.net/index.php/gambar/$encrypted_gambar";

				$data = array(
					'dkm_pelaksana'	=> $this->put('Dkm_Pelaksana'),
					'nama_event'	=> $this->put('Nama_Event'),
					'pemateri'		=> $this->put('Pemateri'),
					'gambar'		=> "https://eventmasjid.azurewebsites.net/gambar/".$params['filename'],
					'lokasi_event'	=> $this->put('Lokasi_Event'),
					'tlp_event'		=> $this->put('Tlp_Event'),
					'waktu_event'	=> $this->put('Waktu_Event')
				);

			}
		
			$this->db->where('id_event',$id_event);
	    }

		if($update){
			$this->response($data,200);
		} else{
			$this->response(array('status' => 'fail', 502));
		}
	}

	public function get_delete(){
		$id_dkm = $this->get('Id_Event');
		
		$this->db->where('id_event',$id_dkm);
		$delete = $this->db->delete('event');
		if($delete){
			$this->response(array('status' => 'success', 201));
		} else{
			$this->response(array('status' => 'fail', 502));
		}
	}
}