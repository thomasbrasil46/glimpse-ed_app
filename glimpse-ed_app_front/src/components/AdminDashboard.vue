<script setup>
import { ref, onMounted } from 'vue';

const message = ref('Welcome to the Admin Dashboard');

const posts = ref([]);

const title = ref('');
const body = ref('');
const API_URL = 'http://localhost:3000/posts';

const createPost = async() => {
    const res = await fetch(API_URL, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ title: title.value, body: body.value })
    });
}


</script>

<template>
    <div class="admin-dashboard">
        <h1>Admin Dashboard</h1>
        <!-- Add your admin dashboard content here -->
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
</style>