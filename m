Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C414C718D8F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 23:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjEaVv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 17:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjEaVvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 17:51:53 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E917107;
        Wed, 31 May 2023 14:51:51 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34VLpjPB103086;
        Wed, 31 May 2023 16:51:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685569905;
        bh=h3g0B28wPPCyczRYs/JjUclI0PqNyrP1/X6niyx0I94=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=jAEFqxYT/uolSI1Ty90SoIUHFFRSgDYqznPYFjr0uKWhUIE+56pRIDUQt93+EYQ+R
         d0suNbh9OqAOFuYmsyB46Pc+6EZ+uAYZmxawhboFDIkZc8r3P05hQmwkwiO+oXaoDA
         Yrx3wnfFunlBhbKsqYIsnqeICqxDik1YL7qIQ3ns=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34VLpjkU113595
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 31 May 2023 16:51:45 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 May 2023 16:51:45 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 May 2023 16:51:45 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34VLpjBm109874;
        Wed, 31 May 2023 16:51:45 -0500
Date:   Wed, 31 May 2023 16:51:45 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Udit Kumar <u-kumar1@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <m-chawdhry@ti.com>, <n-francis@ti.com>
Subject: Re: [PATCH 1/5] arm64: dts: ti: k3-j7200: Add general purpose timers
Message-ID: <20230531215145.a6xiurql6jtvbr3y@filling>
References: <20230426103219.1565266-1-u-kumar1@ti.com>
 <20230426103219.1565266-2-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230426103219.1565266-2-u-kumar1@ti.com>
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

On 16:02-20230426, Udit Kumar wrote:
[..]

> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> index ef352e32f19d..555bde0e7fda 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
[...]

> +	main_timer13: timer@24d0000 {
> +		compatible = "ti,am654-timer";
> +		reg = <0x00 0x24d0000 0x00 0x400>;
> +		interrupts = <GIC_SPI 237 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&k3_clks 63 1>;
> +		clock-names = "fck";
> +		assigned-clocks = <&k3_clks 63 1>;
> +		assigned-clock-parents = <&k3_clks 63 2>;
> +		power-domains = <&k3_pds 63 TI_SCI_PD_EXCLUSIVE>;

^^ I think you need to use device ID 64 here instead of 63 for the node

Also for odd numbered timers, we need to set the TIMERx_CLKSEL_VD
explicitly for J7200, unfortunately the IDs are different from J721e,
preventing re-use :(

Example:
https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j7200/clocks.html#clocks-for-timer1-device
https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j7200/clocks.html#clocks-for-timer1-clksel-vd-device

> +		ti,timer-pwm;
> +	};
[...]

> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> index 331b4e482e41..1c09e442b379 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> @@ -34,6 +34,126 @@ k3_reset: reset-controller {
>  		};
>  	};
[...]

> +	mcu_timer6: timer@40460000 {
> +		compatible = "ti,am654-timer";
> +		reg = <0x00 0x40460000 0x00 0x400>;
> +		interrupts = <GIC_SPI 822 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&k3_clks 76 1>;
> +		clock-names = "fck";
> +		assigned-clocks = <&k3_clks 76 1>;
> +		assigned-clock-parents = <&k3_clks 76 2>;
> +		power-domains = <&k3_pds 35 TI_SCI_PD_EXCLUSIVE>;
I think this needs to be 76 instead of 35

> +		ti,timer-pwm;
> +	};
> +

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
