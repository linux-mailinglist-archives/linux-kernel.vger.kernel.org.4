Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5D967CADE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 13:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbjAZMYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 07:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237132AbjAZMYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 07:24:31 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351F96C126;
        Thu, 26 Jan 2023 04:24:27 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30QCOBeS017371;
        Thu, 26 Jan 2023 06:24:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1674735851;
        bh=QB7T2WGtblYv3To1QwC2Q7W8Lv9dimhXgoRSvaGPmuM=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=oJVKCh4jehWClfx29P+XhLgyEI58ZlHl/J2Ly5GBJ2OZ9Oa1Jze5S9bmFhdF7lDe6
         zDHe9P/Xodz1RqFNJfCuKdfUKH7rObbHFfXDiH0LN8FYF+ZGdbMMruipQeqMsg70Im
         yTCXiWG+KotVv0/cy+tllgOXzsPBVHRp/LKz91sA=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30QCOB85007736
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 26 Jan 2023 06:24:11 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 26
 Jan 2023 06:24:11 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 26 Jan 2023 06:24:11 -0600
Received: from [10.250.234.92] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30QCO6hT029510;
        Thu, 26 Jan 2023 06:24:07 -0600
Message-ID: <e5d7c2c4-6b99-2343-7f37-6d45e141fc0b@ti.com>
Date:   Thu, 26 Jan 2023 17:54:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v8 1/8] arm64: dts: ti: k3-j721s2-main: Add support for
 USB
Content-Language: en-US
To:     Ravi Gunasekaran <r-gunasekaran@ti.com>, <nm@ti.com>, <afd@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <s-vadapalli@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230123095733.31657-1-r-gunasekaran@ti.com>
 <20230123095733.31657-2-r-gunasekaran@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20230123095733.31657-2-r-gunasekaran@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/01/23 3:27 pm, Ravi Gunasekaran wrote:
> From: Aswath Govindraju <a-govindraju@ti.com>
> 
> Add support for single instance of USB 3.0 controller in J721S2 SoC.
> 
> Reviewed-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> Signed-off-by: Matt Ranostay <mranostay@ti.com>
> Link: https://lore.kernel.org/r/20221122101616.770050-2-mranostay@ti.com
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 42 ++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> index 8915132efcc1..c0daa75116f9 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> @@ -26,6 +26,20 @@
>  		};
>  	};
>  
> +	scm_conf: syscon@104000 {
> +		compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
> +		reg = <0x00 0x00104000 0x00 0x18000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x00 0x00 0x00104000 0x18000>;
> +
> +		usb_serdes_mux: mux-controller@0 {

This is regression back to comments on v1. Cannot you @0 w/o reg
You also missed comments on v7:

https://lore.kernel.org/all/52f276fb-93b3-da8f-c428-05ded94d90cb@ti.com/

> +			compatible = "mmio-mux";
> +			#mux-control-cells = <1>;
> +			mux-reg-masks = <0x0 0x8000000>; /* USB0 to SERDES0 lane 1/3 mux */
> +		};
> +	};
> +
>  	gic500: interrupt-controller@1800000 {
>  		compatible = "arm,gic-v3";
>  		#address-cells = <2>;
> @@ -745,6 +759,34 @@
>  		};
>  	};
>  
> +	usbss0: cdns-usb@4104000 {
> +		compatible = "ti,j721e-usb";
> +		reg = <0x00 0x04104000 0x00 0x100>;
> +		clocks = <&k3_clks 360 16>, <&k3_clks 360 15>;
> +		clock-names = "ref", "lpm";
> +		assigned-clocks = <&k3_clks 360 16>; /* USB2_REFCLK */
> +		assigned-clock-parents = <&k3_clks 360 17>;
> +		power-domains = <&k3_pds 360 TI_SCI_PD_EXCLUSIVE>;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +		dma-coherent;
> +
> +		usb0: usb@6000000 {
> +			compatible = "cdns,usb3";
> +			reg = <0x00 0x06000000 0x00 0x10000>,
> +			      <0x00 0x06010000 0x00 0x10000>,
> +			      <0x00 0x06020000 0x00 0x10000>;
> +			reg-names = "otg", "xhci", "dev";
> +			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "host", "peripheral", "otg";
> +			maximum-speed = "super-speed";
> +			dr_mode = "otg";
> +		};
> +	};
> +
>  	main_mcan0: can@2701000 {
>  		compatible = "bosch,m_can";
>  		reg = <0x00 0x02701000 0x00 0x200>,
