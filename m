Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E677E6DF1E3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 12:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjDLKYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 06:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjDLKYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 06:24:01 -0400
Received: from mail.turbocat.net (turbocat.net [88.99.82.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B90872B8;
        Wed, 12 Apr 2023 03:23:58 -0700 (PDT)
Received: from [10.36.2.154] (unknown [46.212.121.255])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mail.turbocat.net (Postfix) with ESMTPSA id B66AB260C85;
        Wed, 12 Apr 2023 12:23:55 +0200 (CEST)
Message-ID: <d8728db4-81d2-6204-9b9f-f9256f574d0c@selasky.org>
Date:   Wed, 12 Apr 2023 12:23:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 0/6] Initial Rust V4L2 support
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        wedsonaf@gmail.com, ojeda@kernel.org, mchehab@kernel.org,
        hverkuil@xs4all.nl, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        kernel@collabora.com
References: <0ec4becd05c49e8f0bf214fbd62208ea67c2b4c3.camel@collabora.com>
 <6fc0a0c6-a7c9-5350-9b9e-1ea9dab568d0@selasky.org>
 <CANiq72m812+L6dc4Qs2wUXW85eBQwgrjWYYKc1MSsqN5AG_sFw@mail.gmail.com>
 <9f896097-8410-4d09-b614-6e792b2160f4@selasky.org>
 <CANiq72mv2uYe1x6cy4zUq8XHhAZcYYpt6hVXMG4yQZeqw1kY7Q@mail.gmail.com>
 <1d50d25c-e64b-01f4-029f-8b40b46848fd@selasky.org>
 <CANiq72mbM+WBcvj1TwU2u9kLz=EucLhLR-a5nzZEDa7VJ0s2_A@mail.gmail.com>
 <ca17f815-5779-d37c-e3f8-2a6c2983fe45@selasky.org>
 <CANiq72mn1nD38DGHpFQzerC=_ifR39Vpbb_PzLv5Q75SdzTxQg@mail.gmail.com>
 <8ff91d0c-624b-2704-24b0-5b7c4ca0db1e@selasky.org>
 <2023041243-clarinet-scallion-6fb0@gregkh>
From:   Hans Petter Selasky <hps@selasky.org>
In-Reply-To: <2023041243-clarinet-scallion-6fb0@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/23 12:13, Greg KH wrote:
> On Wed, Apr 12, 2023 at 12:00:59PM +0200, Hans Petter Selasky wrote:
>> That's why the toolchain should be included in the Linux kernel. So that the
>> people using Linux know that the toolchain works as intended when compiling
>> the Linux kernel.
> 
> That's not how Linux has ever worked, sorry.  So this is not even a
> valid discussion anymore.
> 

Well, maybe it's time to change your views on that and stop being a rock 
thrower on your friends, the compiler folks, whenever something goes wrong:

https://news.ycombinator.com/item?id=8089321

--HPS
