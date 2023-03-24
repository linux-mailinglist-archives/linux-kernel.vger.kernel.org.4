Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B65C6C7DB1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 13:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbjCXMGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 08:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbjCXMGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 08:06:22 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B501F4BA;
        Fri, 24 Mar 2023 05:06:17 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id CA5C05FD6A;
        Fri, 24 Mar 2023 15:06:14 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1679659574;
        bh=k3sf6EC4sogl093QAM9hkykETNle5E2MS3s+d/HgAfM=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=IVzxfUcoCuX0vmnekzmfm3f7vnBzYB+tqMrgR7lL+BoEJt+qzQ2tgj4rwSgZ21isJ
         IxoLErTYPXcQgQjBzi5LiDxdwZWYOQmJVzHBzqpPJRcIVLXAlSlBFU60HynmDMzeP7
         PFzz3vdXD7Xy9SCMxXUhwQtMmC52L1EB/BDsR3ZasVKKUI8Ga6zNGLyWbvKwhAeHLc
         Sf3AfTMq68u8k9mTdtEakKqMbjGOFypMcYq6x4HbpnM5hIj3oCqunOPhnFUtsOaxyJ
         x/kAHL10YLn1UplLktZu1xlV+B9u7ptgEt9jsNMZl7mlY2EslVRpVKY72xoMoy8pK7
         aDPMPYJKGlWMA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Fri, 24 Mar 2023 15:06:13 +0300 (MSK)
Date:   Fri, 24 Mar 2023 15:06:12 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     <neil.armstrong@linaro.org>
CC:     <krzysztof.kozlowski@linaro.org>, <robh@kernel.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <martin.blumenstingl@googlemail.com>, <jianxin.pan@amlogic.com>,
        <kernel@sberdevices.ru>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <rockosov@gmail.com>
Subject: Re: [PATCH v1] arm64: dts: meson: a1: place pwrc and secure-monitor
 under /firmware
Message-ID: <20230324120612.tpb3uga56ilz7yqx@CAB-WSD-L081021>
References: <20230323185548.13731-1-ddrokosov@sberdevices.ru>
 <d180c7d5-7db9-a961-e519-cca5ccf6f013@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d180c7d5-7db9-a961-e519-cca5ccf6f013@linaro.org>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/03/24 06:52:00 #21002836
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Neil,

On Fri, Mar 24, 2023 at 11:11:02AM +0100, neil.armstrong@linaro.org wrote:
> Hi,
> 
> On 23/03/2023 19:55, Dmitry Rokosov wrote:
> > Before, meson power secure controller was a child of secure monitor node.
> > But secure monitor isn't the bus in terms of device tree subsystem, so
> > of_platform initialization code doesn't populate its children
> > (of_platform_default_populate() API).
> > 
> > Therefore in the current device tree meson power secure controller isn't
> > probed at all.
> > 
> > If we place meson power secure controller and secure monitor nodes under
> > '/firmware', they will be populated automatically from of_platform
> > initialization.
> > 
> > Fixes: 04dd0b6584cd ("arm64: dts: meson: a1: add secure power domain controller")
> > Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> > ---
> >   arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 6 ++++--
> >   1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> > index 77023a29b6e7..44c651254dc5 100644
> > --- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> > +++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> > @@ -72,8 +72,10 @@ linux,cma {
> >   		};
> >   	};
> > -	sm: secure-monitor {
> > -		compatible = "amlogic,meson-gxbb-sm";
> > +	firmware {
> > +		sm: secure-monitor {
> > +			compatible = "amlogic,meson-gxbb-sm";
> > +		};
> >   		pwrc: power-controller {
> >   			compatible = "amlogic,meson-a1-pwrc";
> 
> The amlogic,meson-gxbb-sm bindings says the power-controller node should be
> a subnode of secure-monitor, so instead please fix the sm driver by calling:
> 
> of_platform_populate(dev->of_node, NULL, NULL, dev);

This is second option which I was thinking of. I supposing this API is
used from SoC platform drivers and bus drivers only.
But if this approach is okay, I will rework the patch to
of_platform_populate().

Thank you for pointing out it.

-- 
Thank you,
Dmitry
