Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F90B6D08F8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 17:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbjC3PAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 11:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbjC3PAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 11:00:41 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3DAA2;
        Thu, 30 Mar 2023 08:00:40 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id C2BA73200948;
        Thu, 30 Mar 2023 11:00:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 30 Mar 2023 11:00:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1680188438; x=1680274838; bh=XkIIRswdtZjN/RQYs9WPqwblrbMN+FP/NLq
        72KD8BRw=; b=fHzuj0sg/OTRdHaJNnNJn+W7xiyLvh7M+J7WJX7C3FU4JoGeyAr
        T3PAgf5yhPayyxE+292EVwpLALkDjzfqaLmk/ssbt0Nb7ZLNi3pZUGxQDL6NXu6T
        8EbGPiPsL8C/N8/gMEedoPw7x5gSS0Y69/jM0/70vW4Y5ktgyMfrbvfmnKULB81G
        tcmf6eEmY9f56JYwfdiGhAzl8BNYHMKui7KNwgdxw47GFuileOmhJX4hHvndVUJE
        k4nlCezqK0cLdXceGBOQv4OPfpKoDhF4hOBDpTgW+6/2yTzQKNbZbiglPXQw7Iyc
        DQldq0wMrAV47YYNXYvcuOzkg/BfWizjULw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680188438; x=1680274838; bh=XkIIRswdtZjN/RQYs9WPqwblrbMN+FP/NLq
        72KD8BRw=; b=DqbTkCuokA5SSxmsX0iyYwlNtU0y5H+QE4fssY+o4WRd44vk6ES
        2gsARYZTXVDwwP8N3vjzRcygQUqNnUTX+DLs0bbG6rTOJceJaWJN+YXOOvPhwXoB
        YVacXor7I7FFSNtwR78Sl6vyw4/aj0qQzuJXhajsIbQLB5P6BqT/s4Q4bXhd5JD5
        B8vPDepEC4YpsW3TqLEz8sOjcNRrASucWY19/911Po6XuBs+Uv5ESTS89KBjQ7p4
        FwoqCEEpyet6I6TTGiZxGp4SXGCbz1FiJJWj6nCYYyy2xfX90dXTna3vay+24bSf
        qZ1Lu83iGonV1f/OuuAohO3fAWuVRBlJhFw==
X-ME-Sender: <xms:FaQlZP8HUWuWuha-VFskavM1OzLA81-4jQIpLyRmrNZAhyMWNTHiAQ>
    <xme:FaQlZLuduUez1dsih-j-WJIjMVkMj6F-oiW0cVhtrj9UdiIQjyR6eNCWrjRHEeaX7
    Uo-nTHJh7uXl0hKnw>
X-ME-Received: <xmr:FaQlZNCCgtfB2iy2MPycMGwJ16gGM0u8l60_4Fk0upRIhx7KEOi44wPAO-9oCViEaIsrTUVxx7TqKy0jSJwgevnLRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehkedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeetlhhi
    tggvucfthihhlhcuoegrlhhitggvsehrhihhlhdrihhoqeenucggtffrrghtthgvrhhnpe
    ehudduvdetkedvkedtudeludfgfffhudegjeeguedvvedtteevjeehheeiffefgeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhitggvse
    hrhihhlhdrihho
X-ME-Proxy: <xmx:FaQlZLf-u0DULVrHmdsITt6X_79X9NkAk7pePp0gSHFg-Q5l8LoNpA>
    <xmx:FaQlZEOi2zVW2RC5i0yL1AA46DDtbM8VKXYXE3CyGbcjBjruT110fQ>
    <xmx:FaQlZNnk9nKg5KMPuKCPzZEP2molzbsZ2HUX0Gp0LLc0vBShaIsKHw>
    <xmx:FqQlZFi_Fzs5HrGl-mV-Qr8J_qcg-u6SltXxAlV4qy-TRhskhIuhNA>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Mar 2023 11:00:35 -0400 (EDT)
Message-ID: <ada8307d-5177-2094-683f-bce619f1ea44@ryhl.io>
Date:   Thu, 30 Mar 2023 17:00:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 08/13] rust: init: add `stack_pin_init!` macro
Content-Language: en-US
To:     y86-dev@protonmail.com
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Gary Guo <gary@garyguo.net>
References: <20230329223239.138757-1-y86-dev@protonmail.com>
 <20230329223239.138757-9-y86-dev@protonmail.com>
From:   Alice Ryhl <alice@ryhl.io>
In-Reply-To: <20230329223239.138757-9-y86-dev@protonmail.com>
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
> The `stack_pin_init!` macro allows pin-initializing a value on the
> stack. It accepts a `impl PinInit<T, E>` to initialize a `T`. It allows
> propagating any errors via `?` or handling it normally via `match`.
> 
> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

> ---
> +#[macro_export]
> +macro_rules! stack_pin_init {
> +    (let $var:ident $(: $t:ty)? = $val:expr) => {
> +        let mut $var = $crate::init::__internal::StackInit$(::<$t>)?::uninit();
> +        let mut $var = {
> +            let val = $val;
> +            unsafe { $crate::init::__internal::StackInit::init(&mut $var, val) }
> +        };
> +    };
> +    (let $var:ident $(: $t:ty)? =? $val:expr) => {
> +        let mut $var = $crate::init::__internal::StackInit$(::<$t>)?::uninit();
> +        let mut $var = {
> +            let val = $val;
> +            unsafe { $crate::init::__internal::StackInit::init(&mut $var, val)? }
> +        };
> +    };
> +}

This will be inconvenient to use if the initializer is infallible and is 
used inside an infallible function. However, I'm not sure what a better 
alternative would be. Perhaps we should have three variants?

Also, maybe a `<-` rather than `=` would be more consistent?

Anyway, I don't think this should block the PR. We can revisit it later 
if it becomes a problem.
