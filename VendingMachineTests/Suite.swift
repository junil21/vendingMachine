import Quick
import Nimble

@testable import VendingMachine

class Suite: QuickSpec {
    override func spec() {
        beforeSuite {
            Nimble.AsyncDefaults.Timeout = 5
        }
    }
}
