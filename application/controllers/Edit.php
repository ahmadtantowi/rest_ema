<?php

defined('BASEPATH') OR exit('No direct script access allowed');

require APPPATH . '/libraries/REST_Controller.php';
use Restserver\Libraries\REST_Controller;

class Edit extends REST_Controller {

	public function __construct($config = 'rest'){
		parent::__construct($config);
		$this->load->database();
	}


	public function index_post(){

		$id_event = $this->post('Id_Event');
		$id_dkm = $this->post('Id_Dkm');

		$params = json_decode(file_get_contents('php://input'), TRUE);
		
		$config['upload_path'] = './gambar/';
		$config['allowed_types'] = 'gif|jpg|png';
		$config['max_size'] = 10000;

		$this->load->library('upload');
		$this->upload->initialize($config);

		if($id_event != ''){
			
			if (! $this->upload->do_upload('Gambar')) {
			
				$data = array(
					'dkm_pelaksana'	=> $this->post('Dkm_Pelaksana'),
					'nama_event'	=> $this->post('Nama_Event'),
					'pemateri'		=> $this->post('Pemateri'),
					'lokasi_event'	=> $this->post('Lokasi_Event'),
					'tlp_event'		=> $this->post('Tlp_Event'),
					'waktu_event'	=> $this->post('Waktu_Event')
				);

				$this->db->where('id_event',$id_event);
				$update = $this->db->update('event',$data);

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
						'dkm_pelaksana'	=> $this->post('Dkm_Pelaksana'),
						'nama_event'	=> $this->post('Nama_Event'),
						'pemateri'		=> $this->post('Pemateri'),
						'gambar'		=> "https://eventmasjid.azurewebsites.net/gambar/".$params['filename'],
						'lokasi_event'	=> $this->post('Lokasi_Event'),
						'tlp_event'		=> $this->post('Tlp_Event'),
						'waktu_event'	=> $this->post('Waktu_Event')
					);

				}
			
				$this->db->where('id_event',$id_event);
				$update = $this->db->update('event',$data);
		    }

			if($update){
				$this->response($data,200);
			} else{
				$this->response(array('status' => 'fail', 502));
			}

		} else{

			$data = array(
				'alamat_dkm'	=> $this->post('Alamat_Dkm'),
				'tlp_dkm'		=> $this->post('Tlp_Dkm'),
				'email_dkm'		=> $this->post('Email_Dkm'),
				'ketua_dkm'		=> $this->post('Ketua_Dkm'),
				'masjid_dkm'	=> $this->post('Masjid_Dkm')
			);

			$this->db->where('id_dkm', $id_dkm);
			$update = $this->db->update('dkm', $data);

			if($update){
				$this->response($data,200);
			} else{
				$this->response(array('status' => 'fail', 502));
			}
		}
	}

}