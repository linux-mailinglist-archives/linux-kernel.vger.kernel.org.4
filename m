Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C356BA190
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 22:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjCNVms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 17:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjCNVmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 17:42:43 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEF8311FF;
        Tue, 14 Mar 2023 14:42:30 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32ELgJH6112015;
        Tue, 14 Mar 2023 16:42:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678830139;
        bh=HcM2rHSgMV5dbevP9hx0ekJRpVoBcgwOnF22UtrxNrA=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=qe/aPpscHKrETSLzqRgv4vfX61aOlomzxipfw2P56iqe6TcEV/GlGJysYaTBIR/zG
         0XMWimQk9mNIRsd8eAfde081c8YT2eiBlJBdUmJkDQJ4sMAO5X30RtseV5IeamIjU3
         lc8u3Bw3MPESOHjF2ld0oz9fWNzmUweP5iK7FUfQ=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32ELgJIg020787
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Mar 2023 16:42:19 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 14
 Mar 2023 16:42:18 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 14 Mar 2023 16:42:18 -0500
Received: from [10.250.33.160] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32ELgInJ016579;
        Tue, 14 Mar 2023 16:42:18 -0500
Message-ID: <8e6442c8-e4ef-705d-1378-7d1f8b74e84d@ti.com>
Date:   Tue, 14 Mar 2023 16:42:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 2/2] arm64: dts: ti: k3-j721e: Add overlay to enable
 CPSW9G ports in QSGMII mode
Content-Language: en-US
To:     Siddharth Vadapalli <s-vadapalli@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
References: <20230310103504.731845-1-s-vadapalli@ti.com>
 <20230310103504.731845-3-s-vadapalli@ti.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20230310103504.731845-3-s-vadapalli@ti.com>
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

On 3/10/23 4:35 AM, Siddharth Vadapalli wrote:
> The J7 Quad Port Add-On Ethernet Card for J721E Common-Proc-Board supports
> QSGMII mode. Use the overlay to configure CPSW9G ports in QSGMII mode.
> 
> Add support to reset the PHY from kernel by using gpio-hog and gpio-reset.
> 
> Add aliases for CPSW9G ports to enable kernel to fetch MAC addresses
> directly from U-Boot.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>   arch/arm64/boot/dts/ti/Makefile               |   4 +
>   .../dts/ti/k3-j721e-quad-port-eth-exp.dtso    | 148 ++++++++++++++++++
>   2 files changed, 152 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-quad-port-eth-exp.dtso
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index 6acd12409d59..167bcd9b09b7 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -45,3 +45,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm.dtb
>   
>   # Enable support for device-tree overlays
>   DTC_FLAGS_k3-am6548-iot2050-advanced-m2 += -@
> +DTC_FLAGS_k3-j721e-common-proc-board += -@
> +
> +# Device-tree overlays
> +dtb-$(CONFIG_ARCH_K3) += k3-j721e-quad-port-eth-exp.dtbo

I'd recommend this; since the EVM as sold comes with the quad port
expansion, let's call that the J721e "EVM". That will allow us to
keep it separate from the Beagle and SK boards. Since this overlay
applies only to the EVM it should named like this:

k3-j721e-evm-quad-port-eth-exp.dtbo

and then when it is applied to the common-proc-board then the result
is called:

k3-j721e-evm.dtb

This way you can take the EVM and run it with that DTB or take the
base board DTB and apply different overlays (there are the GESI and
the Infotainment overlays next). So the full change to this Makefile
in this patch should be this:



--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -31,8 +31,9 @@ dtb-$(CONFIG_ARCH_K3) += k3-am654-base-board.dtb
  dtb-$(CONFIG_ARCH_K3) += k3-j7200-common-proc-board.dtb
  
  # Boards with J721e SoC
+k3-j721e-evm-dtbs := k3-j721e-common-proc-board.dtb k3-j721e-evm-quad-port-eth-exp.dtbo
  dtb-$(CONFIG_ARCH_K3) += k3-j721e-beagleboneai64.dtb
-dtb-$(CONFIG_ARCH_K3) += k3-j721e-common-proc-board.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-j721e-evm.dtb
  dtb-$(CONFIG_ARCH_K3) += k3-j721e-sk.dtb



Notice we do not need to do that " += -@" stuff either, since
an overlay is applied to make the k3-j721e-evm.dtb, the base DT,

k3-j721e-common-proc-board.dtb

is given symbols automatically.

Yet another benefit is this causes the build to test applying the
overlay and warn us of any missing symbols.

> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-quad-port-eth-exp.dtso b/arch/arm64/boot/dts/ti/k3-j721e-quad-port-eth-exp.dtso
> new file mode 100644
> index 000000000000..d7977d16c921
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-quad-port-eth-exp.dtso
> @@ -0,0 +1,148 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/**
> + * DT Overlay for CPSW9G in QSGMII mode using J7 Quad Port ETH EXP Add-On Ethernet Card with
> + * J721E board.
> + *
> + * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/mux/ti-serdes.h>
> +#include <dt-bindings/pinctrl/k3.h>
> +#include <dt-bindings/phy/phy.h>
> +#include <dt-bindings/phy/phy-cadence.h>
> +
> +/ {
> +	fragment@102 {
> +		target-path = "/";

This is the old style for fragments, just use

&{/} {
	aliases {


> +		__overlay__ {
> +			aliases {
> +				ethernet1 = "/bus@100000/ethernet@c000000/ethernet-ports/port@1";
> +				ethernet2 = "/bus@100000/ethernet@c000000/ethernet-ports/port@2";
> +				ethernet3 = "/bus@100000/ethernet@c000000/ethernet-ports/port@3";
> +				ethernet4 = "/bus@100000/ethernet@c000000/ethernet-ports/port@4";
> +			};
> +		};
> +	};
> +};
> +
> +&cpsw0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mdio0_pins_default>;

The MDIO pinmux belongs in the mdio node. Then since it doesn't need
any extra info here, leave this node enabled in the base dtbs.

> +};
> +
> +&cpsw0_port1 {
> +	phy-handle = <&cpsw9g_phy0>;
> +	phy-mode = "qsgmii";
> +	mac-address = [00 00 00 00 00 00];
> +	phys = <&cpsw0_phy_gmii_sel 1>;
> +};
> +
> +&cpsw0_port2 {
> +	phy-handle = <&cpsw9g_phy1>;
> +	phy-mode = "qsgmii";
> +	mac-address = [00 00 00 00 00 00];
> +	phys = <&cpsw0_phy_gmii_sel 2>;
> +};
> +
> +&cpsw0_port3 {
> +	phy-handle = <&cpsw9g_phy2>;
> +	phy-mode = "qsgmii";
> +	mac-address = [00 00 00 00 00 00];
> +	phys = <&cpsw0_phy_gmii_sel 3>;
> +};
> +
> +&cpsw0_port4 {
> +	phy-handle = <&cpsw9g_phy3>;
> +	phy-mode = "qsgmii";
> +	mac-address = [00 00 00 00 00 00];
> +	phys = <&cpsw0_phy_gmii_sel 4>;
> +};
> +
> +&cpsw0_port5 {
> +	status = "disabled";

Since these need phy handles to function, disable them in the base
dtb and only enable the ones connected in this overlay.

Andrew

> +};
> +
> +&cpsw0_port6 {
> +	status = "disabled";
> +};
> +
> +&cpsw0_port7 {
> +	status = "disabled";
> +};
> +
> +&cpsw0_port8 {
> +	status = "disabled";
> +};
> +
> +&cpsw9g_mdio {
> +	reset-gpios = <&exp2 17 GPIO_ACTIVE_LOW>;
> +	reset-post-delay-us = <120000>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	cpsw9g_phy0: ethernet-phy@17 {
> +		reg = <17>;
> +	};
> +	cpsw9g_phy1: ethernet-phy@16 {
> +		reg = <16>;
> +	};
> +	cpsw9g_phy2: ethernet-phy@18 {
> +		reg = <18>;
> +	};
> +	cpsw9g_phy3: ethernet-phy@19 {
> +		reg = <19>;
> +	};
> +};
> +
> +&exp2 {
> +	qsgmii-line-hog {
> +		gpio-hog;
> +		gpios = <16 GPIO_ACTIVE_HIGH>;
> +		output-low;
> +		line-name = "qsgmii-pwrdn-line";
> +	};
> +};
> +
> +&main_pmx0 {
> +	mdio0_pins_default: mdio0-pins-default {
> +		pinctrl-single,pins = <
> +			J721E_IOPAD(0x1bc, PIN_OUTPUT, 0) /* (V24) MDIO0_MDC */
> +			J721E_IOPAD(0x1b8, PIN_INPUT, 0) /* (V26) MDIO0_MDIO */
> +		>;
> +	};
> +};
> +
> +&serdes_ln_ctrl {
> +	idle-states = <J721E_SERDES0_LANE0_PCIE0_LANE0>, <J721E_SERDES0_LANE1_QSGMII_LANE2>,
> +		      <J721E_SERDES1_LANE0_PCIE1_LANE0>, <J721E_SERDES1_LANE1_PCIE1_LANE1>,
> +		      <J721E_SERDES2_LANE0_PCIE2_LANE0>, <J721E_SERDES2_LANE1_PCIE2_LANE1>,
> +		      <J721E_SERDES3_LANE0_USB3_0_SWAP>, <J721E_SERDES3_LANE1_USB3_0>,
> +		      <J721E_SERDES4_LANE0_EDP_LANE0>, <J721E_SERDES4_LANE1_EDP_LANE1>,
> +		      <J721E_SERDES4_LANE2_EDP_LANE2>, <J721E_SERDES4_LANE3_EDP_LANE3>;
> +};
> +
> +&serdes_wiz0 {
> +	status = "okay";
> +};
> +
> +&serdes0 {
> +	status = "okay";
> +
> +	assigned-clocks = <&serdes0 CDNS_SIERRA_PLL_CMNLC>, <&serdes0 CDNS_SIERRA_PLL_CMNLC1>;
> +	assigned-clock-parents = <&wiz0_pll1_refclk>, <&wiz0_pll1_refclk>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	serdes0_qsgmii_link: phy@1 {
> +		reg = <1>;
> +		cdns,num-lanes = <1>;
> +		#phy-cells = <0>;
> +		cdns,phy-type = <PHY_TYPE_QSGMII>;
> +		resets = <&serdes_wiz0 2>;
> +	};
> +};
