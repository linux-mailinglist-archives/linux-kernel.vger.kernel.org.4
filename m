Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8EC62BC00
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbiKPLdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbiKPLcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:32:46 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E422229D;
        Wed, 16 Nov 2022 03:22:30 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AGBMBO4068195;
        Wed, 16 Nov 2022 05:22:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1668597731;
        bh=b5rxEYxHIZSog+pEIX12FfPsa4+nipZLRNYveMgztU8=;
        h=Date:To:CC:References:From:Subject:In-Reply-To;
        b=tVTN3oMa7waWhIRi8V+u6mqXXAyLJbjfsNemQd9MVTwT/K8pzZQlWvINPOWqzn588
         U+M2gBa7UzZ7+jUad9QLw13GYrwEb8M/Sywgqemq92+Kb6HPQ019JOijxm2gZuKk1/
         xb/Lk6I8y4EZdf/k/8kOOMQjyXD8TJxthSCBKoGM=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AGBMBuf052796
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Nov 2022 05:22:11 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 16
 Nov 2022 05:22:10 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Wed, 16 Nov 2022 05:22:10 -0600
Received: from [172.24.222.56] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AGBM4Zp003245;
        Wed, 16 Nov 2022 05:22:05 -0600
Message-ID: <e64f8b3e-c6e6-ddc7-aa79-b641bb1043a4@ti.com>
Date:   Wed, 16 Nov 2022 16:51:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
To:     Wadim Egorov <w.egorov@phytec.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <upstream@phytec.de>, <nm@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
References: <20221108175050.285340-1-w.egorov@phytec.de>
 <20221108175050.285340-2-w.egorov@phytec.de>
Content-Language: en-US
From:   Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: ti: Add support for
 phyBOARD-Electra-AM642
In-Reply-To: <20221108175050.285340-2-w.egorov@phytec.de>
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

Hi, 

Few comments

On 08/11/22 11:20 pm, Wadim Egorov wrote:
> Add basic support for phyCORE-AM64x SoM & phyBOARD-Electra-AM642 CB.
> 
> The phyCORE-AM64x [1] is a SoM (System on Module) featuring TI's AM64x SoC.
> It can be used in combination with different carrier boards.
> This module can come with different sizes and models for
> DDR, eMMC, SPI NOR Flash and various SoCs from the AM64x family.
> 
> A development Kit, called phyBOARD-Electra [2] is used as a carrier board
> reference design around the AM64x SoM.
> 
> Supported features:
>   * Debug UART
>   * Heartbeat LED
>   * GPIO buttons & LEDs
>   * SPI NOR flash
>   * SPI TPM Chip
>   * eMMC
>   * CAN
>   * Ethernet
>   * Micro SD card
>   * I2C EEPROM
>   * I2C RTC
>   * I2C LED Dimmer
>   * USB
> 
> For more details, see:
> 
> [1] Product page SoM: https://www.phytec.com/product/phycore-am64x
> [2] Product page CB: https://www.phytec.com/product/phyboard-am64x
> 
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> ---
> v2:
>   - Update commit message
>   - Add links to product pages for SoM & CB
>   - Drop "fixed" from regulator node names
>   - Use generic node names for pmic, tpm, leds & keys
>   - Update compatible of som.dtsi
>   - Remove not needed node labels for pmic, tpm
>   - Remove not needed R5 core mailbox & reserved memory definitions
>     This is use case specific and should not be defined in the som.dtsi
>   - Provide aliases for used devices by SoM & CB
>   - Fixed led definition: Provide proper default-trigger, function & color
>   - Renamed rtc label to i2c_som_rtc
> ---
>  arch/arm64/boot/dts/ti/Makefile               |   1 +
>  .../boot/dts/ti/k3-am64-phycore-som.dtsi      | 286 ++++++++++++++++
>  .../dts/ti/k3-am642-phyboard-electra-rdk.dts  | 321 ++++++++++++++++++
>  3 files changed, 608 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index 4555a5be2257..79331f16cd4b 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -20,6 +20,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-j7200-common-proc-board.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-j721s2-common-proc-board.dtb
>  
>  dtb-$(CONFIG_ARCH_K3) += k3-am642-evm.dtb
> +dtb-$(CONFIG_ARCH_K3) += k3-am642-phyboard-electra-rdk.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-am642-sk.dtb
>  
>  dtb-$(CONFIG_ARCH_K3) += k3-am625-sk.dtb
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
> new file mode 100644
> index 000000000000..86e6b87b826a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
> @@ -0,0 +1,286 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2021 PHYTEC America, LLC - https://www.phytec.com
> + * Author: Matt McKee <mmckee@phytec.com>
> + *
> + * Copyright (C) 2022 PHYTEC Messtechnik GmbH
> + * Author: Wadim Egorov <w.egorov@phytec.de>
> + *
> + * Product homepage:
> + * https://www.phytec.com/product/phycore-am64x
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/net/ti-dp83867.h>
> +
> +/ {
> +	model = "PHYTEC phyCORE-AM64x";
> +	compatible = "phytec,am64-phycore-som", "ti,am642";
> +
> +	aliases {
> +		ethernet0 = &cpsw_port1;
> +		mmc0 = &sdhci0;
> +		rtc0 = &i2c_som_rtc;
> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		secure_ddr: optee@9e800000 {
> +			reg = <0x00 0x9e800000 0x00 0x01800000>; /* for OP-TEE */
> +			alignment = <0x1000>;
> +			no-map;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		led-0 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&leds_pins_default>;
> +			color = <LED_COLOR_ID_GREEN>;
> +			gpios = <&main_gpio0 12 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +			function = LED_FUNCTION_HEARTBEAT;
> +		};
> +	};
> +
> +	vcc_5v0_som: vcc-5v0-som {

Please use generic node names where specific in DT spec [0]

[0] https://github.com/devicetree-org/devicetree-specification/releases/tag/v0.4-rc1 2.2.2 Generic Names Recommendation

This should be
 regulator-<xyz> {};


> +		/* VIN / VCC_5V0_SOM */
> +		compatible = "regulator-fixed";
> +		regulator-name = "VCC_5V0_SOM";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +};

Few nodes dont really have YAML schemas to validate against:

+arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dtb:0:0: /bus@f4000/i2c@20000000/pmic@61: failed to match any schema with compatible: ['ti,lp8733']
+arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dtb:0:0: /bus@f4000/i2c@20010000/leds@62: failed to match any schema with compatible: ['nxp,pca9533']
+arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dtb:0:0: /bus@f4000/spi@20100000/tpm@1: failed to match any schema with compatible: ['infineon,slb9670']


Rest looks good to me.

[...]
