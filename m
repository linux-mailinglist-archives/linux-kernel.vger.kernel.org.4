Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688826E7716
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 12:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbjDSKED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 06:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbjDSKEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 06:04:00 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5256E13C2E;
        Wed, 19 Apr 2023 03:03:15 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33JA30Kk051814;
        Wed, 19 Apr 2023 05:03:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681898580;
        bh=ld5yWZeJcnL8s+6R2ykjKtMuPw4txZydvn2W458dt9Q=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=ooPUNa34odDt+qZVDZP6XTBIQs2jvK5CS2QM9/0q6uLgyWbqGWhylW03QX4PB+wOB
         dkJmnjAw396bfQc6amdXaEdFyAterWxNWo/TJw3KuDipkHOz+Ma+U2YrzH8m3fQw6a
         kdfKjsWHSND9KW26ZuqgtnUNSeSbW/UmZcCcx/0M=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33JA30F2007057
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Apr 2023 05:03:00 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 19
 Apr 2023 05:02:59 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 19 Apr 2023 05:02:59 -0500
Received: from [172.24.145.7] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33JA2uJb125465;
        Wed, 19 Apr 2023 05:02:56 -0500
Message-ID: <5246274d-8972-17a2-bf9d-eb1cfdd108a7@ti.com>
Date:   Wed, 19 Apr 2023 15:32:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 2/5] arm64: dts: ti: k3-j784s4: Add Main CPSW2G node
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, <nm@ti.com>,
        <vigneshr@ti.com>, <afd@ti.com>
CC:     <s-vadapalli@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <a-bhatia1@ti.com>
References: <20230419061710.290068-1-j-choudhary@ti.com>
 <20230419061710.290068-3-j-choudhary@ti.com>
 <e83733cf-b396-1ec7-4247-49d0f94e8517@linaro.org>
From:   Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <e83733cf-b396-1ec7-4247-49d0f94e8517@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/04/23 13:20, Krzysztof Kozlowski wrote:
> On 19/04/2023 08:17, Jayesh Choudhary wrote:
>> From: Siddharth Vadapalli <s-vadapalli@ti.com>
>>
>> J784S4 SoC has a Main CPSW2G instance of the CPSW Ethernet Switch.
>>
>> Add the device-tree nodes for the Main CPSW2G instance and enable it.
>>
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-j784s4-evm.dts   | 48 +++++++++++++++
>>   arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 68 ++++++++++++++++++++++
>>   2 files changed, 116 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
>> index f33815953e77..aef6f53ae8ac 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
>> @@ -105,6 +105,30 @@ vdd_sd_dv: regulator-TLV71033 {
>>   };
>>   
>>   &main_pmx0 {
>> +	main_cpsw2g_pins_default: main-cpsw2g-pins-default {
>> +		pinctrl-single,pins = <
>> +			J784S4_IOPAD(0x0b8, PIN_INPUT, 6) /* (AC34) MCASP1_ACLKX.RGMII1_RD0 */
>> +			J784S4_IOPAD(0x0a0, PIN_INPUT, 6) /* (AD34) MCASP0_AXR12.RGMII1_RD1 */
>> +			J784S4_IOPAD(0x0a4, PIN_INPUT, 6) /* (AJ36) MCASP0_AXR13.RGMII1_RD2 */
>> +			J784S4_IOPAD(0x0a8, PIN_INPUT, 6) /* (AF34) MCASP0_AXR14.RGMII1_RD3 */
>> +			J784S4_IOPAD(0x0b0, PIN_INPUT, 6) /* (AL33) MCASP1_AXR3.RGMII1_RXC */
>> +			J784S4_IOPAD(0x0ac, PIN_INPUT, 6) /* (AE34) MCASP0_AXR15.RGMII1_RX_CTL */
>> +			J784S4_IOPAD(0x08c, PIN_INPUT, 6) /* (AE35) MCASP0_AXR7.RGMII1_TD0 */
>> +			J784S4_IOPAD(0x090, PIN_INPUT, 6) /* (AC35) MCASP0_AXR8.RGMII1_TD1 */
>> +			J784S4_IOPAD(0x094, PIN_INPUT, 6) /* (AG35) MCASP0_AXR9.RGMII1_TD2 */
>> +			J784S4_IOPAD(0x098, PIN_INPUT, 6) /* (AH36) MCASP0_AXR10.RGMII1_TD3 */
>> +			J784S4_IOPAD(0x0b4, PIN_INPUT, 6) /* (AL34) MCASP1_AXR4.RGMII1_TXC */
>> +			J784S4_IOPAD(0x09c, PIN_INPUT, 6) /* (AF35) MCASP0_AXR11.RGMII1_TX_CTL */
>> +		>;
>> +	};
>> +
>> +	main_cpsw2g_mdio_pins_default: main-cpsw2g-mdio-pins-default {
>> +		pinctrl-single,pins = <
>> +			J784S4_IOPAD(0x0c0, PIN_INPUT, 6) /* (AD38) MCASP1_AXR0.MDIO0_MDC */
>> +			J784S4_IOPAD(0x0bc, PIN_INPUT, 6) /* (AD33) MCASP1_AFSX.MDIO0_MDIO */
>> +		>;
>> +	};
>> +
>>   	main_uart8_pins_default: main-uart8-pins-default {
>>   		pinctrl-single,pins = <
>>   			J784S4_IOPAD(0x040, PIN_INPUT, 14) /* (AF37) MCASP0_AXR0.UART8_CTSn */
>> @@ -253,3 +277,27 @@ &mcu_cpsw_port1 {
>>   	phy-mode = "rgmii-rxid";
>>   	phy-handle = <&mcu_phy0>;
>>   };
>> +
>> +&main_cpsw1 {
>> +	status = "okay";
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&main_cpsw2g_pins_default>;
>> +};
>> +
>> +&main_cpsw1_mdio {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&main_cpsw2g_mdio_pins_default>;
>> +
>> +	main_phy0: ethernet-phy@0 {
>> +		reg = <0>;
>> +		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
>> +		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
>> +		ti,min-output-impedance;
>> +	};
>> +};
>> +
>> +&main_cpsw1_port1 {
>> +	status = "okay";
>> +	phy-mode = "rgmii-rxid";
>> +	phy-handle = <&main_phy0>;
>> +};
>> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
>> index 5fb7edf4f5a0..8bd8aebebe1c 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
>> @@ -36,6 +36,12 @@ scm_conf: syscon@100000 {
>>   		#size-cells = <1>;
>>   		ranges = <0x00 0x00 0x00100000 0x1c000>;
>>   
>> +		cpsw1_phy_gmii_sel: phy@4034 {
>> +			compatible = "ti,am654-phy-gmii-sel";
>> +			reg = <0x4034 0x4>;
>> +			#phy-cells = <1>;
>> +		};
>> +
>>   		serdes_ln_ctrl: mux-controller-4080 {
>>   			compatible = "mmio-mux";
>>   			#mux-control-cells = <1>;
>> @@ -777,6 +783,68 @@ cpts@310d0000 {
>>   		};
>>   	};
>>   
>> +	main_cpsw1: ethernet@c200000 {
>> +		compatible = "ti,j721e-cpsw-nuss";
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
> 
> Fix order of your properties. reg/reg-names/ranges follow comaptible.

Noted. Will fix.

> 
>> +		reg = <0x00 0xc200000 0x00 0x200000>;
>> +		reg-names = "cpsw_nuss";
>> +		ranges = <0x00 0x00 0x00 0xc200000 0x00 0x200000>;
>> +		dma-coherent;
>> +		clocks = <&k3_clks 62 0>;
>> +		clock-names = "fck";
>> +		power-domains = <&k3_pds 62 TI_SCI_PD_EXCLUSIVE>;
>> +
>> +		dmas = <&main_udmap 0xc640>,
>> +		       <&main_udmap 0xc641>,
>> +		       <&main_udmap 0xc642>,
>> +		       <&main_udmap 0xc643>,
>> +		       <&main_udmap 0xc644>,
>> +		       <&main_udmap 0xc645>,
>> +		       <&main_udmap 0xc646>,
>> +		       <&main_udmap 0xc647>,
>> +		       <&main_udmap 0x4640>;
>> +		dma-names = "tx0", "tx1", "tx2", "tx3",
>> +			    "tx4", "tx5", "tx6", "tx7",
>> +			    "rx";
>> +
>> +		status = "disabled";
>> +
>> +		ethernet-ports {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +
>> +			main_cpsw1_port1: port@1 {
>> +				reg = <1>;
>> +				label = "port1";
>> +				phys = <&cpsw1_phy_gmii_sel 1>;
>> +				ti,mac-only;
>> +				status = "disabled";
>> +			};
>> +		};
>> +
>> +		main_cpsw1_mdio: mdio@f00 {
>> +			compatible = "ti,cpsw-mdio", "ti,davinci_mdio";
>> +			reg = <0x00 0xf00 0x00 0x100>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			clocks = <&k3_clks 62 0>;
>> +			clock-names = "fck";
>> +			bus_freq = <1000000>;
>> +		};
>> +
>> +		cpts@3d000 {
> 
> Are you sure dtbs_check does not print any warnings?
> 

One more warning for clock order in serdes_wiz nodes. Will be fixed
after I swap 'ext_ref_clk' and 'core_ref1_clk' in clock and names.

> 
> Best regards,
> Krzysztof
> 
