Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898335BC3A3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 09:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiISHsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 03:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiISHsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 03:48:06 -0400
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD99E1E3EC;
        Mon, 19 Sep 2022 00:48:04 -0700 (PDT)
Date:   Mon, 19 Sep 2022 09:47:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
        t=1663573681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
         references:references; bh=FUzULdujfHx+XvOmBlWfZijqfqCB/CCQSJMlgY6iG5Y=;
        b=tpTfDwTjK2BYAl86UxbpwNKaCvkAwbKnoWS41DW6jVTx+bkTzxuA1uavAPUKpkV+dKKTPW
        AWIhS9jjCQE8N0swDmVqflFPZLQ2dSnSfCH7VLrx/uTgrGWLEqvtnRtOhcGrE5NvSywMks
        gZvYU5LE8L2ZESUcS0+uj5DXz93UlCX4N1x6p1dE5zSYL33I5ADAJt7jogtTtWDLp33EmM
        BObH+OqIIoKUAFKR5T9Od5ve5AyoClqwaZgqRo1i7wsj71g3FXlW/8LPUaeA2w/v02Gbp5
        2mxpW0bJ6SzMAg5R9Bvwp5qEJIE4efS6fPVrVHgDoaxxnlR/xgxpbbb+sZ8e2g==
From:   Alexander Dahl <ada@thorsis.com>
To:     Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, arnd@arndb.de,
        f.fainelli@gmail.com, krzyszccf.kozlowski+dt@linaro.org,
        nsaenz@kernel.org, olof@lixom.net, robh+dt@kernel.org,
        soc@kernel.org, stefan.wahren@i2se.com, william.zhang@broadcom.com
Subject: Re: [PATCH] ARM: dts: Add Raspberry Pi Compute Module 4 CANOPi Board
Message-ID: <YygeqySPtiAEN8EH@ada.ifak-system.com>
Mail-Followup-To: Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, arnd@arndb.de,
        f.fainelli@gmail.com, krzyszccf.kozlowski+dt@linaro.org,
        nsaenz@kernel.org, olof@lixom.net, robh+dt@kernel.org,
        soc@kernel.org, stefan.wahren@i2se.com, william.zhang@broadcom.com
References: <20220916153156.30412-1-ariel.dalessandro@collabora.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916153156.30412-1-ariel.dalessandro@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hei hei,

Am Fri, Sep 16, 2022 at 12:31:56PM -0300 schrieb Ariel D'Alessandro:
> The Eclipse KUKSA CANOPi [0] is a baseboard for the Raspberry Compute
> Module 4 (CM4). It contains a VIA VL805 4 Port USB controller and two
> MCP251xFD based CAN-FD interfaces.
> 
> [0] https://github.com/boschresearch/kuksa.hardware
> 
> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
> ---
>  arch/arm/boot/dts/Makefile                    |   1 +
>  arch/arm/boot/dts/bcm2711-rpi-cm4-canopi.dts  | 139 ++++++++++++++++++
>  arch/arm64/boot/dts/broadcom/Makefile         |   1 +
>  .../dts/broadcom/bcm2711-rpi-cm4-canopi.dts   |   2 +
>  4 files changed, 143 insertions(+)
>  create mode 100644 arch/arm/boot/dts/bcm2711-rpi-cm4-canopi.dts
>  create mode 100644 arch/arm64/boot/dts/broadcom/bcm2711-rpi-cm4-canopi.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 05d8aef6e5d2..8930ab2c132c 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -98,6 +98,7 @@ dtb-$(CONFIG_ARCH_BCM2835) += \
>  	bcm2837-rpi-zero-2-w.dtb \
>  	bcm2711-rpi-400.dtb \
>  	bcm2711-rpi-4-b.dtb \
> +	bcm2711-rpi-cm4-canopi.dtb \
>  	bcm2711-rpi-cm4-io.dtb \
>  	bcm2835-rpi-zero.dtb \
>  	bcm2835-rpi-zero-w.dtb
> diff --git a/arch/arm/boot/dts/bcm2711-rpi-cm4-canopi.dts b/arch/arm/boot/dts/bcm2711-rpi-cm4-canopi.dts
> new file mode 100644
> index 000000000000..52ec5908883c
> --- /dev/null
> +++ b/arch/arm/boot/dts/bcm2711-rpi-cm4-canopi.dts
> @@ -0,0 +1,139 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/dts-v1/;
> +#include "bcm2711-rpi-cm4.dtsi"
> +
> +/ {
> +	model = "Raspberry Pi Compute Module 4 CANOPi Board";
> +
> +	clocks {
> +		clk_mcp251xfd_osc: mcp251xfd-osc {
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <20000000>;
> +		};
> +	};
> +
> +	leds {
> +		led-act {
> +			gpios = <&gpio 42 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		led-pwr {
> +			label = "PWR";
> +			gpios = <&expgpio 2 GPIO_ACTIVE_LOW>;
> +			default-state = "keep";
> +			linux,default-trigger = "default-on";
> +		};
> +	};

This looks like using the node name and the deprecated "label"
property for LED naming.  Please see
Documentation/devicetree/bindings/leds/common.yaml and use the
properties "function" and "color" instead.  Also check the node names
itself, see the example in that binding or the leds-gpio binding for
reference.

Greets
Alex

> +};
> +
> +&ddc0 {
> +	status = "okay";
> +};
> +
> +&ddc1 {
> +	status = "okay";
> +};
> +
> +&hdmi0 {
> +	status = "okay";
> +};
> +
> +&hdmi1 {
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c0_gpio44>;
> +	status = "okay";
> +	clock-frequency = <100000>;
> +
> +	pcf85063a@51 {
> +		compatible = "nxp,pcf85063a";
> +		reg = <0x51>;
> +	};
> +};
> +
> +&pcie0 {
> +	pci@0,0 {
> +		device_type = "pci";
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		reg = <0 0 0 0 0>;
> +
> +		usb@0,0 {
> +			reg = <0 0 0 0 0>;
> +			resets = <&reset RASPBERRYPI_FIRMWARE_RESET_ID_USB>;
> +		};
> +	};
> +};
> +
> +&pixelvalve0 {
> +	status = "okay";
> +};
> +
> +&pixelvalve1 {
> +	status = "okay";
> +};
> +
> +&pixelvalve2 {
> +	status = "okay";
> +};
> +
> +&pixelvalve4 {
> +	status = "okay";
> +};
> +
> +&spi {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spi0_gpio7>;
> +	cs-gpios = <&gpio 8 1>, <&gpio 7 1>;
> +	dmas = <&dma 6>, <&dma 7>;
> +	dma-names = "tx", "rx";
> +
> +	mcp251xfd0: mcp251xfd@0 {
> +		compatible = "microchip,mcp251xfd";
> +		reg = <0>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&mcp251xfd0_pins>;
> +		spi-max-frequency = <20000000>;
> +		interrupt-parent = <&gpio>;
> +		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
> +		clocks = <&clk_mcp251xfd_osc>;
> +	};
> +
> +	mcp251xfd1: mcp251xfd@1 {
> +		compatible = "microchip,mcp251xfd";
> +		reg = <1>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&mcp251xfd1_pins>;
> +		spi-max-frequency = <20000000>;
> +		interrupt-parent = <&gpio>;
> +		interrupts = <22 IRQ_TYPE_LEVEL_LOW>;
> +		clocks = <&clk_mcp251xfd_osc>;
> +	};
> +};
> +
> +&gpio {
> +	mcp251xfd0_pins: mcp251xfd0_pins {
> +		brcm,pins = <27>;
> +		brcm,function = <BCM2835_FSEL_GPIO_IN>;
> +	};
> +
> +	mcp251xfd1_pins: mcp251xfd1_pins {
> +		brcm,pins = <22>;
> +		brcm,function = <BCM2835_FSEL_GPIO_IN>;
> +	};
> +};
> +
> +&vc4 {
> +	status = "okay";
> +};
> +
> +&vec {
> +	status = "disabled";
> +};
> diff --git a/arch/arm64/boot/dts/broadcom/Makefile b/arch/arm64/boot/dts/broadcom/Makefile
> index e8584d3b698f..7cd88b8c0345 100644
> --- a/arch/arm64/boot/dts/broadcom/Makefile
> +++ b/arch/arm64/boot/dts/broadcom/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  dtb-$(CONFIG_ARCH_BCM2835) += bcm2711-rpi-400.dtb \
>  			      bcm2711-rpi-4-b.dtb \
> +			      bcm2711-rpi-cm4-canopi.dtb \
>  			      bcm2711-rpi-cm4-io.dtb \
>  			      bcm2837-rpi-3-a-plus.dtb \
>  			      bcm2837-rpi-3-b.dtb \
> diff --git a/arch/arm64/boot/dts/broadcom/bcm2711-rpi-cm4-canopi.dts b/arch/arm64/boot/dts/broadcom/bcm2711-rpi-cm4-canopi.dts
> new file mode 100644
> index 000000000000..e9369aa0eb39
> --- /dev/null
> +++ b/arch/arm64/boot/dts/broadcom/bcm2711-rpi-cm4-canopi.dts
> @@ -0,0 +1,2 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "arm/bcm2711-rpi-cm4-canopi.dts"
> -- 
> 2.37.2
> 
