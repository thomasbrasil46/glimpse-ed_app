<script setup>
import { ref, onMounted } from 'vue';


const posts = ref([]);

const API_URL = 'http://localhost:3000';
const token = ref(null);
const items = ref([]);


const gerarToken = async () => {
  const res = await fetch(`${API_URL}/admin/accesses`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({media_group_id: 1})
  });
  if (!res.ok) throw new Error('Falha ao gerar token');
  const data = await res.json();
  token.value = data.token;

  await carregarItens();
}

const carregarItens = async () => {
  const res = await fetch(`${API_URL}/access/${token.value}`);
  if (!res.ok) throw new Error('Falha ao buscar itens');
  const data = await res.json();
  items.value = data.items.map(item => ({
    ...item,
    url: `${API_URL}/stream/${token.value}/${item.id}`
  }));
}
</script>

<template>
  <div class="admin-dashboard">
    <h1>Galeria de Mídias</h1>

    <button @click="gerarToken">Gerar Token e Carregar Mídias</button>

    <div v-if="items.length > 0" class="media-grid">
      <div v-for="item in items" :key="item.id" class="media-card">
        <img v-if="item.mime_type.startsWith('image')" :src="item.url" :alt="`Imagem ${item.id}`" />
        <video v-else-if="item.mime_type.startsWith('video')" controls :src="item.url" />
        <p class="media-label">{{ item.mime_type }}</p>
      </div>
    </div>
  </div>
</template>

<style scoped>
.admin-dashboard {
  padding: 20px;
}

button {
  margin-bottom: 20px;
  padding: 8px 16px;
  background: #3b82f6;
  color: white;
  border: none;
  border-radius: 6px;
  cursor: pointer;
}

button:hover {
  background: #2563eb;
}

.media-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
  gap: 16px;
}

.media-card {
  background: #f9fafb;
  padding: 10px;
  border-radius: 8px;
  text-align: center;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

img,
video {
  max-width: 100%;
  border-radius: 6px;
}

.media-label {
  margin-top: 8px;
  font-size: 12px;
  color: #6b7280;
}
</style>