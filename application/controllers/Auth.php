<?php

defined('BASEPATH') OR exit('No direct script access allowed');

class Auth extends CI_Controller{
	
	public function __construct($config = 'rest'){
		parent::__construct($config);
		$this->load->database();
		$this->load->model('EmiModel');
		$this->load->helper('jsonoutput');
	}

	public function login(){
		$method = $_SERVER['REQUEST_METHOD'];

		if($method != 'POST'){
			jsonoutput(400, array('status' => 400,'message' => 'Bad request.'));
		} else{
			$check_auth_client = $this->EmiModel->check_auth_client();

			if($check_auth_client == true){
				$params = $_REQUEST;

				$uname 	= $params['username'];
				$pass	= $params['password'];

				$response = $this->EmiModel->login($uname,$pass);
					echo $response;
					jsonoutput($response['status'],$response);
			}
		}
	}

	public function logout(){
		$method = $_SERVER['REQUEST_METHOD'];

		if($method != 'POST'){
			jsonoutput(400,array('status' => 400,'message' => 'Bad request'));
		} else{
			$check_auth_client = $this->EmiModel->check_auth_client();

			if($check_auth_client == true){
				$response = $this->EmiModel->logout();
					jsonoutput($response['status'],$response);
			}
		}
	}
}