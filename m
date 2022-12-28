Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209A765750A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 11:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbiL1KDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 05:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbiL1KCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 05:02:40 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276FA101CA;
        Wed, 28 Dec 2022 02:02:31 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 8380D5C00E0;
        Wed, 28 Dec 2022 05:02:30 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 28 Dec 2022 05:02:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1672221750; x=
        1672308150; bh=scLhASwGkwPallCX/RDeVmQQLR5UFqve9DQE5NCPGd0=; b=Y
        NPEj2kDgPgTKMR9pv+BAwdbWzRk+3O+Feq/MYXQYcn7C/9+eVKi9t3EYKj+dIQAy
        HIsHBBr+sHWQ9R2IGjBtf1c/wTTSP2mJgQ/N+5c6+fjAtkJ00htoblc1bRkmCfEZ
        N82a8Nid/WKfTlLTfzCh5uxK7uV0EM41Lfiox34QKZO2je3q5v2wax/GQoA7Dokj
        b7dCUIAoNRfKwkycwZm2ZhFWsDDWHMNcxP27t9ZZ7WLA8MpKs9ybjlJCIir4EojK
        AFSQODaOIfqy4PCiFOpS1Rvdd9EicLGKh3siXU0gfTPPIvYVjyoduT0FoRQEHX/e
        P8yyTmupLSvKtB/LLXo+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1672221750; x=
        1672308150; bh=scLhASwGkwPallCX/RDeVmQQLR5UFqve9DQE5NCPGd0=; b=i
        pfNBC3HOmaDLg04a7YS25WxxFAT1+y4qMiP5GY0TXb9HT6YMUB5geREo6N4A/KEs
        IFoBx/+xvrQfF9pQqTw/32nDQNiWC4HPCUj6hyVVXDL3QakDrbh+zi/+7mMjiDpL
        dWmo5Mov9PPT7oE2oGZMBVXWE08rgSYNWDwC9ZKG7pP3B9VtWCYB59HIiMXe62jA
        E5lAzlBLc6d7gSW7LKbh0t8vP+meA/x4yH90SifjhLazr2Mf2epcnOFc+aw+wB1H
        apgt0heHyHwpfSG8gI1xp7gwAZkO5MLUkwgIB2jWR+L2/URlmN0LytW3bpp82DPz
        kz3k4wSA6YpWgu+1H7jnw==
X-ME-Sender: <xms:NhSsY0hFGW69KISKaKRLH6r5eJXjXEXcwAfXJ4vFz4JA-wCaRcBx2w>
    <xme:NhSsY9BLVyuUlHGPaoXrRezNV0Y4193XatWJ2ZTvNHg2ZBDuNN058JLZDHMSkxm4x
    c7GiIoixfyy-9UtNA>
X-ME-Received: <xmr:NhSsY8F_aB3afAELPHdhgA7XF2y74qkj22Gd1DlMfsDyykctTTRHENxglOUbnI12nENXaIQBgSlMxZ0oBsB11Ldi3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedriedvgdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfhuffvvehfjggtgfesthejredttdefjeenucfhrhhomheptehlihgt
    vgcutfihhhhluceorghlihgtvgesrhihhhhlrdhioheqnecuggftrfgrthhtvghrnhephf
    ehueeileevjeefkeetvdffveffudeuhffgtedvuefgiefgiedvjeegvdejleejnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihgtvgesrh
    ihhhhlrdhioh
X-ME-Proxy: <xmx:NhSsY1Q3FdETOTRnlzjBFYKj_ZkbB-Gap20aWdIAmWigSrnENBALLQ>
    <xmx:NhSsYxzLcSvXHRmsOkXRzUOQjFQIjA5R4zTsH4wpsxSKYncu-_5V-Q>
    <xmx:NhSsYz4_pcL6r01GniUoa37gt56A5CCxyyNQBVrjBsBuvU2FXHnE1Q>
    <xmx:NhSsY4mMAjeBLprqZGjZi7TMTC8Yg7ii278CqdjaLqTHS4rbEB8y_A>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Dec 2022 05:02:28 -0500 (EST)
Message-ID: <1643d84c-cd6a-6142-f7e9-f943a0489276@ryhl.io>
Date:   Wed, 28 Dec 2022 11:04:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
From:   Alice Ryhl <alice@ryhl.io>
Subject: Re: [PATCH 5/7] rust: sync: allow type of `self` to be `ArcBorrow<T>`
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org
References: <20221228060346.352362-1-wedsonaf@gmail.com>
 <20221228060346.352362-5-wedsonaf@gmail.com>
Content-Language: en-US
In-Reply-To: <20221228060346.352362-5-wedsonaf@gmail.com>
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
> This allows associated functions whose `self` argument has
> `ArcBorrow<T>` as their type. This, in turn, allows callers to use the
> dot syntax to make calls.
> 
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> ---
>   rust/kernel/sync/arc.rs | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index f68bfc02c81a..84f31c85a513 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -255,11 +255,34 @@ impl<T: ?Sized> Drop for Arc<T> {
>   /// // Assert that both `obj` and `cloned` point to the same underlying object.
>   /// assert!(core::ptr::eq(&*obj, &*cloned));
>   /// ```
> +///
> +/// Using `ArcBorrow<T>` as the type of `self`:
> +///
> +/// ```
> +/// use crate::sync::{Arc, ArcBorrow};
> +///
> +/// struct Example {
> +///     a: u32,
> +///     b: u32,
> +/// }
> +///
> +/// impl Example {
> +///     fn use_reference(self: ArcBorrow<'_, Self>) {
> +///         // ...
> +///     }
> +/// }
> +///
> +/// let obj = Arc::try_new(Example { a: 10, b: 20 })?;
> +/// obj.as_arc_borrow().use_reference();
> +/// ```
>   pub struct ArcBorrow<'a, T: ?Sized + 'a> {
>       inner: NonNull<ArcInner<T>>,
>       _p: PhantomData<&'a ()>,
>   }
>   
> +// This is to allow [`ArcBorrow`] (and variants) to be used as the type of `self`.
> +impl<T: ?Sized> core::ops::Receiver for ArcBorrow<'_, T> {}
> +
>   impl<T: ?Sized> Clone for ArcBorrow<'_, T> {
>       fn clone(&self) -> Self {
>           *self
