import UIKit

class FooterWithLike: UICollectionReusableView {
    
    @IBOutlet weak var TestView: NewLike!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    var scoreBool = false
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let scale3D = CATransform3DMakeScale(1, 2, 2)
        UIView.animate(withDuration: 1.0, delay: 0.0, options:[.curveEaseInOut, .allowUserInteraction], animations: {
            self.layer.transform = scale3D
            if self.scoreBool == false {
                self.TestView.changeScoreUp()
                self.scoreBool = true
                self.TestView.setColorRed()
            } else if self.scoreBool == true {
                self.TestView.changeScoreDown()
                self.scoreBool = false
                self.TestView.setColorDarkGrey()
            }
            
        }, completion: { finished in
            print("animate is finished")
            
        })
        print("[Logging] LikeView is tapped, new like score - \(self.TestView.newLikeScore)")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.transform = .identity
    }
}
