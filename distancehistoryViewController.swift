

import UIKit

class distancehistoryViewController: UIViewController {
    @IBOutlet weak var conversionlbl1: UILabel!
    @IBOutlet weak var conversionlbl2: UILabel!
    @IBOutlet weak var conversionlbl3: UILabel!
    @IBOutlet weak var conversionlbl4: UILabel!
    @IBOutlet weak var conversionlbl5: UILabel!
    var distance = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if let y = UserDefaults.standard.object(forKey: "recentDistance") as? [String]{
            distance = y
            printDataDistance()
        }
    }
    
    //save last 5 history to array
    func printDataDistance(){
        if (distance.isEmpty == false){
            if distance.indices.contains(0){
                conversionlbl1.text = distance[0]
            }
            if distance.indices.contains(1){
                conversionlbl2.text = distance[1]
            }
            if distance.indices.contains(2){
                conversionlbl3.text = distance[2]
            }
            if distance.indices.contains(3){
                conversionlbl4.text = distance[3]
            }
            if distance.indices.contains(4){
                conversionlbl5.text = distance[4]
            }
        }
    }


}
