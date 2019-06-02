import UIKit

class speedhistoryViewController: UIViewController {

    @IBOutlet weak var conversionlbl1: UILabel!
    @IBOutlet weak var conversionlbl2: UILabel!
    @IBOutlet weak var conversionlbl3: UILabel!
    @IBOutlet weak var conversionlbl4: UILabel!
    @IBOutlet weak var conversionlbl5: UILabel!
     var speed = [String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let x = UserDefaults.standard.object(forKey: "recentSpeed") as? [String]{
            speed = x
            printDataSpeed()
        }
    }
    //save last 5 history to array
    func printDataSpeed(){
        if (speed.isEmpty == false){
            if speed.indices.contains(0){
                conversionlbl1.text = speed[0]
            }
            if speed.indices.contains(1){
                conversionlbl2.text = speed[1]
            }
            if speed.indices.contains(2){
                conversionlbl3.text = speed[2]
            }
            if speed.indices.contains(3){
                conversionlbl4.text = speed[3]
            }
            if speed.indices.contains(4){
                conversionlbl5.text = speed[4]
            }
        }
    }

    
}
