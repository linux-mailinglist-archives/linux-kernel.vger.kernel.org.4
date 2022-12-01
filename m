Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0EA63F562
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 17:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbiLAQih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 11:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbiLAQib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 11:38:31 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FB55BD42
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 08:38:29 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id s196so2136070pgs.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 08:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ktaBf+m+7zsCEDxnoaX5mo2FVAO2+XdFUnqxLpyGNw=;
        b=mA7VeMKgH/C+/BL1ppc+N9wU4CejHE+DMIURYuGvfocw1ZcCKphtlPDzo+27wwskjG
         O1BaMMyilZbgbS7mX0ixrsn+OHqZtW8oEO8kADSp5D2YLJBvjkJ3oTLMDc7SaS70rdft
         i495mS3a0TYQH3D7DC1n/dTlrIXhwB+AvvhBqmbpD46KjxX6ULRIEyygJ1IhrCZ5XzkE
         MMMqimGq5z5RC1Pv+baZ1v8Cv0RrhxI2IgXaXp6pRMqB6aFSlBnMpmie8vFEdFKTigqk
         7LwwzG7bIu9mfvNKYpqJ9WJPQWsP47LlxpQ0DUPETXOGQUGvAl7AKcW3coLmIBRtBdKf
         5bHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ktaBf+m+7zsCEDxnoaX5mo2FVAO2+XdFUnqxLpyGNw=;
        b=zJ3vpwEBzHXObc19YcGT2Nks735dmxPR6PPVGH7yaN1qjWYWRyBLYyLS1U+y5sQ126
         +6sXLxJ6c4xqz+I4rsXD8dCYk8m9NQvjaXzxbD3yHvYno/LlC1/5zoE68/P0Tg5ysTMA
         lddeqLQzBPIMl0ey2w/c9A3Ypx7Rb0WADxaFtb+u/jhISgDN28p7wFhGH0fmZwaGgtlq
         8oLoR3pXj2cgqOrhbRIfKyKvrKg9XKf9eAnWclPZ7EkWI/wgGdKMQFoLOmJxA49aPNHi
         iYMd/T3GylvuvuLeX6KgCwj74mXlWmnOinnZiMmX+qTNTnoBNjsJkJ1Q0TKtNt3ZsTXj
         KzKQ==
X-Gm-Message-State: ANoB5pm+PjLAqy6AmpPBIvvHleRur9pvnquKPOj4feZmzX344DQ2uNOa
        0OmfXSDpMWl/3NSbkiX5eQA5jA==
X-Google-Smtp-Source: AA0mqf71fmql0yVOroUO352Tyegi4ufTC7eSD+civWVFv4uppvX9jsZvHlH4/5tw9e0rlYBITxqOuQ==
X-Received: by 2002:a05:6a00:1d0c:b0:573:7b50:acb8 with SMTP id a12-20020a056a001d0c00b005737b50acb8mr51202930pfx.59.1669912709020;
        Thu, 01 Dec 2022 08:38:29 -0800 (PST)
Received: from ?IPV6:2400:4050:c360:8200:7b99:f7c3:d084:f1e2? ([2400:4050:c360:8200:7b99:f7c3:d084:f1e2])
        by smtp.gmail.com with ESMTPSA id x28-20020aa78f1c000000b0056c349f5c70sm3448592pfr.79.2022.12.01.08.38.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 08:38:28 -0800 (PST)
Message-ID: <8b3c4fe0-4a81-ba47-2f01-3686cfdbd519@daynix.com>
Date:   Fri, 2 Dec 2022 01:38:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] arch: arm64: dts: apple: Remove stdout-path
Content-Language: en-US
To:     Hector Martin <marcan@marcan.st>,
        Mark Kettenis <mark.kettenis@xs4all.nl>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, asahi@lists.linux.dev,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        alyssa@rosenzweig.io, sven@svenpeter.dev
References: <20221201103651.27807-1-akihiko.odaki@daynix.com>
 <877czb42wk.fsf@bloch.sibelius.xs4all.nl>
 <c3b0cee9-032c-0447-37df-3ce5ce280e41@daynix.com>
 <ae89b38f-fd67-e0e5-1439-f376da985be8@marcan.st>
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <ae89b38f-fd67-e0e5-1439-f376da985be8@marcan.st>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for reviewing and detailed explanation.

I'm withdrawing this patch. As you pointed out it makes earlycon 
difficult, which is serious in development workflow. As a normal user 
will use U-Boot, which changes stdout-path if appropriate, this kind of 
change should be designed to make development easier, and this change 
does the opposite.

On 2022/12/02 0:46, Hector Martin wrote:
 > On 02/12/2022 00.19, Akihiko Odaki wrote:
 >> So I think we should think more about the case when the kernel is booted
 >> from m1n1. When using its hypervisor feature, it is more likely that you
 >> want console on serial and and that is the opposite of this change.
 >> However, it is still possible to get the console on framebuffer with
 >> keyboard.
 >
 > Except if the framebuffer is broken, or everything is broken and it
 > hangs on early boot, which happens all the time when I'm debugging using
 > the hypervisor. Or maybe I'm just SSHing in remotely and not physically
 > in front of the machine, which is also often the case. Or maybe I'm just
 > booting headless because I didn't feel like swapping around the HDMI 
cable.

The user can change the kernel parameter in such a case. If you have 
already ran the kernel with this change, you should have learned that 
the console is tied to the framebuffer and keyboard and you need to 
supply the kernel parameter. It is easy to change the kernel parameter 
if you use m1n1 directly.

 >
 >> In contrary, if you boot the kernel without the hypervisor
 >> feature and this change, you will completely lose the console.
 >
 > How so? The console goes to both places with stdout-path set to serial0.
 > What it *does* change is where input is accepted prior to getty startup
 > (which is why u-boot specifically conditions this on keyboard presence,
 > modulo the USB issue - because if you *don't* have a keyboard then tty
 > keyboard input is useless). But if you're booting kernels without u-boot
 > along the way, you're probably doing it from the hypervisor or linux.py
 > anyway, especially if you plan to do something like "init=/bin/sh",
 > because without u-boot (+ optionally some EFI loader) there is no way of
 > editing command line arguments at boot time stand-alone.

Well, that is not exactly the behavior I saw. In my case, if stdout-path 
is pointed to serial, there is no output on the framebuffer, and it just 
printed "_".

It looks like the kernel only outputs to either of serial and 
framebuffer, not both.

 >
 > However, while having stdout-path gives you both serial + tty output and
 > serial input, *not* having stdout-path kills serial entirely. It also
 > kills earlycon, and makes it so that you have to specify a bunch of
 > obscure arguments to get earlycon to work, instead of just a plain
 > "earlycon" argument which is much easier.

This is a valid argument. I always struggle when I try earlycon first 
for a computer. stdout-path should be maintained if it is freeing 
developers from such trouble.

 >
 > So for this to be considered at all, you would first need to propose a
 > m1n1 patch to re-add stdout-path in boots under the hypervisor and
 > (optionally?) on linux.py boots, so you don't regress tools that our
 > developers use every day.
 >
 > But I still fail to see the benefit of this change. What scenario are
 > you envisioning that this would improve (something people actually do,
 > not a hypothetical)?
 >

What I experienced is that when I directly booted the kernel from m1n1 
without hypervisor, it showed no output to the display even though the 
same kernel worked with U-Boot. While I could tell it used wrong console 
by running the hypervisor, I wondered why it behaves differently without 
U-Boot, and found the aforementioned U-Boot change, coming up with this 
patch.

Regards,
Akihiko Odaki

 > - Hector
