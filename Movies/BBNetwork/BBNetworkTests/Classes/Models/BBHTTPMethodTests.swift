import Quick
import Nimble

import BBNetwork

final class BBHTTPMethodTests: QuickSpec {

    override func spec() {
        var sut: BBHTTPMethod!

        describe("#GET") {
            beforeEach {
                sut = .get
            }

            it("has GET as rawValue") {
                expect(sut.rawValue).to(equal("GET"))
            }
        }

        describe("#POST") {
            beforeEach {
                sut = .post
            }

            it("has POST as rawValue") {
                expect(sut.rawValue).to(equal("POST"))
            }
        }

        describe("#PUT") {
            beforeEach {
                sut = .put
            }

            it("has PUT as rawValue") {
                expect(sut.rawValue).to(equal("PUT"))
            }
        }

        describe("#DELETE") {
            beforeEach {
                sut = .delete
            }

            it("has DELETE as rawValue") {
                expect(sut.rawValue).to(equal("DELETE"))
            }
        }
    }
}
