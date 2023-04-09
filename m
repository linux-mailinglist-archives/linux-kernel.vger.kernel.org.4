Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D1F6DC0B5
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 18:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjDIQsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 12:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjDIQsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 12:48:14 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEDFED;
        Sun,  9 Apr 2023 09:48:12 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1842f32d7bbso3592864fac.12;
        Sun, 09 Apr 2023 09:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681058892;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=27Nh1orxWxpofpp1LsxB+R25nNiKmed7mJb+CBNTat4=;
        b=Bw+7MN3MddvLKETVXqi4vcmDmn7XXvltw3TZDObelDMthHOfiIQoE4b/FYLB0UNKk/
         vLEZef1qv+rZK8ig/nS7hR+XML2yg9ptlttMvdc0MA2XXylyqXzLkotA7nsx8dZjQeqG
         7sn20VKAhuPNaQQc7U142WHYFz/+2SFllS/DO+TjKdRQw68qMVHRqCsx1rAirpKIT5ai
         mEVjwj7ZhKA6N+VOskFxDuNyKsDUqCIzXNy7iv0rh5Lb5fFRjQgQBFQ0VG2V8UDcEYS9
         aV+0p54NhCL68LzEOrijQw5fW+pmsBo0IHLIFaasJlJ2ICD8/6l15er9syf19iPrUrlf
         /rvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681058892;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=27Nh1orxWxpofpp1LsxB+R25nNiKmed7mJb+CBNTat4=;
        b=r7IJY+F4iba7KSkD7mFhbULIZyq+xTcrQciM6pwjPsJxjYnWHU/bY5k7Zo4yRC0pcH
         W5GbJRzREyhKtYz53sRO1JJxySw020em0KpIXKqnPvHG6KAFuynDOVkA4x40AP1oN+Pl
         IqwhIrRbFDZ224nFH3aomUhXJydeBRi/6yjaYN1dAv82vK1kyy1CntqnF+lb+7fQZ19J
         I2T1NteK5KMB6Ofm1tPu0kUlcq7F7Zdiu8ASCgXMEY2RwBNnvKAHf+nf0wEVNzKJwpvW
         asqgbgXCMTZGhUU7+D6hg5jVl7AhD9o7OgCYiwc5pcap3CV0QwPs/L4igTaCFKzU11Jy
         nApQ==
X-Gm-Message-State: AAQBX9c9CSs9aHlfmlI0hkyddO4DlRyOvVgGx7g62eyxCuBiwAbMhWRD
        lYOP2mZHxE93uW6kgOiCVAE=
X-Google-Smtp-Source: AKy350YWZ35MaFDy+R8VwZYM0CBsVhyfjL4QqsWQKwL8K4mi7N5OdU21YGEDJ2WPk8PPvj0tLNJY8Q==
X-Received: by 2002:a05:6870:418e:b0:17e:99a9:f997 with SMTP id y14-20020a056870418e00b0017e99a9f997mr2869280oac.54.1681058892075;
        Sun, 09 Apr 2023 09:48:12 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id j13-20020a9d7f0d000000b00690dc5d9b9esm3550171otq.6.2023.04.09.09.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Apr 2023 09:48:11 -0700 (PDT)
Message-ID: <9596d82a-4e70-c6be-6c37-519401815e32@gmail.com>
Date:   Sun, 9 Apr 2023 13:48:07 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH v3 05/13] rust: lock: introduce `SpinLock`
To:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
References: <20230408075340.25237-1-wedsonaf@gmail.com>
 <20230408075340.25237-5-wedsonaf@gmail.com>
Content-Language: en-US
In-Reply-To: <20230408075340.25237-5-wedsonaf@gmail.com>
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
> This is the `spinlock_t` lock backend and allows Rust code to use the
> kernel spinlock idiomatically.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
> v1 -> v2: No changes
> v2 -> v3: No changes
> 
>  rust/helpers.c                    |  24 +++++++
>  rust/kernel/sync.rs               |   2 +-
>  rust/kernel/sync/lock.rs          |   1 +
>  rust/kernel/sync/lock/spinlock.rs | 116 ++++++++++++++++++++++++++++++
>  4 files changed, 142 insertions(+), 1 deletion(-)
>  create mode 100644 rust/kernel/sync/lock/spinlock.rs
> 
> diff --git a/rust/helpers.c b/rust/helpers.c
> index 3010a2ec26e2..05694e3f8f70 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -22,6 +22,7 @@
>  #include <linux/build_bug.h>
>  #include <linux/refcount.h>
>  #include <linux/mutex.h>
> +#include <linux/spinlock.h>
>  
>  __noreturn void rust_helper_BUG(void)
>  {
> @@ -35,6 +36,29 @@ void rust_helper_mutex_lock(struct mutex *lock)
>  }
>  EXPORT_SYMBOL_GPL(rust_helper_mutex_lock);
>  
> +void rust_helper___spin_lock_init(spinlock_t *lock, const char *name,
> +				  struct lock_class_key *key)
> +{
> +#ifdef CONFIG_DEBUG_SPINLOCK
> +	spin_lock_init_with_key(lock, name, key);
> +#else
> +	spin_lock_init(lock);
> +#endif
> +}
> +EXPORT_SYMBOL_GPL(rust_helper___spin_lock_init);
> +
> +void rust_helper_spin_lock(spinlock_t *lock)
> +{
> +	spin_lock(lock);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_spin_lock);
> +
> +void rust_helper_spin_unlock(spinlock_t *lock)
> +{
> +	spin_unlock(lock);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_spin_unlock);
> +
>  refcount_t rust_helper_REFCOUNT_INIT(int n)
>  {
>  	return (refcount_t)REFCOUNT_INIT(n);
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index 693f0b7f4e4f..c997ff7e951e 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -11,7 +11,7 @@ mod arc;
>  pub mod lock;
>  
>  pub use arc::{Arc, ArcBorrow, UniqueArc};
> -pub use lock::mutex::Mutex;
> +pub use lock::{mutex::Mutex, spinlock::SpinLock};
>  
>  /// Represents a lockdep class. It's a wrapper around C's `lock_class_key`.
>  #[repr(transparent)]
> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> index 86669f771ee0..df43dff5af5c 100644
> --- a/rust/kernel/sync/lock.rs
> +++ b/rust/kernel/sync/lock.rs
> @@ -11,6 +11,7 @@ use core::{cell::UnsafeCell, marker::PhantomData, marker::PhantomPinned};
>  use macros::pin_data;
>  
>  pub mod mutex;
> +pub mod spinlock;
>  
>  /// The "backend" of a lock.
>  ///
> diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/spinlock.rs
> new file mode 100644
> index 000000000000..a52d20fc9755
> --- /dev/null
> +++ b/rust/kernel/sync/lock/spinlock.rs
> @@ -0,0 +1,116 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! A kernel spinlock.
> +//!
> +//! This module allows Rust code to use the kernel's `spinlock_t`.
> +
> +use crate::bindings;
> +
> +/// Creates a [`SpinLock`] initialiser with the given name and a newly-created lock class.
> +///
> +/// It uses the name if one is given, otherwise it generates one based on the file name and line
> +/// number.
> +#[macro_export]
> +macro_rules! new_spinlock {
> +    ($inner:expr $(, $name:literal)? $(,)?) => {
> +        $crate::sync::SpinLock::new(
> +            $inner, $crate::optional_name!($($name)?), $crate::static_lock_class!())
> +    };
> +}
> +
> +/// A spinlock.
> +///
> +/// Exposes the kernel's [`spinlock_t`]. When multiple CPUs attempt to lock the same spinlock, only
> +/// one at a time is allowed to progress, the others will block (spinning) until the spinlock is
> +/// unlocked, at which point another CPU will be allowed to make progress.
> +///
> +/// Instances of [`SpinLock`] need a lock class and to be pinned. The recommended way to create such
> +/// instances is with the [`pin_init`](crate::pin_init) and [`new_spinlock`] macros.
> +///
> +/// # Examples
> +///
> +/// The following example shows how to declare, allocate and initialise a struct (`Example`) that
> +/// contains an inner struct (`Inner`) that is protected by a spinlock.
> +///
> +/// ```
> +/// use kernel::{init::InPlaceInit, init::PinInit, new_spinlock, pin_init, sync::SpinLock};
> +///
> +/// struct Inner {
> +///     a: u32,
> +///     b: u32,
> +/// }
> +///
> +/// #[pin_data]
> +/// struct Example {
> +///     c: u32,
> +///     #[pin]
> +///     d: SpinLock<Inner>,
> +/// }
> +///
> +/// impl Example {
> +///     fn new() -> impl PinInit<Self> {
> +///         pin_init!(Self {
> +///             c: 10,
> +///             d <- new_spinlock!(Inner { a: 20, b: 30 }),
> +///         })
> +///     }
> +/// }
> +///
> +/// // Allocate a boxed `Example`.
> +/// let e = Box::pin_init(Example::new())?;
> +/// assert_eq!(e.c, 10);
> +/// assert_eq!(e.d.lock().a, 20);
> +/// assert_eq!(e.d.lock().b, 30);
> +/// ```
> +///
> +/// The following example shows how to use interior mutability to modify the contents of a struct
> +/// protected by a spinlock despite only having a shared reference:
> +///
> +/// ```
> +/// use kernel::sync::SpinLock;
> +///
> +/// struct Example {
> +///     a: u32,
> +///     b: u32,
> +/// }
> +///
> +/// fn example(m: &SpinLock<Example>) {
> +///     let mut guard = m.lock();
> +///     guard.a += 10;
> +///     guard.b += 20;
> +/// }
> +/// ```
> +///
> +/// [`spinlock_t`]: ../../../../include/linux/spinlock.h
> +pub type SpinLock<T> = super::Lock<T, SpinLockBackend>;
> +
> +/// A kernel `spinlock_t` lock backend.
> +pub struct SpinLockBackend;
> +
> +// SAFETY: The underlying kernel `spinlock_t` object ensures mutual exclusion.
> +unsafe impl super::Backend for SpinLockBackend {
> +    type State = bindings::spinlock_t;
> +    type GuardState = ();
> +
> +    unsafe fn init(
> +        ptr: *mut Self::State,
> +        name: *const core::ffi::c_char,
> +        key: *mut bindings::lock_class_key,
> +    ) {
> +        // SAFETY: The safety requirements ensure that `ptr` is valid for writes, and `name` and
> +        // `key` are valid for read indefinitely.
> +        unsafe { bindings::__spin_lock_init(ptr, name, key) }
> +    }
> +
> +    unsafe fn lock(ptr: *mut Self::State) -> Self::GuardState {
> +        // SAFETY: The safety requirements of this function ensure that `ptr` points to valid
> +        // memory, and that it has been initialised before.
> +        unsafe { bindings::spin_lock(ptr) }
> +    }
> +
> +    unsafe fn unlock(ptr: *mut Self::State, _guard_state: &Self::GuardState) {
> +        // SAFETY: The safety requirements of this function ensure that `ptr` is valid and that the
> +        // caller is the owner of the mutex.
> +        unsafe { bindings::spin_unlock(ptr) }
> +    }
> +}

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
