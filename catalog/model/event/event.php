<?php
class ModelEventEvent extends Model {
	
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
	
}
