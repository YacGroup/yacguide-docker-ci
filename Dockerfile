# This Dockerfile creates a static build image for the CI.
# The image will available at the Docker Hub registry.

FROM debian:buster

RUN \
   apt-get update && \
   apt-get install -y locales git wget apt-utils unzip make bundler python3-minimal python3-git openjdk-11-jdk-headless && \
   apt-get autoremove -y && \
   apt-get autoclean && \
   apt-get clean && \
   rm -rf /tmp/* /var/tmp/*

RUN \
   echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
   locale-gen && \
   update-locale LANG="en_US.UTF-8"
ENV LANG=en_US.UTF-8

# Must match compileSdkVersion in file `app/build.gradle`
ENV ANDROID_COMPILE_SDK "29"
# Must match version in file `app/build.gradle`
ENV ANDROID_BUILD_TOOLS "29.0.2"
# See https://developer.android.com/studio#cmdline-tools for latest version
ENV ANDROID_CMDLINE_TOOLS "6609375"
ENV ANDROID_HOME /opt/android-sdk
ENV PATH="${PATH}:${ANDROID_HOME}/tools/bin"
ENV SDK_MANAGER="sdkmanager --sdk_root=${ANDROID_HOME}"

# Install Android SDK tools
RUN mkdir -p ${ANDROID_HOME}
WORKDIR ${ANDROID_HOME}
RUN wget \
   --quiet \
   --output-document=android-cmdline-tools.zip \
   https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_CMDLINE_TOOLS}_latest.zip && \
   unzip android-cmdline-tools.zip && \
   rm -f android-cmdline-tools.zip
WORKDIR /root
# Install Android packages
RUN echo y | ${SDK_MANAGER} --install \
   "platforms;android-${ANDROID_COMPILE_SDK}" \
   "platform-tools" \
   "build-tools;${ANDROID_BUILD_TOOLS}"
