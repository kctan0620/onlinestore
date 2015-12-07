<?php
class ModelToolWarranty extends Model {
	public function addWarranty($warranty) {
		
		if(!empty($data['warranty_id']) && isset($data['warranty_id']))
		{
			$this->db->query("UPDATE `" . DB_PREFIX . "warranty` SET status = 1 WHERE warranty_id = " . $data['warranty_id']);
		}
		else
		{						
			$this->db->query("INSERT INTO `" . DB_PREFIX . "warranty` SET `customer_id` = '" . $warranty['customer_id'] . "', `invoice_no` = '" . $warranty['invoice_no'] . "', `customer_name` = '" . $warranty['customer_name'] . "', `email` = '" . $warranty['email'] . "', `telephone` = '" . $warranty['telephone']."',  `ic_no` = '".$warranty['ic_no']."',  `address` = '".$warranty['address']."', `status` = 1 ");						
			return $this->db->getLastId();
		}				
	}
	
	public function getTotalWarranties() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM `" . DB_PREFIX . "warranty` o WHERE customer_id = '" . (int)$this->customer->getId() . "' ");
	
		return $query->row['total'];
	}
	
	public function getWarranties($start = 0, $limit = 20) {
		if ($start < 0) {
			$start = 0;
		}
	
		if ($limit < 1) {
			$limit = 1;
		}
	
		$query = $this->db->query("SELECT invoice_no, customer_name, email, created_dt, telephone FROM `" . DB_PREFIX . "warranty` WHERE customer_id = '" . (int)$this->customer->getId() . "' ORDER BY invoice_no DESC LIMIT " . (int)$start . "," . (int)$limit);
	
		return $query->rows;
	}

}