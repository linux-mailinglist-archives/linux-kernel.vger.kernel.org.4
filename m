Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B49635A9E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 11:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237231AbiKWKyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 05:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236560AbiKWKx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 05:53:28 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9258E2DD2;
        Wed, 23 Nov 2022 02:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669200078; x=1700736078;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j3uIlflRX6X3w3UzK50E4aZVuOuALfClRJmuCDZuPSc=;
  b=gM4WVsfL9Ztl+ATQgqY+bHEDZhnWNAwFHJ5/d+XHLJHeFa6MRLPDv2Yf
   G5p32RVDr/eMU0O9gNfDuYUr7QSP5mGjYecjuG2BT9UGR9tw82rB+gfiO
   ejdzcJ9eMucFnG2Ua7EhjazJBIEAymCPmxEh4/QIYcYb1FUuusudM4BCZ
   ZThCFoLpsHod6nRWcaa5EKUiiQr1np3VrL6EbYBo3sz5ny2AASklO02Tq
   mRLLj6cL8pKf3nnIj//jWT87ALW/6AG1fydIx0HWxLmACJKOBiSM1Muuh
   vTpvnsrSGMU0buk1USPYm0OzvBsaq3Hsec8D0Xdxwqj1uoLPgUvys90sq
   g==;
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="188308734"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Nov 2022 03:41:18 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 23 Nov 2022 03:40:59 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Wed, 23 Nov 2022 03:40:59 -0700
Date:   Wed, 23 Nov 2022 11:45:50 +0100
From:   Horatiu Vultur - M31836 <Horatiu.Vultur@microchip.com>
To:     Claudiu Beznea - M18063 <Claudiu.Beznea@microchip.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Ferre - M43238 <Nicolas.Ferre@microchip.com>,
        UNGLinuxDriver <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH] ARM: dts: lan966x: Add otp support
Message-ID: <20221123104550.3hnod4bo4yitisy3@soft-dev3-1>
References: <20220916194946.2869510-1-horatiu.vultur@microchip.com>
 <c108d42d-dae8-0852-d89b-160b70b196dc@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <c108d42d-dae8-0852-d89b-160b70b196dc@microchip.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 10/26/2022 07:42, Claudiu Beznea - M18063 wrote:

Hi Claudiu,

I just want to let you know that the patch that blocked this patch
was applied and reached the linus' tree [0].
Should I resend this patch?

[0] https://elixir.bootlin.com/linux/v6.1-rc6/source/drivers/nvmem/lan9662-otpc.c#L206

> Hi, Horatiu,
> 
> I will postpone this until [1] or [2] is applied.
> 
> Thank you,
> Claudiu Beznea
> 
> [1]
> https://lore.kernel.org/all/20220928195112.630351-1-horatiu.vultur@microchip.com/
> [2]
> https://lore.kernel.org/all/20221025072217.3715634-1-claudiu.beznea@microchip.com/
> 
> On 16.09.2022 22:49, Horatiu Vultur wrote:
> > Add OTP (one time programmable) support.
> > The both lan966x SocS (lan9662 and lan9668) have the same OTP IP.
> > 
> > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> > ---
> >  arch/arm/boot/dts/lan966x.dtsi | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/lan966x.dtsi b/arch/arm/boot/dts/lan966x.dtsi
> > index 23665a0429906..784caba369485 100644
> > --- a/arch/arm/boot/dts/lan966x.dtsi
> > +++ b/arch/arm/boot/dts/lan966x.dtsi
> > @@ -163,6 +163,11 @@ port7: port@7 {
> >  			};
> >  		};
> >  
> > +		otp: otp@e0021000 {
> > +			compatible = "microchip,lan9668-otpc", "microchip,lan9662-otpc";
> > +			reg = <0xe0021000 0x300>;
> > +		};
> > +
> >  		flx0: flexcom@e0040000 {
> >  			compatible = "atmel,sama5d2-flexcom";
> >  			reg = <0xe0040000 0x100>;
> 

-- 
/Horatiu
