Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB5165750C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 11:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbiL1KDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 05:03:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbiL1KCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 05:02:55 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC9C101C9;
        Wed, 28 Dec 2022 02:02:44 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 663035C0158;
        Wed, 28 Dec 2022 05:02:44 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 28 Dec 2022 05:02:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1672221764; x=
        1672308164; bh=jSRpP9rGMkucfN9dX9X+hnk+p0MUJjCnp64vYbdh9pM=; b=j
        4URDuUcfyV36w4pJhpNNycBW7URLHYSR/N1vPJmA3S4bLmASQ41fE06HNq8R1y08
        cIFJni7lEQobVyvJ6Qq/V4LM0Ztkfc3fbXgwi30cmVpDpd8FGBd79166ZKy189HI
        pNkv90C9xEGnigfCdtKgP2axCmLBG8widI+JNkzNxkNgfMVVpK8qflM9b0xzCNys
        Czk/iyh526nSAFf77NFjiGg+CKX0+oJ5sSocSSb7LszHado6P58kBFqDEteL3IAw
        +SIhqeiTFS1/bveynDNPfDytf059JRQf5XF/sil1s7GkBEhl5sfUCTwRPAD/nc2G
        DZC4v1PCbzQOM4zpCQCUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1672221764; x=
        1672308164; bh=jSRpP9rGMkucfN9dX9X+hnk+p0MUJjCnp64vYbdh9pM=; b=w
        M+UQyoLyGP5wIoRgbk11LOf8y6U7SK0duhKBT1LGaIQ5oXaUeC+GG0Af2q064uOG
        Iod5iLfdbsoQVqQfL4f9XPBTykY0nELtjzmozTenJn2yACn2sUyfQFd98gmqA0G5
        Y3jS0uG9Fpft6iHLutef5OASTQkkFYE6M64UbnVF8mcIQJh6k9sPAdbrhr+xnnnX
        1QfJ3VGvHYcVzxofcmumZLuI18SbCM2QYDIEqQ2ci9i9HgrnFFKS6c8bm4T/KZf5
        qDE3PC5lx55p2wzda+7yimC9XB+OtZiEx1L5ipfbSLFhLeP4qqBg19ftLftyrg81
        DFBtHmYXNsG82ZuO7y4cQ==
X-ME-Sender: <xms:RBSsY5e-8rpVRLTDEbIdsDAnvEdfiT6QizW45jI5sVFG9PI7aVfKxA>
    <xme:RBSsY3PswJ0bJ__IT5MlMj4aIwmuSV-klwECb_ileCkJ1q6Pd3slmNltqhXGygm6F
    94c0RjlU2var0nF2Q>
X-ME-Received: <xmr:RBSsYyhX-CqeZKZWXcniijuAP6MykSSwGR8JXibEKZJ4OJnAPa2KtmuBZMFLnDkn2wlQKO3al841HTxa7vCVxfODpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedriedvgdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfhuffvvehfjggtgfesthejredttdefjeenucfhrhhomheptehlihgt
    vgcutfihhhhluceorghlihgtvgesrhihhhhlrdhioheqnecuggftrfgrthhtvghrnhephf
    ehueeileevjeefkeetvdffveffudeuhffgtedvuefgiefgiedvjeegvdejleejnecuvehl
    uhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheprghlihgtvgesrh
    ihhhhlrdhioh
X-ME-Proxy: <xmx:RBSsYy94zrdbdr4pUt1V9cUtzhzMzHXM5XDyitB4z7fCwL4AZUTaXQ>
    <xmx:RBSsY1sqe4xCvYYVtuBlj7gtQAJ-A2jQMQUXVgzC0BfCquPePrTk7Q>
    <xmx:RBSsYxFnSe874ccEfB_tcL_-65SU8L_R6xYiUAI8zTqVBAYUtkJ_GA>
    <xmx:RBSsY5j3-AQrPo7XEEP-78dX8wv0odFUifmJAGnbEUVMG7HoFS3UBg>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Dec 2022 05:02:42 -0500 (EST)
Message-ID: <85d430e2-1740-3392-451d-566976bfb5da@ryhl.io>
Date:   Wed, 28 Dec 2022 11:04:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
From:   Alice Ryhl <alice@ryhl.io>
Subject: Re: [PATCH 7/7] rust: sync: add support for dispatching on Arc and
 ArcBorrow.
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org
References: <20221228060346.352362-1-wedsonaf@gmail.com>
 <20221228060346.352362-7-wedsonaf@gmail.com>
Content-Language: en-US
In-Reply-To: <20221228060346.352362-7-wedsonaf@gmail.com>
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
> Trait objects (`dyn T`) require trait `T` to be "object safe". One of
> the requirements for "object safety" is that the receiver have one of
> the allowed types. This commit adds `Arc<T>` and `ArcBorrow<'_, T>` to
> the list of allowed types.
> 
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> ---
>   rust/kernel/lib.rs      |  1 +
>   rust/kernel/sync/arc.rs | 20 ++++++++++++++++++--
>   2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 4bde65e7b06b..e0b0e953907d 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -15,6 +15,7 @@
>   #![feature(allocator_api)]
>   #![feature(coerce_unsized)]
>   #![feature(core_ffi_c)]
> +#![feature(dispatch_from_dyn)]
>   #![feature(receiver_trait)]
>   #![feature(unsize)]
>   
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index 832bafc74a90..ff73f9240ca1 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -92,9 +92,15 @@ use core::{
>   /// Coercion from `Arc<Example>` to `Arc<dyn MyTrait>`:
>   ///
>   /// ```
> -/// use kernel::sync::Arc;
> +/// use kernel::sync::{Arc, ArcBorrow};
> +///
> +/// trait MyTrait {
> +///     // Trait has a function whose `self` type is `Arc<Self>`.
> +///     fn example1(self: Arc<Self>) {}
>   ///
> -/// trait MyTrait {}
> +///     // Trait has a function whose `self` type is `ArcBorrow<'_, Self>`.
> +///     fn example2(self: ArcBorrow<'_, Self>) {}
> +/// }
>   ///
>   /// struct Example;
>   /// impl MyTrait for Example {}
> @@ -123,6 +129,9 @@ impl<T: ?Sized> core::ops::Receiver for Arc<T> {}
>   // dynamically-sized type (DST) `U`.
>   impl<T: ?Sized + Unsize<U>, U: ?Sized> core::ops::CoerceUnsized<Arc<U>> for Arc<T> {}
>   
> +// This is to allow `Arc<U>` to be dispatched on when `Arc<T>` can be coerced into `Arc<U>`.
> +impl<T: ?Sized + Unsize<U>, U: ?Sized> core::ops::DispatchFromDyn<Arc<U>> for Arc<T> {}
> +
>   // SAFETY: It is safe to send `Arc<T>` to another thread when the underlying `T` is `Sync` because
>   // it effectively means sharing `&T` (which is safe because `T` is `Sync`); additionally, it needs
>   // `T` to be `Send` because any thread that has an `Arc<T>` may ultimately access `T` directly, for
> @@ -297,6 +306,13 @@ pub struct ArcBorrow<'a, T: ?Sized + 'a> {
>   // This is to allow [`ArcBorrow`] (and variants) to be used as the type of `self`.
>   impl<T: ?Sized> core::ops::Receiver for ArcBorrow<'_, T> {}
>   
> +// This is to allow `ArcBorrow<U>` to be dispatched on when `ArcBorrow<T>` can be coerced into
> +// `ArcBorrow<U>`.
> +impl<T: ?Sized + Unsize<U>, U: ?Sized> core::ops::DispatchFromDyn<ArcBorrow<'_, U>>
> +    for ArcBorrow<'_, T>
> +{
> +}
> +
>   impl<T: ?Sized> Clone for ArcBorrow<'_, T> {
>       fn clone(&self) -> Self {
>           *self
