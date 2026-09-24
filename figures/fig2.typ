#import "@preview/maquette-gltf:0.1.0": render-gltf
#set page(width: auto, height: auto, margin: 2pt)
#render-gltf(
  read("../assets/red_epha2_blue_tfr.glb", encoding: none),
  camera: (35.188, 32.69, 61.823),
  center: (-0.6425, 0.7652, 0.2422),
  up: (-0.306, 0.906, -0.292),
  shadows: true,
  antialias: 4,
)
