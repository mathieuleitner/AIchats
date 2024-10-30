<template>
  <form @submit.prevent="handleSubmit" class="avatar-form">
    <label for="name">Name:</label>
    <input v-model="name" type="text" id="name" required />

    <label for="image">Image URL:</label>
    <input v-model="image" type="url" id="image" placeholder="Enter image URL" />

    <label for="description">Description:</label>
    <input v-model="description" type="text" id="description" />

    <label for="type">Type:</label>
    <select v-model="type" id="type">
      <option value="formel">Formal</option>
      <option value="amical">Friendly</option>
      <option value="informatif">Informative</option>
    </select>

    <button type="submit">Save Avatar</button>
  </form>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { useAvatarsStore } from '../stores/avatarsStore';

// Access the store
const avatarsStore = useAvatarsStore();
const emit = defineEmits(['avatarCreated']);

// Form fields
const name = ref('');
const image = ref('');
const description = ref('');
const type = ref('formel');

// Handle form submission to add a new avatar
function handleSubmit() {
  const newAvatar = {
    id: Date.now(),
    name: name.value,
    image: image.value || 'https://via.placeholder.com/40', // Default image if none provided
    description: description.value,
    type: type.value,
  };

  // Call the store action to add the avatar
  avatarsStore.addAvatar(newAvatar);

  // Emit the new avatar to parent
  emit('avatarCreated', newAvatar);

  // Reset the form fields
  name.value = '';
  image.value = '';
  description.value = '';
  type.value = 'formel';
}
</script>

<style scoped>
.avatar-form {
  display: flex;
  flex-direction: column;
  gap: 1em;
}
</style>
