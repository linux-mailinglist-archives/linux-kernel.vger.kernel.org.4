Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606E35B6905
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 09:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbiIMHxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 03:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbiIMHw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 03:52:59 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93C9543C5;
        Tue, 13 Sep 2022 00:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663055578; x=1694591578;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=knZhzRD1rPrCT9tfB8+UU6FETZqBRyh4NXb907yKBSI=;
  b=HwP+9ch2y/QSzMs4cO3ITxwdCHVKOfMzO/Gls890JXDbbpdgFdE/6LYz
   uux3pMvEBelCvi2tX6r0AuECZdOtb8RQQrus2oxeGFuov1gsQAQAJ7dwx
   TfbTao7ar4i0+pRqRLcnDtDGmzxxRNGFjYAqHM1/waM9xYQqgAB6Gouan
   oa/U5HM4/i3V2nkz8l3gFw7V+Loryw4EPRYwG3iB1VIsVUFLyoD9/ZQL2
   urqgrBrJkMY/oeGiTz0gWhXCE27AXc/7+Up8RjNMhbckpP8yL0+LSMQwZ
   qTdYitQ3iu33dNFJMgpGPbW9KdylEjSQYLj8DHXAEeLsgakQ2DN+zYbBo
   w==;
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="190584736"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Sep 2022 00:52:58 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 13 Sep 2022 00:52:57 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Tue, 13 Sep 2022 00:52:57 -0700
Date:   Tue, 13 Sep 2022 09:57:19 +0200
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Michael Walle <michael@walle.cc>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <claudiu.beznea@microchip.com>, <nicolas.ferre@microchip.com>
Subject: Re: [PATCH] ARM: dts: lan966x: Fix the interrupt number for internal
 PHYs
Message-ID: <20220913075719.y63uvvwzquk435ht@soft-dev3-1.localhost>
References: <20220912192629.461452-1-horatiu.vultur@microchip.com>
 <caf34bf663601404df4021bc14297eeb@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <caf34bf663601404df4021bc14297eeb@walle.cc>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 09/13/2022 09:18, Michael Walle wrote:
> 
> Hi Horatiu,

Hi Walle,

> 
> Am 2022-09-12 21:26, schrieb Horatiu Vultur:
> > According to the datasheet the interrupts for internal PHYs are
> > 80 and 81.
> 
> Can you point me to that documentation?

I have not found yet one on the microchip.com

> 
> Accoring to Table 3-155: Shared Peripheral Interrupts
> There are ID47 and ID48 listed as "MIIM controller 0 interrupt".
> Whatever that is, because the internal PHYs are on MIIM
> controller 1.
> 
> But 80 and 81 would be ID48 and ID49. Did you test the
> interrupts?

Looking the same table (3-155) in the documentation that I have these
interrupts correspond to ID112 and ID113 (Embedded CuPHY port 0/1 interrupt).
And because these are shared peripheral interrupts, it is required to
substract 32. Therefore I got the numbers 80 and 81.

As the internal PHYs don't have yet interrupt support, I have sent a
patch here [1] and I have tested it with this.

[1] https://www.spinics.net/lists/kernel/msg4511731.html

> 
> -michael
> 
> > Fixes: 6ad69e07def67c ("ARM: dts: lan966x: add MIIM nodes")
> > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> > ---
> >  arch/arm/boot/dts/lan966x.dtsi | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/lan966x.dtsi
> > b/arch/arm/boot/dts/lan966x.dtsi
> > index bcb130a2471d..23665a042990 100644
> > --- a/arch/arm/boot/dts/lan966x.dtsi
> > +++ b/arch/arm/boot/dts/lan966x.dtsi
> > @@ -547,13 +547,13 @@ mdio1: mdio@e200413c {
> > 
> >                       phy0: ethernet-phy@1 {
> >                               reg = <1>;
> > -                             interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
> > +                             interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
> >                               status = "disabled";
> >                       };
> > 
> >                       phy1: ethernet-phy@2 {
> >                               reg = <2>;
> > -                             interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
> > +                             interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
> >                               status = "disabled";
> >                       };
> >               };

-- 
/Horatiu
