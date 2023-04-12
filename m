Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2FF36DF16B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 12:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjDLKB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 06:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjDLKBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 06:01:12 -0400
Received: from mail.turbocat.net (turbocat.net [IPv6:2a01:4f8:c17:6c4b::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1DA76B7;
        Wed, 12 Apr 2023 03:01:01 -0700 (PDT)
Received: from [10.36.2.154] (unknown [46.212.121.255])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.turbocat.net (Postfix) with ESMTPSA id 5B687260784;
        Wed, 12 Apr 2023 12:00:59 +0200 (CEST)
Message-ID: <8ff91d0c-624b-2704-24b0-5b7c4ca0db1e@selasky.org>
Date:   Wed, 12 Apr 2023 12:00:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 0/6] Initial Rust V4L2 support
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Daniel Almeida <daniel.almeida@collabora.com>, wedsonaf@gmail.com,
        ojeda@kernel.org, mchehab@kernel.org, hverkuil@xs4all.nl,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, kernel@collabora.com
References: <20230406215615.122099-1-daniel.almeida@collabora.com>
 <441a96cb-7dd1-0885-df64-933ebdb55e9e@selasky.org>
 <0ec4becd05c49e8f0bf214fbd62208ea67c2b4c3.camel@collabora.com>
 <6fc0a0c6-a7c9-5350-9b9e-1ea9dab568d0@selasky.org>
 <CANiq72m812+L6dc4Qs2wUXW85eBQwgrjWYYKc1MSsqN5AG_sFw@mail.gmail.com>
 <9f896097-8410-4d09-b614-6e792b2160f4@selasky.org>
 <CANiq72mv2uYe1x6cy4zUq8XHhAZcYYpt6hVXMG4yQZeqw1kY7Q@mail.gmail.com>
 <1d50d25c-e64b-01f4-029f-8b40b46848fd@selasky.org>
 <CANiq72mbM+WBcvj1TwU2u9kLz=EucLhLR-a5nzZEDa7VJ0s2_A@mail.gmail.com>
 <ca17f815-5779-d37c-e3f8-2a6c2983fe45@selasky.org>
 <CANiq72mn1nD38DGHpFQzerC=_ifR39Vpbb_PzLv5Q75SdzTxQg@mail.gmail.com>
Content-Language: en-US
From:   Hans Petter Selasky <hps@selasky.org>
In-Reply-To: <CANiq72mn1nD38DGHpFQzerC=_ifR39Vpbb_PzLv5Q75SdzTxQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/23 21:22, Miguel Ojeda wrote:
> On Tue, Apr 11, 2023 at 5:33 PM Hans Petter Selasky <hps@selasky.org> wrote:
>>
>> Similarly rustc may depend on an incorrectly specified ioctl()
>> definition, also via other libraries and static linking, that just have
>> to stay incorrectly defined, because it was initially incorrectly defined.
> 
> Why would a compiler depend on random ioctls? Even if it did, how is
> that related to the previous discussion? A compiler is just one more
> userspace application.

Hi,

Is the right hand knowing what the left hand is doing? Are the people 
behind Rust aware Rust is being used for kernel purposes or not?

That's why I brought up the file-system issue with Microsoft and Apple 
as an example. The Unicode guys probably knew nothing about what the 
letter valued 0xE5 was used for in various file systems, so they thought 
it was fine to assign a letter there, the Norwegian "å". I think neither 
anyone at the two big companies mentioned tried to stop Unicode from 
doing such a clear mistake either.

Microsoft and Apple is the left hand, and Unicode is the right hand.

That's why the toolchain should be included in the Linux kernel. So that 
the people using Linux know that the toolchain works as intended when 
compiling the Linux kernel.

It's a generic issue. If two organizations that make products for 
eachother, don't talk closely together, you risk exactly what I point 
at, that some stupid decision will be made by the one party, which 
doesn't really affect the other party, but innocent customers infact.

 > Why would a compiler depend on random ioctls?

Can you say you can write even a test C-program to multiply two 32-bit 
numbers, bit by bit, without even deleting a single character once? 
People who say C-programmers never do mistakes, are naive. Even standard 
ioctls() may contain mistakes and there needs to be a plan to fix such 
issues. And when you think the code is right, the compiler is to blame, 
and when you think the compiler is right, the CPU is to blame and so it 
goes.

> Whether the kernel uses C or Rust internally
> has nothing to do with that.

The question is not OR, but AND related. If the kernel will need both at 
some point in the future, it's not good. The plan should be either OR: 
Rustc ^ GCC = true. Not Rustc | GCC = true :-)

> Also, I don't follow your logic. You said you cannot upgrade your
> toolchain (for some reason), and your argument is that the kernel
> keeps interfaces stable? Well, yes, that is the point and what allows
> you to upgrade.

You need to see, stable interfaces may also need to be changed. That is 
where you invert my logic. If you fix that when reading my text, you 
will see what I'm saying is true and not false.

There may be bit-pattern things down at CPU level, triggering bit-flips, 
that CPU vendors will do nothing about, because the argument is 
typically about money and performance. If something costs both money and 
hurts performance, it will not be implemented. It's like the speculative 
instruction prediction and resulting cache pollution, allowing memory to 
leak from kernel level to user-space level. Isn't it enough to deal with 
this in GCC only? Does Rust handle such issues at all? I don't know simply.

And what about syscall numbers? What if someone from Intel says all 
syscall numbers must be divisible by four, because those two lower 
bit-lines are frequently subject to bit flips and we can do nothing 
about it.

> 
> Moreover, what is special about `rustc` here? What about your C toolchain?

I don't know Rustc that well, so I cannot answer what's special about 
it. But based on my existing experience with C toolchains, I don't 
expect it to be any easier, with regards to handling unforeseen issues.

> 
>> I'm trying to explain something difficult. And I'm OK that you neither
>> understand nor agree about my viewpoint. See my replies above.
> 
> No, it is not a matter of being difficult. It is just that you have
> not shown how you would be prevented from upgrading a toolchain.

The proof is in a principle. Principles are there to avoid unpredictable 
problems.

Apparently you don't accept the principle of talking closely together 
when you are in a supply chain.

I have a feeling you think like this: If I do my job great, and all 
others in the supply chain do their best, then the resulting product 
will be the great too!

Translated to your case: Linux is the most stable OS in the world, and 
Rust is the most secure compiler language in the world. Nothing can go 
wrong!

--HPS

> 
> Cheers,
> Miguel

