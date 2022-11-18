Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F18062FBE8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 18:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242211AbiKRRpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 12:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241614AbiKRRpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 12:45:33 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17B15ADCF;
        Fri, 18 Nov 2022 09:45:32 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AIHjLEj058881;
        Fri, 18 Nov 2022 11:45:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1668793521;
        bh=88+PC9lB91Ag0JXcJVETgQmM7PmFG0ydrmjYnoVPQs0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=N+z/naPnwws28kV3zmrvykGCAKdUItSi0okoSm3aFWrE1fHUb2Ug+BN2/f8VA+pZb
         E5ZpG4cRBBNp05SEasWj6+FsV9IchuzLDp636/vWdIO/zyNdfN6SrRrNtX54kaylnW
         HnIxm4XbRJaN05GOqWS7y5+nZfAPLbhbm4JK5cqQ=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AIHjL04119472
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Nov 2022 11:45:21 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 18
 Nov 2022 11:45:21 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 18 Nov 2022 11:45:21 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AIHjLfl089416;
        Fri, 18 Nov 2022 11:45:21 -0600
Date:   Fri, 18 Nov 2022 11:45:21 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Andrew Davis <afd@ti.com>
CC:     Apurva Nandan <a-nandan@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, Hari Nagalla <hnagalla@ti.com>
Subject: Re: [PATCH v3 3/4] arm64: dts: ti: Add initial support for J784S4 SoC
Message-ID: <20221118174521.t2up5coqylvdgm3b@outhouse>
References: <20221116130428.161329-1-a-nandan@ti.com>
 <20221116130428.161329-4-a-nandan@ti.com>
 <cd3b69a6-1162-ef0a-1927-e4f65d42e62f@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cd3b69a6-1162-ef0a-1927-e4f65d42e62f@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11:32-20221118, Andrew Davis wrote:
> On 11/16/22 7:04 AM, Apurva Nandan wrote:
[...]

> > diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> > new file mode 100644
> > index 000000000000..828f339ddbdc
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> > @@ -0,0 +1,1008 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Device Tree Source for J784S4 SoC Family Main Domain peripherals
> > + *
> > + * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
> > + */
> > +
> > +&cbass_main {
> > +	msmc_ram: sram@70000000 {
> > +		compatible = "mmio-sram";
> > +		reg = <0x0 0x70000000 0x0 0x800000>;
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		ranges = <0x0 0x0 0x70000000 0x800000>;
> > +
> > +		atf-sram@0 {
> > +			reg = <0x0 0x20000>;
> > +		};
> > +
> > +		tifs-sram@1f0000 {
> > +			reg = <0x1f0000 0x10000>;
> > +		};
> > +
> > +		l3cache-sram@200000 {
> > +			reg = <0x200000 0x200000>;
> > +		};
> 
> The amount of SRAM is boot time configurable (and may even change at runtime
> if we work out a couple minor gotchas). Does it make more sense to have
> this node fixed up in the bootloader based on the chosen amount of SRAM vs
> L3-Cache?
> 
> Either way, do we need the l3cache-sram node here? I'm thinking the size
> of the SRAM node itself should be modified. Since the L3 grows from the
> end, all that is needed is to reduce the "reg =" size. At the same time
> the l3-cache0 node below should gain in "cache-size" property.
> 
> (We don't need to do this for this series, the other J7x DTs have the
> same issue, so maybe I'll go fix them all together sometime later)


We do need to describe the sram used as l3cache node in dts and it is indeed
fixedup by bootloader just like DDR sizes are fixed up if a different
configuration is used. The sram fixup is done by using the nodename to
change the size and location. This value should be the usual
configuration such that a system can bootup if bootloader does'nt have
fixup capability (Say TF-A booting straight to linux kernel).

[...]

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
