///**
/**
BioAuthTest
Created by: Ameya Bhagat on 19/01/22
TranslucentEffectView | 

+-----------------------------------------------------------------------------------+
| Permission is hereby granted, free of charge, to any person obtaining a copy  	
| of this software and associated documentation files (the "Software"), to deal	
| in the Software without restriction, including without limitation the rights	
| to use, copy, modify, merge, publish, distribute, sublicense, and/or sell		
| copies of the Software, and to permit persons to whom the Software is		
| furnished to do so, subject to the following conditions:				
|											
| The above copyright notice and this permission notice shall be included in		
| all copies or substantial portions of the Software.					
|											
| THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR		
| IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,		
| FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE	
| AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER		
| LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,	
| OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN		
| THE SOFTWARE.	
									
+-----------------------------------------------------------------------------------+
*/

import UIKit
/**`TranslucentEffectView` is a subclass of `UIVisualEffectView`. This class provides a translucent View. */
public class TranslucentEffectView: UIVisualEffectView {
    //MARK: - Properties
    private var translucentEffect: UIBlurEffect {
        UIBlurEffect(style: .systemThickMaterial)
    }
    //MARK: - init
    override init(effect: UIVisualEffect?) {
        super.init(effect: effect)
        print("`TranslucentEffectView` initialised.")
        self.effect = translucentEffect
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - superclass methods
extension TranslucentEffectView {
    /** This method calls function to update the UI as the system theme change  */
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
        switch traitCollection.userInterfaceStyle {
            
        case .unspecified:
            refreshView(style: .systemThickMaterialLight)
        case .light:
            refreshView(style: .systemThickMaterialLight)
        case .dark:
            refreshView(style: .systemThickMaterialDark)
        @unknown default:
            refreshView(style: .systemThickMaterialLight)
        }
    }
}

//MARK: - Methods
extension TranslucentEffectView {
    /**This function will create a new blur effect and apply it to the view based on the style provided in the `style` parameter. */
    private func refreshView(style: UIBlurEffect.Style) {
        var blurEffect: UIBlurEffect {
            UIBlurEffect(style: style)
        }
        self.effect = blurEffect
    }
}

