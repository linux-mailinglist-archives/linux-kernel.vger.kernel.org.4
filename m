Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF1165750B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 11:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbiL1KDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 05:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiL1KCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 05:02:45 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5691007C;
        Wed, 28 Dec 2022 02:02:37 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 530BF5C0061;
        Wed, 28 Dec 2022 05:02:37 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 28 Dec 2022 05:02:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1672221757; x=
        1672308157; bh=Zx8xUNqox/ToH5NzT8DN2j9vnlJmBZ6q5HqdY75rsG0=; b=X
        InSKiaR9Z4OG3dOmZv2JI7HjBvH1HUPqAasi/Fzr3X0kplwaJLq6ogKsyRl/d8tP
        uXEtwvk4Wk6vzh7kL5pEuUwUCmZfq6sWULajugY1c4+ZAnu4qqXRJUkkN3jEP1iE
        olhqLT2ysWhq1YRLS/kEuiohy6g1TQq1JjORrZYxBCSk5hBbbWf2rKRxqJ/30EpB
        evcheEWtr7RhILK0FQoB3fAOxIMSzt94rTsix+kY9bK7xCttnCwzt0b1nRT7KwuU
        D7lEQbYIJ9MyBYaNU6Gu4T8pL//pWqeuptvTV3DSlLp79PyMQOqoxMfUEs+IMw0U
        /3ehmOAy7FzEpJ51YDpcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1672221757; x=
        1672308157; bh=Zx8xUNqox/ToH5NzT8DN2j9vnlJmBZ6q5HqdY75rsG0=; b=c
        yDG/D6EjlD3PsUAyI7L8JCU8ScJrwLSWkyqPDia6z3z31YLwPjCOyG+KsDuBLwr/
        GR2VIyyR/KI+pn2ISj0a9bvqOCYjc060SEtNPMoy2to1GJV2H7/Fsu9UtWJPhRpu
        bwCflnAAxj9GyeC/q0eBUB79gp59brb27nzHYRgpctp5oQhuGqx2tBlYSZ9zlVrG
        1yPnKlzo12nKw0UB50RAZaoMRRBCG+KZsFmofGg6C71CqYpp80/zA3Bc5hFzZ/UL
        2UTeh4kbhFQww3fFngeLAFsPfdid6B2pwWOpV6VBtZZqNYsdJXjEsP2MWls4L7Fm
        BEGwX07gj25bPqOo/qM4w==
X-ME-Sender: <xms:PRSsY2XxX2S0czYJlh01A1y4tIU33h3N4yyKqX95OXJ7k3VGR3ZmvQ>
    <xme:PRSsYymizFYLTtG0Yfrf1jcCgXUT9DAxk4hACeKDcb9-hMRzwvMRlK9t2vNsQCl17
    vXMRmfIlPT-uxALjg>
X-ME-Received: <xmr:PRSsY6Y5_tGle-epfF-LEhUFEgmEhfgu-JVGFUuFrP1NhMMo1SPR7WoAGFgfbpgwKhCnLAC3WqY1DeVM-VVEgrPp2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedriedvgdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfhuffvvehfjggtgfesthejredttdefjeenucfhrhhomheptehlihgt
    vgcutfihhhhluceorghlihgtvgesrhihhhhlrdhioheqnecuggftrfgrthhtvghrnhepje
    ffieffteevfeejudetheejudekudffkedtueetueevleevveelfeduieegledvnecuffho
    mhgrihhnpehinhhnvghrrdgrshdpphhtrhdrrghsnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghlihgtvgesrhihhhhlrdhioh
X-ME-Proxy: <xmx:PRSsY9Ub9S7SNj80dfy_F9PXAbECKUCs_BdBiqnf15h95s_atac98Q>
    <xmx:PRSsYwn8_c_HzLHo4p8uggvvyS_707-GV-H6XY_YJqLCKy42kiRl3Q>
    <xmx:PRSsYycCx2Ym2TSQ2FsltmeZiWfv2PvRDFVx7QC1nljXFyq4gVWlfA>
    <xmx:PRSsY-Z5cCl61wtincLaEg8bwRmqW9A9oaoPjqXf1OAua0DugdH6pA>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Dec 2022 05:02:35 -0500 (EST)
Message-ID: <6002eecf-124b-743c-ff8d-dd3d0b9a5610@ryhl.io>
Date:   Wed, 28 Dec 2022 11:04:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
From:   Alice Ryhl <alice@ryhl.io>
Subject: Re: [PATCH 6/7] rust: sync: introduce `UniqueArc`
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org
References: <20221228060346.352362-1-wedsonaf@gmail.com>
 <20221228060346.352362-6-wedsonaf@gmail.com>
Content-Language: en-US
In-Reply-To: <20221228060346.352362-6-wedsonaf@gmail.com>
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
> Since `Arc<T>` does not allow mutating `T` directly (i.e., without inner
> mutability), it is currently not possible to do some initialisation of
> `T` post construction but before being shared.
> 
> `UniqueArc<T>` addresses this problem essentially being an `Arc<T>` that
> has a refcount of 1 and is therefore writable. Once initialisation is
> completed, it can be transitioned (without failure paths) into an
> `Arc<T>`.
> 
> Suggested-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> ---
>   rust/kernel/sync.rs     |   2 +-
>   rust/kernel/sync/arc.rs | 152 +++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 151 insertions(+), 3 deletions(-)
> 
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index 5de03ea83ea1..33da23e3076d 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -7,4 +7,4 @@
>   
>   mod arc;
>   
> -pub use arc::{Arc, ArcBorrow};
> +pub use arc::{Arc, ArcBorrow, UniqueArc};
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index 84f31c85a513..832bafc74a90 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -19,8 +19,9 @@ use crate::{bindings, error::Result, types::Opaque};
>   use alloc::boxed::Box;
>   use core::{
>       marker::{PhantomData, Unsize},
> -    mem::ManuallyDrop,
> -    ops::Deref,
> +    mem::{ManuallyDrop, MaybeUninit},
> +    ops::{Deref, DerefMut},
> +    pin::Pin,
>       ptr::NonNull,
>   };
>   
> @@ -222,6 +223,19 @@ impl<T: ?Sized> Drop for Arc<T> {
>       }
>   }
>   
> +impl<T: ?Sized> From<UniqueArc<T>> for Arc<T> {
> +    fn from(item: UniqueArc<T>) -> Self {
> +        item.inner
> +    }
> +}
> +
> +impl<T: ?Sized> From<Pin<UniqueArc<T>>> for Arc<T> {
> +    fn from(item: Pin<UniqueArc<T>>) -> Self {
> +        // SAFETY: The type invariants of `Arc` guarantee that the data is pinned.
> +        unsafe { Pin::into_inner_unchecked(item).inner }
> +    }
> +}
> +
>   /// A borrowed reference to an [`Arc`] instance.
>   ///
>   /// For cases when one doesn't ever need to increment the refcount on the allocation, it is simpler
> @@ -328,3 +342,137 @@ impl<T: ?Sized> Deref for ArcBorrow<'_, T> {
>           unsafe { &self.inner.as_ref().data }
>       }
>   }
> +
> +/// A refcounted object that is known to have a refcount of 1.
> +///
> +/// It is mutable and can be converted to an [`Arc`] so that it can be shared.
> +///
> +/// # Invariants
> +///
> +/// `inner` always has a reference count of 1.
> +///
> +/// # Examples
> +///
> +/// In the following example, we make changes to the inner object before turning it into an
> +/// `Arc<Test>` object (after which point, it cannot be mutated directly). Note that `x.into()`
> +/// cannot fail.
> +///
> +/// ```
> +/// use kernel::sync::{Arc, UniqueArc};
> +///
> +/// struct Example {
> +///     a: u32,
> +///     b: u32,
> +/// }
> +///
> +/// fn test() -> Result<Arc<Example>> {
> +///     let mut x = UniqueArc::try_new(Example { a: 10, b: 20 })?;
> +///     x.a += 1;
> +///     x.b += 1;
> +///     Ok(x.into())
> +/// }
> +///
> +/// # test().unwrap();
> +/// ```
> +///
> +/// In the following example we first allocate memory for a ref-counted `Example` but we don't
> +/// initialise it on allocation. We do initialise it later with a call to [`UniqueArc::write`],
> +/// followed by a conversion to `Arc<Example>`. This is particularly useful when allocation happens
> +/// in one context (e.g., sleepable) and initialisation in another (e.g., atomic):
> +///
> +/// ```
> +/// use kernel::sync::{Arc, UniqueArc};
> +///
> +/// struct Example {
> +///     a: u32,
> +///     b: u32,
> +/// }
> +///
> +/// fn test() -> Result<Arc<Example>> {
> +///     let x = UniqueArc::try_new_uninit()?;
> +///     Ok(x.write(Example { a: 10, b: 20 }).into())
> +/// }
> +///
> +/// # test().unwrap();
> +/// ```
> +///
> +/// In the last example below, the caller gets a pinned instance of `Example` while converting to
> +/// `Arc<Example>`; this is useful in scenarios where one needs a pinned reference during
> +/// initialisation, for example, when initialising fields that are wrapped in locks.
> +///
> +/// ```
> +/// use kernel::sync::{Arc, UniqueArc};
> +///
> +/// struct Example {
> +///     a: u32,
> +///     b: u32,
> +/// }
> +///
> +/// fn test() -> Result<Arc<Example>> {
> +///     let mut pinned = Pin::from(UniqueArc::try_new(Example { a: 10, b: 20 })?);
> +///     // We can modify `pinned` because it is `Unpin`.
> +///     pinned.as_mut().a += 1;
> +///     Ok(pinned.into())
> +/// }
> +///
> +/// # test().unwrap();
> +/// ```
> +pub struct UniqueArc<T: ?Sized> {
> +    inner: Arc<T>,
> +}
> +
> +impl<T> UniqueArc<T> {
> +    /// Tries to allocate a new [`UniqueArc`] instance.
> +    pub fn try_new(value: T) -> Result<Self> {
> +        Ok(Self {
> +            // INVARIANT: The newly-created object has a ref-count of 1.
> +            inner: Arc::try_new(value)?,
> +        })
> +    }
> +
> +    /// Tries to allocate a new [`UniqueArc`] instance whose contents are not initialised yet.
> +    pub fn try_new_uninit() -> Result<UniqueArc<MaybeUninit<T>>> {
> +        Ok(UniqueArc::<MaybeUninit<T>> {
> +            // INVARIANT: The newly-created object has a ref-count of 1.
> +            inner: Arc::try_new(MaybeUninit::uninit())?,
> +        })
> +    }
> +}
> +
> +impl<T> UniqueArc<MaybeUninit<T>> {
> +    /// Converts a `UniqueArc<MaybeUninit<T>>` into a `UniqueArc<T>` by writing a value into it.
> +    pub fn write(mut self, value: T) -> UniqueArc<T> {
> +        self.deref_mut().write(value);
> +        let inner = ManuallyDrop::new(self).inner.ptr;
> +        UniqueArc {
> +            // SAFETY: The new `Arc` is taking over `ptr` from `self.inner` (which won't be
> +            // dropped). The types are compatible because `MaybeUninit<T>` is compatible with `T`.
> +            inner: unsafe { Arc::from_inner(inner.cast()) },
> +        }
> +    }
> +}
> +
> +impl<T: ?Sized> From<UniqueArc<T>> for Pin<UniqueArc<T>> {
> +    fn from(obj: UniqueArc<T>) -> Self {
> +        // SAFETY: It is not possible to move/replace `T` inside a `Pin<UniqueArc<T>>` (unless `T`
> +        // is `Unpin`), so it is ok to convert it to `Pin<UniqueArc<T>>`.
> +        unsafe { Pin::new_unchecked(obj) }
> +    }
> +}
> +
> +impl<T: ?Sized> Deref for UniqueArc<T> {
> +    type Target = T;
> +
> +    fn deref(&self) -> &Self::Target {
> +        self.inner.deref()
> +    }
> +}
> +
> +impl<T: ?Sized> DerefMut for UniqueArc<T> {
> +    fn deref_mut(&mut self) -> &mut Self::Target {
> +        // SAFETY: By the `Arc` type invariant, there is necessarily a reference to the object, so
> +        // it is safe to dereference it. Additionally, we know there is only one reference when
> +        // it's inside a `UniqueArc`, so it is safe to get a mutable reference.
> +        unsafe { &mut self.inner.ptr.as_mut().data }
> +    }
> +}
