let audios = {};
let Funcs = {};
window.addEventListener("message", (e) => {
    const event = e.data.event;
    const data = e.data.data;

    if (Funcs[event]) Funcs[event](data);
});

Funcs.PlaySound = (soundData) => {
    const audio = new Audio("sounds/" + soundData.soundName);

    audio.volume = soundData.volume;
    audio.loop = soundData.looped || false;

    audio.play();

    audios[soundData.soundId] = audio;

    if (!soundData.looped) {
        audio.onended = () => {
            if (soundData.playCount && soundData.playCount > 1) {
                soundData.playCount -= 1;

                return Funcs.PlaySound(soundData);
            }

            Send("SoundEnded", {
                soundId: soundData.soundId,
            });

            delete audios[soundData.soundId];
        };
    }
};

Funcs.StopSound = (soundId) => {
    if (!audios[soundId]) return;

    const hasStarted = audios[soundId].played.length !== 0;
    if (hasStarted) {
        audios[soundId].pause();
        delete audios[soundId];
    } else {
        audios[soundId].addEventListener("canplay", () => {
            audios[soundId].pause();
            delete audios[soundId];
        });
    }
};

Funcs.UpdateSoundVolume = (soundData) => {
    if (!audios[soundData.soundId]) return;

    audios[soundData.soundId].volume = soundData.volume;
};
