Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0177231C3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 22:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbjFEUw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 16:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjFEUw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 16:52:28 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D5EEC;
        Mon,  5 Jun 2023 13:52:27 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 355KqLw2043261;
        Mon, 5 Jun 2023 15:52:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685998341;
        bh=xvUdToRD5jkYlPqIt+azErDZtY7+9g9n4ao9a1t0h0k=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=QpGXmsrjmBsbpER195FDtRznscKLnYpxDjdaD+rLY0lCs+YoGKBcGaKiq1WdCW7PT
         XdemNn+qcTX+SbYtVEnVeRtpAm60NKk2tteuar5f1VWsIIwn4E6uNc+WdcX82iZYjA
         U1CZyGcUXNJ+Lu+8E/1G/osWKAo8d9hcvxpUizHE=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 355KqLVW013118
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 5 Jun 2023 15:52:21 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Jun 2023 15:52:20 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Jun 2023 15:52:21 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 355KqKhI036588;
        Mon, 5 Jun 2023 15:52:20 -0500
Date:   Mon, 5 Jun 2023 15:52:20 -0500
From:   Nishanth Menon <nm@ti.com>
To:     "Raghavendra, Vignesh" <vigneshr@ti.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-j721e-mcu-wakeup: Switch to
 "ti,j721e-system-controller" compatible
Message-ID: <20230605205220.rjmcsi5tjn4auqa7@arose>
References: <20230424154841.353631-1-nm@ti.com>
 <20230424154841.353631-2-nm@ti.com>
 <4b4f4eef-398b-843b-37f8-fdf97c1b6b8d@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4b4f4eef-398b-843b-37f8-fdf97c1b6b8d@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20:43-20230605, Vignesh Raghavendra wrote:
> Hi
> 
> On 4/24/2023 9:18 PM, Nishanth Menon wrote:
> > Switch to "ti,j721e-system-controller" compatible to be more specific.
> > 
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > ---
> >  arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> > index 24e8125db8c4..71b8b04a7789 100644
> > --- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> > @@ -35,7 +35,7 @@ k3_reset: reset-controller {
> >  	};
> >  
> >  	mcu_conf: syscon@40f00000 {
> > -		compatible = "syscon", "simple-mfd";
> > +		compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
> >  		reg = <0x0 0x40f00000 0x0 0x20000>;
> >  		#address-cells = <1>;
> >  		#size-cells = <1>;
> 
> As Andrew suggested at [0], lets work on getting rid of unneeded
> "syscon" here and move to simple-bus instead 
> 
> [0] https://lore.kernel.org/all/76da0b98-3274-b047-db11-ecabc117ae11@ti.com/

OK. Let me relook at the following series as well:
https://lore.kernel.org/all/20230424144949.244135-1-nm@ti.com/
  -> AM65x dtbs_check warning fixups??

https://lore.kernel.org/all/20230424154841.353631-1-nm@ti.com/
  -> J721e dtbs_check warning fixups??

https://lore.kernel.org/linux-arm-kernel/20230424173623.477577-1-nm@ti.com/
  -> J7200 dtbs_check warning fixups??

I will try and respond/ respin the relevant patchsets.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
