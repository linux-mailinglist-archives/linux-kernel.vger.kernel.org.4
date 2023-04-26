Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE9C6EF673
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 16:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241405AbjDZObr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 10:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240902AbjDZObp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 10:31:45 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EE64EE6;
        Wed, 26 Apr 2023 07:31:43 -0700 (PDT)
Received: from [192.168.1.43] ([77.7.2.190]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MlfL0-1qaKbV2V0s-00inbM; Wed, 26 Apr 2023 16:31:35 +0200
Message-ID: <9c11af81-cc30-dcc0-33cf-058d74080f1c@metux.net>
Date:   Wed, 26 Apr 2023 16:31:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 0/6] Initial Rust V4L2 support
Content-Language: tl
To:     Hans Petter Selasky <hps@selasky.org>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        wedsonaf@gmail.com, ojeda@kernel.org, mchehab@kernel.org,
        hverkuil@xs4all.nl
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, kernel@collabora.com
References: <20230406215615.122099-1-daniel.almeida@collabora.com>
 <441a96cb-7dd1-0885-df64-933ebdb55e9e@selasky.org>
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
In-Reply-To: <441a96cb-7dd1-0885-df64-933ebdb55e9e@selasky.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Ow8I91kmxMh/ASGHlIt0oFQKmCEOyR3w3fqp/P6Qz4ZUIz/H16b
 NJGi5boB95K44w9Kwc3RqLJqeOe3tkSQgK5GehEpaVqbt25AUrssVyhdsvp/lxhymleTgzw
 ImtXEMiej4B6dh2UgQQCpdjUQNK6K8Vz1A4cmcGcKBMwlS2FpVpKBVtiy0xgRWXfrb6dl5D
 RDM1NB3U+qvP2uOr0Ronw==
UI-OutboundReport: notjunk:1;M01:P0:kDmh3DcH/z8=;EFi6kEKyvxwGd7krUNNdmsxKACj
 RSDjpoQ0OaQVQkaS8bRMJJS9FUygLdSg+VxkE3OjlMjNPmLVgzavkDRqvMK7Qge9aJ0882vnQ
 Iaklm8gkHnEUxeODuEQ/hqwVvMv2dMQSs+CLwz9zcBMgqV51KdcQCUBYt6UN7MXnLJ+IEYa+0
 +/FqjwPgn4X5lefKjqbzW3DXrTNeLJHY66FtBKhKN47Bc0MOTW8XZ11IaqdcbI1QNbz0waP/E
 M6VaJOQ/sRa6xnL5/kOmmfMB+rvZYpX22wJHgrWkx2lTRIHYRz6orUBLoeBymfb0OqyVgQeB5
 sHpVxflbGLyqmIYqkA+FoAW25DS9g5+9KEKTlza4ErbOHKtI2APp3JpD4PKU26pa0zHX1B4Tb
 iyC+cyteAhFy+OhWr260tQUtcU1Ha2g7urclstxIL3XobvWAmgny4xscWvp7x1m1D/VrbQIr7
 QOZJDaPwh3m1QcCeULQzFA+BxigFC3koHbyqjmgHOst2z0yizFhBhK60OSDeXVoRxcIKyU2tr
 wjyM/mUaOC3c2+AFPA7JcVomqxHkcd4epCRiob3AUp9D2pG/Eg9Zj3loqiY8jUE0QI9LvLhql
 wJ6FxLJPWIaPvWkOg5VYgIfDzU7k27Jj9fdjWVJuG0+I/Wc2TK0xdwQzkeDHwFHZ8gV3FICPR
 exBOiMBfXTTtAmSM030Q4ZOaHUrWC82jgtfo0t7TJQ==
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.04.23 21:43, Hans Petter Selasky wrote:

> You assume that all 
> code is running inside the kernel and needs to be perfect. 

Yes, of course. It's kernel code.

If you're borrowing kernel code for your userland stuff, than it's up
to you to take care of it.

There is no such thing like stable/fixed in-kernel APIs - it always has
been this way.

> But I think 
> you could just aswell implement the next USB webcam V4L2 driver in Perl 
> for that sake.

That would't be v4l anymore.

> The reason for my point of view, is that I think most of the drivers in 
> media/ should run in user-space, and not inside the kernel.

Feel free to provide fully userspace drivers for those devices, but
that's totally unrelated to kernel development (no matter whether you're
copying over kernel code into your userland project).

> The example of secure V4L2 programming is already here:
> https://github.com/hselasky/webcamd

BSD code is not in scope of the LKML.

> I would rather like more drive on that, than flowing down the Rust 
> stream.

Orthogonal topic.

> Rust is cool, Java is cool, VM's are cool. The only bad about 
> cool things, is that they are so slow. For many years I completely 
> avoided C++ code for the sake it is very slow to compile, compared to 
> bare C code. And when looking at how Firefox is building using Rust, I 
> am a little worried, why we need so much code in there!

Yes, compiling Rust is slow, compared to C. That's the price for
sophisticated optimizations. How often do you have to do a full
recompile ?

> Engineering energy would be much more focused, if hardware vendors could 
> agree more about what binary formats to use for their device protocols, 

Indeed. But we (kernel folks) have no influence on that. If we could,
we'd already standardized HW interfaces for lots of things and so only
a small percentage of the drivers we currently have, while still
supporting the same number of HW (or even more). But unfortunately thats
not under our control. Therefore offtopic.

> than changing the coding language, so that now anyone can be let loose 
> to program in the Linux kernel without risking any damage.

AFAIK, this discussion isn't about changing the kernel's programming
language, but just adding language bindings, so some new drivers could
be written in that language. If this really happens and you really want
a C implementation, feel free to send patches.

> The goal for Linux driver development should be fewer drivers and not 
> more. 

Depends on specific case. We already have lots of drivers that support
wide range of devices. But it doesn't make sense having monster drivers
for entirely different devices.

> I don't want Linux to become the next Microsoft, with gigabytes 
> of drivers which are never used for anything.

Actually, we're doing a pretty good job of generalizing things that can
be generalized (if you find room for more improvements, feel free to
send patches). Nobody here seriously intents dropping the subsystem and
lib architectures in favour of monolithic monster drivers like in
Windows world.

> The webcamd daemon already is close to 6 MBytes big on amd64 on FreeBSD. 
> Inside there is support for 510 drivers (counting =y keywords), built 
> straight off Linus Torvalds:

You have ~500 drivers in one 6MB binary and blame us for writing too
much code ? Maybe you should think about modularization (which we do
have in the kernel).

And, btw, FreeBSD is completely off-topic here.

> The USB video class is great, instead of tons of GSPCA devices, then 
> yeah, we don't need to drag around so much legacy binaries, just to make 
> everyone happy. What did Apple do? Custom PCI webcam devices? Why can't 
> they just stick with virtual USB devices, and then have a dual 
> configured device, one config for their own HD codec, and one config for 
> people like me, just needing the framebuffer.

Well, they just could have an USB device layered on-top of a tiny PCI-
USB bridge. We're the wrong to blame - talk to Apple.


--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
