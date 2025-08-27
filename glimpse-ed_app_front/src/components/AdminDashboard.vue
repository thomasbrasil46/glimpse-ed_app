<script setup>
import { ref, onMounted } from 'vue';


const posts = ref([]);

const API_URL = 'http://localhost:3000/watcher/';

const createPost = async() => {
    const res = await fetch(API_URL, {
        // método get para capturar o link do QR code gerado pelo backend
        method: 'GET',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({  })
    });
}


</script>

<template>
    <div class="admin-dashboard">
        <h1>Dá uma olhadinha!</h1>
        <!-- Add your admin dashboard content here -->
        <button @click="createPost">Gerar QR Code</button>
        <p>Copiar link</p>
        <input/>
    </div>
</template>

<style scoped>
.admin-dashboard {
    padding: 20px;
}

.admin-dashboard h1 {
    font-size: 2em;
    margin-bottom: 20px;
}

.admin-dashboard button {
    padding: 10px 20px;
    font-size: 1em;
    cursor: pointer;
}

.admin-dashboard input {
    margin-left: 10px;
    padding: 5px;
    font-size: 1em;
}
</style>