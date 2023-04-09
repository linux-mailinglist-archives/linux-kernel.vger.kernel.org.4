Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C911E6DC0B8
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 18:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjDIQtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 12:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjDIQtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 12:49:01 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9876C40CB;
        Sun,  9 Apr 2023 09:48:40 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id w13so22556283oik.2;
        Sun, 09 Apr 2023 09:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681058920;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mN7Lo2XdhxG1QL+zdNaUPOzW6M2+Mkg1ymu+ExCKVjA=;
        b=pHCp+ZgS8XAt4dNWjjSZ7uSoyy1eWUsrrAzs7WSsEeiNKV8MuI9sWJeVsgE2xvxC1G
         IRhRRa6EYxud1JZDQufCdKej95/Z5xi7JQq2OMEC4DJGvAi95WmWv5pVr1zKHDMOG9+w
         ZsNOX0NMvbzXy2zUtK5pWLcI9aPEdjLbIUZ8/CKYwdc145DH6JehEQ5eZGR/rV9ZIGDn
         LQcjRLkAYvXVi25OIwTxLUB9HyOCilIMQ7OqilGpGEI3HCJ9bC9nyMgBoheIDsNqcjNn
         gtpnjihCyWB2LrXcpYkvxcxuafS2LUxplfmjNVEeOUKPyHxY8sSpv08SSEs+NqYtQ3CF
         PCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681058920;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mN7Lo2XdhxG1QL+zdNaUPOzW6M2+Mkg1ymu+ExCKVjA=;
        b=Q3Zq56kukLLddw+DYCxTheALMILYKOd1fiaI/L8Rtn6tFXKkI0PsdMMKVMsKmhp89g
         65wHksmjEvEwO2QWFg1VOLSmK+GZPzQ/JP5I3xuil4GMT0vQLYDoUt1SDfxHbwly/ir1
         o9VyYqbneUhyzPEimOiWs8AIUunXBAMdocIbpspjIInjvSwB/N8q4UXnjM0HysHYDBWE
         Bpzd5YSBlhEokdEpHIMPImv1VPH8NXUQjSQP0seVfe+FvbzNfYup7d1OWvg3EOyUSR1A
         mki/e6CHwnx+pAFsRES6GT65gCHx+pmCdQ+R6hrfPRe30PYkWr5QwlCCVQ6fYyKW9Quh
         6JAg==
X-Gm-Message-State: AAQBX9cKFhHLf19gC5oQ7dVvfZSyJaubUvsF6j8D6Fvc0UFLlWcQX805
        Ar7In8ZKsPFxekRlUJZSElY=
X-Google-Smtp-Source: AKy350YNc6K70IyuSO/y3CiTZ3bHtRXwqExvxOE/xZ7/0TI6J87lPblQzM+RaotYpZR9Jqt+kHOpLw==
X-Received: by 2002:a05:6808:191a:b0:387:84ce:ce24 with SMTP id bf26-20020a056808191a00b0038784cece24mr4568088oib.45.1681058919857;
        Sun, 09 Apr 2023 09:48:39 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id r7-20020a4a83c7000000b00529cc3986c8sm3753010oog.40.2023.04.09.09.48.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Apr 2023 09:48:39 -0700 (PDT)
Message-ID: <35f8586b-a462-a482-d892-e31d194b90f4@gmail.com>
Date:   Sun, 9 Apr 2023 13:48:36 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH v3 08/13] rust: introduce `ARef`
To:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
References: <20230408075340.25237-1-wedsonaf@gmail.com>
 <20230408075340.25237-8-wedsonaf@gmail.com>
Content-Language: en-US
In-Reply-To: <20230408075340.25237-8-wedsonaf@gmail.com>
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
> This is an owned reference to an object that is always ref-counted. This
> is meant to be used in wrappers for C types that have their own ref
> counting functions, for example, tasks, files, inodes, dentries, etc.
> 
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
> v1 -> v2: No changes
> v2 -> v3: No changes
> 
>  rust/kernel/types.rs | 107 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 107 insertions(+)
> 
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index 3a46ec1a00cd..73709ce1f0a1 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -6,8 +6,10 @@ use crate::init::{self, PinInit};
>  use alloc::boxed::Box;
>  use core::{
>      cell::UnsafeCell,
> +    marker::PhantomData,
>      mem::MaybeUninit,
>      ops::{Deref, DerefMut},
> +    ptr::NonNull,
>  };
>  
>  /// Used to transfer ownership to and from foreign (non-Rust) languages.
> @@ -268,6 +270,111 @@ impl<T> Opaque<T> {
>      }
>  }
>  
> +/// Types that are _always_ reference counted.
> +///
> +/// It allows such types to define their own custom ref increment and decrement functions.
> +/// Additionally, it allows users to convert from a shared reference `&T` to an owned reference
> +/// [`ARef<T>`].
> +///
> +/// This is usually implemented by wrappers to existing structures on the C side of the code. For
> +/// Rust code, the recommendation is to use [`Arc`](crate::sync::Arc) to create reference-counted
> +/// instances of a type.
> +///
> +/// # Safety
> +///
> +/// Implementers must ensure that increments to the reference count keep the object alive in memory
> +/// at least until matching decrements are performed.
> +///
> +/// Implementers must also ensure that all instances are reference-counted. (Otherwise they
> +/// won't be able to honour the requirement that [`AlwaysRefCounted::inc_ref`] keep the object
> +/// alive.)
> +pub unsafe trait AlwaysRefCounted {
> +    /// Increments the reference count on the object.
> +    fn inc_ref(&self);
> +
> +    /// Decrements the reference count on the object.
> +    ///
> +    /// Frees the object when the count reaches zero.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that there was a previous matching increment to the reference count,
> +    /// and that the object is no longer used after its reference count is decremented (as it may
> +    /// result in the object being freed), unless the caller owns another increment on the refcount
> +    /// (e.g., it calls [`AlwaysRefCounted::inc_ref`] twice, then calls
> +    /// [`AlwaysRefCounted::dec_ref`] once).
> +    unsafe fn dec_ref(obj: NonNull<Self>);
> +}
> +
> +/// An owned reference to an always-reference-counted object.
> +///
> +/// The object's reference count is automatically decremented when an instance of [`ARef`] is
> +/// dropped. It is also automatically incremented when a new instance is created via
> +/// [`ARef::clone`].
> +///
> +/// # Invariants
> +///
> +/// The pointer stored in `ptr` is non-null and valid for the lifetime of the [`ARef`] instance. In
> +/// particular, the [`ARef`] instance owns an increment on the underlying object's reference count.
> +pub struct ARef<T: AlwaysRefCounted> {
> +    ptr: NonNull<T>,
> +    _p: PhantomData<T>,
> +}
> +
> +impl<T: AlwaysRefCounted> ARef<T> {
> +    /// Creates a new instance of [`ARef`].
> +    ///
> +    /// It takes over an increment of the reference count on the underlying object.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that the reference count was incremented at least once, and that they
> +    /// are properly relinquishing one increment. That is, if there is only one increment, callers
> +    /// must not use the underlying object anymore -- it is only safe to do so via the newly
> +    /// created [`ARef`].
> +    pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
> +        // INVARIANT: The safety requirements guarantee that the new instance now owns the
> +        // increment on the refcount.
> +        Self {
> +            ptr,
> +            _p: PhantomData,
> +        }
> +    }
> +}
> +
> +impl<T: AlwaysRefCounted> Clone for ARef<T> {
> +    fn clone(&self) -> Self {
> +        self.inc_ref();
> +        // SAFETY: We just incremented the refcount above.
> +        unsafe { Self::from_raw(self.ptr) }
> +    }
> +}
> +
> +impl<T: AlwaysRefCounted> Deref for ARef<T> {
> +    type Target = T;
> +
> +    fn deref(&self) -> &Self::Target {
> +        // SAFETY: The type invariants guarantee that the object is valid.
> +        unsafe { self.ptr.as_ref() }
> +    }
> +}
> +
> +impl<T: AlwaysRefCounted> From<&T> for ARef<T> {
> +    fn from(b: &T) -> Self {
> +        b.inc_ref();
> +        // SAFETY: We just incremented the refcount above.
> +        unsafe { Self::from_raw(NonNull::from(b)) }
> +    }
> +}
> +
> +impl<T: AlwaysRefCounted> Drop for ARef<T> {
> +    fn drop(&mut self) {
> +        // SAFETY: The type invariants guarantee that the `ARef` owns the reference we're about to
> +        // decrement.
> +        unsafe { T::dec_ref(self.ptr) };
> +    }
> +}
> +
>  /// A sum type that always holds either a value of type `L` or `R`.
>  pub enum Either<L, R> {
>      /// Constructs an instance of [`Either`] containing a value of type `L`.

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
