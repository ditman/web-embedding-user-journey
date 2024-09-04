// flutter_bootstrap.js
{{flutter_js}}
{{flutter_build_config}}

_flutter.loader.load({
  onEntrypointLoaded: async function onEntrypointLoaded(engineInitializer) {
    let engine = await engineInitializer.initializeEngine({
      multiViewEnabled: true, // Enables embedded mode. Needs `runWidget` in main.
    });
    let app = await engine.runApp();
    onFlutterAppReady(app);
  }
});

function onFlutterAppReady(app) {
  // Find all chart containers...
  let containers = document.querySelectorAll('.chart[data-value]');
  // Initialize a view for each container...
  containers.forEach((container) => {
    app.addView({
      hostElement: container,
      // Passing data-value to Flutter.
      initialData: {
        value: parseInt(container.dataset.value, 10),
      },
    });
  });
}
