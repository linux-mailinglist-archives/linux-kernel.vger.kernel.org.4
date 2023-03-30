Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D116D0FF9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 22:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjC3U2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 16:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjC3U2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 16:28:31 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FF7C9;
        Thu, 30 Mar 2023 13:28:30 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 1907D3200959;
        Thu, 30 Mar 2023 16:28:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 30 Mar 2023 16:28:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1680208108; x=1680294508; bh=vQs4ynDb5KaPKtPAzLl0Rc9EXZoECrk6bMr
        SAt43TCw=; b=DV2BCGAEYE89/0qB9BCxZL65j8OujS0AqVHYgP6geTlizxxKs+a
        n+h1/Rq0qDKGEvXlhQ3O/WNsnR1iUWY5opFs1bthRv66hQkp2mSUsBFhJ365fqrc
        uWVQjDkLbzhI9GwllS5MMma21dc+SJjKS91l+tC9sSGHCPWo+8H6n/Vxj9+whEwL
        q/U2I1Cy3UsFHQyuS8n8rolINuuX/p0H5US0IQtqQh4QJRA3IUX6RgaOWaYVkxQA
        nda80+Px8RfxpltFBmJn98UEWFHA8DLkegrG7PBbgVMF/vH9fzzreLw3H6EASD79
        z3Mf3fHhdb1gpToC6TpqWN2+xHZPmk8jrwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680208108; x=1680294508; bh=vQs4ynDb5KaPKtPAzLl0Rc9EXZoECrk6bMr
        SAt43TCw=; b=bRz94HWqUtIeSEAzn9WBi4BZ43hv/ArbNIhDIIKZl6nL1zBd+Mp
        Ny0EEMvuLcADVBfXvTvp4W4uT+lwMvjIz0CqAGyLB2j0hItCZIGMgUPK+6v8lzim
        bNwZV/CR4DhR+pQDW08TC71bTSu//+oOs6BcbDH5gN248SatJxg/YxaDUB28s38Z
        Z+4sG4kLIFAajLDA1HQEuat345FU4SBVXUdnmubK0VvGgAYTmLdAeBtCBtPS1xYE
        ss5nvUNvlxpc+q6yCElrDpKQhZNFkw3y/cn8PbyvXVD0yrvzYHKR38Cy+ucnLDj3
        iHzRN/qeEno8Zs8jHNmGDCCAkqGJS02kfCA==
X-ME-Sender: <xms:7PAlZE4LdH6MfIWcK86D0nh3fEvpWyFbRVGPpqGqP4gM9PNddOetaQ>
    <xme:7PAlZF4Ab3G-ixntqtRu8jRr-L8KdvGcBd7SDwWZxJTWxVDYa2tIrN2kz3chSSHcA
    -yIRgpsWCU2_GNJsQ>
X-ME-Received: <xmr:7PAlZDf0n9iBXwebCjcjH9hi2yNN6uhQwSLdMPSGALw0L6Sp_lzGL-aDOePtKwxrjI4Q34-GZZ-vc5qvklokLLJPeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehledgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeetlhhi
    tggvucfthihhlhcuoegrlhhitggvsehrhihhlhdrihhoqeenucggtffrrghtthgvrhhnpe
    ehudduvdetkedvkedtudeludfgfffhudegjeeguedvvedtteevjeehheeiffefgeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhitggvse
    hrhihhlhdrihho
X-ME-Proxy: <xmx:7PAlZJLRGwv-m5P859fhegQuoC4OXi1gbj8brIte6NvQJY-KQtCrGg>
    <xmx:7PAlZIIr_cPRw5ujzGZp5TORke02iXhHqjz4pOJ5zsSajB-4k_HCQQ>
    <xmx:7PAlZKzuoEDQkDo2dJDJamRTY6LRmmV2ICj127z9ifJA3RJZMzjVEA>
    <xmx:7PAlZH9YIMHufS8oLxuw1Bwk8GgPgl_dhOnQAiRd9gsClXYKvvHwuA>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Mar 2023 16:28:26 -0400 (EDT)
Message-ID: <ae53994a-aaa5-8a57-4284-85000229249d@ryhl.io>
Date:   Thu, 30 Mar 2023 22:28:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 08/13] rust: init: add `stack_pin_init!` macro
Content-Language: en-US-large
To:     Benno Lossin <y86-dev@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Gary Guo <gary@garyguo.net>
References: <20230329223239.138757-1-y86-dev@protonmail.com>
 <20230329223239.138757-9-y86-dev@protonmail.com>
 <ada8307d-5177-2094-683f-bce619f1ea44@ryhl.io>
 <4b048bfc-e4fe-8c2f-ebfe-9b6a410cd8b8@protonmail.com>
From:   Alice Ryhl <alice@ryhl.io>
In-Reply-To: <4b048bfc-e4fe-8c2f-ebfe-9b6a410cd8b8@protonmail.com>
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

On 3/30/23 17:19, Benno Lossin wrote:
> On 30.03.23 17:00, Alice Ryhl wrote:
>> On 3/30/23 00:33, y86-dev@protonmail.com wrote:
>>> From: Benno Lossin <y86-dev@protonmail.com>
>>>
>>> The `stack_pin_init!` macro allows pin-initializing a value on the
>>> stack. It accepts a `impl PinInit<T, E>` to initialize a `T`. It allows
>>> propagating any errors via `?` or handling it normally via `match`.
>>>
>>> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
>>
>> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>>
>>> ---
>>> +#[macro_export]
>>> +macro_rules! stack_pin_init {
>>> +    (let $var:ident $(: $t:ty)? = $val:expr) => {
>>> +        let mut $var = $crate::init::__internal::StackInit$(::<$t>)?::uninit();
>>> +        let mut $var = {
>>> +            let val = $val;
>>> +            unsafe { $crate::init::__internal::StackInit::init(&mut $var, val) }
>>> +        };
>>> +    };
>>> +    (let $var:ident $(: $t:ty)? =? $val:expr) => {
>>> +        let mut $var = $crate::init::__internal::StackInit$(::<$t>)?::uninit();
>>> +        let mut $var = {
>>> +            let val = $val;
>>> +            unsafe { $crate::init::__internal::StackInit::init(&mut $var, val)? }
>>> +        };
>>> +    };
>>> +}
>>
>> This will be inconvenient to use if the initializer is infallible and is
>> used inside an infallible function. However, I'm not sure what a better
>> alternative would be. Perhaps we should have three variants?
> 
> That could be an option, any ideas for the syntax though? Or should it
> be a different macro like `stack_pin_init!` and `try_stack_pin_init!`?

You've also split up the other macros into a fallible and infallible 
version, so I think the same would be fine here. Perhaps use 
`stack_pin_try_init!` as the name?

>> Also, maybe a `<-` rather than `=` would be more consistent?
> 
> That is sadly not possible, since `<-` is not allowed after `ty` fragments.
> 
>> Anyway, I don't think this should block the PR. We can revisit it later
>> if it becomes a problem.
> 
> Sure.
> 
> --
> Cheers,
> Benno
> 
> 
