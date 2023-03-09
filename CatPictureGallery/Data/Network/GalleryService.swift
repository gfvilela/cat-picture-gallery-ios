//
//  GalleryService.swift
//  CatPictureGallery
//
//  Created by Gustavo Freitas Vilela on 09/03/23.
//

import Foundation
import Alamofire

protocol GalleryService {
    func fetchGalleriesImagesCat(completion: @escaping (Result<[Gallery]?, Error>) -> Void)
}

class GalleryServiceImpl: GalleryService {
    func fetchGalleriesImagesCat(completion: @escaping (Result<[Gallery]?, Error>) -> Void) {
        AF.request(Router.fetchGalleriesImagesCat).responseDecodable(of: GalleriesResponseDTO.self) { response in
            switch response.result {
            case .success(let galleriesDTO):
                let galleriesDomain = galleriesDTO.data?.compactMap({ $0.toDomain() })
                completion(Result.success(galleriesDomain))
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
}

extension GalleryServiceImpl {
    enum Router: URLRequestConvertible {
        case fetchGalleriesImagesCat

        var method: HTTPMethod {
            switch self {
            case .fetchGalleriesImagesCat:
                return .get
            }
        }

        var url: URL? {
            guard let urlComponents = NSURLComponents(string: Environment.apiBaseURL) else {
                return nil
            }
            urlComponents.queryItems = []

            switch self {
            case .fetchGalleriesImagesCat:
                urlComponents.path = "/3/gallery/search"
                urlComponents.queryItems?.append(URLQueryItem(name: "q", value: "cats"))
            }

            return urlComponents.url
        }

        var parameters: Parameters? {
            return nil
        }

        var parameterEncoding: ParameterEncoding {
            switch self.method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }

        func asURLRequest() throws -> URLRequest {
            guard let url = self.url else {
                throw InternalError.badURL
            }

            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = self.method.rawValue

            if let body = self.parameters {
                try urlRequest = self.parameterEncoding.encode(urlRequest, with: body)
            }

            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.setValue("Client-ID 1ceddedc03a5d71", forHTTPHeaderField: "Authorization")

            return urlRequest
        }
    }
}
