
import UIKit

class WeightHistoryController: UIViewController {
    
    @IBOutlet weak var conversionlbl1: UILabel!
    @IBOutlet weak var conversionlbl2: UILabel!
    @IBOutlet weak var conversionlbl3: UILabel!
    @IBOutlet weak var conversionlbl4: UILabel!
    @IBOutlet weak var conversionlbl5: UILabel!
    var arrweight = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let x = UserDefaults.standard.object(forKey: "recentWeight") as? [String]{
            arrweight = x
            printDataWeight()
        }
    }
    
    //array to save 5 history
    func printDataWeight(){
        if (arrweight.isEmpty == false){
            if arrweight.indices.contains(0){
                conversionlbl1.text = arrweight[0]
            }
            if arrweight.indices.contains(1){
                conversionlbl2.text = arrweight[1]
            }
            if arrweight.indices.contains(2){
                conversionlbl3.text = arrweight[2]
            }
            if arrweight.indices.contains(3){
                conversionlbl4.text = arrweight[3]
            }
            if arrweight.indices.contains(4){
                conversionlbl5.text = arrweight[4]
            }
        }
    }
    
}

