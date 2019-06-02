
import UIKit

class volumeViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var textM3: UITextField!
    @IBOutlet weak var textCm3: UITextField!
    @IBOutlet weak var textLiter: UITextField!
    @IBOutlet weak var cm3Label: UILabel!
    @IBOutlet weak var m3Label: UILabel!
    

    var arrvolume = [String]()
    var savedArrVolume = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textM3.becomeFirstResponder()
        
        
        // Do any additional setup after loading the view.
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(volumeViewController.appMovedToBackground), name: Notification.Name.UIApplicationWillResignActive, object: nil)
        
        //show certain characters in superscript
        let font:UIFont? = UIFont(name:"HelveticaNeue", size:17)
        let fontSuper:UIFont? = UIFont(name:"HelveticaNeue", size:10)
        
        let attString:NSMutableAttributedString = NSMutableAttributedString(string: "cm3", attributes: [.font:font!])
        attString.setAttributes([.font:fontSuper!,.baselineOffset:8], range: NSRange(location:2,length:1))
        cm3Label.attributedText = attString
        
        let atString:NSMutableAttributedString = NSMutableAttributedString(string: "m3", attributes: [.font:font!])
        atString.setAttributes([.font:fontSuper!,.baselineOffset:8], range: NSRange(location:1,length:1))
        m3Label.attributedText = atString
        
         self.textM3.delegate = self
         self.textCm3.delegate = self
         self.textLiter.delegate = self
        
    }
    // tap any place to dismiss the keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //save user defaults
    @objc  func appMovedToBackground() {
        print("App moved to background!")
        let defaults = UserDefaults.standard
        defaults.set(textM3.text, forKey: "m3Value")
        defaults.set(textCm3.text, forKey: "cm3Value")
        defaults.set(textLiter.text, forKey: "literValue")
        defaults.synchronize()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //put any saved text back
        let defaults = UserDefaults.standard
        let m3Value = defaults.string(forKey: "m3Value")
        let cm3Value = defaults.string(forKey: "cm3Value")
        let literValue = defaults.string(forKey: "literValue")
        textM3.text = m3Value
        textCm3.text = cm3Value
        textLiter.text = literValue
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}


    

    // m3 changed function
    @IBAction func m3Changed(_ sender: UITextField) {
        let m3Value = (self.textM3.text! as NSString).floatValue
        let cm3Value = m3Value * 1000000
        let literValue = m3Value*1000
        
        self.textCm3.text = String(format: "%.4f",cm3Value)
        self.textLiter.text = String(format: "%.4f",literValue)
    }
    
    
    // cm3 changed function
    @IBAction func cm3Changed(_ sender: UITextField) {
        let cm3Value = (self.textCm3.text! as NSString).floatValue
        let m3Value = cm3Value/1000000
        let literValue = cm3Value*0.001
       
        self.textM3.text = String(format: "%.4f",m3Value)
        self.textLiter.text = String(format: "%.4f",literValue)
        
    }
    
    // litre changed function
    @IBAction func literChanged(_ sender: UITextField) {
        let literValue = (self.textLiter.text! as NSString).floatValue
        let cm3Value = literValue*1000
        let m3Value = literValue*0.001
        self.textCm3.text = String(format: "%.4f",cm3Value)
        self.textM3.text = String(format: "%.4f",m3Value)
    }
    
    
     //save data to an array
    @IBAction func saveData(_ sender: Any) {
        if let savedArrVolume = UserDefaults.standard.object(forKey: "recentVolume") as? [String]{
            arrvolume = savedArrVolume
        }
        if (arrvolume.count == 5){
            arrvolume.remove(at: 0)
        }
        
        //Check if all textbox has the value "0"
        if(textM3.text == "0"){
            textM3.text = String("0.0000")
        }
        if(textCm3.text == "0"){
            textCm3.text = String("0.0000")
        }
        if(textLiter.text == "0"){
            textLiter.text = String("0.0000")
        }
        
        // output of saved data as history
        if ((textLiter.text?.isEmpty)! || (textM3.text?.isEmpty)! || (textCm3.text?.isEmpty)!) == false {
            if ((textLiter.text == "0.0000") && (textM3.text == "0.0000") && (textCm3.text == "0.0000")) == false {
                //alert
                let userAlert = UIAlertController(title: "", message: " Conversion is saved", preferredStyle: UIAlertControllerStyle.alert)
                
                userAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                    
                }))
                
                present(userAlert, animated: true, completion: nil)
                
                //save data
            arrvolume.append(textM3.text! + " ㎥ =" + textCm3.text! + " C㎥ =" + textLiter.text! + " Liter ")
            let defaults = UserDefaults.standard
            defaults.set(arrvolume, forKey: "recentVolume")
            
        }
            else {
                
                //alert message
                let userAlert = UIAlertController(title: "", message: "You Cannot save values with zeros", preferredStyle: UIAlertControllerStyle.alert)
                
                userAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                    
                }))
                
                present(userAlert, animated: true, completion: nil)
            }
        }
            
        else {
            
            //alert message
            let userAlert = UIAlertController(title: "", message: "You Cannot save empty values", preferredStyle: UIAlertControllerStyle.alert)
            
            userAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                
            }))
            
            present(userAlert, animated: true, completion: nil)
        }
    }
    
    
    //validation to check if a number in textbox has 2 decimal points
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        let arrayOfString = newString.components(separatedBy: ".")
        
        if arrayOfString.count > 2 {
            return false
        }
        return true
    }
    
}




