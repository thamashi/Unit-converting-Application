

import UIKit

class speedViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var textMeter: UITextField!
    @IBOutlet weak var textKm: UITextField!
    @IBOutlet weak var textMile: UITextField!
    @IBOutlet weak var textnautical: UITextField!
    var arrSpeed = [String]()
    var savedArrSpeed = [String]()
    
    var keyBoardHeight:CGFloat = 0
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        textMeter.becomeFirstResponder()
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(speedViewController.appMovedToBackground), name: Notification.Name.UIApplicationWillResignActive, object: nil)
        
         self.textMeter.delegate = self
         self.textKm.delegate = self
         self.textMile.delegate = self
        self.textnautical.delegate = self
    
    }
    
     // tap any place to dismiss the keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
   
    
    //save user defaults
    @objc  func appMovedToBackground() {
        print("App moved to background!")
        let defaults = UserDefaults.standard
        defaults.set(textMeter.text, forKey: "meterValue")
        defaults.set(textKm.text, forKey: "kmValue")
        defaults.set(textMile.text, forKey: "mileValue")
        defaults.set(textnautical.text, forKey: "nauticalValue")
        defaults.synchronize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //put any saved text back
        let defaults = UserDefaults.standard
        let meterValue = defaults.string(forKey: "meterValue")
        let kmValue = defaults.string(forKey: "kmValue")
        let mileValue = defaults.string(forKey: "mileValue")
        let nauticalValue = defaults.string(forKey: "nauticalValue")
        textMeter.text = meterValue
        textKm.text = kmValue
        textMile.text = mileValue
        textnautical.text = nauticalValue
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    
    //Metre changed func
    @IBAction func meterChanged(_ sender: UITextField) {
        let meterValue = (self.textMeter.text! as NSString).floatValue
        let kmValue = meterValue*3.6
        let mileValue = meterValue*2.2369362920544
        let nauticalValue = meterValue*1.94384
        
        self.textKm.text = String(format: "%.4f",kmValue)
        self.textMile.text = String(format: "%.4f",mileValue)
        self.textnautical.text = String(format: "%.4f",nauticalValue)
    }
    
    //KmChanged func
    @IBAction func kmChanged(_ sender: UITextField) {
        let kmValue = (self.textKm.text! as NSString).floatValue
        let meterValue = kmValue*0.2777778
        let mileValue = kmValue*0.6213712
        let nauticalValue = kmValue*0.539957
       
        self.textMeter.text = String(format: "%.4f",meterValue)
        self.textMile.text = String(format: "%.4f",mileValue)
        self.textnautical.text = String(format: "%.4f",nauticalValue)
    }
    
    //milechanged func
    
    @IBAction func mileChanged(_ sender: UITextField) {
        let mileValue = (self.textMile.text! as NSString).floatValue
        let meterValue = mileValue*0.44704
        let kmValue = mileValue*1.609344
        let nauticalValue = mileValue*0.868976
      
        self.textMeter.text = String(format: "%.4f",meterValue)
        self.textKm.text = String(format: "%.4f",kmValue)
        self.textnautical.text = String(format: "%.4f",nauticalValue)
    }
    
    
    @IBAction func nauticalChanged(_ sender: Any) {
        let nauticalValue = (self.textnautical.text! as NSString).floatValue
        let meterValue = nauticalValue*0.44704
        let kmValue = nauticalValue*1.609344
        let milelValue = nauticalValue*0.868976
        
        self.textMeter.text = String(format: "%.4f",meterValue)
        self.textKm.text = String(format: "%.4f",kmValue)
        self.textMile.text = String(format: "%.4f",milelValue)
    }
    

    
    // save data in an array
    @IBAction func saveData(_ sender: Any) {
        
        if let savedArrSpeed = UserDefaults.standard.object(forKey: "recentSpeed") as? [String]{
            arrSpeed = savedArrSpeed
        }
        
        if (arrSpeed.count == 5){
            arrSpeed.remove(at: 0)
        }
        
        //Check if all textbox has the value "0"
        if(textMeter.text == "0"){
            textMeter.text = String("0.0000")
        }
        if(textKm.text == "0"){
            textKm.text = String("0.0000")
        }
        if(textMile.text == "0"){
            textMile.text = String("0.0000")
        }
        
        if(textnautical.text == "0"){
            textnautical.text = String("0.0000")
        }
        
        
        
        //validation to check if textbox has empty values
        if((textKm.text?.isEmpty)! || (textMeter.text?.isEmpty)! || (textMile.text?.isEmpty)! || (textnautical.text?.isEmpty)!) == false {
            if((textKm.text == "0.0000") && (textMeter.text == "0.0000") && (textMile.text == "0.0000") && (textnautical.text == "0.0000")) == false {
                
                //alert
                let userAlert = UIAlertController(title: "", message: "Conversion is saved", preferredStyle: UIAlertControllerStyle.alert)
                
                userAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                    
                }))
                
                present(userAlert, animated: true, completion: nil)
                
                //save data
                arrSpeed.append(textMeter.text! + " Meter =" + textKm.text! + " Kilo meter =" + textMile.text! + " Miles = " + textnautical.text!)
                let defaults = UserDefaults.standard
                defaults.set(arrSpeed, forKey: "recentSpeed")
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
