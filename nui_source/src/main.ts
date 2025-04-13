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

Funcs.StopSound = (soundId: string) => {
    const audio = audios[soundId];
    if (!audio) return;

    const hasStarted = audio.played.length !== 0;
    if (hasStarted) {
        audio.pause();
        delete audios[soundId];
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
