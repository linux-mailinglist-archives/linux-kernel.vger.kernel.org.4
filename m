Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFFB867BBE9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236220AbjAYUEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236115AbjAYUEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:04:46 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8490912587;
        Wed, 25 Jan 2023 12:04:43 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30PK4VR4096181;
        Wed, 25 Jan 2023 14:04:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1674677071;
        bh=q04QEmurduN8rMs3TdU5HLHxq3EBdz7WBEpMoppBJFM=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=fNTSJ+FhTLDhAoCEvupVzSbv6f2QLO8dspkdmyFBPM6E0/vLEAC71Lj4BOXqamj9c
         EvDu5eoCerOvJdtrvmyUnvbGNt9ojAmu+T7QHOfPUkueJONQtjm+bLnCJ+JFONuL9p
         m+XyNux7R4VibhsrHgpx3TWoUJKf+/0zax+U3RTk=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30PK4UHB046988
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 Jan 2023 14:04:30 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 25
 Jan 2023 14:04:30 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 25 Jan 2023 14:04:30 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30PK4TN3038113;
        Wed, 25 Jan 2023 14:04:29 -0600
Date:   Thu, 26 Jan 2023 01:34:28 +0530
From:   Rahul T R <r-ravikumar@ti.com>
To:     Sinthu Raja <sinthu.raja@mistralsolutions.com>
CC:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sinthu Raja <sinthu.raja@ti.com>
Subject: Re: [PATCH V2 2/2] arm64: dts: ti: k3-am68-sk-base-board: Add pinmux
 for RPi Header
Message-ID: <20230125200427.2bqlpym5tzz43yqq@uda0490373>
References: <20230124120311.7323-1-sinthu.raja@ti.com>
 <20230124120311.7323-3-sinthu.raja@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230124120311.7323-3-sinthu.raja@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17:33-20230124, Sinthu Raja wrote:
> From: Sinthu Raja <sinthu.raja@ti.com>
> 
> Add pinmux required to bring out the i2c and gpios on 40-pin RPi
> expansion header on the AM68 SK board.
> 
> Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
> ---
> 
> No Changes in V2.
> 
>  .../boot/dts/ti/k3-am68-sk-base-board.dts     | 70 ++++++++++++++++++-
>  1 file changed, 69 insertions(+), 1 deletion(-)
>

Tested-by: Rahul T R <r-ravikumar@ti.com>

> diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
> index 2091cd2431fb..722cd19b74e0 100644
> --- a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
> @@ -173,6 +173,32 @@ J721S2_IOPAD(0x0a0, PIN_INPUT, 0) /* (AB25) MCASP0_AXR12.MCAN7_RX */
>  			J721S2_IOPAD(0x09c, PIN_INPUT, 0) /* (T24) MCASP0_AXR11.MCAN7_TX */
>  		>;
>  	};
> +
> +	main_i2c4_pins_default: main-i2c4-pins-default {
> +		pinctrl-single,pins = <
> +			J721S2_IOPAD(0x010, PIN_INPUT_PULLUP, 7) /* (AF28) MCAN13_RX.I2C4_SDA */
> +			J721S2_IOPAD(0x014, PIN_INPUT_PULLUP, 7) /* (AD25) MCAN14_TX.I2C4_SCL */
> +		>;
> +	};
> +
> +	rpi_header_gpio0_pins_default: rpi-header-gpio0-pins-default {
> +		pinctrl-single,pins = <
> +			J721S2_IOPAD(0x0a8, PIN_INPUT, 7) /* (U24)  MCASP0_AXR14.GPIO0_42 */
> +			J721S2_IOPAD(0x090, PIN_INPUT, 7) /* (W24) MCASP0_AXR8.GPIO0_36 */
> +			J721S2_IOPAD(0x0bc, PIN_INPUT, 7) /* (V28) MCASP1_AFSX.GPIO0_47 */
> +			J721S2_IOPAD(0x06c, PIN_INPUT, 7) /* (V26) MCAN1_TX.GPIO0_27 */
> +			J721S2_IOPAD(0x004, PIN_INPUT, 7) /* (W25) MCAN12_TX.GPIO0_1 */
> +			J721S2_IOPAD(0x008, PIN_INPUT, 7) /* (AC24) MCAN12_RX.GPIO0_2 */
> +			J721S2_IOPAD(0x0b8, PIN_INPUT, 7) /* (AA24) MCASP1_ACLKX.GPIO0_46 */
> +			J721S2_IOPAD(0x00c, PIN_INPUT, 7) /* (AE28) MCAN13_TX.GPIO0_3 */
> +			J721S2_IOPAD(0x034, PIN_INPUT, 7) /* (AD24) PMIC_WAKE0.GPIO0_13 */
> +			J721S2_IOPAD(0x0a4, PIN_INPUT, 7) /* (T23) MCASP0_AXR13.GPIO0_41 */
> +			J721S2_IOPAD(0x0c0, PIN_INPUT, 7) /* (T28) MCASP1_AXR0.GPIO0_48 */
> +			J721S2_IOPAD(0x0b4, PIN_INPUT, 7) /* (U25) MCASP1_AXR4.GPIO0_45 */
> +			J721S2_IOPAD(0x0cc, PIN_INPUT, 7) /* (AE27) SPI0_CS0.GPIO0_51 */
> +			J721S2_IOPAD(0x08c, PIN_INPUT, 7) /* (T25) MCASP0_AXR7.GPIO0_35 */
> +		>;
> +	};
>  };
>  
>  &wkup_pmx0 {
> @@ -214,12 +240,39 @@ J721S2_WKUP_IOPAD(0x0d0, PIN_OUTPUT, 0) /* (C23) WKUP_GPIO0_4.MCU_MCAN1_TX*/
>  		>;
>  	};
>  
> +	mcu_i2c0_pins_default: mcu-i2c0-pins-default {
> +		pinctrl-single,pins = <
> +			J721S2_WKUP_IOPAD(0x100, PIN_INPUT, 0) /*(H24) WKUP_GPIO0_63.MCU_I2C0_SCL*/
> +			J721S2_WKUP_IOPAD(0x104, PIN_INPUT, 0) /*(H27) WKUP_GPIO0_64.MCU_I2C0_SDA*/
> +		>;
> +	};
> +
>  	mcu_i2c1_pins_default: mcu-i2c1-pins-default {
>  		pinctrl-single,pins = <
>  			J721S2_WKUP_IOPAD(0x0e0, PIN_INPUT, 0) /* (F24) WKUP_GPIO0_8.MCU_I2C1_SCL */
>  			J721S2_WKUP_IOPAD(0x0e4, PIN_INPUT, 0) /* (H26) WKUP_GPIO0_9.MCU_I2C1_SDA */
>  		>;
>  	};
> +
> +	mcu_rpi_header_gpio0_pins_default: mcu-rpi-header-gpio0-pins-default {
> +		pinctrl-single,pins = <
> +			J721S2_WKUP_IOPAD(0x180, PIN_INPUT, 7) /* (G25) WKUP_GPIO0_66 */
> +			J721S2_WKUP_IOPAD(0x190, PIN_INPUT, 7) /* (K26) WKUP_GPIO0_49 */
> +			J721S2_WKUP_IOPAD(0x0c4, PIN_INPUT, 7) /* (E24) MCU_SPI1_D0.WKUP_GPIO0_1 */
> +			J721S2_WKUP_IOPAD(0x0c8, PIN_INPUT, 7) /* (C28) MCU_SPI1_D1.WKUP_GPIO0_2 */
> +			J721S2_WKUP_IOPAD(0x0c0, PIN_INPUT, 7) /* (D26) MCU_SPI1_CLK.WKUP_GPIO0_0 */
> +			J721S2_WKUP_IOPAD(0x0fc, PIN_INPUT, 7) /* (D25) MCU_SPI1_CS2.WKUP_GPIO0_15*/
> +			J721S2_WKUP_IOPAD(0x120, PIN_INPUT, 7) /* (G27) WKUP_GPIO0_56 */
> +			J721S2_WKUP_IOPAD(0x17c, PIN_INPUT, 7) /* (J26) WKUP_GPIO0_57 */
> +			J721S2_WKUP_IOPAD(0x184, PIN_INPUT, 7) /* (J27) WKUP_GPIO0_67 */
> +			J721S2_WKUP_IOPAD(0x0cc, PIN_INPUT, 7) /* (C27) MCU_SPI1_CS0.WKUP_GPIO0_3 */
> +		>;
> +	};
> +};
> +
> +&main_gpio0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&rpi_header_gpio0_pins_default>;
>  };
>  
>  &main_gpio2 {
> @@ -235,7 +288,8 @@ &main_gpio6 {
>  };
>  
>  &wkup_gpio0 {
> -	status = "disabled";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mcu_rpi_header_gpio0_pins_default>;
>  };
>  
>  &wkup_gpio1 {
> @@ -273,6 +327,20 @@ exp1: gpio@21 {
>  	};
>  };
>  
> +&main_i2c4 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_i2c4_pins_default>;
> +	clock-frequency = <400000>;
> +};
> +
> +&mcu_i2c0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mcu_i2c0_pins_default>;
> +	clock-frequency = <400000>;
> +};
> +
>  &main_sdhci0 {
>  	/* Unused */
>  	status = "disabled";
> -- 
> 2.36.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
