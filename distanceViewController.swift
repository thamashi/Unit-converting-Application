
import UIKit

class distanceViewController: UIViewController, UITextFieldDelegate  {

    @IBOutlet weak var textCm: UITextField!
    @IBOutlet weak var textMetre: UITextField!
    @IBOutlet weak var textMm: UITextField!
    @IBOutlet weak var textInch: UITextField!
    @IBOutlet weak var textYard: UITextField!
    @IBOutlet weak var textMiles: UITextField!
    var arrDistance = [String]()
     var savedArrDistance = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        textMetre.becomeFirstResponder()
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(distanceViewController.appMovedToBackground),
        name: Notification.Name.UIApplicationWillResignActive, object: nil)
        
        self.textCm.delegate = self
        self.textMetre.delegate = self
        self.textInch.delegate = self
        self.textMm.delegate = self
        self.textYard.delegate = self
        self.textMiles.delegate = self
    }
    // tap any place to dismiss the keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    //save user defaults
    @objc  func appMovedToBackground() {
        print("App moved to background!")
        let defaults = UserDefaults.standard
        defaults.set(textCm.text, forKey: "cmValue")
        defaults.set(textMetre.text, forKey: "metreValue")
        defaults.set(textInch.text, forKey: "inchValue")
        defaults.set(textMm.text, forKey: "mmValue")
        defaults.set(textYard.text, forKey: "yardValue")
        defaults.set(textMiles.text, forKey: "mileValue")
        defaults.synchronize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //put any saved text back
        let defaults = UserDefaults.standard
        let cmValue = defaults.string(forKey: "cmValue")
        let metreValue = defaults.string(forKey: "metreValue")
        let inchValue = defaults.string(forKey: "inchValue")
        let mmValue = defaults.string(forKey: "mmValue")
        let yardValue = defaults.string(forKey: "yardValue")
        let mileValue = defaults.string(forKey: "mileValue")
        textCm.text = cmValue
        textMetre.text = metreValue
        textInch.text = inchValue
        textMm.text = mmValue
        textYard.text = yardValue
        textMiles.text = mileValue
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // function metre changed
    @IBAction func metreChanged(_ sender: UITextField) {
        let metreValue = (self.textMetre.text! as NSString).floatValue
        let cmValue = metreValue*100
        let inchValue = metreValue*39.3701
        let mmValue = metreValue*1000
        let yardValue = metreValue*1.09361
        let mileValue = metreValue*0.333121371
       
        self.textCm.text = String(format: "%.4f",cmValue)
        self.textInch.text = String(format: "%.4f",inchValue)
        self.textMm.text = String(format: "%.4f",mmValue)
        self.textYard.text = String(format: "%.4f",yardValue)
        self.textMiles.text = String(format: "%.4f",mileValue)
        
    }
    
    
    // function cm changed
    @IBAction func cmChanged(_ sender: UITextField) {
        let cmValue = (self.textCm.text! as NSString).floatValue
        let metreValue = cmValue/100
        let inchValue = cmValue*0.393701
        let mmValue = cmValue*10
        let yardValue = cmValue*0.010936
        let mileValue = cmValue*0.0000062137
       
        self.textMetre.text = String(format: "%.4f",metreValue)
        self.textInch.text = String(format: "%.4f",inchValue)
        self.textMm.text = String(format: "%.4f",mmValue)
        self.textYard.text = String(format: "%.4f",yardValue)
        self.textMiles.text = String(format: "%.4f",mileValue)
        
    }
    
    //function inch changed
    @IBAction func inchChanged(_ sender: UITextField) {
        let inchValue = (self.textInch.text! as NSString).floatValue
        let cmValue = inchValue*2.54
        let metreValue = inchValue*0.0254
        let mmValue = inchValue*25.4
        let yardValue = inchValue*0.0277778
        let mileValue = inchValue*1.5783
     
        self.textCm.text = String(format: "%.4f",cmValue)
        self.textMetre.text = String(format: "%.4f",metreValue)
        self.textMm.text = String(format: "%.4f",mmValue)
        self.textYard.text = String(format: "%.4f",yardValue)
        self.textMiles.text = String(format: "%.4f",mileValue)
    }
    
    //function mm changed
    @IBAction func mmChanged(_ sender: Any) {
        let mmValue = (self.textMm.text! as NSString).floatValue
        let cmValue = mmValue/10
        let metreValue = mmValue/1000
        let inchValue = mmValue*0.039370
        let yardValue = mmValue*0.0010936
        let mileValue = mmValue*0.00000062137
      
        self.textCm.text = String(format: "%.4f",cmValue)
        self.textMetre.text = String(format: "%.4f",metreValue)
        self.textInch.text = String(format: "%.4f",inchValue)
        self.textYard.text = String(format: "%.4f",yardValue)
        self.textMiles.text = String(format: "%.4f",mileValue)
    }
    
    
    //function yard changed
    @IBAction func yardChanged(_ sender: Any) {
        let yardValue = (self.textYard.text! as NSString).floatValue
        let cmValue = yardValue*91.44
        let metreValue = yardValue*0.9144
        let inchValue = yardValue*36
        let mmValue = yardValue*914.4
        let mileValue = yardValue*0.0005182
       
        self.textCm.text = String(format: "%.4f",cmValue)
        self.textMetre.text = String(format: "%.4f",metreValue)
        self.textMm.text = String(format: "%.4f",mmValue)
        self.textInch.text = String(format: "%.4f",inchValue)
        self.textMiles.text = String(format: "%.4f",mileValue)
        
    }
    
    
    @IBAction func milesChanged(_ sender: Any) {
        let mileValue = (self.textMiles.text! as NSString).floatValue
        let cmValue = mileValue*160934
        let metreValue = mileValue*1069.34
        let inchValue = mileValue*63360
        let mmValue = mileValue*1609344
        let yardvalue = mileValue*1760
        
        self.textCm.text = String(format: "%.4f",cmValue)
        self.textMetre.text = String(format: "%.4f",metreValue)
        self.textMm.text = String(format: "%.4f",mmValue)
        self.textInch.text = String(format: "%.4f",inchValue)
        self.textYard.text = String(format: "%.4f",yardvalue)
    }
    
    
    
    //save the data
    @IBAction func saveData(_ sender: Any) {
        if let savedArrDistance = UserDefaults.standard.object(forKey: "recentDistance") as? [String]{
            arrDistance = savedArrDistance
        }
        
        if (arrDistance.count == 5){
            arrDistance.remove(at: 0)
        }
        if(textCm.text == "0"){
            textCm.text = String("0.0000")
        }
        if(textMetre.text == "0"){
            textMetre.text = String("0.0000")
        }
        if(textInch.text == "0"){
            textInch.text = String("0.0000")
        }
        if(textMm.text == "0"){
            textMm.text = String("0.0000")
        }
        if(textYard.text == "0"){
            textYard.text = String("0.0000")
        }
        if(textMiles.text == "0"){
            textMiles.text = String("0.0000")
        }
        //validation to check if textbox has emptyvalues
        if((textMetre.text?.isEmpty)! || (textCm.text?.isEmpty)! || (textMm.text?.isEmpty)! || (textInch.text?.isEmpty)! || (textYard.text?.isEmpty)! || (textMiles.text?.isEmpty)!) == false{
            if((textMetre.text == "0.0000") && (textCm.text == "0.0000") && (textMm.text == "0.0000") && (textInch.text == "0.0000") && (textYard.text == "0.0000") && (textMiles.text == "0.0000")) == false{
                //alert
                let userAlert = UIAlertController(title: "", message: "Conversion is saved", preferredStyle: UIAlertControllerStyle.alert)
                
                userAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                    
                }))
                
                present(userAlert, animated: true, completion: nil)
                
            // output of saved data in history
            arrDistance.append(textCm.text! + " Centi Meter =" + textMetre.text! + " Meter =" + textInch.text! + " Inch =" + textMm.text! + " Milli meter =" + textYard.text! + " Yards = " + textMiles.text!)
            let defaults = UserDefaults.standard
            defaults.set(arrDistance, forKey: "recentDistance")
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


