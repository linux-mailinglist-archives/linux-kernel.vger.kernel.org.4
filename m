Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5816EE0DB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 13:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233952AbjDYLH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 07:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233929AbjDYLHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 07:07:06 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1411E13C2F;
        Tue, 25 Apr 2023 04:06:37 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 4E56F5FD3E;
        Tue, 25 Apr 2023 14:06:12 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1682420772;
        bh=jORapi60saGb6s8dqt0Qj/N+jnHOySKoftd9srjwQEs=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=rRc5dU1h7elVVrLMdQ68XUElEEtq7bwWwUgtV6+mOM9NJnSZxUU/TIdyE5cVikw02
         vK6EdxY2XsJi0G+50e30/FWNBX4dJvX2zdD5NT24ll6uDNdCBmrhUFCQBh+ie+U4VI
         sP15RdoSlG29gtUtuThXm4SWxwId9ahah4GRv5/B+GartSYov43VR8WMd8aIwpGLEi
         /lzZU2VSNpCJuz9Sk2Hzxfn4FfLudJ6OhkrygOpPcR5nnivQMbkcCs/VnclwXOWEG7
         OO6qz+mZzjfy4tHqjYueG+s+azXsSKtWSO0egJxufitROVUXABrZoX/zAIU+1zkBJX
         zi+nTaA/xqwZA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Tue, 25 Apr 2023 14:06:10 +0300 (MSK)
Date:   Tue, 25 Apr 2023 14:06:10 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <mturquette@baylibre.com>, <vkoul@kernel.org>, <kishon@kernel.org>,
        <hminas@synopsys.com>, <Thinh.Nguyen@synopsys.com>,
        <yue.wang@amlogic.com>, <hanjie.lin@amlogic.com>,
        <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-phy@lists.infradead.org>
Subject: Re: [PATCH v2 5/5] arm64: dts: meson: a1: support USB controller in
 OTG mode
Message-ID: <20230425110610.ezhhz2vauc6o4nu2@CAB-WSD-L081021>
References: <20230418111612.19479-1-ddrokosov@sberdevices.ru>
 <20230418111612.19479-6-ddrokosov@sberdevices.ru>
 <CAFBinCDvyweC-m=nKw+FZFYvASDE2x3e-Vt=JkSzBifu87cnNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFBinCDvyweC-m=nKw+FZFYvASDE2x3e-Vt=JkSzBifu87cnNw@mail.gmail.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/04/25 07:55:00 #21159618
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 23, 2023 at 07:51:31PM +0200, Martin Blumenstingl wrote:
> On Tue, Apr 18, 2023 at 1:16 PM Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:
> [...]
> > +                       usb2_phy1: phy@4000 {
> > +                               compatible = "amlogic,a1-usb2-phy";
> > +                               clocks = <&clkc CLKID_USB_PHY_IN>;
> > +                               clock-names = "xtal";
> Out of curiosity since there's also a CLKID_USB_PHY clock (which is
> used for the dwc3 controller below):
> Do we know that this part of the clock hierarchy is correct? I have no
> way to check this myself, so I'm curious if you could verify this
> somehow.
> 
> [...]

I've developed a clock driver for A1 and verified it against the Amlogic
custom driver and datasheet. As you pointed out, there are indeed two
USB phy clocks.
They are labeled as follows in my clock driver:
    * CLKID_USB_PHY_IN (xtal -> usb_phy gated clock) - the phy input clock
    * CLKID_USB_PHY (SYS_CLK_EN based gate) - the synopsys IP gated clock

The current representation of the USB phy clocks is solely based on
my technical opinion, as the datasheet does not provide any detailed
information about them.

Clock driver:
https://lore.kernel.org/all/20230405195927.13487-1-ddrokosov@sberdevices.ru/

> > +                       dwc2: usb@ff500000 {
> > +                               compatible = "amlogic,meson-a1-usb", "snps,dwc2";
> > +                               reg = <0x0 0xff500000 0x0 0x40000>;
> > +                               interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
> > +                               phys = <&usb2_phy1>;
> > +                               phy-names = "usb2_phy";
> Documentation/devicetree/bindings/usb/dwc2.yaml only allows a
> "usb2-phy" (dash instead of underscore).
> 
> [...]

Ah, my fault..

> > +                       dwc3: usb@ff400000 {
> > +                               compatible = "snps,dwc3";
> > +                               reg = <0x0 0xff400000 0x0 0x100000>;
> Note to self: interesting that Amlogic swapped the register location
> of the dwc2 and dwc3 controllers since the G12 generation.

Indeed, during the bringup process, I was surprised to discover that
the dwc2 engine wasn't starting properly. It was quite unexpected, but
also admittedly intriguing as I delved into the issue and tried to
understand the root cause.

-- 
Thank you,
Dmitry
