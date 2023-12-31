//
//  AnyEncodable.swift
//  Hover
//
//  Created by Onur Cantay on 30/12/2023.
//  Copyright © 2022 Onur Hüseyin Çantay. All rights reserved.
//

import Foundation

public struct AnyEncodable {
  public let wrappedValue: Encodable
  
  public init<E>(_ value: E) where E: Encodable {
    wrappedValue = value
  }
}
