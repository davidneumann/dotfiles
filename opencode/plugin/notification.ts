import type { Plugin } from "@opencode-ai/plugin";

const isMac = process.platform === "darwin";

export const NotificationPlugin: Plugin = async (pluginArgs: any) => {
  const {$, client} = pluginArgs;
  const directoryBasename = pluginArgs.directory?.split('/').pop() || undefined;

  return {
    event: async (eventArgs: any) => {
      const {event} = eventArgs;
      if (event.type === "session.idle" && process.env.OPENCODE_NOTIFICATIONS !== "false") {
        const result = await client.session.get({ path: { id: event.properties.sessionID } })
        if (result.data?.parentID) return;
        let title = "OpenCode";
        if(directoryBasename) {
          title = title + " - " + directoryBasename;
        }
        if (isMac) {
          await $`osascript -e ${`display notification "Task completed" with title "${title}"`}`;
          await $`afplay /System/Library/Sounds/Glass.aiff`;
        } else {
          await $`notify-send "${title}" "Task completed"`;
          await $`play -n synth 0.10 tri 600 : synth 0.10 tri 800 : synth 0.12 tri 1000 vol -18dB`.quiet();
        }
        await Bun.write("/tmp/opencode_debug.json", JSON.stringify({pluginArgs, eventArgs}, null, 2));
      }
    },
  }
}
