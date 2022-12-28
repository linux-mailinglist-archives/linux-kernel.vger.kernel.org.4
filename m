Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2BCB657507
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 11:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbiL1KCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 05:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbiL1KCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 05:02:24 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF47FD2F;
        Wed, 28 Dec 2022 02:02:16 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 0839E5C0036;
        Wed, 28 Dec 2022 05:02:16 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 28 Dec 2022 05:02:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1672221736; x=
        1672308136; bh=TkPU/CGRI27Oo3Fq12PWBTy5jvk18F/ykpSrjPWPX/A=; b=A
        Fiw6Bi2UEx+0SUtPY2TuVxML6rKYjU4vJqJWvuAjm32Mqa6QozDdHTP0WsLU/AOJ
        Mogf4qF1v83Xk3xhweOYiVMp2Ey0Gf/gJJwVdwJyzBoYFDsUkBOneGRzFWPB1R+F
        vBY2fMM3Y6VnH9IGxM0pZRubHlUQkdPNQGnbINVPqi25VjtlQ84Opt8yzhAEOFrp
        teJ04jS9TD6Y9IytHVyMa52r9ZVvrhiAtw1Cg+BAiD8cPd+ZnyjPnLr9kW41reGj
        DXWnlg5Q3FzERiLZ2D+cy0uIdm+xK0+v0J6/0kQs+jEPLahU8FUGo/xxRZWBeOjP
        IbwjgYixdvP9GihvoUgeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1672221736; x=
        1672308136; bh=TkPU/CGRI27Oo3Fq12PWBTy5jvk18F/ykpSrjPWPX/A=; b=x
        HH5TO0NRrbWtb2CitL+k55JRHfRfPyF9gQAkImhehBflexJ4NJ7UZh+0Sl+0PP3P
        +t/mBhMzRn+56pdDC2klbOM09xpIMlVCiZ/htmEkxAmVW9W7yorhP1yOJvrQZe2P
        VhUuL/fh8PKhkn0Ey54jhM0IaM3pxP0fi3COAO+melTx33jeHixObvsaDo8zsfGR
        wppgO2sg6aBXWXqdUlGeX/lysuZaCEsI14LLpxno04Qn+x6l2EX986lrurjmc4Zu
        l1ymexvQ7hoxMT2z20KlRIV0aA9Q8aZjZATVWpobUBYCUj446J69/+Si/gYNxnem
        w33h7s3zzz3o+t0l2RVEQ==
X-ME-Sender: <xms:JxSsYw2DEVsJZMMKM2dVuHQNSa7CqJ9qUJ-awC5jysQVMJ77IGDWFA>
    <xme:JxSsY7GWJOCYn9PUcB2ulLB1tU3UaYDoxn4h7s07V4XYNEOXgSi2y5zPIbPXptDjH
    -HeSBqJguNAFPmveQ>
X-ME-Received: <xmr:JxSsY46Hg69pY50bdY2H2_T4f1BpOnrBvwZqI8C3dY5xcXNso7Uje6tnTMGsm_EIvmDrMrsK3UAmci8snUSw91P7fA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedriedvgddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfhuffvvehfjggtgfesthejredttdefjeenucfhrhhomheptehlihgt
    vgcutfihhhhluceorghlihgtvgesrhihhhhlrdhioheqnecuggftrfgrthhtvghrnhephf
    ehueeileevjeefkeetvdffveffudeuhffgtedvuefgiefgiedvjeegvdejleejnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihgtvgesrh
    ihhhhlrdhioh
X-ME-Proxy: <xmx:JxSsY523lUYUe4i1npOTZuhFPXyU2kFJp03CkDwglb0nXZGBrxBNNw>
    <xmx:JxSsYzEAtje11DCdO3tbgOhjxkJw5QqvfMOnw1jbc5aJpvTzCtYcMA>
    <xmx:JxSsYy-3vGgm1N9gVkA3gBo9vlVrh1yckfLCu-7zDiR8YtWbrEkTzA>
    <xmx:KBSsY47FyS_Rzv104J8Ge38U-5r5vRtFE7i_13dvYUGoUILRObQv3w>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Dec 2022 05:02:14 -0500 (EST)
Message-ID: <4b496148-86b6-5fbd-ab9b-e303daeb8ee5@ryhl.io>
Date:   Wed, 28 Dec 2022 11:03:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
From:   Alice Ryhl <alice@ryhl.io>
Subject: Re: [PATCH 3/7] rust: sync: allow coercion from `Arc<T>` to `Arc<U>`
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org
References: <20221228060346.352362-1-wedsonaf@gmail.com>
 <20221228060346.352362-3-wedsonaf@gmail.com>
Content-Language: en-US
In-Reply-To: <20221228060346.352362-3-wedsonaf@gmail.com>
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
> The coercion is only allowed if `U` is a compatible dynamically-sized
> type (DST). For example, if we have some type `X` that implements trait
> `Y`, then this allows `Arc<X>` to be coerced into `Arc<dyn Y>`.
> 
> Suggested-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> ---
>   rust/kernel/lib.rs      |  2 ++
>   rust/kernel/sync/arc.rs | 27 ++++++++++++++++++++++++++-
>   2 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 1a10f7c0ddd9..4bde65e7b06b 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -13,8 +13,10 @@
>   
>   #![no_std]
>   #![feature(allocator_api)]
> +#![feature(coerce_unsized)]
>   #![feature(core_ffi_c)]
>   #![feature(receiver_trait)]
> +#![feature(unsize)]
>   
>   // Ensure conditional compilation based on the kernel configuration works;
>   // otherwise we may silently break things like initcall handling.
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index e2eb0e67d483..dbc7596cc3ce 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -17,7 +17,11 @@
>   
>   use crate::{bindings, error::Result, types::Opaque};
>   use alloc::boxed::Box;
> -use core::{marker::PhantomData, ops::Deref, ptr::NonNull};
> +use core::{
> +    marker::{PhantomData, Unsize},
> +    ops::Deref,
> +    ptr::NonNull,
> +};
>   
>   /// A reference-counted pointer to an instance of `T`.
>   ///
> @@ -82,6 +86,23 @@ use core::{marker::PhantomData, ops::Deref, ptr::NonNull};
>   /// obj.use_reference();
>   /// obj.take_over();
>   /// ```
> +///
> +/// Coercion from `Arc<Example>` to `Arc<dyn MyTrait>`:
> +///
> +/// ```
> +/// use kernel::sync::Arc;
> +///
> +/// trait MyTrait {}
> +///
> +/// struct Example;
> +/// impl MyTrait for Example {}
> +///
> +/// // `obj` has type `Arc<Example>`.
> +/// let obj: Arc<Example> = Arc::try_new(Example)?;
> +///
> +/// // `coerced` has type `Arc<dyn MyTrait>`.
> +/// let coerced: Arc<dyn MyTrait> = obj;
> +/// ```
>   pub struct Arc<T: ?Sized> {
>       ptr: NonNull<ArcInner<T>>,
>       _p: PhantomData<ArcInner<T>>,
> @@ -96,6 +117,10 @@ struct ArcInner<T: ?Sized> {
>   // This is to allow [`Arc`] (and variants) to be used as the type of `self`.
>   impl<T: ?Sized> core::ops::Receiver for Arc<T> {}
>   
> +// This is to allow coercion from `Arc<T>` to `Arc<U>` if `T` can be converted to the
> +// dynamically-sized type (DST) `U`.
> +impl<T: ?Sized + Unsize<U>, U: ?Sized> core::ops::CoerceUnsized<Arc<U>> for Arc<T> {}
> +
>   // SAFETY: It is safe to send `Arc<T>` to another thread when the underlying `T` is `Sync` because
>   // it effectively means sharing `&T` (which is safe because `T` is `Sync`); additionally, it needs
>   // `T` to be `Send` because any thread that has an `Arc<T>` may ultimately access `T` directly, for
