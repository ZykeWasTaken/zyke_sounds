import { Send } from "./utils/nui";

interface SoundData {
    soundId: string;
    soundName: string;
    volume: number;
    looped?: boolean;
    playCount?: number;
}

interface FuncMap {
    [event: string]: (data: any) => void;
}

const audios: Record<string, HTMLAudioElement> = {};
const Funcs: FuncMap = {};

window.addEventListener("message", (e: MessageEvent) => {
    const event = e.data.event as string;
    const data = e.data.data;

    if (Funcs[event]) Funcs[event](data);
});

Funcs.PlaySound = (soundData: SoundData) => {
    const audio = new Audio(`sounds/${soundData.soundName}`);

    audio.volume = soundData.volume;
    audio.loop = soundData.looped ?? false;

    audio.play().catch((err) => {
        console.error("Failed to play sound:", err);
    });

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

Funcs.StopSound = ({
    soundId,
    fade = 0, // Fade sound in ms, defaults to no fade
    forceFull = false, // Force audio to fully play, ignores fade & if audio has not yet started
}: {
    soundId: string;
    fade?: number;
    forceFull?: boolean;
}) => {
    const audio = audios[soundId];
    if (!audio) return;

    const hasStarted = audio.played.length !== 0;
    if (hasStarted) {
        // If forcing the full audio, simply set loop to false, delete the id and let it play out
        if (forceFull) {
            audio.loop = false;
            delete audios[soundId];

            return;
        }

        // If not fading the audio, stop it, delete the id and return
        if (fade == 0) {
            audio.pause();
            delete audios[soundId];
            return;
        }

        // If fading the audio, make sure to delete it insantly to avoid duplicate ids if one is manually provided
        // Then, slowly fade the audio out
        delete audios[soundId];

        const orgVolume = audio.volume;
        const interval = 20;
        const steps = Math.floor(fade / interval);
        const stepSize = orgVolume / steps;

        let currStep = 0;
        let newVolume = orgVolume;
        const fadeInterval = setInterval(() => {
            if (currStep >= steps) {
                clearInterval(fadeInterval);
                audio.pause();
                return;
            }

            currStep += 1;
            newVolume -= stepSize;
            if (newVolume < 0.0) {
                newVolume = 0.0;
                currStep = steps;
            }

            audio.volume = newVolume;
        }, interval);
    } else {
        audio.addEventListener("canplay", () => {
            if (audios[soundId]) {
                audios[soundId].pause();
                delete audios[soundId];
            }
        });
    }
};

Funcs.UpdateSoundVolume = (soundData: { soundId: string; volume: number }) => {
    const audio = audios[soundData.soundId];
    if (!audio) return;

    audio.volume = soundData.volume;
};
