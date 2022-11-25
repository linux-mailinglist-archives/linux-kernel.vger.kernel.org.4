Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF756386E3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 10:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiKYJ6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 04:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiKYJ5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 04:57:48 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947372C6;
        Fri, 25 Nov 2022 01:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669370215; x=1700906215;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lydKM6kU5fun6DC5IqmhCzMnSTfb8qo1b4UPgphoXdk=;
  b=gQZAoOLFd+fPbYuAmmmzfQI59cX8qk5ohV6geGhmozUKLK69UyZjYCD/
   aUd4fmE8C40nhkSt+utaD3kEpi1sZdtKCR2Mwb2bYuC/c0RZdAn2GmTFo
   To1HPLrxCXVGcFY2tGDfKmuwYAv5bbsBu+dXQ8SUPjeNw47S9Z7QMkaSD
   bB1zAp87cC6zAp4IpFqShBk2BNEWmrzY1S3J7WuPNoVsLvcVE7cTI0C9j
   amXhur/t7vqXkegyKarLKepi9j5X46Ow9qPsta9bQzbt58ktHAVVMpGE4
   KgiX9RYZp5q6xTTeeA7deZ/APQLmOfN40H81zTFZJ9+j5l8gByH9x4k2D
   g==;
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="190496059"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Nov 2022 02:56:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 25 Nov 2022 02:56:53 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Fri, 25 Nov 2022 02:56:53 -0700
Date:   Fri, 25 Nov 2022 11:01:44 +0100
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
Message-ID: <20221125100144.332tizam7tonqqtz@soft-dev3-1>
References: <20220916194946.2869510-1-horatiu.vultur@microchip.com>
 <bdce1cb7-a771-4ec6-c75b-f547d26f95b3@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <bdce1cb7-a771-4ec6-c75b-f547d26f95b3@microchip.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 11/25/2022 09:23, Claudiu Beznea - M18063 wrote:
> Hi, Horatiu,

Hi Claudiu,

> 
> On 16.09.2022 22:49, Horatiu Vultur wrote:
> > Add OTP (one time programmable) support.
> > The both lan966x SocS (lan9662 and lan9668) have the same OTP IP.
> 
> If OTP IP is the same for both lan966x is there a reason you've added
> compatibles for each SoC variants?

When I was adding the device tree binding, Krzystof mention not to have
any wilcards in compatible string [0].

[0] https://lore.kernel.org/lkml/550e652e-4541-c1e6-33a7-d5555f0cb266@linaro.org/

> 
> Thank you,
> Claudiu Beznea
> 
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
