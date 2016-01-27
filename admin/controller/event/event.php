<?php
class ControllerEventEvent extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('event/event');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('event/event');

		$this->getList();
	}

	public function add() {
		$this->load->language('event/event');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('event/event');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_event_event->addEvent($this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

// 			if (isset($this->request->get['filter_name'])) {
// 				$url .= '&filter_name=' . urlencode(html_entity_decode($this->request->get['filter_name'], ENT_QUOTES, 'UTF-8'));
// 			}

// 			if (isset($this->request->get['filter_code'])) {
// 				$url .= '&filter_code=' . $this->request->get['filter_code'];
// 			}

// 			if (isset($this->request->get['filter_date_added'])) {
// 				$url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
// 			}

// 			if (isset($this->request->get['sort'])) {
// 				$url .= '&sort=' . $this->request->get['sort'];
// 			}

// 			if (isset($this->request->get['order'])) {
// 				$url .= '&order=' . $this->request->get['order'];
// 			}

// 			if (isset($this->request->get['page'])) {
// 				$url .= '&page=' . $this->request->get['page'];
// 			}

			$this->response->redirect($this->url->link('event/event', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getForm();
	}

	public function edit() {
		$this->load->language('event/event');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('event/event');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_event_event->editEvent($this->request->get['event_id'], $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

// 			if (isset($this->request->get['filter_name'])) {
// 				$url .= '&filter_name=' . urlencode(html_entity_decode($this->request->get['filter_name'], ENT_QUOTES, 'UTF-8'));
// 			}

// 			if (isset($this->request->get['filter_code'])) {
// 				$url .= '&filter_code=' . $this->request->get['filter_code'];
// 			}

// 			if (isset($this->request->get['filter_date_added'])) {
// 				$url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
// 			}

// 			if (isset($this->request->get['sort'])) {
// 				$url .= '&sort=' . $this->request->get['sort'];
// 			}

// 			if (isset($this->request->get['order'])) {
// 				$url .= '&order=' . $this->request->get['order'];
// 			}

// 			if (isset($this->request->get['page'])) {
// 				$url .= '&page=' . $this->request->get['page'];
// 			}

			$this->response->redirect($this->url->link('event/event', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getForm();
	}

	public function delete() {
		$this->load->language('event/event');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('event/event');

		if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $event_id) {
				$this->model_event_event->deleteEvent($event_id);
			}

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['filter_name'])) {
				$url .= '&filter_name=' . urlencode(html_entity_decode($this->request->get['filter_name'], ENT_QUOTES, 'UTF-8'));
			}

			if (isset($this->request->get['filter_code'])) {
				$url .= '&filter_code=' . $this->request->get['filter_code'];
			}

			if (isset($this->request->get['filter_date_added'])) {
				$url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->response->redirect($this->url->link('event/event', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getList();
	}

	protected function getList() {
		if (isset($this->request->get['filter_id'])) {
			$filter_id = $this->request->get['filter_id'];
		} else {
			$filter_id = null;
		}

		if (isset($this->request->get['filter_category'])) {
			$filter_category = $this->request->get['filter_category'];
		} else {
			$filter_category = null;
		}

		if (isset($this->request->get['filter_status'])) {
			$filter_status = $this->request->get['filter_status'];
		} else {
			$filter_status = null;
		}

		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'name';
		}

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		$url = '';

		if (isset($this->request->get['filter_id'])) {
			$url .= '&filter_id=' . urlencode(html_entity_decode($this->request->get['filter_id'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['filter_category'])) {
			$url .= '&filter_category=' . $this->request->get['filter_category'];
		}

		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}
		
		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('event/event', 'token=' . $this->session->data['token'] . $url, 'SSL')
		);

		$data['add'] = $this->url->link('event/event/add', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$data['delete'] = $this->url->link('event/event/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');

		$data['events'] = array();

		$filter_data = array(
			'filter_id'       => $filter_id,
			'filter_category' => $filter_category,
			'filter_status' => $filter_status,
			'sort'              => $sort,			
			'start'             => ($page - 1) * $this->config->get('config_limit_admin'),
			'limit'             => $this->config->get('config_limit_admin')
		);

		$event_total = $this->model_event_event->getTotalEvents($filter_data);

		$results = $this->model_event_event->getEvents($filter_data);

		foreach ($results as $result) {
			$data['events'][] = array(
				'event_id' => $result['event_id'],				
				'category_name' => $result['category_name'],
				'status' => $result['status'],				
				'edit'         => $this->url->link('event/event/edit', 'token=' . $this->session->data['token'] . '&event_id=' . $result['event_id'] . $url, 'SSL')
			);
		}
				
		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_list'] = $this->language->get('text_list');
		$data['text_no_results'] = $this->language->get('text_no_results');
		$data['text_confirm'] = $this->language->get('text_confirm');

		$data['column_id'] = $this->language->get('column_id');
		$data['column_category'] = $this->language->get('column_category');
		$data['column_clicks'] = $this->language->get('column_clicks');
		$data['column_orders'] = $this->language->get('column_orders');
		$data['column_status'] = $this->language->get('column_status');
		$data['column_action'] = $this->language->get('column_action');

		$data['entry_id'] = $this->language->get('entry_id');
		$data['entry_category'] = $this->language->get('entry_category');
		$data['entry_status'] = $this->language->get('entry_status');

		$data['button_add'] = $this->language->get('button_add');
		$data['button_edit'] = $this->language->get('button_edit');
		$data['button_delete'] = $this->language->get('button_delete');
		$data['button_filter'] = $this->language->get('button_filter');

		$data['token'] = $this->session->data['token'];

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];

			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}

		if (isset($this->request->post['selected'])) {
			$data['selected'] = (array)$this->request->post['selected'];
		} else {
			$data['selected'] = array();
		}

		$url = '';

		if (isset($this->request->get['filter_id'])) {
			$url .= '&filter_id=' . urlencode(html_entity_decode($this->request->get['filter_id'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['filter_category'])) {
			$url .= '&filter_category=' . $this->request->get['filter_category'];
		}

		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}		

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$data['sort_id'] = $this->url->link('event/event', 'token=' . $this->session->data['token'] . '&sort=m.event_id' . $url, 'SSL');
		$data['sort_category'] = $this->url->link('event/event', 'token=' . $this->session->data['token'] . '&sort=m.category_id' . $url, 'SSL');
		$data['sort_status'] = $this->url->link('event/event', 'token=' . $this->session->data['token'] . '&sort=m.status' . $url, 'SSL');

		$url = '';

		if (isset($this->request->get['filter_id'])) {
			$url .= '&filter_id=' . urlencode(html_entity_decode($this->request->get['filter_id'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['filter_code'])) {
			$url .= '&filter_category=' . $this->request->get['filter_category'];
		}

		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$pagination = new Pagination();
		$pagination->total = $event_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_limit_admin');
		$pagination->url = $this->url->link('event/event', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');

		$data['pagination'] = $pagination->render();

		$data['results'] = sprintf($this->language->get('text_pagination'), ($event_total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($event_total - $this->config->get('config_limit_admin'))) ? $event_total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $event_total, ceil($event_total / $this->config->get('config_limit_admin')));

		$data['filter_id'] = $filter_id;
		$data['filter_category'] = $filter_category;
		$data['filter_status'] = $filter_status;

		$data['sort'] = $sort;		

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('event/event_list.tpl', $data));
	}

	protected function getForm() {
		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_form'] = !isset($this->request->get['event_id']) ? $this->language->get('text_add') : $this->language->get('text_edit');

		$data['entry_name'] = $this->language->get('entry_name');
		$data['entry_description'] = $this->language->get('entry_description');
		$data['entry_code'] = $this->language->get('entry_code');
		$data['entry_example'] = $this->language->get('entry_example');

		$data['help_code'] = $this->language->get('help_code');
		$data['help_example'] = $this->language->get('help_example');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->error['name'])) {
			$data['error_name'] = $this->error['name'];
		} else {
			$data['error_name'] = '';
		}

		if (isset($this->error['code'])) {
			$data['error_code'] = $this->error['code'];
		} else {
			$data['error_code'] = '';
		}

		$url = '';

		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . urlencode(html_entity_decode($this->request->get['filter_name'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['filter_code'])) {
			$url .= '&filter_code=' . $this->request->get['filter_code'];
		}

		if (isset($this->request->get['filter_date_added'])) {
			$url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
		}

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('event/event', 'token=' . $this->session->data['token'] . $url, 'SSL')
		);

		if (!isset($this->request->get['event_id'])) {
			$data['action'] = $this->url->link('event/event/add', 'token=' . $this->session->data['token'] . $url, 'SSL');
		} else {
			$data['action'] = $this->url->link('event/event/edit', 'token=' . $this->session->data['token'] . '&event_id=' . $this->request->get['event_id'] . $url, 'SSL');
		}

		$data['cancel'] = $this->url->link('event/event', 'token=' . $this->session->data['token'] . $url, 'SSL');

		if (isset($this->request->get['event_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$event_info = $this->model_event_event->getEvent($this->request->get['event_id']);	
			$event_description_info = $this->model_event_event->getEventDescription($this->request->get['event_id']);
						
			foreach ($event_description_info as $description) {

				
				$event_description_product = $this->model_event_event->getEventDescriptionProduct($description['event_description_id']);
				
				$data['events'][] = array(
						'event_id' => $description['event_id'],
						'event_name' => $description['event_name'],
						'event_url' => $description['event_url'],
						'event_description' => $description['event_description'],
						'event_description_id' => $description['event_description_id'],						
						'sort_by' => $description['sort_by'],												
						'products' => $event_description_product
				);
				
			}			
			
		}

		$data['token'] = $this->session->data['token'];

		$data['store'] = HTTP_CATALOG;
		
		if (isset($this->request->post['category_id'])) {
			$data['category_id'] = $this->request->post['category_id'];
		} elseif (!empty($event_info)) {
			$data['category_id'] = $event_info['category_id'];
		} else {
			$data['category_id'] = '';
		}		
		
		if (isset($this->request->post['main_banner'])) {
			$data['main_banner'] = $this->request->post['main_banner'];
		} elseif (!empty($event_info)) {
			$data['main_banner'] = $event_info['main_banner'];
		} else {
			$data['main_banner'] = '';
		}
		
		

// 		if (isset($this->request->post['code'])) {
// 			$data['code'] = $this->request->post['code'];
// 		} elseif (!empty($event_info)) {
// 			$data['code'] = $event_info['code'];
// 		} else {
// 			$data['code'] = uniqid();
// 		}

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('event/event_form.tpl', $data));
	}

	protected function validateForm() {
// 		if (!$this->user->hasPermission('modify', 'event/event')) {
// 			$this->error['warning'] = $this->language->get('error_permission');
// 		}

// 		if ((utf8_strlen($this->request->post['name']) < 1) || (utf8_strlen($this->request->post['name']) > 32)) {
// 			$this->error['name'] = $this->language->get('error_name');
// 		}

// 		if (!$this->request->post['code']) {
// 			$this->error['code'] = $this->language->get('error_code');
// 		}

		return !$this->error;
	}

	protected function validateDelete() {
		if (!$this->user->hasPermission('modify', 'event/event')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}
}