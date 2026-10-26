//
//  NetworkError.swift
//  LaunchPad
//
//  Created by Роман Пичугин on 25.10.2026.
//

import Foundation

nonisolated enum NetworkError: Error {
    case badURL
    case transport(Error)
    case clientError(Int)
    case serverError(Int)
    case decoding(Error)
    case encodeError
    case authProblem
    case responseError
    case unknownError
    case limitRequest
    
    var userMessage: String {
        switch self {
        case .transport(let error):
            guard let urlError = error as? URLError else {
                return "Что-то пошло не так"
            }
            
            switch urlError.code {
            case .notConnectedToInternet:
                return "Проверьте соединение с интернетом"
            case .networkConnectionLost:
                return "Пропало соединение с интернетом"
            case .timedOut:
                return "Сервер не отвечает. Пробуйте позже"
            case .cannotFindHost, .cannotConnectToHost:
                return "Сервер недоступен. Попробуйте позже"
            default:
                return "Проблемы с подключением"
            }
            
        case .badURL, .clientError, .decoding, .encodeError, .unknownError, .responseError:
            return "Что-то пошло не по плану"
            
        case .serverError:
            return "Проблема с сервером, повторите еще раз"
            
        case .authProblem:
            return "Проблема с авторизацией. Авторизуйтесь еще раз"
            
        case .limitRequest:
            return "Лимит запросов исчерпан. Попробуйте через час"
        }
    }
    
    var isCancelled: Bool {
        switch self {
        case .transport(let error):
            guard let urlError = error as? URLError else {
                return false
            }
            
            return urlError.code == .cancelled
        default:
            return false
        }
    }
    
    var isRetryable: Bool {
        switch self {
        case .transport:
            return !isCancelled
        case .serverError:
            return true
        default:
            return false
        }
    }
}
