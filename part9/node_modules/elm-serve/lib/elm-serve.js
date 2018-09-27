module.exports = function elmServe(opts) {
  const supervisor = require('supervisor');
  const path = require('path');
  const os = require('os');
  const clc = require('cli-color');

  const runFile = path.join(
    os.tmpdir(),
    'reload-' +
      Math.random()
        .toString()
        .slice(2)
  );

  const serverFile = path.join(__dirname, './elm-reload-server.js');

  var args = [
    '-e',
    opts.exts || 'html|js|css',
    '-w',
    opts.watchDir || process.cwd(),
    '-q',
    '--',
    serverFile,
    opts.port || 8080,
    opts.dir || process.cwd(),
    opts.open || false,
    opts.host || 'localhost',
    runFile,
    opts.startPage || 'index.html',
    opts.pushstate || false,
    opts.verbose || false,
  ];
  supervisor.run(args);

  console.log('\nReload web server:');
  console.log('listening on port ' + clc.blue.bold(opts.port || 8080));
  console.log('monitoring dir ' + clc.green.bold(opts.dir || process.cwd()));
};
