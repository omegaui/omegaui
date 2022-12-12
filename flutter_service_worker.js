'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "canvaskit/canvaskit.js": "2bc454a691c631b07a9307ac4ca47797",
"canvaskit/canvaskit.wasm": "bf50631470eb967688cca13ee181af62",
"canvaskit/profiling/canvaskit.js": "38164e5a72bdad0faa4ce740c9b8e564",
"canvaskit/profiling/canvaskit.wasm": "95a45378b69e77af5ed2bc72b2209b94",
"flutter.js": "f85e6fb278b0fd20c349186fb46ae36d",
"main.dart.js": "f4bb899f1ab8856e7b523cbc2469c368",
"version.json": "3fe4fd5df2020acccdd334a29a3cc4f4",
"assets/assets/lvc-icon.png": "fc6770b1926a5a8ee255e6059144aa83",
"assets/assets/omega_ide_icon500.png": "9bb571f237ee72f472158e4a0f282710",
"assets/assets/icons8-complex-67.png": "dd15ab64be8d632158bd578e057b8cb8",
"assets/assets/icons8-database-administrator-48.png": "3790cb788c06c066f5b41165a6ad8c5c",
"assets/assets/icons8-java-48.png": "0414fcd53fdb6903fb57134fdd8a9af2",
"assets/assets/icons8-dart-48.png": "0a4777b993a114d9b9870727398bcac6",
"assets/assets/icons8-firebase-48.png": "0e4792f1b38576bce30728eec593a301",
"assets/assets/icons8-flutter-48.png": "bc20ac3c833cdfbb9230c8a0dc483d46",
"assets/assets/icons8-shell-64.png": "852084a51a58bdf620066a05a7caa4d7",
"assets/assets/icons8-python-48.png": "e22d64a2c8825fb9ab6f31bb4bba4fe6",
"assets/assets/icons8-artificial-intelligence-48.png": "5894bc97996c79b29d3e2a73aa3ba2ce",
"assets/assets/curly_create_icon-512.png": "29190951e279faf120eade091d2f9a05",
"assets/assets/icons8-raspberry-pi-zero-48.png": "71de5e02a7ef8696417261fb65f20fe0",
"assets/assets/icons8-desktop-64.png": "12cb8442ac21b6c3c716f5e725bfd944",
"assets/assets/icons8-android-os-48.png": "e22997feaac464c25d13e2d50e0eb394",
"assets/assets/icons8-instagram-48.png": "ff86eb598ca653dbf7f55325f6aadb09",
"assets/assets/icons8-github-48.png": "dc96f5b99dff3acbd46ae054a1052ae8",
"assets/assets/icons8-youtube-48.png": "f6adbbcd622d373bffc5df99b5cd8e64",
"assets/assets/icons8-reddit-48.png": "b38900898159821618bac797681cf328",
"assets/assets/icons8-planet.png": "3252e631902bbad85d9b2a6112f2a584",
"assets/assets/icons8-casteller.png": "d9f967da955bc4b65844cb937dccb0ec",
"assets/assets/icons8-meteors.png": "b4e60b7b1bee8ef468e900b499574641",
"assets/fonts/RNSCamelia-Bold.otf": "6e8d6b6ce06ee5533b2d791c44211c0e",
"assets/fonts/RNSCamelia-Medium.otf": "96298b41e1192c8daff7059974098071",
"assets/fonts/RNSCamelia-Regular.otf": "2d6c484d640ada36d91f8fd4a479cc37",
"assets/fonts/Nunito-Bold.ttf": "91019ffb3b1df640e444b34e5a73dfc3",
"assets/fonts/Nunito-Medium.ttf": "108670f0b05efd5a10ca1afce69e28a3",
"assets/fonts/Nunito-Regular.ttf": "0c890be2af0d241a2387ad2c4c16af2c",
"assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/shaders/ink_sparkle.frag": "ce05426477102af63fa769f8f3e23f76",
"assets/AssetManifest.json": "cd587c2a92cb662b36553fbcf98f79a5",
"assets/FontManifest.json": "7c01590ac262a67be2680683676a9d70",
"assets/NOTICES": "77e809080179e0af083cb751e2d22d68",
"favicon.png": "ba616e6fb10aa3817c8adbd1ea02b9c2",
"manifest.json": "cf45190907d344e52142f1d5a28e5da7",
"index.html": "5510ac331dbed4e731662dc94a2a9393",
"/": "5510ac331dbed4e731662dc94a2a9393",
"icons/Icon-192.png": "ba616e6fb10aa3817c8adbd1ea02b9c2",
"icons/Icon-512.png": "2f50c9ead4fb382906adb100e6675b73",
"icons/Icon-512-maskable.png": "4ccba68932475a81fac3a5a3f9edf197",
"icons/Icon-192-maskable.png": "5eae33b037a56c9c979cffff0a8f4c85",
"favicon.ico": "a3389b184bc511af459c4f3c50fdca24"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
