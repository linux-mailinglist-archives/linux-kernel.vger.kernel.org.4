Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8E16C980C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 23:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjCZVme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 17:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjCZVmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 17:42:32 -0400
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4184C1C
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 14:42:30 -0700 (PDT)
X-KPN-MessageId: 10acee67-cc1f-11ed-91cc-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id 10acee67-cc1f-11ed-91cc-005056994fde;
        Sun, 26 Mar 2023 23:42:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xs4all.nl; s=xs4all01;
        h=subject:to:from:message-id:date;
        bh=FOHaG8D2+t7NKnOheQiaKsU743SJhRHZwy+ITYWQT9w=;
        b=PGmQl8BUzCG9sCU6fr7lx7ESnRwS06LpaaXh56zx+DaxPVHqnj8A4DqJLlK0g2GoVmtEDaNRYo4H7
         8K9wEBiT29G8LNOIMqJIXDzdgVJ1wFPRdq7VhlmBRH6qSlrxl1JERid1HLbzpvKRm2nFPDDIM+lPw2
         teQYfFIN9YySZVS2T+uHaS+xRGgrQwb2d1HKCZDiafb9JvB3zevGG1ZUrNd/GFXS355A6QG/PnYqHh
         1yqpR/nsE9mqQeSYvGoPujQzoiRVgw7IRLpFtdwJG+ZL+YP8puly3yVeyIH9WDskRRXaeh01n1tdMz
         mIgQgyogj5qpAKPYqgKCNI0PiNOWUUg==
X-KPN-MID: 33|hflgBB15tGX+zdNpKRslL5mh+CpZ/uOmqt5ryKTP4uSj4o30B92d2FImLAWYt3e
 Ilt2bntrlBRe0j8YFV3IChwVIV9neq13kOPTw0KPnEgE=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|LSlsABmnZF/7Drgl6ODBOgZ/U6fYFApiMoIJihfaejXXCn+pqFnEI3v/wyi6Rg7
 ZtpeHDK2Zn4wI/KQ24OjwHQ==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net [80.61.163.207])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id 1a037cf8-cc1f-11ed-87f0-00505699772e;
        Sun, 26 Mar 2023 23:42:28 +0200 (CEST)
Date:   Sun, 26 Mar 2023 23:42:27 +0200
Message-Id: <87cz4v2nr1.fsf@bloch.sibelius.xs4all.nl>
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     bigbeeshane@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <03ec1aac-3c6d-892f-fad9-f386a5d4d10e@linaro.org> (message from
        Krzysztof Kozlowski on Sun, 26 Mar 2023 22:02:39 +0200)
Subject: Re: [PATCH 2/2] dt-bindings: clock: update rk3588 clock definitions
References: <20230326001535.149539-1-bigbeeshane@gmail.com>
 <20230326001535.149539-2-bigbeeshane@gmail.com>
 <10930783-e1dd-5e75-a2cc-a09af862d949@linaro.org>
 <CABnpCuCzdbWTTp1Gc6wWPsB80J5GYw1QzKtZzzyEYU456E=1JA@mail.gmail.com>
 <1b9c8e19-10f2-824d-9b50-51e7a9287bb1@linaro.org>
 <CABnpCuAWm7jh19JKukOquPnZCwHoJispgDPGJzjYy6T_BZSnbg@mail.gmail.com>
 <717bfba9-1d70-ef09-9193-853a57117926@linaro.org>
 <CABnpCuA7V9ti6BOoz+3Mq-f=PwgxL2K7rOhjo6tJ4QquSZbaSA@mail.gmail.com> <03ec1aac-3c6d-892f-fad9-f386a5d4d10e@linaro.org>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Sun, 26 Mar 2023 22:02:39 +0200
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> On 26/03/2023 19:51, Shane Francis wrote:
> >> Bootloader also does not use mainline DTS, so where is exactly the problem?
> > 
> > In this case uboot does load the target DTB, and it seems a common
> > function in rockchips
> > downstream boot process, see :
> > 
> > https://github.com/rockchip-linux/u-boot/blob/ef1dd650042f61915c4859ecc94623a09a3529fa/arch/arm/mach-rockchip/kernel_dtb.c#L70
> >

That code makes absolutely no sense.  This tries to transplant
phandles from one DTB into another DTB?  Mainline U-Boot has no code
like that.  I think this is just broken beyond repair.

> U-Boot comes with its own DTB, so what does it means "loads the target
> DTB"? From where? The one appended to the kernel zImage? No, it cannot...
> 
> Any component which operates on mainline DTB must conform to the
> bindings (with respect to the ABI), thus your arguments here mean you
> are not allowed to change ABI in the future. Never. This change,
> assuming original binding was broken, could be warranted.

The current mainline binding isn't broken; 0 is a perfectly fine clock
index.  The RK3588 clock bindings are already used by U-Boot (too late
to fix for the 2023.4 release happening in a few days) and OpenBSD
(too late to fix for the 7.3 release that will happen a few weeks).
Changing the clock binding will just create more chaos.

<rant>

What is broken here is the development process.  Rockchip shouldn't be
maintaining these heavily modified forks of U-Boot and the Linux
kernel.  But at the same time mainline Linux developers should not be
asking for arbitrary changes to the device tree bindings just to
satisfy some unwritten rules.  The clock bindings were originaly
submitted with clock numbers identical to those that Rockchip uses:

  https://lore.kernel.org/all/20220623160329.239501-2-sebastian.reichel@collabora.com/

but then changed because a reviewer wanted them to start at 0 and
didn't want any holes:

  https://lore.kernel.org/all/0841741a-22f6-40f6-c745-6065dfdbcb1d@linaro.org/

This isn't the first example where this happened.  And it invariably
leads to confusion and breakage in projects that try to follow the
mainline Linux device tree bindings.

</rant>
