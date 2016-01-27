<?php
require_once(dirname(__FILE__).'/lelong_config.php');

    class CategoryHelper{
        
        private $prodCategories;
        private $prodDefaultCatId;
		private $_db;
		
        public function __construct($db = null){
			$this->_db = $db;
            //$this->LoadCategoryData();
        }
        
        public function SetProductCategories($defaultCatId, $categories){
            $this->prodCategories = $categories;
            $this->prodDefaultCatId = $defaultCatId;
        }
        
        public function GetProductCategoryId(){
            $categoryId = $this->prodDefaultCatId;
            $category = $this->category[''.$this->prodDefaultCatId.''];
            
            if(empty($category) || !is_array($category) || $category == null){
                foreach($this->prodCategories as $cat){
                    $category = $this->category[''.$cat.''];
                    if(!empty($category) && is_array($category) && $category != null){
                        $categoryId = $cat;
                    }
                }
            }
            return $categoryId;
        }
        
		public function GetLelongCategory($catId){
			$query = $this->_db->query('SELECT * FROM '.DB_PREFIX.'setting WHERE `key` = "lelong_category_'.$catId.'"');
            return ($query != null && $query->row != null && isset($query->row['value']))?$query->row['value']:null;
        }
        
        public function GetLelongStoreCategory($catId){
			$query = $this->_db->query('SELECT * FROM '.DB_PREFIX.'setting WHERE `key` = "lelong_category_'.$catId.'_store"');
            return ($query != null && $query->row != null && isset($query->row['value']))?$query->row['value']:null;
        }
		
		/*
		//Deprecated
        public function GetLelongCategory($catId){
			
			if(!isset($this->category[''.$catId.''])){
				return null;
			}
            return $this->category[''.$catId.'']['lelong'];
        }
        //Deprecated
        public function GetLelongStoreCategory($catId){
			
			if(!isset($this->category[''.$catId.''])){
				return null;
			}
            return $this->category[''.$catId.'']['store'];
        }*/
        
        public function LoadCategoryData(){
			
			$category_mappings['3'] = array('lelong' => 1335, 'store' => 199511);//3-Computers
			$category_mappings['210'] = array('lelong' => 1335, 'store' => 199511);//210-2-in-1 Notebook
			$category_mappings['261'] = array('lelong' => 1335, 'store' => 199511);//261-Acer
			$category_mappings['262'] = array('lelong' => 1335, 'store' => 199511);//262-Asus
			$category_mappings['263'] = array('lelong' => 1335, 'store' => 199511);//263-HP
			$category_mappings['264'] = array('lelong' => 1335, 'store' => 199511);//264-Lenovo
			$category_mappings['211'] = array('lelong' => 1335, 'store' => 199511);//211-All-in-one
			$category_mappings['265'] = array('lelong' => 1335, 'store' => 199511);//265-Asus
			$category_mappings['266'] = array('lelong' => 1335, 'store' => 199511);//266-Dell
			$category_mappings['267'] = array('lelong' => 1335, 'store' => 199511);//267-HP
			$category_mappings['268'] = array('lelong' => 1335, 'store' => 199511);//268-Lenovo
			
			
			/**********************************Deprecated*************************************************/
            $category_mappings['20'] = array('lelong' => 1335, 'store' => 199511);//11-Networking
            $category_mappings['12'] = array('lelong' => 764, 'store' => 180657);//12-Notebook & Desktop PC
            $category_mappings['27'] = array('lelong' => 716, 'store' => 179512);//27-Mobile Phone & Tablet
            $category_mappings['28'] = array('lelong' => 1192, 'store' => 179512);//28-HTC
            $category_mappings['29'] = array('lelong' => 706, 'store' => 179512);//29-Nokia
            $category_mappings['30'] = array('lelong' => 709, 'store' => 179512);//30-Samsung
            $category_mappings['31'] = array('lelong' => 708, 'store' => 179512);//31-Sony
            $category_mappings['35'] = array('lelong' => 59, 'store' => 179503);//35-PC Hardware
            $category_mappings['36'] = array('lelong' => 377, 'store' => 179502);//36-Peripherals
            $category_mappings['40'] = array('lelong' => 766, 'store' => 179502);//40-Notebook Bag
            $category_mappings['41'] = array('lelong' => 716, 'store' => 179512);//41-Tablet
            $category_mappings['46'] = array('lelong' => 667, 'store' => 199517);//46-Software
            $category_mappings['49'] = array('lelong' => 57, 'store' => 180657);//49-Mac
            $category_mappings['50'] = array('lelong' => 1324, 'store' => 179512);//50-iPod
            $category_mappings['51'] = array('lelong' => 1196, 'store' => 179512);//51-iPhone
            $category_mappings['52'] = array('lelong' => 1368, 'store' => 179512);//52-iPad
            $category_mappings['54'] = array('lelong' => 1324, 'store' => 179513);//54-Apple Accessories
            $category_mappings['56'] = array('lelong' => 57, 'store' => 180657);//56-MacBook Air
            $category_mappings['57'] = array('lelong' => 57, 'store' => 180657);//57-MacBook Pro
            $category_mappings['58'] = array('lelong' => 57, 'store' => 180657);//58-Mac Mini
            $category_mappings['59'] = array('lelong' => 1324, 'store' => 179512);//59-iPod Shuffle
            $category_mappings['60'] = array('lelong' => 1324, 'store' => 179512);//60-iPod Nano
            $category_mappings['62'] = array('lelong' => 1324, 'store' => 179512);//62-iPad Touch
            $category_mappings['63'] = array('lelong' => 1368, 'store' => 179512);//63-iPad Mini
            $category_mappings['64'] = array('lelong' => 1368, 'store' => 179512);//64-iPad with Retina Display
            $category_mappings['65'] = array('lelong' => 716, 'store' => 179512);//65-Mobile Phone
            $category_mappings['66'] = array('lelong' => 716, 'store' => 179512);//66-Tablet
            $category_mappings['67'] = array('lelong' => 764, 'store' => 180657);//67-NoteBook
            $category_mappings['68'] = array('lelong' => 764, 'store' => 199245);//68-PC & All in one PC
            $category_mappings['70'] = array('lelong' => 423, 'store' => 155030);//70-Printer
            $category_mappings['71'] = array('lelong' => 929, 'store' => 179501);//71-Monitor
            $category_mappings['73'] = array('lelong' => 57, 'store' => 180657);//73-iMac
            $category_mappings['74'] = array('lelong' => 716, 'store' => 179512);//74-Galaxy
            $category_mappings['75'] = array('lelong' => 716, 'store' => 179512);//75-Tab
            $category_mappings['76'] = array('lelong' => 716, 'store' => 179512);//76-Note
            $category_mappings['77'] = array('lelong' => 764, 'store' => 180657);//77-Book
            $category_mappings['78'] = array('lelong' => 764, 'store' => 180657);//78-Eureka
            $category_mappings['79'] = array('lelong' => 764, 'store' => 180657);//79-Series
            $category_mappings['80'] = array('lelong' => 764, 'store' => 180657);//80-Smart PC
            $category_mappings['81'] = array('lelong' => 697, 'store' => 179513);//81-Casing & Cover
            $category_mappings['82'] = array('lelong' => 696, 'store' => 179513);//82-Screen Protector
            $category_mappings['83'] = array('lelong' => 694, 'store' => 179513);//83-Charger
            $category_mappings['84'] = array('lelong' => 699, 'store' => 179507);//84-HeadSet
            $category_mappings['85'] = array('lelong' => 419, 'store' => 155030);//85-Ink Jet
            $category_mappings['86'] = array('lelong' => 418, 'store' => 155030);//86-Laser Jet
            $category_mappings['89'] = array('lelong' => 716, 'store' => 179512);//89-other
            $category_mappings['93'] = array('lelong' => 764, 'store' => 180657);//93-Notebooks
            $category_mappings['94'] = array('lelong' => 716, 'store' => 179512);//94-Tablet
            $category_mappings['95'] = array('lelong' => 75, 'store' => 180657);//95-Desktop
            $category_mappings['96'] = array('lelong' => 75, 'store' => 199245);//96-All in One PC
            $category_mappings['97'] = array('lelong' => 929, 'store' => 179501);//97-Monitor
            $category_mappings['98'] = array('lelong' => 423, 'store' => 155030);//98-Printer & Ink / Tonner
            $category_mappings['99'] = array('lelong' => 696, 'store' => 179513);//99-Accessories
            $category_mappings['106'] = array('lelong' => 764, 'store' => 180657);//106-Asus Notebook & Ultrabook
            $category_mappings['107'] = array('lelong' => 59, 'store' => 179503);//107-Motherboard
            $category_mappings['108'] = array('lelong' => 716, 'store' => 179512);//108-Tablet & Mobile
            $category_mappings['109'] = array('lelong' => 1254, 'store' => 179503);//109-Graphic Cards
            $category_mappings['110'] = array('lelong' => 764, 'store' => 181393);//110-Desktop & AiO PCs
            $category_mappings['112'] = array('lelong' => 75, 'store' => 199245);//112-All in One PC
            $category_mappings['113'] = array('lelong' => 929, 'store' => 179501);//113-Monitor
            $category_mappings['114'] = array('lelong' => 377, 'store' => 179502);//114-Optical drive, Audio &  Multimedia
            $category_mappings['118'] = array('lelong' => 77, 'store' => 199511);//118-Server & WorksStation
            $category_mappings['121'] = array('lelong' => 764, 'store' => 180657);//121-Notebook
            $category_mappings['122'] = array('lelong' => 716, 'store' => 179512);//122-Tablet
            $category_mappings['123'] = array('lelong' => 75, 'store' => 199245);//123-All in One PC
            $category_mappings['124'] = array('lelong' => 764, 'store' => 180657);//124-Desktop
            $category_mappings['125'] = array('lelong' => 716, 'store' => 179512);//125-Smartphone
            $category_mappings['126'] = array('lelong' => 929, 'store' => 179501);//126-Monitor
            $category_mappings['127'] = array('lelong' => 399, 'store' => 160260);//127-Projectors
            $category_mappings['128'] = array('lelong' => 696, 'store' => 179513);//128-Accessories
            $category_mappings['136'] = array('lelong' => 769, 'store' => 179503);//136-Intel
            $category_mappings['137'] = array('lelong' => 770, 'store' => 179503);//137-AMD
            $category_mappings['138'] = array('lelong' => 771, 'store' => 179503);//138-ROG / Republic of Gamers
            $category_mappings['139'] = array('lelong' => 771, 'store' => 179503);//139-TUF / The Ultimate Fighter
            $category_mappings['140'] = array('lelong' => 771, 'store' => 179503);//140-others..
            $category_mappings['141'] = array('lelong' => 1181, 'store' => 179512);//141-Pad Fone
            $category_mappings['142'] = array('lelong' => 1181, 'store' => 179512);//142-Asus ViviTab
            $category_mappings['143'] = array('lelong' => 1181, 'store' => 179512);//143-Nexus
            $category_mappings['144'] = array('lelong' => 1181, 'store' => 179512);//144-Asus Transform Pad
            $category_mappings['145'] = array('lelong' => 1181, 'store' => 179512);//145-Asus FonePad
            $category_mappings['146'] = array('lelong' => 1254, 'store' => 179503);//146-AMD series
            $category_mappings['147'] = array('lelong' => 1254, 'store' => 179503);//147-NViDIA series
            $category_mappings['148'] = array('lelong' => 1254, 'store' => 179503);//148-ROG / Republic of Gamers series
            $category_mappings['149'] = array('lelong' => 377, 'store' => 179502);//149-Optical drive
            $category_mappings['150'] = array('lelong' => 319, 'store' => 179503);//150-Sound Card and Others
            $category_mappings['151'] = array('lelong' => 1427, 'store' => 179502);//151-Headphone / Head set & speaker
            $category_mappings['152'] = array('lelong' => 765, 'store' => 179503);//152-Multimedia
            $category_mappings['153'] = array('lelong' => 1335, 'store' => 199511);//153-Wireless Router
            $category_mappings['154'] = array('lelong' => 1335, 'store' => 199511);//154-Wireless AP / Range External / Bridge
            $category_mappings['155'] = array('lelong' => 1335, 'store' => 199511);//155-Wireless Adapter
            $category_mappings['156'] = array('lelong' => 1335, 'store' => 199511);//156-Wireless Networking
            $category_mappings['157'] = array('lelong' => 1335, 'store' => 199511);//157-Modern Routers
            $category_mappings['158'] = array('lelong' => 769, 'store' => 179503);//158-Motherboard
            $category_mappings['159'] = array('lelong' => 764, 'store' => 180657);//159-Notebook
            $category_mappings['160'] = array('lelong' => 75, 'store' => 199245);//160-Desktop
            $category_mappings['161'] = array('lelong' => 1254, 'store' => 179503);//161-Graphic Cards
            $category_mappings['162'] = array('lelong' => 303, 'store' => 179502);//162-Keyboard & Mouse
            $category_mappings['163'] = array('lelong' => 764, 'store' => 180657);//163-ZenBook
            $category_mappings['164'] = array('lelong' => 764, 'store' => 180657);//164-ASUS N Series
            $category_mappings['165'] = array('lelong' => 764, 'store' => 180657);//165-Asus  VivoBook
            $category_mappings['166'] = array('lelong' => 764, 'store' => 180657);//166-Asus A450/ A550 Series
            $category_mappings['167'] = array('lelong' => 764, 'store' => 180657);//167-ASUS ROG Gaming
            $category_mappings['170'] = array('lelong' => 764, 'store' => 180657);//170-Asus A  SERIES
            $category_mappings['171'] = array('lelong' => 764, 'store' => 180657);//171-Asus Intel X Series
            $category_mappings['172'] = array('lelong' => 764, 'store' => 180657);//172-Asus Ultra slim / UltraBook
            $category_mappings['176'] = array('lelong' => 764, 'store' => 180657);//176-Acer
            $category_mappings['177'] = array('lelong' => 764, 'store' => 180657);//177-Asus
            $category_mappings['178'] = array('lelong' => 764, 'store' => 180657);//178-Hewlett-Packard
            $category_mappings['179'] = array('lelong' => 764, 'store' => 180657);//179-Samsung
            $category_mappings['182'] = array('lelong' => 1442, 'store' => 179512);//182-Acer
            $category_mappings['184'] = array('lelong' => 1442, 'store' => 179512);//184-Asus
            $category_mappings['186'] = array('lelong' => 1442, 'store' => 179512);//186-Samsung
            $category_mappings['187'] = array('lelong' => 764, 'store' => 180657);//187-Laptop & Notebook
            $category_mappings['189'] = array('lelong' => 767, 'store' => 179502);//189-Battery &  Adapter
            $category_mappings['191'] = array('lelong' => 696, 'store' => 179513);//191-Samsung Mobile part / Cable
            $category_mappings['192'] = array('lelong' => 765, 'store' => 179502);//192-Asus Notebook Accessories
            $category_mappings['193'] = array('lelong' => 767, 'store' => 179502);//193-Asus Notebook Battery / Adapter
            $category_mappings['195'] = array('lelong' => 764, 'store' => 180657);//195-Dell
            $category_mappings['196'] = array('lelong' => 764, 'store' => 180657);//196-Laptop
            $category_mappings['200'] = array('lelong' => 57, 'store' => 180657);//200-MacBook Air
            $category_mappings['201'] = array('lelong' => 57, 'store' => 180657);//201-MacBook Pro
            $category_mappings['202'] = array('lelong' => 766, 'store' => 179502);//202-Notebook Bag
            $category_mappings['204'] = array('lelong' => 57, 'store' => 179502);//204-MacBook Accessories
            $category_mappings['205'] = array('lelong' => 764, 'store' => 180657);//205-Laptop & Notebook
            $category_mappings['206'] = array('lelong' => 767, 'store' => 179502);//206-Battery &  Adapter
            $category_mappings['208'] = array('lelong' => 764, 'store' => 180657);//208-Laptop & Notebook
            $category_mappings['210'] = array('lelong' => 767, 'store' => 179502);//210-Battery &  Adapter
            $category_mappings['211'] = array('lelong' => 764, 'store' => 180657);//211-Toshiba
            $category_mappings['212'] = array('lelong' => 716, 'store' => 179512);//212-Intel Processor
            $category_mappings['213'] = array('lelong' => 716, 'store' => 179512);//213-Window 8
            $category_mappings['214'] = array('lelong' => 716, 'store' => 179512);//214-Android
            $category_mappings['215'] = array('lelong' => 1442, 'store' => 179512);//215-Lenovo
            $category_mappings['216'] = array('lelong' => 1369, 'store' => 179512);//216-Samsung
            $category_mappings['217'] = array('lelong' => 1369, 'store' => 179512);//217-Sony
            $category_mappings['218'] = array('lelong' => 1369, 'store' => 179512);//218-Asus
            $category_mappings['219'] = array('lelong' => 1369, 'store' => 179512);//219-Acer
            $category_mappings['220'] = array('lelong' => 1369, 'store' => 179512);//220-Others..
            $category_mappings['221'] = array('lelong' => 764, 'store' => 180657);//221-Others..
            $category_mappings['222'] = array('lelong' => 58, 'store' => 179502);//222-Cables
            $category_mappings['223'] = array('lelong' => 58, 'store' => 179502);//223-VGA Cables
            $category_mappings['232'] = array('lelong' => 696, 'store' => 179512);//232-Tablet Accessories
            $category_mappings['233'] = array('lelong' => 767, 'store' => 179502);//233-Battery &  Adapter
            $category_mappings['234'] = array('lelong' => 764, 'store' => 180657);//234-Laptop
            $category_mappings['236'] = array('lelong' => 767, 'store' => 179502);//236-Battery &  Adapter
            $category_mappings['237'] = array('lelong' => 764, 'store' => 180657);//237-Lenovo
            $category_mappings['238'] = array('lelong' => 75, 'store' => 199245);//238-Desktop PC
            $category_mappings['239'] = array('lelong' => 757, 'store' => 179503);//239-Processor
            $category_mappings['240'] = array('lelong' => 771, 'store' => 179503);//240-Motherboard
            $category_mappings['241'] = array('lelong' => 58, 'store' => 179502);//241-HDMI Cable
            $category_mappings['242'] = array('lelong' => 764, 'store' => 180657);//242-ThinkPad
            $category_mappings['243'] = array('lelong' => 764, 'store' => 180657);//243-Ideapad
            $category_mappings['244'] = array('lelong' => 764, 'store' => 180657);//244-Essential
            $category_mappings['245'] = array('lelong' => 765, 'store' => 179502);//245-Laptop Accessories
            $category_mappings['246'] = array('lelong' => 377, 'store' => 179502);//246-Adapter & Charger Kit
            $category_mappings['247'] = array('lelong' => 764, 'store' => 180657);//247-VOSTRO
            $category_mappings['248'] = array('lelong' => 764, 'store' => 180657);//248-INSPIRON
            $category_mappings['249'] = array('lelong' => 764, 'store' => 180657);//249-ALIENWARE
            $category_mappings['250'] = array('lelong' => 764, 'store' => 180657);//250-XPS
            $category_mappings['251'] = array('lelong' => 764, 'store' => 180657);//251-Laptop & Notebook
            $category_mappings['252'] = array('lelong' => 764, 'store' => 199245);//252-Desktop & All in one PC
            $category_mappings['253'] = array('lelong' => 764, 'store' => 180657);//253-VOSTRO
            $category_mappings['254'] = array('lelong' => 764, 'store' => 180657);//254-INSPIRON
            $category_mappings['255'] = array('lelong' => 764, 'store' => 180657);//255-ALIENWARE
            $category_mappings['256'] = array('lelong' => 764, 'store' => 180657);//256-XPS
            $category_mappings['257'] = array('lelong' => 1222, 'store' => 179503);//257-Memory (RAM)
            $category_mappings['258'] = array('lelong' => 649, 'store' => 179503);//258-Sound Card
            $category_mappings['260'] = array('lelong' => 1309, 'store' => 179503);//260-3.5" Internal Harddisk
            $category_mappings['261'] = array('lelong' => 296, 'store' => 179503);//261-Optical Drive
            $category_mappings['262'] = array('lelong' => 1254, 'store' => 179503);//262-Graphic Card
            $category_mappings['263'] = array('lelong' => 1008, 'store' => 199511);//263-Wireless Router
            $category_mappings['264'] = array('lelong' => 1008, 'store' => 199511);//264-Wireless AP/Ranger Extender/ Bridges
            $category_mappings['265'] = array('lelong' => 1007, 'store' => 199511);//265-Wired Networking
            $category_mappings['266'] = array('lelong' => 807, 'store' => 199511);//266-Modem Routers
            $category_mappings['267'] = array('lelong' => 300, 'store' => 199511);//267-3G/4G modem
            $category_mappings['268'] = array('lelong' => 1335, 'store' => 199511);//268-Security
            $category_mappings['269'] = array('lelong' => 1008, 'store' => 199511);//269-Switches
            $category_mappings['270'] = array('lelong' => 1008, 'store' => 199511);//270-KVM Switcher
            $category_mappings['271'] = array('lelong' => 1336, 'store' => 199511);//271-NAS / DAS
            $category_mappings['272'] = array('lelong' => 1335, 'store' => 199511);//272-Networking Accessories
            $category_mappings['273'] = array('lelong' => 667, 'store' => 199517);//273-System Protection
            $category_mappings['274'] = array('lelong' => 84, 'store' => 199517);//274-Operating System
            $category_mappings['275'] = array('lelong' => 83, 'store' => 199517);//275-Office Application
            $category_mappings['276'] = array('lelong' => 667, 'store' => 199517);//276-Antivirus & Internet Security
            $category_mappings['277'] = array('lelong' => 83, 'store' => 199517);//277-Graphic & Publishing
            $category_mappings['278'] = array('lelong' => 83, 'store' => 199517);//278-Others..
            $category_mappings['279'] = array('lelong' => 929, 'store' => 179501);//279-Monitor
            $category_mappings['280'] = array('lelong' => 507, 'store' => 179503);//280-Power Supply
            $category_mappings['281'] = array('lelong' => 553, 'store' => 179502);//281-AVR / UPS
            $category_mappings['283'] = array('lelong' => 377, 'store' => 179502);//283-Mouse
            $category_mappings['284'] = array('lelong' => 317, 'store' => 179524);//284-Logitech
            $category_mappings['285'] = array('lelong' => 377, 'store' => 179502);//285-Presenter
            $category_mappings['286'] = array('lelong' => 377, 'store' => 179502);//286-Logitech
            $category_mappings['287'] = array('lelong' => 303, 'store' => 179502);//287-Keyboard
            $category_mappings['288'] = array('lelong' => 303, 'store' => 179502);//288-Logitech
            $category_mappings['289'] = array('lelong' => 377, 'store' => 179502);//289-Speaker
            $category_mappings['290'] = array('lelong' => 699, 'store' => 155684);//290-Audio
            $category_mappings['292'] = array('lelong' => 1452, 'store' => 179513);//292-For Apple IPad
            $category_mappings['293'] = array('lelong' => 348, 'store' => 179502);//293-Webcam
            $category_mappings['294'] = array('lelong' => 377, 'store' => 179502);//294-Wired Mouse
            $category_mappings['295'] = array('lelong' => 377, 'store' => 179502);//295-Wireless Mouse
            $category_mappings['296'] = array('lelong' => 303, 'store' => 179502);//296-Keyboard only
            $category_mappings['297'] = array('lelong' => 303, 'store' => 179502);//297-Keyboard Combo With Mouse
            $category_mappings['298'] = array('lelong' => 699, 'store' => 155684);//298-earphones
            $category_mappings['299'] = array('lelong' => 377, 'store' => 179502);//299-Headset
            $category_mappings['307'] = array('lelong' => 345, 'store' => 179502);//307-Mouse
            $category_mappings['308'] = array('lelong' => 345, 'store' => 179502);//308-Keyboard
            $category_mappings['309'] = array('lelong' => 1427, 'store' => 155684);//309-Ultimate Ear (UE) Series
            $category_mappings['310'] = array('lelong' => 82, 'store' => 154728);//310-Gaming
            $category_mappings['311'] = array('lelong' => 317, 'store' => 179524);//311-Speaker
            $category_mappings['312'] = array('lelong' => 696, 'store' => 179502);//312-Tablet Accessories
            $category_mappings['313'] = array('lelong' => 348, 'store' => 179502);//313-Webcam
            $category_mappings['315'] = array('lelong' => 75, 'store' => 199245);//315-OEM / DIY PC
            $category_mappings['316'] = array('lelong' => 75, 'store' => 199245);//316-Branded PC
            $category_mappings['317'] = array('lelong' => 507, 'store' => 179503);//317-Cooler Master
            $category_mappings['318'] = array('lelong' => 548, 'store' => 179503);//318-Chassis
            $category_mappings['319'] = array('lelong' => 548, 'store' => 179503);//319-Cooler Master
            $category_mappings['320'] = array('lelong' => 75, 'store' => 199245);//320-All In One PC
            $category_mappings['321'] = array('lelong' => 770, 'store' => 179503);//321-AMD Compatible Motherboards
            $category_mappings['322'] = array('lelong' => 769, 'store' => 179503);//322-Intel Compatible Motherboards
            $category_mappings['323'] = array('lelong' => 771, 'store' => 179503);//323-Server / Workstation Motherboards
            $category_mappings['324'] = array('lelong' => 757, 'store' => 179503);//324-AMD Desktop CPU
            $category_mappings['325'] = array('lelong' => 757, 'store' => 179503);//325-Intel Desktop CPU
            $category_mappings['326'] = array('lelong' => 1309, 'store' => 179503);//326-500GB & Below
            $category_mappings['327'] = array('lelong' => 1309, 'store' => 179503);//327-1TB & below
            $category_mappings['328'] = array('lelong' => 1309, 'store' => 179503);//328-2TB & below
            $category_mappings['329'] = array('lelong' => 1219, 'store' => 179502);//329-Car FM Modulator
            $category_mappings['330'] = array('lelong' => 659, 'store' => 179502);//330-Card Reader / Bluetooth
            $category_mappings['331'] = array('lelong' => 1335, 'store' => 199511);//331-Wired Networking
            $category_mappings['332'] = array('lelong' => 58, 'store' => 179502);//332-USB Cable
            $category_mappings['334'] = array('lelong' => 1335, 'store' => 199511);//334-ADSL Modem + Router
            $category_mappings['335'] = array('lelong' => 1335, 'store' => 199511);//335-Wireless Adapter & Router
            $category_mappings['336'] = array('lelong' => 1335, 'store' => 199511);//336-Networking Switcher
            $category_mappings['337'] = array('lelong' => 1335, 'store' => 199511);//337-IP Camera
            $category_mappings['338'] = array('lelong' => 1336, 'store' => 199511);//338-NAS - Network Storage
            $category_mappings['339'] = array('lelong' => 1335, 'store' => 199511);//339-Home Plug / Print Server / POE
            $category_mappings['340'] = array('lelong' => 1335, 'store' => 199511);//340-KVM Switch
            $category_mappings['341'] = array('lelong' => 1335, 'store' => 199511);//341-Firewall / License
            $category_mappings['342'] = array('lelong' => 58, 'store' => 179502);//342-Other Computer Cable
            $category_mappings['343'] = array('lelong' => 317, 'store' => 179524);//343-Edifier
            $category_mappings['344'] = array('lelong' => 58, 'store' => 179502);//344-Network Cable
            $category_mappings['345'] = array('lelong' => 1315, 'store' => 179502);//345-External Harddisk
            $category_mappings['346'] = array('lelong' => 1315, 'store' => 179502);//346-Western Digital
            $category_mappings['348'] = array('lelong' => 423, 'store' => 179521);//348-Ink
            $category_mappings['349'] = array('lelong' => 421, 'store' => 179521);//349-HP
            $category_mappings['351'] = array('lelong' => 423, 'store' => 155030);//351-Toner
            $category_mappings['352'] = array('lelong' => 607, 'store' => 179521);//352-HP
            $category_mappings['354'] = array('lelong' => 1335, 'store' => 199511);//354-Wireless
            $category_mappings['355'] = array('lelong' => 1335, 'store' => 199511);//355-3G/4G Routers
            $category_mappings['356'] = array('lelong' => 1335, 'store' => 199511);//356-ADSL
            $category_mappings['357'] = array('lelong' => 1335, 'store' => 199511);//357-Switches
            $category_mappings['358'] = array('lelong' => 1335, 'store' => 199511);//358-Routers
            $category_mappings['359'] = array('lelong' => 1335, 'store' => 199511);//359-Powerline
            $category_mappings['360'] = array('lelong' => 1335, 'store' => 199511);//360-IP Cameras
            $category_mappings['361'] = array('lelong' => 1335, 'store' => 199511);//361-Print Servers
            $category_mappings['362'] = array('lelong' => 1335, 'store' => 199511);//362-Power over Ethernet
            $category_mappings['363'] = array('lelong' => 1335, 'store' => 199511);//363-Adapters & 56K Modem
            $category_mappings['364'] = array('lelong' => 1335, 'store' => 199511);//364-3G Modem
            $category_mappings['365'] = array('lelong' => 1335, 'store' => 199511);//365-IP Camera
            $category_mappings['366'] = array('lelong' => 1008, 'store' => 199511);//366-Routers
            $category_mappings['368'] = array('lelong' => 660, 'store' => 179502);//368-Enclosure
            $category_mappings['370'] = array('lelong' => 548, 'store' => 179503);//370-Raidmax
            $category_mappings['371'] = array('lelong' => 1335, 'store' => 199511);//371-Access point
            $category_mappings['372'] = array('lelong' => 765, 'store' => 179502);//372-Notebook Cooler Pad
            $category_mappings['373'] = array('lelong' => 377, 'store' => 179502);//373-USB Hub
            $category_mappings['374'] = array('lelong' => 377, 'store' => 179502);//374-Keyboard / Screen Protector
            $category_mappings['376'] = array('lelong' => 766, 'store' => 179502);//376-Notebook Sleeve
            $category_mappings['377'] = array('lelong' => 1315, 'store' => 179502);//377-Hard Disk Pouch
            $category_mappings['380'] = array('lelong' => 377, 'store' => 179502);//380-Tablet Drawing
            $category_mappings['381'] = array('lelong' => 507, 'store' => 179503);//381-Cooling
            $category_mappings['382'] = array('lelong' => 507, 'store' => 179503);//382-Cooler Master
            $category_mappings['383'] = array('lelong' => 1254, 'store' => 179503);//383-AMD series
            $category_mappings['384'] = array('lelong' => 1254, 'store' => 179503);//384-NViDIA series
            $category_mappings['385'] = array('lelong' => 649, 'store' => 179503);//385-Asus
            $category_mappings['386'] = array('lelong' => 1309, 'store' => 179503);//386-3TB & below
            $category_mappings['387'] = array('lelong' => 296, 'store' => 179503);//387-Asus
            $category_mappings['389'] = array('lelong' => 757, 'store' => 179503);//389-Processor
            $category_mappings['390'] = array('lelong' => 1487, 'store' => 179503);//390-Solid State Drive (SSD)
            $category_mappings['396'] = array('lelong' => 1487, 'store' => 179503);//396-Solid State Drive (SSD)
            $category_mappings['397'] = array('lelong' => 1487, 'store' => 179503);//397-Intel(SSD)
            $category_mappings['398'] = array('lelong' => 507, 'store' => 179503);//398-Huntkey
            $category_mappings['399'] = array('lelong' => 548, 'store' => 179503);//399-Huntkey
            $category_mappings['401'] = array('lelong' => 377, 'store' => 179502);//401-Media Player & TV BOX
            $category_mappings['402'] = array('lelong' => 695, 'store' => 179502);//402-Power Bank
            $category_mappings['403'] = array('lelong' => 695, 'store' => 179502);//403-Noontec
            $category_mappings['404'] = array('lelong' => 377, 'store' => 179502);//404-Noontec
            $category_mappings['408'] = array('lelong' => 765, 'store' => 179502);//408-Cooler Master
            $category_mappings['409'] = array('lelong' => 726, 'store' => 179503);//409-Hard Disk
            $category_mappings['410'] = array('lelong' => 391, 'store' => 179503);//410-RAM
            $category_mappings['411'] = array('lelong' => 295, 'store' => 179503);//411-Optical drive
            $category_mappings['414'] = array('lelong' => 764, 'store' => 180657);//414-Laptop & Notebook
            $category_mappings['415'] = array('lelong' => 1254, 'store' => 179503);//415-Graphic Card
            $category_mappings['417'] = array('lelong' => 1254, 'store' => 179503);//417-AMD series
            $category_mappings['418'] = array('lelong' => 1254, 'store' => 179503);//418-NVIDIA series
            $category_mappings['420'] = array('lelong' => 764, 'store' => 180657);//420-Laptop/Notebook
            $category_mappings['421'] = array('lelong' => 716, 'store' => 179512);//421-Smartphone
            $category_mappings['422'] = array('lelong' => 764, 'store' => 180657);//422-VAIO Fit 14E/15E
            $category_mappings['423'] = array('lelong' => 764, 'store' => 180657);//423-VAIO Fit 14/15
            $category_mappings['424'] = array('lelong' => 764, 'store' => 180657);//424-VAIO Duo 13
            $category_mappings['425'] = array('lelong' => 764, 'store' => 180657);//425-VAIO Duo 11
            $category_mappings['426'] = array('lelong' => 764, 'store' => 180657);//426-S Series
            $category_mappings['427'] = array('lelong' => 764, 'store' => 180657);//427-T Series
            $category_mappings['428'] = array('lelong' => 764, 'store' => 180657);//428-VAIO Pro 11/13
            $category_mappings['430'] = array('lelong' => 764, 'store' => 180657);//430-Sony
            $category_mappings['431'] = array('lelong' => 764, 'store' => 180657);//431- VAIO Fit 14E/15E
            $category_mappings['432'] = array('lelong' => 764, 'store' => 180657);//432-VAIO Fit 14/15
            $category_mappings['433'] = array('lelong' => 764, 'store' => 180657);//433-VAIO Duo 13
            $category_mappings['434'] = array('lelong' => 764, 'store' => 180657);//434-VAIO Duo 11
            $category_mappings['435'] = array('lelong' => 764, 'store' => 180657);//435-S Series
            $category_mappings['436'] = array('lelong' => 764, 'store' => 180657);//436-T Series
            $category_mappings['437'] = array('lelong' => 764, 'store' => 180657);//437-VAIO Pro 11/13
            $category_mappings['438'] = array('lelong' => 607, 'store' => 179521);//438-Canon
            $category_mappings['439'] = array('lelong' => 1307, 'store' => 179503);//439-Internal Harddisk
            $category_mappings['442'] = array('lelong' => 345, 'store' => 179509);//442-Mouse&Mice
            $category_mappings['443'] = array('lelong' => 345, 'store' => 179515);//443-Keyboard
            $category_mappings['444'] = array('lelong' => 1431, 'store' => 179502);//444-Audio
            $category_mappings['445'] = array('lelong' => 345, 'store' => 160260);//445-Controller
            $category_mappings['446'] = array('lelong' => 345, 'store' => 179514);//446-Gaming Accessories
            $category_mappings['447'] = array('lelong' => 477, 'store' => 179517);//447-Gaming Mouse Pads
            $category_mappings['448'] = array('lelong' => 1431, 'store' => 179508);//448-SteelSeries
            $category_mappings['449'] = array('lelong' => 1431, 'store' => 179509);//449-Razer
            $category_mappings['450'] = array('lelong' => 345, 'store' => 179508);//450-SteelSeries
            $category_mappings['451'] = array('lelong' => 345, 'store' => 179509);//451-Razer
            $category_mappings['452'] = array('lelong' => 345, 'store' => 179508);//452-Razer
            $category_mappings['453'] = array('lelong' => 345, 'store' => 179509);//453-Razer
            $category_mappings['454'] = array('lelong' => 477, 'store' => 179509);//454-Razer
            $category_mappings['457'] = array('lelong' => 377, 'store' => 179502);//457-HDMI
            $category_mappings['458'] = array('lelong' => 377, 'store' => 179502);//458-HDMI Splitter
            $category_mappings['459'] = array('lelong' => 377, 'store' => 179502);//459-HDMI Matrix
            $category_mappings['460'] = array('lelong' => 377, 'store' => 179502);//460-HDMI Extender
            $category_mappings['461'] = array('lelong' => 377, 'store' => 179502);//461-HDMI Switch
            $category_mappings['462'] = array('lelong' => 423, 'store' => 155030);//462-HDMI Converter
            $category_mappings['463'] = array('lelong' => 1412, 'store' => 179502);//463-AV converter
            $category_mappings['464'] = array('lelong' => 377, 'store' => 179502);//464-VGA
            $category_mappings['465'] = array('lelong' => 377, 'store' => 179502);//465-VGA Extender
            $category_mappings['466'] = array('lelong' => 377, 'store' => 179502);//466-VGA splitter
            $category_mappings['467'] = array('lelong' => 377, 'store' => 179502);//467-VGA Matrix
            $category_mappings['468'] = array('lelong' => 423, 'store' => 155030);//468-KVM Extender
            $category_mappings['469'] = array('lelong' => 423, 'store' => 155030);//469-USB Extender
            $category_mappings['471'] = array('lelong' => 59, 'store' => 179503);//471-PCI Card
            $category_mappings['472'] = array('lelong' => 377, 'store' => 179502);//472-Converters
            $category_mappings['473'] = array('lelong' => 377, 'store' => 179502);//473-Display Port to HDMI
            $category_mappings['474'] = array('lelong' => 377, 'store' => 179502);//474-Avermedia
            $category_mappings['475'] = array('lelong' => 377, 'store' => 179502);//475-Tv Tuner
            $category_mappings['476'] = array('lelong' => 377, 'store' => 179502);//476-Capture Card&Box
            $category_mappings['477'] = array('lelong' => 377, 'store' => 179502);//477-Accessories
            $category_mappings['478'] = array('lelong' => 59, 'store' => 179503);//478-PCI Express Card
            $category_mappings['479'] = array('lelong' => 59, 'store' => 179503);//479-Express Card
            $category_mappings['480'] = array('lelong' => 59, 'store' => 179503);//480-PCMCIA CardBus
            $category_mappings['481'] = array('lelong' => 1335, 'store' => 199511);//481-Printer Server
            $category_mappings['482'] = array('lelong' => 1222, 'store' => 179503);//482-Corsair
            $category_mappings['483'] = array('lelong' => 1487, 'store' => 179503);//483-Corsair(SSD)
            $category_mappings['484'] = array('lelong' => 648, 'store' => 181190);//484-Digital Voice Recorders
            $category_mappings['485'] = array('lelong' => 1331, 'store' => 179502);//485-MP3/ MP4 & Recorder
            $category_mappings['486'] = array('lelong' => 1331, 'store' => 179502);//486-SONY
            $category_mappings['490'] = array('lelong' => 377, 'store' => 179502);//490-External Storage
            $category_mappings['491'] = array('lelong' => 377, 'store' => 179503);//491-Internal Storage
            $category_mappings['492'] = array('lelong' => 1335, 'store' => 199511);//492-Cloud Storage
            $category_mappings['493'] = array('lelong' => 377, 'store' => 179502);//493-Home Entertainment
            $category_mappings['494'] = array('lelong' => 1312, 'store' => 179502);//494-Desktop Drives
            $category_mappings['495'] = array('lelong' => 1312, 'store' => 179502);//495-Desktop Drives for Mac
            $category_mappings['496'] = array('lelong' => 1312, 'store' => 179502);//496-Portable Drives
            $category_mappings['497'] = array('lelong' => 1312, 'store' => 179502);//497-Portable Drives for Mac
            $category_mappings['498'] = array('lelong' => 1312, 'store' => 179502);//498-Personal Cloud Storage
            $category_mappings['499'] = array('lelong' => 1312, 'store' => 179502);//499-Storage for Tablets
            $category_mappings['500'] = array('lelong' => 1312, 'store' => 179502);//500-Desktop/ Workstation
            $category_mappings['501'] = array('lelong' => 1312, 'store' => 179502);//501-Mobile
            $category_mappings['502'] = array('lelong' => 1312, 'store' => 179502);//502-NAS
            $category_mappings['503'] = array('lelong' => 1312, 'store' => 179502);//503-Datacenter
            $category_mappings['504'] = array('lelong' => 1312, 'store' => 179502);//504-Audio/ Video
            $category_mappings['506'] = array('lelong' => 1312, 'store' => 179502);//506-Solid State Storage (SSD)
            $category_mappings['512'] = array('lelong' => 1315, 'store' => 199511);//512-Personal Cloud Storage
            $category_mappings['513'] = array('lelong' => 1315, 'store' => 199511);//513-WD TV Media Players
            $category_mappings['514'] = array('lelong' => 1315, 'store' => 199511);//514-Multimedia Drives
            $category_mappings['515'] = array('lelong' => 1315, 'store' => 199511);//515-DVR Expander
            $category_mappings['519'] = array('lelong' => 485, 'store' => 179503);//519-CPU Air Cooler
            $category_mappings['520'] = array('lelong' => 485, 'store' => 179503);//520-CPU Liquid Cooler
            $category_mappings['521'] = array('lelong' => 485, 'store' => 179503);//521-OEM Cooler
            $category_mappings['522'] = array('lelong' => 485, 'store' => 179503);//522-Case Fan
            $category_mappings['523'] = array('lelong' => 485, 'store' => 179503);//523-Thermal Compound
            $category_mappings['524'] = array('lelong' => 485, 'store' => 179503);//524-Accessories
            $category_mappings['526'] = array('lelong' => 1335, 'store' => 199511);//526-Powerline
            $category_mappings['528'] = array('lelong' => 764, 'store' => 180657);//528-HP 1000
            $category_mappings['529'] = array('lelong' => 764, 'store' => 180657);//529-HP Pavilion
            $category_mappings['530'] = array('lelong' => 764, 'store' => 180657);//530-HP 1000
            $category_mappings['531'] = array('lelong' => 764, 'store' => 180657);//531-HP Pavilion
            $category_mappings['532'] = array('lelong' => 764, 'store' => 180657);//532-HP ENVY
            $category_mappings['533'] = array('lelong' => 764, 'store' => 180657);//533-HP Spectre
            $category_mappings['534'] = array('lelong' => 764, 'store' => 180657);//534-HP Slatebook
            $category_mappings['535'] = array('lelong' => 764, 'store' => 180657);//535-HP ENVY
            $category_mappings['536'] = array('lelong' => 764, 'store' => 180657);//536-HP Spectre
            $category_mappings['537'] = array('lelong' => 764, 'store' => 180657);//537-HP Slatebook
            $category_mappings['538'] = array('lelong' => 423, 'store' => 155030);//538-Canon
            $category_mappings['539'] = array('lelong' => 787, 'store' => 155030);//539-All In One Printer
            $category_mappings['540'] = array('lelong' => 423, 'store' => 155030);//540-Single Function Printer
            $category_mappings['541'] = array('lelong' => 1303, 'store' => 155030);//541-FAX
            $category_mappings['542'] = array('lelong' => 418, 'store' => 155030);//542-ImageClass Laser AIO Printer
            $category_mappings['543'] = array('lelong' => 418, 'store' => 155030);//543-Laser Printer
            $category_mappings['544'] = array('lelong' => 303, 'store' => 179502);//544-Bluetooth & wireless keyboard
            $category_mappings['547'] = array('lelong' => 57, 'store' => 179502);//547-Apple Notebook Adapter
            $category_mappings['550'] = array('lelong' => 667, 'store' => 199517);//550-Microsoft Software
            $category_mappings['552'] = array('lelong' => 1442, 'store' => 179512);//552-Microsoft Surface
            $category_mappings['553'] = array('lelong' => 1452, 'store' => 179513);//553-For Microsoft Surface
            $category_mappings['554'] = array('lelong' => 1181, 'store' => 179512);//554-Asus
            $category_mappings['555'] = array('lelong' => 1345, 'store' => 179512);//555-Acer
            $category_mappings['556'] = array('lelong' => 716, 'store' => 179512);//556-Microsoft Surface
            $category_mappings['559'] = array('lelong' => 766, 'store' => 179502);//559-Notebook / Table Bag & Casing
            $category_mappings['560'] = array('lelong' => 317, 'store' => 179524);//560-Other Speaker
            $category_mappings['561'] = array('lelong' => 735, 'store' => 181190);//561-GPS Store
            $category_mappings['562'] = array('lelong' => 765, 'store' => 179502);//562- Tablet & Notebook accessories
            $category_mappings['563'] = array('lelong' => 1331, 'store' => 179502);//563-Apple
            $category_mappings['564'] = array('lelong' => 764, 'store' => 180657);//564-Notebook
            $category_mappings['565'] = array('lelong' => 716, 'store' => 179512);//565-Tablet
            $category_mappings['566'] = array('lelong' => 377, 'store' => 179502);//566-AC RYAN
            $category_mappings['568'] = array('lelong' => 423, 'store' => 155030);//568-Printer
            $category_mappings['569'] = array('lelong' => 729, 'store' => 179502);//569-Bluetooth Adapter
            $category_mappings['571'] = array('lelong' => 302, 'store' => 179502);//571-Mouse & Keyboard
            $category_mappings['572'] = array('lelong' => 766, 'store' => 179502);//572-Notebook Bag
            $category_mappings['573'] = array('lelong' => 343, 'store' => 179514);//573-Joystick
            $category_mappings['575'] = array('lelong' => 317, 'store' => 179524);//575-Altec Lansing
            $category_mappings['576'] = array('lelong' => 1181, 'store' => 179512);//576-Memo Pad
            $category_mappings['577'] = array('lelong' => 648, 'store' => 181190);//577-Portable Audio
            $category_mappings['578'] = array('lelong' => 648, 'store' => 181190);//578-Headphones
            $category_mappings['579'] = array('lelong' => 648, 'store' => 181190);//579-WalkmanÆ MP3 players/video players
            $category_mappings['580'] = array('lelong' => 377, 'store' => 181174);//580-Cintiq Series
            $category_mappings['581'] = array('lelong' => 377, 'store' => 181174);//581-Bamboo Series
            $category_mappings['582'] = array('lelong' => 377, 'store' => 181174);//582-Intuos Series
            $category_mappings['583'] = array('lelong' => 377, 'store' => 181174);//583-Stylus Pen
            $category_mappings['584'] = array('lelong' => 377, 'store' => 181174);//584-Accessories
            $category_mappings['589'] = array('lelong' => 377, 'store' => 181174);//589-Interactive Series
            $category_mappings['592'] = array('lelong' => 317, 'store' => 179524);//592-Sonic Gear
            $category_mappings['594'] = array('lelong' => 317, 'store' => 179524);//594-Speaker
            $category_mappings['595'] = array('lelong' => 317, 'store' => 179524);//595-Pouch
            $category_mappings['596'] = array('lelong' => 345, 'store' => 179516);//596-Steelseries
            $category_mappings['597'] = array('lelong' => 1335, 'store' => 199511);//597-Internet TV Hub
            $category_mappings['601'] = array('lelong' => 317, 'store' => 179524);//601-Accessories
            $category_mappings['602'] = array('lelong' => 317, 'store' => 179524);//602-Braven
            $category_mappings['604'] = array('lelong' => 317, 'store' => 179524);//604-Jawbone
            $category_mappings['605'] = array('lelong' => 317, 'store' => 179524);//605-Soundfreaq
            $category_mappings['606'] = array('lelong' => 1155, 'store' => 0);//606-C-Series
            $category_mappings['607'] = array('lelong' => 1155, 'store' => 0);//607-Cushion-Series
            $category_mappings['608'] = array('lelong' => 1155, 'store' => 0);//608-Modular-Series
            $category_mappings['609'] = array('lelong' => 1155, 'store' => 0);//609-AP- Series
            $category_mappings['610'] = array('lelong' => 1155, 'store' => 0);//610-AO-Series
            $category_mappings['611'] = array('lelong' => 317, 'store' => 179524);//611-Edifier
            $category_mappings['612'] = array('lelong' => 317, 'store' => 179524);//612-Speaker
            $category_mappings['613'] = array('lelong' => 699, 'store' => 155684);//613-Earphone
            $category_mappings['614'] = array('lelong' => 1431, 'store' => 155684);//614-Headset
            $category_mappings['615'] = array('lelong' => 423, 'store' => 155030);//615-HP
            $category_mappings['616'] = array('lelong' => 396, 'store' => 155030);//616-Scanner
            $category_mappings['617'] = array('lelong' => 418, 'store' => 155030);//617-Laser Printer
            $category_mappings['618'] = array('lelong' => 418, 'store' => 155030);//618-Laser Printer
            $category_mappings['619'] = array('lelong' => 787, 'store' => 155030);//619-All In One Printer
            $category_mappings['620'] = array('lelong' => 396, 'store' => 155030);//620-Scanner
            $category_mappings['621'] = array('lelong' => 787, 'store' => 155030);//621-All In One Printer
            $category_mappings['622'] = array('lelong' => 682, 'store' => 179502);//622-Mouse Pads & Mats
            $category_mappings['624'] = array('lelong' => 764, 'store' => 180657);//624-Laptop & Ultrabook
            $category_mappings['625'] = array('lelong' => 716, 'store' => 179512);//625-Tablets
            $category_mappings['626'] = array('lelong' => 716, 'store' => 179512);//626-Smartphone
            $category_mappings['627'] = array('lelong' => 764, 'store' => 199245);//627-Desktops & All-In-Ones
            $category_mappings['628'] = array('lelong' => 696, 'store' => 179513);//628-Accessories
            $category_mappings['629'] = array('lelong' => 1520, 'store' => 179512);//629-Lenovo
            $category_mappings['630'] = array('lelong' => 695, 'store' => 179502);//630-Gigabyte
            $category_mappings['631'] = array('lelong' => 1315, 'store' => 179502);//631-Buffalo
            $category_mappings['633'] = array('lelong' => 728, 'store' => 179502);//633-External DVD Drive
            $category_mappings['634'] = array('lelong' => 1487, 'store' => 179503);//634-Kingston(SSD)
            $category_mappings['635'] = array('lelong' => 1222, 'store' => 179503);//635-Kingston
            $category_mappings['636'] = array('lelong' => 1431, 'store' => 179502);//636-Logitech
            $category_mappings['637'] = array('lelong' => 1254, 'store' => 179503);//637-Sapphire
            $category_mappings['638'] = array('lelong' => 477, 'store' => 179508);//638-SteelSeries
            $category_mappings['639'] = array('lelong' => 1335, 'store' => 199511);//639-USB Adapter
            $category_mappings['640'] = array('lelong' => 423, 'store' => 155030);//640-Samsung
            $category_mappings['643'] = array('lelong' => 75, 'store' => 199245);//643-Custom Build PC
            $category_mappings['644'] = array('lelong' => 75, 'store' => 199245);//644-Everyday PCs
            $category_mappings['645'] = array('lelong' => 929, 'store' => 179501);//645-Monitor
            $category_mappings['646'] = array('lelong' => 165, 'store' => 154728);//646-Valve
            $category_mappings['647'] = array('lelong' => 696, 'store' => 179513);//647-Microsoft Accessories
            $category_mappings['649'] = array('lelong' => 165, 'store' => 154728);//649-Game
            $category_mappings['651'] = array('lelong' => 716, 'store' => 155670);//651-Tablets
            $category_mappings['652'] = array('lelong' => 1497, 'store' => 179512);//652-Huawei
            $category_mappings['653'] = array('lelong' => 1431, 'store' => 179507);//653-Sennheiser / Adidas Originals        
            $category_mappings['654'] = array('lelong' => 1431, 'store' => 179507);//654-Audiophile Sound
            $category_mappings['655'] = array('lelong' => 1431, 'store' => 179507);//655-Home Entertainment
            $category_mappings['656'] = array('lelong' => 1431, 'store' => 179507);//656-Portable Entertainment
            $category_mappings['657'] = array('lelong' => 1431, 'store' => 179507);//657-Professional
            $category_mappings['658'] = array('lelong' => 1431, 'store' => 179507);//658-Sennheiser / Adidas Originals
            $category_mappings['659'] = array('lelong' => 1431, 'store' => 179507);//659-PC Headsets
            $category_mappings['660'] = array('lelong' => 1431, 'store' => 179507);//660-Gaming Headsets
            $category_mappings['666'] = array('lelong' => 696, 'store' => 179513);//666-Accessories
            $category_mappings['668'] = array('lelong' => 399, 'store' => 160260);//668-Projector
            $category_mappings['669'] = array('lelong' => 399, 'store' => 160260);//669-Projector
            $category_mappings['670'] = array('lelong' => 423, 'store' => 155030);//670-Printer
            $category_mappings['671'] = array('lelong' => 399, 'store' => 160260);//671-Projector
            $category_mappings['672'] = array('lelong' => 399, 'store' => 160260);//672-Projector
            $category_mappings['676'] = array('lelong' => 399, 'store' => 160260);//676-Projector
            $category_mappings['678'] = array('lelong' => 929, 'store' => 179501);//678-Monitor
            $category_mappings['680'] = array('lelong' => 165, 'store' => 154728);//680-Dota 2
            $category_mappings['681'] = array('lelong' => 165, 'store' => 154728);//681-Counter-Strike
            $category_mappings['682'] = array('lelong' => 165, 'store' => 154728);//682-Half-Life 2
            $category_mappings['683'] = array('lelong' => 82, 'store' => 179514);//683-Left 4 Dead
            $category_mappings['684'] = array('lelong' => 165, 'store' => 154728);//684-Portal
            $category_mappings['685'] = array('lelong' => 165, 'store' => 154728);//685-Portal 2
            $category_mappings['686'] = array('lelong' => 165, 'store' => 154728);//686-Team Fortress 2
            $category_mappings['688'] = array('lelong' => 423, 'store' => 155030);//688-Printer
            $category_mappings['690'] = array('lelong' => 399, 'store' => 160260);//690-Projector Accessories
            $category_mappings['691'] = array('lelong' => 566, 'store' => 179502);//691-Flash Drive (Pendirve)
            $category_mappings['692'] = array('lelong' => 695, 'store' => 179502);//692-Jumbox
            $category_mappings['693'] = array('lelong' => 695, 'store' => 179502);//693-iBank
            $category_mappings['694'] = array('lelong' => 695, 'store' => 179502);//694-Incito Dtech
            $category_mappings['695'] = array('lelong' => 695, 'store' => 179502);//695-Tech Titan
            $category_mappings['697'] = array('lelong' => 345, 'store' => 179508);//697-SteelSeries
            $category_mappings['698'] = array('lelong' => 377, 'store' => 179502);//698-Controller
            $category_mappings['699'] = array('lelong' => 317, 'store' => 179524);//699-Speaker
            $category_mappings['702'] = array('lelong' => 165, 'store' => 154728);//702-Left 4 Dead 2
            $category_mappings['703'] = array('lelong' => 345, 'store' => 160260);//703-Logitech
            $category_mappings['704'] = array('lelong' => 345, 'store' => 179502);//704-Controller
            $category_mappings['705'] = array('lelong' => 699, 'store' => 155684);//705-Headset & Earphone
            $category_mappings['706'] = array('lelong' => 345, 'store' => 179502);//706-Presenter
            $category_mappings['708'] = array('lelong' => 345, 'store' => 179516);//708-Logitech
            $category_mappings['709'] = array('lelong' => 345, 'store' => 179515);//709-Logitech
            $category_mappings['710'] = array('lelong' => 1431, 'store' => 179507);//710-Sennheiser
            $category_mappings['711'] = array('lelong' => 345, 'store' => 179515);//711-CM Storm
            $category_mappings['712'] = array('lelong' => 1431, 'store' => 179502);//712-CM Storm
            $category_mappings['713'] = array('lelong' => 345, 'store' => 179516);//713-CM Storm
            $category_mappings['714'] = array('lelong' => 345, 'store' => 179516);//714-Bloody
            $category_mappings['715'] = array('lelong' => 399, 'store' => 160260);//715-Acer
            $category_mappings['716'] = array('lelong' => 399, 'store' => 160260);//716-Epson
            $category_mappings['717'] = array('lelong' => 345, 'store' => 179516);//717-Roccat
            $category_mappings['718'] = array('lelong' => 345, 'store' => 179515);//718-Roccat
            $category_mappings['719'] = array('lelong' => 1431, 'store' => 179502);//719-Roccat
            $category_mappings['720'] = array('lelong' => 477, 'store' => 179517);//720-Roccat
            $category_mappings['721'] = array('lelong' => 399, 'store' => 160260);//721-BenQ
            $category_mappings['722'] = array('lelong' => 399, 'store' => 160260);//722-ViewSonic
            $category_mappings['723'] = array('lelong' => 399, 'store' => 160260);//723-Infocus
            $category_mappings['724'] = array('lelong' => 399, 'store' => 160260);//724-Panasonic
            $category_mappings['726'] = array('lelong' => 165, 'store' => 154728);//726-Steam Wallet
            $category_mappings['727'] = array('lelong' => 1315, 'store' => 199511);//727-My Cloud
            $category_mappings['728'] = array('lelong' => 421, 'store' => 179521);//728-Canon
            $category_mappings['729'] = array('lelong' => 423, 'store' => 155030);//729-Printer Ink
            $category_mappings['730'] = array('lelong' => 345, 'store' => 179516);//730-i-Rocks
            $category_mappings['731'] = array('lelong' => 345, 'store' => 179515);//731-i-Rocks
            $category_mappings['732'] = array('lelong' => 1431, 'store' => 179502);//732-i-Rocks
            $category_mappings['733'] = array('lelong' => 377, 'store' => 179502);//733-i-Rocks
            $category_mappings['734'] = array('lelong' => 1307, 'store' => 179503);//734-2.5" Internal Harddisk
            $category_mappings['735'] = array('lelong' => 1307, 'store' => 179503);//735-450GB & below
            $category_mappings['736'] = array('lelong' => 1307, 'store' => 179503);//736-500GB & Above
            $category_mappings['737'] = array('lelong' => 62, 'store' => 179503);//737-Western Digital
            $category_mappings['738'] = array('lelong' => 1177, 'store' => 154728);//738-Figures
            $category_mappings['740'] = array('lelong' => 1431, 'store' => 179502);//740-Astro
            $category_mappings['741'] = array('lelong' => 399, 'store' => 160260);//741-NEC
            $category_mappings['743'] = array('lelong' => 1427, 'store' => 155684);//743-Headphones
            $category_mappings['744'] = array('lelong' => 699, 'store' => 155684);//744-Earphones
            $category_mappings['745'] = array('lelong' => 317, 'store' => 179524);//745-Speakers
            $category_mappings['753'] = array('lelong' => 764, 'store' => 180657);//753-G Series
            $category_mappings['754'] = array('lelong' => 764, 'store' => 180657);//754-S Series
            $category_mappings['755'] = array('lelong' => 764, 'store' => 180657);//755-U Series
            $category_mappings['756'] = array('lelong' => 764, 'store' => 180657);//756-Y Series
            $category_mappings['757'] = array('lelong' => 764, 'store' => 180657);//757-Y Series
            $category_mappings['758'] = array('lelong' => 764, 'store' => 180657);//758-Laptop
            $category_mappings['760'] = array('lelong' => 764, 'store' => 180657);//760-Asus
            $category_mappings['761'] = array('lelong' => 764, 'store' => 180657);//761-Dell
            $category_mappings['762'] = array('lelong' => 764, 'store' => 180657);//762-HP
            $category_mappings['763'] = array('lelong' => 764, 'store' => 180657);//763-Lenovo
            $category_mappings['766'] = array('lelong' => 764, 'store' => 180657);//766-ThinkPad
            $category_mappings['767'] = array('lelong' => 764, 'store' => 180657);//767-IdeaPad
            $category_mappings['768'] = array('lelong' => 764, 'store' => 180657);//768-G Series
            $category_mappings['769'] = array('lelong' => 764, 'store' => 180657);//769-Flex Series
            $category_mappings['770'] = array('lelong' => 764, 'store' => 180657);//770-S Series
            $category_mappings['771'] = array('lelong' => 764, 'store' => 180657);//771-U Series
            $category_mappings['772'] = array('lelong' => 764, 'store' => 180657);//772-Y Series
            $category_mappings['773'] = array('lelong' => 764, 'store' => 180657);//773-Yoga Series
            $category_mappings['774'] = array('lelong' => 764, 'store' => 180657);//774-Z Series
            $category_mappings['775'] = array('lelong' => 764, 'store' => 180657);//775-A Series
            $category_mappings['776'] = array('lelong' => 764, 'store' => 180657);//776-X Series
            $category_mappings['777'] = array('lelong' => 764, 'store' => 180657);//777-K Series
            $category_mappings['778'] = array('lelong' => 764, 'store' => 180657);//778-S Series
            $category_mappings['779'] = array('lelong' => 764, 'store' => 180657);//779-N Series
            $category_mappings['780'] = array('lelong' => 764, 'store' => 180657);//780-Zenbook
            $category_mappings['781'] = array('lelong' => 764, 'store' => 180657);//781-Pro Series
            $category_mappings['782'] = array('lelong' => 764, 'store' => 180657);//782-ROG Gaming
            $category_mappings['783'] = array('lelong' => 764, 'store' => 180657);//783-Transformer Book
            $category_mappings['784'] = array('lelong' => 764, 'store' => 180657);//784-Aspire E1
            $category_mappings['785'] = array('lelong' => 764, 'store' => 180657);//785-Aspire V5
            $category_mappings['786'] = array('lelong' => 764, 'store' => 180657);//786-Aspire V7
            $category_mappings['787'] = array('lelong' => 764, 'store' => 180657);//787-Aspire R7
            $category_mappings['788'] = array('lelong' => 764, 'store' => 180657);//788-Aspire S7 Ultrabook
            $category_mappings['789'] = array('lelong' => 764, 'store' => 180657);//789-Vostro Series
            $category_mappings['790'] = array('lelong' => 764, 'store' => 180657);//790-Inspiron
            $category_mappings['791'] = array('lelong' => 764, 'store' => 180657);//791-XPS Series
            $category_mappings['792'] = array('lelong' => 764, 'store' => 180657);//792-Amd Series
            $category_mappings['793'] = array('lelong' => 764, 'store' => 180657);//793-Intel Celeron
            $category_mappings['794'] = array('lelong' => 764, 'store' => 180657);//794-Intel Pentium
            $category_mappings['795'] = array('lelong' => 764, 'store' => 180657);//795-Intel Core i3
            $category_mappings['796'] = array('lelong' => 764, 'store' => 180657);//796-Intel Core i5
            $category_mappings['797'] = array('lelong' => 764, 'store' => 180657);//797-Intel Core i7
            $category_mappings['798'] = array('lelong' => 764, 'store' => 180657);//798-AMD Processor
            $category_mappings['799'] = array('lelong' => 764, 'store' => 180657);//799-Intel Celeron
            $category_mappings['800'] = array('lelong' => 764, 'store' => 180657);//800-Intel Pentium
            $category_mappings['801'] = array('lelong' => 764, 'store' => 180657);//801-Intel Core i3
            $category_mappings['802'] = array('lelong' => 764, 'store' => 180657);//802-Intel Core i5
            $category_mappings['803'] = array('lelong' => 764, 'store' => 180657);//803-Intel Core i7
            $category_mappings['804'] = array('lelong' => 764, 'store' => 180657);//804-Price Below RM1099
            $category_mappings['805'] = array('lelong' => 929, 'store' => 179501);//805-Acer
            $category_mappings['806'] = array('lelong' => 929, 'store' => 179501);//806-Asus
            $category_mappings['807'] = array('lelong' => 929, 'store' => 179501);//807-Dell
            $category_mappings['808'] = array('lelong' => 929, 'store' => 179501);//808-HP
            $category_mappings['809'] = array('lelong' => 929, 'store' => 179501);//809-LG
            $category_mappings['810'] = array('lelong' => 929, 'store' => 179501);//810-Below 20'
            $category_mappings['811'] = array('lelong' => 929, 'store' => 179501);//811-21.5' - 24'
            $category_mappings['812'] = array('lelong' => 929, 'store' => 179501);//812-25' - 27'
            $category_mappings['813'] = array('lelong' => 75, 'store' => 199245);//813-Acer
            $category_mappings['814'] = array('lelong' => 75, 'store' => 199245);//814-Asus
            $category_mappings['815'] = array('lelong' => 75, 'store' => 199245);//815-Dell
            $category_mappings['816'] = array('lelong' => 75, 'store' => 199245);//816-HP
            $category_mappings['817'] = array('lelong' => 75, 'store' => 199245);//817-Lenovo
            $category_mappings['818'] = array('lelong' => 75, 'store' => 199245);//818-Amd Processor
            $category_mappings['819'] = array('lelong' => 75, 'store' => 199245);//819-Intel Celeron
            $category_mappings['820'] = array('lelong' => 75, 'store' => 199245);//820-Intel Pentium
            $category_mappings['821'] = array('lelong' => 75, 'store' => 199245);//821-Intel Core i3
            $category_mappings['822'] = array('lelong' => 75, 'store' => 199245);//822-Intel Core i5
            $category_mappings['823'] = array('lelong' => 75, 'store' => 199245);//823-Intel Core i7
            $category_mappings['826'] = array('lelong' => 399, 'store' => 160260);//826-Optoma
            $category_mappings['827'] = array('lelong' => 399, 'store' => 160260);//827-Full HD Projector
            $category_mappings['828'] = array('lelong' => 399, 'store' => 160260);//828-LED Projector
            $category_mappings['830'] = array('lelong' => 399, 'store' => 160260);//830-Projector Accessories
            $category_mappings['831'] = array('lelong' => 929, 'store' => 179501);//831-Philips
            $category_mappings['832'] = array('lelong' => 929, 'store' => 179501);//832-Samsung
            $category_mappings['834'] = array('lelong' => 401, 'store' => 173091);//834-Music
            $category_mappings['835'] = array('lelong' => 401, 'store' => 173091);//835-Ukulele
            $category_mappings['836'] = array('lelong' => 401, 'store' => 173091);//836-Makai
            $category_mappings['837'] = array('lelong' => 716, 'store' => 179512);//837-Mobile Phone
            $category_mappings['838'] = array('lelong' => 764, 'store' => 180657);//838-Intel Processor Notebook
            $category_mappings['839'] = array('lelong' => 764, 'store' => 180657);//839-AMD Processor Notebook
            $category_mappings['840'] = array('lelong' => 165, 'store' => 154728);//840-Gaming & Hobby
            $category_mappings['841'] = array('lelong' => 1177, 'store' => 154728);//841-Toys
            $category_mappings['842'] = array('lelong' => 764, 'store' => 180657);//842-ACER
            $category_mappings['843'] = array('lelong' => 764, 'store' => 180657);//843-ASUS
            $category_mappings['844'] = array('lelong' => 764, 'store' => 180657);//844-LENOVO
            $category_mappings['845'] = array('lelong' => 165, 'store' => 154728);//845-Games
            $category_mappings['846'] = array('lelong' => 165, 'store' => 154728);//846-Digital Codes
            $category_mappings['847'] = array('lelong' => 764, 'store' => 180657);//847-Intel Processor Laptop
            $category_mappings['848'] = array('lelong' => 764, 'store' => 180657);//848-Intel Processor Ultrabook
            $category_mappings['849'] = array('lelong' => 764, 'store' => 180657);//849-Intel Processor 2 IN 1 Notebook
            $category_mappings['850'] = array('lelong' => 75, 'store' => 199245);//850-Intel Processor Desktop PC
            $category_mappings['851'] = array('lelong' => 764, 'store' => 180657);//851-Intel Processor Chromebook
            $category_mappings['852'] = array('lelong' => 1369, 'store' => 179512);//852-Lenovo
            $category_mappings['853'] = array('lelong' => 764, 'store' => 180657);//853-Alienware
            $category_mappings['854'] = array('lelong' => 764, 'store' => 180657);//854-Aspire E5
            $category_mappings['859'] = array('lelong' => 1487, 'store' => 179503);//859-Solid State Drive (SSD)
            $category_mappings['860'] = array('lelong' => 1487, 'store' => 179503);//860-Samsung
            $category_mappings['863'] = array('lelong' => 165, 'store' => 154728);//863-Card Fight
            $category_mappings['864'] = array('lelong' => 165, 'store' => 154728);//864-Gundam
            $category_mappings['865'] = array('lelong' => 667, 'store' => 199517);//865-Bitdefender
            $category_mappings['866'] = array('lelong' => 77, 'store' => 199511);//866-Server & Workstation
            $category_mappings['867'] = array('lelong' => 77, 'store' => 199511);//867-Dell
            $category_mappings['868'] = array('lelong' => 77, 'store' => 199511);//868-HP
            $category_mappings['869'] = array('lelong' => 165, 'store' => 154728);//869-Blizzard
            $category_mappings['870'] = array('lelong' => 1336, 'store' => 199511);//870-Synology
            $category_mappings['871'] = array('lelong' => 1336, 'store' => 199511);//871-Asustor
            $category_mappings['872'] = array('lelong' => 1336, 'store' => 199511);//872-QNAP
            $category_mappings['873'] = array('lelong' => 423, 'store' => 155030);//873-Printer
            $category_mappings['874'] = array('lelong' => 423, 'store' => 155030);//874-Epson
            $category_mappings['875'] = array('lelong' => 722, 'store' => 179503);//875-Harddisk
            $category_mappings['876'] = array('lelong' => 399, 'store' => 160260);//876-Sony
            $category_mappings['884'] = array('lelong' => 1487, 'store' => 179503);//884-Adata SSD
            $category_mappings['889'] = array('lelong' => 1315, 'store' => 179502);//889-Seagate
            $category_mappings['890'] = array('lelong' => 165, 'store' => 154728);//890-Gundam
            $category_mappings['898'] = array('lelong' => 401, 'store' => 173091);//898-Hawaii
            $category_mappings['899'] = array('lelong' => 401, 'store' => 173091);//899-Puretone
            $category_mappings['900'] = array('lelong' => 283, 'store' => 173091);//900-Keyboard & Piano 
            $category_mappings['901'] = array('lelong' => 283, 'store' => 173091);//901-Casio
            $category_mappings['902'] = array('lelong' => 283, 'store' => 173091);//902-Puretone
            $category_mappings['904'] = array('lelong' => 770, 'store' => 179503);//904-AMD Socket
            $category_mappings['905'] = array('lelong' => 769, 'store' => 179503);//905-Intel Socket
            $category_mappings['906'] = array('lelong' => 282, 'store' => 173091);//906-Guitar & Electric Guitar
            $category_mappings['907'] = array('lelong' => 282, 'store' => 173091);//907-Accessories
            $category_mappings['908'] = array('lelong' => 764, 'store' => 180657);//908-12.12 Sales
            $category_mappings['909'] = array('lelong' => 165, 'store' => 154728);//909-Tower Of Savior 
            $category_mappings['910'] = array('lelong' => 764, 'store' => 180657);//910-Notebook
            $category_mappings['911'] = array('lelong' => 62, 'store' => 179503);//911-Harddisk
            $category_mappings['912'] = array('lelong' => 377, 'store' => 179502);//912-Accessories
            $category_mappings['914'] = array('lelong' => 716, 'store' => 155670);//914-Mobile & Tablet
            $category_mappings['915'] = array('lelong' => 764, 'store' => 180657);//915-HP

            
            $this->category = $category_mappings;
        }
        
    }
    
?>