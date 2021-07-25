#!/usr/bin/env -S deno run --allow-net --allow-run --allow-write
import { ProgrammableFS, basename, dirname, exec } from './deps.ts'

const port = 8080
const server = new ProgrammableFS()
server.onEvent = async event => {
  switch (event.type) {
    case 'write-text-file': {
      const { path } = JSON.parse(event.data || '{ path: "" }')
      if (basename(path) === 'main.txt') {
        const parentDir = dirname(path)
        const qax = `${parentDir}.qax`
        await exec(`sh -c "cd '${parentDir}'; rm -v '../${qax}'; zip -r '../${qax}' *"`)
        await exec(`sh -c "cd ./headless-qa-viewer; yarn; cd ..; rm -v '${qax}-iq' '${qax}-qa'; node ./headless-qa-viewer/index.js '${qax}'"`)
      }
      break
    }
  }
}
server.start({ port })
