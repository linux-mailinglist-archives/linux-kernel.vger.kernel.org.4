Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873B06D1235
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 00:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjC3Wgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 18:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjC3Wgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 18:36:33 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD57DD308;
        Thu, 30 Mar 2023 15:36:31 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 0735832001C6;
        Thu, 30 Mar 2023 18:36:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 30 Mar 2023 18:36:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1680215787; x=1680302187; bh=XeSiGqg2CwSebiVN2ce25LntTFIojl0mClJ
        DW8Z7Pok=; b=EhX3fAjN9Fr6yV5pb1z4rpHbLGkrwoLM8QUuEjyj2wbsJiahwSf
        5pn/IcG1Xkzs7+cCmzwtDFzMbxn3phciU8bJ6pE+3OphkxwjjnW72F5Yd9p7D6U0
        sUApF7bwzDyubK9ZcIAdbY3Eb41cfXF8n83df9Oj1RBsO/q8nFNLe1i+Y4KW/37H
        aQyvqinyp4LJes6GYg0QMbbr90pHG4FhTmzTUCz4JqnroJHDOngzN1jNOdMy6XrR
        VaI5JgTACJzKRXLrCUiK/N6pcURO/Tzq1NfZct7gDwhzIZ79kI3oTj1eBIlTjMLg
        vqL7UH94gmOtS2H6uvUeQfE4G3SAPMEyAMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680215787; x=1680302187; bh=XeSiGqg2CwSebiVN2ce25LntTFIojl0mClJ
        DW8Z7Pok=; b=AUDSR6OOiTzX3D0VrICdZyoxWH/+nv372dXGYxrDMobV6tNE6GB
        JIcKqdRiWzcnZVoXJqPVoNEa+HEbYlPnu6boCvfUnBGltn+QEu73lh08+N8mUfRd
        fFZYZ7n7aSPehdHWIQxFMqyiUCnuA5bEH/5J8uptBKTI86bGxQaazUaXV7GO3M7+
        kLW6yKpfer89RmuLaeotBg9LChnEtFAYILj7dp80Lg27ETXI8BovW4NFenID21hv
        PAkBPPA/DedCf8gjfoFdwkMK2kh18yNoIsQDHLvNLqdLeKdzdObp1GwJOhEi44p3
        pPYqL61+6m9Iy+ogDn86vlOzBpoA+0LBn3Q==
X-ME-Sender: <xms:6w4mZOd1D33aNjScThSJYDb9UhE92zaHcf3uE8IVB-dp-tNQ3vmVMQ>
    <xme:6w4mZIPZbG52gP8QFFc_YPzh2GHnr9WEPAinG6FTy9BPSqXxidYj4I8IAZmGv5BcU
    EYe6vH6T47JWNJvvA>
X-ME-Received: <xmr:6w4mZPim6OVR0tUkJ_EffM-fZErgLNfFp4LlXa6Up0ixI4F55k-j0it8JGOt2CpuxM70Ufe0eO6r_Y9nyQMds9wTMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeitddguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeetlhhi
    tggvucfthihhlhcuoegrlhhitggvsehrhihhlhdrihhoqeenucggtffrrghtthgvrhhnpe
    ehudduvdetkedvkedtudeludfgfffhudegjeeguedvvedtteevjeehheeiffefgeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhitggvse
    hrhihhlhdrihho
X-ME-Proxy: <xmx:6w4mZL9TlSubGRc3uJlgmLXPTh90b6iCw3TuXcBskUUhNhbW3mkkgw>
    <xmx:6w4mZKsGKspbVeSuzbKRVhlPRW5otFcj43gHpOtsejVPtp8NabliDg>
    <xmx:6w4mZCEVbcbDcay0IjoRCtqHshdAi5MtVsvQIO5Cd0Qa0Yx11khF5Q>
    <xmx:6w4mZIA9bxFu9R8fjaeVlqfLUKNFp7Cp0vRNh3R_mua4AYcJkIlNmA>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Mar 2023 18:36:25 -0400 (EDT)
Message-ID: <5dd90c62-0dc5-1225-c66c-e8f201cb0d59@ryhl.io>
Date:   Fri, 31 Mar 2023 00:36:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 09/13] rust: init: add `Zeroable` trait and
 `init::zeroed` function
Content-Language: en-US-large
To:     y86-dev@protonmail.com
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
References: <20230329223239.138757-10-y86-dev@protonmail.com>
From:   Alice Ryhl <alice@ryhl.io>
In-Reply-To: <20230329223239.138757-10-y86-dev@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/23 00:33, y86-dev@protonmail.com wrote:
> From: Benno Lossin <y86-dev@protonmail.com>
> 
> Add the `Zeroable` trait which marks types that can be initialized by
> writing `0x00` to every byte of the type. Also add the `init::zeroed`
> function that creates an initializer for a `Zeroable` type that writes
> `0x00` to every byte.
> 
> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

> +impl_zeroable! {
> +    // SAFETY: All primitives that are allowed to be zero.
> +    bool,
> +    char,
> +    u8, u16, u32, u64, u128, usize,
> +    i8, i16, i32, i64, i128, isize,
> +    f32, f64,
> +    // SAFETY: There is nothing to zero.
> +    core::marker::PhantomPinned, Infallible, (),
> +}

Here are some other types it might make sense to add:

  * Option<NonNull<T>>
  * Option<Box<T>>
  * Option<NonZeroU32>
  * PhantomData<T>
  * MaybeUninit<T>

> +
> +// SAFETY: We are allowed to zero padding bytes.
> +unsafe impl<const N: usize, T: Zeroable> Zeroable for [T; N] {}

There are no padding bytes in [T; N].
