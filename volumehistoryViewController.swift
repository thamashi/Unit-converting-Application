

import UIKit

class volumehistoryViewController: UIViewController {

    @IBOutlet weak var conversionlbl1: UILabel!
    @IBOutlet weak var conversionlbl2: UILabel!
    @IBOutlet weak var conversionlbl3: UILabel!
    @IBOutlet weak var conversionlbl4: UILabel!
    @IBOutlet weak var conversionlbl5: UILabel!
    
    
    var arrvolume = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let o = UserDefaults.standard.object(forKey: "recentVolume") as? [String]{
            arrvolume = o
            printDataVolume()
        }
    }
    //save last 5 history to array
    func printDataVolume(){
        if (arrvolume.isEmpty == false){
            if arrvolume.indices.contains(0){
                conversionlbl1.text = arrvolume[0]
            }
            if arrvolume.indices.contains(1){
                conversionlbl2.text = arrvolume[1]
            }
            if arrvolume.indices.contains(2){
                conversionlbl3.text = arrvolume[2]
            }
            if arrvolume.indices.contains(3){
                conversionlbl4.text = arrvolume[3]
            }
            if arrvolume.indices.contains(4){
                conversionlbl5.text = arrvolume[4]
            }
        }
    }
   

}
