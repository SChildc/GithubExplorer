//
//  HTTPConst.swift
//
//
//  Created by childc on 2/18/24.
//

import Foundation

public enum HTTPConst {
    /// HTTP method definitions.
    ///
    /// - SeeAlso: https://tools.ietf.org/html/rfc7231#section-4.3
    public enum Method: String {
        case options = "OPTIONS"
        case get = "GET"
        case head = "HEAD"
        case post = "POST"
        case put = "PUT"
        case patch = "PATCH"
        case delete = "DELETE"
        case trace = "TRACE"
        case connect = "CONNECT"
        case propFind = "PROPFIND"
        case report = "REPORT"
        case mkCalendar = "MKCALENDAR"
        case propPatch = "PROPPATCH"
    }
    
    public enum StatusCode: Int {
        case ok = 200
        case badRequest = 400
        case unauthorized = 401
        case forbidden = 403
        case notFound = 404
        case timeout = 408
        case serverError = 500
        case insufficientStorage = 507
    }
}

public typealias HTTPMethod = HTTPConst.Method
public typealias HTTPStatusCode = HTTPConst.StatusCode
