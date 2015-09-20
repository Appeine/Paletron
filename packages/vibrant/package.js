var description = {
    name: 'appeine:vibrant',
    summary: 'Wrapper around node-vibrant',
    version: '1.0.0',
    git: ''
};

var dependencies = ['coffeescript'];
var npmDependencies = {
    'node-vibrant': '1.1.1'
};
var clientFiles = [];
var serverFiles = [
    'server/vibrant.coffee'
];
var libFiles = [];

Package.describe(description);
Npm.depends(npmDependencies);
Package.onUse(function (api) {
    api.use(dependencies);
    api.addFiles(clientFiles, ['client']);
    api.addFiles(serverFiles, ['server']);
    api.addFiles(libFiles, ['server', 'client']);
});