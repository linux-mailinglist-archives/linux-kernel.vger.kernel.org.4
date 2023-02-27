Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2311B6A445D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 15:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjB0O2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 09:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjB0O2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 09:28:16 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1867CA5C6;
        Mon, 27 Feb 2023 06:28:14 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 083DA5FD18;
        Mon, 27 Feb 2023 17:28:11 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1677508091;
        bh=dHA/Wc3Fmu2Ic2yiLPy7ks11PfgCivPYbG1QvntY4RI=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=Zel0j/24EN18NurGpIm8rfbVXkCFfOOYSv6j+TFBnkDIF93AbsupE4YvZNiqr2ls9
         HLIME5RCEC+i59clo7uAiR7k/8V2yphl54m96LCEI8I9CK085pJ997peXOfXCIAUEN
         lqFz+VxIO9FygFdBB0Ud++tuxrrWwp5edkjMPux51JEC96LTAcyKUzIg2U3MHszt3C
         7FtthXWvaU475A8AMJ1LW/TjeBR4YuZrK4KYNRZ5+YfEgBLzCRKZq/bdJdAncbYrdw
         R3pv7BnyiFrsIXUdE/6ftXHANj5YTUpD3o6h5jsgSh7qe0JTD9MoPad4M/BEckMh+y
         38xFN9hEqd9MQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Mon, 27 Feb 2023 17:28:10 +0300 (MSK)
Date:   Mon, 27 Feb 2023 17:28:09 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     <neil.armstrong@linaro.org>
CC:     Alexey Romanov <avromanov@sberdevices.ru>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <khilman@baylibre.com>,
        <jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>,
        <linus.walleij@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@sberdevices.ru>
Subject: Re: [PATCH v1 0/3] Meson A1 32-bit support
Message-ID: <20230227142809.kujmrraf3pcdhqyn@CAB-WSD-L081021>
References: <20230222115020.55867-1-avromanov@sberdevices.ru>
 <8e5f9bfa-d612-cd43-d722-d04c40938c62@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8e5f9bfa-d612-cd43-d722-d04c40938c62@linaro.org>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/02/27 12:14:00 #20900843
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Neil!

On Mon, Feb 27, 2023 at 09:15:04AM +0100, neil.armstrong@linaro.org wrote:

[...]

> I'm aware Amlogic also runs their kernel as 32bit to gain a few kbytes
> of memory, but those processors are ARMv8 and the arm64 arch code
> has been designed for those CPUs.
> 
> So far I didn't find a single good reason to add 32bit support for
> ARMv8 Amlogic based SoCs, if you have a solid reason please share.

I totally agree with you, but I suppose it's fully related to 'big'
Amlogic SoC like S905_ or A311_ series. A113L (aka 'a1') is
a cost-efficient dual-core SoC which is used for small, cheap solutions
with cheap components. Every cent is important during BoM development.
That's why usually ODMs install small ROM and RAM capacity, and each
megabyte is important for RAM/ROM kernel and rootfs footprints.
Why am I talking about rootfs? For such small projects a good
choice is buildroot rootfs assembling framework. Unfortunatelly,
buildroot doesn't support 'compat' mode when kernel and userspace have
a different bitness. In the internal project, we save several
percents of ROM/RAM free space using 32-bit configuration (mostly rootfs
ROM space, to be honest). Therefore, for such 'little' cost-efficient
SoCs we can make an exception and support 32-bit configuration, from my
point of view.

What do you think about that?

> 
> And as Krzysztof stated, the support is incomplete and cannot work
> without a dts file.

Agreed, we shouldn't merge dead code. But there are several question to
discuss there. Please check my reply to Krzysztof message.

[...]

-- 
Thank you,
Dmitry
