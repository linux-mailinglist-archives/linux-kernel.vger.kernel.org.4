Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17C8632A10
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 17:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiKUQxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 11:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiKUQxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 11:53:31 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DD64D5E0;
        Mon, 21 Nov 2022 08:53:28 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2ALGr4jP010154;
        Mon, 21 Nov 2022 10:53:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1669049584;
        bh=WjWo23JtttWhqV+cd1f60yZAJ4C0gsxz38omvfZwPrQ=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=NWQg2ps1s9LyQzHhvVttTa+mCy2uvC0en3we0LtAbHhnUh+5GULksyScxm8ASO7gQ
         NlZ5YmAaWcETzluhVZdLUUAQzbh6winvgJVYM8cLEZ8MjQt5bqFTzXO7HnGDjC2NiM
         OA7BEqXP3GxQymZsL1LZTzjDx8VT+hxBGZouQ9qQ=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2ALGr4tr077290
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Nov 2022 10:53:04 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 21
 Nov 2022 10:53:04 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 21 Nov 2022 10:53:04 -0600
Received: from [10.250.38.44] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2ALGr3lU017978;
        Mon, 21 Nov 2022 10:53:03 -0600
Message-ID: <e9de2a7b-4e04-9d6c-1e49-96469a23f705@ti.com>
Date:   Mon, 21 Nov 2022 10:53:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v6 3/8] arm64: dts: ti: k3-j721s2-mcu-wakeup: Add support
 of OSPI
Content-Language: en-US
To:     Matt Ranostay <mranostay@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <s-vadapalli@ti.com>,
        <r-gunasekaran@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221119040906.9495-1-mranostay@ti.com>
 <20221119040906.9495-4-mranostay@ti.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20221119040906.9495-4-mranostay@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
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

On 11/18/22 10:09 PM, Matt Ranostay wrote:
> From: Aswath Govindraju <a-govindraju@ti.com>
> 
> Add support for two instance of OSPI in J721S2 SoC.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> Signed-off-by: Matt Ranostay <mranostay@ti.com>
> ---
>   .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     | 40 +++++++++++++++++++
>   1 file changed, 40 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
> index 0af242aa9816..46b3aab93c4b 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
> @@ -306,4 +306,44 @@ cpts@3d000 {
>   			ti,cpts-periodic-outputs = <2>;
>   		};
>   	};
> +
> +	fss: syscon@47000000 {
> +		compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";

This node is not the "ti,j721e-system-controller", and those don't have
SPI nodes in the binding, so this will have failed the dtbs_check anyway..

Should be just a "simple-bus".

Andrew

> +		reg = <0x00 0x47000000 0x00 0x100>;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		ospi0: spi@47040000 {
> +			compatible = "ti,am654-ospi", "cdns,qspi-nor";
> +			reg = <0x00 0x47040000 0x00 0x100>,
> +			      <0x5 0x0000000 0x1 0x0000000>;
> +			interrupts = <GIC_SPI 840 IRQ_TYPE_LEVEL_HIGH>;
> +			cdns,fifo-depth = <256>;
> +			cdns,fifo-width = <4>;
> +			cdns,trigger-address = <0x0>;
> +			clocks = <&k3_clks 109 5>;
> +			assigned-clocks = <&k3_clks 109 5>;
> +			assigned-clock-parents = <&k3_clks 109 7>;
> +			assigned-clock-rates = <166666666>;
> +			power-domains = <&k3_pds 109 TI_SCI_PD_EXCLUSIVE>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		ospi1: spi@47050000 {
> +			compatible = "ti,am654-ospi", "cdns,qspi-nor";
> +			reg = <0x00 0x47050000 0x00 0x100>,
> +			      <0x7 0x0000000 0x1 0x0000000>;
> +			interrupts = <GIC_SPI 841 IRQ_TYPE_LEVEL_HIGH>;
> +			cdns,fifo-depth = <256>;
> +			cdns,fifo-width = <4>;
> +			cdns,trigger-address = <0x0>;
> +			clocks = <&k3_clks 110 5>;
> +			power-domains = <&k3_pds 110 TI_SCI_PD_EXCLUSIVE>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +	};
>   };
