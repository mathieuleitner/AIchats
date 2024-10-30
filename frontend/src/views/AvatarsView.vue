<template>
  <div>
    <h1>Liste des Avatars</h1>
    <AvatarForm :avatarToEdit="avatarToEdit" /> <!-- Formulaire pour ajouter ou éditer -->
    <div class="avatar-list">
      <AvatarCard
        v-for="avatar in avatars"
        :key="avatar.id"
        :avatar="avatar"
        @edit="editAvatar"
      />
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { useAvatarsStore } from '../stores/avatarsStore';
import AvatarForm from '../components/AvatarForm.vue';
import AvatarCard from '../components/AvatarCard.vue';
import type { Avatar } from '../stores/avatarsStore';

const avatarsStore = useAvatarsStore();
const avatars = avatarsStore.avatars;
const avatarToEdit = ref<Avatar | null>(null); // Avatar sélectionné pour édition

function editAvatar(avatar: Avatar) {
  avatarToEdit.value = avatar;
}
</script>

<style scoped>
.avatar-list {
  display: flex;
  flex-wrap: wrap;
  gap: 16px;
}
</style>
