Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50B761219D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 10:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiJ2IwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 04:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiJ2IwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 04:52:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CA57294C;
        Sat, 29 Oct 2022 01:52:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D45EEB80B18;
        Sat, 29 Oct 2022 08:52:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B54D9C433C1;
        Sat, 29 Oct 2022 08:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667033532;
        bh=tgmS/qsa7Xj1NPEN9xtKdy2llm6Lq3xzN0ImD6ECmVk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bfr+Jc3YRUHbT0fjZU69RWmHkPLRflTF6qltdWo86+RhjCEqi1f5AKBBjIzVkXgn4
         HJqD63WuQOlv+gybW84JioiM+qryUzqyfK4Y/onjSx7qITvp/ajxm0rMOGXcckQH4X
         wOhc2umeWLnT3o43QCFCESUuIrjZUNu0pNnENmsZ1mHpc0wPxcDvL87IQNi5heMf2n
         M6wpSCDTLbrY1+cKteNt0psT58QNzGsJmM6I25Jq/0geIMUuxZp7gy2aO7h+QAg2Y5
         LUITtWaaCWD4NAton8fkOCRZilwnckCaCR5LzjrJrAimeo4fwRsHFGqjrBf4KDLPpz
         zeDyhAxf5HgDQ==
Date:   Sat, 29 Oct 2022 16:52:04 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     kernel@pengutronix.de, robh+dt@kernel.org, lgirdwood@gmail.com,
        lee.jones@linaro.org, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org, rui.zhang@intel.com,
        s.hauer@pengutronix.de, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org, linux-pm@vger.kernel.org,
        andreas@kemnade.info, amitk@kernel.org,
        linux-hwmon@vger.kernel.org, alistair23@gmail.com,
        devicetree@vger.kernel.org, linux@roeck-us.net, linux-imx@nxp.com
Subject: Re: [PATCH v22 2/2] ARM: dts: imx7d-remarkable2: Enable
 silergy,sy7636a
Message-ID: <20221029085204.GU125525@dragon>
References: <20221024105853.42029-1-alistair@alistair23.me>
 <20221024105853.42029-3-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024105853.42029-3-alistair@alistair23.me>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 08:58:53PM +1000, Alistair Francis wrote:
> Enable the silergy,sy7636a and silergy,sy7636a-regulator on the
> reMarkable2.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  arch/arm/boot/dts/imx7d-remarkable2.dts | 62 +++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
> index a2a91bfdd98e..99ac0d242936 100644
> --- a/arch/arm/boot/dts/imx7d-remarkable2.dts
> +++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
> @@ -22,6 +22,27 @@ memory@80000000 {
>  		reg = <0x80000000 0x40000000>;
>  	};
>  
> +	thermal-zones {
> +		epd-thermal {
> +			thermal-sensors = <&epd_pmic>;
> +			polling-delay-passive = <30000>;
> +			polling-delay = <30000>;

Have a newline between properties and child node.

> +			trips {
> +				trip0 {
> +					temperature = <49000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				trip1 {
> +					temperature = <50000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +	};
> +
>  	reg_brcm: regulator-brcm {
>  		compatible = "regulator-fixed";
>  		regulator-name = "brcm_reg";
> @@ -84,6 +105,33 @@ wacom_digitizer: digitizer@9 {
>  	};
>  };
>  
> +&i2c4 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&pinctrl_i2c4>;
> +	pinctrl-1 = <&pinctrl_i2c4>;
> +	status = "okay";
> +
> +	epd_pmic: sy7636a@62 {

Node name should be generic while label could be specific, so maybe:

	sy7636a: pmic@62 {

> +		compatible = "silergy,sy7636a";
> +		reg = <0x62>;
> +		status = "okay";

We usually end property list with `status`.

> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_epdpmic>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		#thermal-sensor-cells = <0>;
> +

Move this newline one line below.

> +		epd-pwr-good-gpios = <&gpio6 21 GPIO_ACTIVE_HIGH>;
> +		regulators {
> +			reg_epdpmic: vcom {
> +				regulator-name = "vcom";
> +				regulator-boot-on;
> +			};
> +		};
> +	};
> +};
> +
>  &snvs_pwrkey {
>  	status = "okay";
>  };
> @@ -177,6 +225,13 @@ MX7D_PAD_SAI1_TX_BCLK__GPIO6_IO13	0x14
>  		>;
>  	};
>  
> +	pinctrl_epdpmic: epdpmicgrp {
> +		fsl,pins = <
> +			MX7D_PAD_SAI2_RX_DATA__GPIO6_IO21 0x00000074
> +			MX7D_PAD_ENET1_RGMII_TXC__GPIO7_IO11 0x00000014

You might want to align hex values like other pinctrl nodes?

Shawn

> +		>;
> +	};
> +
>  	pinctrl_i2c1: i2c1grp {
>  		fsl,pins = <
>  			MX7D_PAD_I2C1_SDA__I2C1_SDA		0x4000007f
> @@ -184,6 +239,13 @@ MX7D_PAD_I2C1_SCL__I2C1_SCL		0x4000007f
>  		>;
>  	};
>  
> +	pinctrl_i2c4: i2c4grp {
> +		fsl,pins = <
> +			MX7D_PAD_I2C4_SDA__I2C4_SDA		0x4000007f
> +			MX7D_PAD_I2C4_SCL__I2C4_SCL		0x4000007f
> +		>;
> +	};
> +
>  	pinctrl_uart1: uart1grp {
>  		fsl,pins = <
>  			MX7D_PAD_UART1_TX_DATA__UART1_DCE_TX	0x79
> -- 
> 2.37.3
> 
