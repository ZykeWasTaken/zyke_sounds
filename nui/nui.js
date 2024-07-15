const Send = (eventName, data) => {
    axios.post("https://zyke_sounds/Eventhandler", {
        event: eventName,
        data: data,
    });
};
