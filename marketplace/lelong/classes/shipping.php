<?php
    
    class ShippingHelper{
        
        //private $shipping_price_mappings;
        private $_db;
		
        public function __construct($db){
			$this->_db = $db;
            //$this->LoadShippingPriceData();
        }
        
		public function GetLelongShippingPrice($catId){
			$setting_key_prefix = 'lelong_category_'.$catId.'_shipfee_';
			
			$query = $this->_db->query('SELECT * FROM '.DB_PREFIX.'setting WHERE `key` LIKE "lelong_category_'.$catId.'_shipfee_%"');

			$ship_fee_west = "";
			$ship_fee_sabah = "";
			$ship_fee_sarawak = "";
			$ship_fee_intl = "";
			
			foreach($query->rows as $row){
				if($row['key'] == $setting_key_prefix.'west'){
					$ship_fee_west = $row['value'];
				}
				else if($row['key'] == $setting_key_prefix.'sabah'){
					$ship_fee_sabah = $row['value'];
				}
				else if($row['key'] == $setting_key_prefix.'sarawak'){
					$ship_fee_sarawak = $row['value'];
				}
				else if($row['key'] == $setting_key_prefix.'intl'){
					$ship_fee_intl= $row['value'];
				}
			}
			
            return $ship_fee_west.'^'.$ship_fee_sabah.'^'.$ship_fee_sarawak.'^'.$ship_fee_intl;
        }
		
		/*
        public function GetLelongShippingPrice($catId){
			if(!isset($this->shipping_price_mappings[''.$catId.''])){
				return null;
			}
			
            return implode($this->shipping_price_mappings[''.$catId.''], '^').'^';
        }*/

        public function LoadShippingPriceData(){
            $shipping_price_mappings['20'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//11-Networking
            $shipping_price_mappings['12'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//12-Notebook & Desktop PC
            $shipping_price_mappings['27'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//27-Mobile Phone & Tablet
            $shipping_price_mappings['28'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//28-HTC
            $shipping_price_mappings['29'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//29-Nokia
            $shipping_price_mappings['30'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//30-Samsung
            $shipping_price_mappings['31'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//31-Sony
            $shipping_price_mappings['35'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//35-PC Hardware
            $shipping_price_mappings['36'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//36-Peripherals
            $shipping_price_mappings['40'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//40-Notebook Bag
            $shipping_price_mappings['41'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//41-Tablet
            $shipping_price_mappings['46'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//46-Software
            $shipping_price_mappings['49'] = array('peninsular' => 25, 'sabah' => 120, 'sarawak' => 120);//49-Mac
            $shipping_price_mappings['50'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//50-iPod
            $shipping_price_mappings['51'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//51-iPhone
            $shipping_price_mappings['52'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//52-iPad
            $shipping_price_mappings['54'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//54-Apple Accessories
            $shipping_price_mappings['56'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//56-MacBook Air
            $shipping_price_mappings['57'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//57-MacBook Pro
            $shipping_price_mappings['58'] = array('peninsular' => 25, 'sabah' => 120, 'sarawak' => 120);//58-Mac Mini
            $shipping_price_mappings['59'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//59-iPod Shuffle
            $shipping_price_mappings['60'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//60-iPod Nano
            $shipping_price_mappings['62'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//62-iPad Touch
            $shipping_price_mappings['63'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//63-iPad Mini
            $shipping_price_mappings['64'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//64-iPad with Retina Display
            $shipping_price_mappings['65'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//65-Mobile Phone
            $shipping_price_mappings['66'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//66-Tablet
            $shipping_price_mappings['67'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//67-NoteBook
            $shipping_price_mappings['68'] = array('peninsular' => 25, 'sabah' => 120, 'sarawak' => 120);//68-PC & All in one PC
            $shipping_price_mappings['70'] = array('peninsular' => 20, 'sabah' => 50, 'sarawak' => 50);//70-Printer
            $shipping_price_mappings['71'] = array('peninsular' => 15, 'sabah' => 40, 'sarawak' => 40);//71-Monitor
            $shipping_price_mappings['73'] = array('peninsular' => 25, 'sabah' => 120, 'sarawak' => 120);//73-iMac
            $shipping_price_mappings['74'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//74-Galaxy
            $shipping_price_mappings['75'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//75-Tab
            $shipping_price_mappings['76'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//76-Note
            $shipping_price_mappings['77'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//77-Book
            $shipping_price_mappings['78'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//78-Eureka
            $shipping_price_mappings['79'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//79-Series
            $shipping_price_mappings['80'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//80-Smart PC
            $shipping_price_mappings['81'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//81-Casing & Cover
            $shipping_price_mappings['82'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//82-Screen Protector
            $shipping_price_mappings['83'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//83-Charger
            $shipping_price_mappings['84'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//84-HeadSet
            $shipping_price_mappings['85'] = array('peninsular' => 20, 'sabah' => 50, 'sarawak' => 50);//85-Ink Jet
            $shipping_price_mappings['86'] = array('peninsular' => 20, 'sabah' => 50, 'sarawak' => 50);//86-Laser Jet
            $shipping_price_mappings['89'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//89-other
            $shipping_price_mappings['93'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//93-Notebooks
            $shipping_price_mappings['94'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//94-Tablet
            $shipping_price_mappings['95'] = array('peninsular' => 20, 'sabah' => 50, 'sarawak' => 50);//95-Desktop
            $shipping_price_mappings['96'] = array('peninsular' => 20, 'sabah' => 50, 'sarawak' => 50);//96-All in One PC
            $shipping_price_mappings['97'] = array('peninsular' => 15, 'sabah' => 40, 'sarawak' => 40);//97-Monitor
            $shipping_price_mappings['98'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//98-Printer & Ink / Tonner
            $shipping_price_mappings['99'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//99-Accessories
            $shipping_price_mappings['106'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//106-Asus Notebook & Ultrabook
            $shipping_price_mappings['107'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//107-Motherboard
            $shipping_price_mappings['108'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//108-Tablet & Mobile
            $shipping_price_mappings['109'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//109-Graphic Cards
            $shipping_price_mappings['110'] = array('peninsular' => 25, 'sabah' => 120, 'sarawak' => 120);//110-Desktop & AiO PCs
            $shipping_price_mappings['112'] = array('peninsular' => 25, 'sabah' => 120, 'sarawak' => 120);//112-All in One PC
            $shipping_price_mappings['113'] = array('peninsular' => 15, 'sabah' => 40, 'sarawak' => 40);//113-Monitor
            $shipping_price_mappings['114'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//114-Optical drive, Audio &  Multimedia
            $shipping_price_mappings['118'] = array('peninsular' => 25, 'sabah' => 120, 'sarawak' => 120);//118-Server & WorksStation
            $shipping_price_mappings['121'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//121-Notebook
            $shipping_price_mappings['122'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//122-Tablet
            $shipping_price_mappings['123'] = array('peninsular' => 25, 'sabah' => 120, 'sarawak' => 120);//123-All in One PC
            $shipping_price_mappings['124'] = array('peninsular' => 25, 'sabah' => 120, 'sarawak' => 120);//124-Desktop
            $shipping_price_mappings['125'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//125-Smartphone
            $shipping_price_mappings['126'] = array('peninsular' => 15, 'sabah' => 40, 'sarawak' => 40);//126-Monitor
            $shipping_price_mappings['127'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//127-Projectors
            $shipping_price_mappings['128'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//128-Accessories
            $shipping_price_mappings['136'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//136-Intel
            $shipping_price_mappings['137'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//137-AMD
            $shipping_price_mappings['138'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//138-ROG / Republic of Gamers
            $shipping_price_mappings['139'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//139-TUF / The Ultimate Fighter
            $shipping_price_mappings['140'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//140-others..
            $shipping_price_mappings['141'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//141-Pad Fone
            $shipping_price_mappings['142'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//142-Asus ViviTab
            $shipping_price_mappings['143'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//143-Nexus
            $shipping_price_mappings['144'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//144-Asus Transform Pad
            $shipping_price_mappings['145'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//145-Asus FonePad
            $shipping_price_mappings['146'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//146-AMD series
            $shipping_price_mappings['147'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//147-NViDIA series
            $shipping_price_mappings['148'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//148-ROG / Republic of Gamers series
            $shipping_price_mappings['149'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//149-Optical drive
            $shipping_price_mappings['150'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//150-Sound Card and Others
            $shipping_price_mappings['151'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//151-Headphone / Head set & speaker
            $shipping_price_mappings['152'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//152-Multimedia
            $shipping_price_mappings['153'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//153-Wireless Router
            $shipping_price_mappings['154'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//154-Wireless AP / Range External / Bridge
            $shipping_price_mappings['155'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//155-Wireless Adapter
            $shipping_price_mappings['156'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//156-Wireless Networking
            $shipping_price_mappings['157'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//157-Modern Routers
            $shipping_price_mappings['158'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//158-Motherboard
            $shipping_price_mappings['159'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//159-Notebook
            $shipping_price_mappings['160'] = array('peninsular' => 25, 'sabah' => 120, 'sarawak' => 120);//160-Desktop
            $shipping_price_mappings['161'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//161-Graphic Cards
            $shipping_price_mappings['162'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//162-Keyboard & Mouse
            $shipping_price_mappings['163'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//163-ZenBook
            $shipping_price_mappings['164'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//164-ASUS N Series
            $shipping_price_mappings['165'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//165-Asus  VivoBook
            $shipping_price_mappings['166'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//166-Asus A450/ A550 Series
            $shipping_price_mappings['167'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//167-ASUS ROG Gaming
            $shipping_price_mappings['170'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//170-Asus A  SERIES
            $shipping_price_mappings['171'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//171-Asus Intel X Series
            $shipping_price_mappings['172'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//172-Asus Ultra slim / UltraBook
            $shipping_price_mappings['176'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//176-Acer
            $shipping_price_mappings['177'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//177-Asus
            $shipping_price_mappings['178'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//178-Hewlett-Packard
            $shipping_price_mappings['179'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//179-Samsung
            $shipping_price_mappings['182'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//182-Acer
            $shipping_price_mappings['184'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//184-Asus
            $shipping_price_mappings['186'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//186-Samsung
            $shipping_price_mappings['187'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//187-Laptop & Notebook
            $shipping_price_mappings['189'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//189-Battery &  Adapter
            $shipping_price_mappings['191'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//191-Samsung Mobile part / Cable
            $shipping_price_mappings['192'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//192-Asus Notebook Accessories
            $shipping_price_mappings['193'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//193-Asus Notebook Battery / Adapter
            $shipping_price_mappings['195'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//195-Dell
            $shipping_price_mappings['196'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//196-Laptop
            $shipping_price_mappings['200'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//200-MacBook Air
            $shipping_price_mappings['201'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//201-MacBook Pro
            $shipping_price_mappings['202'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//202-Notebook Bag
            $shipping_price_mappings['204'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//204-MacBook Accessories
            $shipping_price_mappings['205'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//205-Laptop & Notebook
            $shipping_price_mappings['206'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//206-Battery &  Adapter
            $shipping_price_mappings['208'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//208-Laptop & Notebook
            $shipping_price_mappings['210'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//210-Battery &  Adapter
            $shipping_price_mappings['211'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//211-Toshiba
            $shipping_price_mappings['212'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//212-Intel Processor
            $shipping_price_mappings['213'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//213-Window 8
            $shipping_price_mappings['214'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//214-Android
            $shipping_price_mappings['215'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//215-Lenovo
            $shipping_price_mappings['216'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//216-Samsung
            $shipping_price_mappings['217'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//217-Sony
            $shipping_price_mappings['218'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//218-Asus
            $shipping_price_mappings['219'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//219-Acer
            $shipping_price_mappings['220'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//220-Others..
            $shipping_price_mappings['221'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//221-Others..
            $shipping_price_mappings['222'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//222-Cables
            $shipping_price_mappings['223'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//223-VGA Cables
            $shipping_price_mappings['232'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//232-Tablet Accessories
            $shipping_price_mappings['233'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//233-Battery &  Adapter
            $shipping_price_mappings['234'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//234-Laptop
            $shipping_price_mappings['236'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//236-Battery &  Adapter
            $shipping_price_mappings['237'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//237-Lenovo
            $shipping_price_mappings['238'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//238-Desktop PC
            $shipping_price_mappings['239'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//239-Processor
            $shipping_price_mappings['240'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//240-Motherboard
            $shipping_price_mappings['241'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//241-HDMI Cable
            $shipping_price_mappings['242'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//242-ThinkPad
            $shipping_price_mappings['243'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//243-Ideapad
            $shipping_price_mappings['244'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//244-Essential
            $shipping_price_mappings['245'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//245-Laptop Accessories
            $shipping_price_mappings['246'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//246-Adapter & Charger Kit
            $shipping_price_mappings['247'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//247-VOSTRO
            $shipping_price_mappings['248'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//248-INSPIRON
            $shipping_price_mappings['249'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//249-ALIENWARE
            $shipping_price_mappings['250'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//250-XPS
            $shipping_price_mappings['251'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//251-Laptop & Notebook
            $shipping_price_mappings['252'] = array('peninsular' => 25, 'sabah' => 120, 'sarawak' => 120);//252-Desktop & All in one PC
            $shipping_price_mappings['253'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//253-VOSTRO
            $shipping_price_mappings['254'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//254-INSPIRON
            $shipping_price_mappings['255'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//255-ALIENWARE
            $shipping_price_mappings['256'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//256-XPS
            $shipping_price_mappings['257'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//257-Memory (RAM)
            $shipping_price_mappings['258'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//258-Sound Card
            $shipping_price_mappings['260'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//260-3.5" Internal Harddisk
            $shipping_price_mappings['261'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//261-Optical Drive
            $shipping_price_mappings['262'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//262-Graphic Card
            $shipping_price_mappings['263'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//263-Wireless Router
            $shipping_price_mappings['264'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//264-Wireless AP/Ranger Extender/ Bridges
            $shipping_price_mappings['265'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//265-Wired Networking
            $shipping_price_mappings['266'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//266-Modem Routers
            $shipping_price_mappings['267'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//267-3G/4G modem
            $shipping_price_mappings['268'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//268-Security
            $shipping_price_mappings['269'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//269-Switches
            $shipping_price_mappings['270'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//270-KVM Switcher
            $shipping_price_mappings['271'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//271-NAS / DAS
            $shipping_price_mappings['272'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//272-Networking Accessories
            $shipping_price_mappings['273'] = array('peninsular' => 8, 'sabah' => 10, 'sarawak' => 10);//273-System Protection
            $shipping_price_mappings['274'] = array('peninsular' => 8, 'sabah' => 10, 'sarawak' => 10);//274-Operating System
            $shipping_price_mappings['275'] = array('peninsular' => 8, 'sabah' => 10, 'sarawak' => 10);//275-Office Application
            $shipping_price_mappings['276'] = array('peninsular' => 8, 'sabah' => 10, 'sarawak' => 10);//276-Antivirus & Internet Security
            $shipping_price_mappings['277'] = array('peninsular' => 8, 'sabah' => 10, 'sarawak' => 10);//277-Graphic & Publishing
            $shipping_price_mappings['278'] = array('peninsular' => 8, 'sabah' => 10, 'sarawak' => 10);//278-Others..
            $shipping_price_mappings['279'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//279-Monitor
            $shipping_price_mappings['280'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//280-Power Supply
            $shipping_price_mappings['281'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//281-AVR / UPS
            $shipping_price_mappings['283'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//283-Mouse
            $shipping_price_mappings['284'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//284-Logitech
            $shipping_price_mappings['285'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//285-Presenter
            $shipping_price_mappings['286'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//286-Logitech
            $shipping_price_mappings['287'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//287-Keyboard
            $shipping_price_mappings['288'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//288-Logitech
            $shipping_price_mappings['289'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//289-Speaker
            $shipping_price_mappings['290'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//290-Audio
            $shipping_price_mappings['292'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//292-For Apple IPad
            $shipping_price_mappings['293'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//293-Webcam
            $shipping_price_mappings['294'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//294-Wired Mouse
            $shipping_price_mappings['295'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//295-Wireless Mouse
            $shipping_price_mappings['296'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//296-Keyboard only
            $shipping_price_mappings['297'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//297-Keyboard Combo With Mouse
            $shipping_price_mappings['298'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//298-earphones
            $shipping_price_mappings['299'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//299-Headset
            $shipping_price_mappings['307'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//307-Mouse
            $shipping_price_mappings['308'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//308-Keyboard
            $shipping_price_mappings['309'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//309-Ultimate Ear (UE) Series
            $shipping_price_mappings['310'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//310-Gaming
            $shipping_price_mappings['311'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//311-Speaker
            $shipping_price_mappings['312'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//312-Tablet Accessories
            $shipping_price_mappings['313'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//313-Webcam
            $shipping_price_mappings['315'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//315-OEM / DIY PC
            $shipping_price_mappings['316'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//316-Branded PC
            $shipping_price_mappings['317'] = array('peninsular' => 12, 'sabah' => 22, 'sarawak' => 22);//317-Cooler Master
            $shipping_price_mappings['318'] = array('peninsular' => 20, 'sabah' => 50, 'sarawak' => 50);//318-Chassis
            $shipping_price_mappings['319'] = array('peninsular' => 20, 'sabah' => 50, 'sarawak' => 50);//319-Cooler Master
            $shipping_price_mappings['320'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//320-All In One PC
            $shipping_price_mappings['321'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//321-AMD Compatible Motherboards
            $shipping_price_mappings['322'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//322-Intel Compatible Motherboards
            $shipping_price_mappings['323'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//323-Server / Workstation Motherboards
            $shipping_price_mappings['324'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//324-AMD Desktop CPU
            $shipping_price_mappings['325'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//325-Intel Desktop CPU
            $shipping_price_mappings['326'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//326-500GB & Below
            $shipping_price_mappings['327'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//327-1TB & below
            $shipping_price_mappings['328'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//328-2TB & below
            $shipping_price_mappings['329'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//329-Car FM Modulator
            $shipping_price_mappings['330'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//330-Card Reader / Bluetooth
            $shipping_price_mappings['331'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//331-Wired Networking
            $shipping_price_mappings['332'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//332-USB Cable
            $shipping_price_mappings['334'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//334-ADSL Modem + Router
            $shipping_price_mappings['335'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//335-Wireless Adapter & Router
            $shipping_price_mappings['336'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//336-Networking Switcher
            $shipping_price_mappings['337'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//337-IP Camera
            $shipping_price_mappings['338'] = array('peninsular' => 25, 'sabah' => 120, 'sarawak' => 120);//338-NAS - Network Storage
            $shipping_price_mappings['339'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//339-Home Plug / Print Server / POE
            $shipping_price_mappings['340'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//340-KVM Switch
            $shipping_price_mappings['341'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//341-Firewall / License
            $shipping_price_mappings['342'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//342-Other Computer Cable
            $shipping_price_mappings['343'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//343-Edifier
            $shipping_price_mappings['344'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//344-Network Cable
            $shipping_price_mappings['345'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//345-External Harddisk
            $shipping_price_mappings['346'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//346-Western Digital
            $shipping_price_mappings['348'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//348-Ink
            $shipping_price_mappings['349'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//349-HP
            $shipping_price_mappings['351'] = array('peninsular' => 20, 'sabah' => 50, 'sarawak' => 50);//351-Toner
            $shipping_price_mappings['352'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//352-HP
            $shipping_price_mappings['354'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//354-Wireless
            $shipping_price_mappings['355'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//355-3G/4G Routers
            $shipping_price_mappings['356'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//356-ADSL
            $shipping_price_mappings['357'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//357-Switches
            $shipping_price_mappings['358'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//358-Routers
            $shipping_price_mappings['359'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//359-Powerline
            $shipping_price_mappings['360'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//360-IP Cameras
            $shipping_price_mappings['361'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//361-Print Servers
            $shipping_price_mappings['362'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//362-Power over Ethernet
            $shipping_price_mappings['363'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//363-Adapters & 56K Modem
            $shipping_price_mappings['364'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//364-3G Modem
            $shipping_price_mappings['365'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//365-IP Camera
            $shipping_price_mappings['366'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//366-Routers
            $shipping_price_mappings['368'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//368-Enclosure
            $shipping_price_mappings['370'] = array('peninsular' => 20, 'sabah' => 50, 'sarawak' => 50);//370-Raidmax
            $shipping_price_mappings['371'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//371-Access point
            $shipping_price_mappings['372'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//372-Notebook Cooler Pad
            $shipping_price_mappings['373'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//373-USB Hub
            $shipping_price_mappings['374'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//374-Keyboard / Screen Protector
            $shipping_price_mappings['376'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//376-Notebook Sleeve
            $shipping_price_mappings['377'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//377-Hard Disk Pouch
            $shipping_price_mappings['380'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//380-Tablet Drawing
            $shipping_price_mappings['381'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//381-Cooling
            $shipping_price_mappings['382'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//382-Cooler Master
            $shipping_price_mappings['383'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//383-AMD series
            $shipping_price_mappings['384'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//384-NViDIA series
            $shipping_price_mappings['385'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//385-Asus
            $shipping_price_mappings['386'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//386-3TB & below
            $shipping_price_mappings['387'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//387-Asus
            $shipping_price_mappings['389'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//389-Processor
            $shipping_price_mappings['390'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//390-Solid State Drive (SSD)
            $shipping_price_mappings['396'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//396-Solid State Drive (SSD)
            $shipping_price_mappings['397'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//397-Intel(SSD)
            $shipping_price_mappings['398'] = array('peninsular' => 12, 'sabah' => 22, 'sarawak' => 22);//398-Huntkey
            $shipping_price_mappings['399'] = array('peninsular' => 20, 'sabah' => 50, 'sarawak' => 50);//399-Huntkey
            $shipping_price_mappings['401'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//401-Media Player & TV BOX
            $shipping_price_mappings['402'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//402-Power Bank
            $shipping_price_mappings['403'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//403-Noontec
            $shipping_price_mappings['404'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//404-Noontec
            $shipping_price_mappings['408'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//408-Cooler Master
            $shipping_price_mappings['409'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//409-Hard Disk
            $shipping_price_mappings['410'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//410-RAM
            $shipping_price_mappings['411'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//411-Optical drive
            $shipping_price_mappings['414'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//414-Laptop & Notebook
            $shipping_price_mappings['415'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//415-Graphic Card
            $shipping_price_mappings['417'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//417-AMD series
            $shipping_price_mappings['418'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//418-NVIDIA series
            $shipping_price_mappings['420'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//420-Laptop/Notebook
            $shipping_price_mappings['421'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//421-Smartphone
            $shipping_price_mappings['422'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//422-VAIO Fit 14E/15E
            $shipping_price_mappings['423'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//423-VAIO Fit 14/15
            $shipping_price_mappings['424'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//424-VAIO Duo 13
            $shipping_price_mappings['425'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//425-VAIO Duo 11
            $shipping_price_mappings['426'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//426-S Series
            $shipping_price_mappings['427'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//427-T Series
            $shipping_price_mappings['428'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//428-VAIO Pro 11/13
            $shipping_price_mappings['430'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//430-Sony
            $shipping_price_mappings['431'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//431- VAIO Fit 14E/15E
            $shipping_price_mappings['432'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//432-VAIO Fit 14/15
            $shipping_price_mappings['433'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//433-VAIO Duo 13
            $shipping_price_mappings['434'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//434-VAIO Duo 11
            $shipping_price_mappings['435'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//435-S Series
            $shipping_price_mappings['436'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//436-T Series
            $shipping_price_mappings['437'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//437-VAIO Pro 11/13
            $shipping_price_mappings['438'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//438-Canon
            $shipping_price_mappings['439'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//439-Internal Harddisk
            $shipping_price_mappings['442'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//442-Mouse&Mice
            $shipping_price_mappings['443'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//443-Keyboard
            $shipping_price_mappings['444'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//444-Audio
            $shipping_price_mappings['445'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//445-Controller
            $shipping_price_mappings['446'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//446-Gaming Accessories
            $shipping_price_mappings['447'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//447-Gaming Mouse Pads
            $shipping_price_mappings['448'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//448-SteelSeries
            $shipping_price_mappings['449'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//449-Razer
            $shipping_price_mappings['450'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//450-SteelSeries
            $shipping_price_mappings['451'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//451-Razer
            $shipping_price_mappings['452'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//452-Razer
            $shipping_price_mappings['453'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//453-Razer
            $shipping_price_mappings['454'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//454-Razer
            $shipping_price_mappings['457'] = array('peninsular' => 12, 'sabah' => 22, 'sarawak' => 22);//457-HDMI
            $shipping_price_mappings['458'] = array('peninsular' => 12, 'sabah' => 22, 'sarawak' => 22);//458-HDMI Splitter
            $shipping_price_mappings['459'] = array('peninsular' => 12, 'sabah' => 22, 'sarawak' => 22);//459-HDMI Matrix
            $shipping_price_mappings['460'] = array('peninsular' => 12, 'sabah' => 22, 'sarawak' => 22);//460-HDMI Extender
            $shipping_price_mappings['461'] = array('peninsular' => 12, 'sabah' => 22, 'sarawak' => 22);//461-HDMI Switch
            $shipping_price_mappings['462'] = array('peninsular' => 12, 'sabah' => 22, 'sarawak' => 22);//462-HDMI Converter
            $shipping_price_mappings['463'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//463-AV converter
            $shipping_price_mappings['464'] = array('peninsular' => 12, 'sabah' => 22, 'sarawak' => 22);//464-VGA
            $shipping_price_mappings['465'] = array('peninsular' => 12, 'sabah' => 22, 'sarawak' => 22);//465-VGA Extender
            $shipping_price_mappings['466'] = array('peninsular' => 12, 'sabah' => 22, 'sarawak' => 22);//466-VGA splitter
            $shipping_price_mappings['467'] = array('peninsular' => 12, 'sabah' => 22, 'sarawak' => 22);//467-VGA Matrix
            $shipping_price_mappings['468'] = array('peninsular' => 12, 'sabah' => 22, 'sarawak' => 22);//468-KVM Extender
            $shipping_price_mappings['469'] = array('peninsular' => 12, 'sabah' => 22, 'sarawak' => 22);//469-USB Extender
            $shipping_price_mappings['471'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//471-PCI Card
            $shipping_price_mappings['472'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//472-Converters
            $shipping_price_mappings['473'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//473-Display Port to HDMI
            $shipping_price_mappings['474'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//474-Avermedia
            $shipping_price_mappings['475'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//475-Tv Tuner
            $shipping_price_mappings['476'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//476-Capture Card&Box
            $shipping_price_mappings['477'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//477-Accessories
            $shipping_price_mappings['478'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//478-PCI Express Card
            $shipping_price_mappings['479'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//479-Express Card
            $shipping_price_mappings['480'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//480-PCMCIA CardBus
            $shipping_price_mappings['481'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//481-Printer Server
            $shipping_price_mappings['482'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//482-Corsair
            $shipping_price_mappings['483'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//483-Corsair(SSD)
            $shipping_price_mappings['484'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//484-Digital Voice Recorders
            $shipping_price_mappings['485'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//485-MP3/ MP4 & Recorder
            $shipping_price_mappings['486'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//486-SONY
            $shipping_price_mappings['490'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//490-External Storage
            $shipping_price_mappings['491'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//491-Internal Storage
            $shipping_price_mappings['492'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//492-Cloud Storage
            $shipping_price_mappings['493'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//493-Home Entertainment
            $shipping_price_mappings['494'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//494-Desktop Drives
            $shipping_price_mappings['495'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//495-Desktop Drives for Mac
            $shipping_price_mappings['496'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//496-Portable Drives
            $shipping_price_mappings['497'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//497-Portable Drives for Mac
            $shipping_price_mappings['498'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//498-Personal Cloud Storage
            $shipping_price_mappings['499'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//499-Storage for Tablets
            $shipping_price_mappings['500'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//500-Desktop/ Workstation
            $shipping_price_mappings['501'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//501-Mobile
            $shipping_price_mappings['502'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//502-NAS
            $shipping_price_mappings['503'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//503-Datacenter
            $shipping_price_mappings['504'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//504-Audio/ Video
            $shipping_price_mappings['506'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//506-Solid State Storage (SSD)
            $shipping_price_mappings['512'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//512-Personal Cloud Storage
            $shipping_price_mappings['513'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//513-WD TV Media Players
            $shipping_price_mappings['514'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//514-Multimedia Drives
            $shipping_price_mappings['515'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//515-DVR Expander
            $shipping_price_mappings['519'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//519-CPU Air Cooler
            $shipping_price_mappings['520'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//520-CPU Liquid Cooler
            $shipping_price_mappings['521'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//521-OEM Cooler
            $shipping_price_mappings['522'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//522-Case Fan
            $shipping_price_mappings['523'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//523-Thermal Compound
            $shipping_price_mappings['524'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//524-Accessories
            $shipping_price_mappings['526'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//526-Powerline
            $shipping_price_mappings['528'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//528-HP 1000
            $shipping_price_mappings['529'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//529-HP Pavilion
            $shipping_price_mappings['530'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//530-HP 1000
            $shipping_price_mappings['531'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//531-HP Pavilion
            $shipping_price_mappings['532'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//532-HP ENVY
            $shipping_price_mappings['533'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//533-HP Spectre
            $shipping_price_mappings['534'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//534-HP Slatebook
            $shipping_price_mappings['535'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//535-HP ENVY
            $shipping_price_mappings['536'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//536-HP Spectre
            $shipping_price_mappings['537'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//537-HP Slatebook
            $shipping_price_mappings['538'] = array('peninsular' => 20, 'sabah' => 50, 'sarawak' => 50);//538-Canon
            $shipping_price_mappings['539'] = array('peninsular' => 20, 'sabah' => 50, 'sarawak' => 50);//539-All In One Printer
            $shipping_price_mappings['540'] = array('peninsular' => 20, 'sabah' => 50, 'sarawak' => 50);//540-Single Function Printer
            $shipping_price_mappings['541'] = array('peninsular' => 20, 'sabah' => 50, 'sarawak' => 50);//541-FAX
            $shipping_price_mappings['542'] = array('peninsular' => 20, 'sabah' => 50, 'sarawak' => 50);//542-ImageClass Laser AIO Printer
            $shipping_price_mappings['543'] = array('peninsular' => 20, 'sabah' => 50, 'sarawak' => 50);//543-Laser Printer
            $shipping_price_mappings['544'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//544-Bluetooth & wireless keyboard
            $shipping_price_mappings['547'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//547-Apple Notebook Adapter
            $shipping_price_mappings['550'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//550-Microsoft Software
            $shipping_price_mappings['552'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//552-Microsoft Surface
            $shipping_price_mappings['553'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//553-For Microsoft Surface
            $shipping_price_mappings['554'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//554-Asus
            $shipping_price_mappings['555'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//555-Acer
            $shipping_price_mappings['556'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//556-Microsoft Surface
            $shipping_price_mappings['559'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//559-Notebook / Table Bag & Casing
            $shipping_price_mappings['560'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//560-Other Speaker
            $shipping_price_mappings['561'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//561-GPS Store
            $shipping_price_mappings['562'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//562- Tablet & Notebook accessories
            $shipping_price_mappings['563'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//563-Apple
            $shipping_price_mappings['564'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//564-Notebook
            $shipping_price_mappings['565'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//565-Tablet
            $shipping_price_mappings['566'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//566-AC RYAN
            $shipping_price_mappings['568'] = array('peninsular' => 20, 'sabah' => 50, 'sarawak' => 50);//568-Printer
            $shipping_price_mappings['569'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//569-Bluetooth Adapter
            $shipping_price_mappings['571'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//571-Mouse & Keyboard
            $shipping_price_mappings['572'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//572-Notebook Bag
            $shipping_price_mappings['573'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//573-Joystick
            $shipping_price_mappings['575'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//575-Altec Lansing
            $shipping_price_mappings['576'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//576-Memo Pad
            $shipping_price_mappings['577'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//577-Portable Audio
            $shipping_price_mappings['578'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//578-Headphones
            $shipping_price_mappings['579'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//579-WalkmanÆ MP3 players/video players
            $shipping_price_mappings['580'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//580-Cintiq Series
            $shipping_price_mappings['581'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//581-Bamboo Series
            $shipping_price_mappings['582'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//582-Intuos Series
            $shipping_price_mappings['583'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//583-Stylus Pen
            $shipping_price_mappings['584'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//584-Accessories
            $shipping_price_mappings['589'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//589-Interactive Series
            $shipping_price_mappings['592'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//592-Sonic Gear
            $shipping_price_mappings['594'] = array('peninsular' => 20, 'sabah' => 50, 'sarawak' => 50);//594-Speaker
            $shipping_price_mappings['595'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//595-Pouch
            $shipping_price_mappings['596'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//596-Steelseries
            $shipping_price_mappings['597'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//597-Internet TV Hub
            $shipping_price_mappings['601'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//601-Accessories
            $shipping_price_mappings['602'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//602-Braven
            $shipping_price_mappings['604'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//604-Jawbone
            $shipping_price_mappings['605'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//605-Soundfreaq
            $shipping_price_mappings['606'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//606-C-Series
            $shipping_price_mappings['607'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//607-Cushion-Series
            $shipping_price_mappings['608'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//608-Modular-Series
            $shipping_price_mappings['609'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//609-AP- Series
            $shipping_price_mappings['610'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//610-AO-Series
            $shipping_price_mappings['611'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//611-Edifier
            $shipping_price_mappings['612'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//612-Speaker
            $shipping_price_mappings['613'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//613-Earphone
            $shipping_price_mappings['614'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//614-Headset
            $shipping_price_mappings['615'] = array('peninsular' => 20, 'sabah' => 50, 'sarawak' => 50);//615-HP
            $shipping_price_mappings['616'] = array('peninsular' => 20, 'sabah' => 50, 'sarawak' => 50);//616-Scanner
            $shipping_price_mappings['617'] = array('peninsular' => 20, 'sabah' => 50, 'sarawak' => 50);//617-Laser Printer
            $shipping_price_mappings['618'] = array('peninsular' => 20, 'sabah' => 50, 'sarawak' => 50);//618-Laser Printer
            $shipping_price_mappings['619'] = array('peninsular' => 20, 'sabah' => 50, 'sarawak' => 50);//619-All In One Printer
            $shipping_price_mappings['620'] = array('peninsular' => 20, 'sabah' => 50, 'sarawak' => 50);//620-Scanner
            $shipping_price_mappings['621'] = array('peninsular' => 20, 'sabah' => 50, 'sarawak' => 50);//621-All In One Printer
            $shipping_price_mappings['622'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//622-Mouse Pads & Mats
            $shipping_price_mappings['624'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//624-Laptop & Ultrabook
            $shipping_price_mappings['625'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//625-Tablets
            $shipping_price_mappings['626'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//626-Smartphone
            $shipping_price_mappings['627'] = array('peninsular' => 25, 'sabah' => 120, 'sarawak' => 120);//627-Desktops & All-In-Ones
            $shipping_price_mappings['628'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//628-Accessories
            $shipping_price_mappings['629'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//629-Lenovo
            $shipping_price_mappings['630'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//630-Gigabyte
            $shipping_price_mappings['631'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//631-Buffalo
            $shipping_price_mappings['633'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//633-External DVD Drive
            $shipping_price_mappings['634'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//634-Kingston(SSD)
            $shipping_price_mappings['635'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//635-Kingston
            $shipping_price_mappings['636'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//636-Logitech
            $shipping_price_mappings['637'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//637-Sapphire
            $shipping_price_mappings['638'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//638-SteelSeries
            $shipping_price_mappings['639'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//639-USB Adapter
            $shipping_price_mappings['640'] = array('peninsular' => 20, 'sabah' => 50, 'sarawak' => 50);//640-Samsung
            $shipping_price_mappings['643'] = array('peninsular' => 25, 'sabah' => 120, 'sarawak' => 120);//643-Custom Build PC
            $shipping_price_mappings['644'] = array('peninsular' => 25, 'sabah' => 120, 'sarawak' => 120);//644-Everyday PCs
            $shipping_price_mappings['645'] = array('peninsular' => 15, 'sabah' => 40, 'sarawak' => 40);//645-Monitor
            $shipping_price_mappings['646'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//646-Valve
            $shipping_price_mappings['647'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//647-Microsoft Accessories
            $shipping_price_mappings['649'] = array('peninsular' => 8, 'sabah' => 10, 'sarawak' => 10);//649-Game
            $shipping_price_mappings['651'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//651-Tablets
            $shipping_price_mappings['652'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//652-Huawei
            $shipping_price_mappings['654'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//654-Audiophile Sound
            $shipping_price_mappings['655'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//655-Home Entertainment
            $shipping_price_mappings['656'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//656-Portable Entertainment
            $shipping_price_mappings['657'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//657-Professional
            $shipping_price_mappings['658'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//658-Sennheiser / Adidas Originals
            $shipping_price_mappings['659'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//659-PC Headsets
            $shipping_price_mappings['660'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//660-Gaming Headsets
            $shipping_price_mappings['666'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//666-Accessories
            $shipping_price_mappings['668'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//668-Projector
            $shipping_price_mappings['669'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//669-Projector
            $shipping_price_mappings['670'] = array('peninsular' => 20, 'sabah' => 50, 'sarawak' => 50);//670-Printer
            $shipping_price_mappings['671'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//671-Projector
            $shipping_price_mappings['672'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//672-Projector
            $shipping_price_mappings['676'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//676-Projector
            $shipping_price_mappings['678'] = array('peninsular' => 15, 'sabah' => 40, 'sarawak' => 40);//678-Monitor
            $shipping_price_mappings['680'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//680-Dota 2
            $shipping_price_mappings['681'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//681-Counter-Strike
            $shipping_price_mappings['682'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//682-Half-Life 2
            $shipping_price_mappings['683'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//683-Left 4 Dead
            $shipping_price_mappings['684'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//684-Portal
            $shipping_price_mappings['685'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//685-Portal 2
            $shipping_price_mappings['686'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//686-Team Fortress 2
            $shipping_price_mappings['688'] = array('peninsular' => 20, 'sabah' => 50, 'sarawak' => 50);//688-Printer
            $shipping_price_mappings['690'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//690-Projector Accessories
            $shipping_price_mappings['691'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//691-Flash Drive (Pendirve)
            $shipping_price_mappings['692'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//692-Jumbox
            $shipping_price_mappings['693'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//693-iBank
            $shipping_price_mappings['694'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//694-Incito Dtech
            $shipping_price_mappings['695'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//695-Tech Titan
            $shipping_price_mappings['697'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//697-SteelSeries
            $shipping_price_mappings['698'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//698-Controller
            $shipping_price_mappings['699'] = array('peninsular' => 20, 'sabah' => 50, 'sarawak' => 50);//699-Speaker
            $shipping_price_mappings['702'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//702-Left 4 Dead 2
            $shipping_price_mappings['703'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//703-Logitech
            $shipping_price_mappings['704'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//704-Controller
            $shipping_price_mappings['705'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//705-Headset & Earphone
            $shipping_price_mappings['706'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//706-Presenter
            $shipping_price_mappings['708'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//708-Logitech
            $shipping_price_mappings['709'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//709-Logitech
            $shipping_price_mappings['710'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//710-Sennheiser
            $shipping_price_mappings['711'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//711-CM Storm
            $shipping_price_mappings['712'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//712-CM Storm
            $shipping_price_mappings['713'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//713-CM Storm
            $shipping_price_mappings['714'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//714-Bloody
            $shipping_price_mappings['715'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//715-Acer
            $shipping_price_mappings['716'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//716-Epson
            $shipping_price_mappings['717'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//717-Roccat
            $shipping_price_mappings['718'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//718-Roccat
            $shipping_price_mappings['719'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//719-Roccat
            $shipping_price_mappings['720'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//720-Roccat
            $shipping_price_mappings['721'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//721-BenQ
            $shipping_price_mappings['722'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//722-ViewSonic
            $shipping_price_mappings['723'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//723-Infocus
            $shipping_price_mappings['724'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//724-Panasonic
            $shipping_price_mappings['726'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//726-Steam Wallet
            $shipping_price_mappings['727'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//727-My Cloud
            $shipping_price_mappings['728'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//728-Canon
            $shipping_price_mappings['729'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//729-Printer Ink
            $shipping_price_mappings['730'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//730-i-Rocks
            $shipping_price_mappings['731'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//731-i-Rocks
            $shipping_price_mappings['732'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//732-i-Rocks
            $shipping_price_mappings['733'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//733-i-Rocks
            $shipping_price_mappings['734'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//734-2.5" Internal Harddisk
            $shipping_price_mappings['735'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//735-450GB & below
            $shipping_price_mappings['736'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//736-500GB & Above
            $shipping_price_mappings['737'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//737-Western Digital
            $shipping_price_mappings['738'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//738-Figures
            $shipping_price_mappings['740'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//740-Astro
            $shipping_price_mappings['741'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//741-NEC
            $shipping_price_mappings['743'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//743-Headphones
            $shipping_price_mappings['744'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//744-Earphones
            $shipping_price_mappings['745'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//745-Speakers
            $shipping_price_mappings['753'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//753-G Series
            $shipping_price_mappings['754'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//754-S Series
            $shipping_price_mappings['755'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//755-U Series
            $shipping_price_mappings['756'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//756-Y Series
            $shipping_price_mappings['757'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//757-Y Series
            $shipping_price_mappings['758'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//758-Laptop
            $shipping_price_mappings['760'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//760-Asus
            $shipping_price_mappings['761'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//761-Dell
            $shipping_price_mappings['762'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//762-HP
            $shipping_price_mappings['763'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//763-Lenovo
            $shipping_price_mappings['766'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//766-ThinkPad
            $shipping_price_mappings['767'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//767-IdeaPad
            $shipping_price_mappings['768'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//768-G Series
            $shipping_price_mappings['769'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//769-Flex Series
            $shipping_price_mappings['770'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//770-S Series
            $shipping_price_mappings['771'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//771-U Series
            $shipping_price_mappings['772'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//772-Y Series
            $shipping_price_mappings['773'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//773-Yoga Series
            $shipping_price_mappings['774'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//774-Z Series
            $shipping_price_mappings['775'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//775-A Series
            $shipping_price_mappings['776'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//776-X Series
            $shipping_price_mappings['777'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//777-K Series
            $shipping_price_mappings['778'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//778-S Series
            $shipping_price_mappings['779'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//779-N Series
            $shipping_price_mappings['780'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//780-Zenbook
            $shipping_price_mappings['781'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//781-Pro Series
            $shipping_price_mappings['782'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//782-ROG Gaming
            $shipping_price_mappings['783'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//783-Transformer Book
            $shipping_price_mappings['784'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//784-Aspire E1
            $shipping_price_mappings['785'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//785-Aspire V5
            $shipping_price_mappings['786'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//786-Aspire V7
            $shipping_price_mappings['787'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//787-Aspire R7
            $shipping_price_mappings['788'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//788-Aspire S7 Ultrabook
            $shipping_price_mappings['789'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//789-Vostro Series
            $shipping_price_mappings['790'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//790-Inspiron
            $shipping_price_mappings['791'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//791-XPS Series
            $shipping_price_mappings['792'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//792-Amd Series
            $shipping_price_mappings['793'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//793-Intel Celeron
            $shipping_price_mappings['794'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//794-Intel Pentium
            $shipping_price_mappings['795'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//795-Intel Core i3
            $shipping_price_mappings['796'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//796-Intel Core i5
            $shipping_price_mappings['797'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//797-Intel Core i7
            $shipping_price_mappings['798'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//798-AMD Processor
            $shipping_price_mappings['799'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//799-Intel Celeron
            $shipping_price_mappings['800'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//800-Intel Pentium
            $shipping_price_mappings['801'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//801-Intel Core i3
            $shipping_price_mappings['802'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//802-Intel Core i5
            $shipping_price_mappings['803'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//803-Intel Core i7
            $shipping_price_mappings['804'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//804-Price Below RM1099
            $shipping_price_mappings['805'] = array('peninsular' => 15, 'sabah' => 40, 'sarawak' => 40);//805-Acer
            $shipping_price_mappings['806'] = array('peninsular' => 15, 'sabah' => 40, 'sarawak' => 40);//806-Asus
            $shipping_price_mappings['807'] = array('peninsular' => 15, 'sabah' => 40, 'sarawak' => 40);//807-Dell
            $shipping_price_mappings['808'] = array('peninsular' => 15, 'sabah' => 40, 'sarawak' => 40);//808-HP
            $shipping_price_mappings['809'] = array('peninsular' => 15, 'sabah' => 40, 'sarawak' => 40);//809-LG
            $shipping_price_mappings['810'] = array('peninsular' => 15, 'sabah' => 40, 'sarawak' => 40);//810-Below 20'
            $shipping_price_mappings['811'] = array('peninsular' => 15, 'sabah' => 40, 'sarawak' => 40);//811-21.5' - 24'
            $shipping_price_mappings['812'] = array('peninsular' => 15, 'sabah' => 40, 'sarawak' => 40);//812-25' - 27'
            $shipping_price_mappings['813'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//813-Acer
            $shipping_price_mappings['814'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//814-Asus
            $shipping_price_mappings['815'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//815-Dell
            $shipping_price_mappings['816'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//816-HP
            $shipping_price_mappings['817'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//817-Lenovo
            $shipping_price_mappings['818'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//818-Amd Processor
            $shipping_price_mappings['819'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//819-Intel Celeron
            $shipping_price_mappings['820'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//820-Intel Pentium
            $shipping_price_mappings['821'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//821-Intel Core i3
            $shipping_price_mappings['822'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//822-Intel Core i5
            $shipping_price_mappings['823'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//823-Intel Core i7
            $shipping_price_mappings['826'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//826-Optoma
            $shipping_price_mappings['827'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//827-Full HD Projector
            $shipping_price_mappings['828'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//828-LED Projector
            $shipping_price_mappings['830'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//830-Projector Accessories
            $shipping_price_mappings['831'] = array('peninsular' => 15, 'sabah' => 40, 'sarawak' => 40);//831-Philips
            $shipping_price_mappings['832'] = array('peninsular' => 15, 'sabah' => 40, 'sarawak' => 40);//832-Samsung
            $shipping_price_mappings['834'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//834-Music
            $shipping_price_mappings['835'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//835-Ukulele
            $shipping_price_mappings['836'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//836-Makai
            $shipping_price_mappings['837'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//837-Mobile Phone
            $shipping_price_mappings['838'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//838-Intel Processor Notebook
            $shipping_price_mappings['839'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//839-AMD Processor Notebook
            $shipping_price_mappings['840'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//840-Gaming & Hobby
            $shipping_price_mappings['841'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//841-Toys
            $shipping_price_mappings['842'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//842-ACER
            $shipping_price_mappings['843'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//843-ASUS
            $shipping_price_mappings['844'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//844-LENOVO
            $shipping_price_mappings['845'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//845-Games
            $shipping_price_mappings['846'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//846-Digital Codes
            $shipping_price_mappings['847'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//847-Intel Processor Laptop
            $shipping_price_mappings['848'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//848-Intel Processor Ultrabook
            $shipping_price_mappings['849'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//849-Intel Processor 2 IN 1 Notebook
            $shipping_price_mappings['850'] = array('peninsular' => 25, 'sabah' => 120, 'sarawak' => 120);//850-Intel Processor Desktop PC
            $shipping_price_mappings['851'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//851-Intel Processor Chromebook
            $shipping_price_mappings['852'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//852-Lenovo
            $shipping_price_mappings['853'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//853-Alienware
            $shipping_price_mappings['854'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//854-Aspire E5
            $shipping_price_mappings['859'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//859-Solid State Drive (SSD)
            $shipping_price_mappings['860'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//860-Samsung
            $shipping_price_mappings['863'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//863-Card Fight
            $shipping_price_mappings['864'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//864-Gundam
            $shipping_price_mappings['865'] = array('peninsular' => 8, 'sabah' => 10, 'sarawak' => 10);//865-Bitdefender
            $shipping_price_mappings['866'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//866-Server & Workstation
            $shipping_price_mappings['867'] = array('peninsular' => 25, 'sabah' => 120, 'sarawak' => 120);//867-Dell
            $shipping_price_mappings['868'] = array('peninsular' => 25, 'sabah' => 120, 'sarawak' => 120);//868-HP
            $shipping_price_mappings['869'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//869-Blizzard
            $shipping_price_mappings['870'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//870-Synology
            $shipping_price_mappings['871'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//871-Asustor
            $shipping_price_mappings['872'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//872-QNAP
            $shipping_price_mappings['873'] = array('peninsular' => 20, 'sabah' => 50, 'sarawak' => 50);//873-Printer
            $shipping_price_mappings['874'] = array('peninsular' => 20, 'sabah' => 50, 'sarawak' => 50);//874-Epson
            $shipping_price_mappings['875'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//875-Harddisk
            $shipping_price_mappings['876'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//876-Sony
            $shipping_price_mappings['884'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//884-Adata SSD
            $shipping_price_mappings['889'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//889-Seagate
            $shipping_price_mappings['890'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//890-Gundam
            $shipping_price_mappings['898'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//898-Hawaii
            $shipping_price_mappings['899'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//899-Puretone
            $shipping_price_mappings['900'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//900-Keyboard & Piano 
            $shipping_price_mappings['901'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//901-Casio
            $shipping_price_mappings['902'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//902-Puretone
            $shipping_price_mappings['904'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//904-AMD Socket
            $shipping_price_mappings['905'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//905-Intel Socket
            $shipping_price_mappings['906'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//906-Guitar & Electric Guitar
            $shipping_price_mappings['907'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//907-Accessories
            $shipping_price_mappings['908'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//908-12.12 Sales
            $shipping_price_mappings['909'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//909-Tower Of Savior 
            $shipping_price_mappings['910'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//910-Notebook
            $shipping_price_mappings['911'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//911-Harddisk
            $shipping_price_mappings['912'] = array('peninsular' => 8, 'sabah' => 15, 'sarawak' => 15);//912-Accessories
            $shipping_price_mappings['914'] = array('peninsular' => 12, 'sabah' => 20, 'sarawak' => 20);//914-Mobile & Tablet
            $shipping_price_mappings['915'] = array('peninsular' => 15, 'sabah' => 35, 'sarawak' => 35);//915-HP
            
            $this->shipping_price_mappings = $shipping_price_mappings;
        }
        
    }
    
?>