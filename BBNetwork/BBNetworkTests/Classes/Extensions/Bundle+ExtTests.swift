import Quick
import Nimble

@testable import BBNetwork

final class BundleExtTests: QuickSpec {

    override func spec() {

        var sut: Bundle!

        beforeEach {
            sut = Bundle(for: BundleExtTests.self)
        }

        describe("#getInfo") {
            it("returns the info value related to a given key") {
                let expectedValue: String = "base.url.test/"

                expect(sut.getInfo(for: .baseURL)).to(equal(expectedValue))
            }

            context("when info does not exists") {
                beforeEach {
                    sut = Bundle(for: BBNetwork.self)
                }

                it("returns nil") {
                    let info: String? = sut.getInfo(for: .baseURL)

                    expect(info).to(beNil())
                }
            }
        }

        describe("#BundleInfoKey") {

            var key: Bundle.BundleInfoKey!

            context("baseURL") {

                beforeEach {
                    key = .baseURL
                }

                it("has the expected value") {
                    expect(key.rawValue).to(equal("BB_BASE_URL"))
                }
            }
        }
    }
}
