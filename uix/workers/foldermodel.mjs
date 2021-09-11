WorkerScript.onMessage = function (message) {
    let list = message.list

    list.forEach(function (item) {
        const data = {
            "filename": item
        }
        message.model.append(data)
        message.model.sync()
    })
}
