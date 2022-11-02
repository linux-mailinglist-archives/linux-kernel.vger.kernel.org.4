Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E14616DF1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 20:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiKBTog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 15:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiKBTod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 15:44:33 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1FE2BF4;
        Wed,  2 Nov 2022 12:44:31 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A2JiKvL125223;
        Wed, 2 Nov 2022 14:44:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667418260;
        bh=73fJ/vUrAbwYd4seHXK+hQNCfqrK2dd66XKeNvDJbXQ=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=puP9EyhnKGWKqLSG4MiIQLfqovo/GwHLupylvfRuqgYQH2dlVBYDqezZL2NIBs01V
         NkTq4SissumgQYKuaj4bPBlxNoPzhMEorRx0hgSbQP82kiQ6VoP4anDc6LVqwwyIp0
         VRJof68/QpNPidD3958+CeSKdd2ITwgRcXbBmlpo=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A2JiK4f051375
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Nov 2022 14:44:20 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Wed, 2 Nov
 2022 14:44:20 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Wed, 2 Nov 2022 14:44:20 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A2JiKDT103584;
        Wed, 2 Nov 2022 14:44:20 -0500
Date:   Wed, 2 Nov 2022 14:44:20 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Andrew Davis <afd@ti.com>
CC:     Jayesh Choudhary <j-choudhary@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>, <j-keerthy@ti.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <s-anna@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] arm64: dts: ti: k3-am65-main: drop RNG clock
Message-ID: <20221102194420.umwuyk374g2mgg45@unlucky>
References: <20221031213237.52275-1-j-choudhary@ti.com>
 <20221031213237.52275-2-j-choudhary@ti.com>
 <20221102151706.krsi5lujydb4nswa@daybreak>
 <4f954c08-6a2e-93b5-6806-7b27b247496e@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4f954c08-6a2e-93b5-6806-7b27b247496e@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12:04-20221102, Andrew Davis wrote:
> On 11/2/22 10:17 AM, Nishanth Menon wrote:
> > On 03:02-20221101, Jayesh Choudhary wrote:
> > > Drop RNG clock property as it is not controlled by rng-driver.
> > 
> > Does'nt tell me what is the alternative? why is the hardware description
> > not sufficient for control?
> > 
> > https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/am65x_sr2/clocks.html#clocks-for-sa2-ul0-device
> > Looks like a perfectly valid description - do we have a bug and firmware
> > does'nt allow control here?
> > 
> 
> We have three input clocks feeding the SA2UL module, x1, x2, pka. PKA goes
> to the PKA sub-module (isn't it nice when they make things simple). But x1 and
> x2 are miscellaneous and bus clocks respectively and route to several sub-modules.
> 
> All we drop here is the clock handle in the RNG sub-module, as that sub-module is
> not the owner of that clock (the parent SA2UL is). The alternative we could implement
> is to move the clock node up to the parent SA2UL node.
> 
> > > 
> > > Fixes: b366b2409c97 ("arm64: dts: ti: k3-am6: Add crypto accelarator node")
> > > Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> > > ---
> > >   arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 1 -
> > >   1 file changed, 1 deletion(-)
> > > 
> > > diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> > > index 4005a73cfea9..e166d7b7e3a1 100644
> > > --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> > > +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> > > @@ -126,7 +126,6 @@ rng: rng@4e10000 {
> > >   			compatible = "inside-secure,safexcel-eip76";
> > >   			reg = <0x0 0x4e10000 0x0 0x7d>;
> > >   			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
> > > -			clocks = <&k3_clks 136 1>;
> > 
> > Does this mean that the crypto module's power-domains property should be
> > dropped as well?
> > 
> 
> Why? the power-domains property is in the correct spot (up in the parent node).
> 
> Now it is true we cant actually shut the SA2UL down since it is owned
> by the security processor, but since it is marked TI_SCI_PD_SHARED this
> should be fine.

The idea of the descriptions were to describe what is controllable by
firmware, if there is no control due to the specified reason, it is a
device tree bug, and should be documented when dropping it. If it serves
a purpose in the firmware by indicating usage for example - it has valid
reason to stick around as it is expected to be used by firmware for some
specific reason.

The commit description does bring up the above mentioned questions and
must be explained appropriately.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
