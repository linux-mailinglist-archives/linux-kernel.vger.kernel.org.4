Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D378C657506
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 11:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiL1KCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 05:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbiL1KCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 05:02:10 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C095B97;
        Wed, 28 Dec 2022 02:02:09 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 38E795C00C3;
        Wed, 28 Dec 2022 05:02:09 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 28 Dec 2022 05:02:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1672221729; x=
        1672308129; bh=zJ9H10w8qH7GxLiJRMvCYl4baqrj5iP/EW2fYSs9PSs=; b=a
        KUHWAmr7o2bzQngALX/NHEuntIkv1PPeQDCFhsjfa2t8mBAngQJSzZLFxxSquQSp
        jnzulQWKjDAMvkpujaqrIR3bFSlHrQzzerIIz3oduqoMxMDC/l1oneqqagVDYJjI
        dD/zVguOfoYNoJotAGwCWdnLV98JZiZjZraUoUd+dI1DV3HSf4OzSGWhHvpaMBdN
        TQGlWk5M0Ke49ZaQ/SdrGjJ9t5U9NiMIVPjqyHRjp32w0rZVLmf2ITP4uHNYULU/
        4MdGFBe+XuBB2/8RuMZO9r55MAH8yw5D07g43TIIBz7aZ7lTIiXt32l/qZkWYa8G
        AzMnf2gV7lkLL05dr3t8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1672221729; x=
        1672308129; bh=zJ9H10w8qH7GxLiJRMvCYl4baqrj5iP/EW2fYSs9PSs=; b=Z
        5qw//C08QpwpXq9liGB0BlM3E4+52CPMNN1nbTDwqVevOwJl3Vuk1D5QZ7yhaNRD
        SzyHMYUJoeGL/9UZQQX7MoIRRvw1or+2LX4xeZP0/YUop/tqbch2/LVh6OsPBD6c
        1+HMvQ25nR1oZJncMyXxsC+1wdrnlSFyHxt9WdU7oQPBARfr1LRhENUv2Kk/W+7p
        SCCfJh/VO+5l/JclVed2f32xe00GZKiZ8T8B9dgO25PU28vt7dyxSGrpmMdH+JC0
        +uP7t2zB30T7Mh8NJrTFAkCDnoaVpeBoUBrXCm5SWpcHnt55dH/b/Tw1yd1YXXbQ
        sodilPgoAzjGcpsAACOBg==
X-ME-Sender: <xms:IRSsY7UInASBLg7y_lApSHEUtMbpmdtIyCT9NPWmGtN6uQh_ORvw5Q>
    <xme:IRSsYzlvFGsFntaJFJnsv1Cq7ZEhf62lHq1lqTc-_R2hNAUJGGH9QJp6GaftCklgm
    neXAU1sqb9tD5gkZg>
X-ME-Received: <xmr:IRSsY3bpjOHhmsvs9rs7rBN3goXKUgYqzU4cn6g1fp_I0i2cyaR-y-SZ-K5_w9USlvauSzoUHyteLakCankX-2KGMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedriedvgdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfhuffvvehfjggtgfesthejredttdefjeenucfhrhhomheptehlihgt
    vgcutfihhhhluceorghlihgtvgesrhihhhhlrdhioheqnecuggftrfgrthhtvghrnhephf
    ehueeileevjeefkeetvdffveffudeuhffgtedvuefgiefgiedvjeegvdejleejnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihgtvgesrh
    ihhhhlrdhioh
X-ME-Proxy: <xmx:IRSsY2XXanR4La4WR_mpDe6wsmuBGXi-Zrf1lBQq_fX36H6gJN2Whg>
    <xmx:IRSsY1k4YvKY_d-bvmsBVL-OeGgnx_utTnpUqw-CX1js2R26UI9XFw>
    <xmx:IRSsYzeQZBOwcBBCNgwQvTeMoFmsrjJWcAFJAoN_WsKidpXYTKfARQ>
    <xmx:IRSsYzYFIeFHDAcBxuVOTh1tHUTriAtXKNfHbXhNP8952lq1sc8PJg>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Dec 2022 05:02:07 -0500 (EST)
Message-ID: <f0911f15-79df-13a7-a8a3-b6c896ffa982@ryhl.io>
Date:   Wed, 28 Dec 2022 11:03:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
From:   Alice Ryhl <alice@ryhl.io>
Subject: Re: [PATCH 2/7] rust: sync: allow type of `self` to be `Arc<T>` or
 variants
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org
References: <20221228060346.352362-1-wedsonaf@gmail.com>
 <20221228060346.352362-2-wedsonaf@gmail.com>
Content-Language: en-US
In-Reply-To: <20221228060346.352362-2-wedsonaf@gmail.com>
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
> This allows associated functions whose `self` argument has `Arc<T>` or
> variants as their type. This, in turn, allows callers to use the dot
> syntax to make calls.
> 
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> ---
>   rust/kernel/lib.rs      |  1 +
>   rust/kernel/sync/arc.rs | 28 ++++++++++++++++++++++++++++
>   2 files changed, 29 insertions(+)
> 
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index ace064a3702a..1a10f7c0ddd9 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -14,6 +14,7 @@
>   #![no_std]
>   #![feature(allocator_api)]
>   #![feature(core_ffi_c)]
> +#![feature(receiver_trait)]
>   
>   // Ensure conditional compilation based on the kernel configuration works;
>   // otherwise we may silently break things like initcall handling.
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index 22290eb5ab9b..e2eb0e67d483 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -57,6 +57,31 @@ use core::{marker::PhantomData, ops::Deref, ptr::NonNull};
>   ///
>   /// // The refcount drops to zero when `cloned` goes out of scope, and the memory is freed.
>   /// ```
> +///
> +/// Using `Arc<T>` as the type of `self`:
> +///
> +/// ```
> +/// use kernel::sync::Arc;
> +///
> +/// struct Example {
> +///     a: u32,
> +///     b: u32,
> +/// }
> +///
> +/// impl Example {
> +///     fn take_over(self: Arc<Self>) {
> +///         // ...
> +///     }
> +///
> +///     fn use_reference(self: &Arc<Self>) {
> +///         // ...
> +///     }
> +/// }
> +///
> +/// let obj = Arc::try_new(Example { a: 10, b: 20 })?;
> +/// obj.use_reference();
> +/// obj.take_over();
> +/// ```
>   pub struct Arc<T: ?Sized> {
>       ptr: NonNull<ArcInner<T>>,
>       _p: PhantomData<ArcInner<T>>,
> @@ -68,6 +93,9 @@ struct ArcInner<T: ?Sized> {
>       data: T,
>   }
>   
> +// This is to allow [`Arc`] (and variants) to be used as the type of `self`.
> +impl<T: ?Sized> core::ops::Receiver for Arc<T> {}
> +
>   // SAFETY: It is safe to send `Arc<T>` to another thread when the underlying `T` is `Sync` because
>   // it effectively means sharing `&T` (which is safe because `T` is `Sync`); additionally, it needs
>   // `T` to be `Send` because any thread that has an `Arc<T>` may ultimately access `T` directly, for
