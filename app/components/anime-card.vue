<script setup lang="ts">
const props = defineProps({
    anime: {
        type: Object,
        required: true
    }
})

const config = useAppConfig()
</script>

<template>
    <div class="overflow-hidden">
        <!-- Thumbnail -->
        <div class="relative w-full rounded-md overflow-hidden group pb-[150%]">
            <NuxtLink :to="anime.link">
                <img class="absolute top-0 left-0 w-full h-full object-fill transition-transform duration-300 group-hover:scale-110"
                :src="config.uri + anime.img" 
                :alt="anime.title">
                <div class="absolute top-0 left-0 w-full h-full" style="content: '';background: linear-gradient(0deg, oklch(0.145 0 0) 0px, rgba(32, 31, 49, 0) 40%);"></div>
            </NuxtLink>
            <div class="absolute top-0 left-0 w-full h-full">
                <span class="bg-black/50 text-white text-xs font-semibold py-2 px-4 rounded-br-2xl">{{ anime.episode }}</span>
            </div>
        </div>
        <!-- Title -->
        <div class="space-y-1 pt-2">
            <NuxtLink :to="anime.link">
                <p class="font-medium leading-tight truncate hover:text-primary">{{ anime.title }}</p>
            </NuxtLink>
            <div class="bg-card text-card-foreground flex flex-col gap-6 border shadow-sm py-1 px-2 mt-2 rounded-md">
                <NuxtLink :to="anime.link">
                    <p class="text-xs text-muted-foreground hover:text-primary flex justify-between">
                        <span>{{ anime.day }}</span>
                        <span class="ml-2 text-right text-xs">{{ anime.date }}</span>
                    </p>
                </NuxtLink>
            </div>
        </div>
    </div>
</template>