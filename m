Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622006DC0B2
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 18:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjDIQrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 12:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDIQro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 12:47:44 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3711B3C30;
        Sun,  9 Apr 2023 09:47:39 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-183f4efa98aso9782369fac.2;
        Sun, 09 Apr 2023 09:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681058858;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=deA2mG9P5Qv3+gcJzpwWMdasscdax3dDxfQYVedCOVY=;
        b=ThOz8KWz4qaPGD5i8q2f+g6qAC3p4ylA+XwTKBmZObncjG+iTN/ykrhTtTxNy/5lXM
         b8NVEiem01hj8FxjdVu2mAmXbe+sAlbUnwkt0zmAipauFOdcI6/QhOxDjMjvhINyvnZO
         NFdld0vIHVnz7kG0l2i7U+MvHrAjh9efJZR7ZBpsGXh+GJuFfhkHOZhnLsrN9Puv18mH
         e6Wo4pAVOYLoAiR+EBPKiRs+ctkxOnlXWZyacs7FMXbpCE8SIzhaSoZKyaVcj8gC8erg
         ocbbeX/Lxrllap4ODS/YQomazLEr7q79RFpViWN8wYZwwCNlQ8i6ghCgB+Dhw/x05D8K
         IEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681058858;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=deA2mG9P5Qv3+gcJzpwWMdasscdax3dDxfQYVedCOVY=;
        b=Kz9v+AcXQb5bvTgbcMb2HzCi2lqgp+6euwtixE+BVf9oScWvvmKXu9go5FUvGXgCwL
         8WJta8UdGu+AQ6At3A2xRiKFT1iYcudNnpGph7uRTreqRBugF6hD5cxK9wnqUpn/9Ynz
         tWFETrdZLt+/QhecsnwKS7G2Q5cQ6IULzXWcyvISdlohioWyqKSQ/SDAcdJsWLSaNcbO
         993q9SnJaNL8IlaIWd+TlpB1ABzz/EYXfVtB+SUlljG11Ku/l10g8l3G0kNe/Gh/FTAJ
         8VAEpq7WFEWG0NsunD8Tmv6uGUgALF+zd9/tMlrh67K9Lv6uVr/ugJC5N0xe03Qviv6e
         A/3w==
X-Gm-Message-State: AAQBX9f7N57FQh9SFK8SFsn54XfY/jXekSyloO/1nRB4mf8HZ71JQp7b
        T2nar2fs9r9un8tqaj0nDfY=
X-Google-Smtp-Source: AKy350aIoRM3P+1KsU7TjpArMkRj0cUkiHp2+VtNTNb2UjmOJoAeIV56CrKY8AY5An8z6hvQS5p+Sg==
X-Received: by 2002:a05:6870:b003:b0:177:80e4:9a52 with SMTP id y3-20020a056870b00300b0017780e49a52mr4372910oae.6.1681058858329;
        Sun, 09 Apr 2023 09:47:38 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id yx21-20020a056871251500b001842bb0a01csm1396748oab.27.2023.04.09.09.47.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Apr 2023 09:47:37 -0700 (PDT)
Message-ID: <3a08f406-c71e-c012-a8f3-c2048952e195@gmail.com>
Date:   Sun, 9 Apr 2023 13:47:34 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH v3 03/13] rust: lock: introduce `Mutex`
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
 <20230408075340.25237-3-wedsonaf@gmail.com>
Content-Language: en-US
In-Reply-To: <20230408075340.25237-3-wedsonaf@gmail.com>
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
> This is the `struct mutex` lock backend and allows Rust code to use the
> kernel mutex idiomatically.
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
>  rust/helpers.c                 |   7 ++
>  rust/kernel/sync.rs            |   1 +
>  rust/kernel/sync/lock.rs       |   2 +
>  rust/kernel/sync/lock/mutex.rs | 118 +++++++++++++++++++++++++++++++++
>  4 files changed, 128 insertions(+)
>  create mode 100644 rust/kernel/sync/lock/mutex.rs
> 
> diff --git a/rust/helpers.c b/rust/helpers.c
> index 09a4d93f9d62..3010a2ec26e2 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -21,6 +21,7 @@
>  #include <linux/bug.h>
>  #include <linux/build_bug.h>
>  #include <linux/refcount.h>
> +#include <linux/mutex.h>
>  
>  __noreturn void rust_helper_BUG(void)
>  {
> @@ -28,6 +29,12 @@ __noreturn void rust_helper_BUG(void)
>  }
>  EXPORT_SYMBOL_GPL(rust_helper_BUG);
>  
> +void rust_helper_mutex_lock(struct mutex *lock)
> +{
> +	mutex_lock(lock);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_mutex_lock);
> +
>  refcount_t rust_helper_REFCOUNT_INIT(int n)
>  {
>  	return (refcount_t)REFCOUNT_INIT(n);
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index 81b0998eaa18..693f0b7f4e4f 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -11,6 +11,7 @@ mod arc;
>  pub mod lock;
>  
>  pub use arc::{Arc, ArcBorrow, UniqueArc};
> +pub use lock::mutex::Mutex;
>  
>  /// Represents a lockdep class. It's a wrapper around C's `lock_class_key`.
>  #[repr(transparent)]
> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> index 3fa4eefde740..86669f771ee0 100644
> --- a/rust/kernel/sync/lock.rs
> +++ b/rust/kernel/sync/lock.rs
> @@ -10,6 +10,8 @@ use crate::{bindings, init::PinInit, pin_init, str::CStr, types::Opaque};
>  use core::{cell::UnsafeCell, marker::PhantomData, marker::PhantomPinned};
>  use macros::pin_data;
>  
> +pub mod mutex;
> +
>  /// The "backend" of a lock.
>  ///
>  /// It is the actual implementation of the lock, without the need to repeat patterns used in all
> diff --git a/rust/kernel/sync/lock/mutex.rs b/rust/kernel/sync/lock/mutex.rs
> new file mode 100644
> index 000000000000..923472f04af4
> --- /dev/null
> +++ b/rust/kernel/sync/lock/mutex.rs
> @@ -0,0 +1,118 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! A kernel mutex.
> +//!
> +//! This module allows Rust code to use the kernel's `struct mutex`.
> +
> +use crate::bindings;
> +
> +/// Creates a [`Mutex`] initialiser with the given name and a newly-created lock class.
> +///
> +/// It uses the name if one is given, otherwise it generates one based on the file name and line
> +/// number.
> +#[macro_export]
> +macro_rules! new_mutex {
> +    ($inner:expr $(, $name:literal)? $(,)?) => {
> +        $crate::sync::Mutex::new(
> +            $inner, $crate::optional_name!($($name)?), $crate::static_lock_class!())
> +    };
> +}
> +
> +/// A mutual exclusion primitive.
> +///
> +/// Exposes the kernel's [`struct mutex`]. When multiple threads attempt to lock the same mutex,
> +/// only one at a time is allowed to progress, the others will block (sleep) until the mutex is
> +/// unlocked, at which point another thread will be allowed to wake up and make progress.
> +///
> +/// Since it may block, [`Mutex`] needs to be used with care in atomic contexts.
> +///
> +/// Instances of [`Mutex`] need a lock class and to be pinned. The recommended way to create such
> +/// instances is with the [`pin_init`](crate::pin_init) and [`new_mutex`] macros.
> +///
> +/// # Examples
> +///
> +/// The following example shows how to declare, allocate and initialise a struct (`Example`) that
> +/// contains an inner struct (`Inner`) that is protected by a mutex.
> +///
> +/// ```
> +/// use kernel::{init::InPlaceInit, init::PinInit, new_mutex, pin_init, sync::Mutex};
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
> +///     d: Mutex<Inner>,
> +/// }
> +///
> +/// impl Example {
> +///     fn new() -> impl PinInit<Self> {
> +///         pin_init!(Self {
> +///             c: 10,
> +///             d <- new_mutex!(Inner { a: 20, b: 30 }),
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
> +/// protected by a mutex despite only having a shared reference:
> +///
> +/// ```
> +/// use kernel::sync::Mutex;
> +///
> +/// struct Example {
> +///     a: u32,
> +///     b: u32,
> +/// }
> +///
> +/// fn example(m: &Mutex<Example>) {
> +///     let mut guard = m.lock();
> +///     guard.a += 10;
> +///     guard.b += 20;
> +/// }
> +/// ```
> +///
> +/// [`struct mutex`]: ../../../../include/linux/mutex.h
> +pub type Mutex<T> = super::Lock<T, MutexBackend>;
> +
> +/// A kernel `struct mutex` lock backend.
> +pub struct MutexBackend;
> +
> +// SAFETY: The underlying kernel `struct mutex` object ensures mutual exclusion.
> +unsafe impl super::Backend for MutexBackend {
> +    type State = bindings::mutex;
> +    type GuardState = ();
> +
> +    unsafe fn init(
> +        ptr: *mut Self::State,
> +        name: *const core::ffi::c_char,
> +        key: *mut bindings::lock_class_key,
> +    ) {
> +        // SAFETY: The safety requirements ensure that `ptr` is valid for writes, and `name` and
> +        // `key` are valid for read indefinitely.
> +        unsafe { bindings::__mutex_init(ptr, name, key) }
> +    }
> +
> +    unsafe fn lock(ptr: *mut Self::State) -> Self::GuardState {
> +        // SAFETY: The safety requirements of this function ensure that `ptr` points to valid
> +        // memory, and that it has been initialised before.
> +        unsafe { bindings::mutex_lock(ptr) };
> +    }
> +
> +    unsafe fn unlock(ptr: *mut Self::State, _guard_state: &Self::GuardState) {
> +        // SAFETY: The safety requirements of this function ensure that `ptr` is valid and that the
> +        // caller is the owner of the mutex.
> +        unsafe { bindings::mutex_unlock(ptr) };
> +    }
> +}

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
