//
//  MainViewModel.swift
//  OxygenTest
//
//  Created by Александр Сетров on 05.04.2021.
//

import Foundation
import UIKit

protocol MainViewModelProtocol: class {
    func fetchSystemInfo() -> Void
    var systemVersion: ((String) -> Void)? { get set }
    var modelName: ((String) -> Void)? { get set }
}

final class MainViewModel: MainViewModelProtocol {

    var systemVersion: ((String) -> Void)?

    var modelName: ((String) -> Void)?

    func fetchModelName() {
        let model = UIDevice.current.modelName
        self.modelName?(model)
    }

    func fetchSystemVersion() {
        let systemVersion = "iOS " + UIDevice.current.systemVersion
        self.systemVersion?(systemVersion)
    }

    func fetchSystemInfo() {
        self.fetchModelName()
        self.fetchSystemVersion()
    }
}
