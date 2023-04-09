Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958676DC0B1
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 18:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjDIQrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 12:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDIQrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 12:47:23 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AF43AB8;
        Sun,  9 Apr 2023 09:47:20 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1842e8a8825so3652751fac.13;
        Sun, 09 Apr 2023 09:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681058840;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=boobaPNQlEOaqevol7Ar9+noZtwaxD9UOPd5sZLi+Z4=;
        b=E0ZRme1I8nty/wKqdLORiWAYryJXPzbHr73ic5oKkuj+hgvs4CdZ8b/QiA4p4JBJL8
         afINpOvmp9tsiT8O6wles1KVrQB24JZ/3U5gENU1NX/oL2Y+LgLID63y8bSzcvz8BNB6
         XjRwnoEJ0TDwAHuZGGaXzLQHfIPUNmwvfMLC6EwuWsVFaNoRKjjoeAxaOdWZqXseVtHJ
         6s5y3wIvmBH5c3aLs7/6p71Z/IsrQC2A7/2Kc4NFypjzOIN3yI9KCj2Dj5BqGBjhD+90
         x6xCVbQ05gORPxVP3E+nmExZ9ASI/Je0X1G6zNBvrPXF04CMCLbHaXFkYK+iCvBOxaol
         0tsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681058840;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=boobaPNQlEOaqevol7Ar9+noZtwaxD9UOPd5sZLi+Z4=;
        b=jHeYR/LgNf1uhC7x2nX1nCV9i7JNBLxwLYzvBWlrhjclBY02OcI8z4cUQD3i8EwW8p
         kgVnRTcmV+aTWSy6w9dwC57wks8yI9lX7qMtrKbO+CIKYUVYiyvwHS2l0Kd3/G+ljmAa
         9fp/xy5QWBdYZJLGMu5XSKMvfNZvnAVUWnwCJ6q3QUdgTHBxrfAOROLAnMq3SlNy4+zr
         ja+iFsDAIWvCW78Xw7mu5EZFwQsdt22lLcQaH7C4mBDEnKF2hchwGQ07CUtPNTE7QI9R
         PIZfBrU0eg4egYG0n/9Hsf4BNbbARCATJeeg+7CyYiCHzmfMegyoA3S/UKjFdxjT7xGI
         h24A==
X-Gm-Message-State: AAQBX9ekU/nJtl8aJ8ZW9mNFJm4/baVAKTYSjY7ns6+S5a6TBLvGUz6j
        4Eyi5XEhn0OG1XxuSLZrbaODWQTtY3A=
X-Google-Smtp-Source: AKy350aXeSKI7ec/WDWDcMSXqBZ+tgFZn6i5EcOkc4A2K1EzyT2QRt0e1sKmrT2cEZFlVYgvUjM9mw==
X-Received: by 2002:a05:6870:972c:b0:184:a61:f400 with SMTP id n44-20020a056870972c00b001840a61f400mr2542375oaq.35.1681058840024;
        Sun, 09 Apr 2023 09:47:20 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id r20-20020a9d7cd4000000b0069fb87285fdsm3488761otn.59.2023.04.09.09.47.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Apr 2023 09:47:19 -0700 (PDT)
Message-ID: <50d1083b-10a4-941a-7e50-2aa0b6eb3867@gmail.com>
Date:   Sun, 9 Apr 2023 13:47:16 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH v3 02/13] rust: sync: introduce `Lock` and `Guard`
To:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
References: <20230408075340.25237-1-wedsonaf@gmail.com>
 <20230408075340.25237-2-wedsonaf@gmail.com>
Content-Language: en-US
In-Reply-To: <20230408075340.25237-2-wedsonaf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/23 04:53, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> They are generic Rust implementations of a lock and a lock guard that
> contain code that is common to all locks. Different backends will be
> introduced in subsequent commits.
> 
> Suggested-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
> v1 -> v2: No changes
> v2 -> v3: Use new Opaque::ffi_init from Benno's series
> 
>  rust/kernel/sync.rs      |   2 +-
>  rust/kernel/sync/lock.rs | 162 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 163 insertions(+), 1 deletion(-)
>  create mode 100644 rust/kernel/sync/lock.rs
> 
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index 541d235ffbeb..81b0998eaa18 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -8,6 +8,7 @@
>  use crate::types::Opaque;
>  
>  mod arc;
> +pub mod lock;
>  
>  pub use arc::{Arc, ArcBorrow, UniqueArc};
>  
> @@ -25,7 +26,6 @@ impl LockClassKey {
>          Self(Opaque::uninit())
>      }
>  
> -    #[allow(dead_code)]
>      pub(crate) fn as_ptr(&self) -> *mut bindings::lock_class_key {
>          self.0.get()
>      }
> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> new file mode 100644
> index 000000000000..3fa4eefde740
> --- /dev/null
> +++ b/rust/kernel/sync/lock.rs
> @@ -0,0 +1,162 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Generic kernel lock and guard.
> +//!
> +//! It contains a generic Rust lock and guard that allow for different backends (e.g., mutexes,
> +//! spinlocks, raw spinlocks) to be provided with minimal effort.
> +
> +use super::LockClassKey;
> +use crate::{bindings, init::PinInit, pin_init, str::CStr, types::Opaque};
> +use core::{cell::UnsafeCell, marker::PhantomData, marker::PhantomPinned};
> +use macros::pin_data;
> +
> +/// The "backend" of a lock.
> +///
> +/// It is the actual implementation of the lock, without the need to repeat patterns used in all
> +/// locks.
> +///
> +/// # Safety
> +///
> +/// - Implementers must ensure that only one thread/CPU may access the protected data once the lock
> +/// is owned, that is, between calls to `lock` and `unlock`.
> +pub unsafe trait Backend {
> +    /// The state required by the lock.
> +    type State;
> +
> +    /// The state required to be kept between lock and unlock.
> +    type GuardState;
> +
> +    /// Initialises the lock.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must be valid for write for the duration of the call, while `name` and `key` must
> +    /// remain valid for read indefinitely.
> +    unsafe fn init(
> +        ptr: *mut Self::State,
> +        name: *const core::ffi::c_char,
> +        key: *mut bindings::lock_class_key,
> +    );
> +
> +    /// Acquires the lock, making the caller its owner.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that [`Backend::init`] has been previously called.
> +    #[must_use]
> +    unsafe fn lock(ptr: *mut Self::State) -> Self::GuardState;
> +
> +    /// Releases the lock, giving up its ownership.
> +    ///
> +    /// # Safety
> +    ///
> +    /// It must only be called by the current owner of the lock.
> +    unsafe fn unlock(ptr: *mut Self::State, guard_state: &Self::GuardState);
> +}
> +
> +/// A mutual exclusion primitive.
> +///
> +/// Exposes one of the kernel locking primitives. Which one is exposed depends on the lock banckend
> +/// specified as the generic parameter `T`.

I think this meant that it is specified by `B` and wraps `T`.

> +#[pin_data]
> +pub struct Lock<T: ?Sized, B: Backend> {
> +    /// The kernel lock object.
> +    #[pin]
> +    state: Opaque<B::State>,
> +
> +    /// Some locks are known to be self-referential (e.g., mutexes), while others are architecture
> +    /// or config defined (e.g., spinlocks). So we conservatively require them to be pinned in case
> +    /// some architecture uses self-references now or in the future.
> +    #[pin]
> +    _pin: PhantomPinned,
> +
> +    /// The data protected by the lock.
> +    data: UnsafeCell<T>,
> +}
> +
> +// SAFETY: `Lock` can be transferred across thread boundaries iff the data it protects can.
> +unsafe impl<T: ?Sized + Send, B: Backend> Send for Lock<T, B> {}
> +
> +// SAFETY: `Lock` serialises the interior mutability it provides, so it is `Sync` as long as the
> +// data it protects is `Send`.
> +unsafe impl<T: ?Sized + Send, B: Backend> Sync for Lock<T, B> {}
> +
> +impl<T, B: Backend> Lock<T, B> {
> +    /// Constructs a new lock initialiser.
> +    #[allow(clippy::new_ret_no_self)]
> +    pub fn new(t: T, name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self> {
> +        pin_init!(Self {
> +            data: UnsafeCell::new(t),
> +            _pin: PhantomPinned,
> +            // SAFETY: `slot` is valid while the closure is called and both `name` and `key` have
> +            // static lifetimes so they live indefinitely.
> +            state <- Opaque::ffi_init(|slot| unsafe {
> +                B::init(slot, name.as_char_ptr(), key.as_ptr())
> +            }),
> +        })
> +    }
> +}
> +
> +impl<T: ?Sized, B: Backend> Lock<T, B> {
> +    /// Acquires the lock and gives the caller access to the data protected by it.
> +    pub fn lock(&self) -> Guard<'_, T, B> {
> +        // SAFETY: The constructor of the type calls `init`, so the existence of the object proves
> +        // that `init` was called.
> +        let state = unsafe { B::lock(self.state.get()) };
> +        // SAFETY: The lock was just acquired.
> +        unsafe { Guard::new(self, state) }
> +    }
> +}
> +
> +/// A lock guard.
> +///
> +/// Allows mutual exclusion primitives that implement the `Backend` trait to automatically unlock
> +/// when a guard goes out of scope. It also provides a safe and convenient way to access the data
> +/// protected by the lock.
> +#[must_use = "the lock unlocks immediately when the guard is unused"]
> +pub struct Guard<'a, T: ?Sized, B: Backend> {
> +    pub(crate) lock: &'a Lock<T, B>,
> +    pub(crate) state: B::GuardState,
> +    _not_send: PhantomData<*mut ()>,
> +}
> +
> +// SAFETY: `Guard` is sync when the data protected by the lock is also sync.
> +unsafe impl<T: Sync + ?Sized, B: Backend> Sync for Guard<'_, T, B> {}
> +
> +impl<T: ?Sized, B: Backend> core::ops::Deref for Guard<'_, T, B> {
> +    type Target = T;
> +
> +    fn deref(&self) -> &Self::Target {
> +        // SAFETY: The caller owns the lock, so it is safe to deref the protected data.
> +        unsafe { &*self.lock.data.get() }
> +    }
> +}
> +
> +impl<T: ?Sized, B: Backend> core::ops::DerefMut for Guard<'_, T, B> {
> +    fn deref_mut(&mut self) -> &mut Self::Target {
> +        // SAFETY: The caller owns the lock, so it is safe to deref the protected data.
> +        unsafe { &mut *self.lock.data.get() }
> +    }
> +}
> +
> +impl<T: ?Sized, B: Backend> Drop for Guard<'_, T, B> {
> +    fn drop(&mut self) {
> +        // SAFETY: The caller owns the lock, so it is safe to unlock it.
> +        unsafe { B::unlock(self.lock.state.get(), &self.state) };
> +    }
> +}
> +
> +impl<'a, T: ?Sized, B: Backend> Guard<'a, T, B> {
> +    /// Constructs a new immutable lock guard.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that it owns the lock.
> +    pub(crate) unsafe fn new(lock: &'a Lock<T, B>, state: B::GuardState) -> Self {
> +        Self {
> +            lock,
> +            state,
> +            _not_send: PhantomData,
> +        }
> +    }
> +}

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
