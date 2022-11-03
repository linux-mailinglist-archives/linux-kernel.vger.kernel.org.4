Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84219618ADA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 22:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbiKCVxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 17:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiKCVxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 17:53:08 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8ECD64CE;
        Thu,  3 Nov 2022 14:53:07 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A3Lr1QL057487;
        Thu, 3 Nov 2022 16:53:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667512381;
        bh=095CCfkd4aT/HzwXJyHyWqHHeUC0ZhvKHQ8qi1QPuco=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Ho1aSFAqDETv2W6tvKdUJ6pXncuFi8GDPS52bTi7L5tJpjviZvNHYxXpEB288+EjH
         NmpO6bkc9Yfz4i4FdaR5V/qBCylnjp1gBuw3QEY2plrUuN0VZS7LzlA1+RsL3ZG+N5
         FcD4cPeUXGRc3psScRgXyP8boYnmd0sYTno4jsMA=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A3Lr1bZ126536
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Nov 2022 16:53:01 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 3 Nov
 2022 16:53:01 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 3 Nov 2022 16:53:01 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A3Lr1nX031270;
        Thu, 3 Nov 2022 16:53:01 -0500
Date:   Thu, 3 Nov 2022 16:53:01 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Rahul T R <r-ravikumar@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jkridner@gmail.com>
Subject: Re: [PATCH v7 1/2] arm64: dts: ti: k3-j721e-main: Add dts nodes for
 EHRPWMs
Message-ID: <20221103215301.xlq3zj775jv4zezb@stability>
References: <20221103174743.16827-1-r-ravikumar@ti.com>
 <20221103174743.16827-2-r-ravikumar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221103174743.16827-2-r-ravikumar@ti.com>
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

On 23:17-20221103, Rahul T R wrote:
> From: Vijay Pothukuchi <vijayp@ti.com>
> 
> Add dts nodes for 6 EHRPWM instances on SoC

OK - I  am able to understand why you'd want this to be disabled because
I have the background, however, the intent of a commit message is to
provide information to folks who is not me.

To give you a guidance, please see how Andrew has done
in https://lore.kernel.org/linux-arm-kernel/20221028142417.10642-10-afd@ti.com/

You are permitted to disable, but you need to provide explanation why
you are choosing to do that by default.

> 
> Signed-off-by: Vijay Pothukuchi <vijayp@ti.com>
> Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 68 ++++++++++++++++++++++-
>  1 file changed, 67 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> index 5c4a0e28cde5..bc3146e24816 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> @@ -66,7 +66,73 @@ usb_serdes_mux: mux-controller@4000 {
>  			#mux-control-cells = <1>;
>  			mux-reg-masks = <0x4000 0x8000000>, /* USB0 to SERDES0/3 mux */
>  					<0x4010 0x8000000>; /* USB1 to SERDES1/2 mux */
> -	    };
> +		};
> +
> +		ehrpwm_tbclk: clock-controller@4140 {
> +			compatible = "ti,am654-ehrpwm-tbclk", "syscon";
> +			reg = <0x4140 0x18>;
> +			#clock-cells = <1>;
> +		};
> +	};
> +
> +	main_ehrpwm0: pwm@3000000 {
> +		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
> +		#pwm-cells = <3>;
> +		reg = <0x00 0x3000000 0x00 0x100>;
> +		power-domains = <&k3_pds 83 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&ehrpwm_tbclk 0>, <&k3_clks 83 0>;
> +		clock-names = "tbclk", "fck";
> +		status = "disabled";
> +	};
> +
> +	main_ehrpwm1: pwm@3010000 {
> +		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
> +		#pwm-cells = <3>;
> +		reg = <0x00 0x3010000 0x00 0x100>;
> +		power-domains = <&k3_pds 84 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&ehrpwm_tbclk 1>, <&k3_clks 84 0>;
> +		clock-names = "tbclk", "fck";
> +		status = "disabled";
> +	};
> +
> +	main_ehrpwm2: pwm@3020000 {
> +		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
> +		#pwm-cells = <3>;
> +		reg = <0x00 0x3020000 0x00 0x100>;
> +		power-domains = <&k3_pds 85 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&ehrpwm_tbclk 2>, <&k3_clks 85 0>;
> +		clock-names = "tbclk", "fck";
> +		status = "disabled";
> +	};
> +
> +	main_ehrpwm3: pwm@3030000 {
> +		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
> +		#pwm-cells = <3>;
> +		reg = <0x00 0x3030000 0x00 0x100>;
> +		power-domains = <&k3_pds 86 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&ehrpwm_tbclk 3>, <&k3_clks 86 0>;
> +		clock-names = "tbclk", "fck";
> +		status = "disabled";
> +	};
> +
> +	main_ehrpwm4: pwm@3040000 {
> +		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
> +		#pwm-cells = <3>;
> +		reg = <0x00 0x3040000 0x00 0x100>;
> +		power-domains = <&k3_pds 87 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&ehrpwm_tbclk 4>, <&k3_clks 87 0>;
> +		clock-names = "tbclk", "fck";
> +		status = "disabled";
> +	};
> +
> +	main_ehrpwm5: pwm@3050000 {
> +		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
> +		#pwm-cells = <3>;
> +		reg = <0x00 0x3050000 0x00 0x100>;
> +		power-domains = <&k3_pds 88 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&ehrpwm_tbclk 5>, <&k3_clks 88 0>;
> +		clock-names = "tbclk", "fck";
> +		status = "disabled";
>  	};
>  
>  	gic500: interrupt-controller@1800000 {
> -- 
> 2.38.0
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
