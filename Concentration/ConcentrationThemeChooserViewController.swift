//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by Sneh Patel on 3/30/20.
//  Copyright © 2020 Sneh Patel. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController {
    
    let themes = [
        "Faces":"😃😅😂🤣😇🙃😜🧐",
        "Cats":"😸😹😻😼😽🙀😿😾",
        "Animals":"🐶🐱🐭🐹🐰🦊🐻🐼",
        "Food":"🥨🍕🥪🌮🍩🍫🍪🧁",
        "Trees":"🎄🌿🍀🌵🌴🌾🎍🎋"
    
    ]
    
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName]{
                if let cvc = segue.destination as? ConcentrationViewController{
                    cvc.theme = theme
                }
                
                
            }
            
        }
        
        
    }
    

}
