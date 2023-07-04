Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71801747990
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 23:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjGDV2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 17:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjGDV2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 17:28:15 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49439195;
        Tue,  4 Jul 2023 14:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=wySgJTzp0DwGyi/w7+8EFiBtpc8Kz+inKOVzp7KIGB8=; b=m0dxCKEWN5yw85WdwxLxNDxXCh
        PTc5rUXUPAx4OzYbPvPUOWjnGcAkBY7VHqxTIPPmmHAfLZVCTAf6o/nDLHW7YcTMUuqVVBvICtSLT
        t72jkFO+vnqSNYXcumFQcPUiZCW5LzWcpgn1JMvJqYhkKsKzxGSDIRb5dIMGKPQ9OJyc=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:46704 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qGnZ4-00037U-Jy; Tue, 04 Jul 2023 17:28:03 -0400
Date:   Tue, 4 Jul 2023 17:28:01 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Pierluigi Passaro <pierluigi.p@variscite.com>,
        Nate Drude <nate.d@variscite.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Message-Id: <20230704172801.f11422b3f947c625f53af871@hugovil.com>
In-Reply-To: <CAOMZO5BNaQVMKbxU9rc5zOBwv9c+HayLnkjqrSgPKgMGzQ585A@mail.gmail.com>
References: <20230704150240.2022020-1-hugo@hugovil.com>
        <1341ba38-35c1-1657-aed4-a3c11f584367@linaro.org>
        <20230704113124.f2830afe1d9df252afe5abdc@hugovil.com>
        <834a0679-7e0c-150f-68be-c75d7dac0bc8@linaro.org>
        <CAOMZO5CX8WzaNeHmE8ohT2_6F-ehRRNWGnF7Dji=uLGphY4q2A@mail.gmail.com>
        <20230704125541.f361cab8de3faacd830418ab@hugovil.com>
        <20230704130204.7ac64cbd76b3440fc351c373@hugovil.com>
        <CAOMZO5Dsp7YZfmpkBNsQgE4d3Ag-v2fpBAU=aZ9NGqGYoaOMWQ@mail.gmail.com>
        <20230704164140.824f6890dae5c87fc92531b4@hugovil.com>
        <CAOMZO5BNaQVMKbxU9rc5zOBwv9c+HayLnkjqrSgPKgMGzQ585A@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
Subject: Re: [PATCH] arm64: dts: imx8mn-var-som-symphony: fix USB OTG
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jul 2023 18:02:53 -0300
Fabio Estevam <festevam@gmail.com> wrote:

> Hi Hugo,
> 
> On Tue, Jul 4, 2023 at 5:41 PM Hugo Villeneuve <hugo@hugovil.com> wrote:
> 
> > Hi Fabio,
> > with interrupts = <11 IRQ_TYPE_LEVEL_LOW>, USB OTG doesn't work.
> 
> PTN5150 datasheet says:
> 
> "Any changes in the attach/detach events or Rp current source changes
> will trigger INTB pin to go LOW."

Hi Fabio,
it is important to remember that on this board, like I explained
before, the INTB pin is not connected to anything.

It is only the ID pin (9) that is connected to the GPIO1_11 pin.

> What about:  interrupts = <11 IRQ_TYPE_EDGE_FALLING>; ?

With this setting, USB OTG works:

$ dmesg | grep 5150
[    4.833529] ptn5150 1-003d: No VBUS GPIO, ignoring VBUS control
[    4.839972] ptn5150 1-003d: DEBUG_IRQ: i2c->irq: 42
[    4.874173] ptn5150 1-003d: DEBUG_IRQ: error in usb_role_switch_get()
[    4.896822] ptn5150 1-003d: No VBUS GPIO, ignoring VBUS control
[    4.902905] ptn5150 1-003d: DEBUG_IRQ: i2c->irq: 42
[    4.911190] ptn5150 1-003d: DEBUG_IRQ: error in usb_role_switch_get()
[    4.918462] ptn5150 1-003d: No VBUS GPIO, ignoring VBUS control
[    4.926197] ptn5150 1-003d: DEBUG_IRQ: i2c->irq: 42
[    4.935210] ptn5150 1-003d: DEBUG_IRQ: error in usb_role_switch_get()
[    4.947673] ptn5150 1-003d: No VBUS GPIO, ignoring VBUS control
[    4.953771] ptn5150 1-003d: DEBUG_IRQ: i2c->irq: 42
[    4.961104] ptn5150 1-003d: DEBUG_IRQ: error in usb_role_switch_get()
[    5.052165] ptn5150 1-003d: No VBUS GPIO, ignoring VBUS control
[    5.058234] ptn5150 1-003d: DEBUG_IRQ: i2c->irq: 42
[    5.064632] ptn5150 1-003d: DEBUG_IRQ: error in usb_role_switch_get()
[    5.096452] ptn5150 1-003d: No VBUS GPIO, ignoring VBUS control
[    5.102578] ptn5150 1-003d: DEBUG_IRQ: i2c->irq: 42
[    5.114959] ptn5150 1-003d: DEBUG_IRQ: error in usb_role_switch_get()
[    5.187060] ptn5150 1-003d: No VBUS GPIO, ignoring VBUS control
[    5.193243] ptn5150 1-003d: DEBUG_IRQ: i2c->irq: 42
[    5.206235] ptn5150 1-003d: DEBUG_IRQ: probe done


> Also, please add a pullup to the GPIO1_11 pad.

There is already an external 10K pull-up resistor (R88) to +3.3V 
on GPIO1_11 pin...

Hugo.
