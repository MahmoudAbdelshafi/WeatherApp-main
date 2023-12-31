//
//  ProviderError.swift
//  Hover
//
//  Created by Onur Hüseyin Çantay on 8.07.2019.
//  Copyright © 2019 Onur Hüseyin Çantay. All rights reserved.
//

import Foundation


public enum ProviderError: Error, Equatable{
    public static func == (lhs: ProviderError, rhs: ProviderError) -> Bool {
            switch (lhs, rhs) {
            case (.invalidServerResponseWithStatusCode(let statusCode1), .invalidServerResponseWithStatusCode(let statusCode2)):
                return statusCode1 == statusCode2

            case (.invalidServerResponse, .invalidServerResponse):
                return true

            case (.missingBodyData, .missingBodyData):
                return true

            case (.failedToDecodeImage, .failedToDecodeImage):
                return true

            case (.decodingError(let error1), .decodingError(let error2)):
                return (error1 as NSError) == (error2 as NSError)

            case (.connectionError(let error1), .connectionError(let error2)):
                return (error1 as NSError) == (error2 as NSError)

            case (.underlying(let error1), .underlying(let error2)):
                return (error1 as NSError) == (error2 as NSError)

            default:
                return false
            }
        }

    case invalidServerResponseWithStatusCode(statusCode: Int)
    case invalidServerResponse
    case missingBodyData
    case failedToDecodeImage
    case decodingError(Error)
    case connectionError(Error)
    case underlying(Error)
}

public extension ProviderError {
     var errorDescription: String {
        switch self {
        case .invalidServerResponse:
            return "Failed to parse the response to HTTPResponse"
        case .connectionError(let error):
            return "Network connection seems to be offline: \(error.localizedDescription)"
        case .decodingError(let error):
            return "Decoding problem: \(error.localizedDescription)"
        case .underlying(let error):
            return error.localizedDescription
        case .invalidServerResponseWithStatusCode(let statusCode):
            return "The server response didn't fall in the given range Status Code is: \(statusCode)"
        case .missingBodyData:
            return "No body data provided from the server"
        case .failedToDecodeImage:
            return "the body doesn't contain a valid data."
        }
    }
}
