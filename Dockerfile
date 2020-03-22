# This Dockerfile creates a static build image for the CI.
# The image will available at the Docker Hub registry.

FROM openjdk:11-jdk-buster

# Install required OS packages
RUN \
   apt-get update && \
   apt-get install --yes git wget apt-utils unzip make && \
   apt-get autoclean

# Must match version in file `app/build.gradle`
ENV ANDROID_COMPILE_SDK "28"
# Must match version in file `app/build.gradle`
ENV ANDROID_BUILD_TOOLS "28.0.3"
# See https://developer.android.com/studio/ for latest version
ENV ANDROID_SDK_TOOLS "6200805"
ENV ANDROID_HOME /usr/local/android-sdk
ENV PATH="${PATH}:${ANDROID_HOME}/tools/bin"
ENV SDK_MANAGER="sdkmanager --sdk_root=${ANDROID_HOME}"

# Install Android SDK tools
RUN mkdir -p ${ANDROID_HOME}
WORKDIR ${ANDROID_HOME}
RUN wget \
   --quiet \
   --output-document=android-sdk.zip \
   https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_SDK_TOOLS}_latest.zip && \
   unzip android-sdk.zip
WORKDIR /root
# Install Android packages
RUN echo y | ${SDK_MANAGER} --install \
   "platforms;android-${ANDROID_COMPILE_SDK}" \
   "platform-tools" \
   "build-tools;${ANDROID_BUILD_TOOLS}"
