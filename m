Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBAF6E3B2A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 20:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjDPS0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 14:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjDPS0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 14:26:21 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E1D2132
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 11:26:13 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id kt6so20426622ejb.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 11:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681669572; x=1684261572;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EABqg+N3YCRIaC4Hgz/ePg3oPQWOwoXWHt3u9z1fv84=;
        b=kh61Pan4dkwIdwo1ggUaWBF8xeQ6pDOWeweqxw0cCjeeFiYbvISRa5poKvjEpNxrkR
         DygIZVvCm/Lj9piAuY9Kdr/dYJYBNjIwLWifantmS+zdudDNgzTtAjWdy/01C9BUItHh
         xxDf/LkrJJ3LoiMJcniaQDyFmNWC4llNLNjFc41QkymsmiKfrG6FnS/qjniByUD7H4Q/
         2fBxF47XnzlLOY18EdSVcJi+S5x1kbAnrwXNb5hD7WIdv/wljKvyrkUx3hWzZ2BGLurV
         KdNTCp2iNh2eNDnh2XuGUAcPvRT8RG21K8RuqSQ1ebqWEiWCO+06Dm3kCQ6sgP+KfIZr
         Swxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681669572; x=1684261572;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EABqg+N3YCRIaC4Hgz/ePg3oPQWOwoXWHt3u9z1fv84=;
        b=fRdSNdYomxq5HXps4DbHYtKXUWI/3TfBchxL+l7B6xxkaS/e5qudU82TKEdlqTCIR/
         itlYF7q0vjy3uCjVScJyT4v0xyond1e+9ZjuudZqgE/TyfpzDDCWbv2ORFN0i7sz2Maw
         S6i/UQyabiE268NsBUeFEYDNjhNMak7/zsWGb3kKPzUfzpl9gw6h54HGSLOzsrfzih+f
         gP9FvR7DpAFKOrJG5HMILufCaOB5JEJKE+3FrlXCsGf8kd+YFL6EQT79qy9d+Dxyc3kr
         SLJdB99xv2zofiTxbBFyzOL/r/+Nzo40r/yM1tp4cuVWthjADfkm9GuOuJW4SkrXJLcK
         pf+A==
X-Gm-Message-State: AAQBX9c3tVIZGYR42BkOwDJLEblUwEx8K+xwyL8utl6amu/IrgTRzVqh
        6XbGJjzq2aBdxmuNXPbPWGyGmw==
X-Google-Smtp-Source: AKy350ZDzXmAdVpxqF4w1PQjYIl3R0H+Bo/7oND9CmlewaIX8O5g/Qr+M775YNmzF/IWJuiUEyBVjA==
X-Received: by 2002:a17:906:5384:b0:94e:c306:f42f with SMTP id g4-20020a170906538400b0094ec306f42fmr4388589ejo.16.1681669572281;
        Sun, 16 Apr 2023 11:26:12 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:f9e3:1d38:66a7:ae92? ([2a02:810d:15c0:828:f9e3:1d38:66a7:ae92])
        by smtp.gmail.com with ESMTPSA id d18-20020a170906041200b0094f0237c32bsm2990454eja.208.2023.04.16.11.26.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 11:26:11 -0700 (PDT)
Message-ID: <9aba4c1d-93f3-7613-6fb5-0591a281ec0a@linaro.org>
Date:   Sun, 16 Apr 2023 20:26:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 12/12] ARM: dts: exynos: Add Samsung Galaxy Tab 3 8.0
 boards
Content-Language: en-US
To:     Artur Weber <aweber.kernel@gmail.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
        linux-phy@lists.infradead.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230416133422.1949-1-aweber.kernel@gmail.com>
 <20230416133422.1949-13-aweber.kernel@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230416133422.1949-13-aweber.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2023 15:34, Artur Weber wrote:
> Introduce support for the Galaxy Tab 3 8.0 series of boards:
> 
>  - Samsung Galaxy Tab 3 8.0 WiFi (SM-T310/lt01wifi)
>  - Samsung Galaxy Tab 3 8.0 3G (SM-T311/lt013g)
>  - Samsung Galaxy Tab 3 8.0 LTE (SM-T315/lt01lte)
> 
> What works:
> 
>  - Display and backlight
>  - Touchscreen (without touchkeys)
>  - GPIO buttons, hall sensor
>  - WiFi and Bluetooth
>  - USB, fuel gauge, charging (partial)
>  - Accelerometer and magnetometer
>  - WiFi model only: light sensor
> 
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> ---
> Display panel bindings are added by a separate patchset:
> "[PATCH 0/3] Add Samsung S6D7AA0 panel controller driver"[1]
> 
> [1] https://lore.kernel.org/all/20230416131632.31673-1-aweber.kernel@gmail.com/
> ---
>  arch/arm/boot/dts/Makefile                  |    3 +
>  arch/arm/boot/dts/exynos4212-tab3-3g8.dts   |   30 +
>  arch/arm/boot/dts/exynos4212-tab3-lte8.dts  |   43 +
>  arch/arm/boot/dts/exynos4212-tab3-wifi8.dts |   25 +
>  arch/arm/boot/dts/exynos4212-tab3.dtsi      | 1175 +++++++++++++++++++

Your patches do not apply, so I cannot test them. Be sure you do not
bring any new dtbs_check warnings. Currently on my pending branch we are
down to four - few missing schemas.


>  5 files changed, 1276 insertions(+)
>  create mode 100644 arch/arm/boot/dts/exynos4212-tab3-3g8.dts
>  create mode 100644 arch/arm/boot/dts/exynos4212-tab3-lte8.dts
>  create mode 100644 arch/arm/boot/dts/exynos4212-tab3-wifi8.dts
>  create mode 100644 arch/arm/boot/dts/exynos4212-tab3.dtsi
> 

(...)

> +++ b/arch/arm/boot/dts/exynos4212-tab3-wifi8.dts
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Samsung's Exynos4212 based Galaxy Tab 3 8.0 WiFi board device tree
> + * source
> + *
> + * Copyright (c) 2013 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + */
> +
> +/dts-v1/;
> +#include "exynos4212-tab3.dtsi"
> +
> +/ {
> +	model = "Samsung Galaxy Tab 3 8.0 WiFi (SM-T310) based on Exynos4212";
> +	compatible = "samsung,t310", "samsung,tab3", "samsung,exynos4212", "samsung,exynos4";
> +	chassis-type = "tablet";
> +};
> +
> +&i2c_lightsensor {
> +	/* Capella Micro CM3323 color light sensor */
> +	colorsensor@10 {

light-sensor

> +		compatible = "capella,cm3323";
> +		reg = <0x10>;
> +	};
> +};
> diff --git a/arch/arm/boot/dts/exynos4212-tab3.dtsi b/arch/arm/boot/dts/exynos4212-tab3.dtsi
> new file mode 100644
> index 000000000000..b8ad5497506c
> --- /dev/null
> +++ b/arch/arm/boot/dts/exynos4212-tab3.dtsi
> @@ -0,0 +1,1175 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Samsung's Exynos4212 based Galaxy Tab 3 board common source
> + *
> + * Copyright (c) 2013 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + */
> +
> +/dts-v1/;
> +#include "exynos4212.dtsi"
> +#include "exynos4412-ppmu-common.dtsi"
> +#include "exynos-mfc-reserved-memory.dtsi"
> +#include <dt-bindings/clock/samsung,s2mps11.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/gpio-keys.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include "exynos-pinctrl.h"
> +
> +/ {
> +	compatible = "samsung,tab3", "samsung,exynos4212", "samsung,exynos4";
> +
> +	memory@40000000 {
> +		device_type = "memory";
> +
> +		/* Technically 2GB, but last 1GB is flaky, so we ignore it for now */
> +		reg = <0x40000000 0x3FC00000>;

lowercase hex, everywhere.

> +	};
> +
> +	chosen {
> +		stdout-path = &serial_2;
> +
> +		/* Default S-BOOT bootloader loads initramfs here */
> +		linux,initrd-start = <0x42000000>;
> +		linux,initrd-end = <0x42800000>;
> +	};
> +
> +	firmware@204f000 {
> +		compatible = "samsung,secure-firmware";
> +		reg = <0x0204F000 0x1000>;
> +	};
> +
> +	fixed-rate-clocks {
> +		xxti {
> +			compatible = "samsung,clock-xxti";
> +			clock-frequency = <0>;
> +		};
> +
> +		xusbxti {
> +			compatible = "samsung,clock-xusbxti";
> +			clock-frequency = <24000000>;
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&gpio_keys>;
> +
> +		key-power {
> +			gpios = <&gpx2 7 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_POWER>;
> +			label = "power";
> +			debounce-interval = <10>;
> +			wakeup-source;
> +		};
> +
> +		key-up {
> +			gpios = <&gpx2 2 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_VOLUMEUP>;
> +			label = "volume down";
> +			debounce-interval = <10>;
> +		};
> +
> +		key-down {
> +			gpios = <&gpx3 3 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_VOLUMEDOWN>;
> +			label = "volume up";
> +			debounce-interval = <10>;
> +		};
> +
> +		key-home {
> +			gpios = <&gpx1 2 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_HOME>;
> +			label = "home";
> +			debounce-interval = <10>;
> +		};
> +
> +		switch-hall-sensor {
> +			gpios = <&gpx2 4 GPIO_ACTIVE_LOW>;
> +			linux,input-type = <EV_SW>;
> +			linux,code = <SW_LID>;
> +			linux,can-disable;
> +			label = "hall effect sensor";
> +			debounce-interval = <10>;
> +			wakeup-source;
> +		};
> +	};
> +
> +	vbatt_reg: voltage-regulator-1 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VBATT";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +	};
> +
> +	backlight_reset_supply: voltage-regulator-2 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "BACKLIGHT_ENVDDIO";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&backlight_reset>;
> +		gpio = <&gpm0 1 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	lcd_enable_supply: voltage-regulator-3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "LCD_VDD_2.2V";
> +		regulator-min-microvolt = <2200000>;
> +		regulator-max-microvolt = <2200000>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&lcd_en>;
> +		gpio = <&gpc0 1 GPIO_ACTIVE_HIGH>; /* LCD_EN */
> +		enable-active-high;
> +	};
> +
> +	i2c_max77693: i2c-gpio-1 {
> +		compatible = "i2c-gpio";
> +		sda-gpios = <&gpm2 0 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +		scl-gpios = <&gpm2 1 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +		i2c-gpio,delay-us = <2>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		status = "okay";

No need for status.

> +
> +		pmic@66 {
> +			compatible = "maxim,max77693";
> +			interrupt-parent = <&gpx1>;
> +			interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&max77693_irq>;
> +			reg = <0x66>;

Put reg as after compatible.

> +
> +			regulators {
> +				esafeout1_reg: ESAFEOUT1 {
> +					regulator-name = "ESAFEOUT1";
> +					regulator-boot-on;
> +				};
> +
> +				esafeout2_reg: ESAFEOUT2 {
> +					regulator-name = "ESAFEOUT2";
> +				};
> +
> +				charger_reg: CHARGER {
> +					regulator-name = "CHARGER";
> +					regulator-min-microamp = <60000>;
> +					regulator-max-microamp = <2580000>;
> +					regulator-boot-on;
> +				};
> +			};
> +
> +			charger {
> +				compatible = "maxim,max77693-charger";
> +
> +				maxim,constant-microvolt = <4350000>;
> +				maxim,min-system-microvolt = <3600000>;
> +				maxim,thermal-regulation-celsius = <100>;
> +				maxim,battery-overcurrent-microamp = <3500000>;
> +				maxim,charge-input-threshold-microvolt = <4300000>;
> +			};
> +		};
> +	};
> +
> +	i2c_max77693_fuel: i2c-gpio-2 {
> +		compatible = "i2c-gpio";
> +		sda-gpios = <&gpy0 2 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +		scl-gpios = <&gpy0 3 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +		i2c-gpio,delay-us = <2>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		status = "okay";

Drop

> +
> +		fuel-gauge@36 {
> +			compatible = "maxim,max17050";
> +			interrupt-parent = <&gpx2>;
> +			interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&max77693_fuel_irq>;
> +			reg = <0x36>;

Put reg as after compatible.

> +
> +			maxim,over-heat-temp = <500>;
> +			maxim,over-volt = <4500>;
> +		};
> +	};
> +
> +	i2c_yas532_magnetometer: i2c-gpio-3 {

Shorter labels.

> +		compatible = "i2c-gpio";
> +		sda-gpios = <&gpy2 4 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +		scl-gpios = <&gpy2 5 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +		i2c-gpio,delay-us = <2>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		status = "okay";
> +
> +		/* Magnetometer: Yamaha YAS532 */
> +		magnetometer@2e {
> +			compatible = "yamaha,yas532";
> +			reg = <0x2e>;
> +			iovdd-supply = <&ldo3_reg>; /* VCC_1.8V_AP */
> +			mount-matrix = "-1", "0", "0",
> +					  "0", "1", "0",
> +					  "0", "0", "-1";
> +		};
> +	};
> +
> +	i2c_lightsensor: i2c-gpio-4 {
> +		compatible = "i2c-gpio";
> +		sda-gpios = <&gpl0 2 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +		scl-gpios = <&gpl0 1 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +		i2c-gpio,delay-us = <2>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		status = "okay";

Should be disabled and enabled on when users are given.

> +
> +		/* WiFi model uses CM3323, 3G/LTE use CM36653 */
> +	};
> +
> +	i2c_bl: i2c-gpio-24 {

Why 24?

> +		compatible = "i2c-gpio";
> +		sda-gpios = <&gpm4 3 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +		scl-gpios = <&gpm4 2 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		status = "okay";

Come on...

> +
> +		backlight: backlight@2c {
> +			compatible = "ti,lp8556";

You need to convert bindings to DT schema first. I don't accept any new
usages of TXT bindings anymore, sorry.

> +			reg = <0x2c>;
> +			status = "okay";
> +
> +			bl-name = "lcd-bl";
> +			dev-ctrl = /bits/ 8 <0x80>;
> +			init-brt = /bits/ 8 <0x78>; /* 120 */
> +
> +			power-supply = <&vbatt_reg>;
> +			enable-supply = <&backlight_reset_supply>;
> +
> +			pwms = <&pwm 1 78770 0>;
> +			pwm-names = "lp8556";
> +			pwm-period = <78770>;
> +
> +			rom_a3h {

No underscores in node names.
> +				rom-addr = /bits/ 8 <0xa3>;
> +				rom-val = /bits/ 8 <0x5e>;
> +			};
> +
> +			rom_a5h {
> +				rom-addr = /bits/ 8 <0xa5>;
> +				rom-val = /bits/ 8 <0x34>;
> +			};
> +
> +			rom_a7h {
> +				rom-addr = /bits/ 8 <0xa7>;
> +				rom-val = /bits/ 8 <0xfa>;
> +			};
> +		};
> +	};
> +
> +	wlan_pwrseq: sdhci3-pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		reset-gpios = <&gpm3 5 GPIO_ACTIVE_LOW>;
> +	};
> +};
> +
> +&bus_dmc {
> +	devfreq-events = <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
> +	vdd-supply = <&buck1_reg>;
> +	status = "okay";
> +};
> +
> +&bus_acp {

Order label/phandle overrides by name, so acp before dmc.

> +	devfreq = <&bus_dmc>;
> +	status = "okay";
> +};
> +
> +&bus_c2c {
> +	devfreq = <&bus_dmc>;
> +	status = "okay";
> +};
> +
> +&bus_leftbus {
> +	devfreq-events = <&ppmu_leftbus_3>, <&ppmu_rightbus_3>;
> +	vdd-supply = <&buck3_reg>;
> +	status = "okay";
> +};
> +
> +&bus_rightbus {
> +	devfreq = <&bus_leftbus>;
> +	status = "okay";
> +};
> +
> +&bus_display {
> +	devfreq = <&bus_leftbus>;
> +	status = "okay";
> +};
> +
> +&bus_fsys {
> +	devfreq = <&bus_leftbus>;
> +	status = "okay";
> +};
> +
> +&bus_peri {
> +	devfreq = <&bus_leftbus>;
> +	status = "okay";
> +};
> +
> +&bus_mfc {
> +	devfreq = <&bus_leftbus>;
> +	status = "okay";
> +};
> +
> +&cpu0 {
> +	cpu0-supply = <&buck2_reg>;
> +};
> +
> +&dsi_0 {
> +	vddcore-supply = <&ldo8_reg>;
> +	vddio-supply = <&ldo10_reg>;
> +	samsung,burst-clock-frequency = <500000000>;
> +	samsung,esc-clock-frequency = <20000000>;
> +	samsung,pll-clock-frequency = <24000000>;
> +	status = "okay";
> +
> +	panel@0 {
> +		compatible = "samsung,s6d7aa0-lsl080al02";
> +		reg = <0>;
> +		enable-supply = <&lcd_enable_supply>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&lcd_nrst>;
> +		reset-gpios = <&gpf0 4 GPIO_ACTIVE_LOW>;
> +		backlight = <&backlight>;
> +	};
> +};
> +
> +&exynos_usbphy {
> +	vbus-supply = <&esafeout1_reg>;
> +	status = "okay";
> +};
> +
> +&fimd {
> +	status = "okay";
> +};
> +
> +&gpu {
> +	mali-supply = <&buck4_reg>;
> +	status = "okay";
> +};
> +
> +&hsotg {
> +	vusb_d-supply = <&ldo15_reg>;
> +	vusb_a-supply = <&ldo12_reg>;
> +	dr_mode = "peripheral";
> +	status = "okay";
> +};
> +
> +/* Accelerometer: K2DH/K3DH */
> +&i2c_1 {
> +	pinctrl-0 = <&i2c1_bus>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	lis3dh: accelerometer@19 {
> +		/* K2DH seems to be the same as lis2dh12 in terms of registers */
> +		compatible = "st,lis2dh12-accel";
> +		reg = <0x19>;
> +
> +		interrupt-parent = <&gpx0>;
> +		interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
> +
> +		vdd-supply = <&ldo17_reg>; /* VCC_2.8V_AP */
> +		vddio-supply = <&ldo3_reg>; /* VCC_1.8V_AP */
> +
> +		mount-matrix = "-1", "0", "0",
> +				  "0", "1", "0",
> +				  "0", "0", "-1";
> +	};
> +};
> +
> +/* Touchscreen: MMS252 */
> +&i2c_3 {
> +	samsung,i2c-sda-delay = <100>;
> +	samsung,i2c-slave-addr = <0x10>;
> +	samsung,i2c-max-bus-freq = <400000>;
> +	pinctrl-0 = <&i2c3_bus>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	touchscreen@48 {
> +		/* Using mms114 compatible for now */
> +		compatible = "melfas,mms114";
> +		reg = <0x48>;
> +		interrupt-parent = <&gpb>;
> +		interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
> +		touchscreen-size-x = <800>;
> +		touchscreen-size-y = <1280>;
> +		avdd-supply = <&ldo21_reg>;
> +		vdd-supply = <&ldo25_reg>;
> +	};
> +};
> +
> +/* PMIC: s5m8767 */

Drop comment, it's obvious from the child.

> +&i2c_7 {
> +	samsung,i2c-sda-delay = <100>;
> +	samsung,i2c-slave-addr = <0x10>;
> +	samsung,i2c-max-bus-freq = <100000>;
> +	pinctrl-0 = <&i2c7_bus>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	s5m8767: pmic@66 {
> +		compatible = "samsung,s5m8767-pmic";
> +		reg = <0x66>;
> +		interrupt-parent = <&gpx0>;
> +		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&s5m8767_irq &s5m8767_dvs &s5m8767_ds>;
> +		wakeup-source;
> +
> +		s5m8767,pmic-buck2-ramp-enable;
> +		s5m8767,pmic-buck3-ramp-enable;
> +		s5m8767,pmic-buck4-ramp-enable;
> +
> +		s5m8767,pmic-buck-ramp-delay = <25>;
> +		s5m8767,pmic-buck-default-dvs-idx = <1>;
> +
> +		s5m8767,pmic-buck-dvs-gpios = <&gpm3 0 GPIO_ACTIVE_HIGH>,
> +						 <&gpm3 1 GPIO_ACTIVE_HIGH>,
> +						 <&gpm3 2 GPIO_ACTIVE_HIGH>;
> +
> +		s5m8767,pmic-buck-ds-gpios = <&gpf3 1 GPIO_ACTIVE_HIGH>,
> +						 <&gpf3 2 GPIO_ACTIVE_HIGH>,
> +						 <&gpf3 3 GPIO_ACTIVE_HIGH>;
> +
> +		s5m8767,pmic-buck2-dvs-voltage = <1100000>, <1100000>,
> +						<1100000>, <1100000>,
> +						<1100000>, <1100000>,
> +						<1100000>, <1100000>;
> +
> +		s5m8767,pmic-buck3-dvs-voltage = <1100000>, <1100000>,
> +						<1100000>, <1100000>,
> +						<1100000>, <1100000>,
> +						<1100000>, <1100000>;
> +
> +		s5m8767,pmic-buck4-dvs-voltage = <1100000>, <1100000>,
> +						<1100000>, <1100000>,
> +						<1100000>, <1100000>,
> +						<1100000>, <1100000>;
> +
> +		regulators {
> +			ldo1_reg: LDO1 {
> +				regulator-name = "VALIVE_1.0V_AP";
> +				regulator-min-microvolt = <1000000>;
> +				regulator-max-microvolt = <1000000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +				op_mode = <1>;
> +			};
> +
> +			ldo2_reg: LDO2 {
> +				regulator-name = "VM1M2_1.2V_AP";
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <1200000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +				op_mode = <1>;
> +			};
> +
> +			ldo3_reg: LDO3 {
> +				regulator-name = "VCC_1.8V_AP";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;
> +				op_mode = <1>;
> +			};
> +
> +			ldo5_reg: LDO5 {
> +				regulator-name = "VCC_3.3V_MHL";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				op_mode = <1>;
> +			};
> +
> +			ldo8_reg: LDO8 {
> +				regulator-name = "VMIPI_1.0V";
> +				regulator-min-microvolt = <1000000>;
> +				regulator-max-microvolt = <1000000>;
> +				op_mode = <3>;
> +			};
> +
> +			ldo9_reg: LDO9 {
> +				regulator-name = "VSIL_1.2V";
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <1200000>;
> +				op_mode = <1>;
> +			};
> +
> +			ldo10_reg: LDO10 {
> +				regulator-name = "VMIPI_1.8V";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				op_mode = <3>;
> +			};
> +
> +			ldo12_reg: LDO12 {
> +				regulator-name = "VUOTG_3.0V";
> +				regulator-min-microvolt = <3000000>;
> +				regulator-max-microvolt = <3000000>;
> +				op_mode = <1>;
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			ldo13_reg: LDO13 {
> +				regulator-name = "VCC_1.8V_MHL";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				op_mode = <1>;
> +			};
> +
> +			ldo15_reg: LDO15 {
> +				regulator-name = "VHSIC_1.0V";
> +				regulator-min-microvolt = <1000000>;
> +				regulator-max-microvolt = <1000000>;
> +				op_mode = <1>;
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +				};
> +			};
> +
> +			ldo17_reg: LDO17 {
> +				regulator-name = "VCC_2.8V_AP";
> +				regulator-min-microvolt = <2800000>;
> +				regulator-max-microvolt = <2800000>;
> +				op_mode = <1>;
> +				regulator-always-on;
> +			};
> +
> +			ldo19_reg: LDO19 {
> +				regulator-name = "VLED_IC_1.9V";
> +				regulator-min-microvolt = <1900000>;
> +				regulator-max-microvolt = <1900000>;
> +				op_mode = <1>;
> +				regulator-always-on;
> +			};
> +
> +			ldo20_reg: LDO20 {
> +				regulator-name = "VTOUCH_3.3V";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				op_mode = <1>;
> +			};
> +
> +			ldo21_reg: LDO21 {
> +				regulator-name = "TSP_VDD_3.3V";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				op_mode = <1>;
> +			};
> +
> +			ldo22_reg: LDO22 {
> +				regulator-name = "5M_AF_2.8V";
> +				regulator-min-microvolt = <2800000>;
> +				regulator-max-microvolt = <2800000>;
> +				op_mode = <1>;
> +			};
> +
> +			ldo23_reg: LDO23 {
> +				regulator-name = "VTF_2.8V";
> +				regulator-min-microvolt = <2800000>;
> +				regulator-max-microvolt = <2800000>;
> +				op_mode = <3>;
> +			};
> +
> +			ldo24_reg: LDO24 {
> +				regulator-name = "LEDA_2.8V";
> +				regulator-min-microvolt = <2800000>;
> +				regulator-max-microvolt = <2800000>;
> +				op_mode = <1>;
> +			};
> +
> +			ldo25_reg: LDO25 {
> +				regulator-name = "TSP_VDD_1.8V";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				op_mode = <1>;
> +			};
> +
> +			ldo26_reg: LDO26 {
> +				regulator-name = "CAM_IO_1.8V";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				op_mode = <1>;
> +			};
> +
> +			ldo27_reg: LDO27 {
> +				regulator-name = "VTCAM_1.8V";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				op_mode = <1>;
> +			};
> +
> +			buck1_reg: BUCK1 {
> +				regulator-name = "VDD_MIF";
> +				regulator-min-microvolt = <850000>;
> +				regulator-max-microvolt = <1100000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +				op_mode = <3>;
> +			};
> +
> +			buck2_reg: BUCK2 {
> +				regulator-name = "VDD_ARM";
> +				regulator-min-microvolt = <850000>;
> +				regulator-max-microvolt = <1500000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +				op_mode = <3>;
> +			};
> +
> +			buck3_reg: BUCK3 {
> +				regulator-name = "VDD_INT";
> +				regulator-min-microvolt = <850000>;
> +				regulator-max-microvolt = <1300000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +				op_mode = <3>;
> +			};
> +
> +			buck4_reg: BUCK4 {
> +				regulator-name = "VDD_G3D";
> +				regulator-min-microvolt = <850000>;
> +				regulator-max-microvolt = <1150000>;
> +				regulator-boot-on;
> +				op_mode = <3>;
> +			};
> +
> +			buck5_reg: BUCK5 {
> +				regulator-name = "VMEM_1.2V_AP";
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt	= <1200000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +				op_mode = <1>;
> +			};
> +
> +			buck6_reg: BUCK6 {
> +				regulator-name = "CAM_ISP_CORE_1.2V";
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <1200000>;
> +				op_mode = <1>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +		};
> +
> +		s5m8767_osc: clocks {
> +			compatible = "samsung,s5m8767-clk";
> +			#clock-cells = <1>;
> +			clock-output-names = "en32khz_ap",
> +						 "en32khz_cp",
> +						 "en32khz_bt";
> +		};
> +	};
> +};
> +
> +&mshc_0 {
> +	broken-cd;
> +	non-removable;
> +	card-detect-delay = <200>;
> +	vmmc-supply = <&ldo22_reg>;
> +	clock-frequency = <400000000>;
> +	samsung,dw-mshc-ciu-div = <0>;
> +	samsung,dw-mshc-sdr-timing = <2 3>;
> +	samsung,dw-mshc-ddr-timing = <1 2>;
> +	pinctrl-0 = <&sd4_clk &sd4_cmd &sd4_bus4 &sd4_bus8>;
> +	pinctrl-names = "default";
> +	status = "okay";

Put the status last.

> +	bus-width = <8>;
> +	cap-mmc-highspeed;
> +};
> +
> +&pinctrl_0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sleep0>;
> +
> +	s5m8767_ds: s5m8767-ds {

Does not look like you tested the DTS against bindings. Please run `make
dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
for instructions).

I stop review as for sure this was not tested against bindings.

Best regards,
Krzysztof

