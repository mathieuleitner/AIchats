<template>
    <div>
      <h2>Chat avec {{ avatar?.name }}</h2>
      <div class="chat-messages">
        <div v-for="message in messages" :key="message.id" :class="{'user-message': message.sender === 'user', 'avatar-message': message.sender === 'avatar'}">
          <p>{{ message.text }}</p>
        </div>
      </div>
      <form @submit.prevent="sendMessage">
        <input v-model="newMessage" placeholder="Type your message..." />
        <button type="submit">Send</button>
      </form>
    </div>
  </template>
  
  <script setup lang="ts">
  import { ref, onMounted } from 'vue';
  import { useRoute } from 'vue-router';
  import { useAvatarsStore } from '../stores/avatarsStore';
  
  const avatarsStore = useAvatarsStore();
  const route = useRoute();
  
  const avatarId = parseInt(route.params.id as string);
  const avatar = avatarsStore.getAvatarById(avatarId);
  const messages = ref(avatarsStore.getMessagesForAvatar(avatarId));
  
  const newMessage = ref('');
  
  function sendMessage() {
    if (newMessage.value.trim()) {
      avatarsStore.addMessage(avatarId, { sender: 'user', text: newMessage.value });
      newMessage.value = '';
  
      // Simulate a response from the avatar AI (for demonstration)
      setTimeout(() => {
        avatarsStore.addMessage(avatarId, { sender: 'avatar', text: "Hello! How can I help you?" });
      }, 1000);
    }
  }
  </script>
  
  <style scoped>
  .chat-messages {
    max-height: 60vh;
    overflow-y: auto;
    padding: 1em;
  }
  .user-message {
    text-align: right;
    background-color: #d1ffd1;
  }
  .avatar-message {
    text-align: left;
    background-color: #ffd1d1;
  }
  </style>
  