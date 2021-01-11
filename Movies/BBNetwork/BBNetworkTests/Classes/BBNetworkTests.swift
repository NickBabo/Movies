import Quick
import Nimble

@testable import BBNetwork

final class BBNetworkTests: QuickSpec {

    override func spec() {
        var sut: BBNetworkProtocol!
        var requestExecuterMock: BBRequestExecuterMock!
        var delegateMock: BBNetworkDelegateMock!

        beforeEach {
            requestExecuterMock = BBRequestExecuterMock()
            delegateMock = BBNetworkDelegateMock()
            mockRequest(ObjectMock())

            sut = BBNetwork(requestExecuter: requestExecuterMock,
                            bundle: Bundle(for: BundleExtTests.self))
        }

        describe("#init") {
            it("sets up the shared instance") {
                expect(BBNetwork.shared).toNot(beNil())
            }
        }

        describe("#set") {
            it("sets the delegate") {
                BBNetwork.set(delegate: delegateMock)

                expect(BBNetwork.shared.delegate).to(beAKindOf(BBNetworkDelegateMock.self))
            }
        }

        describe("#sessionConfig") {
            it("returns the expected session configuration") {
                let config = BBNetwork.sessionConfig

                expect(config.timeoutIntervalForRequest).to(equal(60.0))
                expect(config.timeoutIntervalForResource).to(equal(80.0))
            }
        }

        describe("#request") {
            it("requests a service and decodes the response into given type") {
                sut.request(ServiceMock(), responseType: ObjectMock.self) { result in
                    let expectedURL = URL(string: "base.url.test/example/path")
                    expect(requestExecuterMock.calledWithRequest?.url).to(equal(expectedURL))

                    switch result {
                    case .success(let objectMock):
                        expect(objectMock.id).to(equal(1))
                        expect(objectMock.name).to(equal("name"))
                    case .failure:
                        fail("FAIL - Expected request to succeed")
                    }
                }
            }

            context("unable to decode into given type") {
                beforeEach {
                    mockRequest(NoResponse())
                }

                it("returns a decodingError") {
                    sut.request(ServiceMock(), responseType: ObjectMock.self) { result in
                        switch result {
                        case .success:
                            fail("FAIL - Expected request to fail")
                        case .failure(let error):
                            expect(error).to(equal(.decodingError))
                        }
                    }
                }
            }

            context("bundle has no baseURL info") {
                beforeEach {
                    sut = BBNetwork(requestExecuter: requestExecuterMock,
                                    bundle: Bundle(for: BBNetwork.self))
                }

                it("returns an invalidBaseURL error") {
                    sut.request(ServiceMock(), responseType: ObjectMock.self) { result in
                        switch result {
                        case .success:
                            fail("FAIL - Expected request to fail")
                        case .failure(let error):
                            expect(error).to(equal(.invalidBaseURL))
                        }
                    }
                }
            }
        }

        func mockRequest(_ object: Encodable?, error: BBAPIError? = nil) {
            if let data = object?.encodeToData() {
                requestExecuterMock.mock(.success(data))
            } else {
                requestExecuterMock.mock(.failure(error!))
            }
        }
    }
}
