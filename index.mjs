let i = 0;

function log() {
  console.log('Hello World #%d @ %s', ++i, new Date().toISOString());
}

while (true) {
  log();
  await new Promise((resolve) => {
      setTimeout(resolve, 5000);
  })
}
