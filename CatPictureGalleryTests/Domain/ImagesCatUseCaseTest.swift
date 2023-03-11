//
//  ImagesCatUseCaseTest.swift
//  CatPictureGalleryTests
//
//  Created by Gustavo Freitas Vilela on 10/03/23.
//

import XCTest
@testable import CatPictureGallery

final class ImagesCatUseCaseTest: XCTestCase {
    func testSuccessResult() {
        let image = Image(id: "1", description: "test", type: "image/jpg")
        let video = Image(id: "2", description: "test", type: "video/mp4")
        let repositoryMock = GalleriesRepositoryMock()
        repositoryMock.resultMock = Result.success([Gallery(id: "1", images: [image, video])])

        let subject = ImagesCatUseCaseImpl(galeriesRepository: repositoryMock)
        let expec = expectation(description: "test")
        subject.execute { result in
            switch result {
            case .success(let images):
                XCTAssertEqual(images.count, 1)
                XCTAssertEqual(images.first?.type, "image/jpg")
            case .failure(_):
                XCTFail()
            }
            expec.fulfill()
        }
        waitForExpectations(timeout: 1.0)
    }

    func testErrorResult() {
        let repositoryMock = GalleriesRepositoryMock()
        repositoryMock.resultMock = Result.failure(RepositoryError.malformatedResponse)

        let subject = ImagesCatUseCaseImpl(galeriesRepository: repositoryMock)
        let expec = expectation(description: "test")
        subject.execute { result in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error as! RepositoryError, RepositoryError.malformatedResponse)
            }
            expec.fulfill()
        }
        waitForExpectations(timeout: 1.0)
    }
}
