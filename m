Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D626DC0B6
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 18:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjDIQs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 12:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjDIQsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 12:48:24 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E6C3C3C;
        Sun,  9 Apr 2023 09:48:21 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id cp25-20020a056830661900b00693ce5a2f3eso1436537otb.8;
        Sun, 09 Apr 2023 09:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681058901;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=25syNKVzzAxfQxyr5cAVlXTRnOTq++82+v7Rc2s+ORE=;
        b=ORx/3RlFB/9dhAmBh9NEHro01BdbaxSKVfDOKt2+ejesQM7oYbvLrtV6nrDQUOkM62
         TqBYPBQzsfT8E9Uq9n64USBW+xRrCsvJc+4FXQ214OmxbO5pwDx1e7g34t1UAxxFlzaA
         z5rvVvL+cTXRAR33QybGU9+TLtW1gc3YAQF3t9l6ltn6opb8luvdamEOLWZPdjRHPVv+
         h0fVdGW8s5MLJwRX+YU3jvKwgtVNJ4ggDoLhYKxcEkmQCOIIx+8gDntDNl//ZVwCszEM
         8+YARy/OH6hNPZwP8k3yuv6HbVKzjYG95zJ4S/kef/Me0Ffv6uI9wojjjKNj5mrOkHFm
         vhOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681058901;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=25syNKVzzAxfQxyr5cAVlXTRnOTq++82+v7Rc2s+ORE=;
        b=AXnzKDTaVyt7ev8ZqOktVy/W8pD2DOFG4f007GZ7V2bSbTLUz/+3X3hpsaFuKdHC8B
         TGOHu7s+TolSH1hA2s+2ROSXcs9IyagQkqpeZfXZqz90VL3rJqX27V3/gpWQqlJoXtOL
         Urc/LmXpZK/d7o36nIV0df/5SVbMBxZZx6lG+NdHHH+mAYJOZuhOYB4DrvcWJTkTq2Id
         BdepKkIMA56yynGMCvNuTcSDm+X+UodFwSY8p6i6uFdHzxYPjteR8hxcjh39ekYhyOY8
         uOxj/v9oU85YBNj+pJJ9+rvYCNe7RMF9eO8gmym0rsGQXKVVR4gHnTX1FUj5gD/85VAc
         LeuQ==
X-Gm-Message-State: AAQBX9ftly+hSIWn2VEPtnvxAFs/weIF0CCw+N4dmQQ4Z6BiL8j0+qAX
        xBqPl3bkBu3WSy0PYleOP5U=
X-Google-Smtp-Source: AKy350bOCblFogL4MTz0ajhtC3x8F6RHjriX4Tz6Rjtb71CgTjAzdYfDJgvRhPRvCqPNiknR3aK3VQ==
X-Received: by 2002:a05:6830:1e84:b0:69d:d4f4:733d with SMTP id n4-20020a0568301e8400b0069dd4f4733dmr4074917otr.4.1681058901062;
        Sun, 09 Apr 2023 09:48:21 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id c6-20020a9d67c6000000b006a143873c6bsm3514336otn.50.2023.04.09.09.48.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Apr 2023 09:48:20 -0700 (PDT)
Message-ID: <c4c21920-ba72-716d-86bf-4588c7e207e8@gmail.com>
Date:   Sun, 9 Apr 2023 13:48:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH v3 06/13] rust: lock: add support for `Lock::lock_irqsave`
To:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
References: <20230408075340.25237-1-wedsonaf@gmail.com>
 <20230408075340.25237-6-wedsonaf@gmail.com>
Content-Language: en-US
In-Reply-To: <20230408075340.25237-6-wedsonaf@gmail.com>
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
> This allows locks like spinlocks and raw spinlocks to expose a
> `lock_irqsave` variant in Rust that corresponds to the C version.
> 
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
> v1 -> v2: No changes
> v2 -> v3: No changes
> 
>  rust/kernel/sync/lock.rs | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> index df43dff5af5c..690429561f0e 100644
> --- a/rust/kernel/sync/lock.rs
> +++ b/rust/kernel/sync/lock.rs
> @@ -57,6 +57,29 @@ pub unsafe trait Backend {
>      unsafe fn unlock(ptr: *mut Self::State, guard_state: &Self::GuardState);
>  }
>  
> +/// The "backend" of a lock that supports the irq-save variant.
> +///
> +/// # Safety
> +///
> +/// The same requirements wrt mutual exclusion in [`Backend`] apply for acquiring the lock via
> +/// [`IrqSaveBackend::lock_irqsave`].
> +///
> +/// Additionally, when [`IrqSaveBackend::lock_irqsave`] is used to acquire the lock, implementers
> +/// must disable interrupts on lock, and restore interrupt state on unlock. Implementers may use
> +/// [`Backend::GuardState`] to store state needed to keep track of the interrupt state.
> +pub unsafe trait IrqSaveBackend: Backend {
> +    /// Acquires the lock, making the caller its owner.
> +    ///
> +    /// Before acquiring the lock, it disables interrupts, and returns the previous interrupt state
> +    /// as its guard state so that the guard can restore it when it is dropped.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that [`Backend::init`] has been previously called.
> +    #[must_use]
> +    unsafe fn lock_irqsave(ptr: *mut Self::State) -> Self::GuardState;
> +}
> +
>  /// A mutual exclusion primitive.
>  ///
>  /// Exposes one of the kernel locking primitives. Which one is exposed depends on the lock banckend
> @@ -111,6 +134,21 @@ impl<T: ?Sized, B: Backend> Lock<T, B> {
>      }
>  }
>  
> +impl<T: ?Sized, B: IrqSaveBackend> Lock<T, B> {
> +    /// Acquires the lock and gives the caller access to the data protected by it.
> +    ///
> +    /// Before acquiring the lock, it disables interrupts. When the guard is dropped, the interrupt
> +    /// state (either enabled or disabled) is restored to its state before
> +    /// [`lock_irqsave`](Self::lock_irqsave) was called.
> +    pub fn lock_irqsave(&self) -> Guard<'_, T, B> {
> +        // SAFETY: The constructor of the type calls `init`, so the existence of the object proves
> +        // that `init` was called.
> +        let state = unsafe { B::lock_irqsave(self.state.get()) };
> +        // SAFETY: The lock was just acquired.
> +        unsafe { Guard::new(self, state) }
> +    }
> +}
> +
>  /// A lock guard.
>  ///
>  /// Allows mutual exclusion primitives that implement the `Backend` trait to automatically unlock

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
