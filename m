Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8C66D06D0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 15:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbjC3Ndt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 09:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjC3Ndk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 09:33:40 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F070EB74F;
        Thu, 30 Mar 2023 06:33:35 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 67DB13200939;
        Thu, 30 Mar 2023 09:33:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 30 Mar 2023 09:33:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1680183214; x=1680269614; bh=9ygzPkZj+/QrhVUxn7AjaLePZSGPp/lBV08
        Ve5JXUy0=; b=hnUg1NaH3ycxoR4C2zA3uVgbMQmL/VdwFu1a1r0QtUKmUvt6mHw
        dGyP88iA2oo/qc1fvKjRFWOkGkzMEcrPdXwklD03IV57KE61q8WLZIXFToAX9fgX
        rmd++3cvMU5KBc0ICBTcBJNm9+JqZ66nFQGYh4XdPa0gX1wqWNdjlu/UXqhKxDJK
        r2Xcl5bHJwW19ZN2nxHfVlKk4CYfiB/Yqe7s/01vPfM9C1U8PhYzqNPYWUTeU+y0
        6j5kQvyZO0ig3grtqdTPGmmlPMTU/eTV6nmM3JHjmsZUoo57T1728Obf3/ImRAsO
        7M5lJQtOagdK2FgXXBrhgixF2d+9HroCgdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680183214; x=1680269614; bh=9ygzPkZj+/QrhVUxn7AjaLePZSGPp/lBV08
        Ve5JXUy0=; b=AbXXIt8vrSJ4xWEXteeS5P4DHLLI0o4Zfqfd1a0XDdRMzItpNFK
        ElBa39u0+fF8lZHL6xNliNRD63ZZbAZBk9tXcERb2ZdBHaStJLNfzZDJQXf/N8om
        fU/763SiUY9pCbm4sSnNQDjROO5HI0sAVE1K/5nc3GPayHYkWGpNfAE9IjGJYnNc
        Wj/f8Bmp9/YfmF8VCpSWMKs0qf2wHvtsu+bwnzUCnBWmOaVmSEPWF9RFON+FbbOG
        AYtNiVm96pzrkUi6/Vi19sHPfmT7le2Oie0wpaNCrgNCU70fjmdU3EebpsvBGqqI
        n8kAHRl85qLvPQ84tQ8mGkUnTqNnluc/s9g==
X-ME-Sender: <xms:rY8lZIvPtNXwmb7Wo9mzhtmVMc24zN_pyeKbZ2SfbkPL8zE4EEpFkA>
    <xme:rY8lZFdcjZbT0_f6m__o-upaybRL63iV2Ugp3Mew0_1iRGj2G4W7eRevH4Prq1l4i
    8voq8G0xWJ2QPXjRg>
X-ME-Received: <xmr:rY8lZDzTuqTuA4Fmz57hsZNxUHzfjDTvTryhtdn77_A1pFtznDHx8dImB9gbXzjHL_KITe9lZacS_i3Q38ToJfCzcw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehkedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfhffuvfevfhgjtgfgsehtjeertddtfeejnecuhfhrohhmpeetlhhi
    tggvucfthihhlhcuoegrlhhitggvsehrhihhlhdrihhoqeenucggtffrrghtthgvrhhnpe
    dugeelhfehkedvgffgfeffhefgtddvleefieejfeehleejkeetieeuvedtvdevkeenucff
    ohhmrghinheprhhushhtqdhlrghnghdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhitggvsehrhihhlhdrihho
X-ME-Proxy: <xmx:rY8lZLNEhwXV9smQ5mKI5RusVGLmyKhFi0Pc6Dw05rEtLRQthzFHqg>
    <xmx:rY8lZI_WmK1Qi5_9DCXXq8ruJd--uSIxMDfvPtHLtil6QE1JmeQgeg>
    <xmx:rY8lZDVxkolVhcJCpFJzeYpqaVhbxYLUfrV2fXHY2ZJccxhel41NiQ>
    <xmx:ro8lZMQC9bd9hyJgcYmH0Lql-5WBErtbkQ9uYFnHEX6nxoHwt9_NfA>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Mar 2023 09:33:31 -0400 (EDT)
Message-ID: <ce17f68e-521f-f55e-8ae2-35bcd6ebd709@ryhl.io>
Date:   Thu, 30 Mar 2023 15:33:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
From:   Alice Ryhl <alice@ryhl.io>
Subject: Re: [PATCH v3 04/13] rust: add pin-init API core
To:     y86-dev@protonmail.com
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
References: <20230329223239.138757-1-y86-dev@protonmail.com>
 <20230329223239.138757-5-y86-dev@protonmail.com>
Content-Language: en-US
In-Reply-To: <20230329223239.138757-5-y86-dev@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/23 00:33, y86-dev@protonmail.com wrote:
> From: Benno Lossin <y86-dev@protonmail.com>
> 
> This API is used to facilitate safe pinned initialization of structs. It
> replaces cumbersome `unsafe` manual initialization with elegant safe macro
> invocations.
> 
> Due to the size of this change it has been split into six commits:
> 1. This commit introducing the basic public interface: traits and
>     functions to represent and create initializers.
> 2. Adds the `#[pin_data]`, `pin_init!`, `try_pin_init!`, `init!` and
>     `try_init!` macros along with their internal types.
> 3. Adds the `InPlaceInit` trait that allows using an initializer to create
>     an object inside of a `Box<T>` and other smart pointers.
> 4. Adds the `PinnedDrop` trait and adds macro support for it in
>     the `#[pin_data]` macro.
> 5. Adds the `stack_pin_init!` macro allowing to pin-initialize a struct on
>     the stack.
> 6. Adds the `Zeroable` trait and `init::zeroed` function to initialize
>     types that have `0x00` in all bytes as a valid bit pattern.
> 
> Co-developed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

> +//! Aside from pinned initialization, this API also supports in-place construction without pinning,
> +//! the marcos/types/functions are generally named like the pinned variants without the `pin`
> +//! prefix.

Typo: Should be "macros".

> +type Invariant<T> = PhantomData<fn(*mut T) -> *mut T>;

I think it would make sense to include a link to the nomicon on the 
documentation for the Invariant type.

E.g. this link: https://doc.rust-lang.org/nomicon/subtyping.html

> +// This is the module-internal type implementing `PinInit` and `Init`. It is unsafe to create this
> +// type, since the closure needs to fulfill the same safety requirement as the
> +// `__pinned_init`/`__init` functions.
> +struct InitClosure<F, T: ?Sized, E>(F, Invariant<(E, T)>);

Documentation for a type should use /// rather than //.

I think it would help to call out explicitly in the documentation on 
this type that it is an implementation detail of the 
pin_init_from_closure and init_from_closure methods.
