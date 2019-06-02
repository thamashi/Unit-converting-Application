
import UIKit

class NegativeKeyboard: UITextField{

    let temperature = TemperatureController()
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.keyboardType = UIKeyboardType.decimalPad
        
    }
    
    fileprivate func getAccessoryButtons() -> UIView
    {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.superview!.frame.size.width, height: 44))
        view.backgroundColor = UIColor.lightGray
        
        let minusButton = UIButton(type: UIButtonType.custom)
        minusButton.setTitle("NEGATIVE", for: UIControlState())
        let buttonWidth = view.frame.size.width;
        minusButton.frame = CGRect(x: 85, y: 0, width: buttonWidth, height: 44);
        minusButton.addTarget(self, action: #selector(NegativeKeyboard.minusTouchUpInside(_:)), for: UIControlEvents.touchUpInside)
        view.addSubview(minusButton)
        
        return view;
    }
    
    @objc func minusTouchUpInside(_ sender: UIButton!) {
        
        let text = self.text!
        if(text.isEmpty == false) {
            let index: String.Index = text.index(text.startIndex, offsetBy: 1)
            let firstChar = text[..<index]
            if firstChar == "-" {
                self.text = String(text[index...])
            } else {
                self.text = "-" + text
                self.endEditing(true)
            }
        }
    }
    
   
    override func layoutSubviews() {
        super.layoutSubviews()
        self.inputAccessoryView = getAccessoryButtons()
    }
    

}
