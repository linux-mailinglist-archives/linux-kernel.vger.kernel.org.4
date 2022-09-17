Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8188C5BB7B3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 12:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiIQKSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 06:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIQKSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 06:18:48 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE241C93C;
        Sat, 17 Sep 2022 03:18:46 -0700 (PDT)
Received: from [192.168.1.138] ([37.4.248.23]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MsqMq-1pSPqD2nXM-00tCDJ; Sat, 17 Sep 2022 12:18:25 +0200
Message-ID: <e2c081b0-080e-fd96-c277-deec63c5f822@i2se.com>
Date:   Sat, 17 Sep 2022 12:18:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ARM: dts: Add Raspberry Pi Compute Module 4 CANOPi Board
Content-Language: en-US
To:     Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc:     arnd@arndb.de, f.fainelli@gmail.com,
        krzyszccf.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        olof@lixom.net, robh+dt@kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, william.zhang@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220916153156.30412-1-ariel.dalessandro@collabora.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20220916153156.30412-1-ariel.dalessandro@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bWgkOWAUfG9XTpNhMLKrOflaI6yMpSZR0LRfPFf41oxosY9/8OU
 ys5xr3J1ogBEP/EcWQamHJT9n8H3avVgEV65M+4QkcS5fXDx/DXE1G1TBkhDO66KO/W8p5v
 E5qM7utfqsxvnWt5XukzdGnUjlyCKcJHQUryCgQFwZFfmve7OvNWbqt9TaRmgh5eaXDE3nI
 t5ptC24JJP0M0cCIXX1nA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oCsjlzjt2YM=:x4ztgspVp6Sc/Qo2O56PKU
 5R9pXpN3eWR4o0xGEz6atj1AdhCHT8Em9AG9oOz/rNfawuXyLgdnwrKVcnEpJwI8o9ZjAt162
 7Vt4M1vY1XxcgNB9Ps7ANjM1282kyj4wk82CCm+lkWaX26NjEkWt5LcRcyF77aQyNEL9S57hl
 yeYgiHrT4Zd4AKU8IAQs0d7e1SJQyxzzFgshGkfpxUca6s+mO+oI1IfcQ1zcrhVTrKPpYU6j3
 1Cj7/sKNAnjHQqJvukk1jkBpk8xfQrFf7/eYFyAZrUVRLThGmYfuYNR1roHqvnV/l3Zz+oeDu
 JzjMqiU4T3UOcgEZWZvvSEc9KeUydGGS+f9zooa89v7n07xDEbXFUT7I9OuFHXbMKI1ANjzUz
 Omk79VKpuphegWSg8kW8XMYisgxHZwxI19KhPCkyURmnvFwqATvn4TUGSCz/jBxJ45ZulPcmz
 vnF75rI827O/DvOKGvnbChM6AhTRBMDi1ZiXuPBzPlq6+DaeUcsSej6BqfSaNyfq5kYB82Ecz
 aYlBdmu6hU49hYwIcnztOkdTCDtV4HxLWh3LLAmC0uThVB3s3bixzd8tQXBIaHFgl9lJsA3OF
 FAHCWzmwe6t9qBvCUN3YJ7pJauxykoknwaTzF9PXqY+FTqJRNSDbdzFyS0Lki6GuG29I1zmHK
 Az7BOslEbUmWCvv0rHTjdDRnjJo4s3AQcDcaU4DzfR43A6xBwVVed3mF2jy81kE1doIuRY+Bs
 oQFXqM1NQo+gv7HI8ARpvshw9CDwDbqMcD7QFip3486/oWCx7l/7ft3Y09Xc7215jJHCwQrE4
 nqxsRJE
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ariel,

Am 16.09.22 um 17:31 schrieb Ariel D'Alessandro:
> The Eclipse KUKSA CANOPi [0] is a baseboard for the Raspberry Compute
> Module 4 (CM4). It contains a VIA VL805 4 Port USB controller and two
> MCP251xFD based CAN-FD interfaces.

this is a cool piece of hardware :-)

Is it correct this baseboard is only intended for Compute Modules 
without Wifi/BT? Otherwise we get conflicts with UART0. The 
bcm2711-rpi-cm4.dtsi is currently written for all Compute Module 
variants. A possible solution is to use delete-node, another cleaner 
ones is to split bcm2711-rpi-cm4 into wifi and non-wifi variants and 
include the non-wifi one in your case.

>
> [0] https://github.com/boschresearch/kuksa.hardware
>
> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
> ---
>   arch/arm/boot/dts/Makefile                    |   1 +
>   arch/arm/boot/dts/bcm2711-rpi-cm4-canopi.dts  | 139 ++++++++++++++++++
>   arch/arm64/boot/dts/broadcom/Makefile         |   1 +
>   .../dts/broadcom/bcm2711-rpi-cm4-canopi.dts   |   2 +
>   4 files changed, 143 insertions(+)
>   create mode 100644 arch/arm/boot/dts/bcm2711-rpi-cm4-canopi.dts
>   create mode 100644 arch/arm64/boot/dts/broadcom/bcm2711-rpi-cm4-canopi.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 05d8aef6e5d2..8930ab2c132c 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -98,6 +98,7 @@ dtb-$(CONFIG_ARCH_BCM2835) += \
>   	bcm2837-rpi-zero-2-w.dtb \
>   	bcm2711-rpi-400.dtb \
>   	bcm2711-rpi-4-b.dtb \
> +	bcm2711-rpi-cm4-canopi.dtb \
>   	bcm2711-rpi-cm4-io.dtb \
>   	bcm2835-rpi-zero.dtb \
>   	bcm2835-rpi-zero-w.dtb
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
are these LEDs really populated and wired to the BCM2711? The schematics 
suggests that they are connected to the STN2120.
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
I cannot see any graphical interface in the schematics. So why they are 
enabled?
> +
> +&i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c0_gpio44>;
> +	status = "okay";
> +	clock-frequency = <100000>;
> +
> +	pcf85063a@51 {
Please use the actual function for the node name like rtc@51
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
Without a graphical interface they shouldn't be necessary?
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
mcp251xfd0: can@0
> +		compatible = "microchip,mcp251xfd";
> +		reg = <0>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&mcp251xfd0_pins>;
> +		spi-max-frequency = <20000000>;

I wasn't good at physics, but having spi-max-frequency equal to the 
oscillator frequency seems wrong. Is it because of the hack in the 
downstream kernel which halves the SPI frequency?

Just guessing because imx6qp-prtwd3.dts uses 10 MHz.

> +		interrupt-parent = <&gpio>;
> +		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
> +		clocks = <&clk_mcp251xfd_osc>;
> +	};
> +
> +	mcp251xfd1: mcp251xfd@1 {
mcp251xfd1: can@1
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

In case there are any GPIOs which should be controlled via user space 
(like LTE or FAN control), it would be nice to describe them via 
gpio-line-names.

> +	mcp251xfd0_pins: mcp251xfd0_pins {
> +		brcm,pins = <27>;
> +		brcm,function = <BCM2835_FSEL_GPIO_IN>;
> +	};

The vendor specific pin properties are deprecated for BCM2711. We have 
generic ones for this:

mcp251xfd0_pins: mcp251xfd0_pins {
         pin-irq {
             pins = "gpio27";
             function = "gpio_in";
         };
     };

> +
> +	mcp251xfd1_pins: mcp251xfd1_pins {
> +		brcm,pins = <22>;
> +		brcm,function = <BCM2835_FSEL_GPIO_IN>;
> +	};
dito
> +};
> +
> +&vc4 {
> +	status = "okay";
> +};
I think this is also not necessary for a headless device.
> +
> +&vec {
> +	status = "disabled";
> +};
> diff --git a/arch/arm64/boot/dts/broadcom/Makefile b/arch/arm64/boot/dts/broadcom/Makefile
> index e8584d3b698f..7cd88b8c0345 100644
> --- a/arch/arm64/boot/dts/broadcom/Makefile
> +++ b/arch/arm64/boot/dts/broadcom/Makefile
> @@ -1,6 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0
>   dtb-$(CONFIG_ARCH_BCM2835) += bcm2711-rpi-400.dtb \
>   			      bcm2711-rpi-4-b.dtb \
> +			      bcm2711-rpi-cm4-canopi.dtb \
>   			      bcm2711-rpi-cm4-io.dtb \
>   			      bcm2837-rpi-3-a-plus.dtb \
>   			      bcm2837-rpi-3-b.dtb \
> diff --git a/arch/arm64/boot/dts/broadcom/bcm2711-rpi-cm4-canopi.dts b/arch/arm64/boot/dts/broadcom/bcm2711-rpi-cm4-canopi.dts
> new file mode 100644
> index 000000000000..e9369aa0eb39
> --- /dev/null
> +++ b/arch/arm64/boot/dts/broadcom/bcm2711-rpi-cm4-canopi.dts
> @@ -0,0 +1,2 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "arm/bcm2711-rpi-cm4-canopi.dts"
