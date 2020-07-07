import Foundation

public protocol Mockable {
    associatedtype MockedMethods: Hashable
    var mocker: Mocker<MockedMethods> { get set }

    func record(invocation: MockedMethods, with parameters: Any?...)
    func invocationCount(for name: MockedMethods) -> Int
    func parameters(for name: MockedMethods, at index: Int) -> [Any?]?
    func parameter<T>(for name: MockedMethods, at index: Int, andInvocation invocation: Int) -> T?
    func setReturnValue(for name: MockedMethods, with value: Any?, index: Int)
    func throwErrorIfAny(for name: MockedMethods) throws
    func returnValue<T>(for name: MockedMethods) -> T?
    func reset()
}

public extension Mockable {
    
    func record(invocation name: MockedMethods, with parameters: Any?...) {
        mocker.recordInvocation(name, paramList: parameters as [Any?])
    }

    func invocationCount(for name: MockedMethods) -> Int {
        return mocker.getInvocationCountFor(name)
    }

    func parameters(for name: MockedMethods, at index: Int = 0) -> [Any?]? {
        return mocker.getParametersFor(name, n: index)
    }

    func parameter<T>(for name: MockedMethods, at index: Int, andInvocation invocation: Int = 0) -> T? {
        return parameters(for: name, at: invocation)?.value(at: index) as? T
    }

    func setErrorToThrow(for name: MockedMethods, with error: Error, index: Int = -1) {
        mocker.setErrorToThrowFor(name, error: error, n: index)
    }

    func setReturnValue(for name: MockedMethods, with value: Any?, index: Int = -1) {
        mocker.setReturnValueFor(name, returnValue: value, n: index)
    }

    func throwErrorIfAny(for name: MockedMethods) throws {
        try mocker.throwErrorIfAnyFor(name)
    }

    func returnValue<T>(for name: MockedMethods) -> T? {
        return mocker.getReturnValueFor(name) as? T
    }

    func reset() {
        mocker.reset()
    }
}

private extension Array {
    func value(at index: Int) -> Element? {
        guard index >= 0 && index < endIndex else {
            return nil
        }
        return self[index]
    }
}
