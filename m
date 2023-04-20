Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C766E8DFE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234289AbjDTJYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 05:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234045AbjDTJYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:24:04 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6603A8E;
        Thu, 20 Apr 2023 02:23:35 -0700 (PDT)
Received: from [192.168.4.220] ([84.160.205.173]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MZAvp-1pksAp24h7-00V7HZ; Thu, 20 Apr 2023 11:22:46 +0200
Message-ID: <99388c8f-a00a-f0f1-d279-24253c84dea2@in-circuit.de>
Date:   Thu, 20 Apr 2023 11:22:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 1/1] arm: dts: sunxi: Add ICnova A20 ADB4006 board
 support
Content-Language: de-DE
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     samuel@sholland.org, jernej.skrabec@gmail.com, wens@csie.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230419121229.1384024-1-ludwig.kormann@in-circuit.de>
 <20230420095735.00cbf365@donnerap.cambridge.arm.com>
From:   Ludwig Kormann <ludwig.kormann@in-circuit.de>
Organization: In-Circuit GmbH
In-Reply-To: <20230420095735.00cbf365@donnerap.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Sb4jXLQ2nImn5SrBlqYtrFOByIuwMpRA35yTtarjrJRnBQ+pwGw
 P8qQJxkA4iw0S6BpNb+bopwjsG8tNNvhDDNPos9wXE3csDs+LOrz3buITt9qxLliB6KlHIX
 elhvSQW4V+Sr7wnIJLJUtob9BrCf4kAoDVxZaACR5QHXKeRDPjlZqOSIbQq7BvfWEa5kaJd
 bq4k42yCf8IdY78+dMEsw==
UI-OutboundReport: notjunk:1;M01:P0:H5ejDJGSSUw=;FRJaifOpKCF1j6S3PsAX+mX2RKG
 TiCshoqGoyIZ6G+JEVedLjfU+DB+2RzGQ2YmTWhbfmS6rCwL7zZqJbP7zzA4cQAuXV4R1Qzm4
 Y8FnSIcD3h59p90yjWfRfvM9WMx8x0W4WYHB8vNuqVyKo2K0o8ifjyfy2sxO+Axsk+poJn31Q
 7eAZC/vYdkCx5CLkZalmsdRth5ohCusL7hoSCHigidLKTU5Ei/ciCduP4k8Tm0Kc3gVL1ai+8
 VMYswdYMA+Z9+IIqqMME19NFlxL1jcj6nGiNyPr3Re7o1mFJpITslDh5+/saQqhSU0dZEf6TL
 NiOLiWHD598UH6SXY1VpKx/+mjJqXJd3ob4wV07UCmriw+KXkLxByWqqVf/YYBJsB3nkZ5rKx
 OEAtNOLNMRuOB8xKluKsXLh3r03FuJp4c0DxdHn78PV2k5KvXbAbR+1ZVq1AY1EXCvqcf0WYd
 lbUnUbHnB5x3u9DT7dKpYpIPm4FF1nBbapSP7pVrTSUamy0UJq+zjn9fveII20hK/UTTJZ3YE
 w7O5fVK89zipzOJxwNkz+lYl2L40xWqwvTsW3NkKRYFF3/c+ciN7hJ+3c7gquq+j3aYIYRlad
 e4TwqDFEu0DNZsW9L3ydY/oVV+Qc+ezVmpg0ktDkhrwQkLVwU2JedgMGBQdgkjfTWrSIJdbHh
 Vawkxyj1e4wNvWKyAC7ZQP41s6oR8AzNkW3YQ0QBAvdu27dbXrCuhgr1oUDLpGbb6upRQrsMj
 dFmPzsrbsKrAXjYTM7bcBvyn2UDd1PVSQ==
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre,

Am 20.04.23 um 10:57 schrieb Andre Przywara:
> On Wed, 19 Apr 2023 14:12:29 +0200
> Ludwig Kormann <ludwig.kormann@in-circuit.de> wrote:
>
> Hi Ludwig,
>
> thanks for posting this!
>
>> Add board support for ICnova A20 SomPi compute module on
>> ICnova ADB4006 development board.
>>
>> Specification:
>> SoM
>> - Processor: Allwinner A20 Cortex-A7 Dual Core at 1GHz
>> - 512MB DDR3 RAM
>> - Fast Ethernet (Phy: Realtek RTL8201CP)
>> ADB4006
>> - I2C
>> - 2x USB 2.0
>> - 1x Fast Ethernet port
>> - 1x SATA
>> - 2x buttons (PWRON, Boot)
>> - 2x LEDS
>> - serial console
>> - HDMI
>> - µSD-Card slot
>> - Audio Line-In / Line-Out
>> - GPIO pinheaders
>>
>> https://wiki.in-circuit.de/index.php5?title=ICnova_ADB4006
>> https://wiki.in-circuit.de/index.php5?title=ICnova_A20_SODIMM
>>
>> ---
>>
>> changes in v2:
>> - use short licensing header
>> - remove deprecated elements from led nodes
>> - disable csi power supply
>> - add missing pins in usbphy node
>> - split dts into SoM dtsi and carrier board dts
>>
>> v1 of this patch was sent to the uboot mailing list [1].
>>
>> [1] https://lists.denx.de/pipermail/u-boot/2023-April/514605.html
>>
>> Signed-off-by: Ludwig Kormann <ludwig.kormann@in-circuit.de>
> So apart from what Krzysztof already mentioned (separate binding patch and
> stray line), this looks good to me, and passed dt-validate. Also you
> addressed all the comments I had on the U-Boot post (thanks for that), so
> with those nits above fixed:
>
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Thanks for your review! I will provide v3 in a few minutes.

kind regards,
Ludwig
> Cheers,
> Andre
>
>> ---
>>   .../devicetree/bindings/arm/sunxi.yaml        |   6 +
>>   arch/arm/boot/dts/Makefile                    |   1 +
>>   .../boot/dts/sun7i-a20-icnova-a20-adb4006.dts | 137 ++++++++++++++++++
>>   arch/arm/boot/dts/sun7i-a20-icnova-a20.dtsi   |  63 ++++++++
>>   4 files changed, 207 insertions(+)
>>   create mode 100644 arch/arm/boot/dts/sun7i-a20-icnova-a20-adb4006.dts
>>   create mode 100644 arch/arm/boot/dts/sun7i-a20-icnova-a20.dtsi
>>
>> diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
>> index 013821f4a7b8..12f0c236f17b 100644
>> --- a/Documentation/devicetree/bindings/arm/sunxi.yaml
>> +++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
>> @@ -305,6 +305,12 @@ properties:
>>             - const: allwinner,i12-tvbox
>>             - const: allwinner,sun7i-a20
>>   
>> +      - description: ICNova A20 ADB4006
>> +        items:
>> +          - const: incircuit,icnova-a20-adb4006
>> +          - const: incircuit,icnova-a20
>> +          - const: allwinner,sun7i-a20
>> +
>>         - description: ICNova A20 SWAC
>>           items:
>>             - const: incircuit,icnova-a20-swac
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index 3cc32722c394..b6b408417261 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -1321,6 +1321,7 @@ dtb-$(CONFIG_MACH_SUN7I) += \
>>   	sun7i-a20-hummingbird.dtb \
>>   	sun7i-a20-itead-ibox.dtb \
>>   	sun7i-a20-i12-tvbox.dtb \
>> +	sun7i-a20-icnova-a20-adb4006.dtb \
>>   	sun7i-a20-icnova-swac.dtb \
>>   	sun7i-a20-lamobo-r1.dtb \
>>   	sun7i-a20-linutronix-testbox-v2.dtb \
>> diff --git a/arch/arm/boot/dts/sun7i-a20-icnova-a20-adb4006.dts b/arch/arm/boot/dts/sun7i-a20-icnova-a20-adb4006.dts
>> new file mode 100644
>> index 000000000000..c1606c085e4e
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/sun7i-a20-icnova-a20-adb4006.dts
>> @@ -0,0 +1,137 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +// Copyright (C) 2023 In-Circuit GmbH
>> +
>> +/dts-v1/;
>> +
>> +#include "sun7i-a20-icnova-a20.dtsi"
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/leds/common.h>
>> +
>> +/ {
>> +	model = "In-Circuit ICnova A20 ADB4006";
>> +	compatible = "incircuit,icnova-a20-adb4006", "incircuit,icnova-a20",
>> +		     "allwinner,sun7i-a20";
>> +
>> +	aliases {
>> +		serial0 = &uart0;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial0:115200n8";
>> +	};
>> +
>> +	hdmi-connector {
>> +		compatible = "hdmi-connector";
>> +		type = "a";
>> +
>> +		port {
>> +			hdmi_con_in: endpoint {
>> +				remote-endpoint = <&hdmi_out_con>;
>> +			};
>> +		};
>> +	};
>> +
>> +	leds {
>> +		compatible = "gpio-leds";
>> +
>> +		led-0 {
>> +			function = LED_FUNCTION_POWER;
>> +			color = <LED_COLOR_ID_YELLOW>;
>> +			gpios = <&pio 7 21 GPIO_ACTIVE_HIGH>; /* PH21 */
>> +			default-state = "on";
>> +		};
>> +
>> +		led-1 {
>> +			function = LED_FUNCTION_HEARTBEAT;
>> +			color = <LED_COLOR_ID_RED>;
>> +			gpios = <&pio 7 20 GPIO_ACTIVE_HIGH>; /* PH20 */
>> +			linux,default-trigger = "heartbeat";
>> +		};
>> +	};
>> +};
>> +
>> +&ahci {
>> +	target-supply = <&reg_ahci_5v>;
>> +	status = "okay";
>> +};
>> +
>> +&codec {
>> +	status = "okay";
>> +};
>> +
>> +&de {
>> +	status = "okay";
>> +};
>> +
>> +&ehci0 {
>> +	status = "okay";
>> +};
>> +
>> +&ehci1 {
>> +	status = "okay";
>> +};
>> +
>> +&hdmi {
>> +	status = "okay";
>> +};
>> +
>> +&hdmi_out {
>> +	hdmi_out_con: endpoint {
>> +		remote-endpoint = <&hdmi_con_in>;
>> +	};
>> +};
>> +
>> +&mmc0 {
>> +	vmmc-supply = <&reg_vcc3v3>;
>> +	bus-width = <4>;
>> +	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
>> +	status = "okay";
>> +};
>> +
>> +&ohci0 {
>> +	status = "okay";
>> +};
>> +
>> +&ohci1 {
>> +	status = "okay";
>> +};
>> +
>> +&otg_sram {
>> +	status = "okay";
>> +};
>> +
>> +&reg_ahci_5v {
>> +	status = "okay";
>> +};
>> +
>> +&ac_power_supply {
>> +	status = "okay";
>> +};
>> +
>> +&reg_usb1_vbus {
>> +	status = "okay";
>> +};
>> +
>> +&reg_usb2_vbus {
>> +	status = "okay";
>> +};
>> +
>> +&uart0 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&uart0_pb_pins>;
>> +	status = "okay";
>> +};
>> +
>> +&usb_otg {
>> +	dr_mode = "otg";
>> +	status = "okay";
>> +};
>> +
>> +&usbphy {
>> +	usb0_id_det-gpios = <&pio 7 4 GPIO_ACTIVE_HIGH>; /* PH4 */
>> +	usb0_vbus_det-gpios = <&pio 7 5 GPIO_ACTIVE_HIGH>; /* PH5 */
>> +	usb1_vbus-supply = <&reg_usb1_vbus>;
>> +	usb2_vbus-supply = <&reg_usb2_vbus>;
>> +	status = "okay";
>> +};
>> diff --git a/arch/arm/boot/dts/sun7i-a20-icnova-a20.dtsi b/arch/arm/boot/dts/sun7i-a20-icnova-a20.dtsi
>> new file mode 100644
>> index 000000000000..f1142bda5cd7
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/sun7i-a20-icnova-a20.dtsi
>> @@ -0,0 +1,63 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +// Copyright (C) 2023 In-Circuit GmbH
>> +
>> +#include "sun7i-a20.dtsi"
>> +#include "sunxi-common-regulators.dtsi"
>> +
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +&cpu0 {
>> +	cpu-supply = <&reg_dcdc2>;
>> +};
>> +
>> +&gmac {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&gmac_mii_pins>;
>> +	phy-handle = <&phy1>;
>> +	phy-mode = "mii";
>> +	status = "okay";
>> +};
>> +
>> +&i2c0 {
>> +	status = "okay";
>> +
>> +	axp209: pmic@34 {
>> +		reg = <0x34>;
>> +		interrupt-parent = <&nmi_intc>;
>> +		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
>> +	};
>> +};
>> +
>> +&gmac_mdio {
>> +	phy1: ethernet-phy@1 {
>> +		reg = <1>;
>> +	};
>> +};
>> +
>> +#include "axp209.dtsi"
>> +
>> +&reg_dcdc2 {
>> +	regulator-always-on;
>> +	regulator-min-microvolt = <1000000>;
>> +	regulator-max-microvolt = <1400000>;
>> +	regulator-name = "vdd-cpu";
>> +};
>> +
>> +&reg_dcdc3 {
>> +	regulator-always-on;
>> +	regulator-min-microvolt = <1000000>;
>> +	regulator-max-microvolt = <1400000>;
>> +	regulator-name = "vdd-int-dll";
>> +};
>> +
>> +&reg_ldo1 {
>> +	regulator-name = "vdd-rtc";
>> +};
>> +
>> +&reg_ldo2 {
>> +	regulator-always-on;
>> +	regulator-min-microvolt = <3000000>;
>> +	regulator-max-microvolt = <3000000>;
>> +	regulator-name = "avcc";
>> +};
>> +
>

-- 
Dipl.-Ing. Ludwig Kormann

In-Circuit GmbH
Boltenhagener Straße 124
01109 Dresden
Germany

Phone: +49 351 42 66 850
Fax: +49 351 42 66 849
Email: ludwig.kormann@in-circuit.de
https://www.in-circuit.de/

Name der Gesellschaft: In-Circuit GmbH
Sitz der Gesellschaft: Dresden
Handelsregister : HRB 23099
Geschäftsführer : Jörg Träger
UST-ID Nr. : DE237550066

