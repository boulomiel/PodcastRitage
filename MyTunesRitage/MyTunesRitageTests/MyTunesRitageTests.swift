//
//  MyTunesRitageTests.swift
//  MyTunesRitageTests
//
//  Created by Ruben Mimoun on 23/01/2023.
//

import XCTest
import Combine
@testable import MyTunesRitage

final class MyTunesRitageTests: XCTestCase {
    
    
    class MockApiClient : ApiClientDelegate {
        
        var mustsTriggerError : Bool = false

        func fetch<D>(query: [URLQueryItem]?) -> AnyPublisher<D, MyTunesRitage.APIError> where D : Decodable, D : Encodable {
            let mocks : D =  BundleReader.read("podcasts")
            if mustsTriggerError{
                return Fail(error: APIError.failedRequest(reason: "test failing"))
                    .eraseToAnyPublisher()
            }
            return Just(mocks)
                .mapError{ _ in
                    return APIError.failedRequest(reason: "test failing")
                }
                .eraseToAnyPublisher()
        }
    }

    
    class MockInteractor : MusicSearchBusinessLogic {
        
        var subscriptions : Set<AnyCancellable> = .init()

        var presenter: MyTunesRitage.MusicSearchPresenterLogic?
        
        var searchApi: MyTunesRitage.ItunesApiClient = ItunesApiClient(apiClient: MockApiClient())
        
        var fetchedHasBeenCalled : Bool = false

        func setErrorApi() {
            (searchApi.apiClient as? MockApiClient)?.mustsTriggerError =  true
        }
        
        func fetch(_ request: MyTunesRitage.MusicSearchData.Request) {
            fetchedHasBeenCalled = true
            if request.query.isEmpty {
                presenter?.emptyResponse(.init())
                return
            }
             searchApi
                .get(request.query)
                .first()
                .map { $0.results }
                .flatMap { $0.publisher}
                .sink(receiveCompletion : { [weak self] completion in
                    if case let .failure(error) = completion {
                        self?.presenter?.showError(.init(raw: error))
                    }
                } , receiveValue : {[weak self] item  in
                    self?.presenter?.createSong(.init(raw:item))
                })
                .store(in:&subscriptions)
        }
        
    }
    
    class MockPresenter : MusicSearchPresenterLogic {
        var view: MyTunesRitage.MusicSearchDisplayLogic?
        
        func showError(_ response: MyTunesRitage.MusicSearchData.Response.Error) {
            view?.showError(.init(title: "Test", reason: "I wanted to"))
        }
        
        func emptyResponse(_ response: MyTunesRitage.MusicSearchData.Response.Empty) {
            view?.clearInput()
        }
        
        func createSong(_ response: MyTunesRitage.MusicSearchData.Response.Success) {
            view?.showSong(.mock)
        }
        
    }
   
    var subscriptions : Set<AnyCancellable> = .init()
    var vm : MusicSearchProvider?
    var interactor : MockInteractor?
    var presenter : MockPresenter?

    
    override func setUpWithError() throws {
        vm = .init()
        interactor = MockInteractor()
        presenter = MockPresenter()
        presenter!.view = vm!
        vm?.interactor =  interactor!
        vm?.presenter = presenter!

    }
    
    override func tearDownWithError() throws {
        vm = nil
        interactor = nil
        presenter = nil
        subscriptions.forEach{ $0.cancel() }
    }
    
    func testFetchWhileQuerrying() {
        vm?.start()
        vm?.searchableText = "Pizza"
        let expectation = expectation(description: "fetch test")
        DispatchQueue.main.asyncAfter(deadline : .now() + 0.5){
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.5)
        XCTAssertTrue(interactor!.fetchedHasBeenCalled, "interactor fetch() has not been called")
    }
    

    func testApiClientSuccess() {
        let expectation = expectation(description: "success test")
        var data : [Any] = []
        vm?.start()
        vm?.onSongReceived
            .sink{ d in
                data.append(d)
            }
            .store(in: &subscriptions)
        vm?.searchableText = "Pizza"
        DispatchQueue.main.asyncAfter(deadline : .now() + 0.8){
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(data.count == 10, "no data has been fetched")
    }
    
    func testApiClientError() {
        let expectation = expectation(description: "error test")
        var data : Failure?
        interactor?.setErrorApi()
        vm?.start()
        vm?.onErrorReceived
            .sink{ d in
               data = d
            }
            .store(in: &subscriptions)
        vm?.searchableText = "Pizza"
        DispatchQueue.main.asyncAfter(deadline : .now() + 0.8){
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(data != nil, "no error has been received from api")
        XCTAssertTrue(data!.title == "Test", "the error title is wrong")

    }
    
    func testClearInput() {
        let expectation = expectation(description: "clear test")
        var data : ()?
        interactor?.setErrorApi()
        vm?.searchableText = "Hello"
        vm?.start()
        vm?.searchableText = ""
        vm?.onClearInput
            .sink{ d in
               data = d
            }
            .store(in: &subscriptions)
        DispatchQueue.main.asyncAfter(deadline : .now() + 0.8){
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(data != nil, "clearInput should be called when querrying an empty value")
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
