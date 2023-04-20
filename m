Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8079F6E8D71
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbjDTJDe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 20 Apr 2023 05:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234199AbjDTJCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:02:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1AAB9EFD;
        Thu, 20 Apr 2023 01:57:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD829C14;
        Thu, 20 Apr 2023 01:58:22 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 999A53F5A1;
        Thu, 20 Apr 2023 01:57:37 -0700 (PDT)
Date:   Thu, 20 Apr 2023 09:57:35 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Ludwig Kormann <ludwig.kormann@in-circuit.de>
Cc:     samuel@sholland.org, jernej.skrabec@gmail.com, wens@csie.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] arm: dts: sunxi: Add ICnova A20 ADB4006 board
 support
Message-ID: <20230420095735.00cbf365@donnerap.cambridge.arm.com>
In-Reply-To: <20230419121229.1384024-1-ludwig.kormann@in-circuit.de>
References: <20230419121229.1384024-1-ludwig.kormann@in-circuit.de>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Apr 2023 14:12:29 +0200
Ludwig Kormann <ludwig.kormann@in-circuit.de> wrote:

Hi Ludwig,

thanks for posting this!

> Add board support for ICnova A20 SomPi compute module on
> ICnova ADB4006 development board.
> 
> Specification:
> SoM
> - Processor: Allwinner A20 Cortex-A7 Dual Core at 1GHz
> - 512MB DDR3 RAM
> - Fast Ethernet (Phy: Realtek RTL8201CP)
> ADB4006
> - I2C
> - 2x USB 2.0
> - 1x Fast Ethernet port
> - 1x SATA
> - 2x buttons (PWRON, Boot)
> - 2x LEDS
> - serial console
> - HDMI
> - µSD-Card slot
> - Audio Line-In / Line-Out
> - GPIO pinheaders
> 
> https://wiki.in-circuit.de/index.php5?title=ICnova_ADB4006
> https://wiki.in-circuit.de/index.php5?title=ICnova_A20_SODIMM
> 
> ---
> 
> changes in v2:
> - use short licensing header
> - remove deprecated elements from led nodes
> - disable csi power supply
> - add missing pins in usbphy node
> - split dts into SoM dtsi and carrier board dts
> 
> v1 of this patch was sent to the uboot mailing list [1].
> 
> [1] https://lists.denx.de/pipermail/u-boot/2023-April/514605.html
> 
> Signed-off-by: Ludwig Kormann <ludwig.kormann@in-circuit.de>

So apart from what Krzysztof already mentioned (separate binding patch and
stray line), this looks good to me, and passed dt-validate. Also you
addressed all the comments I had on the U-Boot post (thanks for that), so
with those nits above fixed:

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  .../devicetree/bindings/arm/sunxi.yaml        |   6 +
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../boot/dts/sun7i-a20-icnova-a20-adb4006.dts | 137 ++++++++++++++++++
>  arch/arm/boot/dts/sun7i-a20-icnova-a20.dtsi   |  63 ++++++++
>  4 files changed, 207 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun7i-a20-icnova-a20-adb4006.dts
>  create mode 100644 arch/arm/boot/dts/sun7i-a20-icnova-a20.dtsi
> 
> diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
> index 013821f4a7b8..12f0c236f17b 100644
> --- a/Documentation/devicetree/bindings/arm/sunxi.yaml
> +++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
> @@ -305,6 +305,12 @@ properties:
>            - const: allwinner,i12-tvbox
>            - const: allwinner,sun7i-a20
>  
> +      - description: ICNova A20 ADB4006
> +        items:
> +          - const: incircuit,icnova-a20-adb4006
> +          - const: incircuit,icnova-a20
> +          - const: allwinner,sun7i-a20
> +
>        - description: ICNova A20 SWAC
>          items:
>            - const: incircuit,icnova-a20-swac
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 3cc32722c394..b6b408417261 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1321,6 +1321,7 @@ dtb-$(CONFIG_MACH_SUN7I) += \
>  	sun7i-a20-hummingbird.dtb \
>  	sun7i-a20-itead-ibox.dtb \
>  	sun7i-a20-i12-tvbox.dtb \
> +	sun7i-a20-icnova-a20-adb4006.dtb \
>  	sun7i-a20-icnova-swac.dtb \
>  	sun7i-a20-lamobo-r1.dtb \
>  	sun7i-a20-linutronix-testbox-v2.dtb \
> diff --git a/arch/arm/boot/dts/sun7i-a20-icnova-a20-adb4006.dts b/arch/arm/boot/dts/sun7i-a20-icnova-a20-adb4006.dts
> new file mode 100644
> index 000000000000..c1606c085e4e
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun7i-a20-icnova-a20-adb4006.dts
> @@ -0,0 +1,137 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +// Copyright (C) 2023 In-Circuit GmbH
> +
> +/dts-v1/;
> +
> +#include "sun7i-a20-icnova-a20.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> +
> +/ {
> +	model = "In-Circuit ICnova A20 ADB4006";
> +	compatible = "incircuit,icnova-a20-adb4006", "incircuit,icnova-a20",
> +		     "allwinner,sun7i-a20";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	hdmi-connector {
> +		compatible = "hdmi-connector";
> +		type = "a";
> +
> +		port {
> +			hdmi_con_in: endpoint {
> +				remote-endpoint = <&hdmi_out_con>;
> +			};
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		led-0 {
> +			function = LED_FUNCTION_POWER;
> +			color = <LED_COLOR_ID_YELLOW>;
> +			gpios = <&pio 7 21 GPIO_ACTIVE_HIGH>; /* PH21 */
> +			default-state = "on";
> +		};
> +
> +		led-1 {
> +			function = LED_FUNCTION_HEARTBEAT;
> +			color = <LED_COLOR_ID_RED>;
> +			gpios = <&pio 7 20 GPIO_ACTIVE_HIGH>; /* PH20 */
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
> +};
> +
> +&ahci {
> +	target-supply = <&reg_ahci_5v>;
> +	status = "okay";
> +};
> +
> +&codec {
> +	status = "okay";
> +};
> +
> +&de {
> +	status = "okay";
> +};
> +
> +&ehci0 {
> +	status = "okay";
> +};
> +
> +&ehci1 {
> +	status = "okay";
> +};
> +
> +&hdmi {
> +	status = "okay";
> +};
> +
> +&hdmi_out {
> +	hdmi_out_con: endpoint {
> +		remote-endpoint = <&hdmi_con_in>;
> +	};
> +};
> +
> +&mmc0 {
> +	vmmc-supply = <&reg_vcc3v3>;
> +	bus-width = <4>;
> +	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
> +	status = "okay";
> +};
> +
> +&ohci0 {
> +	status = "okay";
> +};
> +
> +&ohci1 {
> +	status = "okay";
> +};
> +
> +&otg_sram {
> +	status = "okay";
> +};
> +
> +&reg_ahci_5v {
> +	status = "okay";
> +};
> +
> +&ac_power_supply {
> +	status = "okay";
> +};
> +
> +&reg_usb1_vbus {
> +	status = "okay";
> +};
> +
> +&reg_usb2_vbus {
> +	status = "okay";
> +};
> +
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_pb_pins>;
> +	status = "okay";
> +};
> +
> +&usb_otg {
> +	dr_mode = "otg";
> +	status = "okay";
> +};
> +
> +&usbphy {
> +	usb0_id_det-gpios = <&pio 7 4 GPIO_ACTIVE_HIGH>; /* PH4 */
> +	usb0_vbus_det-gpios = <&pio 7 5 GPIO_ACTIVE_HIGH>; /* PH5 */
> +	usb1_vbus-supply = <&reg_usb1_vbus>;
> +	usb2_vbus-supply = <&reg_usb2_vbus>;
> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/sun7i-a20-icnova-a20.dtsi b/arch/arm/boot/dts/sun7i-a20-icnova-a20.dtsi
> new file mode 100644
> index 000000000000..f1142bda5cd7
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun7i-a20-icnova-a20.dtsi
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +// Copyright (C) 2023 In-Circuit GmbH
> +
> +#include "sun7i-a20.dtsi"
> +#include "sunxi-common-regulators.dtsi"
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +&cpu0 {
> +	cpu-supply = <&reg_dcdc2>;
> +};
> +
> +&gmac {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&gmac_mii_pins>;
> +	phy-handle = <&phy1>;
> +	phy-mode = "mii";
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +
> +	axp209: pmic@34 {
> +		reg = <0x34>;
> +		interrupt-parent = <&nmi_intc>;
> +		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +};
> +
> +&gmac_mdio {
> +	phy1: ethernet-phy@1 {
> +		reg = <1>;
> +	};
> +};
> +
> +#include "axp209.dtsi"
> +
> +&reg_dcdc2 {
> +	regulator-always-on;
> +	regulator-min-microvolt = <1000000>;
> +	regulator-max-microvolt = <1400000>;
> +	regulator-name = "vdd-cpu";
> +};
> +
> +&reg_dcdc3 {
> +	regulator-always-on;
> +	regulator-min-microvolt = <1000000>;
> +	regulator-max-microvolt = <1400000>;
> +	regulator-name = "vdd-int-dll";
> +};
> +
> +&reg_ldo1 {
> +	regulator-name = "vdd-rtc";
> +};
> +
> +&reg_ldo2 {
> +	regulator-always-on;
> +	regulator-min-microvolt = <3000000>;
> +	regulator-max-microvolt = <3000000>;
> +	regulator-name = "avcc";
> +};
> +

