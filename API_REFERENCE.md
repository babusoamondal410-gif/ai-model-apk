# API Reference

## AIModelManager

Core class for managing PyTorch model loading and inference.

### Methods

#### `generateImageFromText(prompt: String): Bitmap?`
Generates an image from a text prompt using text-to-image model.

**Parameters:**
- `prompt` - Text description for image generation

**Returns:**
- `Bitmap` - Generated image or null if generation failed

**Example:**
```kotlin
val imageManager = DIContainer.getModelManager()
val bitmap = imageManager.generateImageFromText("A beautiful sunset over mountains")
```

---

#### `applyStyleTransfer(contentBitmap: Bitmap, styleBitmap: Bitmap): Bitmap?`
Applies style from one image to another.

**Parameters:**
- `contentBitmap` - The image to be styled
- `styleBitmap` - Reference image for style

**Returns:**
- `Bitmap` - Styled image or null if transfer failed

**Example:**
```kotlin
val contentBitmap = BitmapFactory.decodeFile("photo.jpg")
val styleBitmap = BitmapFactory.decodeFile("style.jpg")
val result = imageManager.applyStyleTransfer(contentBitmap, styleBitmap)
```

---

#### `enhanceImage(bitmap: Bitmap): Bitmap?`
Enhances image quality using AI algorithms.

**Parameters:**
- `bitmap` - Image to enhance

**Returns:**
- `Bitmap` - Enhanced image or null if enhancement failed

**Example:**
```kotlin
val enhanced = imageManager.enhanceImage(originalBitmap)
```

---

#### `getChatbotResponse(userInput: String): String`
Gets AI chatbot response for user input.

**Parameters:**
- `userInput` - User message

**Returns:**
- `String` - Chatbot response

**Example:**
```kotlin
val response = imageManager.getChatbotResponse("Hello, what can you do?")
println(response)
```

---

## ImageUtils

Utility functions for image file management.

### Methods

#### `saveBitmap(context: Context, bitmap: Bitmap, fileName: String): File?`
Saves bitmap to file system.

**Parameters:**
- `context` - Android context
- `bitmap` - Bitmap to save
- `fileName` - Optional custom filename

**Returns:**
- `File` - Saved file or null on error

---

#### `deleteImage(file: File): Boolean`
Deletes image file from storage.

**Parameters:**
- `file` - File to delete

**Returns:**
- `Boolean` - True if deletion successful

---

#### `getFileSizeString(file: File): String`
Gets formatted file size string.

**Parameters:**
- `file` - File to check

**Returns:**
- `String` - Formatted size (e.g., "2.5 MB")

---

#### `getTimestampString(): String`
Gets timestamp string for file naming.

**Returns:**
- `String` - Timestamp in format "yyyyMMdd_HHmmss"

---

#### `clearOldImages(context: Context, maxAgeHours: Int): Unit`
Clears cached images older than specified hours.

**Parameters:**
- `context` - Android context
- `maxAgeHours` - Age threshold in hours

---

## ShareUtils

Utilities for sharing images.

### Methods

#### `shareImage(context: Context, file: File, title: String): Unit`
Shares single image via intent.

**Parameters:**
- `context` - Android context
- `file` - Image file to share
- `title` - Share dialog title

---

#### `shareMultipleImages(context: Context, files: List<File>, title: String): Unit`
Shares multiple images via intent.

**Parameters:**
- `context` - Android context
- `files` - List of image files
- `title` - Share dialog title

---

#### `openImageInViewer(context: Context, file: File): Unit`
Opens image in external viewer app.

**Parameters:**
- `context` - Android context
- `file` - Image file to view

---

## ViewModels

### ImageGeneratorViewModel

Manages text-to-image generation state.

**Properties:**
```kotlin
val uiState: StateFlow<GeneratorUiState>
```

**Methods:**
```kotlin
fun generateImage(prompt: String)
fun clearState()
```

---

### StyleTransferViewModel

Manages style transfer state and operations.

**Methods:**
```kotlin
fun setContentImage(path: String)
fun setStyleImage(path: String)
fun applyStyleTransfer()
fun clearState()
```

---

### EnhancementViewModel

Manages image enhancement state.

**Methods:**
```kotlin
fun setImage(path: String)
fun setEnhancementLevel(level: Float)
fun enhanceImage()
fun clearState()
```

---

## Constants

### Permission Constants
```kotlin
PermissionUtils.CAMERA
PermissionUtils.READ_STORAGE
PermissionUtils.WRITE_STORAGE
PermissionUtils.INTERNET
```

### Model Types
```kotlin
AIModelManager.ModelType.TEXT_TO_IMAGE
AIModelManager.ModelType.STYLE_TRANSFER
AIModelManager.ModelType.IMAGE_ENHANCEMENT
AIModelManager.ModelType.CHATBOT
```

---

## Error Handling

All methods include try-catch blocks with Timber logging:

```kotlin
try {
    val result = imageManager.generateImageFromText(prompt)
} catch (e: Exception) {
    Timber.e(e, "Error generating image")
}
```

---

## Best Practices

1. **Always check null returns** - Methods may return null on error
2. **Use coroutines** - Long operations should run on background threads
3. **Log appropriately** - Use Timber for consistent logging
4. **Handle permissions** - Request permissions before file operations
5. **Memory management** - Clear caches regularly to prevent OOM

---

**Last Updated**: 2026-09-06
