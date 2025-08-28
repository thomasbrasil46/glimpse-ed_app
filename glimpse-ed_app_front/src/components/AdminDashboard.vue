<script setup>
import { ref, onMounted } from 'vue';


const posts = ref([]);

const API_URL = 'http://localhost:3000';
const token = ref(null);
const items = ref([]);
const mediaUrl = ref(null);

const gerarToken = async () => {
    const res = await fetch(`${API_URL}/admin/accesses`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({})
    });
    if (!res.ok) throw new Error('Falha ao gerar token');
    const data = await res.json();
    token.value = data.token;

    await carregarItens();
}

const carregarItens = async () => {
    const res = await fetch(`${API_URL}/access/${token.value}`);
    const data = await res.json();
    items.value = data.items;

    if (items.value.length > 0) {
        const item = items.value[0];
        mediaUrl.value = `${API_URL}/stream/${token.value}/${item.id}`;
    }
}

</script>

<template>
  <div class="admin-dashboard">
    <h1>Dá uma olhadinha!</h1>

    <button @click="gerarToken">Gerar Token e Carregar Mídia</button>

    <div v-if="mediaUrl" class="media-container">
      <!-- Renderiza conforme tipo -->
      <img
        v-if="items[0]?.mime_type.startsWith('image')"
        :src="mediaUrl"
        alt="Mídia"
      />
      <video
        v-else-if="items[0]?.mime_type.startsWith('video')"
        controls
        :src="mediaUrl"
      />
    </div>
  </div>
</template>

<style scoped>
.media-container {
  margin-top: 20px;
}
img, video {
  max-width: 400px;
  border-radius: 8px;
}
</style>