//
//  Extension+Dispactch.swift
//  MindValleyMobileTest
//
//  Created by Engineer 144 on 24/06/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation

func underground(work: @escaping () -> ()) {
    DispatchQueue.global(qos: .userInitiated).async {
        work()
    }
}

func mainThread(work: @escaping () -> ()) {
    DispatchQueue.main.async {
        work()
    }
}
