import Foundation
import UIKit
import XLPagerTabStrip
import Cartography

class ParentViewController:TwitterPagerTabStripViewController{
    
    override public func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [PositiveViewController(), NegativeViewController()]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
}
