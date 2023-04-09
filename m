Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516656DC0BD
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 18:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjDIQti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 12:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjDIQtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 12:49:18 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F17A46A2;
        Sun,  9 Apr 2023 09:49:07 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-184518754bfso68341fac.5;
        Sun, 09 Apr 2023 09:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681058946;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DICVUfZYlg7r0nNlRNpMmQdzRa8vktIIBq9q8+zULqs=;
        b=W+15LSdAza08N20QgufShdsDE3YMgIXarC8xdS2yOkiH1bGnsLtCZAcl5JTmNlZ8XZ
         4DAIA0Tn7IiXLuDqei7jKsxt4WwaGYrUo5eiNJKsdKNngANxl/+DPRhS7ZuMetbv8xjd
         StscMMpvf/CPItiGUX91SDMezetKoN6nyBSYnyOMI4837qPSaTZ3RP7yKKDrGrWgT2XL
         4MeWY1yJozLv0kL5YgGLg41yXcbnAFcD5gDxaA0aKNlILNHGcXGM3qSPf9NJlPuHHCGx
         csQclkaBMd1apoSwzsW20gA7h2q4sv7SDYazb+hFimrnD4HAOWgIVqxP2yuq08FkPVdp
         lrGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681058946;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DICVUfZYlg7r0nNlRNpMmQdzRa8vktIIBq9q8+zULqs=;
        b=HmUKREMRh26NwfFgJneU9iYNR63IzXPYdXBoMxUyFPIuOArCYzMH9DxmSiXaKcauOd
         J+StV8MY15Q/K2c/AgR1oqygchLNwydYbF4B0dpUIYF0468FEjY+oIUTogar4WdZiYWt
         L3QPk0C+sVIFUFAwv95F/6GAssWg/u5Xy6cCu5kLjNkl5zv1uyLZcL6qSzy45HPtvWMX
         Y60CbDJAbVo2OBRidkMW3YQ6mxNeMA6CxyglBNPcg55DmLUW9h7B4icOqkS3PkFtRjmJ
         fgpBBjHUzk8pnUJjsFfCFGeOrxep5mvEJx3b1EF6iX6nN4VK7U5PcRDyTdVkTGxTEf6j
         wVlQ==
X-Gm-Message-State: AAQBX9co/K+iI8HA5nrQVtg2gTcj1Sa4QzpWmpJSYFC+CKWDBhwR3FSs
        BzFa9pgkd7kvkNqOgDwhcJE=
X-Google-Smtp-Source: AKy350ZrqNL1tEdHRn48TlanYOryefDOgaLc++9b4OJB+s6SD0zWm5P0mKcgx62JN4Usfd/eOgupKg==
X-Received: by 2002:a05:6870:7394:b0:17a:c102:b449 with SMTP id z20-20020a056870739400b0017ac102b449mr5032408oam.59.1681058946656;
        Sun, 09 Apr 2023 09:49:06 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id j2-20020a056830014200b0069faca091acsm3513411otp.54.2023.04.09.09.49.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Apr 2023 09:49:06 -0700 (PDT)
Message-ID: <3f16d076-c7f9-be33-74e0-2b86fcd5a22d@gmail.com>
Date:   Sun, 9 Apr 2023 13:49:03 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH v3 11/13] rust: lock: add `Guard::do_unlocked`
To:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
References: <20230408075340.25237-1-wedsonaf@gmail.com>
 <20230408075340.25237-11-wedsonaf@gmail.com>
Content-Language: en-US
In-Reply-To: <20230408075340.25237-11-wedsonaf@gmail.com>
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
> It releases the lock, executes some function provided by the caller,
> then reacquires the lock. This is preparation for the implementation of
> condvars, which will sleep after between unlocking and relocking.
> 
> We need an explicit `relock` method for primitives like `SpinLock` that
> have an irqsave variant: we use the guard state to determine if the lock
> was originally acquired with the regular `lock` function or
> `lock_irqsave`.
> 
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
> v1 -> v2: No changes
> v2 -> v3: No changes
> 
>  rust/kernel/sync/lock.rs          | 25 +++++++++++++++++++++++++
>  rust/kernel/sync/lock/spinlock.rs | 17 +++++++++++++++--
>  2 files changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> index 690429561f0e..a2c654ec5bd3 100644
> --- a/rust/kernel/sync/lock.rs
> +++ b/rust/kernel/sync/lock.rs
> @@ -22,6 +22,9 @@ pub mod spinlock;
>  ///
>  /// - Implementers must ensure that only one thread/CPU may access the protected data once the lock
>  /// is owned, that is, between calls to `lock` and `unlock`.
> +/// - Implementers must also ensure that `relock` uses the same locking method as the original
> +/// lock operation. For example, it should disable interrupts if [`IrqSaveBackend::lock_irqsave`]
> +/// is used.
>  pub unsafe trait Backend {
>      /// The state required by the lock.
>      type State;
> @@ -55,6 +58,17 @@ pub unsafe trait Backend {
>      ///
>      /// It must only be called by the current owner of the lock.
>      unsafe fn unlock(ptr: *mut Self::State, guard_state: &Self::GuardState);
> +
> +    /// Reacquires the lock, making the caller its owner.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that `state` comes from a previous call to [`Backend::lock`] (or
> +    /// variant) that has been unlocked with [`Backend::unlock`] and will be relocked now.
> +    unsafe fn relock(ptr: *mut Self::State, guard_state: &mut Self::GuardState) {
> +        // SAFETY: The safety requirements ensure that the lock is initialised.
> +        *guard_state = unsafe { Self::lock(ptr) };
> +    }
>  }
>  
>  /// The "backend" of a lock that supports the irq-save variant.
> @@ -164,6 +178,17 @@ pub struct Guard<'a, T: ?Sized, B: Backend> {
>  // SAFETY: `Guard` is sync when the data protected by the lock is also sync.
>  unsafe impl<T: Sync + ?Sized, B: Backend> Sync for Guard<'_, T, B> {}
>  
> +impl<T: ?Sized, B: Backend> Guard<'_, T, B> {
> +    #[allow(dead_code)]
> +    pub(crate) fn do_unlocked(&mut self, cb: impl FnOnce()) {
> +        // SAFETY: The caller owns the lock, so it is safe to unlock it.
> +        unsafe { B::unlock(self.lock.state.get(), &self.state) };
> +        cb();
> +        // SAFETY: The lock was just unlocked above and is being relocked now.
> +        unsafe { B::relock(self.lock.state.get(), &mut self.state) };
> +    }
> +}
> +
>  impl<T: ?Sized, B: Backend> core::ops::Deref for Guard<'_, T, B> {
>      type Target = T;
>  
> diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/spinlock.rs
> index 34dec09a97c0..e2a2f68e6d93 100644
> --- a/rust/kernel/sync/lock/spinlock.rs
> +++ b/rust/kernel/sync/lock/spinlock.rs
> @@ -4,6 +4,7 @@
>  //!
>  //! This module allows Rust code to use the kernel's `spinlock_t`.
>  
> +use super::IrqSaveBackend;
>  use crate::bindings;
>  
>  /// Creates a [`SpinLock`] initialiser with the given name and a newly-created lock class.
> @@ -95,7 +96,8 @@ pub type SpinLock<T> = super::Lock<T, SpinLockBackend>;
>  /// A kernel `spinlock_t` lock backend.
>  pub struct SpinLockBackend;
>  
> -// SAFETY: The underlying kernel `spinlock_t` object ensures mutual exclusion.
> +// SAFETY: The underlying kernel `spinlock_t` object ensures mutual exclusion. `relock` uses the
> +// same scheme as `unlock` to figure out which locking method was used originally.
>  unsafe impl super::Backend for SpinLockBackend {
>      type State = bindings::spinlock_t;
>      type GuardState = Option<core::ffi::c_ulong>;
> @@ -127,13 +129,24 @@ unsafe impl super::Backend for SpinLockBackend {
>              None => unsafe { bindings::spin_unlock(ptr) },
>          }
>      }
> +
> +    unsafe fn relock(ptr: *mut Self::State, guard_state: &mut Self::GuardState) {
> +        let _ = match guard_state {
> +            // SAFETY: The safety requiments of this function ensure that `ptr` has been
> +            // initialised.
> +            None => unsafe { Self::lock(ptr) },
> +            // SAFETY: The safety requiments of this function ensure that `ptr` has been
> +            // initialised.
> +            Some(_) => unsafe { Self::lock_irqsave(ptr) },
> +        };
> +    }
>  }
>  
>  // SAFETY: The underlying kernel `spinlock_t` object ensures mutual exclusion. We use the `irqsave`
>  // variant of the C lock acquisition functions to disable interrupts and retrieve the original
>  // interrupt state, and the `irqrestore` variant of the lock release functions to restore the state
>  // in `unlock` -- we use the guard context to determine which method was used to acquire the lock.
> -unsafe impl super::IrqSaveBackend for SpinLockBackend {
> +unsafe impl IrqSaveBackend for SpinLockBackend {
>      unsafe fn lock_irqsave(ptr: *mut Self::State) -> Self::GuardState {
>          // SAFETY: The safety requirements of this function ensure that `ptr` points to valid
>          // memory, and that it has been initialised before.

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
