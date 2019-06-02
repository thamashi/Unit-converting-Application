

import UIKit

class liquidhistoryViewController: UIViewController {
    @IBOutlet weak var conversionlbl1: UILabel!
    @IBOutlet weak var conversionlbl2: UILabel!
    @IBOutlet weak var conversionlbl3: UILabel!
    @IBOutlet weak var conversionlbl4: UILabel!
    @IBOutlet weak var conversionlbl5: UILabel!
    
    
    var liquid = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let n = UserDefaults.standard.object(forKey: "recentLiquid") as? [String]{
            liquid = n
            printDataLiquid()
        }
    }
    //save last 5 history to array
    func printDataLiquid(){
        if (liquid.isEmpty == false){
            if liquid.indices.contains(0){
                conversionlbl1.text = liquid[0]
            }
            if liquid.indices.contains(1){
                conversionlbl2.text = liquid[1]
            }
            if liquid.indices.contains(2){
                conversionlbl3.text = liquid[2]
            }
            if liquid.indices.contains(3){
                conversionlbl4.text = liquid[3]
            }
            if liquid.indices.contains(4){
                conversionlbl5.text = liquid[4]
            }
        }
    }
   

}
