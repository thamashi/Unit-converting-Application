

import UIKit

class weightViewController: UIViewController, UITextFieldDelegate  {

    @IBOutlet weak var textStPounds: UITextField!
    @IBOutlet weak var textStone: UITextField!
    @IBOutlet weak var textPound: UITextField!
    @IBOutlet weak var textOunce: UITextField!
    @IBOutlet weak var textGrams: UITextField!
    @IBOutlet weak var textKg: UITextField!
    var arrWeight = [String]()
    var savedArrWeight = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector( weightViewController.appMovedToBackground), name: Notification.Name.UIApplicationWillResignActive, object: nil)
        

        self.textKg.delegate = self
        self.textGrams.delegate = self
        self.textOunce.delegate = self
        self.textPound.delegate = self
        self.textStPounds.delegate = self
    }
    // tap any place to dismiss the keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
//save user defaults
    @objc  func appMovedToBackground() {
        print("App moved to background!")
        
        let defaults = UserDefaults.standard
        defaults.set(textOunce.text, forKey: "ounceValue")
        defaults.set(textPound.text, forKey: "poundValue")
        defaults.set(textGrams.text, forKey: "gramValue")
        defaults.set(textKg.text, forKey: "KgValue")
        defaults.set(textStone.text, forKey: "stoneValue")
        defaults.set(textStPounds.text, forKey: "stPoundsValue")
        defaults.synchronize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
         //display any saved text

        let defaults = UserDefaults.standard
        let ounceValue = defaults.string(forKey: "ounceValue")
        let poundValue = defaults.string(forKey: "poundValue")
        let gramsValue = defaults.string(forKey: "gramValue")
        let kgValue = defaults.string(forKey: "kgValue")
        let stoneValue = defaults.string(forKey: "stoneValue")
        let stPoundsValue = defaults.string(forKey: "stPoundsValue")
        textOunce.text = ounceValue
        textPound.text = poundValue
        textGrams.text = gramsValue
        textKg.text = kgValue
        textStone.text = stoneValue
        textStPounds.text = stPoundsValue
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        textOunce.becomeFirstResponder()
        
    }
    
    
    //KG changed function
    @IBAction func kgChanged(_ sender: Any) {
        let kgValue = (self.textKg.text! as NSString).floatValue
        let gramValue = kgValue * 1000
        let poundValue = gramToPound(gram: gramValue)
        let ounceValue = poundValue * 16
        let stoneValue = kgToStone(kg: kgValue)
        let stPoundsValue = kgToPounds(kg: kgValue)
        
        //restrict for 4 decimal value output
        self.textOunce.text = String(format: "%.4f",ounceValue)
        self.textPound.text = String(format: "%.4f",poundValue)
        self.textGrams.text = String(format: "%.4f",gramValue)
        self.textStPounds.text = String(format: "%.4f",stPoundsValue)
         self.textStone.text = "\(stoneValue)"
    }
    
    //Grams Changed function
    @IBAction func gramsChanged(_ sender: UITextField) {
        let gramValue = (self.textGrams.text! as NSString).floatValue
        let poundValue = gramToPound(gram: gramValue)
        let ounceValue = poundValue * 16
        let kgValue = gramToKg(gram: gramValue)
        let stoneValue = kgToStone(kg: kgValue)
        let stPoundsValue = kgToPounds(kg: kgValue)
        self.textStone.text = "\(stoneValue)"
        self.textOunce.text = String(format: "%.4f",ounceValue)
        self.textPound.text = String(format: "%.4f",poundValue)
        self.textKg.text = String(format: "%.4f",kgValue)
        self.textStPounds.text = String(format: "%.4f",stPoundsValue)
    }
    
    
    //Ounce changed function
    @IBAction func ounceChanged(_ sender: UITextField) {
        let ounceValue = (self.textOunce.text! as NSString).floatValue
        let poundValue = ounceValue / 16
        let gramValue = poundToGrams(pound: poundValue)
        let kgValue = gramToKg(gram: gramValue)
        let stoneValue = kgToStone(kg: kgValue)
        let stPoundsValue = kgToPounds(kg: kgValue)
        
        self.textStone.text = "\(stoneValue)"
        self.textPound.text = String(format: "%.4f", poundValue)
        self.textGrams.text = String(format: "%.4f",gramValue)
        self.textKg.text = String(format: "%.4f",kgValue)
        self.textStPounds.text = String(format: "%.4f",stPoundsValue)
    }
    
    //pounds changed function
    @IBAction func poundChanged(_ sender: UITextField) {
        let poundValue = (self.textPound.text! as NSString).floatValue
        let ounceValue = poundValue * 16
        let gramValue = poundToGrams(pound: poundValue)
        let kgValue = gramToKg(gram: gramValue)
        let stoneValue = kgToStone(kg: kgValue)
        let stPoundsValue = kgToPounds(kg: kgValue)
       
        self.textStone.text = "\(stoneValue)"
        self.textOunce.text = String(format: "%.4f",ounceValue)
        self.textGrams.text = String(format: "%.4f",gramValue)
        self.textKg.text = String(format: "%.4f",kgValue)
        self.textStPounds.text = String(format: "%.4f",stPoundsValue)

    }
    
    //Stones changed function
    @IBAction func stoneChanged(_ sender: UITextField) {
        let stPoundsValue = (self.textStPounds.text! as NSString).floatValue
        let stoneValue = (self.textStone.text! as NSString).floatValue
        let kgValue = stonePoundsToKg(stone:stoneValue, pounds: stPoundsValue)
        let gramValue = kgValue * 1000
        let poundValue = gramToPound(gram: gramValue)
        let ounceValue = poundValue * 16
        self.textOunce.text = String(format: "%.4f",ounceValue)
        self.textPound.text = String(format: "%.4f",poundValue)
        self.textGrams.text = String(format: "%.4f",gramValue)
        self.textKg.text = String(format: "%.4f",kgValue)
    }
    
    
    //STpounds changed function
    @IBAction func stPoundsChanged(_ sender: UITextField) {
        let stPoundsValue = (self.textStPounds.text! as NSString).floatValue
        
        //restrict user from entering a value more than 14
        if (stPoundsValue > 13.99999999){
            self.textStPounds.text = String(0.0)
        }
        else{
        let stoneValue = (self.textStone.text! as NSString).floatValue
        let kgValue = stonePoundsToKg(stone:stoneValue, pounds:stPoundsValue)
        let gramValue = kgValue * 1000
        let poundValue = gramToPound(gram: gramValue)
        let ounceValue = poundValue * 16
        self.textOunce.text = String(format: "%.4f",ounceValue)
        self.textPound.text = String(format: "%.4f",poundValue)
        self.textGrams.text = String(format: "%.4f",gramValue)
        self.textKg.text = String(format: "%.4f",kgValue)
        }
    }
    //Pounds to Grams Function
    func poundToGrams(pound:Float)->Float{
        let grams = pound * 453.59237
        return grams
    }
    
    //Grams to KG Function
    func gramToKg(gram:Float)->Float{
        let Kg = gram / 1000
        return Kg
    }
    
    //Grams to pounds Function
    func gramToPound(gram:Float)->Float{
        let pound = gram / 453.59237
        return pound
    }
    
    //KG to Stone Function
    func kgToStone(kg:Float)->Float{
        let stone = floor(kg / 6.35029318)
        return stone
    }
    
    //KG to Pounds Function
    func kgToPounds(kg:Float)->Float{
        let poundsVal = kg / 6.35029318
        let poundsNormal = poundsVal.truncatingRemainder(dividingBy: 1)
        let pounds = poundsNormal * 14
        return pounds
    }
    
    
    //STpounds to KG Function
    func stonePoundsToKg(stone:Float , pounds:Float)->Float{
        let Kg = (stone + (pounds/14)) * 6.35029318
        return Kg
    }
    
    //save data to an array
    @IBAction func saveData(_ sender: Any) {
        if let savedArrWeight = UserDefaults.standard.object(forKey: "recentWeight") as? [String]{
            arrWeight = savedArrWeight
        }
        
        if (arrWeight.count == 5){
            arrWeight.remove(at: 0)
        }
        //Check if all textbox has the value "0"
        if(textKg.text == "0"){
            textKg.text = String("0.0000")
        }
        if(textGrams.text == "0"){
            textGrams.text = String("0.0000")
        }
        if(textOunce.text == "0"){
            textOunce.text = String("0.0000")
        }
        if(textStone.text == "0"){
            textStone.text = String("0.0000")
        }
        if(textStPounds.text == "0"){
            textStPounds.text = String("0.0000")
        }
        
        //validation to check if textbox has emptyvalues
        if((textGrams.text?.isEmpty)! || (textPound.text?.isEmpty)! || (textOunce.text?.isEmpty)! || (textKg.text?.isEmpty)! || (textStone.text?.isEmpty)! || (textStPounds.text?.isEmpty)!) == false{
            
            if((textGrams.text == "0.0000") && (textPound.text == "0.0000") && (textOunce.text == "0.0000") && (textKg.text == "0.0000") && (textStone.text == "0.0000") && (textStPounds.text == "0.0000")) == false{
                
                
                //alert message
                let userAlert = UIAlertController(title: "", message: "Your Conversion is saved", preferredStyle: UIAlertControllerStyle.alert)
                
                userAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                    
                }))
                
                present(userAlert, animated: true, completion: nil)
                
                //save data
                arrWeight.append(textOunce.text! + " Ounce =" + textPound.text! + " Pound =" + textGrams.text! + " Grams =" + textKg.text! + " Kilo Grams =" + textStone.text! + " Stone &" + textStPounds.text! + " Pounds ")
                let defaults = UserDefaults.standard
                defaults.set(self.arrWeight, forKey: "recentWeight")
                
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
