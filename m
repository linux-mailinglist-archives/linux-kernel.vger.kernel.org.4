Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B980616895
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbiKBQXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbiKBQWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:22:55 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA382CDEA;
        Wed,  2 Nov 2022 09:16:39 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A2GGTPY095685;
        Wed, 2 Nov 2022 11:16:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667405789;
        bh=mQHcOL/FnvThcsl6P1gsURDzKXjljhwdEz7tr2YY/7E=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Vuy6dBhd9/Krwi+MiA05YMuqGrJJJ0Ace2PNtm/kPJSWJqOcDBqm3NN2suhTAFRtv
         KXrIvu7etlo+e7TTWAHiTdA4gPQfaQnNxmW2MSvrYWf9ZpiFRog+BIQJ99ugQjV/0n
         srhw1qpk+XlwIYGWfbrBoMvvmyUSNkt5aUOh9Uyc=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A2GGTZA054997
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Nov 2022 11:16:29 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Wed, 2 Nov
 2022 11:16:28 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Wed, 2 Nov 2022 11:16:28 -0500
Received: from [10.249.33.217] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A2GGSXR060092;
        Wed, 2 Nov 2022 11:16:28 -0500
Message-ID: <ce9291a0-e138-f0ec-9604-83abd93e72c3@ti.com>
Date:   Wed, 2 Nov 2022 11:16:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4 2/2] arm64: dts: ti: add k3-j721e-beagleboneai64
Content-Language: en-US
To:     Robert Nelson <robertcnelson@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Drew Fustini <drew@beagleboard.org>
References: <20221031200114.987024-1-robertcnelson@gmail.com>
 <20221031200114.987024-2-robertcnelson@gmail.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20221031200114.987024-2-robertcnelson@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/22 3:01 PM, Robert Nelson wrote:
> BeagleBoard.org BeagleBone AI-64 is an open source hardware single
> board computer based on the Texas Instruments TDA4VM SoC featuring
> dual-core 2.0GHz Arm Cortex-A72 processor, C7x+MMA and 2 C66x
> floating-point VLIW DSPs, 3x dual Arm Cortex-R5 co-processors,
> 2x 6-core Programmable Real-Time Unit and Industrial Communication
> SubSystem, PowerVR Rogue 8XE GE8430 3D GPU. The board features 4GB
> DDR4, USB3.0 Type-C, 2x USB SS Type-A, miniDisplayPort, 2x 4-lane
> CSI, DSI, 16GB eMMC flash, 1G Ethernet, M.2 E-key for WiFi/BT, and
> BeagleBone expansion headers.
> 
> This board family can be indentified by the BBONEAI-64-B0 in the
> at24 eeprom:
> 
> [aa 55 33 ee 01 37 00 10  2e 00 42 42 4f 4e 45 41 |.U3..7....BBONEA|]
> [49 2d 36 34 2d 42 30 2d  00 00 42 30 30 30 37 38 |I-64-B0-..B00078|]
> 
> https://beagleboard.org/ai-64
> https://git.beagleboard.org/beagleboard/beaglebone-ai-64
> 
> Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
> CC: Nishanth Menon <nm@ti.com>
> CC: Vignesh Raghavendra <vigneshr@ti.com>
> CC: Tero Kristo <kristo@kernel.org>
> CC: Jason Kridner <jkridner@beagleboard.org>
> CC: Drew Fustini <drew@beagleboard.org>
> ---
> Changes since v3:
>   - rebased on next after enable/disable device-tree level changes
>   - Enable UART nodes at the board level
>   - Enable I2C nodes at the board level
>   - Enable Mailbox nodes at the board level
>   - Enable MCASP nodes at the board level
> Changes since v2:
>   - drop bootargs
>   - use generic node names for regulators
>   - corrected main-i2c*pins node-names
> Changes since v1:
>   - added product url to license section
>   - added aliases for serial, mmc and i2c
>   - use switch-X syntax for switches
>   - switch-1 removed disabled status
>   - use led-X syntax for leds
>   - led-x dropped labels, using functions
>   - dp_pwr_3v3 removed extra comment, always on regulator setting
>   - added i2c interfaces that map with BeagleBone Family
>   - corrected mcu-adc*-pins-default node-names
>   - main_uart0 corrected comment on TIFS firmware.
>   - main_gpio0 - removed un-needed okay
>   - main_gpio1 - removed un-needed okay
>   - mhdp added missing phy
>   - main_r5fss0_core0 - corrected missing space
>   - added tscadc0/tscadc1 pins brought out on board
>   - marked disabled nodes as unused in this design
> ---
>   arch/arm64/boot/dts/ti/Makefile               |    1 +
>   .../boot/dts/ti/k3-j721e-beagleboneai64.dts   | 1113 +++++++++++++++++
>   2 files changed, 1114 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index 4555a5be2257..cf7c509538a4 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -12,6 +12,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am6528-iot2050-basic-pg2.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced-pg2.dtb
>   
> +dtb-$(CONFIG_ARCH_K3) += k3-j721e-beagleboneai64.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-j721e-common-proc-board.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-j721e-sk.dtb
>   
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
> new file mode 100644
> index 000000000000..5c3ab97837d9
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
> @@ -0,0 +1,1113 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * https://beagleboard.org/ai-64
> + * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
> + * Copyright (C) 2022 Jason Kridner, BeagleBoard.org Foundation
> + * Copyright (C) 2022 Robert Nelson, BeagleBoard.org Foundation
> + */
> +
> +/dts-v1/;
> +
> +#include "k3-j721e.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/net/ti-dp83867.h>
> +#include <dt-bindings/phy/phy-cadence.h>
> +
> +/ {
> +	compatible = "beagle,j721e-beagleboneai64", "ti,j721e";
> +	model = "BeagleBoard.org BeagleBone AI-64";
> +
> +	aliases {
> +		serial2 = &main_uart0;
> +		mmc0 = &main_sdhci0;
> +		mmc1 = &main_sdhci1;
> +		i2c0 = &wkup_i2c0;
> +		i2c1 = &main_i2c6;
> +		i2c2 = &main_i2c2;
> +		i2c3 = &main_i2c4;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial2:115200n8";
> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		/* 4G RAM */
> +		reg = <0x00000000 0x80000000 0x00000000 0x80000000>,
> +		      <0x00000008 0x80000000 0x00000000 0x80000000>;
> +	};
> +
> +	reserved_memory: reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		secure_ddr: optee@9e800000 {
> +			reg = <0x00 0x9e800000 0x00 0x01800000>;
> +			alignment = <0x1000>;

"alignment" property should not be needed here since you cannot
allocate from this region anyway.

> +			no-map;
> +		};
> +
> +		mcu_r5fss0_core0_dma_memory_region: r5f-dma-memory@a0000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa0000000 0x00 0x100000>;
> +			no-map;
> +		};
> +
> +		mcu_r5fss0_core0_memory_region: r5f-memory@a0100000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa0100000 0x00 0xf00000>;
> +			no-map;
> +		};
> +
> +		mcu_r5fss0_core1_dma_memory_region: r5f-dma-memory@a1000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa1000000 0x00 0x100000>;
> +			no-map;
> +		};
> +
> +		mcu_r5fss0_core1_memory_region: r5f-memory@a1100000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa1100000 0x00 0xf00000>;
> +			no-map;
> +		};
> +
> +		main_r5fss0_core0_dma_memory_region: r5f-dma-memory@a2000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa2000000 0x00 0x100000>;
> +			no-map;
> +		};
> +
> +		main_r5fss0_core0_memory_region: r5f-memory@a2100000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa2100000 0x00 0xf00000>;
> +			no-map;
> +		};
> +
> +		main_r5fss0_core1_dma_memory_region: r5f-dma-memory@a3000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa3000000 0x00 0x100000>;
> +			no-map;
> +		};
> +
> +		main_r5fss0_core1_memory_region: r5f-memory@a3100000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa3100000 0x00 0xf00000>;
> +			no-map;
> +		};
> +
> +		main_r5fss1_core0_dma_memory_region: r5f-dma-memory@a4000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa4000000 0x00 0x100000>;
> +			no-map;
> +		};
> +
> +		main_r5fss1_core0_memory_region: r5f-memory@a4100000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa4100000 0x00 0xf00000>;
> +			no-map;
> +		};
> +
> +		main_r5fss1_core1_dma_memory_region: r5f-dma-memory@a5000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa5000000 0x00 0x100000>;
> +			no-map;
> +		};
> +
> +		main_r5fss1_core1_memory_region: r5f-memory@a5100000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa5100000 0x00 0xf00000>;
> +			no-map;
> +		};
> +
> +		c66_1_dma_memory_region: c66-dma-memory@a6000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa6000000 0x00 0x100000>;
> +			no-map;
> +		};
> +
> +		c66_0_memory_region: c66-memory@a6100000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa6100000 0x00 0xf00000>;
> +			no-map;
> +		};
> +
> +		c66_0_dma_memory_region: c66-dma-memory@a7000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa7000000 0x00 0x100000>;
> +			no-map;
> +		};
> +
> +		c66_1_memory_region: c66-memory@a7100000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa7100000 0x00 0xf00000>;
> +			no-map;
> +		};
> +
> +		c71_0_dma_memory_region: c71-dma-memory@a8000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa8000000 0x00 0x100000>;
> +			no-map;
> +		};
> +
> +		c71_0_memory_region: c71-memory@a8100000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa8100000 0x00 0xf00000>;
> +			no-map;
> +		};
> +
> +		rtos_ipc_memory_region: ipc-memories@aa000000 {
> +			reg = <0x00 0xaa000000 0x00 0x01c00000>;
> +			alignment = <0x1000>;
> +			no-map;
> +		};
> +	};
> +
> +	gpio_keys: gpio-keys {
> +		compatible = "gpio-keys";
> +		autorepeat;

Do you need "autorepeat" on these?

> +		pinctrl-names = "default";
> +		pinctrl-0 = <&sw_pwr_pins_default>;
> +
> +		sw_boot: switch-1 {

I don't see anyone referencing these nodes, the "sw_boot" shouldn't be needed.

> +			label = "BOOT";
> +			linux,code = <BTN_0>;
> +			gpios = <&wkup_gpio0 0 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		sw_pwr: switch-2 {

NIT (no need to actually change this),
Would "button"-1/2 be better here, I see on the silkscreen has them as "sw"
but most would call these buttons if they saw them.

> +			label = "POWER";
> +			linux,code = <KEY_POWER>;
> +			gpios = <&wkup_gpio0 4 GPIO_ACTIVE_LOW>;
> +		};
> +	};

[...]

> +
> +&main_sdhci2 {
> +	/* Unused */
> +	status = "disabled";
> +};
> +

For J7x I did not "disable by default" several classes of device
like this one, since the default pinmux may allow their function.
Once that is sorted out I'll fix up this DT here and in the spots
below for you.

BTW, thanks for taking the time to rebase on my series for the
devices I did disable. Hope that didn't cause too much churn
on your side :)

> +&ospi0 {
> +	/* Unused */
> +	status = "disabled";
> +};
> +

[...]

> +
> +&main_r5fss0_core0 {
> +	firmware-name = "pdk-ipc/ipc_echo_test_mcu2_0_release_strip.xer5f";
> +};
> +

What is this crazy firmware name? These are not in linux-firmware, might
be better to leave these out until we get these names sorted out and
upstreamed. (yes I know the same snuck into k3-j721e-sk.dtb but
it probably isn't correct there either).

> +
> +&mcu_cpsw {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mcu_cpsw_pins_default &mcu_mdio_pins_default>;

mcu_mdio_pins_default should belong to the MDIO node below.

> +};
> +
> +&davinci_mdio {


Right here.

pinctrl-names = "default";
pinctrl-0 = <&mcu_mdio_pins_default>;


Everything else looks sane enough to me,

Reviewed-by: Andrew Davis <afd@ti.com>
