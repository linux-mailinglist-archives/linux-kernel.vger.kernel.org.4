Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CCB5B9E83
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 17:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbiIOPOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 11:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbiIOPON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 11:14:13 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCBD9F8FE
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 08:08:19 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n35-20020a05600c502300b003b4924c6868so3956439wmr.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 08:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=9mQUaPNceis8qparWDkrLv2BKnQ9SmM81stuAhhbzew=;
        b=LsQo2JpTUkhTzfuDrJ9y/4GnGKTFwHW/PSWLYrWtomRbBWYjPZM14GvphXRuD7cPBp
         k3JZ+7US/WNPMpgGXXwWecEDpG/BAvoYLpVJKNKVvQr+ezEuGx4gzqSMsVaF/Uotbwpj
         dF3HxM8tD1HpTdAuiw4AdS00lvRWOBZP/FAQ1ekdtvTTikxyAoXPGZT/ocVSemAbMnV+
         XFbG2AKYu/mvIPw9EgzPG2cLjvqbHSDNeXELIuoYPpjCeehPx5EN7xVHiyZDO/J8ArY7
         iPln6G8fXhIaBuBbEARnBetbMcZrFpMkLXHmfmpqC3fCdbp0gi6CVp9TCgKi0/CLPxg9
         vk8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=9mQUaPNceis8qparWDkrLv2BKnQ9SmM81stuAhhbzew=;
        b=kQXSEJAzFAkpdmNfSRISsOWmAqZujcvvXpA6BYK5SnxAXfXaX3ti8LQhxlWlyxlitz
         pyrOt9rQBehRAenWm2dulCg6c45Y57iWpo7+HMxWr6NvPwErafpcBONoLp0JKB06v9Zk
         WZQbr1uWKB5ZvWgA/Qx2ma2RU3U5a83Vp5qlP6CGu1GhXOayMnpVvyyMPt9/tFjvCWTE
         k7G+NXz+Uqv0SeWpdnuc0poO8D0w6SmRBVyB5qSAK1CxTK4r09tGbD3svZckJwtu7Mcb
         2T7nsvbfacXc3BMuQUF1FdrctAQ6E4dhns5Zu+MbXkFYYAPKA9dyCErTej8UAU3b17qS
         6qdA==
X-Gm-Message-State: ACgBeo2SU3MF8AemqqxD8qqKpMOsTxefs3OgtLsXSjqkKFJ3baNQJc9a
        hhstPzU/xWUKzhcIhwWTZDB4eg==
X-Google-Smtp-Source: AA6agR7MonZjlHNMXwe0IaiZO8G7Nw83j+6yzFvN9UU8Qb8D8xG5Ma8HaDtaJ4b0KHXmzJd/VpiUAw==
X-Received: by 2002:a05:600c:4c22:b0:3b4:766a:4f76 with SMTP id d34-20020a05600c4c2200b003b4766a4f76mr6708741wmp.101.1663254475376;
        Thu, 15 Sep 2022 08:07:55 -0700 (PDT)
Received: from [10.119.22.201] ([89.101.193.72])
        by smtp.gmail.com with ESMTPSA id h4-20020a5d5044000000b00228d67db06esm2904974wrt.21.2022.09.15.08.07.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Sep 2022 08:07:54 -0700 (PDT)
Message-ID: <c46fd424-3517-9f66-dc8c-ed10ca3ef622@linaro.org>
Date:   Thu, 15 Sep 2022 16:07:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] Changes phy configuration to expose sata in place of usb3
 on quartz64-a board
Content-Language: en-US
To:     Alessandro Carminati <alessandro.carminati@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <YyIyo42QWvgJTBjL@lab.hqhome163.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YyIyo42QWvgJTBjL@lab.hqhome163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2022 20:59, Alessandro Carminati wrote:
> The Quartz64 board is built upon Rockchip RK3566.
> Rockchip RK3566 has two combo phys.
> The first connects USB3 and SATA ctrl1, and the second PCIe lane and SATA
> ctrl2.
> The second combo phy is hardwired to the PCIe slot, where for the first,
> the hardware on the board provides both the USB3 connector and the SATA
> connector.
> This DT allows the users to switch the combo phy to the SATA connector.
> 
> Signed-off-by: Alessandro Carminati <alessandro.carminati@gmail.com>
> ---
>  .../dts/rockchip/rk3566-quartz64-a.sata.dts   | 839 ++++++++++++++++++
>  1 file changed, 839 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.sata.dts
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.sata.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.sata.dts
> new file mode 100644
> index 000000000000..6ac21b729be7
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.sata.dts
> @@ -0,0 +1,839 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/pinctrl/rockchip.h>
> +#include <dt-bindings/soc/rockchip,vop2.h>
> +#include "rk3566.dtsi"
> +
> +/ {
> +	model = "Pine64 RK3566 Quartz64-A Board";
> +	compatible = "pine64,quartz64-a", "rockchip,rk3566";
> +
> +	aliases {
> +		ethernet0 = &gmac1;
> +		mmc0 = &sdmmc0;
> +		mmc1 = &sdhci;
> +	};
> +
> +	chosen: chosen {
> +		stdout-path = "serial2:1500000n8";
> +	};
> +
> +	gmac1_clkin: external-gmac1-clock {
> +		compatible = "fixed-clock";
> +		clock-frequency = <125000000>;
> +		clock-output-names = "gmac1_clkin";
> +		#clock-cells = <0>;
> +	};
> +
> +	fan: gpio_fan {

No underscores in node names. Node name just "fan"

> +		compatible = "gpio-fan";
> +		gpios = <&gpio0 RK_PD5 GPIO_ACTIVE_HIGH>;
> +		gpio-fan,speed-map = <0    0
> +				      4500 1>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&fan_en_h>;
> +		#cooling-cells = <2>;
> +	};
> +
> +	hdmi-con {

Node name: connector

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
> +		led-work {
> +			label = "work-led";
> +			default-state = "off";
> +			gpios = <&gpio0 RK_PD3 GPIO_ACTIVE_HIGH>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&work_led_enable_h>;
> +			retain-state-suspended;
> +		};
> +
> +		led-diy {
> +			label = "diy-led";
> +			default-state = "on";
> +			gpios = <&gpio0 RK_PD4 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&diy_led_enable_h>;
> +			retain-state-suspended;
> +		};
> +	};
> +
> +	rk817-sound {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,format = "i2s";
> +		simple-audio-card,name = "Analog RK817";
> +		simple-audio-card,mclk-fs = <256>;
> +
> +		simple-audio-card,cpu {
> +			sound-dai = <&i2s1_8ch>;
> +		};
> +
> +		simple-audio-card,codec {
> +			sound-dai = <&rk817>;
> +		};
> +	};
> +
> +	sdio_pwrseq: sdio-pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		clocks = <&rk817 1>;
> +		clock-names = "ext_clock";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&wifi_enable_h>;
> +		post-power-on-delay-ms = <100>;
> +		power-off-delay-us = <5000000>;
> +		reset-gpios = <&gpio2 RK_PC2 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	spdif_dit: spdif-dit {
> +		compatible = "linux,spdif-dit";
> +		#sound-dai-cells = <0>;
> +	};
> +
> +	spdif_sound: spdif-sound {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,name = "SPDIF";
> +
> +		simple-audio-card,cpu {
> +			sound-dai = <&spdif>;
> +		};
> +
> +		simple-audio-card,codec {
> +			sound-dai = <&spdif_dit>;
> +		};
> +	};
> +
> +	vcc12v_dcin: vcc12v_dcin {

No underscores in node names, generic node name, so at least with
regulator prefix or suffix.

> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc12v_dcin";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;
> +	};
> +
> +	/* vbus feeds the rk817 usb input.
> +	 * With no battery attached, also feeds vcc_bat+
> +	 * via ON/OFF_BAT jumper
> +	 */
> +	vbus: vbus {

Ditto

> +		compatible = "regulator-fixed";
> +		regulator-name = "vbus";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc12v_dcin>;
> +	};
> +
> +	vcc3v3_pcie_p: vcc3v3-pcie-p-regulator {

And here you have suffix...

> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio0 RK_PC6 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pcie_enable_h>;
> +		regulator-name = "vcc3v3_pcie_p";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc_3v3>;
> +	};
> +
> +	vcc5v0_usb: vcc5v0_usb {

Ditto

> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_usb";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc12v_dcin>;
> +	};
> +
> +	/* all four ports are controlled by one gpio
> +	 * the host ports are sourced from vcc5v0_usb
> +	 * the otg port is sourced from vcc5v0_midu
> +	 */
> +	vcc5v0_usb20_host: vcc5v0_usb20_host {

and in other places as well



> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio4 RK_PB5 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vcc5v0_usb20_host_en>;
> +		regulator-name = "vcc5v0_usb20_host";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc5v0_usb>;
> +	};
> +
> +	vcc5v0_usb20_otg: vcc5v0_usb20_otg {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio4 RK_PB5 GPIO_ACTIVE_HIGH>;
> +		regulator-name = "vcc5v0_usb20_otg";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&dcdc_boost>;
> +	};
> +
> +	vcc3v3_sd: vcc3v3_sd {
> +		compatible = "regulator-fixed";
> +		enable-active-low;
> +		gpio = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vcc_sd_h>;
> +		regulator-boot-on;
> +		regulator-name = "vcc3v3_sd";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc_3v3>;
> +	};
> +
> +	/* sourced from vbus and vcc_bat+ via rk817 sw5 */
> +	vcc_sys: vcc_sys {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <4400000>;
> +		regulator-max-microvolt = <4400000>;
> +		vin-supply = <&vbus>;
> +	};
> +
> +	/* sourced from vcc_sys, sdio module operates internally at 3.3v */
> +	vcc_wl: vcc_wl {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_wl";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc_sys>;
> +	};
> +};
> +
> +&combphy1 {
> +	status = "okay";
> +};
> +
> +&combphy2 {
> +	status = "okay";
> +};
> +
> +&cpu0 {
> +	cpu-supply = <&vdd_cpu>;
> +};
> +
> +&cpu1 {
> +	cpu-supply = <&vdd_cpu>;
> +};
> +
> +&cpu2 {
> +	cpu-supply = <&vdd_cpu>;
> +};
> +
> +&cpu3 {
> +	cpu-supply = <&vdd_cpu>;
> +};
> +
> +&cpu_thermal {
> +	trips {
> +		cpu_hot: cpu_hot {

No underscores in node names. Are you sure bindings/schema do not expect
some specific name?

> +			temperature = <55000>;
> +			hysteresis = <2000>;
> +			type = "active";
> +		};
> +	};


Best regards,
Krzysztof
