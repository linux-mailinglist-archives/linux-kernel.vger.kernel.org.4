Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2BC6F4991
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 20:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbjEBSQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 14:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjEBSQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 14:16:40 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45F6EC;
        Tue,  2 May 2023 11:16:38 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 378F85C00C7;
        Tue,  2 May 2023 14:16:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 02 May 2023 14:16:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1683051396; x=1683137796; bh=gRaJ+D8upH0CzVnGVpD0jcCp3qLvV1xzPMZ
        YZq2YRko=; b=EyrPOiozK/Fc8+rQe6EiQwZZvYGY40mKnr64LslwNMRgJiKYBLU
        ZsroAojo1M2fRvQwGgYaWCBfO3xRWzXiLofI7zg8p4PaInKuGdfyqPYdsdEn44Jv
        f7NtydfgtP0qmk+xxUvEtp4qs+bSkI6o56blF8KTuqgs8J4hQtAPuvP5hnrvjYFy
        8GXRv0SQwYdVKp5Kp/g1OESSQm+HPOFOVT/b/3/ehNMXczNi4MpNiAu0iLSXP6bb
        HIngyn3Bj3Ypz/N5LeVa1ge+YTSqR5RKxBdOGttF3IRqfIoUyvvHal4UDb5cZGdG
        yq8mY4bPJN4vEM/lrtdQXCcXWnwQMiT37aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1683051396; x=1683137796; bh=gRaJ+D8upH0CzVnGVpD0jcCp3qLvV1xzPMZ
        YZq2YRko=; b=Xk2rKxj0nQIattvbHpT+OpTF4Dx015K7RvgQ0w6+ouZJ5X0Qgc9
        1N+aysufQ5Rdwhx0h4+3BFROv8t3Hnm6l1f6wHCYVtR7y6MIZ4FcLuCMSt2Xyk9P
        K9r6NLVVGcMblWnJ9xBx4u44aW2GtThcxFr/+Z0gzQEQ1j3ko/qRRceHqBuY/Nq+
        +JxSZM+MCcMjHv1eaiHPJrECi4kFq0cx+CerSooRJRAJMEQ/DCxxwVxUmvTBodXz
        4k+m94I5BxVgJV/y0GGqMm/yxWi9X2gRWxLGK/NS2mrE0DFF3wyuVsIr9xRUTYBO
        TtsubKvepbFVOMFx+AxcHv88SqLGf2ZdZ6g==
X-ME-Sender: <xms:hFNRZGAVpvX2e9OhB9VPLxMUq3XARc8uGXQU1SxDu_WwK7YSpudIrg>
    <xme:hFNRZAh2YQvDKhBcOnLSBPJWQmvJZTfGntOWRsvOfZAd0pbVO-WZAY95N4UYeDB15
    Q7fW06IcNRX05Nn_A>
X-ME-Received: <xmr:hFNRZJnJSh9cuW-sNtCATtwQp7T8eKQVemoKCEs8X0W_uDka9vljOnNcvU19Edeb4yNWc49f7-7Pq1kx7M4aJoij6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedviedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomheptehl
    ihgtvgcutfihhhhluceorghlihgtvgesrhihhhhlrdhioheqnecuggftrfgrthhtvghrnh
    epheduuddvteekvdektdduledugfffhfdugeejgeeuvdevtdetveejheehiefffeegnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihgtvg
    esrhihhhhlrdhioh
X-ME-Proxy: <xmx:hFNRZEy45k8ALRjWAArIbhkajw_4iA0IBX4G6Bu7SH_CuZXYXkZVYQ>
    <xmx:hFNRZLSEJFmC0KiowwFSuMuk353qgiQQAXPSx0V3ILqZLjQA5wsGRw>
    <xmx:hFNRZPbUnLK7GjyVAOc5zQqhWVDReXkoMRAIOO5Q4cQ7musCkzab_w>
    <xmx:hFNRZGFKk3jCriPyP-LaLlLihNq67mRyab56TATqEAQp0GI51ntdWA>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 May 2023 14:16:34 -0400 (EDT)
Message-ID: <c9b27926-fcf5-b343-e70c-799a684faa75@ryhl.io>
Date:   Tue, 2 May 2023 20:17:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] rust: str: add conversion from `CStr` to `CString`
Content-Language: en-US
To:     Benno Lossin <benno.lossin@proton.me>,
        Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
References: <20230502125306.358283-1-aliceryhl@google.com>
 <CANeycqo+htksD_nj-eyCTOtE0TQHJR+dHZ1Hu8cL5eXNt4cd=A@mail.gmail.com>
 <LUCgVpZBQNex70PxHGlNVauiTqldfXpTUbd9l0tkBl4yHBQ6qWIhIQu4eZn03UG4a3jrKqt4FyL81321CSXgdISmzYnn69DejmZ-UgXJgD0=@proton.me>
From:   Alice Ryhl <alice@ryhl.io>
In-Reply-To: <LUCgVpZBQNex70PxHGlNVauiTqldfXpTUbd9l0tkBl4yHBQ6qWIhIQu4eZn03UG4a3jrKqt4FyL81321CSXgdISmzYnn69DejmZ-UgXJgD0=@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/23 20:02, Benno Lossin wrote:
> On 02.05.23 18:59, Wedson Almeida Filho wrote:
>> On Tue, 2 May 2023 at 09:53, Alice Ryhl <aliceryhl@google.com> wrote:
>>>
>>> +impl<'a> TryFrom<&'a CStr> for CString {
>>> +    type Error = TryReserveError;
>>
>> Wouldn't `AllocError` make more sense? Or even Error (with ENOMEM value).
>>
>> `TryReserveError` is documented as "The error type for try_reserve
>> methods." -- that fact the we use a `Vec` is an implementation detail,
>> I feel it's better not to leak this fact through the public API.
> 
> I agree, it should be `AllocError`. There is a `From<AllocError> for Error`
> with `ENOMEM` as the value, so `AllocError` is the most compatible, since it
> simply converts to `Error` via `?`.

Sounds good to me.

> Technically, `TryReserveError` represents two different kinds of errors:
> - CapacityOverflow -- triggered when exceeding `isize::MAX` bytes of size
> - AllocError -- memory allocation failed
> 
> I think it is fine to coalesce these into `AllocError`, since allocating
> `isize::MAX` might as well be considered an OOM error.
In fact, the `isize::MAX` case is unreachable since that would require 
you to already have a `&CStr` of that size, which Rust does not allow.

> With that fixed:
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>

Thanks both of you. I'll submit a v2 tomorrow.

Alice
