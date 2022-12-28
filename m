Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08371657508
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 11:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbiL1KCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 05:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbiL1KC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 05:02:29 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1498101C8;
        Wed, 28 Dec 2022 02:02:22 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 1D8455C0158;
        Wed, 28 Dec 2022 05:02:21 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 28 Dec 2022 05:02:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1672221741; x=
        1672308141; bh=MZcrtkpn45hSZzHoYj+0v76Q/VMqCGY1GazRzbBpn54=; b=J
        iBFMf95/cnvdReHC+AtNTdVyIUiJ3oUK4LSNd2QgwA2gITVceh0yE6bRREeAlflv
        fALA14ePw7rEPvaH1+GHhNKj3i3MX+KxiJZTKYMQ486sSHipg9hh0CEvWOGo6dCG
        yy7BaVmb/93rvwH6vX/NRDDCeuqUbyeaMwmab32HF3G/tK2NcFDgpQc11vUsDxak
        9oxS5Kmne3qIJmc7+KDJSA4rwWeFME7oeZ5LIxjJnxPtyWLyxSNx258TmTkRfHi5
        me49o8FME+Ijo5xUtgysDzLuAa1ueO0l/Ia1HCb1ZYAFIpcRAHNKLjCqDCBwwyVb
        +RMnbrnHE0jtGpJbjhobg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1672221741; x=
        1672308141; bh=MZcrtkpn45hSZzHoYj+0v76Q/VMqCGY1GazRzbBpn54=; b=Q
        rp8ZhQ51iPKrtKhUUc5TfhLgC2dXbpDiHU1luE6V8AQCZVFMllsWAPiWpIgzGl/5
        Q21OJfNd2NFmb5IBRxPCcjItA5XIkvdIgzdpgZw0N6GUKvwfwEV1bcfSoBbcsMA3
        xdCtxh64V9/ETL8IhLtJW19JdmgZNoo5d4LO1R1IofVH9WAt8x29A8pxuXduV0h+
        Wje76bTvbw0p17OTy8FML4flvhCWG/aCRHsEJy2RSD471m+VD2sECNZt89wjFIGU
        /2xygPq70G3lUh4okA4VwKMhwUrkzChkvGTjxA7M/OmT0XVJEdSCCH0F8DG30gdJ
        RKE2Vzhufv0UptCzzYhdA==
X-ME-Sender: <xms:LBSsY_aa4XOUpA6UGaA89DA5u7oSM9hONcp79D736rcoxtm0Dx5IcQ>
    <xme:LBSsY-YaBn_vMv_Q8bbLoWkLEIivbIpSoObtiiYvJqP8s7mx43OtP1iBP7LYQmOXu
    ZELGoTE1LLsJNU75A>
X-ME-Received: <xmr:LBSsYx9wLMm_8-KaJY2wL2k3eEqHBd5yl9Zg0wbFRtBwaQ46SK5CGBbAEIWFa_HGLNVHkKcXmDw75e9LLgSnWNH7OQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedriedvgdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfhuffvvehfjggtgfesthejredttdefjeenucfhrhhomheptehlihgt
    vgcutfihhhhluceorghlihgtvgesrhihhhhlrdhioheqnecuggftrfgrthhtvghrnhepvd
    evhfegtddtledvudfgfeegjeevudefjefhieekieevtdfhgfffudekudfhudeknecuffho
    mhgrihhnpehinhhnvghrrdgrshenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrlhhitggvsehrhihhlhdrihho
X-ME-Proxy: <xmx:LBSsY1oDHxhBvisE0JEtbTtzud9c17OSbAydmaynfO2VCnqwqMIx1Q>
    <xmx:LBSsY6oNc4GNPZPhXO0NQzuL3a38gGcByub1xOxKo7LqNYnIj7OqMg>
    <xmx:LBSsY7Qp4gF0Goic9RCGfFDBgMd0U67FXVXf6hymMkpVx3Wud6DWww>
    <xmx:LRSsY7epY1LySYKZ1LVpcZE69aF1ZZm8LvUvsz_9GBk7zI2A52f5GA>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Dec 2022 05:02:18 -0500 (EST)
Message-ID: <254be618-67f3-f17c-e01b-e0389c8008bc@ryhl.io>
Date:   Wed, 28 Dec 2022 11:03:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
From:   Alice Ryhl <alice@ryhl.io>
Subject: Re: [PATCH 4/7] rust: sync: introduce `ArcBorrow`
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org
References: <20221228060346.352362-1-wedsonaf@gmail.com>
 <20221228060346.352362-4-wedsonaf@gmail.com>
Content-Language: en-US
In-Reply-To: <20221228060346.352362-4-wedsonaf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

On 12/28/22 07:03, Wedson Almeida Filho wrote:
> This allows us to create references to a ref-counted allocation without
> double-indirection and that still allow us to increment the refcount to
> a new `Arc<T>`.
> 
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> ---
>   rust/kernel/sync.rs     |  2 +-
>   rust/kernel/sync/arc.rs | 97 +++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 98 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index 39b379dd548f..5de03ea83ea1 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -7,4 +7,4 @@
>   
>   mod arc;
>   
> -pub use arc::Arc;
> +pub use arc::{Arc, ArcBorrow};
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index dbc7596cc3ce..f68bfc02c81a 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -19,6 +19,7 @@ use crate::{bindings, error::Result, types::Opaque};
>   use alloc::boxed::Box;
>   use core::{
>       marker::{PhantomData, Unsize},
> +    mem::ManuallyDrop,
>       ops::Deref,
>       ptr::NonNull,
>   };
> @@ -164,6 +165,18 @@ impl<T: ?Sized> Arc<T> {
>               _p: PhantomData,
>           }
>       }
> +
> +    /// Returns an [`ArcBorrow`] from the given [`Arc`].
> +    ///
> +    /// This is useful when the argument of a function call is an [`ArcBorrow`] (e.g., in a method
> +    /// receiver), but we have an [`Arc`] instead. Getting an [`ArcBorrow`] is free when optimised.
> +    #[inline]
> +    pub fn as_arc_borrow(&self) -> ArcBorrow<'_, T> {
> +        // SAFETY: The constraint that the lifetime of the shared reference must outlive that of
> +        // the returned `ArcBorrow` ensures that the object remains alive and that no mutable
> +        // reference can be created.
> +        unsafe { ArcBorrow::new(self.ptr) }
> +    }
>   }
>   
>   impl<T: ?Sized> Deref for Arc<T> {
> @@ -208,3 +221,87 @@ impl<T: ?Sized> Drop for Arc<T> {
>           }
>       }
>   }
> +
> +/// A borrowed reference to an [`Arc`] instance.
> +///
> +/// For cases when one doesn't ever need to increment the refcount on the allocation, it is simpler
> +/// to use just `&T`, which we can trivially get from an `Arc<T>` instance.
> +///
> +/// However, when one may need to increment the refcount, it is preferable to use an `ArcBorrow<T>`
> +/// over `&Arc<T>` because the latter results in a double-indirection: a pointer (shared reference)
> +/// to a pointer (`Arc<T>`) to the object (`T`). An [`ArcBorrow`] eliminates this double
> +/// indirection while still allowing one to increment the refcount and getting an `Arc<T>` when/if
> +/// needed.
> +///
> +/// # Invariants
> +///
> +/// There are no mutable references to the underlying [`Arc`], and it remains valid for the
> +/// lifetime of the [`ArcBorrow`] instance.
> +///
> +/// # Example
> +///
> +/// ```
> +/// use crate::sync::{Arc, ArcBorrow};
> +///
> +/// struct Example;
> +///
> +/// fn do_something(e: ArcBorrow<'_, Example>) -> Arc<Example> {
> +///     e.into()
> +/// }
> +///
> +/// let obj = Arc::try_new(Example)?;
> +/// let cloned = do_something(obj.as_arc_borrow());
> +///
> +/// // Assert that both `obj` and `cloned` point to the same underlying object.
> +/// assert!(core::ptr::eq(&*obj, &*cloned));
> +/// ```
> +pub struct ArcBorrow<'a, T: ?Sized + 'a> {
> +    inner: NonNull<ArcInner<T>>,
> +    _p: PhantomData<&'a ()>,
> +}
> +
> +impl<T: ?Sized> Clone for ArcBorrow<'_, T> {
> +    fn clone(&self) -> Self {
> +        *self
> +    }
> +}
> +
> +impl<T: ?Sized> Copy for ArcBorrow<'_, T> {}
> +
> +impl<T: ?Sized> ArcBorrow<'_, T> {
> +    /// Creates a new [`ArcBorrow`] instance.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure the following for the lifetime of the returned [`ArcBorrow`] instance:
> +    /// 1. That `inner` remains valid;
> +    /// 2. That no mutable references to `inner` are created.
> +    unsafe fn new(inner: NonNull<ArcInner<T>>) -> Self {
> +        // INVARIANT: The safety requirements guarantee the invariants.
> +        Self {
> +            inner,
> +            _p: PhantomData,
> +        }
> +    }
> +}
> +
> +impl<T: ?Sized> From<ArcBorrow<'_, T>> for Arc<T> {
> +    fn from(b: ArcBorrow<'_, T>) -> Self {
> +        // SAFETY: The existence of `b` guarantees that the refcount is non-zero. `ManuallyDrop`
> +        // guarantees that `drop` isn't called, so it's ok that the temporary `Arc` doesn't own the
> +        // increment.
> +        ManuallyDrop::new(unsafe { Arc::from_inner(b.inner) })
> +            .deref()
> +            .clone()
> +    }
> +}
> +
> +impl<T: ?Sized> Deref for ArcBorrow<'_, T> {
> +    type Target = T;
> +
> +    fn deref(&self) -> &Self::Target {
> +        // SAFETY: By the type invariant, the underlying object is still alive with no mutable
> +        // references to it, so it is safe to create a shared reference.
> +        unsafe { &self.inner.as_ref().data }
> +    }
> +}
