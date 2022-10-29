Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC2C612324
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 15:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiJ2NIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 09:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiJ2NIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 09:08:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81ADE27CCD;
        Sat, 29 Oct 2022 06:08:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D8A0B80C63;
        Sat, 29 Oct 2022 13:08:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE16FC433C1;
        Sat, 29 Oct 2022 13:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667048889;
        bh=quMDOfP1QXfzQ6F0KCVWRa5HH46e9O2tMvwS/Aw9lB4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eBFymFPKFa3NrMnJKmOaI2ORyY7Ha9urPdBGJDtPtGuPBSln8Wj/vU6DW6R3LoheL
         cFBo4FGtgubxaMd72SlDKlpAN65MXF08HZgxYOb+5dTF0ZVggep9DzW2F0+BNnIo59
         RzjlnRs8WHo099wgBCHJnMOC6K7uwHObkkPwTI4rDWi4X83NNNHmp95H4qe8Y4Fr93
         ZQzKl4OqwviodcDjyauB9pLUDfQpXyDnJxrEU184aI9bhaD0Rt7Drb5Lx3AdYN+FW/
         BG8dw497iFpOi4e/HMt9pl5DI97ntLekHKxi/ArTUWtfenWnffjA/21a7zCmnEkAtM
         DsWR63Q38vaCg==
Date:   Sat, 29 Oct 2022 21:08:00 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, broonie@kernel.org,
        kernel@pengutronix.de, lee.jones@linaro.org,
        linux-arm-kernel@lists.infradead.org, alistair23@gmail.com,
        linux-imx@nxp.com, amitk@kernel.org, s.hauer@pengutronix.de,
        linux@roeck-us.net, rui.zhang@intel.com,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hwmon@vger.kernel.org, andreas@kemnade.info,
        linux-kernel@vger.kernel.org, geert@linux-m68k.org
Subject: Re: [PATCH v23 2/2] ARM: dts: imx7d-remarkable2: Enable
 silergy,sy7636a
Message-ID: <20221029130800.GZ125525@dragon>
References: <20221029100646.294583-1-alistair@alistair23.me>
 <20221029100646.294583-3-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221029100646.294583-3-alistair@alistair23.me>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2022 at 08:06:46PM +1000, Alistair Francis wrote:
> Enable the silergy,sy7636a and silergy,sy7636a-regulator on the
> reMarkable2.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  arch/arm/boot/dts/imx7d-remarkable2.dts | 63 +++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
> index a2a91bfdd98e..58581295b9a0 100644
> --- a/arch/arm/boot/dts/imx7d-remarkable2.dts
> +++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
> @@ -22,6 +22,28 @@ memory@80000000 {
>  		reg = <0x80000000 0x40000000>;
>  	};
>  
> +	thermal-zones {
> +		epd-thermal {
> +			thermal-sensors = <&epd_pmic>;
> +			polling-delay-passive = <30000>;
> +			polling-delay = <30000>;
> +
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
> @@ -84,6 +106,33 @@ wacom_digitizer: digitizer@9 {
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
> +	sy7636a: pmic@62 {
> +		compatible = "silergy,sy7636a";
> +		reg = <0x62>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_epdpmic>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		#thermal-sensor-cells = <0>;
> +		epd-pwr-good-gpios = <&gpio6 21 GPIO_ACTIVE_HIGH>;
> +		status = "okay";

The "okay" status is only needed to flip disabled devices.  It can be
dropped here.

I fixed it up and applied both patches.

Shawn

> +
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
> @@ -177,6 +226,13 @@ MX7D_PAD_SAI1_TX_BCLK__GPIO6_IO13	0x14
>  		>;
>  	};
>  
> +	pinctrl_epdpmic: epdpmicgrp {
> +		fsl,pins = <
> +			MX7D_PAD_SAI2_RX_DATA__GPIO6_IO21	0x00000074
> +			MX7D_PAD_ENET1_RGMII_TXC__GPIO7_IO11	0x00000014
> +		>;
> +	};
> +
>  	pinctrl_i2c1: i2c1grp {
>  		fsl,pins = <
>  			MX7D_PAD_I2C1_SDA__I2C1_SDA		0x4000007f
> @@ -184,6 +240,13 @@ MX7D_PAD_I2C1_SCL__I2C1_SCL		0x4000007f
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
> 2.38.1
> 
