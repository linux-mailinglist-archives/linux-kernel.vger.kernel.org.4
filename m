Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478ED6D0819
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 16:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbjC3OWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 10:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbjC3OW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 10:22:27 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C776C65F;
        Thu, 30 Mar 2023 07:21:54 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 3A9893200495;
        Thu, 30 Mar 2023 10:21:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 30 Mar 2023 10:21:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1680186088; x=1680272488; bh=aaHDnGEY8jQWwBiHM0AomkpCoN/1r8C0yPk
        Rgo7kzOI=; b=EHkKTUkv+ZU6d642PnmpxtLiefd1jLRa6aLEbIBZJ//Xw7xFb6c
        ocJWhL+RgkKFlpAUPpap17tuAX81odULLYvUU91brxOKbxnj0nrqy9MElOcKFGVn
        bO9cNNZ77tYEAC0zALL5UM84t9+CpLJw6oulVqFL9wheqoeAfer1QlWYWQqfPjK0
        LkQ3ry/O5qcyo1Ui7NRTlIcgU1n46LjvSE3O9+eJMM0KStMZ1RvFhEt07zeHKLiz
        NeiR9XwLlErMq+WEXJXkjbLMxv2vYVs36FE5bioe3jL/ddC321lxxJGMtauMfK2Q
        pFDH1IK1DI/6HfMx9aDZEPdPx36Rlx6oimQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680186088; x=1680272488; bh=aaHDnGEY8jQWwBiHM0AomkpCoN/1r8C0yPk
        Rgo7kzOI=; b=K3sAiPnwAgatkHpndFCVM+oXEIgS85j2P85doaM33lDqwSPc01x
        UhocjnwJrul9UKtXn3u6JOWP0Vqm6ijMCalG2RbLG3vVbzyI4BgmL9Eji9YKj28r
        IZCStdV8LizaemXBFYXWhbrhgDd88gPfWqvj0saeO1fDSmkpsbhHr2H4cnK/v8Ci
        +hFXtrWb6wW24aKjs+IWdXmQTqIrMxyGK7gvFIPWLSjUJlMzrZv2bHe80bhniER6
        c/nmId1wTut389t9YuZECQkyw067UJW0AckXkyJ1fgV5zFNyaYDLZx+NPx+Ibs6U
        7XyEuL6e02QN+RsQ/ow2v7A9BMIiNEtLiTQ==
X-ME-Sender: <xms:6JolZNcXnXZ7XiZU_4IBe11YdpZNup2eUydwSJMrLEBPelmLQf8QJg>
    <xme:6JolZLNseFiRZtvfWhn8Ur6MYI885UoSISMtUbkd7amhMWkrMxUl-HqoaKcNJK8_g
    VE6pjnOiQ4069AmsA>
X-ME-Received: <xmr:6JolZGhyU0Pg1UMtSJ3KCjz6WlzS8almvWTOrS9Xe8WovwVCwCV_A_X6XUzfzev7j6Ta7M9QIGhsPN1Lh9XB_cgJfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehkedgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeetlhhi
    tggvucfthihhlhcuoegrlhhitggvsehrhihhlhdrihhoqeenucggtffrrghtthgvrhhnpe
    ehudduvdetkedvkedtudeludfgfffhudegjeeguedvvedtteevjeehheeiffefgeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhitggvse
    hrhihhlhdrihho
X-ME-Proxy: <xmx:6JolZG-SFJASRZFtVlu6e8tPr5u6j0a5ta7R2RRNVQQYdmuJG2KqDw>
    <xmx:6JolZJvX6VD87l6X1knRohP3xv2W49faYPPoCzaduANlJfZOtXsjEw>
    <xmx:6JolZFGrEDmfUvBQcqJZcVCWWBLjFmbOn5VZDrl6ASmaDglTY0IpQQ>
    <xmx:6JolZPDE481H-10Woc2is43edXxLmRkIJeNyFeNb6KkxVEX1nea_yg>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Mar 2023 10:21:25 -0400 (EDT)
Message-ID: <f9f1d67f-5c89-d508-d582-528273b635db@ryhl.io>
Date:   Thu, 30 Mar 2023 16:21:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 05/13] rust: init: add initialization macros
Content-Language: en-US
To:     y86-dev@protonmail.com
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
References: <20230329223239.138757-1-y86-dev@protonmail.com>
 <20230329223239.138757-6-y86-dev@protonmail.com>
From:   Alice Ryhl <alice@ryhl.io>
In-Reply-To: <20230329223239.138757-6-y86-dev@protonmail.com>
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
> Add the following initializer macros:
> - `#[pin_data]` to annotate structurally pinned fields of structs,
>    needed for `pin_init!` and `try_pin_init!` to select the correct
>    initializer of fields.
> - `pin_init!` create a pin-initializer for a struct with the
>    `Infallible` error type.
> - `try_pin_init!` create a pin-initializer for a struct with a custom
>    error type (`kernel::error::Error` is the default).
> - `init!` create an in-place-initializer for a struct with the
>    `Infallible` error type.
> - `try_init!` create an in-place-initializer for a struct with a custom
>    error type (`kernel::error::Error` is the default).
> 
> Also add their needed internal helper traits and structs.
> 
> Co-developed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

> +/// ```rust
> +/// # #![allow(clippy::disallowed_names, clippy::new_ret_no_self)]
> +/// # use kernel::{init, pin_init, prelude::*, init::*};
> +/// # use core::pin::Pin;
> +/// # #[pin_data]
> +/// # struct Foo {
> +/// #     a: usize,
> +/// #     b: Bar,
> +/// # }
> +/// # #[pin_data]
> +/// # struct Bar {
> +/// #     x: u32,
> +/// # }
> +///
> +/// impl Foo {
> +///     fn new() -> impl PinInit<Self> {

I would remove the empty line above `impl Foo` so that the example 
doesn't start with an empty line when rendered.

> +/// # Syntax
> +///
> +/// As already mentioned in the examples above, inside of `pin_init!` a `struct` initializer with
> +/// the following modifications is expected:
> +/// - Fields that you want to initialize in-place have to use `<-` instead of `:`.
> +/// - In front of the initializer you can write `&this in` to have access to a [`NonNull<Self>`]
> +///   pointer named `this` inside of the initializer.
> +///
> +/// For instance:
> +///
> +/// ```rust
> +/// # use kernel::pin_init;
> +/// # use macros::pin_data;
> +/// # use core::{ptr::addr_of_mut, marker::PhantomPinned};
> +/// #[pin_data]
> +/// struct Buf {
> +///     ptr: *mut u8,

I'd add a comment on the `ptr` field saying "points at `buf`".

> +/// impl BigBuf {
> +///     fn new() -> impl PinInit<Self, Error> {
> +///         try_pin_init!(Self {
> +///             big: {
> +///                 let zero = Box::try_new_zeroed()?;
> +///                 unsafe { zero.assume_init() }
> +///             },

Is there a reason for not using `Box::init(kernel::init::zeroed())?` here?
