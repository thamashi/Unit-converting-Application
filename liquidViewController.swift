
import UIKit

class liquidViewController: UIViewController, UITextFieldDelegate  {
    @IBOutlet weak var textGallon: UITextField!
    @IBOutlet weak var textLiter: UITextField!
    @IBOutlet weak var textPint: UITextField!
    @IBOutlet weak var textOunce: UITextField!
    @IBOutlet weak var textMilileter: UITextField!
    
    var savedArrLiquid = [String]()
    var arrLiquid = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        textGallon.becomeFirstResponder()
        // Do any additional setup after loading the view.
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(liquidViewController.appMovedToBackground), name: Notification.Name.UIApplicationWillResignActive, object: nil)
        
        self.textGallon.delegate = self
        self.textLiter.delegate = self
        self.textPint.delegate = self
        self.textOunce.delegate = self
        self.textMilileter.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //save user defaults
    @objc  func appMovedToBackground() {
        print("App moved to background!")
        let defaults = UserDefaults.standard
        defaults.set(textGallon.text, forKey: "gallonValue")
        defaults.set(textLiter.text, forKey: "literValue")
        defaults.set(textPint.text, forKey: "pintValue")
        defaults.set(textOunce.text, forKey: "ounceValue")
        defaults.set(textMilileter.text, forKey: "milileter")
        defaults.synchronize()
    }
    override func viewWillAppear(_ animated: Bool) {
        //put any saved text back
        let defaults = UserDefaults.standard
        let gallonValue = defaults.string(forKey: "gallonValue")
        let literValue = defaults.string(forKey: "literValue")
        let pintValue = defaults.string(forKey: "pintValue")
        let ounceValue = defaults.string(forKey: "ounceValue")
        let milileter = defaults.string(forKey: "milileter")
        textGallon.text = gallonValue
        textLiter.text = literValue
        textPint.text = pintValue
        textOunce.text = ounceValue
        textMilileter.text = milileter
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //function gallon changed
    @IBAction func gallonChanged(_ sender: UITextField) {
        let gallonValue = (self.textGallon.text! as NSString).floatValue
        let literValue = gallonValue*4.54609
        let pintValue = gallonValue*8
        let ounceValue = gallonValue*160
        let milileterValue = gallonValue*3785.4
        
        self.textLiter.text = String(format: "%.4f",literValue)
        self.textPint.text = String(format: "%.4f",pintValue)
        self.textOunce.text = String(format: "%.4f",ounceValue)
        self.textMilileter.text = String(format: "%.4f",milileterValue)
    }
    
    
    //function litre changed
    @IBAction func litreChanged(_ sender: UITextField) {
        let literValue = (self.textLiter.text! as NSString).floatValue
        let gallonValue = literValue*0.21996924829909
        let pintValue = literValue*1.7597539863927
        let ounceValue = literValue*35.195079727854
        let milileterValue = literValue*1000
        
        self.textGallon.text = String(format: "%.4f",gallonValue)
        self.textPint.text = String(format: "%.4f",pintValue)
        self.textOunce.text = String(format: "%.4f",ounceValue)
        self.textMilileter.text = String(format: "%.4f",milileterValue)
    }
    
    
    //function pint changed
    @IBAction func pintChanged(_ sender: UITextField) {
        let pintValue = (self.textPint.text! as NSString).floatValue
        let literValue = pintValue/1.75975
        let gallonValue = pintValue*0.125
        let ounceValue = pintValue/0.05
        let milileterValue = pintValue*473.176
       
        self.textGallon.text = String(format: "%.4f",gallonValue)
        self.textLiter.text = String(format: "%.4f",literValue)
        self.textOunce.text = String(format: "%.4f",ounceValue)
        self.textMilileter.text = String(format: "%.4f",milileterValue)
    }
    
    
    //function ounce changed
    @IBAction func ounceChanged(_ sender: UITextField) {
        let ounceValue = (self.textOunce.text! as NSString).floatValue
        let literValue = ounceValue*0.0284130625
        let gallonValue = ounceValue*0.00625
        let pintValue = ounceValue*0.05
        let milileterValue = ounceValue*29.5735
       
        self.textGallon.text = String(format: "%.4f",gallonValue)
        self.textLiter.text = String(format: "%.4f",literValue)
        self.textPint.text = String(format: "%.4f",pintValue)
        self.textMilileter.text = String(format: "%.4f",milileterValue)
    }
    

    
    @IBAction func changedMilileter(_ sender: Any) {
        let milileterValue = (self.textMilileter.text! as NSString).floatValue
        let literValue = milileterValue*0.001
        let gallonValue = milileterValue*0.000264172
        let pintValue = milileterValue*0.00211338
        let oncevalue = milileterValue*0.033814
        
        self.textGallon.text = String(format: "%.4f",gallonValue)
        self.textLiter.text = String(format: "%.4f",literValue)
        self.textPint.text = String(format: "%.4f",pintValue)
        self.textOunce.text = String(format: "%.4f",oncevalue)
    }
    
    //save data to an array
    @IBAction func sendData(_ sender: Any) {
        if let savedArrLiquid = UserDefaults.standard.object(forKey: "recentLiquid") as? [String]{
            arrLiquid = savedArrLiquid
        }
        if (arrLiquid.count == 5){
            arrLiquid.remove(at: 0)
        }
    
        //Check if all textbox has the value "0"
        if(textGallon.text == "0"){
            textGallon.text = String("0.0000")
        }
        if(textPint.text == "0"){
            textPint.text = String("0.0000")
        }
        if(textLiter.text == "0"){
            textLiter.text = String("0.0000")
        }
        if(textOunce.text == "0"){
            textOunce.text = String("0.0000")
        }
        if(textMilileter.text == "0"){
            textMilileter.text = String("0.0000")
        }
        
        
        //check textbox has null values or all the text box has 0
        if ((textOunce.text?.isEmpty)! || (textPint.text?.isEmpty)! || (textLiter.text?.isEmpty)! || (textGallon.text?.isEmpty)! || (textMilileter.text?.isEmpty)!) == false {
            if((textOunce.text == "0.0000") && (textPint.text == "0.0000") && (textLiter.text == "0.0000") && (textGallon.text == "0.0000") && (textMilileter.text == "0.0000")) == false {
                
                //alert
                let userAlert = UIAlertController(title: "", message: "Conversion is saved", preferredStyle: UIAlertControllerStyle.alert)
                
                userAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                    
                }))
                
                present(userAlert, animated: true, completion: nil)
                
                //save data
                arrLiquid.append(textGallon.text! + " Gallon = " + textLiter.text! + " Liter = " + textPint.text! + " Pint = " + textOunce.text! + " Fluid Ounce =" + textMilileter.text! + "Milileter")
                let defaults = UserDefaults.standard
                defaults.set(arrLiquid, forKey: "recentLiquid")
                
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
