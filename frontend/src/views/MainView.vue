<template>
    <div class="main-view">
      <!-- Barre latérale des avatars -->
      <aside class="avatar-list">
        <div class="header">
          <h2>Chats</h2>
          <button @click="openNewChatModal" class="new-chat-button">+</button>
        </div>
        <div 
          v-for="avatar in avatars" 
          :key="avatar.id" 
          @click="selectAvatar(avatar)" 
          :class="{ active: selectedAvatar?.id === avatar.id }" 
          class="avatar-item"
        >
          <img :src="avatar.image" alt="Avatar Image" />
          <div class="avatar-info">
            <h3>{{ avatar.name }}</h3>
            <p>{{ avatar.description }}</p>
          </div>
        </div>
      </aside>
  
      <!-- Fenêtre de chat -->
      <section class="chat-window" v-if="selectedAvatar">
        <h2>Chat with {{ selectedAvatar.name }}</h2>
        <div class="chat-messages">
          <div 
            v-for="message in messages" 
            :key="message.id" 
            :class="{'user-message': message.sender === 'user', 'avatar-message': message.sender === 'avatar'}"
          >
            <p>{{ message.text }}</p>
          </div>
        </div>
        <form @submit.prevent="sendMessage" class="message-input">
          <input v-model="newMessage" placeholder="Type your message..." />
          <button type="submit">Send</button>
        </form>
      </section>
  
      <!-- Placeholder si aucun avatar n'est sélectionné -->
      <section class="chat-window" v-else>
        <p>Select an avatar to start a conversation</p>
      </section>
  
      <!-- Modal pour nouvelle conversation -->
      <NewChatModal 
        v-if="showNewChatModal" 
        @close="showNewChatModal = false" 
        @selectAvatar="startChatWithAvatar" 
        @avatarCreated="startChatWithAvatar" 
        />
    </div>
  </template>
  
  <script setup lang="ts">
  import { ref, computed } from 'vue';
  import { useAvatarsStore } from '../stores/avatarsStore';
  import NewChatModal from '../components/NewChatModal.vue';
  import type { Avatar } from '../stores/avatarsStore';
  
  const avatarsStore = useAvatarsStore();
  const avatars = avatarsStore.avatars;
  const selectedAvatar = ref<Avatar | null>(null);
  const newMessage = ref('');
  const showNewChatModal = ref(false);
  
  // Computed pour obtenir les messages de l'avatar sélectionné
  const messages = computed(() => selectedAvatar.value ? avatarsStore.getMessagesForAvatar(selectedAvatar.value.id) : []);
  
  // Ouvrir la modal pour une nouvelle conversation
  function openNewChatModal() {
    showNewChatModal.value = true;
  }
  
  // Fonction pour sélectionner un avatar
  function selectAvatar(avatar: Avatar) {
    selectedAvatar.value = avatar;
  }
  
  // Fonction pour démarrer une conversation avec un avatar existant
  function startChatWithAvatar(avatar: Avatar) {
    selectedAvatar.value = avatar;
    showNewChatModal.value = false;
  }
  
  // Fonction pour créer un nouvel avatar et démarrer une conversation
  function createNewAvatar(avatar: Avatar) {
    avatarsStore.addAvatar(avatar);
    startChatWithAvatar(avatar);
  }
  
  // Fonction pour envoyer un message
  function sendMessage() {
    if (newMessage.value.trim() && selectedAvatar.value) {
      avatarsStore.addMessage(selectedAvatar.value.id, { sender: 'user', text: newMessage.value });
      newMessage.value = '';
  
      // Réponse simulée de l'avatar
      setTimeout(() => {
        avatarsStore.addMessage(selectedAvatar.value.id, { sender: 'avatar', text: "Hello! How can I help you?" });
      }, 1000);
    }
  }
  </script>
  
  <style scoped>
  .main-view {
    display: flex;
    width: 100vw;
    height: 100vh;
    overflow: hidden;
  }
  
  .header {
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  
  .new-chat-button {
    font-size: 1.5rem;
    background-color: transparent;
    border: none;
    cursor: pointer;
  }
  
  .avatar-list {
    width: 30%;
    background-color: #f3f3f3;
    overflow-y: auto;
    padding: 1em;
    border-right: 1px solid #ddd;
  }
  
  .avatar-item {
    display: flex;
    align-items: center;
    padding: 0.5em;
    cursor: pointer;
    border-radius: 5px;
    transition: background-color 0.3s;
  }
  
  .avatar-item.active {
    background-color: #e0e0e0;
  }
  
  .avatar-item img {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    margin-right: 0.5em;
  }
  
  .avatar-info h3 {
    margin: 0;
    font-size: 1rem;
  }
  
  .chat-window {
    width: 70%;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    padding: 1em;
    background-color: #fff;
  }
  
  .chat-messages {
    flex: 1;
    overflow-y: auto;
    padding-right: 1em;
  }
  
  .user-message {
    text-align: right;
    background-color: #d1ffd1;
    margin: 0.5em;
    padding: 0.5em;
    border-radius: 10px;
  }
  
  .avatar-message {
    text-align: left;
    background-color: #ffd1d1;
    margin: 0.5em;
    padding: 0.5em;
    border-radius: 10px;
  }
  
  .message-input {
    display: flex;
    align-items: center;
    padding: 0.5em;
    border-top: 1px solid #ddd;
  }
  
  .message-input input {
    flex: 1;
    padding: 0.5em;
    border-radius: 5px;
    border: 1px solid #ccc;
    margin-right: 0.5em;
  }
  
  .message-input button {
    padding: 0.5em 1em;
    border-radius: 5px;
    border: none;
    background-color: #4caf50;
    color: white;
    cursor: pointer;
  }
  </style>
  