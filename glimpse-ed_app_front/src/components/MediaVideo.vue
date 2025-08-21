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