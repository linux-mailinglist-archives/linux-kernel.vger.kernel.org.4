Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B506C7FAB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 15:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjCXOP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 10:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbjCXOPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 10:15:53 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C971D92F;
        Fri, 24 Mar 2023 07:15:50 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32OEFbWa065914;
        Fri, 24 Mar 2023 09:15:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679667337;
        bh=dCKIhAqLpMTl8zi6x7hjpcoMTKFgJPyxY8OQsA2CGbs=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=T099vWJ2SvMTzI4q6hY2ZilkC53uwaghdiiYc8EVtrKrURCpCkRNy+pzomnnPZhvd
         1+cfIZ9KoM6YlXLVd/YQ8I7g3ubJn8iIRmWUsFWPymTn6d9ZVDXB4Y2GPPgsXQh1eX
         BZ86P1WMc5SqbhatDBaHetAPogx23Eff/54QrxTo=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32OEFbWK018284
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Mar 2023 09:15:37 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 24
 Mar 2023 09:15:36 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 24 Mar 2023 09:15:36 -0500
Received: from [172.24.145.176] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32OEFXmn054169;
        Fri, 24 Mar 2023 09:15:34 -0500
Message-ID: <9d22e2a9-ed36-8687-cc99-e0798bac4d68@ti.com>
Date:   Fri, 24 Mar 2023 19:45:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] arm64: dts: ti: k3-am654: Add overlay for audio support
To:     <nm@ti.com>, <vigneshr@ti.com>
CC:     <afd@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <j-luthra@ti.com>
References: <20230324122417.252491-1-j-choudhary@ti.com>
Content-Language: en-US
From:   Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <20230324122417.252491-1-j-choudhary@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/03/23 17:54, Jayesh Choudhary wrote:
> From: Peter Ujfalusi <peter.ujfalusi@ti.com>
> 
> The GP application board has:
> ICSSG I2C0..3 connected to I2C EEPROMs
> ICSSG UART0..3 headers with level shifters
> ICSSG SPI0..3 connected to SPI Flash
> McASP0 connected to tlv320aic3106 codec with Headset out and Line In jack
> 
> This patch adds support for the audio on the GP application board.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> [j-choudhary@ti.com: Makefile fixups, dtso file cleanups]
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---

Please drop the patch as this board is no longer in production/supported
actively.

I am extremely sorry for the noise.

Warm Regards,
-Jayesh


> 
> Changes are made considering Andrew's comment on another overlay patch[1]
> related to Makefile and styling comments on the overlay file.
> 
> [1]:
> <https://lore.kernel.org/all/8e6442c8-e4ef-705d-1378-7d1f8b74e84d@ti.com/>
> 
>   arch/arm64/boot/dts/ti/Makefile         |   3 +-
>   arch/arm64/boot/dts/ti/k3-am654-gp.dtso | 124 ++++++++++++++++++++++++
>   2 files changed, 126 insertions(+), 1 deletion(-)
>   create mode 100644 arch/arm64/boot/dts/ti/k3-am654-gp.dtso
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index 541970a8ed0a..9b70a85fbc96 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -21,12 +21,13 @@ dtb-$(CONFIG_ARCH_K3) += k3-am642-phyboard-electra-rdk.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am642-sk.dtb
>   
>   # Boards with AM65x SoC
> +k3-am654-evm-dtbs := k3-am654-base-board.dtb k3-am654-gp.dtbo
>   dtb-$(CONFIG_ARCH_K3) += k3-am6528-iot2050-basic.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am6528-iot2050-basic-pg2.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced-m2.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced-pg2.dtb
> -dtb-$(CONFIG_ARCH_K3) += k3-am654-base-board.dtb
> +dtb-$(CONFIG_ARCH_K3) += k3-am654-evm.dtb
>   
>   # Boards with J7200 SoC
>   k3-j7200-evm-dtbs := k3-j7200-common-proc-board.dtb k3-j7200-evm-quad-port-eth-exp.dtbo
> diff --git a/arch/arm64/boot/dts/ti/k3-am654-gp.dtso b/arch/arm64/boot/dts/ti/k3-am654-gp.dtso
> new file mode 100644
> index 000000000000..14ceb2714677
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am654-gp.dtso
> @@ -0,0 +1,124 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * DT overlay for GP application board on AM654 EVM
> + *
> + * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +
> +#include "k3-pinctrl.h"
> +
> +&{/} {
> +	gp_vcc_5v0: fixedregulator-gp-vcc-5v0 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "gp_vcc_5v0";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	codec_vcc_3v3: fixedregulator-codec-vcc-3v3 {
> +		/* LP5912-3.3DRVT */
> +		compatible = "regulator-fixed";
> +		regulator-name = "codec_vcc_3v3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&gp_vcc_5v0>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	gp_vcc_1v8: fixedregulator-gp-vcc-1v8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "gp_vcc_1v8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	sound {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,name = "AM65x-GPEVM";
> +		simple-audio-card,widgets =
> +			"Headphone", "Headphone Jack",
> +			"Line", "Line In";
> +		simple-audio-card,routing =
> +			"Headphone Jack",	"HPLOUT",
> +			"Headphone Jack",	"HPROUT",
> +			"LINE1L",		"Line In",
> +			"LINE1R",		"Line In";
> +		simple-audio-card,format = "dsp_b";
> +		simple-audio-card,bitclock-master = <&sound_master>;
> +		simple-audio-card,frame-master = <&sound_master>;
> +		simple-audio-card,bitclock-inversion;
> +
> +		simple-audio-card,cpu {
> +			sound-dai = <&mcasp0>;
> +		};
> +
> +		sound_master: simple-audio-card,codec {
> +			sound-dai = <&tlv320aic3106>;
> +			system-clock-frequency = <12000000>;
> +		};
> +	};
> +};
> +
> +&main_pmx0 {
> +	mcasp0_pins: mcasp0-pins {
> +		pinctrl-single,pins = <
> +			AM65X_IOPAD(0x01f4, PIN_INPUT, 5) /* (V24) PRG0_PRU0_GPO0.MCASP0_ACLKX */
> +			AM65X_IOPAD(0x01f8, PIN_INPUT, 5) /* (W25) PRG0_PRU0_GPO1.MCASP0_AFSX */
> +			AM65X_IOPAD(0x0204, PIN_OUTPUT, 5) /* (Y24) PRG0_PRU0_GPO4.MCASP0_AXR0 */
> +			AM65X_IOPAD(0x0208, PIN_INPUT, 5) /* (V28) PRG0_PRU0_GPO5.MCASP0_AXR1 */
> +		>;
> +	};
> +
> +	aic3106_pins: aic3106-pins {
> +		pinctrl-single,pins = <
> +			AM65X_IOPAD(0x011c, PIN_OUTPUT, 7) /* (AD19) PRG1_PRU0_GPO15.GPIO0_71 */
> +		>;
> +	};
> +};
> +
> +&main_i2c0 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	tlv320aic3106: tlv320aic3106@1b {
> +		#sound-dai-cells = <0>;
> +		compatible = "ti,tlv320aic3106";
> +		reg = <0x1b>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&aic3106_pins>;
> +		gpio-reset = <&main_gpio0 71 GPIO_ACTIVE_LOW>; /* gpio0_71 */
> +		/* Regulators */
> +		AVDD-supply = <&codec_vcc_3v3>;
> +		IOVDD-supply = <&gp_vcc_1v8>;
> +		DRVDD-supply = <&codec_vcc_3v3>;
> +		DVDD-supply = <&gp_vcc_1v8>;
> +	};
> +};
> +
> +&mcasp0 {
> +	status = "okay";
> +	#sound-dai-cells = <0>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mcasp0_pins>;
> +	op-mode = <0>;          /* MCASP_IIS_MODE */
> +	tdm-slots = <2>;
> +	/* 16 serializers */
> +	serial-dir = <  /* 0: INACTIVE, 1: TX, 2: RX */
> +		1 2 0 0
> +		0 0 0 0
> +		0 0 0 0
> +		0 0 0 0
> +	>;
> +	tx-num-evt = <32>;
> +	rx-num-evt = <32>;
> +};
