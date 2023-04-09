Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3BC6DC0B7
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 18:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjDIQs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 12:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjDIQsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 12:48:45 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B746149D6;
        Sun,  9 Apr 2023 09:48:31 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id r14so28263859oiw.12;
        Sun, 09 Apr 2023 09:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681058910;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xdHold+COrV3sKwjTw8PSf3mGPA2NsrU/gKVxg/DLYI=;
        b=PQc6GmNKtCQkGxrQNeVo65JIJakZ8BkGXCQI8w5l7NOXm2uLvmzp7/8dbVL8p1uaeM
         JcB7iMVWU6AhTGg1fvCIGl7+fY/gMPr+NccdxRCr9a5xfKwgTyWbWKnq8asDteVPAX6O
         j7pCHDR/K3NyrUuMumMHfCxCPjAemFTnINXuOmtxajKaUNKsIgUbjPggexY+rkDoQZG8
         CW3KeHukW+kInAAOhRwkhKrY1L6Lv+POFUc3JM+23HHKo8LsSu1DQvvd0pyUDRmrjLOs
         eQs3Q2cqzA8yupqPKyPY1mR8SO3wHGjtieeHu4Xj6XrGvSQWhklxeQNHgaIj6AKojhHM
         ioqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681058910;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xdHold+COrV3sKwjTw8PSf3mGPA2NsrU/gKVxg/DLYI=;
        b=c/6cnpT7+/pzQ7p6gcZAF/7XBGcIs4JvfHkrbpwqP89EK6eZ+0tx/gj243MaSHcESZ
         APJf2CGLGvXhDGZQ/L/YtMjOmF42EE0Z5+LAPQbEGXnDUqPZS3/lABtw0V/pea7+iffq
         G9N0n9wrCwZVpYNU1+IRKXlOgGq1pZ+c2GXbcLO2ibyt/+FsH1ow1GBUIvGX2I3DbhAN
         urT7jiuXmMvx4EdN0gln0JouODFWwUNOqsfcpkMIVu9jRBaYR2wb7zHT0JQiO+FEM3Rz
         dJ9Tqc8NDdO/GDQv79xI04yAfnIu29ij8KImznWWVMIshAmGjUJDa1EBrXqXIhypqEwt
         csAA==
X-Gm-Message-State: AAQBX9fiOmaLugyua98xLsHdXwV2hbI523kwC1G+eiSaJkcNV1Hkyf5T
        j1wqEhOGB34Z64Wx2Bn5+dY=
X-Google-Smtp-Source: AKy350bJVwQIZeAyynP4YG+VAGp2/pEiewdnSTpXUFp/T68zq29Wvz8w0lveOYT/7ewsVq9+r3v7yw==
X-Received: by 2002:a05:6808:2089:b0:38b:be56:81 with SMTP id s9-20020a056808208900b0038bbe560081mr739901oiw.28.1681058910659;
        Sun, 09 Apr 2023 09:48:30 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id b124-20020aca3482000000b0038bc0cb5d52sm338758oia.9.2023.04.09.09.48.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Apr 2023 09:48:30 -0700 (PDT)
Message-ID: <7210fc06-e431-54a7-744d-29e587a565e2@gmail.com>
Date:   Sun, 9 Apr 2023 13:48:26 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH v3 07/13] rust: lock: implement `IrqSaveBackend` for
 `SpinLock`
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
 <20230408075340.25237-7-wedsonaf@gmail.com>
Content-Language: en-US
In-Reply-To: <20230408075340.25237-7-wedsonaf@gmail.com>
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
> This allows Rust code to use the `lock_irqsave` variant of spinlocks.
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
>  rust/helpers.c                    | 16 +++++++++++++
>  rust/kernel/sync/lock/spinlock.rs | 38 ++++++++++++++++++++++++++-----
>  2 files changed, 48 insertions(+), 6 deletions(-)
> 
> diff --git a/rust/helpers.c b/rust/helpers.c
> index 05694e3f8f70..e42f5b446f92 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -59,6 +59,22 @@ void rust_helper_spin_unlock(spinlock_t *lock)
>  }
>  EXPORT_SYMBOL_GPL(rust_helper_spin_unlock);
>  
> +unsigned long rust_helper_spin_lock_irqsave(spinlock_t *lock)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(lock, flags);
> +
> +	return flags;
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_spin_lock_irqsave);
> +
> +void rust_helper_spin_unlock_irqrestore(spinlock_t *lock, unsigned long flags)
> +{
> +	spin_unlock_irqrestore(lock, flags);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_spin_unlock_irqrestore);
> +
>  refcount_t rust_helper_REFCOUNT_INIT(int n)
>  {
>  	return (refcount_t)REFCOUNT_INIT(n);
> diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/spinlock.rs
> index a52d20fc9755..34dec09a97c0 100644
> --- a/rust/kernel/sync/lock/spinlock.rs
> +++ b/rust/kernel/sync/lock/spinlock.rs
> @@ -61,6 +61,8 @@ macro_rules! new_spinlock {
>  /// assert_eq!(e.c, 10);
>  /// assert_eq!(e.d.lock().a, 20);
>  /// assert_eq!(e.d.lock().b, 30);
> +/// assert_eq!(e.d.lock_irqsave().a, 20);
> +/// assert_eq!(e.d.lock_irqsave().b, 30);
>  /// ```
>  ///
>  /// The following example shows how to use interior mutability to modify the contents of a struct
> @@ -79,6 +81,12 @@ macro_rules! new_spinlock {
>  ///     guard.a += 10;
>  ///     guard.b += 20;
>  /// }
> +///
> +/// fn example2(m: &SpinLock<Example>) {
> +///     let mut guard = m.lock_irqsave();
> +///     guard.a += 10;
> +///     guard.b += 20;
> +/// }
>  /// ```
>  ///
>  /// [`spinlock_t`]: ../../../../include/linux/spinlock.h
> @@ -90,7 +98,7 @@ pub struct SpinLockBackend;
>  // SAFETY: The underlying kernel `spinlock_t` object ensures mutual exclusion.
>  unsafe impl super::Backend for SpinLockBackend {
>      type State = bindings::spinlock_t;
> -    type GuardState = ();
> +    type GuardState = Option<core::ffi::c_ulong>;
>  
>      unsafe fn init(
>          ptr: *mut Self::State,
> @@ -105,12 +113,30 @@ unsafe impl super::Backend for SpinLockBackend {
>      unsafe fn lock(ptr: *mut Self::State) -> Self::GuardState {
>          // SAFETY: The safety requirements of this function ensure that `ptr` points to valid
>          // memory, and that it has been initialised before.
> -        unsafe { bindings::spin_lock(ptr) }
> +        unsafe { bindings::spin_lock(ptr) };
> +        None
>      }
>  
> -    unsafe fn unlock(ptr: *mut Self::State, _guard_state: &Self::GuardState) {
> -        // SAFETY: The safety requirements of this function ensure that `ptr` is valid and that the
> -        // caller is the owner of the mutex.
> -        unsafe { bindings::spin_unlock(ptr) }
> +    unsafe fn unlock(ptr: *mut Self::State, guard_state: &Self::GuardState) {
> +        match guard_state {
> +            // SAFETY: The safety requirements of this function ensure that `ptr` is valid and that
> +            // the caller is the owner of the mutex.
> +            Some(flags) => unsafe { bindings::spin_unlock_irqrestore(ptr, *flags) },
> +            // SAFETY: The safety requirements of this function ensure that `ptr` is valid and that
> +            // the caller is the owner of the mutex.
> +            None => unsafe { bindings::spin_unlock(ptr) },
> +        }
> +    }
> +}
> +
> +// SAFETY: The underlying kernel `spinlock_t` object ensures mutual exclusion. We use the `irqsave`
> +// variant of the C lock acquisition functions to disable interrupts and retrieve the original
> +// interrupt state, and the `irqrestore` variant of the lock release functions to restore the state
> +// in `unlock` -- we use the guard context to determine which method was used to acquire the lock.
> +unsafe impl super::IrqSaveBackend for SpinLockBackend {
> +    unsafe fn lock_irqsave(ptr: *mut Self::State) -> Self::GuardState {
> +        // SAFETY: The safety requirements of this function ensure that `ptr` points to valid
> +        // memory, and that it has been initialised before.
> +        Some(unsafe { bindings::spin_lock_irqsave(ptr) })
>      }
>  }

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
