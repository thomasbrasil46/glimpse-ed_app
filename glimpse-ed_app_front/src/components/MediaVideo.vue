<script setup>
import { onMounted, ref, watch } from 'vue'
const props = defineProps({ src: { type: String, required: true } })
const videoEl = ref(null)
let objectUrl = null

async function load() {
  const res = await fetch(props.src, { cache: 'no-store' })
  if (!res.ok) return
  const blob = await res.blob()
  if (objectUrl) URL.revokeObjectURL(objectUrl)
  objectUrl = URL.createObjectURL(blob)
  videoEl.value.src = objectUrl
}

onMounted(load)
watch(() => props.src, load)
</script>

<template>
  <div class="media-video">
    <video
      ref="videoEl"
      controls
      preload="auto"
      playsinline
      class="media-video-player"
    >
      Seu navegador não suporta vídeo em HTML5.
    </video>
  </div>
</template>

<style scoped>
.media-video {
  display: flex;
  justify-content: center;
  align-items: center;
  margin: 1rem auto;
  max-width: 100%;
}

.media-video-player {
  width: 100%;
  max-width: 800px;
  border-radius: 12px;
  background-color: #000;
  box-shadow: 0 4px 10px rgba(0,0,0,0.4);
}
</style>