Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745FC747915
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 22:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbjGDUlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 16:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjGDUlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 16:41:53 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951D7DD;
        Tue,  4 Jul 2023 13:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=HW7ZhyDLqVKFKjCFNLAp0JD1t9Vseu4A09CiQofsdVA=; b=BrAzDcxQh7bvYdJyngJQO7Y3hL
        8KN8wckDrJFW2YLx4P5BvsjfcKPxb5gnDyLOPUypmEUeWIyZGWwU2jqsVGoqCVRb4O06l7AQcszUa
        MF0SfZr/QidtkDdh5JQ5vHlax5EBY7f71g4wlPDVw71+X2GwMxs2kvGUQ4OddWhmP71s=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:53038 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qGmqD-0002iu-6G; Tue, 04 Jul 2023 16:41:41 -0400
Date:   Tue, 4 Jul 2023 16:41:40 -0400
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
Message-Id: <20230704164140.824f6890dae5c87fc92531b4@hugovil.com>
In-Reply-To: <CAOMZO5Dsp7YZfmpkBNsQgE4d3Ag-v2fpBAU=aZ9NGqGYoaOMWQ@mail.gmail.com>
References: <20230704150240.2022020-1-hugo@hugovil.com>
        <1341ba38-35c1-1657-aed4-a3c11f584367@linaro.org>
        <20230704113124.f2830afe1d9df252afe5abdc@hugovil.com>
        <834a0679-7e0c-150f-68be-c75d7dac0bc8@linaro.org>
        <CAOMZO5CX8WzaNeHmE8ohT2_6F-ehRRNWGnF7Dji=uLGphY4q2A@mail.gmail.com>
        <20230704125541.f361cab8de3faacd830418ab@hugovil.com>
        <20230704130204.7ac64cbd76b3440fc351c373@hugovil.com>
        <CAOMZO5Dsp7YZfmpkBNsQgE4d3Ag-v2fpBAU=aZ9NGqGYoaOMWQ@mail.gmail.com>
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

On Tue, 4 Jul 2023 15:04:37 -0300
Fabio Estevam <festevam@gmail.com> wrote:

> Hi Hugo,
> 
> On Tue, Jul 4, 2023 at 2:02 PM Hugo Villeneuve <hugo@hugovil.com> wrote:
> 
> > Ok, I tought pin 9 (ID) was an input, but it is in fact an output
> > driven by the PTN5150 so the last sentence is incorrect.
> 
> Does USB OTG work if you keep interrupts = <11 IRQ_TYPE_LEVEL_LOW> ?

Hi Fabio,
with interrupts = <11 IRQ_TYPE_LEVEL_LOW>, USB OTG doesn't work.

I have added additional debug messages to help diagnose
(prefixed by DEBUG_IRQ), and here is what I have:

With IRQ_TYPE_LEVEL_LOW:

$ dmesg | grep 5150
[    4.729134] ptn5150 1-003d: No VBUS GPIO, ignoring VBUS control
[    4.735257] ptn5150 1-003d: DEBUG_IRQ: i2c->irq: 42
[    4.749563] ptn5150 1-003d: DEBUG_IRQ: error in usb_role_switch_get()
[    4.792956] ptn5150 1-003d: No VBUS GPIO, ignoring VBUS control
[    4.799022] ptn5150 1-003d: DEBUG_IRQ: i2c->irq: 0
[    4.803889] ptn5150 1-003d: error -ENOENT: failed to get INT GPIO
[    4.810085] ptn5150: probe of 1-003d failed with error -2


With IRQ_TYPE_NONE:

$ dmesg | grep 5150
[    4.726860] ptn5150 1-003d: No VBUS GPIO, ignoring VBUS control
[    4.736050] ptn5150 1-003d: DEBUG_IRQ: i2c->irq: 42
[    4.768351] ptn5150 1-003d: DEBUG_IRQ: error in usb_role_switch_get()
[    4.803091] ptn5150 1-003d: No VBUS GPIO, ignoring VBUS control
[    4.809172] ptn5150 1-003d: DEBUG_IRQ: i2c->irq: 42
[    4.816030] ptn5150 1-003d: DEBUG_IRQ: error in usb_role_switch_get()
[    4.825915] ptn5150 1-003d: No VBUS GPIO, ignoring VBUS control
[    4.832057] ptn5150 1-003d: DEBUG_IRQ: i2c->irq: 42
[    4.840722] ptn5150 1-003d: DEBUG_IRQ: error in usb_role_switch_get()
[    4.889220] ptn5150 1-003d: No VBUS GPIO, ignoring VBUS control
[    4.895271] ptn5150 1-003d: DEBUG_IRQ: i2c->irq: 42
[    4.901636] ptn5150 1-003d: DEBUG_IRQ: error in usb_role_switch_get()
[    4.934740] ptn5150 1-003d: No VBUS GPIO, ignoring VBUS control
[    4.940840] ptn5150 1-003d: DEBUG_IRQ: i2c->irq: 42
[    4.947223] ptn5150 1-003d: DEBUG_IRQ: error in usb_role_switch_get()
[    4.993208] ptn5150 1-003d: No VBUS GPIO, ignoring VBUS control
[    4.999347] ptn5150 1-003d: DEBUG_IRQ: i2c->irq: 42
[    5.014494] ptn5150 1-003d: DEBUG_IRQ: error in usb_role_switch_get()
[    5.071615] ptn5150 1-003d: No VBUS GPIO, ignoring VBUS control
[    5.077771] ptn5150 1-003d: DEBUG_IRQ: i2c->irq: 42
[    5.101222] ptn5150 1-003d: DEBUG_IRQ: probe done

Hugo.
