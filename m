Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2936EE1D6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 14:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbjDYM1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 08:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbjDYM1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 08:27:54 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABABFCC2E;
        Tue, 25 Apr 2023 05:27:51 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33PCRisC031241;
        Tue, 25 Apr 2023 07:27:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1682425664;
        bh=ipiUSnmA2+1WIk0HkySkOwI9+HpDpHtuOrmd8pbEBQc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=LLp1TG/LTVkyTJODVxQ+iFjnO3CPPNMSoeDoAVMxXeIctcGbRg8ekE6Mpl+ULZwE5
         rS9btWwaEwvbNy8KOWRhjcTbWoVgTrC+MXSQiOteBWfE96Fv0MG9obqyDKQ09EYron
         4P9po4zePwbPWNDHaAoy++qK5me5+dmXQoWKJx3o=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33PCRifO023020
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Apr 2023 07:27:44 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 25
 Apr 2023 07:27:44 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 25 Apr 2023 07:27:44 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33PCRiG5111194;
        Tue, 25 Apr 2023 07:27:44 -0500
Date:   Tue, 25 Apr 2023 07:27:44 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Andrew Davis <afd@ti.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, <vaishnav.a@ti.com>,
        <u-kumar1@ti.com>
Subject: Re: [PATCH 3/3] arm64: dts: ti: k3-j7200-mcu-wakeup: Split fss node
 up
Message-ID: <20230425122744.hkahpv6yvprd6qzy@creature>
References: <20230424173623.477577-1-nm@ti.com>
 <20230424173623.477577-4-nm@ti.com>
 <f5861b8b-637a-e127-2945-8994a472015a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f5861b8b-637a-e127-2945-8994a472015a@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13:55-20230424, Andrew Davis wrote:
> On 4/24/23 12:36 PM, Nishanth Menon wrote:
> > fss node claims to be entirely a syscon node, but it is really two
> > parts of it - one a syscon that controls the hbmc mux and a simple bus
> > where ospi, hbmc peripherals are located. So model it accordingly by
> > splitting the node up and using ti,j721e-system-controller to describe
> > the syscon
> > 
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > ---
> >   .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 21 +++++++++++++------
> >   1 file changed, 15 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> > index b58a31371bf3..7653cb191be1 100644
> > --- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> > @@ -338,18 +338,27 @@ mcu_spi2: spi@40320000 {
> >   		status = "disabled";
> >   	};
> > -	fss: syscon@47000000 {
> > -		compatible = "syscon", "simple-mfd";
> > +	hbmc_syscon: syscon@47000000 {
> > +		compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
> >   		reg = <0x00 0x47000000 0x00 0x100>;
> > -		#address-cells = <2>;
> > -		#size-cells = <2>;
> > -		ranges;
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		ranges = <0x00 0x00 0x47000000 0x100>;
> > -		hbmc_mux: hbmc-mux {
> > +		hbmc_mux: mux-controller@4 {
> >   			compatible = "mmio-mux";
> > +			reg = <0x4 0x2>;
> >   			#mux-control-cells = <1>;
> >   			mux-reg-masks = <0x4 0x2>; /* HBMC select */
> >   		};
> > +	};
> > +
> > +	fss: bus@47030000 {
> > +		compatible = "simple-bus";
> > +		reg = <0x0 0x47030000 0x0 0x100>;
> > +		#address-cells = <2>;
> > +		#size-cells = <2>;
> > +		ranges;
> >   		hbmc: hyperbus@47034000 {
> >   			compatible = "ti,am654-hbmc";
> 
> 
> I hope all the things you had to do here show you what I mean in my
> comments on [0] :)

yup.

> 
> I've posted a first step patch that allows "reg-mux" node to work with
> regular reg properties[1]. Which means this patch could have been just this:
> 
> --- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> @@ -305,15 +305,16 @@ wkup_i2c0: i2c@42120000 {
>                 status = "disabled";
>         };
> -       fss: syscon@47000000 {
> -               compatible = "syscon", "simple-mfd";
> +       fss: bus@47000000 {
> +               compatible = "simple-bus";
>                 reg = <0x00 0x47000000 0x00 0x100>;
>                 #address-cells = <2>;
>                 #size-cells = <2>;
>                 ranges;
>                 hbmc_mux: hbmc-mux {
> -                       compatible = "mmio-mux";
> +                       compatible = "reg-mux";
> +                       reg = <0x00 0x47000004 0x00 0x2>;
>                         #mux-control-cells = <1>;
>                         mux-reg-masks = <0x4 0x2>; /* HBMC select */
>                 };
> 
> Andrew
> 
> [0] https://lore.kernel.org/all/76da0b98-3274-b047-db11-ecabc117ae11@ti.com/
> [1] https://lore.kernel.org/all/20230424184810.29453-1-afd@ti.com/

yes, this is a better approach. Lets see the conclusion of the
discussion.


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
