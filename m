Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6388074755B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 17:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjGDPbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 11:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjGDPbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 11:31:37 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C240810EF;
        Tue,  4 Jul 2023 08:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=aSU/8YfMkAedsJBdoHeDZK33yvVVAM8JcV5bQFqXvjw=; b=IyKETWm9la4KtMOpWcEn4clUw5
        5kFA5HTuFdnUgZRdhnufpqH2tXR2SVYRvCEzXaUq5jMHiLLnKMV7XpNcA4Cqt11p1U5Sns7ULlKK+
        9uD5yOblRUvddMgtQVJTtOqvgvn2S77oLkdgez34FZhGLIJ7La4FPApEjaQpj/+MUmZU=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:52252 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qGhzx-0000Bk-LL; Tue, 04 Jul 2023 11:31:26 -0400
Date:   Tue, 4 Jul 2023 11:31:24 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Message-Id: <20230704113124.f2830afe1d9df252afe5abdc@hugovil.com>
In-Reply-To: <1341ba38-35c1-1657-aed4-a3c11f584367@linaro.org>
References: <20230704150240.2022020-1-hugo@hugovil.com>
        <1341ba38-35c1-1657-aed4-a3c11f584367@linaro.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 4 Jul 2023 17:08:12 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 04/07/2023 17:02, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > USB OTG is currently broken on the Variscite Symphony EVK and imx8mn
> > nano SOM.
> > 
> > Import changes from linux-5.15 branch of  doen't giveto fix it.
> > 
> > Link: https://github.com/varigit/linux-imx.git
> > Fixes: 7358e05bddca ("arm64: dts: imx8mn-var-som-symphony: Add Variscite Symphony board with VAR-SOM-MX8MN")
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > ---
> >  .../dts/freescale/imx8mn-var-som-symphony.dts | 37 ++++++++++++++++++-
> >  1 file changed, 35 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts b/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts
> > index 406a711486da..aef89198f24c 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts
> > @@ -6,6 +6,7 @@
> >  
> >  /dts-v1/;
> >  
> > +#include <dt-bindings/usb/pd.h>
> >  #include "imx8mn-var-som.dtsi"
> >  
> >  / {
> > @@ -104,10 +105,29 @@ extcon_usbotg1: typec@3d {
> >  		compatible = "nxp,ptn5150";
> >  		reg = <0x3d>;
> >  		interrupt-parent = <&gpio1>;
> > -		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
> > +		interrupts = <11 IRQ_TYPE_NONE>;
> 
> That's surprising, why?

Hi,
the varigit repos log or source code has no information about this
particular configuration.

In the schematics, the interrupt output pin of the PTN5150 is connected
to two different resistors, one of these being connected to GPIO1 pin
11. But these two resistors are not assembled on any versions of the
board, so the interrupt pin is currently not used.

Hugo.
