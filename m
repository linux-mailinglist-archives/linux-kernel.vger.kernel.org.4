Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7D1672082
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 16:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjARPFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 10:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjARPFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 10:05:08 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0962B290;
        Wed, 18 Jan 2023 07:04:44 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 868131643;
        Wed, 18 Jan 2023 16:04:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1674054282;
        bh=sUjHOG2olgdeF1/5XV754TxoYc8jG2ShPLKx+8ro0YY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BDvKyibNgxGfmdNnEXL2nGxycsJDOb3UK6x6VWCOhNS/YXwy8nRsQyhPKw85IPjeh
         1M+tmq1TxHErju5Q+pmcgbBjbf1r/Poz8OEg6ob5YcuDHjL4VzycN49Gu/OmxagH+i
         Jk5CQLCIjkFyHFDe707qwe+MnSnEGzr6XDOeHkbM=
Date:   Wed, 18 Jan 2023 17:04:40 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Philippe Schenker <dev@pschenker.ch>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: imx8mp-verdin-dev: Do not include dahlia
 dtsi
Message-ID: <Y8gKiOE/8+AQbQl7@pendragon.ideasonboard.com>
References: <20230118105251.6035-1-dev@pschenker.ch>
 <20230118105251.6035-3-dev@pschenker.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230118105251.6035-3-dev@pschenker.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philippe,

Thank you for the patch.

On Wed, Jan 18, 2023 at 11:52:51AM +0100, Philippe Schenker wrote:
> From: Philippe Schenker <philippe.schenker@toradex.com>
> 
> Follow the change that has been done on imx8mm-verdin-dev.dtsi and
> remove the include from dahlia to be consistent. Put back all nodes that
> previously had been included.
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> 
> ---
> 
>  .../boot/dts/freescale/imx8mp-verdin-dev.dtsi | 116 +++++++++++++++++-
>  1 file changed, 114 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin-dev.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin-dev.dtsi
> index cefabe65b252..361426c0da0a 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-verdin-dev.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin-dev.dtsi
> @@ -3,8 +3,6 @@
>   * Copyright 2022 Toradex
>   */
>  
> -#include "imx8mp-verdin-dahlia.dtsi"
> -

Makes sense.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  / {
>  	/* TODO: Audio Codec */
>  
> @@ -21,16 +19,99 @@ reg_eth2phy: regulator-eth2phy {
>  	};
>  };
>  
> +&backlight {
> +	power-supply = <&reg_3p3v>;
> +};
> +
> +/* Verdin SPI_1 */
> +&ecspi1 {
> +	status = "okay";
> +};
> +
> +/* EEPROM on display adapter boards */
> +&eeprom_display_adapter {
> +	status = "okay";
> +};
> +
> +/* EEPROM on Verdin Development board */
> +&eeprom_carrier_board {
> +	status = "okay";
> +};
> +
> +&eqos {
> +	status = "okay";
> +};
> +
>  &fec {
>  	phy-supply = <&reg_eth2phy>;
>  	status = "okay";
>  };
>  
> +&flexcan1 {
> +	status = "okay";
> +};
> +
> +&flexcan2 {
> +	status = "okay";
> +};
> +
> +/* Verdin QSPI_1 */
> +&flexspi {
> +	status = "okay";
> +};
> +
>  &gpio_expander_21 {
>  	status = "okay";
>  	vcc-supply = <&reg_1p8v>;
>  };
>  
> +/* Current measurement into module VCC */
> +&hwmon {
> +	status = "okay";
> +};
> +
> +&hwmon_temp {
> +	vs-supply = <&reg_1p8v>;
> +	status = "okay";
> +};
> +
> +/* Verdin I2C_2_DSI */
> +&i2c2 {
> +	status = "okay";
> +};
> +
> +&i2c3 {
> +	status = "okay";
> +};
> +
> +/* Verdin I2C_1 */
> +&i2c4 {
> +	status = "okay";
> +
> +	/* TODO: Audio Codec */
> +};
> +
> +/* TODO: Verdin PCIE_1 */
> +
> +/* Verdin PWM_1 */
> +&pwm1 {
> +	status = "okay";
> +};
> +
> +/* Verdin PWM_2 */
> +&pwm2 {
> +	status = "okay";
> +};
> +
> +/* Verdin PWM_3_DSI */
> +&pwm3 {
> +	status = "okay";
> +};
> +
> +&reg_usdhc2_vmmc {
> +	vin-supply = <&reg_3p3v>;
> +};
> +
>  /* TODO: Verdin I2C_1 with Audio Codec */
>  
>  /* Verdin UART_1, connector X50 through RS485 transceiver */
> @@ -38,9 +119,40 @@ &uart1 {
>  	linux,rs485-enabled-at-boot-time;
>  	rs485-rts-active-low;
>  	rs485-rx-during-tx;
> +	status = "okay";
> +};
> +
> +/* Verdin UART_2 */
> +&uart2 {
> +	status = "okay";
> +};
> +
> +/* Verdin UART_3, used as the Linux Console */
> +&uart3 {
> +	status = "okay";
> +};
> +
> +/* Verdin USB_1 */
> +&usb3_0 {
> +	status = "okay";
> +};
> +
> +&usb3_phy0 {
> +	status = "okay";
> +};
> +
> +/* Verdin USB_2 */
> +&usb3_1 {
> +	fsl,permanently-attached;
> +	status = "okay";
> +};
> +
> +&usb3_phy1 {
> +	status = "okay";
>  };
>  
>  /* Limit frequency on dev board due to long traces and bad signal integrity */
>  &usdhc2 {
>  	max-frequency = <100000000>;
> +	status = "okay";
>  };

-- 
Regards,

Laurent Pinchart
