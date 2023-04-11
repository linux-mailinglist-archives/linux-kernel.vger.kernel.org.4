Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885636DDBDB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 15:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjDKNPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 09:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjDKNPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 09:15:45 -0400
Received: from mail.turbocat.net (turbocat.net [IPv6:2a01:4f8:c17:6c4b::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C060AA6;
        Tue, 11 Apr 2023 06:15:41 -0700 (PDT)
Received: from [10.36.2.154] (unknown [46.212.121.255])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mail.turbocat.net (Postfix) with ESMTPSA id A26302615BF;
        Tue, 11 Apr 2023 15:15:39 +0200 (CEST)
Message-ID: <1d50d25c-e64b-01f4-029f-8b40b46848fd@selasky.org>
Date:   Tue, 11 Apr 2023 15:15:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 0/6] Initial Rust V4L2 support
Content-Language: en-US
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
From:   Hans Petter Selasky <hps@selasky.org>
In-Reply-To: <CANiq72mv2uYe1x6cy4zUq8XHhAZcYYpt6hVXMG4yQZeqw1kY7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/23 14:36, Miguel Ojeda wrote:
> On Tue, Apr 11, 2023 at 11:52 AM Hans Petter Selasky<hps@selasky.org>  wrote:
>> Assume you need to update both the kernel and the rust compiler at the
>> same time. How do you do that? In the binary download case you have two
>> machines. One to build rust and one to build the kernel, so it is
>> technically not possible?
> I don't understand the problem -- you can build (or download) new
> toolchains without changing the kernel, and you can keep several
> kernels and several toolchains installed, too.
> 

Hi Miguel,

What I'm saying is a bit difficult to get about right off the bat.

 >you can build (or download) new toolchains without changing the kernel

Yes, most of the time, but not always. Let me rephrase it:

If you cannot build a new toolchain without a new kernel.

And:

You cannot build a new kernel without a new toolchain.

Then you are stuck forever to build a new toolchain and kernel? Do you 
agree?

Or you can say, someone else needs to deal with it, but then you have a 
single point of failure.

It's like the next version of the Rust compiler depends on the previous 
version of the Rust compiler.

But now you have (Version of Linux and version of Rust) depends on 
(Version of Linux and version of Rust).

So in order to upgrade either Linux or Rust, you may be forced to go 
through multiple, upgrade kernel, reboot, upgrade rust, build kernel, 
reboot and so on.

And that is an annoying complication when upgrading a system.

--HPS
