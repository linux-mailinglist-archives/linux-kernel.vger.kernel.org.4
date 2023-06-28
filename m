Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C22740F80
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 12:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjF1K7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 06:59:42 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36884 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjF1K7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 06:59:35 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35SAxDPP039747;
        Wed, 28 Jun 2023 05:59:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1687949953;
        bh=fAz5LFseo7lEldx3ZYITuvV7Xvig0TD/PEjZ1krIfcE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=DJJNhfBYVJprDaynnB1x5t74zsQJLkdPiJJVoZcclfCWK2C8SvhQ7wyt0zGoRwzuv
         eRDqdItBrkxITOBzsXKYa8FF1ekZoSWh/Cjvb/ZUzh48AhO+K9aIksD4zVuhXkxmQ0
         wYBgKleRaDOgXpAG4EqDsd1UTLZDXFRK51RG7HFE=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35SAxDk1025395
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Jun 2023 05:59:13 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Jun 2023 05:59:12 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Jun 2023 05:59:12 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35SAxB7e121791;
        Wed, 28 Jun 2023 05:59:12 -0500
Date:   Wed, 28 Jun 2023 05:59:11 -0500
From:   Nishanth Menon <nm@ti.com>
To:     "Kumar, Udit" <u-kumar1@ti.com>
CC:     Bhavya Kapoor <b-kapoor@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <kristo@kernel.org>, <vigneshr@ti.com>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-j721s2-main: Enable support for
 SDR104 speed mode
Message-ID: <20230628105911.rdpqwxuhshgaj2ik@kobold>
References: <20230412121415.860447-1-b-kapoor@ti.com>
 <7fe4adef-9be2-6dae-d53f-692f9775439c@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7fe4adef-9be2-6dae-d53f-692f9775439c@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13:50-20230628, Kumar, Udit wrote:
> 
> On 4/12/2023 5:44 PM, Bhavya Kapoor wrote:
> > According to TRM for J721S2, SDR104 speed mode is supported by the SoC
> > but its capabilities were masked in device tree. Remove sdhci-caps-mask
> > to enable support for SDR104 speed mode for SD card in J721S2 SoC.
> > 
> > [+] Refer to : section 12.3.6.1.1 MMCSD Features, in J721S2 TRM
> > - https://www.ti.com/lit/zip/spruj28
> > 
> > Fixes: b8545f9d3a54 ("arm64: dts: ti: Add initial support for J721S2 SoC")
> > Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
> > ---
> > Changelog v1->v2:
> > 	- Modified Commit Message and Added Fixes tag
> > 
> > Link to v1 : https://lore.kernel.org/all/20230404091245.336732-1-b-kapoor@ti.com/
> > 
> >   arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 2 --
> >   1 file changed, 2 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> > index 8915132efcc1..95c6151ed10c 100644
> > --- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> > @@ -400,8 +400,6 @@ main_sdhci1: mmc@4fb0000 {
> >   		ti,clkbuf-sel = <0x7>;
> >   		ti,trm-icp = <0x8>;
> >   		dma-coherent;
> > -		/* Masking support for SDR104 capability */
> > -		sdhci-caps-mask = <0x00000003 0x00000000>;
> 
> 
> Reviewed-by: Udit Kumar <u-kumar1@ti.com>

Please confirm if there are any changes in *tap-delay attributes.
> 
> >   	};
> >   	main_navss: bus@30000000 {

--
Regards,
Nishanth Menon
