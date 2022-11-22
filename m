Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8436F633540
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 07:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbiKVG05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 01:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKVG0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 01:26:54 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE562DA90;
        Mon, 21 Nov 2022 22:26:52 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AM6Qg7f067538;
        Tue, 22 Nov 2022 00:26:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1669098402;
        bh=iLSR+lNftbG5WCxJ5fgNr1tJatDoqnEjEPjFnCbRN8A=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=LUcPfF3+4ebkLqm+kPeJl0f2rrBM5MKe0vlQoHzE8gzy1yBWr0PFwRvpx8ijgK+zC
         GwUmB0MgBV7556J9hkUbf9NqMXK7Y0cUqUjwfQMS7aGKuFVtj/CcZVMSHP/QWvM63c
         V/8dbQOGoJi0O9sw1Qx/ROvFd152WlLuhkQ+dEDs=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AM6Qgk6012936
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Nov 2022 00:26:42 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 22
 Nov 2022 00:26:42 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 22 Nov 2022 00:26:42 -0600
Received: from [10.24.69.79] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AM6QdQk020414;
        Tue, 22 Nov 2022 00:26:39 -0600
Message-ID: <9e1ab6e2-6b58-7b0f-fd74-2a6d785f2551@ti.com>
Date:   Tue, 22 Nov 2022 11:56:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v6 2/8] arm64: dts: ti: k3-j721s2-main: Add SERDES and WIZ
 device tree node
To:     Matt Ranostay <mranostay@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <s-vadapalli@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221119040906.9495-1-mranostay@ti.com>
 <20221119040906.9495-3-mranostay@ti.com>
Content-Language: en-US
From:   Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <20221119040906.9495-3-mranostay@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/11/22 9:39 am, Matt Ranostay wrote:
> Add dt node for the single instance of WIZ (SERDES wrapper) and
> SERDES module shared by PCIe, eDP and USB.
> 
> Signed-off-by: Matt Ranostay <mranostay@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 54 ++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> index b4869bff4f22..adbb172658b9 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> @@ -5,6 +5,17 @@
>   * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
>   */
>  
> +#include <dt-bindings/phy/phy-cadence.h>
> +#include <dt-bindings/phy/phy-ti.h>
> +
> +/ {
> +	serdes_refclk: clock-cmnrefclk {
> +		#clock-cells = <0>;
> +		compatible = "fixed-clock";
> +		clock-frequency = <0>;
> +	};
> +};
> +
>  &cbass_main {
>  	msmc_ram: sram@70000000 {
>  		compatible = "mmio-sram";
> @@ -38,6 +49,13 @@ usb_serdes_mux: mux-controller-0 {
>  			#mux-control-cells = <1>;
>  			mux-reg-masks = <0x0 0x8000000>; /* USB0 to SERDES0 lane 1/3 mux */
>  		};
> +
> +		serdes_ln_ctrl: mux-controller-80 {
> +			compatible = "mmio-mux";
> +			#mux-control-cells = <1>;
> +			mux-reg-masks = <0x80 0x3>, <0x84 0x3>, /* SERDES0 lane0/1 select */
> +					<0x88 0x3>, <0x8c 0x3>; /* SERDES0 lane2/3 select */
> +		};
>  	};
>  
>  	gic500: interrupt-controller@1800000 {
> @@ -787,6 +805,42 @@ usb0: usb@6000000 {
>  		};
>  	};
>  
> +	serdes_wiz0: wiz@5060000 {
> +		compatible = "ti,am64-wiz-10g";

Using compatible "ti,am64-wiz-10g" may cause issues as the wiz_data->type plays a role in serdes configuration
Please relook into this

> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		power-domains = <&k3_pds 365 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 365 0>, <&k3_clks 365 3>, <&serdes_refclk>;
> +		clock-names = "fck", "core_ref_clk", "ext_ref_clk";
> +		num-lanes = <4>;
> +		#reset-cells = <1>;
> +		#clock-cells = <1>;
> +		ranges = <0x5060000 0x0 0x5060000 0x10000>;
> +
> +		assigned-clocks = <&k3_clks 365 3>;
> +		assigned-clock-parents = <&k3_clks 365 7>;
> +
> +		serdes0: serdes@5060000 {
> +			compatible = "ti,j721e-serdes-10g";
> +			reg = <0x05060000 0x00010000>;
> +			reg-names = "torrent_phy";
> +			resets = <&serdes_wiz0 0>;
> +			reset-names = "torrent_reset";
> +			clocks = <&serdes_wiz0 TI_WIZ_PLL0_REFCLK>,
> +				 <&serdes_wiz0 TI_WIZ_PHY_EN_REFCLK>;
> +			clock-names = "refclk", "phy_en_refclk";
> +			assigned-clocks = <&serdes_wiz0 TI_WIZ_PLL0_REFCLK>,
> +					  <&serdes_wiz0 TI_WIZ_PLL1_REFCLK>,
> +					  <&serdes_wiz0 TI_WIZ_REFCLK_DIG>;
> +			assigned-clock-parents = <&k3_clks 365 3>,
> +						 <&k3_clks 365 3>,
> +						 <&k3_clks 365 3>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			#clock-cells = <1>;
> +		};
> +	};
> +
>  	main_mcan0: can@2701000 {
>  		compatible = "bosch,m_can";
>  		reg = <0x00 0x02701000 0x00 0x200>,

-- 
Regards,
Ravi
