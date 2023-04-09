Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053826DC0BF
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 18:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjDIQuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 12:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjDIQta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 12:49:30 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CED46AF;
        Sun,  9 Apr 2023 09:49:17 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1842d8976d9so3782596fac.9;
        Sun, 09 Apr 2023 09:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681058957;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kvxb9+KHkRjUHuphGDrS8hWOuQ8TSKu8ycWqVf/jXVo=;
        b=Es4POqYdJZkruJ4CjzbigN6pt4IyklMIk+ajE0XUX9yX8F9fpWzRGxZ/pGHg7XGge6
         WFgs2YNCPAsTK2kaGHK1oXBMghVzzs/+cFFpPLvPOGvLTAxTgCxhYJ+p6H8syZgjVTu3
         osvTUCvhljGwvRzO52iWjmJ7j9Vtd1KLCUtYzj0g4ajY3aywzYg4CfMMkgR2mirApYnP
         My+Jvu580hZ9rovs4jD4jKhzaThjTQPq7uTRFyL0mHpTQtKwvjxrnh5rZOQqKOJAhiyb
         TKtBZ7heKXXKVfAP/Ce6cRj+/7FWOvdGRT+BKrbMWZdn8Eng0VNDkn9VOGhHEltuXhaw
         WwGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681058957;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kvxb9+KHkRjUHuphGDrS8hWOuQ8TSKu8ycWqVf/jXVo=;
        b=bRvxdvlIB0zJCMDKaCpWWJ2VwbXuHgbo4l/XJkeqWcC/UT11h4uzW33rmzdgdfdU4F
         Oq4VrrVpYGmxQW6oudMSNOCn6EfEsfc6IH36s0JH6FRxC2yAwLroluJhUPkj4s1DGwVu
         VQq9OUwHS7vrXMxw6oJaEFkUrjrjBuqw7MHLN59PavC5rBQg596KnEq194WhbHTE8ejF
         Vp/w+WepzVx3s2EreLALUsFpsilyPSu5I5dv1BQ3gQ7D28nOqdxeX2W7oXAbpejXIt/k
         W/GKu1ObvemHR4YnUCzVL7Fl2XvtcKFdZ790vZ4xPiLSJGLLNCQbfBb9tLIw/D/iDsai
         EOKA==
X-Gm-Message-State: AAQBX9fXy9LQhB9hqidDONcLzqe0uDld4MGi1gUoUswqU1Kbjodd9B8m
        U8RFEMGgb+Kz7izD46T94UUosHO8YE0=
X-Google-Smtp-Source: AKy350aERvOn+irpRsjyE/uPUTxsaO3hu5ctDi6ZEeEy5EiIXOf5S4c1tHRZHXIC4m/9cBzVzm1IHA==
X-Received: by 2002:a05:6870:b28f:b0:177:8cf4:33 with SMTP id c15-20020a056870b28f00b001778cf40033mr4972375oao.52.1681058956897;
        Sun, 09 Apr 2023 09:49:16 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id zd19-20020a056871279300b0017703b8a5f8sm3268302oab.49.2023.04.09.09.49.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Apr 2023 09:49:16 -0700 (PDT)
Message-ID: <d33c531d-f707-bb29-9220-ced717079fbd@gmail.com>
Date:   Sun, 9 Apr 2023 13:49:12 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH v3 12/13] rust: sync: introduce `CondVar`
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
 <20230408075340.25237-12-wedsonaf@gmail.com>
Content-Language: en-US
In-Reply-To: <20230408075340.25237-12-wedsonaf@gmail.com>
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
> This is the traditional condition variable or monitor synchronisation
> primitive. It is implemented with C's `wait_queue_head_t`.
> 
> It allows users to release a lock and go to sleep while guaranteeing
> that notifications won't be missed. This is achieved by enqueuing a wait
> entry before releasing the lock.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
> v1 -> v2: Use the new `current` macro
> v2 -> v3: Use new Opaque::ffi_init from Benno's series
> 
>  rust/bindings/bindings_helper.h |   1 +
>  rust/helpers.c                  |   7 ++
>  rust/kernel/sync.rs             |   2 +
>  rust/kernel/sync/condvar.rs     | 174 ++++++++++++++++++++++++++++++++
>  rust/kernel/sync/lock.rs        |   1 -
>  5 files changed, 184 insertions(+), 1 deletion(-)
>  create mode 100644 rust/kernel/sync/condvar.rs
> 
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index 03656a44a83f..50e7a76d5455 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -8,6 +8,7 @@
>  
>  #include <linux/slab.h>
>  #include <linux/refcount.h>
> +#include <linux/wait.h>
>  #include <linux/sched.h>
>  
>  /* `bindgen` gets confused at certain things. */
> diff --git a/rust/helpers.c b/rust/helpers.c
> index 96441744030e..8ff2559c1572 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -24,6 +24,7 @@
>  #include <linux/mutex.h>
>  #include <linux/spinlock.h>
>  #include <linux/sched/signal.h>
> +#include <linux/wait.h>
>  
>  __noreturn void rust_helper_BUG(void)
>  {
> @@ -76,6 +77,12 @@ void rust_helper_spin_unlock_irqrestore(spinlock_t *lock, unsigned long flags)
>  }
>  EXPORT_SYMBOL_GPL(rust_helper_spin_unlock_irqrestore);
>  
> +void rust_helper_init_wait(struct wait_queue_entry *wq_entry)
> +{
> +	init_wait(wq_entry);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_init_wait);
> +
>  int rust_helper_signal_pending(struct task_struct *t)
>  {
>  	return signal_pending(t);
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index c997ff7e951e..431402180aa8 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -8,9 +8,11 @@
>  use crate::types::Opaque;
>  
>  mod arc;
> +mod condvar;
>  pub mod lock;
>  
>  pub use arc::{Arc, ArcBorrow, UniqueArc};
> +pub use condvar::CondVar;
>  pub use lock::{mutex::Mutex, spinlock::SpinLock};
>  
>  /// Represents a lockdep class. It's a wrapper around C's `lock_class_key`.
> diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
> new file mode 100644
> index 000000000000..ef882e2af746
> --- /dev/null
> +++ b/rust/kernel/sync/condvar.rs
> @@ -0,0 +1,174 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! A condition variable.
> +//!
> +//! This module allows Rust code to use the kernel's [`struct wait_queue_head`] as a condition
> +//! variable.
> +
> +use super::{lock::Backend, lock::Guard, LockClassKey};
> +use crate::{bindings, init::PinInit, pin_init, str::CStr, types::Opaque};
> +use core::marker::PhantomPinned;
> +use macros::pin_data;
> +
> +/// Creates a [`CondVar`] initialiser with the given name and a newly-created lock class.
> +#[macro_export]
> +macro_rules! new_condvar {
> +    ($($name:literal)?) => {
> +        $crate::sync::CondVar::new($crate::optional_name!($($name)?), $crate::static_lock_class!())
> +    };
> +}
> +
> +/// A conditional variable.
> +///
> +/// Exposes the kernel's [`struct wait_queue_head`] as a condition variable. It allows the caller to
> +/// atomically release the given lock and go to sleep. It reacquires the lock when it wakes up. And
> +/// it wakes up when notified by another thread (via [`CondVar::notify_one`] or
> +/// [`CondVar::notify_all`]) or because the thread received a signal. It may also wake up
> +/// spuriously.
> +///
> +/// Instances of [`CondVar`] need a lock class and to be pinned. The recommended way to create such
> +/// instances is with the [`pin_init`](crate::pin_init) and [`new_condvar`] macros.
> +///
> +/// # Examples
> +///
> +/// The following is an example of using a condvar with a mutex:
> +///
> +/// ```
> +/// use kernel::sync::{CondVar, Mutex};
> +/// use kernel::{new_condvar, new_mutex};
> +///
> +/// #[pin_data]
> +/// pub struct Example {
> +///     #[pin]
> +///     value: Mutex<u32>,
> +///
> +///     #[pin]
> +///     value_changed: CondVar,
> +/// }
> +///
> +/// /// Waits for `e.value` to become `v`.
> +/// fn wait_for_vaue(e: &Example, v: u32) {

Should it be `wait_for_value`?

> +///     let mut guard = e.value.lock();
> +///     while *guard != v {
> +///         e.value_changed.wait_uninterruptible(&mut guard);
> +///     }
> +/// }
> +///
> +/// /// Increments `e.value` and notifies all potential waiters.
> +/// fn increment(e: &Example) {
> +///     *e.value.lock() += 1;
> +///     e.value_changed.notify_all();
> +/// }
> +///
> +/// /// Allocates a new boxed `Example`.
> +/// fn new_example() -> Result<Pin<Box<Example>>> {
> +///     Box::pin_init(pin_init!(Example {
> +///         value <- new_mutex!(0),
> +///         value_changed <- new_condvar!(),
> +///     }))
> +/// }
> +/// ```
> +///
> +/// [`struct wait_queue_head`]: ../../../include/linux/wait.h
> +#[pin_data]
> +pub struct CondVar {
> +    #[pin]
> +    pub(crate) wait_list: Opaque<bindings::wait_queue_head>,
> +
> +    /// A condvar needs to be pinned because it contains a [`struct list_head`] that is
> +    /// self-referential, so it cannot be safely moved once it is initialised.
> +    #[pin]
> +    _pin: PhantomPinned,
> +}
> +
> +// SAFETY: `CondVar` only uses a `struct wait_queue_head`, which is safe to use on any thread.
> +#[allow(clippy::non_send_fields_in_send_ty)]
> +unsafe impl Send for CondVar {}
> +
> +// SAFETY: `CondVar` only uses a `struct wait_queue_head`, which is safe to use on multiple threads
> +// concurrently.
> +unsafe impl Sync for CondVar {}
> +
> +impl CondVar {
> +    /// Constructs a new condvar initialiser.
> +    #[allow(clippy::new_ret_no_self)]
> +    pub fn new(name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self> {
> +        pin_init!(Self {
> +            _pin: PhantomPinned,
> +            // SAFETY: `slot` is valid while the closure is called and both `name` and `key` have
> +            // static lifetimes so they live indefinitely.
> +            wait_list <- Opaque::ffi_init(|slot| unsafe {
> +                bindings::__init_waitqueue_head(slot, name.as_char_ptr(), key.as_ptr())
> +            }),
> +        })
> +    }
> +
> +    fn wait_internal<T: ?Sized, B: Backend>(&self, wait_state: u32, guard: &mut Guard<'_, T, B>) {
> +        let wait = Opaque::<bindings::wait_queue_entry>::uninit();
> +
> +        // SAFETY: `wait` points to valid memory.
> +        unsafe { bindings::init_wait(wait.get()) };
> +
> +        // SAFETY: Both `wait` and `wait_list` point to valid memory.
> +        unsafe {
> +            bindings::prepare_to_wait_exclusive(self.wait_list.get(), wait.get(), wait_state as _)
> +        };
> +
> +        // SAFETY: No arguments, switches to another thread.
> +        guard.do_unlocked(|| unsafe { bindings::schedule() });
> +
> +        // SAFETY: Both `wait` and `wait_list` point to valid memory.
> +        unsafe { bindings::finish_wait(self.wait_list.get(), wait.get()) };
> +    }
> +
> +    /// Releases the lock and waits for a notification in interruptible mode.
> +    ///
> +    /// Atomically releases the given lock (whose ownership is proven by the guard) and puts the
> +    /// thread to sleep, reacquiring the lock on wake up. It wakes up when notified by
> +    /// [`CondVar::notify_one`] or [`CondVar::notify_all`], or when the thread receives a signal.
> +    /// It may also wake up spuriously.
> +    ///
> +    /// Returns whether there is a signal pending.
> +    #[must_use = "wait returns if a signal is pending, so the caller must check the return value"]
> +    pub fn wait<T: ?Sized, B: Backend>(&self, guard: &mut Guard<'_, T, B>) -> bool {
> +        self.wait_internal(bindings::TASK_INTERRUPTIBLE, guard);
> +        crate::current!().signal_pending()
> +    }
> +
> +    /// Releases the lock and waits for a notification in uninterruptible mode.
> +    ///
> +    /// Similar to [`CondVar::wait`], except that the wait is not interruptible. That is, the
> +    /// thread won't wake up due to signals. It may, however, wake up supirously.
> +    pub fn wait_uninterruptible<T: ?Sized, B: Backend>(&self, guard: &mut Guard<'_, T, B>) {
> +        self.wait_internal(bindings::TASK_UNINTERRUPTIBLE, guard)
> +    }
> +
> +    /// Calls the kernel function to notify the appropriate number of threads with the given flags.
> +    fn notify(&self, count: i32, flags: u32) {
> +        // SAFETY: `wait_list` points to valid memory.
> +        unsafe {
> +            bindings::__wake_up(
> +                self.wait_list.get(),
> +                bindings::TASK_NORMAL,
> +                count,
> +                flags as _,
> +            )
> +        };
> +    }
> +
> +    /// Wakes a single waiter up, if any.
> +    ///
> +    /// This is not 'sticky' in the sense that if no thread is waiting, the notification is lost
> +    /// completely (as opposed to automatically waking up the next waiter).
> +    pub fn notify_one(&self) {
> +        self.notify(1, 0);
> +    }
> +
> +    /// Wakes all waiters up, if any.
> +    ///
> +    /// This is not 'sticky' in the sense that if no thread is waiting, the notification is lost
> +    /// completely (as opposed to automatically waking up the next waiter).
> +    pub fn notify_all(&self) {
> +        self.notify(0, 0);
> +    }
> +}
> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> index a2c654ec5bd3..c365bc909dff 100644
> --- a/rust/kernel/sync/lock.rs
> +++ b/rust/kernel/sync/lock.rs
> @@ -179,7 +179,6 @@ pub struct Guard<'a, T: ?Sized, B: Backend> {
>  unsafe impl<T: Sync + ?Sized, B: Backend> Sync for Guard<'_, T, B> {}
>  
>  impl<T: ?Sized, B: Backend> Guard<'_, T, B> {
> -    #[allow(dead_code)]
>      pub(crate) fn do_unlocked(&mut self, cb: impl FnOnce()) {
>          // SAFETY: The caller owns the lock, so it is safe to unlock it.
>          unsafe { B::unlock(self.lock.state.get(), &self.state) };

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
