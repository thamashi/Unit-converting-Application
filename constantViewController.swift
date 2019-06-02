
import UIKit

class constantViewController: UIViewController {

    @IBOutlet weak var electronlabel: UILabel!
    @IBOutlet weak var protonLabel: UILabel!
    @IBOutlet weak var neutronLabel: UILabel!
    @IBOutlet weak var ePermittivityLabel: UILabel!
    @IBOutlet weak var magneticLabel: UILabel!
    @IBOutlet weak var speedOflight: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let font:UIFont? = UIFont(name:"HelveticaNeue-Italic", size:20)
        let fontSuper:UIFont? = UIFont(name:"HelveticaNeue-Italic", size:10)
        
        let attString:NSMutableAttributedString = NSMutableAttributedString(string: "me", attributes: [.font:font!])
        attString.setAttributes([.font:fontSuper!,.baselineOffset:-3], range: NSRange(location:1,length:1))
        electronlabel.attributedText = attString
        
        let proString:NSMutableAttributedString = NSMutableAttributedString(string: "mp", attributes: [.font:font!])
        proString.setAttributes([.font:fontSuper!,.baselineOffset:-3], range: NSRange(location:1,length:1))
        protonLabel.attributedText = proString
        
        let neuString:NSMutableAttributedString = NSMutableAttributedString(string: "mn", attributes: [.font:font!])
        neuString.setAttributes([.font:fontSuper!,.baselineOffset:-3], range: NSRange(location:1,length:1))
        neutronLabel.attributedText = neuString
        
        let permString:NSMutableAttributedString = NSMutableAttributedString(string: "\u{03b5}0", attributes: [.font:font!])
        permString.setAttributes([.font:fontSuper!,.baselineOffset:-3], range: NSRange(location:1,length:1))
        ePermittivityLabel.attributedText = permString
        
        let magString:NSMutableAttributedString = NSMutableAttributedString(string: "\u{03bc}0", attributes: [.font:font!])
        magString.setAttributes([.font:fontSuper!,.baselineOffset:-3], range: NSRange(location:1,length:1))
        magneticLabel.attributedText = magString
        
//        let speedLight:NSMutableAttributedString = NSMutableAttributedString(string: "C", attributes: [.font:font!])
//        speedLight.setAttributes([.font:fontSuper!,.baselineOffset:-3], range: NSRange(location:1,length:1))
//        speedOflight.attributedText = speedLight

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
