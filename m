Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482A36BB65C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 15:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbjCOOnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 10:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjCOOnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:43:17 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8AF4C6E5;
        Wed, 15 Mar 2023 07:43:14 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32FEh0SW067924;
        Wed, 15 Mar 2023 09:43:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678891380;
        bh=QGyjpIjn3DpE0rG+THwFRSE4f2SV9+fJPSp01OLV4NQ=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=eE0IKYY48JQqiBVLFVYC8B1wIX9D1WuEXZ4CaI06dA7k6g4g8lFxYl8Ms0dDZgUWy
         DaLZgzIKSopmrOOKfdTtb9Sztd0QAuxM6c6Jb7gjYLLAMDKZkANOuXuBKkksSjLXJ8
         6sXbeKovMMwhJeyzGLo5d5YwNbqsTB0jsKJfSowk=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32FEh08m028294
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Mar 2023 09:43:00 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 15
 Mar 2023 09:43:00 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 15 Mar 2023 09:43:00 -0500
Received: from [10.249.34.133] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32FEgxdd014168;
        Wed, 15 Mar 2023 09:42:59 -0500
Message-ID: <51621d96-bba1-4919-0402-b9300492bc50@ti.com>
Date:   Wed, 15 Mar 2023 09:42:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] arm64: dts: ti: k3-j784s4-evm: Enable MCU CPSW2G
To:     Siddharth Vadapalli <s-vadapalli@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
References: <20230315042548.1500528-1-s-vadapalli@ti.com>
Content-Language: en-US
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20230315042548.1500528-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/23 11:25 PM, Siddharth Vadapalli wrote:
> Add device tree support to enable MCU CPSW with J784S4 EVM.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> Hello,
> 
> Please do not merge this patch until the following have been merged:
> 1. https://lore.kernel.org/r/20230314085500.10597-1-j-choudhary@ti.com/
> 2. https://lore.kernel.org/r/20230314152611.140969-2-j-choudhary@ti.com/
> 3. https://lore.kernel.org/r/20230308201513.116638-1-j-choudhary@ti.com/
> 
> Changes from v1:
> 1. Drop patch for adding device id property for mcu_navss. This patch is
>     now a part of another series at:
>     https://lore.kernel.org/r/20230314152611.140969-2-j-choudhary@ti.com/
> 2. Move "mcu_mdio_pins_default" pinctrl to the "davinci_mdio" node.
> 

LGTM,

Reviewed-by: Andrew Davis <afd@ti.com>

> v1:
> https://lore.kernel.org/r/20230314104055.1475054-1-s-vadapalli@ti.com/
> 
>   arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 50 ++++++++++++++++++++++++
>   1 file changed, 50 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> index 8cd4a7ecc121..476ad8915c5b 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> @@ -140,6 +140,32 @@ J784S4_IOPAD(0x020, PIN_INPUT, 7) /* (AJ35) MCAN15_RX.GPIO0_8 */
>   	};
>   };
>   
> +&wkup_pmx0 {
> +	mcu_cpsw_pins_default: mcu-cpsw-pins-default {
> +		pinctrl-single,pins = <
> +			J784S4_WKUP_IOPAD(0x094, PIN_INPUT, 0) /* (A35) MCU_RGMII1_RD0 */
> +			J784S4_WKUP_IOPAD(0x090, PIN_INPUT, 0) /* (B36) MCU_RGMII1_RD1 */
> +			J784S4_WKUP_IOPAD(0x08c, PIN_INPUT, 0) /* (C36) MCU_RGMII1_RD2 */
> +			J784S4_WKUP_IOPAD(0x088, PIN_INPUT, 0) /* (D36) MCU_RGMII1_RD3 */
> +			J784S4_WKUP_IOPAD(0x084, PIN_INPUT, 0) /* (B37) MCU_RGMII1_RXC */
> +			J784S4_WKUP_IOPAD(0x06c, PIN_INPUT, 0) /* (C37) MCU_RGMII1_RX_CTL */
> +			J784S4_WKUP_IOPAD(0x07c, PIN_OUTPUT, 0) /* (D37) MCU_RGMII1_TD0 */
> +			J784S4_WKUP_IOPAD(0x078, PIN_OUTPUT, 0) /* (D38) MCU_RGMII1_TD1 */
> +			J784S4_WKUP_IOPAD(0x074, PIN_OUTPUT, 0) /* (E37) MCU_RGMII1_TD2 */
> +			J784S4_WKUP_IOPAD(0x070, PIN_OUTPUT, 0) /* (E38) MCU_RGMII1_TD3 */
> +			J784S4_WKUP_IOPAD(0x080, PIN_OUTPUT, 0) /* (E36) MCU_RGMII1_TXC */
> +			J784S4_WKUP_IOPAD(0x068, PIN_OUTPUT, 0) /* (C38) MCU_RGMII1_TX_CTL */
> +		>;
> +	};
> +
> +	mcu_mdio_pins_default: mcu-mdio-pins-default {
> +		pinctrl-single,pins = <
> +			J784S4_WKUP_IOPAD(0x09c, PIN_OUTPUT, 0) /* (A36) MCU_MDIO0_MDC */
> +			J784S4_WKUP_IOPAD(0x098, PIN_INPUT, 0) /* (B35) MCU_MDIO0_MDIO */
> +		>;
> +	};
> +};
> +
>   &main_uart8 {
>   	status = "okay";
>   	pinctrl-names = "default";
> @@ -194,3 +220,27 @@ &main_sdhci1 {
>   &main_gpio0 {
>   	status = "okay";
>   };
> +
> +&mcu_cpsw {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mcu_cpsw_pins_default>;
> +};
> +
> +&davinci_mdio {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mcu_mdio_pins_default>;
> +
> +	mcu_phy0: ethernet-phy@0 {
> +		reg = <0>;
> +		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
> +		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
> +		ti,min-output-impedance;
> +	};
> +};
> +
> +&mcu_cpsw_port1 {
> +	status = "okay";
> +	phy-mode = "rgmii-rxid";
> +	phy-handle = <&mcu_phy0>;
> +};
