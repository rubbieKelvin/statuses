// .pragma library
function svg(s) {
    return "data:image/svg+xml;utf8, " + s
}

function mediaType(source) {
    if (source === "")
        return ""
    if (source.endsWith(".mp4") || source.endsWith(".mkv")
            || source.endsWith(".avi"))
        return "VIDEO"
    if (source.endsWith(".gif"))
        return "GIF"
    return "IMAGE"
}

function twoDigitString(number) {
    if (number < 10) {
        number = "0" + number
    }
    return number
}

function timeFromDuration(duration) {
    let dur = new Date(duration)
    let hour = dur.getUTCHours()
    let minute = dur.getUTCMinutes()
    let seconds = dur.getUTCSeconds()

    let time = ""
    if (hour > 0) {
        time += twoDigitString(hour) + ":"
    }

    time += twoDigitString(minute) + ":"
    time += twoDigitString(seconds)

    return time
}
