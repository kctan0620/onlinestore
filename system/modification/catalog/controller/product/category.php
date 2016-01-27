<?php
class ControllerProductCategory extends Controller {
	public function index() {
		$this->load->language('product/category');

		$this->load->model('catalog/category');

		$this->load->model('catalog/product');

                $this->load->model('journal2/product');
            
                $this->load->model('event/event');

		$this->load->model('tool/image');

		if (isset($this->request->get['filter'])) {
			$filter = $this->request->get['filter'];
		} else {
			$filter = '';
		}

		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'p.sort_order';
		}

		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'ASC';
		}

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		if (isset($this->request->get['limit'])) {
			$limit = $this->request->get['limit'];
		} else {
			$limit = $this->config->get('config_product_limit');
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		if (isset($this->request->get['path'])) {
			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$path = '';

			$parts = explode('_', (string)$this->request->get['path']);

			$category_id = (int)array_pop($parts);

			foreach ($parts as $path_id) {
				if (!$path) {
					$path = (int)$path_id;
				} else {
					$path .= '_' . (int)$path_id;
				}

				$category_info = $this->model_catalog_category->getCategory($path_id);

				if ($category_info) {
					$data['breadcrumbs'][] = array(
						'text' => $category_info['name'],
						'href' => $this->url->link('product/category', 'path=' . $path . $url)
					);
				}
			}
		} else {
			$category_id = 0;
		}

		$category_info = $this->model_catalog_category->getCategory($category_id);

		if ($category_info) {
			$this->document->setTitle($category_info['meta_title']);
			$this->document->setDescription($category_info['meta_description']);
			$this->document->setKeywords($category_info['meta_keyword']);
			$this->document->addLink($this->url->link('product/category', 'path=' . $this->request->get['path']), 'canonical');

			$data['heading_title'] = $category_info['name'];

			$data['text_refine'] = $this->language->get('text_refine');
			$data['text_empty'] = $this->language->get('text_empty');
			$data['text_quantity'] = $this->language->get('text_quantity');
			$data['text_manufacturer'] = $this->language->get('text_manufacturer');
			$data['text_model'] = $this->language->get('text_model');
			$data['text_price'] = $this->language->get('text_price');
			$data['text_tax'] = $this->language->get('text_tax');
			$data['text_points'] = $this->language->get('text_points');
			$data['text_compare'] = sprintf($this->language->get('text_compare'), (isset($this->session->data['compare']) ? count($this->session->data['compare']) : 0));
			$data['text_sort'] = $this->language->get('text_sort');
			$data['text_limit'] = $this->language->get('text_limit');

			$data['button_cart'] = $this->language->get('button_cart');
			$data['button_wishlist'] = $this->language->get('button_wishlist');
			$data['button_compare'] = $this->language->get('button_compare');
			$data['button_continue'] = $this->language->get('button_continue');
			$data['button_list'] = $this->language->get('button_list');
			$data['button_grid'] = $this->language->get('button_grid');

			// Set the last category breadcrumb
			$data['breadcrumbs'][] = array(
				'text' => $category_info['name'],
				'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'])
			);

			if ($category_info['image']) {
				$data['thumb'] = $this->model_tool_image->resize($category_info['image'], $this->config->get('config_image_category_width'), $this->config->get('config_image_category_height'));
			} else {
				$data['thumb'] = '';
			}

			$data['description'] = html_entity_decode($category_info['description'], ENT_QUOTES, 'UTF-8');
			$data['compare'] = $this->url->link('product/compare');

			$url = '';

			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$data['categories'] = array();

			$results = $this->model_catalog_category->getCategories($category_id);

			foreach ($results as $result) {
				$filter_data = array(
					'filter_category_id'  => $result['category_id'],
					'filter_sub_category' => true
				);

				$data['categories'][] = array(
					'name'  => $result['name'] . ($this->config->get('config_product_count') ? ' (' . $this->model_catalog_product->getTotalProducts($filter_data) . ')' : ''),
					'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '_' . $result['category_id'] . $url)
				);
			}

			$data['products'] = array();

			$filter_data = array(
				'filter_category_id' => $category_id,
				'filter_filter'      => $filter,
				'sort'               => $sort,
				'order'              => $order,
				'start'              => ($page - 1) * $limit,
				'limit'              => $limit
			);

			$product_total = $this->model_catalog_product->getTotalProducts($filter_data);

			$results = $this->model_catalog_product->getProducts($filter_data);

			foreach ($results as $result) {
				if ($result['image']) {
					$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
				} else {
					$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
				}

				if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
					$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
				} else {
					$price = false;
				}

				if ((float)$result['special']) {
					$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
				} else {
					$special = false;
				}

				if ($this->config->get('config_tax')) {
					$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
				} else {
					$tax = false;
				}

				if ($this->config->get('config_review_status')) {
					$rating = (int)$result['rating'];
				} else {
					$rating = false;
				}


                $date_end = false;
                if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
                    $this->load->model('journal2/product');
                    $date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
                    if ($date_end === '0000-00-00') {
                        $date_end = false;
                    }
                }
            

                $additional_images = $this->model_catalog_product->getProductImages($result['product_id']);

                $image2 = false;

                if (count($additional_images) > 0) {
                    $image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
                }
            
				$data['products'][] = array(
					'product_id'  => $result['product_id'],
					'thumb'       => $image,

                'thumb2'       => $image2,
            

                'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
            
					'name'        => $result['name'],
					'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
					'price'       => $price,
					'special'     => $special,

                'date_end'       => $date_end,
            
					'tax'         => $tax,
					'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
					'rating'      => $result['rating'],
					'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
				);
			}
			
			
			//Check Event Page
			$category_info = $this->model_event_event->getEventByCategory($category_id);
						
			if(isset($category_info) && !empty($category_info)):
				$event_description = $this->model_event_event->getEventDescription($category_info['event_id']);
				$i = 0;
				foreach ($event_description as $description) {					
					$arr_product_group = array();
					
					$products = $this->model_event_event->getEventDescriptionProduct($description['event_description_id']);
													
					foreach ($products as $product) {						
						array_push($arr_product_group, $product['product_id']);
					}
					
					$result_group = $this->model_catalog_product->getParticularProducts($arr_product_group);
					
					foreach ($result_group as $result) {
						if ($result['image']) {
							$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
						} else {
							$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
						}
					
						if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
							$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
						} else {
							$price = false;
						}
					
						if ((float)$result['special']) {
							$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
						} else {
							$special = false;
						}
					
						if ($this->config->get('config_tax')) {
							$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
						} else {
							$tax = false;
						}
					
						if ($this->config->get('config_review_status')) {
							$rating = (int)$result['rating'];
						} else {
							$rating = false;
						}
					
					
						$date_end = false;
						if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
							$this->load->model('journal2/product');
							$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
							if ($date_end === '0000-00-00') {
								$date_end = false;
							}
						}
					
					
						$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
					
						$image2 = false;
					
						if (count($additional_images) > 0) {
							$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
						}
					
						$data['product_group'][$i][] = array(
								'product_id'  => $result['product_id'],
								'thumb'       => $image,
					
								'thumb2'       => $image2,
					
					
								'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
					
								'name'        => $result['name'],
								'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
								'price'       => $price,
								'special'     => $special,
					
								'date_end'       => $date_end,
					
								'tax'         => $tax,
								'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
								'rating'      => $result['rating'],
								'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
						);
						
					}
					unset($arr_product_group);
					
					//$data['product_group'][$description['event_description_id']] = $data['product_group'];					
					$i++;
				}
				
				$data['event_description'] = $event_description;
				$data['event_page'] = $category_info;
			endif;
						
			
			//Intel Page has specific products to feature into category page
			$arr_intel_group0 = array(1876,1854,1858,3092,4147); // Free Gift //1876
			$arr_intel_group1 = array(1867,1929,1930,1932,1151,1896,1853,1936); // 2 in 1			
			$arr_intel_group2 = array(1855,1826,1478,1857,1919,1888,1863,1716); // Notebook
			$arr_intel_group3 = array(1876,1875,1871,1870,1868,1869,1872,1270); // All in one
										
			$result_group0 = $this->model_catalog_product->getParticularProducts($arr_intel_group0);
			$result_group1 = $this->model_catalog_product->getParticularProducts($arr_intel_group1);
			$result_group2 = $this->model_catalog_product->getParticularProducts($arr_intel_group2);
			$result_group3 = $this->model_catalog_product->getParticularProducts($arr_intel_group3);

			if ($result_group0) {
				foreach ($result_group0 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
			
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
			
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
			
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
			
			
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
			
			
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
			
					$image2 = false;
			
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					$data['products_group0'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
			
							'thumb2'       => $image2,
			
			
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
			
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
			
							'date_end'       => $date_end,
			
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
			
			if ($result_group1) {
				foreach ($result_group1 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
				
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
				
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
				
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
				
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
				
				
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
				
				
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
				
					$image2 = false;
				
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
				
					$data['products_group1'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
				
							'thumb2'       => $image2,
				
				
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
				
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
				
							'date_end'       => $date_end,
				
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
				
			if ($result_group2) {
				foreach ($result_group2 as $result) {
						if ($result['image']) {
							$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
						} else {
							$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
						}
					
						if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
							$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
						} else {
							$price = false;
						}
					
						if ((float)$result['special']) {
							$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
						} else {
							$special = false;
						}
					
						if ($this->config->get('config_tax')) {
							$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
						} else {
							$tax = false;
						}
					
						if ($this->config->get('config_review_status')) {
							$rating = (int)$result['rating'];
						} else {
							$rating = false;
						}
					
					
						$date_end = false;
						if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
							$this->load->model('journal2/product');
							$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
							if ($date_end === '0000-00-00') {
								$date_end = false;
							}
						}
					
					
						$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
					
						$image2 = false;
					
						if (count($additional_images) > 0) {
							$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
						}
					
						$data['products_group2'][] = array(
								'product_id'  => $result['product_id'],
								'thumb'       => $image,
					
								'thumb2'       => $image2,
					
					
								'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
					
								'name'        => $result['name'],
								'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
								'price'       => $price,
								'special'     => $special,
					
								'date_end'       => $date_end,
					
								'tax'         => $tax,
								'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
								'rating'      => $result['rating'],
								'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
						);
					}
			}
				
			if ($result_group3) {
				foreach ($result_group3 as $result) {
						if ($result['image']) {
							$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
						} else {
							$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
						}
					
						if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
							$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
						} else {
							$price = false;
						}
					
						if ((float)$result['special']) {
							$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
						} else {
							$special = false;
						}
					
						if ($this->config->get('config_tax')) {
							$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
						} else {
							$tax = false;
						}
					
						if ($this->config->get('config_review_status')) {
							$rating = (int)$result['rating'];
						} else {
							$rating = false;
						}
					
					
						$date_end = false;
						if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
							$this->load->model('journal2/product');
							$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
							if ($date_end === '0000-00-00') {
								$date_end = false;
							}
						}
					
					
						$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
					
						$image2 = false;
					
						if (count($additional_images) > 0) {
							$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
						}
					
						$data['products_group3'][] = array(
								'product_id'  => $result['product_id'],
								'thumb'       => $image,
					
								'thumb2'       => $image2,
					
					
								'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
					
								'name'        => $result['name'],
								'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
								'price'       => $price,
								'special'     => $special,
					
								'date_end'       => $date_end,
					
								'tax'         => $tax,
								'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
								'rating'      => $result['rating'],
								'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
						);
					}
			}
			
			//Microsoft Page has specific products to feature into category page
			$arr_microsoft_group1 = array(1947,1946,1948,1949); // Microsoft Surface Pro 4
			$arr_microsoft_group2 = array(1714,1713,1710,1709); // Microsoft Surface Pro 3
			$arr_microsoft_group3 = array(1707,1705,1706,590); // Type Cover
			
			$result_microsoft_group1 = $this->model_catalog_product->getParticularProducts($arr_microsoft_group1);
			$result_microsoft_group2 = $this->model_catalog_product->getParticularProducts($arr_microsoft_group2);
			$result_microsoft_group3 = $this->model_catalog_product->getParticularProducts($arr_microsoft_group3);
			
			if ($result_microsoft_group1) {
				foreach ($result_microsoft_group1 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
			
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
			
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
			
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
			
			
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
			
			
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
			
					$image2 = false;
			
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					$data['products_microsoft_group1'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
			
							'thumb2'       => $image2,
			
			
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
			
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
			
							'date_end'       => $date_end,
			
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
			
			if ($result_microsoft_group2) {
				foreach ($result_microsoft_group2 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
						
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
						
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
						
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
						
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
						
						
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
						
						
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
						
					$image2 = false;
						
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
						
					$data['products_microsoft_group2'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
								
							'thumb2'       => $image2,
								
								
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
								
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
								
							'date_end'       => $date_end,
								
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
			
			if ($result_microsoft_group3) {
				foreach ($result_microsoft_group3 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
						
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
						
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
						
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
						
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
						
						
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
						
						
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
						
					$image2 = false;
						
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
						
					$data['products_microsoft_group3'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
								
							'thumb2'       => $image2,
								
								
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
								
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
								
							'date_end'       => $date_end,
								
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}	
						
			// Intel Make Magic - December Special Promotion			
			//Intel Page has specific products to feature into category page
// 			$arr_intel_christmas_group1 = array(1876,1854,1858,3092,4147); // Free Gift Will Question Customer //1876
// 			$result_intel_christmas_group0 = $this->model_catalog_product->getParticularProducts($arr_intel_christmas_group1);			
			
// 			if ($result_intel_christmas_group0) {
// 				foreach ($result_intel_christmas_group0 as $result) {
// 					if ($result['image']) {
// 						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
// 					} else {
// 						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
// 					}
						
// 					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
// 						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
// 					} else {
// 						$price = false;
// 					}
						
// 					if ((float)$result['special']) {
// 						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
// 					} else {
// 						$special = false;
// 					}
						
// 					if ($this->config->get('config_tax')) {
// 						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
// 					} else {
// 						$tax = false;
// 					}
						
// 					if ($this->config->get('config_review_status')) {
// 						$rating = (int)$result['rating'];
// 					} else {
// 						$rating = false;
// 					}
						
						
// 					$date_end = false;
// 					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
// 						$this->load->model('journal2/product');
// 						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
// 						if ($date_end === '0000-00-00') {
// 							$date_end = false;
// 						}
// 					}
						
						
// 					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
						
// 					$image2 = false;
						
// 					if (count($additional_images) > 0) {
// 						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
// 					}
						
// 					$data['products_intel_christmas_group1'][] = array(
// 							'product_id'  => $result['product_id'],
// 							'thumb'       => $image,
								
// 							'thumb2'       => $image2,
								
								
// 							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
								
// 							'name'        => $result['name'],
// 							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
// 							'price'       => $price,
// 							'special'     => $special,
								
// 							'date_end'       => $date_end,
								
// 							'tax'         => $tax,
// 							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
// 							'rating'      => $result['rating'],
// 							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
// 					);
// 				}
// 			}

			//Gaming Page has specific products to feature into category page
			
			$arr_gaming_group1 = array(2601,2576,2600,2574,2575,2595,2596,2597,2598,2599,2578,371,234,2576,2577,2573); // DOTA 2
			//$arr_gaming_group1 = array(2570,2571,2572,2574,2575,2595,2596,2597,2598,2599,2578,371,234,2576,2577,2573); // DOTA 2
			$arr_gaming_group2 = array(1364,1937,1367,2569,1938,1939,1940,1941); // Game Code
			$arr_gaming_group3 = array(2582,2585,2586,2590,2591,2592,2593,2594); // TOS & Card Game
			$arr_gaming_group4 = array(2584,2583,2587,2588,2589,1138,1080,1082); // Gaming PC & Laptop
			$arr_gaming_group5 = array(2580,1839,577,1969,2581,14,1669,2579); // Gaming Keyboard & Mouse
			$arr_gaming_group6 = array(1707,1705,1706,590); // Type Cover
			
			$result_gaming_group1 = $this->model_catalog_product->getParticularProducts($arr_gaming_group1);
			$result_gaming_group2 = $this->model_catalog_product->getParticularProducts($arr_gaming_group2);
			$result_gaming_group3 = $this->model_catalog_product->getParticularProducts($arr_gaming_group3);
			$result_gaming_group4 = $this->model_catalog_product->getParticularProducts($arr_gaming_group4);
			$result_gaming_group5 = $this->model_catalog_product->getParticularProducts($arr_gaming_group5);
			$result_gaming_group6 = $this->model_catalog_product->getParticularProducts($arr_gaming_group6);
			
			if ($result_gaming_group1) {
				foreach ($result_gaming_group1 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
						
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
						
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
						
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
						
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
						
						
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
						
						
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
						
					$image2 = false;
						
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
						
					$data['products_gaming_group1'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
								
							'thumb2'       => $image2,
								
								
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
								
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
								
							'date_end'       => $date_end,
								
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
				
			if ($result_gaming_group2) {
				foreach ($result_gaming_group2 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
			
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
			
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
			
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
			
			
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
			
			
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
			
					$image2 = false;
			
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					$data['products_gaming_group2'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
			
							'thumb2'       => $image2,
			
			
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
			
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
			
							'date_end'       => $date_end,
			
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
				
			if ($result_gaming_group3) {
				foreach ($result_gaming_group3 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
			
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
			
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
			
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
			
			
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
			
			
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
			
					$image2 = false;
			
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					$data['products_gaming_group3'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
			
							'thumb2'       => $image2,
			
			
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
			
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
			
							'date_end'       => $date_end,
			
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
			
			if ($result_gaming_group4) {
				foreach ($result_gaming_group4 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
			
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
			
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
			
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
			
			
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
			
			
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
			
					$image2 = false;
			
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					$data['products_gaming_group4'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
			
							'thumb2'       => $image2,
			
			
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
			
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
			
							'date_end'       => $date_end,
			
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
			
			if ($result_gaming_group5) {
				foreach ($result_gaming_group5 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
			
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
			
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
			
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
			
			
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
			
			
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
			
					$image2 = false;
			
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					$data['products_gaming_group5'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
			
							'thumb2'       => $image2,
			
			
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
			
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
			
							'date_end'       => $date_end,
			
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
			
			if ($result_gaming_group6) {
				foreach ($result_gaming_group6 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
						
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
						
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
						
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
						
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
						
						
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
						
						
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
						
					$image2 = false;
						
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
						
					$data['products_gaming_group6'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
								
							'thumb2'       => $image2,
								
								
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
								
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
								
							'date_end'       => $date_end,
								
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
			//end of gaming event
			
			
			//starting WD event page
			//Gaming Page has specific products to feature into category page
				
			/* $arr_wd_group1 = array(2602,2603,2604,2605); // WD My Cloud Series
			$arr_wd_group2 = array(2606,2607,2609); // WD My Passport Wireless
			$arr_wd_group3 = array(2615,3972,2614,2613,2616,2619,2558,3649,3646,3647,3648,3650,3653,3652,3651,3655,3656); // WD Others			 */
						
			$arr_wd_group1 = array(2932); // WD My Cloud Mirror Series
			$arr_wd_group2 = array(2602,2603,2604,2605); // WD My Cloud Series
			$arr_wd_group3 = array(2606,2607); // WD My Passport Wireless
			$arr_wd_group4 = array(2615,3972,2614,2613); // WD Portable Storage
			$arr_wd_group5 = array(2609,2616,2619,2558,3649,3646,3647,3648,3650,3653,3652,3651,3655,3656); // WD My Passport Wireless
			
			
			$result_wd_group1 = $this->model_catalog_product->getParticularProducts($arr_wd_group1);
			$result_wd_group2 = $this->model_catalog_product->getParticularProducts($arr_wd_group2);
			$result_wd_group3 = $this->model_catalog_product->getParticularProducts($arr_wd_group3);
			$result_wd_group4 = $this->model_catalog_product->getParticularProducts($arr_wd_group4);
			$result_wd_group5 = $this->model_catalog_product->getParticularProducts($arr_wd_group5);
		
			if ($result_wd_group1) {
				foreach ($result_wd_group1 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
			
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
			
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
			
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
			
			
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
			
			
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
			
					$image2 = false;
			
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					$data['products_wd_group1'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
			
							'thumb2'       => $image2,
			
			
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
			
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
			
							'date_end'       => $date_end,
			
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
			
			if ($result_wd_group2) {
				foreach ($result_wd_group2 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
						
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
						
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
						
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
						
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
						
						
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
						
						
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
						
					$image2 = false;
						
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
						
					$data['products_wd_group2'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
								
							'thumb2'       => $image2,
								
								
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
								
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
								
							'date_end'       => $date_end,
								
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
			
			if ($result_wd_group3) {
				foreach ($result_wd_group3 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
						
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
						
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
						
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
						
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
						
						
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
						
						
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
						
					$image2 = false;
						
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
						
					$data['products_wd_group3'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
								
							'thumb2'       => $image2,
								
								
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
								
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
								
							'date_end'       => $date_end,
								
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
			
			if ($result_wd_group4) {
				foreach ($result_wd_group4 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
			
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
			
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
			
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
			
			
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
			
			
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
			
					$image2 = false;
			
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					$data['products_wd_group4'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
			
							'thumb2'       => $image2,
			
			
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
			
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
			
							'date_end'       => $date_end,
			
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
			
			if ($result_wd_group5) {
				foreach ($result_wd_group5 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
			
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
			
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
			
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
			
			
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
			
			
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
			
					$image2 = false;
			
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					$data['products_wd_group5'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
			
							'thumb2'       => $image2,
			
			
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
			
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
			
							'date_end'       => $date_end,
			
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
				
			// end of WD event page
			
			//starting likes and unlock event page			
			
			$arr_lu_group1 = array(3654, 2617, 2618, 2611, 2620, 2083); // Like and Unlock
			
			$result_lu_group1 = $this->model_catalog_product->getParticularProducts($arr_lu_group1);
			
			
			if ($result_lu_group1) {
				foreach ($result_lu_group1 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
						
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
						
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
						
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
						
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
						
						
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
						
						
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
						
					$image2 = false;
						
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
						
					$data['products_lu_group1'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
								
							'thumb2'       => $image2,
								
								
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
								
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
								
							'date_end'       => $date_end,
								
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}

			//end of likes and unlock
			
			//starting crazy 12 event page
				
			$arr_12_group1 = array(3979,3980,3981,3996,3984,3982,3989,3990,3985,3988,3987,3986); // Crazy Corner
			$arr_12_group2 = array(3983,2822,2875,2763,3216,3972,3452,2985,349,1762,131,102); // PC & Laptop
			$arr_12_group3 = array(4000,3991,1954,1110,910,1197,2428,907,2286,2152,3461,3999); // Mobile & Tablet
				
			$result_12_group1 = $this->model_catalog_product->getParticularProducts($arr_12_group1);
			$result_12_group2 = $this->model_catalog_product->getParticularProducts($arr_12_group2);
			$result_12_group3 = $this->model_catalog_product->getParticularProducts($arr_12_group3);
				
				
			if ($result_12_group1) {
				foreach ($result_12_group1 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
			
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
			
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
			
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
			
			
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
			
			
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
			
					$image2 = false;
			
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					$data['products_12_group1'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
			
							'thumb2'       => $image2,
			
			
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
			
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
			
							'date_end'       => $date_end,
			
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
			
			if ($result_12_group2) {
				foreach ($result_12_group2 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
						
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
						
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
						
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
						
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
						
						
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
						
						
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
						
					$image2 = false;
						
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
						
					$data['products_12_group2'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
								
							'thumb2'       => $image2,
								
								
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
								
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
								
							'date_end'       => $date_end,
								
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
			
			if ($result_12_group3) {
				foreach ($result_12_group3 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
						
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
						
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
						
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
						
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
						
						
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
						
						
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
						
					$image2 = false;
						
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
						
					$data['products_12_group3'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
								
							'thumb2'       => $image2,
								
								
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
								
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
								
							'date_end'       => $date_end,
								
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
			
			//end of likes and unlock
			
			//starting projector event page
			
			$arr_projector_group1 = array(1762,1761,1806,4006,4007,4008,4009,4010); // Epson
			$arr_projector_group2 = array(1216,1218,1238,1227,4011); // Sony
			$arr_projector_group3 = array(1320,1322,607,1333,1325,1326); // NEC
			
			$result_projector_group1 = $this->model_catalog_product->getParticularProducts($arr_projector_group1);
			$result_projector_group2 = $this->model_catalog_product->getParticularProducts($arr_projector_group2);
			$result_projector_group3 = $this->model_catalog_product->getParticularProducts($arr_projector_group3);
			
			
			if ($result_projector_group1) {
				foreach ($result_projector_group1 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
						
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
						
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
						
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
						
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
						
						
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
						
						
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
						
					$image2 = false;
						
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
						
					$data['products_projector_group1'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
								
							'thumb2'       => $image2,
								
								
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
								
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
								
							'date_end'       => $date_end,
								
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
				
			if ($result_projector_group2) {
				foreach ($result_projector_group2 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
			
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
			
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
			
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
			
			
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
			
			
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
			
					$image2 = false;
			
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					$data['products_projector_group2'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
			
							'thumb2'       => $image2,
			
			
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
			
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
			
							'date_end'       => $date_end,
			
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
				
			if ($result_projector_group3) {
				foreach ($result_projector_group3 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
			
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
			
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
			
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
			
			
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
			
			
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
			
					$image2 = false;
			
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					$data['products_projector_group3'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
			
							'thumb2'       => $image2,
			
			
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
			
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
			
							'date_end'       => $date_end,
			
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
				
			//end of projector
			
			//starting Canon event page
			//Latest Canon	
			$result_canon_group1 = $this->model_catalog_product->getCanonLatestProduct();								
			if ($result_canon_group1) {
				foreach ($result_canon_group1 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
			
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
			
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
			
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
			
			
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
			
			
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
			
					$image2 = false;
			
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					$data['products_canon_group1'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
			
							'thumb2'       => $image2,
			
			
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
			
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
			
							'date_end'       => $date_end,
			
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
			
			//end of Canon						
			//starting Samsung event page				
			$arr_samsung_group1 = array(2393,2402,3507,1432,3253,3266,3377,3318,3308,2403,3461,1431,3387,2078,2006,3362); // Samsung
				
			$result_samsung_group1 = $this->model_catalog_product->getParticularProducts($arr_samsung_group1);			
				
				
			if ($result_samsung_group1) {
				foreach ($result_samsung_group1 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
			
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
			
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
			
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
			
			
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
			
			
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
			
					$image2 = false;
			
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					$data['products_samsung_group1'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
			
							'thumb2'       => $image2,
			
			
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
			
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
			
							'date_end'       => $date_end,
			
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
			
			
			//end of Samsung
			
			//starting Laser event page
			$arr_laser_group1 = array(4048,2991,2992,4049,4050,2977,4051,4052,2983); // Laser
			
			$result_laser_group1 = $this->model_catalog_product->getParticularProducts($arr_laser_group1);
			
			
			if ($result_laser_group1) {
				foreach ($result_laser_group1 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
						
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
						
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
						
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
						
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
						
						
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
						
						
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
						
					$image2 = false;
						
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
						
					$data['products_laser_group1'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
								
							'thumb2'       => $image2,
								
								
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
								
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
								
							'date_end'       => $date_end,
								
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
								
			//end of Laser

			//starting Inject event page
			$arr_inject_group1 = array(4053,4054,4055,4056,4057); // Inject
				
			$result_inject_group1 = $this->model_catalog_product->getParticularProducts($arr_inject_group1);
				
				
			if ($result_inject_group1) {
				foreach ($result_inject_group1 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
			
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
			
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
			
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
			
			
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
			
			
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
			
					$image2 = false;
			
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					$data['products_inject_group1'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
			
							'thumb2'       => $image2,
			
			
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
			
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
			
							'date_end'       => $date_end,
			
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
			
			//starting Epson event page
			$arr_epson_group1 = array(1685,1805,1788,1792,817,818,1762,1761,1806,4006,4007,4008,4009,4010,1804); // Epson
			
			$result_epson_group1 = $this->model_catalog_product->getParticularProducts($arr_epson_group1);
						
			if ($result_epson_group1) {
				foreach ($result_epson_group1 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
						
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
						
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
						
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
						
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
						
						
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
						
						
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
						
					$image2 = false;
						
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
						
					$data['products_epson_group1'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
								
							'thumb2'       => $image2,
								
								
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
								
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
								
							'date_end'       => $date_end,
								
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
			
			//Razer Page has specific products to feature into category page
			$arr_razer_group1 = array(4063,2581,577,585,1668,581,1669,4067,2645,4100,23,577); // Keyboard
			$arr_razer_group2 = array(13,1969,15,17,22,1986,14,2921,1036,2723,4096,2726); // Mouse			
			$arr_razer_group3 = array(1942,2774,2773,1992,1988,1991,1989,1990); // Mouse pad			
			$arr_razer_group4 = array(531,533,534,4131,2761,10,2781,542); // Headset			
			$arr_razer_group5 = array(2440,18,4134,4135,4137,2,4136,4138); // Acessories 			
				
			$result_razer_group1 = $this->model_catalog_product->getParticularProducts($arr_razer_group1);
			$result_razer_group2 = $this->model_catalog_product->getParticularProducts($arr_razer_group2);
			$result_razer_group3 = $this->model_catalog_product->getParticularProducts($arr_razer_group3);
			$result_razer_group4 = $this->model_catalog_product->getParticularProducts($arr_razer_group4);
			$result_razer_group5 = $this->model_catalog_product->getParticularProducts($arr_razer_group5);
				
			if ($result_razer_group1) {
				foreach ($result_razer_group1 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
						
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
						
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
						
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
						
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
						
						
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
						
						
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
						
					$image2 = false;
						
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
						
					$data['products_razer_group1'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
								
							'thumb2'       => $image2,
								
								
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
								
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
								
							'date_end'       => $date_end,
								
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
				
			if ($result_razer_group2) {
				foreach ($result_razer_group2 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
			
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
			
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
			
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
			
			
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
			
			
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
			
					$image2 = false;
			
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					$data['products_razer_group2'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
			
							'thumb2'       => $image2,
			
			
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
			
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
			
							'date_end'       => $date_end,
			
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
				
			if ($result_razer_group3) {
				foreach ($result_razer_group3 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
			
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
			
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
			
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
			
			
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
			
			
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
			
					$image2 = false;
			
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					$data['products_razer_group3'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
			
							'thumb2'       => $image2,
			
			
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
			
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
			
							'date_end'       => $date_end,
			
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
			
			if ($result_razer_group4) {
				foreach ($result_razer_group4 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
						
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
						
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
						
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
						
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
						
						
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
						
						
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
						
					$image2 = false;
						
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
						
					$data['products_razer_group4'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
								
							'thumb2'       => $image2,
								
								
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
								
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
								
							'date_end'       => $date_end,
								
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
			
			if ($result_razer_group5) {
				foreach ($result_razer_group5 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
						
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
						
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
						
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
						
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
						
						
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
						
						
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
						
					$image2 = false;
						
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
						
					$data['products_razer_group5'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
								
							'thumb2'       => $image2,
								
								
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
								
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
								
							'date_end'       => $date_end,
								
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
			
			/* End of Razer Page */
				
			//Apple Page has specific products to feature into category page
			$arr_apple_group1 = array(1947,1946,1948,1949); // Microsoft Surface Pro 4
			$arr_apple_group2 = array(1714,1713,1710,1709); // Microsoft Surface Pro 3
			$arr_apple_group3 = array(1707,1705,1706,590); // Type Cover
			
			$result_apple_group1 = $this->model_catalog_product->getParticularProducts($arr_apple_group1);
			$result_apple_group2 = $this->model_catalog_product->getParticularProducts($arr_apple_group2);
			$result_apple_group3 = $this->model_catalog_product->getParticularProducts($arr_apple_group3);
			
			if ($result_apple_group1) {
				foreach ($result_apple_group1 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
			
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
			
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
			
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
			
			
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
			
			
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
			
					$image2 = false;
			
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					$data['products_apple_group1'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
			
							'thumb2'       => $image2,
			
			
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
			
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
			
							'date_end'       => $date_end,
			
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
			
			if ($result_apple_group2) {
				foreach ($result_apple_group2 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
						
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
						
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
						
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
						
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
						
						
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
						
						
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
						
					$image2 = false;
						
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
						
					$data['products_apple_group2'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
								
							'thumb2'       => $image2,
								
								
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
								
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
								
							'date_end'       => $date_end,
								
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
			
			if ($result_apple_group3) {
				foreach ($result_apple_group3 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
						
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
						
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
						
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
						
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
						
						
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
						
						
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
						
					$image2 = false;
						
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
						
					$data['products_apple_group3'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
								
							'thumb2'       => $image2,
								
								
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
								
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
								
							'date_end'       => $date_end,
								
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
			
			//Xmas and New Year has specific products to feature into category page
			//$arr_xnew_group1 = array(3980,3996,1954,4084); // Special Gift To All
			$arr_xnew_group1 = array(3980,1685,1954,4084);
			$arr_xnew_group2 = array(4015,17,2381,2275,2324,4017,376,1669,2680,2614,234,278); // For Him (21-27 Dec)
			$arr_xnew_group3 = array(2831,3544,4019,4020,4021,4026,4022,4083,4023,4024,2430,2095); // For Her (21-27 Dec)
				
			$result_xnew_group1 = $this->model_catalog_product->getParticularProducts($arr_xnew_group1);
			$result_xnew_group2 = $this->model_catalog_product->getParticularProducts($arr_xnew_group2);
			$result_xnew_group3 = $this->model_catalog_product->getParticularProducts($arr_xnew_group3);
				
			if ($result_xnew_group1) {
				foreach ($result_xnew_group1 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
						
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
						
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
						
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
						
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
						
						
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
						
						
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
						
					$image2 = false;
						
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
						
					$data['products_xnew_group1'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
								
							'thumb2'       => $image2,
								
								
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
								
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
								
							'date_end'       => $date_end,
								
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
				
			if ($result_xnew_group2) {
				foreach ($result_xnew_group2 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
			
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
			
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
			
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
			
			
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
			
			
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
			
					$image2 = false;
			
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					$data['products_xnew_group2'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
			
							'thumb2'       => $image2,
			
			
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
			
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
			
							'date_end'       => $date_end,
			
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
				
			if ($result_xnew_group3) {
				foreach ($result_xnew_group3 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
			
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
			
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
			
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
			
			
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
			
			
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
			
					$image2 = false;
			
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					$data['products_xnew_group3'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
			
							'thumb2'       => $image2,
			
			
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
			
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
			
							'date_end'       => $date_end,
			
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
			/* Xmas and New Year */
			
			/* Dec 2015 Timesale Starting Coding 21 - 25*/			
			$arr_dec2015_timesale_group1 = array(3996,4027,4028); // 21 
			$arr_dec2015_timesale_group2 = array(4029,4030,3985); // 22
			//$arr_dec2015_timesale_group3 = array(4031,4083,3989); // 23
			$arr_dec2015_timesale_group3 = array(4031,4120,3989); // 23
			$arr_dec2015_timesale_group4 = array(4032,4033,3987); // 24
			$arr_dec2015_timesale_group5 = array(4034,4035,4028); // 25
			/* Dec 2015 Timesale Starting Coding 28 - 1/1 */
			$arr_dec2015_timesale_group6 = array(4037,4059,3988); // 28
			$arr_dec2015_timesale_group7 = array(4039,4040,4028); // 29
			$arr_dec2015_timesale_group8 = array(4041,4042,3990); // 30
			$arr_dec2015_timesale_group9 = array(4043,4044,4028); // 31
			$arr_dec2015_timesale_group10 = array(4045,4085,4060); // 1/1 
			
			$result_dec2015_timesale_group1 = $this->model_catalog_product->getParticularProducts($arr_dec2015_timesale_group1);
			$result_dec2015_timesale_group2 = $this->model_catalog_product->getParticularProducts($arr_dec2015_timesale_group2);
			$result_dec2015_timesale_group3 = $this->model_catalog_product->getParticularProducts($arr_dec2015_timesale_group3);
			$result_dec2015_timesale_group4 = $this->model_catalog_product->getParticularProducts($arr_dec2015_timesale_group4);
			$result_dec2015_timesale_group5 = $this->model_catalog_product->getParticularProducts($arr_dec2015_timesale_group5);
			$result_dec2015_timesale_group6 = $this->model_catalog_product->getParticularProducts($arr_dec2015_timesale_group6);
			$result_dec2015_timesale_group7 = $this->model_catalog_product->getParticularProducts($arr_dec2015_timesale_group7);
			$result_dec2015_timesale_group8 = $this->model_catalog_product->getParticularProducts($arr_dec2015_timesale_group8);
			$result_dec2015_timesale_group9 = $this->model_catalog_product->getParticularProducts($arr_dec2015_timesale_group9);
			$result_dec2015_timesale_group10 = $this->model_catalog_product->getParticularProducts($arr_dec2015_timesale_group10);
			
			if ($result_dec2015_timesale_group1) {
				foreach ($result_dec2015_timesale_group1 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
			
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
			
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
			
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
			
			
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
			
			
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
			
					$image2 = false;
			
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					$data['products_dec2015_timesale_group1'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
			
							'thumb2'       => $image2,
			
			
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
			
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
			
							'date_end'       => $date_end,
			
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
			
			if ($result_dec2015_timesale_group2) {
				foreach ($result_dec2015_timesale_group2 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
						
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
						
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
						
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
						
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
						
						
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
						
						
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
						
					$image2 = false;
						
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
						
					$data['products_dec2015_timesale_group2'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
								
							'thumb2'       => $image2,
								
								
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
								
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
								
							'date_end'       => $date_end,
								
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
			
			if ($result_dec2015_timesale_group3) {
				foreach ($result_dec2015_timesale_group3 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
			
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
			
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
			
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
			
			
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
			
			
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
			
					$image2 = false;
			
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					$data['products_dec2015_timesale_group3'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
			
							'thumb2'       => $image2,
			
			
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
			
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
			
							'date_end'       => $date_end,
			
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
			
			if ($result_dec2015_timesale_group4) {
				foreach ($result_dec2015_timesale_group4 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
			
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
			
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
			
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
			
			
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
			
			
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
			
					$image2 = false;
			
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					$data['products_dec2015_timesale_group4'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
			
							'thumb2'       => $image2,
			
			
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
			
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
			
							'date_end'       => $date_end,
			
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
			
			if ($result_dec2015_timesale_group5) {
				foreach ($result_dec2015_timesale_group5 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
			
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
			
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
			
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
			
			
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
			
			
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
			
					$image2 = false;
			
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					$data['products_dec2015_timesale_group5'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
			
							'thumb2'       => $image2,
			
			
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
			
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
			
							'date_end'       => $date_end,
			
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
			
			if ($result_dec2015_timesale_group6) {
				foreach ($result_dec2015_timesale_group6 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
			
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
			
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
			
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
			
			
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
			
			
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
			
					$image2 = false;
			
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					$data['products_dec2015_timesale_group6'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
			
							'thumb2'       => $image2,
			
			
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
			
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
			
							'date_end'       => $date_end,
			
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
			
			if ($result_dec2015_timesale_group7) {
				foreach ($result_dec2015_timesale_group7 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
			
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
			
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
			
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
			
			
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
			
			
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
			
					$image2 = false;
			
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					$data['products_dec2015_timesale_group7'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
			
							'thumb2'       => $image2,
			
			
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
			
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
			
							'date_end'       => $date_end,
			
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
			
			if ($result_dec2015_timesale_group8) {
				foreach ($result_dec2015_timesale_group8 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
			
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
			
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
			
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
			
			
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
			
			
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
			
					$image2 = false;
			
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					$data['products_dec2015_timesale_group8'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
			
							'thumb2'       => $image2,
			
			
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
			
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
			
							'date_end'       => $date_end,
			
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
			
			if ($result_dec2015_timesale_group9) {
				foreach ($result_dec2015_timesale_group9 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
			
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
			
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
			
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
			
			
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
			
			
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
			
					$image2 = false;
			
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					$data['products_dec2015_timesale_group9'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
			
							'thumb2'       => $image2,
			
			
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
			
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
			
							'date_end'       => $date_end,
			
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
			
			if ($result_dec2015_timesale_group10) {
				foreach ($result_dec2015_timesale_group10 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
			
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
			
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
			
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
			
			
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
			
			
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
			
					$image2 = false;
			
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					$data['products_dec2015_timesale_group10'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
			
							'thumb2'       => $image2,
			
			
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
			
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
			
							'date_end'       => $date_end,
			
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
									
			/* Dec 2015 Timesale End Coding */
			
			
			/* Star Product Starting Coding*/
			$arr_star_product_group1 = array(3493,1592,2149,2160,2188,3603,492,2781,6,3112,73,4024,709,1138,3809,2819); // 21 - 25
			$result_star_product_group1 = $this->model_catalog_product->getParticularProducts($arr_star_product_group1);
				
			if ($result_star_product_group1) {
				foreach ($result_star_product_group1 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
						
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
						
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
						
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
						
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
						
						
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
						
						
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
						
					$image2 = false;
						
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
						
					$data['products_star_product_group1'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
								
							'thumb2'       => $image2,
								
								
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
								
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
								
							'date_end'       => $date_end,
								
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
				
			/* Star Product  End Coding */
			
			/* Bck School Starting Coding*/
			$arr_back_school_group1 = array(3452,704,316,1026,90,3619,141,2431,335,1241,3099,2985,3216,2245,2260,2242);
			$result_back_school_group1 = $this->model_catalog_product->getParticularProducts($arr_back_school_group1);
			
			if ($result_back_school_group1) {
				foreach ($result_back_school_group1 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
			
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
			
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
			
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
			
			
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
			
			
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
			
					$image2 = false;
			
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					$data['products_back_school_group1'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
			
							'thumb2'       => $image2,
			
			
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
			
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
			
							'date_end'       => $date_end,
			
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
			
			/* BAck school  End Coding */
			
			/* Zoom in & Zoom Out Starting Coding*/
			$arr_zoom_group1 = array(4019,4068,4073,4078,4071,4072,4076,4075,4077,4070,4069,4074,4079,4080,4081,4082);
			$result_zoom_group1 = $this->model_catalog_product->getParticularProducts($arr_zoom_group1);
				
			if ($result_zoom_group1) {
				foreach ($result_zoom_group1 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
						
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
						
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
						
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
						
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
						
						
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
						
						
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
						
					$image2 = false;
						
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
						
					$data['products_zoom_group1'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
								
							'thumb2'       => $image2,
								
								
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
								
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
								
							'date_end'       => $date_end,
								
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
				
			/* Zoom in & Zoom Out End Coding */
			
			/* Bitdefender Starting Coding*/
			$arr_bit_group1 = array(4086,4087,4088,4089);
			$result_bit_group1 = $this->model_catalog_product->getParticularProducts($arr_bit_group1);
			
			if ($result_bit_group1) {
				foreach ($result_bit_group1 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
			
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
			
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
			
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
			
			
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
			
			
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
			
					$image2 = false;
			
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					$data['products_bit_group1'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
			
							'thumb2'       => $image2,
			
			
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
			
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
			
							'date_end'       => $date_end,
			
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
			
			/*End of Bitdefender */
			
			//Customized PC Page has specific products to feature into category page
			$arr_custompc_group1 = array(4252,4253,4251,4245,3518,4250,3556,4247,4246,3550,4249,4248); // Customized PC
			$result_custompc_group1 = $this->model_catalog_product->getParticularProducts($arr_custompc_group1);			
			
			if ($result_custompc_group1) {
				foreach ($result_custompc_group1 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
			
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
			
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
			
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
			
			
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
			
			
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
			
					$image2 = false;
			
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					$data['products_custompc_group1'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
			
							'thumb2'       => $image2,
			
			
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
			
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
			
							'date_end'       => $date_end,
			
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
			
				
			/* End of Customized PC Page */
			
			//Precious Memory Page has specific products to feature into category page
			$arr_precious_group1 = array(4265,4266,4269,4270); // iOS Pendrive
			$arr_precious_group2 = array(678,694,3356,3413,3360,3378,3368,3366); // Memory Card (Micro SD)
			$arr_precious_group3 = array(2612,2608,4271,4272,3426,3424,4274,4273,3418,3339,3395,3393); // Pendrive
			$arr_precious_group4 = array(3379,3355,3386,3367); // Camera SDHC
			$arr_precious_group5 = array(632,3121,3120,3086,2558,2602,2609,3260,3261,3263,3264,3972); // External Harddisk
			$arr_precious_group6 = array(3065,3069,3074,3082); // Internal Harddisk
			
			$result_precious_group1 = $this->model_catalog_product->getParticularProducts($arr_precious_group1);
			$result_precious_group2 = $this->model_catalog_product->getParticularProducts($arr_precious_group2);
			$result_precious_group3 = $this->model_catalog_product->getParticularProducts($arr_precious_group3);
			$result_precious_group4 = $this->model_catalog_product->getParticularProducts($arr_precious_group4);
			$result_precious_group5 = $this->model_catalog_product->getParticularProducts($arr_precious_group5);
			$result_precious_group6 = $this->model_catalog_product->getParticularProducts($arr_precious_group6);
				
			if ($result_precious_group1) {
				foreach ($result_precious_group1 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
						
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
						
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
						
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
						
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
						
						
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
						
						
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
						
					$image2 = false;
						
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
						
					$data['products_precious_group1'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
								
							'thumb2'       => $image2,
								
								
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
								
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
								
							'date_end'       => $date_end,
								
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
			
			if ($result_precious_group2) {
				foreach ($result_precious_group2 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
			
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
			
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
			
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
			
			
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
			
			
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
			
					$image2 = false;
			
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					$data['products_precious_group2'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
			
							'thumb2'       => $image2,
			
			
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
			
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
			
							'date_end'       => $date_end,
			
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
			
			if ($result_precious_group3) {
				foreach ($result_precious_group3 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
			
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
			
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
			
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
			
			
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
			
			
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
			
					$image2 = false;
			
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					$data['products_precious_group3'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
			
							'thumb2'       => $image2,
			
			
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
			
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
			
							'date_end'       => $date_end,
			
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
			
			if ($result_precious_group4) {
				foreach ($result_precious_group4 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
			
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
			
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
			
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
			
			
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
			
			
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
			
					$image2 = false;
			
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					$data['products_precious_group4'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
			
							'thumb2'       => $image2,
			
			
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
			
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
			
							'date_end'       => $date_end,
			
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
			
			if ($result_precious_group5) {
				foreach ($result_precious_group5 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
			
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
			
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
			
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
			
			
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
			
			
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
			
					$image2 = false;
			
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					$data['products_precious_group5'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
			
							'thumb2'       => $image2,
			
			
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
			
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
			
							'date_end'       => $date_end,
			
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
			
			if ($result_precious_group6) {
				foreach ($result_precious_group6 as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
			
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
			
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}
			
					if ($this->config->get('config_review_status')) {
						$rating = (int)$result['rating'];
					} else {
						$rating = false;
					}
			
			
					$date_end = false;
					if (strpos($this->config->get('config_template'), 'journal2') === 0 && $special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
						$this->load->model('journal2/product');
						$date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
						if ($date_end === '0000-00-00') {
							$date_end = false;
						}
					}
			
			
					$additional_images = $this->model_catalog_product->getProductImages($result['product_id']);
			
					$image2 = false;
			
					if (count($additional_images) > 0) {
						$image2 = $this->model_tool_image->resize($additional_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
			
					$data['products_precious_group6'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'       => $image,
			
							'thumb2'       => $image2,
			
			
							'labels'        => $this->model_journal2_product->getLabels($result['product_id']),
			
							'name'        => $result['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'special'     => $special,
			
							'date_end'       => $date_end,
			
							'tax'         => $tax,
							'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
							'rating'      => $result['rating'],
							'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
					);
				}
			}
				
			
			/* End of Precious Memory Page */
			
			$url = '';

			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$data['sorts'] = array();

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_default'),
				'value' => 'p.sort_order-ASC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.sort_order&order=ASC' . $url)
			);

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_name_asc'),
				'value' => 'pd.name-ASC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=pd.name&order=ASC' . $url)
			);

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_name_desc'),
				'value' => 'pd.name-DESC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=pd.name&order=DESC' . $url)
			);

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_price_asc'),
				'value' => 'p.price-ASC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.price&order=ASC' . $url)
			);

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_price_desc'),
				'value' => 'p.price-DESC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.price&order=DESC' . $url)
			);

			if ($this->config->get('config_review_status')) {
				$data['sorts'][] = array(
					'text'  => $this->language->get('text_rating_desc'),
					'value' => 'rating-DESC',
					'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=rating&order=DESC' . $url)
				);

				$data['sorts'][] = array(
					'text'  => $this->language->get('text_rating_asc'),
					'value' => 'rating-ASC',
					'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=rating&order=ASC' . $url)
				);
			}

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_model_asc'),
				'value' => 'p.model-ASC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.model&order=ASC' . $url)
			);

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_model_desc'),
				'value' => 'p.model-DESC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.model&order=DESC' . $url)
			);

			$url = '';

			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			$data['limits'] = array();

			$limits = array_unique(array($this->config->get('config_product_limit'), 25, 50, 75, 100));

			sort($limits);

			foreach($limits as $value) {
				$data['limits'][] = array(
					'text'  => $value,
					'value' => $value,
					'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url . '&limit=' . $value)
				);
			}

			$url = '';

			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$pagination = new Pagination();
			$pagination->total = $product_total;
			$pagination->page = $page;
			$pagination->limit = $limit;
			$pagination->url = $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url . '&page={page}');

			$data['pagination'] = $pagination->render();

			$data['results'] = sprintf($this->language->get('text_pagination'), ($product_total) ? (($page - 1) * $limit) + 1 : 0, ((($page - 1) * $limit) > ($product_total - $limit)) ? $product_total : ((($page - 1) * $limit) + $limit), $product_total, ceil($product_total / $limit));

			$data['sort'] = $sort;
			$data['order'] = $order;
			$data['limit'] = $limit;

			$data['continue'] = $this->url->link('common/home');

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/product/category.tpl')) {
				$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/product/category.tpl', $data));
			} else {
				$this->response->setOutput($this->load->view('default/template/product/category.tpl', $data));
			}
		} else {
			$url = '';

			if (isset($this->request->get['path'])) {
				$url .= '&path=' . $this->request->get['path'];
			}

			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
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

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_error'),
				'href' => $this->url->link('product/category', $url)
			);

			$this->document->setTitle($this->language->get('text_error'));

			$data['heading_title'] = $this->language->get('text_error');

			$data['text_error'] = $this->language->get('text_error');

			$data['button_continue'] = $this->language->get('button_continue');

			$data['continue'] = $this->url->link('common/home');

			$this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . ' 404 Not Found');

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/error/not_found.tpl')) {
				$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/error/not_found.tpl', $data));
			} else {
				$this->response->setOutput($this->load->view('default/template/error/not_found.tpl', $data));
			}
		}
	}
}