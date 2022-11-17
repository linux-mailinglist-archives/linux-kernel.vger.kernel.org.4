Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A7662D409
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 08:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239314AbiKQH0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 02:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234615AbiKQH0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 02:26:45 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D36A4299C;
        Wed, 16 Nov 2022 23:26:45 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AH7QasS051985;
        Thu, 17 Nov 2022 01:26:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1668669996;
        bh=eqQ/3cCLrSuzVZEUFTNhVlp1S92E4HYsYV7v9SonXn8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=fNQufl1//OH+DxPdwyri9aYKsr69ShdyqndU96TP7c0OaMGwnxMlv4bZQ0S0OPi0t
         8aXSH/QA5hKeEyMkAcRqjT49mJqbtZ1m9kfUw7aTbdWUuL4+x6+/Mc5jXP41WuCeWU
         klbgiMjKj0uaoxnWaea8duEHuRYQ7RedBEZOuq8E=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AH7QZGd017005
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Nov 2022 01:26:36 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 17
 Nov 2022 01:26:35 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 17 Nov 2022 01:26:35 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AH7QZ9u012868;
        Thu, 17 Nov 2022 01:26:35 -0600
Date:   Thu, 17 Nov 2022 01:26:35 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Bhavya Kapoor <b-kapoor@ti.com>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
        <piyali_g@ti.com>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-j721e-main: Remove ti,strobe-sel
 property
Message-ID: <20221117072635.k4fmjqcnw3kcjrc4@precinct>
References: <20221116091652.112620-1-b-kapoor@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221116091652.112620-1-b-kapoor@ti.com>
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

On 14:46-20221116, Bhavya Kapoor wrote:
> According to latest errata of J721e [1], HS400 mode is not supported
> in MMCSD0 subsystem (i2024) .  Speed modes supported has been already
			     ^^ space before "."

btw, "The MMCSD peripherals do not support the Multimedia Card HS400
mode." is the exact text of the erratum. Even though it applies to
instance 0. I think minor rewording will probably help people from
running to search for which specific instances.

> updated in commit eb8f6194e807 ("arm64: dts: ti: k3-j721e-main: Update the speed modes supported and their itap delay values for MMCSD subsystems")

Please format this correctly.

> but it missed dropping 'ti,strobe-sel' property which is
> only required by HS400 speed mode.
> 
> Thus, drop 'ti,strobe-sel' property from kernel dtsi for J721e SoC.
> 
> [1] https://www.ti.com/lit/er/sprz455/sprz455.pdf
> 
> Fixes: eb8f6194e807 ("arm64: dts: ti: k3-j721e-main: Update the speed modes supported and their itap delay values for MMCSD subsystems")
> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
> ---
> 
> Changelog v1 -> v2 :
> 	- Updated Commit Message based on what Nishanth Menon has told
> 		in https://lore.kernel.org/all/20221115034324.6qpxl2774bzwbl3t@acorn/
> 
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
