Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7545A60E691
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 19:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233878AbiJZRdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 13:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiJZRdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 13:33:36 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3071057F9;
        Wed, 26 Oct 2022 10:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666805614; x=1698341614;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O261lLQiLqPVrCWlpXCG39uNCbVIJ7+DxA1Gv8LAvJg=;
  b=zP0ZKPtSX0axz/gs1TpNHwKXL+ewqJgV/YW/iQZKRcAO1KXqYZvFDoSr
   YXQcUf9uswzadXVEpNyTs2oBP4DPv7oFPlI4k//NHjw+OQR3bvf74cfhC
   HWpGq4jZKAlre1cspxU61LFKcIpGK98J4Opw5t4ZK1HESKi9gyWMl93ZN
   QGuu6VbltsVTTwXAfD7PXGk4vG7OPCdxJt0LNU5dcVvUfpEzbYmyiV/nZ
   PFacxC3yJP4Kp1gVbCRYan8QBw/awzh2VI2Vt9CC7xngU3ZmIrZctt/Uz
   0UU0+lkmh94/bLGJD997rP45dFwcht1jjXqSdqychpeiwmSn55r6xKljF
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="186409655"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Oct 2022 10:33:33 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 26 Oct 2022 10:33:32 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Wed, 26 Oct 2022 10:33:32 -0700
Date:   Wed, 26 Oct 2022 19:38:13 +0200
From:   Horatiu Vultur - M31836 <Horatiu.Vultur@microchip.com>
To:     Claudiu Beznea - M18063 <Claudiu.Beznea@microchip.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Ferre - M43238 <Nicolas.Ferre@microchip.com>,
        UNGLinuxDriver <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH] ARM: dts: lan966x: Enable sgpio on pcb8291
Message-ID: <20221026173813.wdpueueziirxdgq5@soft-dev3-1>
References: <20221019075154.2555054-1-horatiu.vultur@microchip.com>
 <fb12f594-5d71-dc35-c37e-b357e51b6b3c@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <fb12f594-5d71-dc35-c37e-b357e51b6b3c@microchip.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 10/26/2022 07:47, Claudiu Beznea - M18063 wrote:
> Hi, Horatiu,

Hi Claudiu,

> 
> On 19.10.2022 10:51, Horatiu Vultur wrote:
> > Enable sgpio node on pcb8291 as this is needed to be able to control
> > the LEDs on this board. Otherwise the LEDs support on the board will
> > not be available.
> 
> Do we need a fixes tag for this?

I was not 100% sure that I need to add the tag, but I will send
another version where I will add the tag.

> 
> > On the other board pcb8309 the sgpio is already enabled because it
> > needed to access the SFP ports.
> > 
> > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> > ---
> >  arch/arm/boot/dts/lan966x-pcb8291.dts | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/lan966x-pcb8291.dts b/arch/arm/boot/dts/lan966x-pcb8291.dts
> > index f4f054cdf2a87..3a3d76af86122 100644
> > --- a/arch/arm/boot/dts/lan966x-pcb8291.dts
> > +++ b/arch/arm/boot/dts/lan966x-pcb8291.dts
> > @@ -69,6 +69,12 @@ can0_b_pins:  can0-b-pins {
> >  		pins = "GPIO_35", "GPIO_36";
> >  		function = "can0_b";
> >  	};
> > +
> > +	sgpio_a_pins: sgpio-a-pins {
> > +		/* SCK, D0, D1, LD */
> > +		pins = "GPIO_32", "GPIO_33", "GPIO_34", "GPIO_35";
> > +		function = "sgpio_a";
> > +	};
> >  };
> >  
> >  &can0 {
> > @@ -118,6 +124,20 @@ &serdes {
> >  	status = "okay";
> >  };
> >  
> > +&sgpio {
> > +	pinctrl-0 = <&sgpio_a_pins>;
> > +	pinctrl-names = "default";
> > +	microchip,sgpio-port-ranges = <0 3>, <8 11>;
> > +	status = "okay";
> > +
> > +	gpio@0 {
> > +		ngpios = <64>;
> > +	};
> > +	gpio@1 {
> > +		ngpios = <64>;
> > +	};
> > +};
> > +
> >  &switch {
> >  	status = "okay";
> >  };
> 

-- 
/Horatiu
