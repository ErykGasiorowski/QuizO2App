//
//  AppNavigator.swift
//  QUIZ_O2_WPPILOT
//
//  Created by Eryk Gasiorowski on 03/04/2022.
//

import Foundation
import UIKit

class AppNavigator: BaseNavigator {
    static let shared = AppNavigator()
    
    init() {
        let route: Route = CharacterRoutes.list
        super.init(with: route)
    }
    
    required init(with route: Route) {
        super.init(with: route)
    }
    
    var settingsParentVC: UIViewController?
    
    func popSettings() {
        guard let settingsParentVC = settingsParentVC else {
            popEmbedded()
            return
        }
        popEmbedded(to: settingsParentVC, animated: false)
    }
}
