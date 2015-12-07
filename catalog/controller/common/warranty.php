<?php
class ControllerCommonWarranty extends Controller {
	private $error = array();
	
	public function index() {
		
		if (!$this->customer->isLogged()) {
			$this->session->data['redirect'] = $this->url->link('common/warranty', '', 'SSL');
		
			$this->response->redirect($this->url->link('account/login', '', 'SSL'));
		}
		
		$this->load->language('common/warranty');
		$this->load->model('account/customer');

		$data['text_warranty'] = $this->language->get('text_warranty');

		$data['action'] = $this->url->link('common/warranty/', '', $this->request->server['HTTPS']);
		
		$this->document->setTitle($this->config->get('config_meta_title'));
		$this->document->setDescription($this->config->get('config_meta_description'));
		$this->document->setKeywords($this->config->get('config_meta_keyword'));
		
		if (isset($this->request->get['route'])) {
			$this->document->addLink(HTTP_SERVER, 'canonical');
		}
		
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');
		
				
		$data['entry_invoice_no'] = $this->language->get('entry_invoice_no');
		$data['entry_name'] = $this->language->get('entry_name');
		$data['entry_email'] = $this->language->get('entry_email');
		$data['entry_telephone'] = $this->language->get('entry_telephone');
		$data['entry_ic'] = $this->language->get('entry_ic');
		$data['entry_address'] = $this->language->get('entry_address');
		
		$data['button_submit'] = $this->language->get('button_submit');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
									
			$form_submit 	= $this->request->post['formSubmit']; 
			$invoice_no 	= $this->request->post['invoice_no'];
			$customer_name 	= $this->request->post['customer_name'];
			$ic_no 			= $this->request->post['ic_no'];
			$telephone 		= $this->request->post['telephone'];
			$email 			= $this->request->post['email'];
			$address 		= $this->request->post['address'];
			
			$this->load->model('tool/warranty');
			$warranty = array();
			
			$warranty['customer_id'] = $this->customer->getId();						
			$warranty['invoice_no'] = $invoice_no;
			$warranty['customer_name'] = $customer_name;
			$warranty['ic_no'] = $ic_no;
			$warranty['telephone'] = $telephone;
			$warranty['email'] = $email;
			$warranty['address'] = $address;
			
			
			$warranty_id = $this->model_tool_warranty->addWarranty($warranty);
			if($warranty_id):
							
				// Add to activity log
				$this->load->model('account/activity');
				
				$activity_data = array(
						'customer_id' => $this->customer->getId(),
						'name'        => $this->customer->getFirstName() . ' ' . $this->customer->getLastName()
				);
				
				$this->model_account_activity->addActivity('submit_warranty', $activity_data);
				
				$this->session->data['success'] = $this->language->get('text_success');
				$this->response->redirect($this->url->link('common/warranty/summary_warranty', '', 'SSL'));
			endif;
		
			//$this->response->redirect($this->url->link('account/account', '', 'SSL'));
		}
		
		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}
		
		if (isset($this->error['customer_name'])) {
			$data['error_customer_name'] = $this->error['customer_name'];
		} else {
			$data['error_customer_name'] = '';
		}
		
		if (isset($this->error['email'])) {
			$data['error_email'] = $this->error['email'];
		} else {
			$data['error_email'] = '';
		}
		
		if (isset($this->error['telephone'])) {
			$data['error_telephone'] = $this->error['telephone'];
		} else {
			$data['error_telephone'] = '';
		}
		
		if (isset($this->error['ic_no'])) {
			$data['error_ic_no'] = $this->error['ic_no'];
		} else {
			$data['error_ic_no'] = '';
		}
		
		if (isset($this->error['address'])) {
			$data['error_address'] = $this->error['address'];
		} else {
			$data['error_address'] = '';
		}
		
		if (isset($this->error['invoice_no'])) {
			$data['error_invoice_no'] = $this->error['invoice_no'];
		} else {
			$data['error_invoice_no'] = '';
		}
		
		if (isset($this->error['custom_field'])) {
			$data['error_custom_field'] = $this->error['custom_field'];
		} else {
			$data['error_custom_field'] = array();
		}

		/* if(!empty($form_submit) && isset($form_submit)):
		
		endif; */
		
		$data['action'] = $this->url->link('common/warranty', '', 'SSL');
		
		if ($this->request->server['REQUEST_METHOD'] != 'POST') {
			$customer_info = $this->model_account_customer->getCustomer($this->customer->getId());
			$address_info = $this->model_account_customer->getAddressByCustomer($this->customer->getId());			
		}
		

		if (isset($this->request->post['customer_name'])) {
			$data['firstname'] = $this->request->post['customer_name'];
			$data['lastname'] = '';
		} elseif (!empty($customer_info)) {
			$data['firstname'] = $customer_info['firstname'];
			$data['lastname'] = $customer_info['lastname'];
		} else {
			$data['firstname'] = '';
			$data['lastname'] = '';
		}
		
		
		
		if (isset($this->request->post['email'])) {
			$data['email'] = $this->request->post['email'];
		} elseif (!empty($customer_info)) {
			$data['email'] = $customer_info['email'];
		} else {
			$data['email'] = '';
		}
		
		if (isset($this->request->post['telephone'])) {
			$data['telephone'] = $this->request->post['telephone'];
		} elseif (!empty($customer_info)) {
			$data['telephone'] = $customer_info['telephone'];
		} else {
			$data['telephone'] = '';
		}
		
		if (isset($this->request->post['ic_no'])) {
			$data['ic_no'] = $this->request->post['ic_no'];
		} else {
			$data['ic_no'] = '';
		}
				
		if (isset($this->request->post['address'])) {
			$data['address'] = $this->request->post['address'];			
		} elseif (!empty($customer_info) && !empty($address_info)) {
			$data['address'] = $address_info['address_1']. PHP_EOL .$address_info['address_2']. PHP_EOL .$address_info['postcode'].' '.$address_info['city']. PHP_EOL .$address_info['zone_name'].' '.$address_info['country_name'];			
		} else {
			$data['address'] = '';			
		}
		
		
		if (isset($this->request->post['invoice_no'])) {
			$data['invoice_no'] = $this->request->post['invoice_no'];
		} else {
			$data['invoice_no'] = '';
		}

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/warranty.tpl')) {
			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/common/warranty.tpl', $data));
		} else {
			$this->response->setOutput($this->load->view('default/template/common/warranty.tpl', $data));
		}
		
	}
	
	public function register_warranty() {
	
		$this->load->language('common/warranty');
	
		$data['text_warranty'] = $this->language->get('text_warranty');
	
		$data['action'] = $this->url->link('common/warranty/', '', $this->request->server['HTTPS']);
	
		$this->document->setTitle($this->config->get('config_meta_title'));
		$this->document->setDescription($this->config->get('config_meta_description'));
		$this->document->setKeywords($this->config->get('config_meta_keyword'));
	
		if (isset($this->request->get['route'])) {
			$this->document->addLink(HTTP_SERVER, 'canonical');
		}
	
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');
	
	
		$data['entry_invoice_no'] = $this->language->get('entry_invoice_no');
		$data['entry_name'] = $this->language->get('entry_name');
		$data['entry_email'] = $this->language->get('entry_email');
		$data['entry_telephone'] = $this->language->get('entry_telephone');
		$data['entry_ic'] = $this->language->get('entry_ic');
		$data['entry_address'] = $this->language->get('entry_address');
	
		
	
	}
	
	public function summary_warranty() {
	
		$this->load->language('common/warranty');
	
		$data['text_warranty'] = $this->language->get('text_warranty');
	
		$data['action'] = $this->url->link('common/warranty/', '', $this->request->server['HTTPS']);
	
		$this->document->setTitle($this->config->get('config_meta_title'));
		$this->document->setDescription($this->config->get('config_meta_description'));
		$this->document->setKeywords($this->config->get('config_meta_keyword'));
	
		if (isset($this->request->get['route'])) {
			$this->document->addLink(HTTP_SERVER, 'canonical');
		}
	
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');
	
	
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/warranty_summary.tpl')) {
			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/common/warranty_summary.tpl', $data));
		} else {
			$this->response->setOutput($this->load->view('default/template/common/warranty_summary.tpl', $data));
		}

	
	}
	
	public function history() {
		if (!$this->customer->isLogged()) {
			$this->session->data['redirect'] = $this->url->link('account/order', '', 'SSL');
		
			$this->response->redirect($this->url->link('account/login', '', 'SSL'));
		}
		
		$this->load->language('common/warranty');
		
		$this->document->setTitle($this->language->get('heading_title'));
		
		$data['breadcrumbs'] = array();
		
		$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_home'),
				'href' => $this->url->link('common/home')
		);
		
		$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_account'),
				'href' => $this->url->link('account/account', '', 'SSL')
		);
		
		$url = '';
		
		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}
		
		$data['breadcrumbs'][] = array(
				'text' => $this->language->get('heading_title'),
				'href' => $this->url->link('warranty/history', $url, 'SSL')
		);
		
		$data['heading_title'] = $this->language->get('heading_title');
		
		$data['text_empty'] = $this->language->get('text_empty');
		
		$data['column_invoice_no'] = $this->language->get('column_invoive_no');
		$data['column_name'] = $this->language->get('column_name');
		$data['column_telephone'] = $this->language->get('column_telephone');
		$data['column_email'] = $this->language->get('column_email');
		$data['column_address'] = $this->language->get('column_address');
		$data['column_created_dt'] = $this->language->get('column_created_dt');
		
		//$data['column_total'] = $this->language->get('column_total');
		
		$data['button_view'] = $this->language->get('button_view');
		$data['button_continue'] = $this->language->get('button_continue');
		
		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}
		
		$data['warranties'] = array();
		
		$this->load->model('tool/warranty');
		
		$warranty_total = $this->model_tool_warranty->getTotalWarranties();
		
		$results = $this->model_tool_warranty->getWarranties(($page - 1) * 10, 10);
		
		foreach ($results as $result) {
			
			$data['warranties'][] = array(
					'invoice_no'   => $result['invoice_no'],
					'customer_name'       => $result['customer_name'],
					'email'     => $result['email'],
					'created_dt' => $result['created_dt'],
					'telephone'   => $result['telephone'],
					'href'       => $this->url->link('common/warranty/info', 'invoice_no=' . $result['invoice_no'], 'SSL'),
			);
			
		}
		
		$pagination = new Pagination();
		$pagination->total = $warranty_total;
		$pagination->page = $page;
		$pagination->limit = 10;
		$pagination->url = $this->url->link('common/warranty/history', 'page={page}', 'SSL');
		
		$data['pagination'] = $pagination->render();
		
		$data['results'] = sprintf($this->language->get('text_pagination'), ($warranty_total) ? (($page - 1) * 10) + 1 : 0, ((($page - 1) * 10) > ($warranty_total - 10)) ? $warranty_total : ((($page - 1) * 10) + 10), $warranty_total, ceil($warranty_total / 10));
		
		$data['continue'] = $this->url->link('account/account', '', 'SSL');
		
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/warranty_list.tpl')) {
			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/common/warranty_list.tpl', $data));
		} else {
			$this->response->setOutput($this->load->view('default/template/common/warranty_list.tpl', $data));
		}
	}
	
	protected function validate() {
		if ((utf8_strlen($this->request->post['invoice_no']) < 1)) {			
			$this->error['invoice_no'] = $this->language->get('error_invoice_no');			
		}
				
		if ((utf8_strlen(trim($this->request->post['customer_name'])) < 1) || (utf8_strlen(trim($this->request->post['customer_name'])) > 32)) {
			$this->error['customer_name'] = $this->language->get('error_customer_name');
		}
		
		/* if ((utf8_strlen($this->request->post['ic_no']) < 1) || (utf8_strlen($this->request->post['ic_no']) > 12)) {
			$this->error['ic_no'] = $this->language->get('error_ic_no');
		} */
	
		if ((utf8_strlen($this->request->post['email']) > 96) || !preg_match('/^[^\@]+@.*.[a-z]{2,15}$/i', $this->request->post['email'])) {
			$this->error['email'] = $this->language->get('error_email');
		}
	
		if ((utf8_strlen($this->request->post['telephone']) < 1) || (utf8_strlen($this->request->post['telephone']) > 32)) {
			$this->error['telephone'] = $this->language->get('error_telephone');
		}
		
		if ((utf8_strlen($this->request->post['address']) < 1)) {
			$this->error['address'] = $this->language->get('error_address');
		}
			
				
		return !$this->error;
	}

	
}
