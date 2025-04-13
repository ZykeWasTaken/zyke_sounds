import axios from "axios";

export const Send = (eventName: string, data: any): void => {
    axios.post("https://zyke_sounds/Eventhandler", {
        event: eventName,
        data: data,
    });
};
