Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7613E67363F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 12:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjASLAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 06:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjASLAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 06:00:46 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9282F4A1C0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 03:00:43 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id b5so1511864wrn.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 03:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LXk6KWxoWyxX2ygaT+k9mbzorhZfE9CfYaGcC2xlaQU=;
        b=hROn0AeU1HQSs54gTmkYhGzWClLIEQs0DJbYpLOYEo3A/K7AkeKpaZwiTsookMKrCr
         xMWwsqdQ9dw0J7JP7V6sLbi2l+Ox+5bUY/TwHOWsFP5NR+MCpvVlHuHP24l+4NL1DKF5
         iTSQDAn30WIaXlurzjr5tztpRYkP5ZGvnSxlFNxbi/Da+aUUW6fbEDRrc0n7zCxXat2J
         AqyTtSTXwzmRuyRysBNrkOappv2FvzX+3kcVD1zeC4Nzdzk/PVx9y4zmR1YBW+qjBcgI
         mZSJKVdINVLsEIr4+2eQnyTSJaW+NxwXSumXHH2aLwOPVpzj7v8QEefosHMLZO5nc9/E
         NneQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LXk6KWxoWyxX2ygaT+k9mbzorhZfE9CfYaGcC2xlaQU=;
        b=NNE7XusUAXEUHOyIZaSrxipyDz19XruGXTnyHxlNt7u7iaqKm8GQUIu8xxAlleDjSc
         SYypFo0FUtqtP9JwbxbDGods9h5uOPqDGQ+9D+lw26ueunOtLhE0MAwWbCMG57m08Q+m
         m0Kq92Y/J+PxUA6tk7O20sdKQeIQ935BtdqERiao3Aiv2vsMF/HxmO2uGNCEQudFrDov
         AtjXr/uAvVDk5FS91LgX0ZUgRHSUi7zx2795HaDpPkL9i2NuTe8Sw5H1ezInTB0s9xS/
         IerQZB2XHmDnsPge6zN5tlZky47Ntc3uTVeAs+R1HTHTl7gQJj4VBWryaQ5Lv4KTpF9D
         YVng==
X-Gm-Message-State: AFqh2ko+YCDsPIyv2IvUWjTb/fB9N5R8A5mkq+ek5nJ6xkVs6B8E05sJ
        ZxtmCdJwtllb5sXVMhgKk+m5i2Kd98TdUdO9
X-Google-Smtp-Source: AMrXdXu8ls7sGQQwz9tXli0ikpBl9CITac5QqrKVYoWTOhQfTzoU8Rx02NEDtVM5n07LQvJ9CfQDLA==
X-Received: by 2002:a5d:4ac2:0:b0:2bd:d898:6239 with SMTP id y2-20020a5d4ac2000000b002bdd8986239mr8680332wrs.3.1674126042124;
        Thu, 19 Jan 2023 03:00:42 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f3-20020adfdb43000000b00236883f2f5csm34030045wrj.94.2023.01.19.03.00.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 03:00:41 -0800 (PST)
Message-ID: <3e242c03-f8fd-2136-0263-2306acb9f610@linaro.org>
Date:   Thu, 19 Jan 2023 12:00:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 3/3] ARM: dts: aspeed: Add device tree for Ufispace
 NCPLite BMC
Content-Language: en-US
To:     Jordan Chang <jordan.chang@ufispace.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        robh+dt@kernel.org
Cc:     jay.tc.lin@ufispace.com, eason.ys.huang@ufispace.com
References: <20230119102102.73414-1-jordan.chang@ufispace.com>
 <20230119102102.73414-4-jordan.chang@ufispace.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230119102102.73414-4-jordan.chang@ufispace.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,WEIRD_QUOTING autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/2023 11:21, Jordan Chang wrote:
> Add initial version of device tree for Ufispace NCPlite platform
> which is equipped with AST2600-based BMC.
> 
> Signed-off-by: Jordan Chang <jordan.chang@ufispace.com>
> ---
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../boot/dts/aspeed-bmc-ufispace-ncplite.dts  | 360 ++++++++++++++++++
>  2 files changed, 361 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-ufispace-ncplite.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 2ee9c043218b..d26e0651e805 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1626,6 +1626,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>  	aspeed-bmc-inventec-transformers.dtb \
>  	aspeed-bmc-tyan-s7106.dtb \
>  	aspeed-bmc-tyan-s8036.dtb \
> +	aspeed-bmc-ufispace-ncplite.dtb \
>  	aspeed-bmc-vegman-n110.dtb \
>  	aspeed-bmc-vegman-rx20.dtb \
>  	aspeed-bmc-vegman-sx20.dtb
> diff --git a/arch/arm/boot/dts/aspeed-bmc-ufispace-ncplite.dts b/arch/arm/boot/dts/aspeed-bmc-ufispace-ncplite.dts
> new file mode 100644
> index 000000000000..7ab29129d1e4
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed-bmc-ufispace-ncplite.dts
> @@ -0,0 +1,360 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright (c) 2022 Ufispace Co., Ltd.
> +/dts-v1/;
> +
> +#include "aspeed-g6.dtsi"
> +#include <dt-bindings/i2c/i2c.h>
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +
> +/ {
> +	model = "Ufispace NCPLite BMC";
> +	compatible = "ufispace,ncplite-bmc", "aspeed,ast2600";
> +
> +	aliases {
> +		serial4 = &uart5;
> +	};
> +
> +	chosen {
> +		stdout-path = &uart5;
> +		bootargs = "console=ttyS4,115200n8 earlycon";

earlycon is debugging tool and not suitable for mainline, wide usage. Drop.

Actually drop entire bootags and use proper stdout-path.

> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x80000000 0x80000000>;
> +	};
> +
> +	iio-hwmon {
> +		compatible = "iio-hwmon";
> +		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
> +			      <&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
> +			      <&adc1 0>, <&adc1 1>, <&adc1 2>, <&adc1 3>,
> +			      <&adc1 4>, <&adc1 5>, <&adc1 6>, <&adc1 7>;
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		fan-status-int-l {

Does not look like you tested the DTS against bindings. Please run `make
dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
for instructions).

These will bring warnings. Missing generic name,

> +			label = "fan-status-int-l";
> +			gpios = <&gpio0 ASPEED_GPIO(M, 2) GPIO_ACTIVE_LOW>;
> +			linux,code = <ASPEED_GPIO(M, 2)>;
> +		};
> +
> +		allpwr-good {
> +			label = "allpwr-good";
> +			gpios = <&gpio0 ASPEED_GPIO(V, 4) GPIO_ACTIVE_HIGH>;
> +			linux,code = <ASPEED_GPIO(V, 4)>;
> +		};
> +
> +		psu0-alert-n {
> +			label = "psu0-alert-n";
> +			gpios = <&gpio0 ASPEED_GPIO(V, 1) GPIO_ACTIVE_LOW>;
> +			linux,code = <ASPEED_GPIO(V, 1)>;
> +		};
> +
> +		psu1-alert-n {
> +			label = "psu1-alert-n";
> +			gpios = <&gpio0 ASPEED_GPIO(V, 2) GPIO_ACTIVE_LOW>;
> +			linux,code = <ASPEED_GPIO(V, 2)>;
> +		};
> +
> +		int-thermal-alert {
> +			label = "int-thermal-alert";
> +			gpios = <&gpio0 ASPEED_GPIO(P, 2) GPIO_ACTIVE_LOW>;
> +			linux,code = <ASPEED_GPIO(P, 2)>;
> +		};
> +
> +		cpu-caterr-l {
> +			label = "cpu-caterr-l";
> +			gpios = <&gpio0 ASPEED_GPIO(N, 3) GPIO_ACTIVE_LOW>;
> +			linux,code = <ASPEED_GPIO(N, 3)>;
> +		};
> +
> +		cpu-thermtrip-l {
> +			label = "cpu-thermtrip-l";
> +			gpios = <&gpio0 ASPEED_GPIO(V, 5) GPIO_ACTIVE_LOW>;
> +			linux,code = <ASPEED_GPIO(V, 5)>;
> +		};
> +
> +		psu0-presence-l {
> +			label = "psu0-presence-l";
> +			gpios = <&gpio0 ASPEED_GPIO(F, 6) GPIO_ACTIVE_LOW>;
> +			linux,code = <ASPEED_GPIO(F, 6)>;
> +		};
> +
> +		psu1-presence-l {
> +			label = "psu1-presence-l";
> +			gpios = <&gpio0 ASPEED_GPIO(F, 7) GPIO_ACTIVE_LOW>;
> +			linux,code = <ASPEED_GPIO(F, 7)>;
> +		};
> +
> +		psu0-power-ok {
> +			label = "psu0-power-ok";
> +			gpios = <&gpio0 ASPEED_GPIO(M, 4) GPIO_ACTIVE_HIGH>;
> +			linux,code = <ASPEED_GPIO(M, 4)>;
> +		};
> +
> +		psu1-power-ok {
> +			label = "psu1-power-ok";
> +			gpios = <&gpio0 ASPEED_GPIO(M, 5) GPIO_ACTIVE_HIGH>;
> +			linux,code = <ASPEED_GPIO(M, 5)>;
> +		};
> +	};
> +
> +	gpio-keys-polled {
> +		compatible = "gpio-keys-polled";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		poll-interval = <1000>;
> +
> +		fan0-presence {

Same problem - not tested.

> +			label = "fan0-presence";
> +			gpios = <&fan_ioexp 2 GPIO_ACTIVE_LOW>;
> +			linux,code = <2>;
> +		};
> +
> +		fan1-presence {
> +			label = "fan1-presence";
> +			gpios = <&fan_ioexp 6 GPIO_ACTIVE_LOW>;
> +			linux,code = <6>;
> +		};
> +
> +		fan2-presence {
> +			label = "fan2-presence";
> +			gpios = <&fan_ioexp 10 GPIO_ACTIVE_LOW>;
> +			linux,code = <10>;
> +		};
> +
> +		fan3-presence {
> +			label = "fan3-presence";
> +			gpios = <&fan_ioexp 14 GPIO_ACTIVE_LOW>;
> +			linux,code = <14>;
> +		};
> +	};
> +};
> +
> +&mac2 {
> +	status = "okay";
> +	use-ncsi;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rmii3_default>;
> +	clocks = <&syscon ASPEED_CLK_GATE_MAC3CLK>,
> +		 <&syscon ASPEED_CLK_MAC3RCLK>;
> +	clock-names = "MACCLK", "RCLK";
> +};
> +
> +&fmc {
> +	status = "okay";
> +	flash@0 {
> +		status = "okay";
> +		m25p,fast-read;
> +		label = "bmc";
> +		spi-max-frequency = <50000000>;
> +#include "openbmc-flash-layout-64.dtsi"
> +	};
> +
> +	flash@1 {
> +		status = "okay";
> +		m25p,fast-read;
> +		label = "alt-bmc";
> +		spi-max-frequency = <50000000>;
> +#include "openbmc-flash-layout-64-alt.dtsi"
> +	};
> +};
> +
> +&uart1 {
> +	status = "okay";
> +};
> +
> +&uart4 {
> +	status = "okay";
> +};
> +
> +&uart5 {
> +	status = "okay";
> +};
> +
> +&kcs3 {
> +	status = "okay";
> +	aspeed,lpc-io-reg = <0xca2>;
> +};
> +
> +&lpc_reset {
> +	status = "okay";
> +};
> +
> +&lpc_ctrl {
> +	status = "okay";
> +};
> +
> +&uart_routing {
> +	status = "okay";
> +};
> +
> +&wdt1 {
> +	status = "okay";
> +};
> +
> +&wdt2 {
> +	status = "okay";
> +};
> +
> +&peci0 {
> +	status = "okay";
> +};
> +
> +&udc {
> +	status = "okay";
> +};
> +
> +&adc0 {
> +	vref = <2500>;
> +	status = "okay";
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
> +		&pinctrl_adc2_default &pinctrl_adc3_default
> +		&pinctrl_adc4_default &pinctrl_adc5_default
> +		&pinctrl_adc6_default &pinctrl_adc7_default>;
> +};
> +
> +&adc1 {
> +	vref = <2500>;
> +	status = "okay";
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default
> +		&pinctrl_adc10_default &pinctrl_adc11_default
> +		&pinctrl_adc12_default &pinctrl_adc13_default
> +		&pinctrl_adc14_default &pinctrl_adc15_default>;
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +
> +	lm75@48 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +		compatible = "national,lm75";
> +		reg = <0x48>;
> +	};
> +
> +	lm75@49 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +		compatible = "national,lm75";
> +		reg = <0x49>;
> +	};
> +
> +	lm86@4c {

and so on...

> +		compatible = "national,lm86";
> +		reg = <0x4c>;
> +	};
> +};
> +
> +&i2c2 {
> +	status = "okay";
> +
> +	lm75@4f {

as well

> +		cpmpatible = "national,lm75";
> +		reg = <0x4f>;
> +	};
> +
> +	fan_ioexp: pca9535@20 {

and here

> +		compatible = "nxp,pca9535";
> +		reg = <0x20>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		gpio-line-names =
> +		"","","presence-fan0","",
> +		"","","presence-fan1","",
> +		"","","presence-fan2","",
> +		"","","presence-fan3","";
> +	};
> +};
> +
> +&i2c3 {
> +	status = "okay";
> +
> +	eeprom@50 {
> +		compatible = "atmel,24c128";
> +		reg = <0x50>;
> +		pagesize = <64>;
> +	};
> +};
> +
> +&i2c4 {
> +	status = "okay";
> +
> +	psu@58 {
> +		compatible = "pmbus";

Where is this compatible documented?

Did you run checkpatch? Did it pass without warnings?


> +		reg = <0x58>;
> +	};
> +
> +	eeprom@50 {
> +		compatible = "atmel,24c02";
> +		reg = <0x50>;
> +		pagesize = <1>;
> +	};
> +};
> +
> +&i2c5 {
> +	status = "okay";
> +
> +	psu@58 {
> +		compatible = "pmbus";
> +		reg = <0x58>;
> +	};
> +
> +	eeprom@50 {
> +		compatible = "atmel,24c02";
> +		reg = <0x50>;
> +		pagesize = <1>;
> +	};
> +};
> +
> +&i2c8 {
> +	status = "okay";
> +};
> +
> +&i2c10 {
> +	status = "okay";
> +
> +	lm75@4d {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +		compatible = "national,lm75";
> +		reg = <0x4d>;
> +	};
> +};
Best regards,
Krzysztof

