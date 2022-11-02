Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378B46165D7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 16:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiKBPR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 11:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiKBPR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 11:17:26 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053B41403A;
        Wed,  2 Nov 2022 08:17:24 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A2FH63C086723;
        Wed, 2 Nov 2022 10:17:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667402226;
        bh=ntPjrpgY0g9DPqQ0Ayv8uIbizDavjhuziEkWkOCA1w8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=hgXI8klv8LBlAmIaVT/XrYoUnv02Wj62cQsqNVHC+0kr/eed031WDa164TiVpLjtr
         2CEwqvjwk63ubE30J93CcNodOzpBhKa/CqQS6nHQExmROf9yX5JIYfmsP3Cr+fhEGq
         ObSBMUAS5YPnuhrR/Avdcq+MwhCN06e1YXRU+qZ0=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A2FH6Xq011650
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Nov 2022 10:17:06 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Wed, 2 Nov
 2022 10:17:06 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Wed, 2 Nov 2022 10:17:06 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A2FH6o4020798;
        Wed, 2 Nov 2022 10:17:06 -0500
Date:   Wed, 2 Nov 2022 10:17:06 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jayesh Choudhary <j-choudhary@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <afd@ti.com>, <j-keerthy@ti.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <s-anna@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] arm64: dts: ti: k3-am65-main: drop RNG clock
Message-ID: <20221102151706.krsi5lujydb4nswa@daybreak>
References: <20221031213237.52275-1-j-choudhary@ti.com>
 <20221031213237.52275-2-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221031213237.52275-2-j-choudhary@ti.com>
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

On 03:02-20221101, Jayesh Choudhary wrote:
> Drop RNG clock property as it is not controlled by rng-driver.

Does'nt tell me what is the alternative? why is the hardware description
not sufficient for control?

https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/am65x_sr2/clocks.html#clocks-for-sa2-ul0-device
Looks like a perfectly valid description - do we have a bug and firmware
does'nt allow control here?

> 
> Fixes: b366b2409c97 ("arm64: dts: ti: k3-am6: Add crypto accelarator node")
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> index 4005a73cfea9..e166d7b7e3a1 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> @@ -126,7 +126,6 @@ rng: rng@4e10000 {
>  			compatible = "inside-secure,safexcel-eip76";
>  			reg = <0x0 0x4e10000 0x0 0x7d>;
>  			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&k3_clks 136 1>;

Does this mean that the crypto module's power-domains property should be
dropped as well?

>  			status = "disabled"; /* Used by OP-TEE */
>  		};
>  	};
> -- 
> 2.25.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
