<template>
    <div class="modal">
      <div class="modal-content">
        <!-- En-tête dynamique en fonction du mode -->
        <h2 v-if="!showAvatarForm">Select an Avatar</h2>
        <h2 v-else>Create a New Avatar</h2>
  
        <!-- Liste des avatars existants -->
        <div v-if="!showAvatarForm">
          <div v-for="avatar in avatars" :key="avatar.id" class="avatar-option" @click="selectAvatar(avatar)">
            <img :src="avatar.image" alt="Avatar Image" />
            <span>{{ avatar.name }}</span>
          </div>
          <button @click="toggleAvatarForm">Create New Avatar</button>
        </div>
  
        <!-- Formulaire de création d'avatar -->
        <AvatarForm v-else @avatarCreated="handleAvatarCreated" />
  
        <!-- Bouton de fermeture de la modal -->
        <button @click="$emit('close')" class="close-button">Close</button>
      </div>
    </div>
  </template>
  
  <script setup lang="ts">
  import { ref } from 'vue';
  import { useAvatarsStore } from '../stores/avatarsStore';
  import type { Avatar } from '../stores/avatarsStore';
  import AvatarForm from './AvatarForm.vue';
  
  // Obtenir les avatars existants depuis le store
  const avatarsStore = useAvatarsStore();
  const avatars = avatarsStore.avatars;
  const emit = defineEmits(['selectAvatar', 'close']);
  
  // État pour basculer entre le formulaire et la sélection d'avatars
  const showAvatarForm = ref(false);
  
  // Sélectionner un avatar existant
  function selectAvatar(avatar: Avatar) {
    emit('selectAvatar', avatar);
  }
  
  // Basculer entre le formulaire de création et la liste d'avatars
  function toggleAvatarForm() {
    showAvatarForm.value = !showAvatarForm.value;
  }
  
  // Gérer la création d'un nouvel avatar
  function handleAvatarCreated(avatar: Avatar) {
    emit('selectAvatar', avatar); // Démarrer la conversation avec le nouvel avatar
    showAvatarForm.value = false; // Retour à la sélection d'avatars
  }
  </script>
  
  <style scoped>
  .modal {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(0, 0, 0, 0.6);
    display: flex;
    align-items: center;
    justify-content: center;
  }
  
  .modal-content {
    background: white;
    padding: 20px;
    border-radius: 8px;
    width: 300px;
    text-align: center;
  }
  
  .avatar-option {
    display: flex;
    align-items: center;
    padding: 0.5em;
    cursor: pointer;
    border-bottom: 1px solid #ddd;
  }
  
  .avatar-option img {
    width: 40px;
    height: 40px;
    margin-right: 10px;
  }
  
  .close-button {
    margin-top: 1em;
    background-color: #d9534f;
    color: white;
    border: none;
    padding: 0.5em 1em;
    cursor: pointer;
  }
  </style>
  