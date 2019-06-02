

import UIKit

class temperaturehistoryViewController: UIViewController {
    @IBOutlet weak var conversionlbl1: UILabel!
    @IBOutlet weak var conversionlbl2: UILabel!
    @IBOutlet weak var conversionlbl3: UILabel!
    @IBOutlet weak var conversionlbl4: UILabel!
    @IBOutlet weak var conversionlbl5: UILabel!
    var temperature = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if let m = UserDefaults.standard.object(forKey: "recentTemperature") as? [String]{
            temperature = m
            printDataTemperature()
        }
    }
    //save last 5 history to array
    func printDataTemperature(){
        if (temperature.isEmpty == false){
            if temperature.indices.contains(0){
                conversionlbl1.text = temperature[0]
            }
            if temperature.indices.contains(1){
                conversionlbl2.text = temperature[1]
            }
            if temperature.indices.contains(2){
                conversionlbl3.text = temperature[2]
            }
            if temperature.indices.contains(3){
                conversionlbl4.text = temperature[3]
            }
            if temperature.indices.contains(4){
                conversionlbl5.text = temperature[4]
            }
        }
    }


}
