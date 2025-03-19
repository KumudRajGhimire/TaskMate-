buildscript {
    repositories {
        google()
        mavenCentral()
    }

    dependencies {
        classpath("com.android.tools.build:gradle:7.3.0") // Or newer version
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:1.8.20") // Or newer version
        classpath("com.google.gms:google-services:4.4.0") // Or newer version
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

plugins {
    id("com.android.application") version "8.7.0" apply false // Or newer version
    id("org.jetbrains.kotlin.android") version "1.8.22" apply false // Or newer version
}

// Ensure the Google Services plugin is applied in the app-level build.gradle.kts
// The plugin application in the root build.gradle.kts is not necessary.
// If you have specific build directory customizations, please provide details.
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}