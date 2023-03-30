Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2BE6D0FF1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 22:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjC3UZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 16:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjC3UZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 16:25:02 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF541FE7;
        Thu, 30 Mar 2023 13:25:00 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 4D886320095E;
        Thu, 30 Mar 2023 16:24:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 30 Mar 2023 16:24:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1680207896; x=1680294296; bh=yo0C034vGSBxi+os4rgvPlo0nGFfVZiz3Ze
        ZDUzAo6s=; b=nOg05TAvugjNHAwkD3hyb0R1J5DEk7CRznYnzN5yw0NWL10NJzN
        z3M9Zh5rNeVOAa6UldhwinRCmVCMOvuD+ojq45oYGORIjyI5XQ1WFOg84piAUKpN
        kFpdzqcxc2W/am+mqyUVlymv4StJurYHgeO5sfxQKGJqReJx6wATUzrp4tm5Qwdm
        TXHjpFOpMt8q9ecYyh2gMjnzneF+udKQVM+ielJig/6VmcCEx8k6dOGH51fcg9ke
        Nz42HjIOlIUIe5/QF5r8/fomql7mBzEV0Q0wkCp8iEVFj0CVhlgeiQbymcUr75Q3
        rzjEZG4vndYKPXC66yFO+65bHaXA64vwmfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680207896; x=1680294296; bh=yo0C034vGSBxi+os4rgvPlo0nGFfVZiz3Ze
        ZDUzAo6s=; b=Hf4xg2ZRLnr4FEdB89FkRxOtOh1rC5R3F5xNZIAUVjgavUdhIuz
        HUQZyUtvXtMWtMVZGzXicqTeYukba/uR54NxYldr7ULZW5nOGfVRIY84/d7KA4Gg
        QpQeszMbTPMYpchPb5wXxykOhGFf1PBbkL7ypdo190jdDb+iG6U9sSYpGkI1kF9n
        w63pIoFIcY7mdUbRbFIdloYFNnvG4FBHY4B5D8OLZoTD3xOCbMGChy8WYaI8J0iK
        +8E24zKrSR0lGUd6yMZNE5EhESwA8OO638GR6KharmlgGC6NrR4E8zingV0H/96N
        7R5CLhsdH9cmzhXqjnTl7Bq7prCE6wZVlyw==
X-ME-Sender: <xms:GPAlZD4tEv0kJWPtH5VtIAf4tYGTLf1EjBJccF2saLX7Y7jSiRbXMg>
    <xme:GPAlZI4TgdYB3ods2wnGosGKB_uyod2owRDdo4R9UtPSO4yYdyJyzbvaGIQSAR6nq
    H8XNNZd-tQjzD9fnw>
X-ME-Received: <xmr:GPAlZKc_z27p6MVM7NKX-bQj5U0EzzZDCH1Q3XrrzgsOfo9LWfAeHwhZI7cLaV4u6XZDcGHFN6K-Os6aeHA46IctXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehledgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeetlhhi
    tggvucfthihhlhcuoegrlhhitggvsehrhihhlhdrihhoqeenucggtffrrghtthgvrhhnpe
    fhtdfhieejveekgfevfedvieefhfeggeeiieehhfffleeuuddugfejleelkeffieenucff
    ohhmrghinhepughotghsrdhrshenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrlhhitggvsehrhihhlhdrihho
X-ME-Proxy: <xmx:GPAlZEKQRSY0c1OEI-rrAwIF2llj27p3YjSMNdK7QOC2D_Mds8mD3g>
    <xmx:GPAlZHJ8VUDv8WStv3DSvCDe-HJruiNa4cEw6qsmqXjIB4Qk9ShKIg>
    <xmx:GPAlZNwEM0g03LaBxWN7y5KYqY1pc_A6V8O0SLKNMf9XG61Odqc-Ig>
    <xmx:GPAlZO9feXDFAczCA-Flll0p8Hz2394nBjAVLCI81fbn8AQ6H7IAOw>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Mar 2023 16:24:54 -0400 (EDT)
Message-ID: <1c2338c5-adab-f85c-645e-44e361ef0677@ryhl.io>
Date:   Thu, 30 Mar 2023 22:24:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 06/13] rust: init/sync: add `InPlaceInit` trait to
 pin-initialize smart pointers
Content-Language: en-US-large
To:     Benno Lossin <y86-dev@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
References: <20230329223239.138757-1-y86-dev@protonmail.com>
 <20230329223239.138757-7-y86-dev@protonmail.com>
 <1f93a045-5bd8-e07f-cf1b-7b1196c8ab54@ryhl.io>
 <3ea5cd8d-84ca-59bd-de50-fef185233a50@protonmail.com>
From:   Alice Ryhl <alice@ryhl.io>
In-Reply-To: <3ea5cd8d-84ca-59bd-de50-fef185233a50@protonmail.com>
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

On 3/30/23 17:28, Benno Lossin wrote:
> On 30.03.23 16:37, Alice Ryhl wrote:
>> On 3/30/23 00:33, y86-dev@protonmail.com wrote:
>>> From: Benno Lossin <y86-dev@protonmail.com>
>>>
>>> The `InPlaceInit` trait that provides two functions, for initializing
>>> using `PinInit<T, E>` and `Init<T>`. It is implemented by `Arc<T>`,
>>> `UniqueArc<T>` and `Box<T>`.
>>>
>>> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
>>> ---
>>>
>>> +/// Smart pointer that can initialize memory in-place.
>>> +pub trait InPlaceInit<T>: Sized {
>>> +    /// Use the given initializer to in-place initialize a `T`.
>>> +    ///
>>> +    /// If `T: !Unpin` it will not be able to move afterwards.
>>> +    fn pin_init<E>(init: impl PinInit<T, E>) -> error::Result<Pin<Self>>
>>> +    where
>>> +        Error: From<E>;
>>> +
>>> +    /// Use the given initializer to in-place initialize a `T`.
>>> +    fn init<E>(init: impl Init<T, E>) -> error::Result<Self>
>>> +    where
>>> +        Error: From<E>;
>>> +}
>>
>> This definition is potentially rather limiting, because it can only be
>> used with error types that can be converted into a `kernel::Error`. What
>> do you think of this alternative?
>>
>> pub trait InPlaceInit<T>: Sized {
>>        fn pin_init<E>(init: impl PinInit<T, E>) -> Result<Pin<Self>, E>
>>        where
>>            E: From<AllocError>;
>>
>>        fn init<E>(init: impl Init<T, E>) -> Result<Self, E>
>>        where
>>            E: From<AllocError>;
>> }
> 
> I initially implemented it like this, but it required almost always that
> `E` is specified, I will try and see if the situation is any different now,
> but I do not think so. In the user-space version of this API (see [1]) I
> have four functions, normal variants that return an `AllocError` and `try`
> variants that look exactly like what you suggested. In the kernel, we could
> make the normal variants as they are now and add the `try` variants as you
> described.
> 
> [1]: https://docs.rs/pinned-init/0.0.5/pinned_init/trait.InPlaceInit.html
> 
> --
> Cheers,
> Benno

Ok, if my alternative causes type inference problems, then let us keep 
the version you proposed here. We can add more variants later. (Or if 
you want to add more now, that's also fine.)

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
