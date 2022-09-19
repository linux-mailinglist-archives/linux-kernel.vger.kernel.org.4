Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEADC5BCA90
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 13:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiISLTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 07:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiISLSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 07:18:43 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F347315A10;
        Mon, 19 Sep 2022 04:18:41 -0700 (PDT)
Received: from [192.168.1.138] ([37.4.248.23]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N0WwO-1pWcAM0qCS-00wT8W; Mon, 19 Sep 2022 13:18:22 +0200
Message-ID: <354a3ef2-c2df-e8fb-da15-b2271581959b@i2se.com>
Date:   Mon, 19 Sep 2022 13:18:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ARM: dts: Add Raspberry Pi Compute Module 4 CANOPi Board
Content-Language: en-US
To:     Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, arnd@arndb.de,
        f.fainelli@gmail.com, nsaenz@kernel.org, olof@lixom.net,
        robh+dt@kernel.org, soc@kernel.org, william.zhang@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20220916153156.30412-1-ariel.dalessandro@collabora.com>
 <YygeqySPtiAEN8EH@ada.ifak-system.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <YygeqySPtiAEN8EH@ada.ifak-system.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:SpJSE1oXnkAPLm3tb9XKYnK40VVR6C6bPT2VaBgpISD9CljmcMs
 +nR/Lcr5NNq33Bukl4URqmZnYOFvbpi4+vHDq95Hy99MyNWoqYCZV02gUdBkbiQYMBm8+h/
 mGeI594nOHlsHK+JBSSeBWQUkZcOOxzWW6/KCGh63i5IDya9sRa+FhahV87kCEKk2bxvV4M
 S75Hri2YnjaK5JbfVUhHQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VwCrV8Yl8Ps=:MJ8ITIZwW0T6bVwgs8OosT
 V611IWMVLsHLzzvDJMHs/vys5Zu9lKipXlhyV3sbpLGqtRJ4B96xpSo+DxwaXU4iyGv6gR3Ia
 GTQXaPsrD8HI4SE81ewj8Qqu5KeOZk3XfMOfrFjp5o1J449zrZNHx6wpckDF7zmCsVovDZsTP
 9Ez+jwqIL+5xDPVVxJ5AMgu/yja0JU/Xbl7uB9kiJ1KJm75v6ZgzvjbNbUrOij8IqURT0/ewR
 isjzbPEQ4EwlxJVUKv8+XZ/2pd2iJLDraIStIl3h2zvt3UZqZ9Gr0esU9gPsZV6M+BvYoMTks
 H3pXK0RiTTBa2qcUUh4Y1knsSkH3QVVV5349fmmv64edBku3Xif54spFUDejZmkRHk3DJug5n
 cryG7Wqh/y149suxAswECI800zjJYsY2XDXS3oIXhoVv0tVJ2nHLzJMFMcwC+c39rXVXx4oUQ
 7a0/cJ0JEkaEIhV8lQ+q51cBk8F5SHjPGWtf6wJUsgrDZStsUSj4Z7BfEWmBgG/4BfnYHEdoq
 QS5cjRcVGpnPQfkeBW49ihi1DMqmzUmkWFfiqgDWt9ZS0iVBMhdj0Oi2H6dT0EBHUCjR52p5F
 4pENFZcRFs4EyoA8gqW8QzQODyC6R95FKKakr/aLzc95w4UdazkB5AnIma4CjRzUe+I7fbXf7
 OOlj2faAbNYXEKIco4bel7Rkc0DIaO6NkLdQ+iIV2vsdPOktke1vRxH4eJNURb9umSoBZiAeY
 Xo4IRROVu4/hfNo8vk88SdNs0r0m5znavd/cyx9wPBeVsTUjou3k1BYd45J8/JkmQgjbMvmzn
 slHbSagvWT0ZDuxwVz7FKlnUXschA==
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

[fix address of Krzysztof]

Am 19.09.22 um 09:47 schrieb Alexander Dahl:
> Hei hei,
>
> Am Fri, Sep 16, 2022 at 12:31:56PM -0300 schrieb Ariel D'Alessandro:
>> The Eclipse KUKSA CANOPi [0] is a baseboard for the Raspberry Compute
>> Module 4 (CM4). It contains a VIA VL805 4 Port USB controller and two
>> MCP251xFD based CAN-FD interfaces.
>>
>> [0] https://github.com/boschresearch/kuksa.hardware
>>
>> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
>> ---
>>   arch/arm/boot/dts/Makefile                    |   1 +
>>   arch/arm/boot/dts/bcm2711-rpi-cm4-canopi.dts  | 139 ++++++++++++++++++
>>   arch/arm64/boot/dts/broadcom/Makefile         |   1 +
>>   .../dts/broadcom/bcm2711-rpi-cm4-canopi.dts   |   2 +
>>   4 files changed, 143 insertions(+)
>>   create mode 100644 arch/arm/boot/dts/bcm2711-rpi-cm4-canopi.dts
>>   create mode 100644 arch/arm64/boot/dts/broadcom/bcm2711-rpi-cm4-canopi.dts
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index 05d8aef6e5d2..8930ab2c132c 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -98,6 +98,7 @@ dtb-$(CONFIG_ARCH_BCM2835) += \
>>   	bcm2837-rpi-zero-2-w.dtb \
>>   	bcm2711-rpi-400.dtb \
>>   	bcm2711-rpi-4-b.dtb \
>> +	bcm2711-rpi-cm4-canopi.dtb \
>>   	bcm2711-rpi-cm4-io.dtb \
>>   	bcm2835-rpi-zero.dtb \
>>   	bcm2835-rpi-zero-w.dtb
>> diff --git a/arch/arm/boot/dts/bcm2711-rpi-cm4-canopi.dts b/arch/arm/boot/dts/bcm2711-rpi-cm4-canopi.dts
>> new file mode 100644
>> index 000000000000..52ec5908883c
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/bcm2711-rpi-cm4-canopi.dts
>> @@ -0,0 +1,139 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/dts-v1/;
>> +#include "bcm2711-rpi-cm4.dtsi"
>> +
>> +/ {
>> +	model = "Raspberry Pi Compute Module 4 CANOPi Board";
>> +
>> +	clocks {
>> +		clk_mcp251xfd_osc: mcp251xfd-osc {
>> +			#clock-cells = <0>;
>> +			compatible = "fixed-clock";
>> +			clock-frequency = <20000000>;
>> +		};
>> +	};
>> +
>> +	leds {
>> +		led-act {
>> +			gpios = <&gpio 42 GPIO_ACTIVE_HIGH>;
>> +		};
>> +
>> +		led-pwr {
>> +			label = "PWR";
>> +			gpios = <&expgpio 2 GPIO_ACTIVE_LOW>;
>> +			default-state = "keep";
>> +			linux,default-trigger = "default-on";
>> +		};
>> +	};
> This looks like using the node name and the deprecated "label"
> property for LED naming.  Please see
> Documentation/devicetree/bindings/leds/common.yaml and use the
> properties "function" and "color" instead.  Also check the node names
> itself, see the example in that binding or the leds-gpio binding for
> reference.

Oops, i didn't noticed this.

Unfortunately the ACT-LED is already a little bit opaque defined in 
bcm2835-rpi.dtsi:

leds {
         compatible = "gpio-leds";

         led-act {
             label = "ACT";
             default-state = "keep";
             linux,default-trigger = "heartbeat";
         };
};

So a reference (currently missing) would have make it clear that the 
ACT-LED is common for all Raspberry Pi boards.

So you wish that this is fixed for the CANOPi board or all Raspberry Pi 
boards?

I'm asking because switching to function would change the sysfs path and 
breaking userspace ABI.

>
> Greets
> Alex
>
>> +};
>> +
>> +&ddc0 {
>> +	status = "okay";
>> +};
>> +
>> +&ddc1 {
>> +	status = "okay";
>> +};
>> +
>> +&hdmi0 {
>> +	status = "okay";
>> +};
>> +
>> +&hdmi1 {
>> +	status = "okay";
>> +};
>> +
>> +&i2c0 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&i2c0_gpio44>;
>> +	status = "okay";
>> +	clock-frequency = <100000>;
>> +
>> +	pcf85063a@51 {
>> +		compatible = "nxp,pcf85063a";
>> +		reg = <0x51>;
>> +	};
>> +};
>> +
>> +&pcie0 {
>> +	pci@0,0 {
>> +		device_type = "pci";
>> +		#address-cells = <3>;
>> +		#size-cells = <2>;
>> +		ranges;
>> +
>> +		reg = <0 0 0 0 0>;
>> +
>> +		usb@0,0 {
>> +			reg = <0 0 0 0 0>;
>> +			resets = <&reset RASPBERRYPI_FIRMWARE_RESET_ID_USB>;
>> +		};
>> +	};
>> +};
>> +
>> +&pixelvalve0 {
>> +	status = "okay";
>> +};
>> +
>> +&pixelvalve1 {
>> +	status = "okay";
>> +};
>> +
>> +&pixelvalve2 {
>> +	status = "okay";
>> +};
>> +
>> +&pixelvalve4 {
>> +	status = "okay";
>> +};
>> +
>> +&spi {
>> +	status = "okay";
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&spi0_gpio7>;
>> +	cs-gpios = <&gpio 8 1>, <&gpio 7 1>;
>> +	dmas = <&dma 6>, <&dma 7>;
>> +	dma-names = "tx", "rx";
>> +
>> +	mcp251xfd0: mcp251xfd@0 {
>> +		compatible = "microchip,mcp251xfd";
>> +		reg = <0>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&mcp251xfd0_pins>;
>> +		spi-max-frequency = <20000000>;
>> +		interrupt-parent = <&gpio>;
>> +		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
>> +		clocks = <&clk_mcp251xfd_osc>;
>> +	};
>> +
>> +	mcp251xfd1: mcp251xfd@1 {
>> +		compatible = "microchip,mcp251xfd";
>> +		reg = <1>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&mcp251xfd1_pins>;
>> +		spi-max-frequency = <20000000>;
>> +		interrupt-parent = <&gpio>;
>> +		interrupts = <22 IRQ_TYPE_LEVEL_LOW>;
>> +		clocks = <&clk_mcp251xfd_osc>;
>> +	};
>> +};
>> +
>> +&gpio {
>> +	mcp251xfd0_pins: mcp251xfd0_pins {
>> +		brcm,pins = <27>;
>> +		brcm,function = <BCM2835_FSEL_GPIO_IN>;
>> +	};
>> +
>> +	mcp251xfd1_pins: mcp251xfd1_pins {
>> +		brcm,pins = <22>;
>> +		brcm,function = <BCM2835_FSEL_GPIO_IN>;
>> +	};
>> +};
>> +
>> +&vc4 {
>> +	status = "okay";
>> +};
>> +
>> +&vec {
>> +	status = "disabled";
>> +};
>> diff --git a/arch/arm64/boot/dts/broadcom/Makefile b/arch/arm64/boot/dts/broadcom/Makefile
>> index e8584d3b698f..7cd88b8c0345 100644
>> --- a/arch/arm64/boot/dts/broadcom/Makefile
>> +++ b/arch/arm64/boot/dts/broadcom/Makefile
>> @@ -1,6 +1,7 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>   dtb-$(CONFIG_ARCH_BCM2835) += bcm2711-rpi-400.dtb \
>>   			      bcm2711-rpi-4-b.dtb \
>> +			      bcm2711-rpi-cm4-canopi.dtb \
>>   			      bcm2711-rpi-cm4-io.dtb \
>>   			      bcm2837-rpi-3-a-plus.dtb \
>>   			      bcm2837-rpi-3-b.dtb \
>> diff --git a/arch/arm64/boot/dts/broadcom/bcm2711-rpi-cm4-canopi.dts b/arch/arm64/boot/dts/broadcom/bcm2711-rpi-cm4-canopi.dts
>> new file mode 100644
>> index 000000000000..e9369aa0eb39
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/broadcom/bcm2711-rpi-cm4-canopi.dts
>> @@ -0,0 +1,2 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include "arm/bcm2711-rpi-cm4-canopi.dts"
>> -- 
>> 2.37.2
>>
