<template>
  <div class="avatar-card">
    <img :src="avatar.image" alt="Avatar Image" />
    <h3>{{ avatar.name }}</h3>
    <p>{{ avatar.description }}</p>
    <span>{{ avatar.type }}</span>
    <button @click="startChat">Chat</button>
    <button @click="$emit('edit', avatar)">Edit</button>
  </div>
</template>

<script setup lang="ts">
import { defineProps } from 'vue';
import { useRouter } from 'vue-router';
import type { Avatar } from '../stores/avatarsStore';

const props = defineProps<{
  avatar: Avatar;
}>();

const router = useRouter();

function startChat() {
  router.push({ name: 'Chat', params: { id: props.avatar.id } });
}
</script>

<style scoped>
.avatar-card {
  /* Add styles for avatar card */
  display: flex;
  flex-direction: column;
  align-items: center;
}
</style>
