// Copyright (c) 2012 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// This file is autogenerated by
//     base/android/jni_generator/jni_generator.py
// For
//     org/chromium/base/SystemMonitor

#ifndef org_chromium_base_SystemMonitor_JNI
#define org_chromium_base_SystemMonitor_JNI

#include <jni.h>

#include "base/android/jni_android.h"
#include "base/android/scoped_java_ref.h"
#include "base/basictypes.h"
#include "base/logging.h"

using base::android::ScopedJavaLocalRef;

// Step 1: forward declarations.
namespace {
const char kSystemMonitorClassPath[] = "org/chromium/base/SystemMonitor";
// Leaking this jclass as we cannot use LazyInstance from some threads.
jclass g_SystemMonitor_clazz = NULL;
}  // namespace

namespace base {
namespace android {

static void OnBatteryChargingChanged(JNIEnv* env, jclass clazz);

// Step 2: method stubs.

static base::subtle::AtomicWord g_SystemMonitor_isBatteryPower = 0;
static jboolean Java_SystemMonitor_isBatteryPower(JNIEnv* env) {
  /* Must call RegisterNativesImpl()  */
  DCHECK(g_SystemMonitor_clazz);
  jmethodID method_id =
      base::android::MethodID::LazyGet<
      base::android::MethodID::TYPE_STATIC>(
      env, g_SystemMonitor_clazz,
      "isBatteryPower",

"("
")"
"Z",
      &g_SystemMonitor_isBatteryPower);

  jboolean ret =
    env->CallStaticBooleanMethod(g_SystemMonitor_clazz,
      method_id);
  base::android::CheckException(env);
  return ret;
}

// Step 3: RegisterNatives.

static bool RegisterNativesImpl(JNIEnv* env) {

  g_SystemMonitor_clazz = reinterpret_cast<jclass>(env->NewGlobalRef(
      base::android::GetUnscopedClass(env, kSystemMonitorClassPath)));
  static const JNINativeMethod kMethodsSystemMonitor[] = {
    { "nativeOnBatteryChargingChanged",
"("
")"
"V", reinterpret_cast<void*>(OnBatteryChargingChanged) },
  };
  const int kMethodsSystemMonitorSize = arraysize(kMethodsSystemMonitor);

  if (env->RegisterNatives(g_SystemMonitor_clazz,
                           kMethodsSystemMonitor,
                           kMethodsSystemMonitorSize) < 0) {
    LOG(ERROR) << "RegisterNatives failed in " << __FILE__;
    return false;
  }

  return true;
}
}  // namespace android
}  // namespace base

#endif  // org_chromium_base_SystemMonitor_JNI