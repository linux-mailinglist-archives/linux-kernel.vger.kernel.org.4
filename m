Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7726D6D4FC0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 19:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbjDCR57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 13:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbjDCR5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 13:57:43 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FA53ABF;
        Mon,  3 Apr 2023 10:57:21 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id C036D5C00FB;
        Mon,  3 Apr 2023 13:57:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 03 Apr 2023 13:57:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1680544638; x=1680631038; bh=VcOAbiou2sds8XmkBJZfmWlB/w58JiopJQl
        NifYn9ps=; b=XEf/WjSFOIGtGKSpCahHgDurfBBBmzz9FNvnKqucIKCtv627Tm0
        3fwImD/CpJtnEhK2kCTrEuOILwnjETklimXV11W9OuXworh6uGaA5z28BuQ9pEpO
        8frcRm6oBi/lTVrCzPXsXs/tcEZneI+KHIenl1RD0zKbL0cOwkJ1nwqIr6jQTmbs
        Po26Ot19oWY7aJOnT89tqyMUbtqJxlmEPcI0mthvJWydHc7zkgHZ+I+NPY5SbnSq
        aVd7YkNb9RnQAOrwQ7gQuqAIS3dAyRxxwmh0wwnNJREm/6Z/8l7KioTGOWhNa2T+
        XIg2EWFcbQiQk2okWAVhvDllbwSu32GAgmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680544638; x=1680631038; bh=VcOAbiou2sds8XmkBJZfmWlB/w58JiopJQl
        NifYn9ps=; b=tTDekSXhNaLBgN09YhgbTEAGEaaKJt8IYGu/M1GG4xEwttZs0HM
        ckq9lzNYpf07urKSjDaJ0rhGsINAlW727V7KKYulU/9DApy/hZuvC1IlznzbZw4t
        PMt/AvfjSamDDsqOXyl/MnrDCkGVWWQ5fTV975g4KQ0zp3zSBH999evdMKSVp8rx
        TLnYgiHkxy/BEWsQnI7ReKsBcD41oAPHZcO2YE9KInWOfbNpBQuWn40hlu7F5uhH
        WDn90qaRGJKxthCO2SNO+I0NEfwith2cAXYI3gY5Nir7s7AnN0y5KWfdUraCEnR8
        ZaEKMOPAQpV6a12mDH+hlt6yd0E/TQWBvwA==
X-ME-Sender: <xms:fhMrZIlFKGynf01f1xaTgjzwMz3qsuq5CEyh9Jk7mznjhPSpewMi0w>
    <xme:fhMrZH3N4Gs7z0Q_lUTmX0XyN2u7yy-J2hJ_FMlpIE2QX7AxNKq6c3QxKZbim5VS2
    zTACp-EBmQeyV6OGQ>
X-ME-Received: <xmr:fhMrZGok8rMsJNArDiKKRvoORBYGoklf5e80K6Xq4cAr5LSRppe1EegV2xAChR_j8P4tiIQyofbb30xlAcrJMa_aaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeijedguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfhuffvvehfjggtgfesthejredttdefjeenucfhrhhomheptehl
    ihgtvgcutfihhhhluceorghlihgtvgesrhihhhhlrdhioheqnecuggftrfgrthhtvghrnh
    ephfehueeileevjeefkeetvdffveffudeuhffgtedvuefgiefgiedvjeegvdejleejnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheprghlihgtvg
    esrhihhhhlrdhioh
X-ME-Proxy: <xmx:fhMrZEkpbO0wc8IRyQ8kGuqYjhob0tZ-6eFgo_qgf2B9Vz-ZHH3Xtg>
    <xmx:fhMrZG3utN3Zq3yqNH6ohZ25txYd-MI8I4bMGiofKmkvTLzbHrkaGA>
    <xmx:fhMrZLsOosfquF39mZaIjlVXr1cyiuH4-fxrP2ghjckgwgZH0UELfw>
    <xmx:fhMrZPv1ly7AkrY_u9EpmODPFUjOS6XU9CB1fr25H-wT8Vt88Ymjhg>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Apr 2023 13:57:16 -0400 (EDT)
Message-ID: <93225277-91a8-a1b5-abda-e936cd50d6a3@ryhl.io>
Date:   Mon, 3 Apr 2023 19:56:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
From:   Alice Ryhl <alice@ryhl.io>
Subject: Re: [PATCH v5 10/15] rust: init: add `stack_pin_init!` macro
To:     Benno Lossin <y86-dev@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
References: <20230403154422.168633-1-y86-dev@protonmail.com>
 <20230403160511.174894-3-y86-dev@protonmail.com>
Content-Language: en-US
In-Reply-To: <20230403160511.174894-3-y86-dev@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/23 18:05, Benno Lossin wrote:
> The `stack_pin_init!` macro allows pin-initializing a value on the
> stack. It accepts a `impl PinInit<T, E>` to initialize a `T`. It allows
> propagating any errors via `?` or handling it normally via `match`.
> 
> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: Andreas Hindborg <a.hindborg@samsung.com>
> Cc: Gary Guo <gary@garyguo.net>
> ---

If you fix the issue below, then you may add
Reviewed-by: Alice Ryhl <aliceryhl@google.com>

> +    /// Initializes the contents and returns the result.
> +    #[inline]
> +    pub fn init<E>(self: Pin<&mut Self>, init: impl PinInit<T, E>) -> Result<Pin<&mut T>, E> {
> +        // SAFETY: We never move out of `this`.
> +        let this = unsafe { Pin::into_inner_unchecked(self) };
> +        // The value is currently initialized, so it needs to be dropped before we can reuse
> +        // the memory (this is a safety guarantee of `Pin`).
> +        if this.1 {
> +            // SAFETY: `this.1` is true and we set it to false after this.
> +            unsafe { this.0.assume_init_drop() };
> +            this.1 = false;
> +        }

This would double-free the value if `assume_init_drop` panics. I know 
that we configure panics to abort the kernel, but someone could copy 
this into another codebase and then they would have this issue.

You can fix it by setting `this.1` to false *before* calling 
`assume_init_drop`.
