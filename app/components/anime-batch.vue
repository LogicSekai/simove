<script setup lang="ts">
import AnimeBatchCard from './anime-side-card.vue'

const props = defineProps({
    isloading: {
        type: Boolean,
        default: true
    },
    anime: {
        type: Object,
        required: true
    }
})

const config = useAppConfig()

// const animeBatch = ref({
//     isLoading: true,
//     data: []
// })

// const fetchAnimeBatch = async () => {
//     animeBatch.value.isLoading = true
//     try {
//         const res = <any>await $fetch(config.uri + '/anime/complete') // Ganti dengan API kamu
//         animeBatch.value.data = res.data
//     } catch (error) {
//         console.error('Fetch failed:', error)
//     } finally {
//         animeBatch.value.isLoading = false
//     }
// }

onMounted(() => {
    // fetchAnimeBatch()
})
</script>

<template>
    <div>
        <!-- Header Card -->
        <div class="bg-card text-card-foreground flex flex-col gap-6 border shadow-sm py-0 px-4 rounded-md rounded-b-none md-4 mb-1">
            <div class="@container/card-header auto-rows-min grid-rows-[auto_auto] gap-1.5 has-data-[slot=card-action]:grid-cols-[1fr_auto] [.border-b]:pb-6 px-0 flex justify-between items-center">
                <div class="leading-none font-semibold py-2">Completed Batch</div>
            </div>
        </div>
        <!-- Content -->
        <div class="bg-card text-card-foreground flex flex-col gap-6 border shadow-sm p-4 rounded-md rounded-t-none md-4 mb-1">
            <div class="px-0">
                <div class="flex flex-col">
                    <div v-if="isloading" class="animate-pulse flex space-x-4">
                        <div class="rounded bg-gray-300 h-16 w-16"></div>
                        <div class="flex-1 space-y-4 py-1">
                            <div class="h-4 bg-gray-300 rounded w-3/4"></div>
                            <div class="h-4 bg-gray-300 rounded w-1/2"></div>
                        </div>
                    </div>
                    <template v-else>
                        <AnimeBatchCard v-for="(item, index) in anime" :key="index" :anime="item" :last-item="Number(index) === anime.length - 1" />
                    </template>
                </div>
            </div>
        </div>
    </div>
</template>