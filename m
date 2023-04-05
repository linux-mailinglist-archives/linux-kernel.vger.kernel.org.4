Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3286D8540
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 19:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbjDERwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 13:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjDERv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 13:51:58 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBD66591;
        Wed,  5 Apr 2023 10:51:57 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id l18so27218462oic.13;
        Wed, 05 Apr 2023 10:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680717116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKPe4ZYrLaif7r3R3bAYVGcjt87OAmyTt+kMVWIS4fY=;
        b=qcz0U3y6hWuVizzxQUsKTB35TzlsMweQZ0HY8cickbzYT2OG6oK1yD8EiEHx+lygrq
         yR2N46drRxixL6+kFeymTN0aB6cGi+ttgwytfuRJzcdZc0DiV2NVHJOsr3UQyxw/vZJL
         hRaq/rGoFJWYubf8U5K6fM4Y/ikDpqi6WfH8C7uEvQxZTlT7XcpYO5oblhq5l/9yfMUc
         /O1b2HdJVb/Nkb9FYGBfP4jXxZv55ytFZp4VbUpfeTOpniklLI5pNj5Du7JPrISEY7Xo
         68viJPfjyNTY8jV8QBI+KdU1buQv9Gr5I2bKTkHSEsOZDBt4ZPCyd1yvmqZ9AaDBpffm
         zHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680717116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VKPe4ZYrLaif7r3R3bAYVGcjt87OAmyTt+kMVWIS4fY=;
        b=DS64XMf6Fd+XiEibCRnRpgKf5NatHwYejubJjLKHgzK4E5T4SZUkRcP3YgKgCqbACN
         UIxlByY3naCp6aOHxjEhlT4VTiMbficId9Dt++jUr1Kb7mfi3ZEsSsyxb9/hwRZhfcjs
         apyLD0zm1KOlZBdnVcogEntOdJY6M23zPfOZtlmw548/xdnIDkbX5+7cjz5OYfrmIZcy
         RHFYYES+qbH4MbQGds574S9DMhyHQSnFpjNG4G4VZw3or3CSW7tZg3md7DwYHhVe5nOh
         PUjrsHTswe4r1fYZFXezdTRYOvuTt5O//9Xo0Pj4mXUEGOJQOCoFi5jAyHf2PwFuy74i
         diDw==
X-Gm-Message-State: AAQBX9ewXxPF7ux9SIhGfwQnOSVtnLepbKOIk5qlmlpyU6Q1ZnsDpbfS
        1Q5QAXSw925bXyfkTdebrmGkK3wkytrlVw==
X-Google-Smtp-Source: AKy350YOeY5K3RN1N8zLNqlHQK8zaTzJp3C0n8VTTj1r/SFwLw3AVCSxvNRMaC2x7PCOeUIKcDwM4Q==
X-Received: by 2002:aca:3d84:0:b0:389:4bcf:83a5 with SMTP id k126-20020aca3d84000000b003894bcf83a5mr1674731oia.9.1680717114517;
        Wed, 05 Apr 2023 10:51:54 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id w185-20020aca62c2000000b003896e31867esm6604045oib.49.2023.04.05.10.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 10:51:54 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2 03/13] rust: lock: introduce `Mutex`
Date:   Wed,  5 Apr 2023 14:51:01 -0300
Message-Id: <20230405175111.5974-3-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230405175111.5974-1-wedsonaf@gmail.com>
References: <20230405175111.5974-1-wedsonaf@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wedson Almeida Filho <walmeida@microsoft.com>

This is the `struct mutex` lock backend and allows Rust code to use the
kernel mutex idiomatically.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
v1 -> v2: No changes

 rust/helpers.c                 |   7 ++
 rust/kernel/sync.rs            |   1 +
 rust/kernel/sync/lock.rs       |   2 +
 rust/kernel/sync/lock/mutex.rs | 118 +++++++++++++++++++++++++++++++++
 4 files changed, 128 insertions(+)
 create mode 100644 rust/kernel/sync/lock/mutex.rs

diff --git a/rust/helpers.c b/rust/helpers.c
index 09a4d93f9d62..3010a2ec26e2 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -21,6 +21,7 @@
 #include <linux/bug.h>
 #include <linux/build_bug.h>
 #include <linux/refcount.h>
+#include <linux/mutex.h>
 
 __noreturn void rust_helper_BUG(void)
 {
@@ -28,6 +29,12 @@ __noreturn void rust_helper_BUG(void)
 }
 EXPORT_SYMBOL_GPL(rust_helper_BUG);
 
+void rust_helper_mutex_lock(struct mutex *lock)
+{
+	mutex_lock(lock);
+}
+EXPORT_SYMBOL_GPL(rust_helper_mutex_lock);
+
 refcount_t rust_helper_REFCOUNT_INIT(int n)
 {
 	return (refcount_t)REFCOUNT_INIT(n);
diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index bf088b324af4..9ff116b2eebe 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -11,6 +11,7 @@ mod arc;
 pub mod lock;
 
 pub use arc::{Arc, ArcBorrow, UniqueArc};
+pub use lock::mutex::Mutex;
 
 /// Represents a lockdep class. It's a wrapper around C's `lock_class_key`.
 #[repr(transparent)]
diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index f5614bed2a78..cec1d68bab86 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -10,6 +10,8 @@ use crate::{bindings, init::PinInit, pin_init, str::CStr, types::Opaque};
 use core::{cell::UnsafeCell, marker::PhantomData, marker::PhantomPinned};
 use macros::pin_data;
 
+pub mod mutex;
+
 /// The "backend" of a lock.
 ///
 /// It is the actual implementation of the lock, without the need to repeat patterns used in all
diff --git a/rust/kernel/sync/lock/mutex.rs b/rust/kernel/sync/lock/mutex.rs
new file mode 100644
index 000000000000..923472f04af4
--- /dev/null
+++ b/rust/kernel/sync/lock/mutex.rs
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! A kernel mutex.
+//!
+//! This module allows Rust code to use the kernel's `struct mutex`.
+
+use crate::bindings;
+
+/// Creates a [`Mutex`] initialiser with the given name and a newly-created lock class.
+///
+/// It uses the name if one is given, otherwise it generates one based on the file name and line
+/// number.
+#[macro_export]
+macro_rules! new_mutex {
+    ($inner:expr $(, $name:literal)? $(,)?) => {
+        $crate::sync::Mutex::new(
+            $inner, $crate::optional_name!($($name)?), $crate::static_lock_class!())
+    };
+}
+
+/// A mutual exclusion primitive.
+///
+/// Exposes the kernel's [`struct mutex`]. When multiple threads attempt to lock the same mutex,
+/// only one at a time is allowed to progress, the others will block (sleep) until the mutex is
+/// unlocked, at which point another thread will be allowed to wake up and make progress.
+///
+/// Since it may block, [`Mutex`] needs to be used with care in atomic contexts.
+///
+/// Instances of [`Mutex`] need a lock class and to be pinned. The recommended way to create such
+/// instances is with the [`pin_init`](crate::pin_init) and [`new_mutex`] macros.
+///
+/// # Examples
+///
+/// The following example shows how to declare, allocate and initialise a struct (`Example`) that
+/// contains an inner struct (`Inner`) that is protected by a mutex.
+///
+/// ```
+/// use kernel::{init::InPlaceInit, init::PinInit, new_mutex, pin_init, sync::Mutex};
+///
+/// struct Inner {
+///     a: u32,
+///     b: u32,
+/// }
+///
+/// #[pin_data]
+/// struct Example {
+///     c: u32,
+///     #[pin]
+///     d: Mutex<Inner>,
+/// }
+///
+/// impl Example {
+///     fn new() -> impl PinInit<Self> {
+///         pin_init!(Self {
+///             c: 10,
+///             d <- new_mutex!(Inner { a: 20, b: 30 }),
+///         })
+///     }
+/// }
+///
+/// // Allocate a boxed `Example`.
+/// let e = Box::pin_init(Example::new())?;
+/// assert_eq!(e.c, 10);
+/// assert_eq!(e.d.lock().a, 20);
+/// assert_eq!(e.d.lock().b, 30);
+/// ```
+///
+/// The following example shows how to use interior mutability to modify the contents of a struct
+/// protected by a mutex despite only having a shared reference:
+///
+/// ```
+/// use kernel::sync::Mutex;
+///
+/// struct Example {
+///     a: u32,
+///     b: u32,
+/// }
+///
+/// fn example(m: &Mutex<Example>) {
+///     let mut guard = m.lock();
+///     guard.a += 10;
+///     guard.b += 20;
+/// }
+/// ```
+///
+/// [`struct mutex`]: ../../../../include/linux/mutex.h
+pub type Mutex<T> = super::Lock<T, MutexBackend>;
+
+/// A kernel `struct mutex` lock backend.
+pub struct MutexBackend;
+
+// SAFETY: The underlying kernel `struct mutex` object ensures mutual exclusion.
+unsafe impl super::Backend for MutexBackend {
+    type State = bindings::mutex;
+    type GuardState = ();
+
+    unsafe fn init(
+        ptr: *mut Self::State,
+        name: *const core::ffi::c_char,
+        key: *mut bindings::lock_class_key,
+    ) {
+        // SAFETY: The safety requirements ensure that `ptr` is valid for writes, and `name` and
+        // `key` are valid for read indefinitely.
+        unsafe { bindings::__mutex_init(ptr, name, key) }
+    }
+
+    unsafe fn lock(ptr: *mut Self::State) -> Self::GuardState {
+        // SAFETY: The safety requirements of this function ensure that `ptr` points to valid
+        // memory, and that it has been initialised before.
+        unsafe { bindings::mutex_lock(ptr) };
+    }
+
+    unsafe fn unlock(ptr: *mut Self::State, _guard_state: &Self::GuardState) {
+        // SAFETY: The safety requirements of this function ensure that `ptr` is valid and that the
+        // caller is the owner of the mutex.
+        unsafe { bindings::mutex_unlock(ptr) };
+    }
+}
-- 
2.34.1

