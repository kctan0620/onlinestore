<?php
class ModelEventEvent extends Model {
	public function addEvent($data) {
		//$this->event->trigger('pre.admin.event.add', $data);

		//user		
		$this->db->query("INSERT INTO " . DB_PREFIX . "event_page SET category_id = '" . (int)$data['category_id'] . "', main_banner = '" . $this->db->escape($data['main_banner']) . "' , create_dt = NOW()");
		$event_id = $this->db->getLastId();
		
		foreach ($data['name'] as $key => $value):
			$this->db->query("INSERT INTO " . DB_PREFIX . "event_page_description SET event_id = '" . (int)$event_id . "', event_description = '" . $this->db->escape($data['description'][$key]) . "', event_name = '" . $this->db->escape($data['name'][$key]) . "', event_url = '" . $this->db->escape($data['event_url'][$key]) . "', sort_by = '" . $this->db->escape($data['sort_by'][$key]) ."'");
			$event_description_id = $this->db->getLastId();			
			foreach ($data['product'][$key + 1] as $product_value) {				
				$this->db->query("INSERT INTO " . DB_PREFIX . "event_page_product SET event_description_id = '" . (int)$event_description_id . "', product_id = '" . (int)$product_value. "'");
			}		
		endforeach;
		
		//$this->event->trigger('post.admin.event.add', $event_id);

		return $event_id;
	}

	public function editEvent($event_id, $data) {
		
		//var_dump($data);
		//die();

		//$this->event->trigger('pre.admin.event.edit', $data);	
		$event_description = $this->getEventDescription($event_id);
		
		foreach ($event_description as $description) {
			$this->db->query("DELETE FROM " . DB_PREFIX . "event_page_product WHERE event_description_id = '" . (int)$description['event_description_id'] . "'");
		}
				
		$this->db->query("DELETE FROM " . DB_PREFIX . "event_page_description WHERE event_id = '" . (int)$event_id . "'");
		
		if (!empty($data['name']) && isset($data['name'])) {
			foreach ($data['name'] as $key => $value):
				if(isset($data['name'][$key]) && !empty($data['name'][$key])){
					
					$this->db->query("INSERT INTO " . DB_PREFIX . "event_page_description SET event_id = '" . (int)$event_id . "', event_description = '" . $data['description'][$key] . "', event_name = '" . $this->db->escape($data['name'][$key]) . "', event_url = '" . $this->db->escape($data['event_url'][$key]) ."', sort_by = '" . $this->db->escape($data['sort_by'][$key]) ."'");
					$event_description_id = $this->db->getLastId();
					if(!empty($data['product'][$key + 1]) && isset($data['product'][$key + 1])){
						foreach ($data['product'][$key + 1] as $product_value) {
							$this->db->query("INSERT INTO " . DB_PREFIX . "event_page_product SET event_description_id = '" . (int)$event_description_id . "', product_id = '" . (int)$product_value. "'");
						}
					}
				}				
			endforeach;
			
		}
				
		$this->db->query("UPDATE " . DB_PREFIX . "event_page SET category_id = '" . (int)$data['category_id'] . "', main_banner = '" . $this->db->escape($data['main_banner']) . "', update_dt =  NOW() WHERE event_id = '". (int)$event_id."'");

		//$this->event->trigger('post.admin.event.edit', $event_id);
	}

	public function deleteEvent($event_id) {
		$this->event->trigger('pre.admin.event.delete', $event_id);

		$this->db->query("DELETE FROM " . DB_PREFIX . "event WHERE event_id = '" . (int)$event_id . "'");

		$this->event->trigger('post.admin.event.delete', $event_id);
	}

	public function getEvent($event_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "event_page WHERE event_id = '" . (int)$event_id . "'");

		return $query->row;
	}
	
	public function getEventDescription($event_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "event_page_description WHERE event_id = '" . (int)$event_id . "'");
	
		return $query->rows;
	}

	public function getEventDescriptionProduct($event_description_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "event_page_product WHERE event_description_id = '" . (int)$event_description_id . "'");
	
		return $query->rows;
	}
	
	public function getEventByCategory($category_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "event_page WHERE category_id = '" . (int)$category_id . "' order by event_id desc limit 1");
	
		return $query->row;
	}
	
	public function getEvents($data = array()) {
		
		
		$sql = "SELECT event_id, catdesc.name as category_name, status FROM `" . DB_PREFIX . "event_page`  page inner join oc_category_description catdesc on page.category_id = catdesc.category_id";						
		
// 		if (!empty($data['filter_name'])) {
// 			$implode[] = "m.name LIKE '" . $this->db->escape($data['filter_name']) . "%'";
// 		}

// 		if (!empty($data['filter_code'])) {
// 			$implode[] = "m.code = '" . $this->db->escape($data['filter_code']) . "'";
// 		}

// 		if (!empty($data['filter_date_added'])) {
// 			$implode[] = "DATE(m.date_added) = DATE('" . $this->db->escape($data['filter_date_added']) . "')";
// 		}

		

// 		$sort_data = array(
// 			'm.name',
// 			'm.code',
// 			'm.date_added'
// 		);

// 		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
// 			$sql .= " ORDER BY " . $data['sort'];
// 		} else {
// 			$sql .= " ORDER BY name";
// 		}

// 		if (isset($data['order']) && ($data['order'] == 'DESC')) {
// 			$sql .= " DESC";
// 		} else {
// 			$sql .= " ASC";
// 		}

// 		if (isset($data['start']) || isset($data['limit'])) {
// 			if ($data['start'] < 0) {
// 				$data['start'] = 0;
// 			}

// 			if ($data['limit'] < 1) {
// 				$data['limit'] = 20;
// 			}

// 			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
// 		}

		$query = $this->db->query($sql);

		return $query->rows;
	}

	public function getTotalEvents($data = array()) {
		$sql = "SELECT COUNT(*) AS total FROM " . DB_PREFIX . "event_page";

		//$implode = array();

// 		if (!empty($data['filter_name'])) {
// 			$implode[] = "name LIKE '" . $this->db->escape($data['filter_name']) . "'";
// 		}

// 		if (!empty($data['filter_code'])) {
// 			$implode[] = "code = '" . $this->db->escape($data['filter_code']) . "'";
// 		}

// 		if (!empty($data['filter_date_added'])) {
// 			$implode[] = "DATE(date_added) = DATE('" . $this->db->escape($data['filter_date_added']) . "')";
// 		}

// 		if ($implode) {
// 			$sql .= " WHERE " . implode(" AND ", $implode);
// 		}

		$query = $this->db->query($sql);

		return $query->row['total'];
	}
}
