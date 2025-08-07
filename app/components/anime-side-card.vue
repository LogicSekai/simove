<script setup lang="ts">
const props = defineProps({
    anime: {
        type: Object,
        required: true
    },
    lastItem: {
        type: Boolean,
        default: false
    }
})

const config = useAppConfig()
</script>

<template>
    <div class="flex items-start gap-2">
        <NuxtLink :to="anime.link">
            <div class="relative w-16 h-24 rounded-md overflow-hidden group pb-[150%]">
                <img :src="config.uri + anime.img" :alt="anime.title"
                class="absolute top-0 left-0 w-full h-full object-fill transition-transform duration-300 group-hover:scale-110">
            </div>
        </NuxtLink>
        <div class="flex flex-col flex-grow overflow-hidden">
            <NuxtLink :to="anime.link">
                <p class="text-sm font-medium leading-tight line-clamp-2 hover:text-primary overflow-hidden">{{ anime.title }}</p>
            </NuxtLink>
            <div v-if="anime.episode && anime.score && anime.date" class="text-xs mt-1 gap-1">
                <div>
                    <span class="text-muted-foreground font-semibold pr-1">Total Episode:</span>
                    <NuxtLink :to="anime.link">
                        <span class="hover:underline hover:text-primary cursor-pointer">{{ anime.episode }}</span>
                    </NuxtLink>
                </div>
                <div>
                    <span class="text-muted-foreground font-semibold pr-1">Mal Score:</span>
                    <NuxtLink :to="anime.link">
                        <span class="hover:underline hover:text-primary cursor-pointer">{{ anime.score }}</span>
                    </NuxtLink>
                </div>
                <div>
                    <span class="text-muted-foreground font-semibold pr-1">Last Update:</span>
                    <NuxtLink :to="anime.link">
                        <span class="hover:underline hover:text-primary cursor-pointer">{{ anime.date }}</span>
                    </NuxtLink>
                </div>
            </div>
        </div>
    </div>
    <div v-if="!lastItem" class="border-b border-muted-foreground/10 my-2"></div>
</template>