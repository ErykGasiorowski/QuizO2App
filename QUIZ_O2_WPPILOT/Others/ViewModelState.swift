//
//  ViewModelState.swift
//  QUIZ_O2_WPPILOT
//
//  Created by Eryk Gasiorowski on 03/04/2022.
//

import Foundation

enum ViewModelState: Equatable {
  case loading
  case error(String)
  case idle
}
