import UIKit
protocol iMocker {
    associatedtype MockedMethod: Hashable
    associatedtype ParamList_t = [Any?]
    associatedtype ReturnType_t = Any
    func setReturnValueFor(_ methodName : MockedMethod, returnValue : ReturnType_t?, n : Int)
    func getReturnValueFor(_ methodName : MockedMethod) -> ReturnType_t?
    func getParametersFor(_ methodName : MockedMethod, n : Int) -> ParamList_t?
    func getInvocationCountFor(_ methodName : MockedMethod) -> Int
    func recordInvocation(_ methodName : MockedMethod, paramList : ParamList_t?)
    func reset()
}

private extension Array {
    func get(at i: Index) -> Element? {
        var count = 0
        for item in self {
            if count == i {
                return item
            }
            count += 1
        }
        return nil
    }
}
open class Mocker<MockedMethod: Hashable> : NSObject, iMocker {
    public typealias ParamList_t = [Any?]
    public typealias ReturnType_t = Any
    public typealias ErrorType_t = Error

    var invocationParameterArray = Dictionary<MockedMethod, Array<ParamList_t?>>()
    var definedReturnValues = Dictionary<MockedMethod, Array<ReturnType_t?>>()
    var definedReturnValueRequestCount = Dictionary<MockedMethod, Int>()
    // If unspecified (or negative), n will append the returnValue to the queue of returnValues
    // If specified, n will override the already-specified returnValue

    var definedErrorsToThrow = Dictionary<MockedMethod, Array<ErrorType_t?>>()
    var definedErrorsToThrowRequestCount = Dictionary<MockedMethod, Int>()

    open func setReturnValueFor(_ methodName : MockedMethod, returnValue : ReturnType_t?, n : Int = -1) {
        if (definedReturnValues[methodName] == nil) {
            definedReturnValues[methodName] = Array<ReturnType_t?>()
            definedReturnValueRequestCount[methodName] = 0
        }
        if (n <= definedReturnValues[methodName]!.count) {
            definedReturnValues[methodName]!.append(returnValue)
        }
        else {
            definedReturnValues[methodName]![n] = returnValue
        }
    }

    func setErrorToThrowFor(_ methodName: MockedMethod, error: Error, n: Int) {
        if (definedErrorsToThrow[methodName] == nil) {
            definedErrorsToThrow[methodName] = Array<ErrorType_t?>()
            definedErrorsToThrowRequestCount[methodName] = 0
        }
        if (n <= definedErrorsToThrow[methodName]!.count) {
            definedErrorsToThrow[methodName]!.append(error)
        }
        else {
            definedErrorsToThrow[methodName]![n] = error
        }
    }

    open func getReturnValueFor(_ methodName : MockedMethod) -> ReturnType_t? {
        guard let requestCount = definedReturnValueRequestCount[methodName],
            let returnValues = definedReturnValues[methodName] else {
            return nil
        }
        definedReturnValueRequestCount[methodName] = requestCount + 1
        assert(returnValues.count > 0, "Could not return \(requestCount)th value for \(methodName); no return values were set.")
        if requestCount < returnValues.count {
            return returnValues[requestCount]
        }
        else {
            return returnValues[returnValues.count - 1]
        }
    }

    open func throwErrorIfAnyFor(_ methodName: MockedMethod) throws {
        guard let requestCount = definedErrorsToThrowRequestCount[methodName],
              let errorsToThrow = definedErrorsToThrow[methodName] else { return }

        definedErrorsToThrowRequestCount[methodName] = requestCount + 1

        if requestCount < errorsToThrow.count {
            if let error = errorsToThrow[requestCount] {
                throw error
            }
        }
        else {
            if let error = errorsToThrow[errorsToThrow.count - 1] {
                throw error
            }
        }
    }

    open func getParametersFor(_ methodName : MockedMethod, n : Int = 0) -> ParamList_t? {
        guard let methodName = invocationParameterArray[methodName] else { return nil }
        let parametersForAllInvocations : Array<ParamList_t?> = methodName
        return parametersForAllInvocations.get(at: n) ?? nil
    }
    open func getInvocationCountFor(_ methodName : MockedMethod) -> Int {
        let parametersForAllInvocations : Array<ParamList_t?>? = invocationParameterArray[methodName]
        return ( (parametersForAllInvocations == nil) ? 0 : parametersForAllInvocations!.count )
    }
    open func recordInvocation(_ methodName : MockedMethod, paramList : ParamList_t? = []) {
        if (invocationParameterArray[methodName] == nil) {
            invocationParameterArray[methodName] = Array<ParamList_t?>()
        }
        invocationParameterArray[methodName]!.append(paramList)
    }
    open func reset() {
        invocationParameterArray.removeAll(keepingCapacity: false)
        definedReturnValues.removeAll(keepingCapacity: false)
        definedReturnValueRequestCount.removeAll(keepingCapacity: false)
        definedErrorsToThrow.removeAll(keepingCapacity: false)
        definedErrorsToThrowRequestCount.removeAll(keepingCapacity: false)
    }
}
