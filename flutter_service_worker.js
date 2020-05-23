'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "main.dart.js": "1aa419571d010eaa21b4f04ddd46ff27",
"assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"assets/FontManifest.json": "f7161631e25fbd47f3180eae84053a51",
"assets/LICENSE": "4ac20c7209bb52b11e6aec99740e10b8",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"assets/assets/arrow.png": "1d661da4b0af357958a832d852bdb658",
"assets/AssetManifest.json": "135dcd431f40591a87665dc1d82661c2",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"manifest.json": "b8987614482ea67b612188838747d561",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"index.html": "ce394a75b72ea8a8557c19a890185fd1",
"/": "ce394a75b72ea8a8557c19a890185fd1"
};

self.addEventListener('activate', function (event) {
  event.waitUntil(
    caches.keys().then(function (cacheName) {
      return caches.delete(cacheName);
    }).then(function (_) {
      return caches.open(CACHE_NAME);
    }).then(function (cache) {
      return cache.addAll(Object.keys(RESOURCES));
    })
  );
});

self.addEventListener('fetch', function (event) {
  event.respondWith(
    caches.match(event.request)
      .then(function (response) {
        if (response) {
          return response;
        }
        return fetch(event.request);
      })
  );
});
