<script setup>
import { onMounted, ref, watch } from 'vue'
const props = defineProps({ src: { type: String, required: true } })
const canvas = ref(null)

async function draw() {
  const res = await fetch(props.src, { cache: 'no-store' })
  if (!res.ok) return
  const blob = await res.blob()
  const bitmap = await createImageBitmap(blob)
  const c = canvas.value
  c.width = bitmap.width
  c.height = bitmap.height
  const ctx = c.getContext('2d', { alpha: false })
  ctx.drawImage(bitmap, 0, 0)
}

onMounted(draw)
watch(() => props.src, draw)
</script>

<template>
  <canvas ref="canvas" style="user-select:none; -webkit-user-drag:none;"></canvas>
</template>

<style scoped>
canvas { max-width: 100%; height: auto; }
</style>