

import UIKit

class TemperatureController: UIViewController, UITextFieldDelegate {
    

   
    @IBOutlet weak var textCelcius: UITextField!
    @IBOutlet weak var textFahrenheit: UITextField!
    @IBOutlet weak var textKelvin: UITextField!
    
    
    var arrTemperature = [String]()
    var savedArrTemperature = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
    textCelcius.becomeFirstResponder()
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(TemperatureController.appMovedToBackground),
        name: Notification.Name.UIApplicationWillResignActive, object: nil)
        
        self.textCelcius.delegate = self
        self.textFahrenheit.delegate = self
        self.textKelvin.delegate = self
        
    }
     // tap any place to dismiss the keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
        //save user defaults
        @objc  func appMovedToBackground() {
            print("App moved to background!")
            let defaults = UserDefaults.standard
            defaults.set(textCelcius.text, forKey: "celciusValue")
            defaults.set(textFahrenheit.text, forKey: "farValue")
            defaults.set(textKelvin.text, forKey: "kelValue")
            defaults.synchronize()
    }
    override func viewWillAppear(_ animated: Bool) {
            //display any saved text
        let defaults = UserDefaults.standard
        let celValue = defaults.string(forKey: "celciusValue")
        let farValue = defaults.string(forKey: "farValue")
        let kelValue = defaults.string(forKey: "kelValue")
        textCelcius.text = celValue
        textFahrenheit.text = farValue
        textKelvin.text = kelValue
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //fahrenheit changed function
    @IBAction func fahrenheitChanged(_ sender: UITextField) {
        let farenValue = (self.textFahrenheit.text! as NSString).floatValue
        let centValue = farToCent(far: farenValue)
        let kelValue = centValue + 273.15
        
        self.textKelvin.text = String(format: "%.4f",kelValue)
        self.textCelcius.text = String(format: "%.4f",centValue)
    }
    
    //celcius changed function
    @IBAction func celciusChanged(_ sender: Any) {
        let centValue = (self.textCelcius.text! as NSString).floatValue
        let farenValue = centToFar(cent: centValue)
        let kelValue = centValue + 273.15
        
        self.textFahrenheit.text = String(format: "%.4f",farenValue)
        self.textKelvin.text = String(format: "%.4f",kelValue)

    }
    
    //kelvin changed function
    @IBAction func kelvinChanged(_ sender: UITextField) {
        let kelValue = (self.textKelvin.text! as NSString).floatValue
        let centValue = kelValue - 273.15
        let farenValue = centToFar(cent: centValue)
 
        self.textCelcius.text = String(format: "%.4f",centValue)
        self.textFahrenheit.text = String(format: "%.4f",farenValue)
    }
    
   // function Celcius to farh
    func centToFar (cent:Float)->Float{
        let far = cent*(9/5) + 32
        return far
    }
   
    //function farh to celcious
    func farToCent (far:Float)->Float{
        let cent = (far - 32)*(5/9)
        return cent
    }
    
    //save data to an array
    @IBAction func saveData(_ sender: Any) {
        
        if let savedArrTemperature = UserDefaults.standard.object(forKey: "recentTemperature") as? [String]{
            arrTemperature = savedArrTemperature
        }
        
        if (arrTemperature.count == 5){
            arrTemperature.remove(at: 0)
        }
        
        //Check if all textbox has the value "0"
        if(textCelcius.text == "0"){
            textCelcius.text = String("0.0000")
        }
        if(textFahrenheit.text == "0"){
            textFahrenheit.text = String("0.0000")
        }
        if(textKelvin.text == "0"){
            textKelvin.text = String("0.0000")
        }
        
         //validation to check if textbox has emptyvalues
        if ((textKelvin.text?.isEmpty)!||(textCelcius.text?.isEmpty)!||(textFahrenheit.text?.isEmpty)!) == false{
             if ((textKelvin.text == "0.0000") && (textCelcius.text == "0.0000") && (textFahrenheit.text == "0.0000")) == false{
                
                //alert
                let userAlert = UIAlertController(title: "", message: " Conversion is saved", preferredStyle: UIAlertControllerStyle.alert)
                
                userAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                    
                }))
                
                present(userAlert, animated: true, completion: nil)
                
                //save data
            arrTemperature.append(textCelcius.text! + " Celcius =" + textFahrenheit.text! + " Fahrenhiet =" + textKelvin.text! + " Kelvin ")
            let defaults = UserDefaults.standard
            defaults.set(arrTemperature, forKey: "recentTemperature")
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

    
        
    
    @IBAction func celciusMinus(_ sender: Any) {
        celciusChanged(textCelcius)
    }
    
    @IBAction func farenhiteMinus(_ sender: Any) {
        fahrenheitChanged(textFahrenheit)
    }
    
    @IBAction func kelvinMinus(_ sender: Any) {
        kelvinChanged(textKelvin)
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

