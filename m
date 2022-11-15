Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A1B6290EC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 04:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbiKODoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 22:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiKODn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 22:43:58 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7806A15A25;
        Mon, 14 Nov 2022 19:43:55 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AF3hOoj046493;
        Mon, 14 Nov 2022 21:43:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1668483805;
        bh=vW4Na6MUWNFRZenOB8ly6uHS+ELtuXqlkGUOA9uhB+Y=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=JzxPMmLHUH0YD90PYMH06sxwLrRqqsyVyYZAYwSr8EcuK6v5EAdJEVmHunpzKH2jc
         CRqKkbZJ/TQKCvvPCH2xZxurVEGw6Ihki6QZGsAikqgBPdhGpNiH7edCpSva3mxnnB
         NJZwhNnbKBaxmBrs28V6GXcGVP7uDx1DI9tNfW+4=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AF3hOl8012785
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Nov 2022 21:43:24 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 14
 Nov 2022 21:43:24 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 14 Nov 2022 21:43:24 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AF3hODx121431;
        Mon, 14 Nov 2022 21:43:24 -0600
Date:   Mon, 14 Nov 2022 21:43:24 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Bhavya Kapoor <b-kapoor@ti.com>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
        <piyali_g@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-j721e-main: Remove ti,strobe-sel
 property
Message-ID: <20221115034324.6qpxl2774bzwbl3t@acorn>
References: <20221107112246.69242-1-b-kapoor@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221107112246.69242-1-b-kapoor@ti.com>
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

On 16:52-20221107, Bhavya Kapoor wrote:
> According to latest errata of J721e [1], HS400 mode is not supported
> in MMCSD0 subsystem (i2024) .  Speed modes supported has been already
> updated in PATCH eb8f6194e807. 'ti,strobe-sel' property is only

eb8f6194e807 isn't a PATCH :) See
Documentation/process/submitting-patches.rst line 99 as an example how
to refer to specific commits.

> required by HS400 speed mode and thus needs to be removed from kernel
> dtsi for J721e soc.

s/soc/SoC

> 
> 'ti,strobe-sel' is read in sdhci_am654.c line 733 and gets stored in
> sdhci_am654->strb_sel. This sdhci_am654->strb_sel is used at only one
> place in sdhci_am654.c line 291 which will only get used if HS400
> is enabled.

Please don't describe driver behavior in device tree patch. DT binding
should indicate the property behavior.

> 
> Thus, drop 'ti,strobe-sel' property from kernel dtsi for J721e soc.
> 
> [.] https://www.ti.com/lit/er/sprz455/sprz455.pdf

Should be [1] ?

I think we could simplify it by saying that the commit that implemented
the patch missed dropping ti,strobe-sel property that is only meant for
HS400. (please rephrase appropriately).

Documentation/devicetree/bindings/mmc/sdhci-am654.yaml

Now, that said - this could be enforced in dt-schema to prevent such a
miss from taking place (if then required)

Might be a case to post a separate patch for the enforcement?

> 
> Fixes: eb8f6194e807 ("arm64: dts: ti: k3-j721e-main: Update the speed modes supported and their itap delay values for MMCSD subsystems")
> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> index 917c9dc99efa..e4748a838d83 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> @@ -1094,7 +1094,6 @@
>  		ti,itap-del-sel-mmc-hs = <0xa>;
>  		ti,itap-del-sel-ddr52 = <0x3>;
>  		ti,trm-icp = <0x8>;
> -		ti,strobe-sel = <0x77>;
>  		dma-coherent;
>  	};
>  
> -- 
> 2.20.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
