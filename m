Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42585F616B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 09:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiJFHKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 03:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiJFHK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 03:10:27 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFCC42AFB
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 00:10:25 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id by36so1186330ljb.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 00:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=2I/1QzQAyhs03U6EUbvdD9mrpDPgHGLdtO/kjkRzvpE=;
        b=PMmRUTc4YkNKV0tKu19tFM5wTJveTHPgqco/cfnP78Q1gRa5s/fGleDx+6TmialXfe
         AqEBUqEmNp2wZoGoZL9spUrszdbqPhgQVt0bn+tsNHtszuBW5cVNyk+LHXs6pHSFhCak
         56zoya76Gx8eDzbgSKEfldJiRyzHFyqpU8llVFy0WQjMXo858HCHwbnqASR8vPndWT8W
         iXnqcgRoMK12cGQgFRZbOjdyyFLuZbvP8BU+1Fmpk9NPGVthn00q9vtG5EQ54E0H2ujd
         5w+d/Hg7m/FsLITyoDvFvKxBqwK5cC1d6uNJMiNuFOR9tGA+iXhUaM8DjvkytS9q9W99
         Sz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=2I/1QzQAyhs03U6EUbvdD9mrpDPgHGLdtO/kjkRzvpE=;
        b=K//m979uDJ5Pyl8XabL21+0LKi4eeDDTIonEZTlnfnfIXr5z5kph/E0TZ5gPIC9B6I
         R1+u1UId9dxRVnoak9fm8Y11reFhfKdrAKK2y4CnpMtGdF9RiyZWzv923mZ+gJt/EAiu
         0iwPAKL+oBLG57uUApF++97azsT09KuHYEo/WgxQ4g7aVjBii0YgnZmFGacXJBWTmNph
         6vj6gbaQogLsWT/9NsCE0TvrB8D1qk+0NRXKwiIzi9F9EaY4e5poqFjdjyH9pMi91lsS
         mRBt73kVC4+o7kWd/wHP148tzpOS5/GAJBc3tpyYamI6lZYXaZbAMOp3zRkSKABrji23
         OTCg==
X-Gm-Message-State: ACrzQf2Mkq9RmcWzG2HWZrnVmGUIPE14jd2KFgPEGWQrJ9zl28BI/jr7
        PpB6kkcyMe2C57mYTZ+eJLrOxAUug8pDMw==
X-Google-Smtp-Source: AMsMyM7t0L4tSiNO8/WleoyInpCKagr+hmERnfJ+UdQDQjy3KxVKaSqD+N7nG5HG3VYX5V/Ybo67vw==
X-Received: by 2002:a2e:be9e:0:b0:26c:2d48:5c98 with SMTP id a30-20020a2ebe9e000000b0026c2d485c98mr1226092ljr.395.1665040223888;
        Thu, 06 Oct 2022 00:10:23 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id x6-20020ac24886000000b00498f570aef2sm2604118lfc.209.2022.10.06.00.10.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 00:10:23 -0700 (PDT)
Message-ID: <a8854c8e-8868-461d-9f7b-d5b44f7288c7@linaro.org>
Date:   Thu, 6 Oct 2022 09:10:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v1 2/2] greatlakes: dts: Add Facebook greatlakes (AST2600)
 BMC
Content-Language: en-US
To:     Delphine CC Chiu <Delphine_CC_Chiu@Wiwynn.com>,
        krzysztof.kozlowski@linaro.or
Cc:     patrick@stwcx.xyz, garnermic@fb.com, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org
References: <20221006063527.2007802-1-Delphine_CC_Chiu@Wiwynn.com>
 <20221006063527.2007802-2-Delphine_CC_Chiu@Wiwynn.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221006063527.2007802-2-Delphine_CC_Chiu@Wiwynn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/2022 08:35, Delphine CC Chiu wrote:
> Add linux device tree entry related to
> greatlakes specific devices connected to BMC SoC.
> 
> ---
> --- v1 - Add documentation of board compatible (bindings)
> ---    - Add board compatible
> ---    - Remove the bootargs
> ---    - Revise the DTS node name
> ---

This is v3, not v1, because you resent first patch twice Changelog does
not go above SoB. You can see the problem easily - save your patch, git
am xxx.mbox, git show

Subject is wrong. Use subject prefixes matching the subsystem (git log
--oneline -- ...).


> 
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@Wiwynn.com>
> ---
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../dts/aspeed-bmc-facebook-greatlakes.dts    | 243 ++++++++++++++++++
>  2 files changed, 244 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 05d8aef6e5d2..d9f417f2d7df 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1586,6 +1586,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>  	aspeed-bmc-facebook-elbert.dtb \
>  	aspeed-bmc-facebook-fuji.dtb \
>  	aspeed-bmc-facebook-galaxy100.dtb \
> +	aspeed-bmc-facebook-greatlakes.dtb \
>  	aspeed-bmc-facebook-minipack.dtb \
>  	aspeed-bmc-facebook-tiogapass.dtb \
>  	aspeed-bmc-facebook-wedge40.dtb \
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts
> new file mode 100644
> index 000000000000..29c46d0e003e
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts
> @@ -0,0 +1,243 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright 2022 Facebook Inc.
> +
> +/dts-v1/;
> +#include "aspeed-g6.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +#include <dt-bindings/leds/leds-pca955x.h>
> +#include <dt-bindings/i2c/i2c.h>
> +
> +/ {
> +	model = "Facebook Greatlakes BMC";
> +	compatible = "facebook,greatlakes-bmc", "aspeed,ast2600";
> +
> +	aliases {
> +		serial4 = &uart5;
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
> +				<&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
> +				<&adc1 0>, <&adc1 2>, <&adc1 3>, <&adc1 4>,
> +				<&adc1 5>, <&adc1 6>;
> +	};
> +};
> +
> +&uart1 {
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	status = "okay";
> +};
> +
> +&uart3 {
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
> +&wdt1 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_wdtrst1_default>;
> +	aspeed,reset-type = "soc";
> +	aspeed,external-signal;
> +	aspeed,ext-push-pull;
> +	aspeed,ext-active-high;
> +	aspeed,ext-pulse-duration = <256>;
> +};
> +
> +&mac3 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rmii4_default>;
> +	no-hw-checksum;
> +	use-ncsi;
> +	mlx,multi-host;
> +	ncsi-ctrl,start-redo-probe;
> +	ncsi-ctrl,no-channel-monitor;
> +	ncsi-package = <1>;
> +	ncsi-channel = <1>;
> +	ncsi-rexmit = <1>;
> +	ncsi-timeout = <2>;
> +};
> +
> +&rtc {
> +	status = "okay";
> +};
> +
> +&fmc {
> +	status = "okay";
> +	flash@0 {
> +		status = "okay";
> +		m25p,fast-read;
> +		label = "bmc";
> +		spi-rx-bus-width = <4>;
> +		spi-max-frequency = <50000000>;
> +#include "openbmc-flash-layout-64.dtsi"
> +	};
> +	flash@1 {
> +		status = "okay";
> +		m25p,fast-read;
> +		label = "bmc2";
> +		spi-rx-bus-width = <4>;
> +		spi-max-frequency = <50000000>;
> +	};
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +	multi-master;
> +	ipmb0@10 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Therefore: ipmb@10

> +		compatible = "ipmb-dev";
> +		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> +		i2c-protocol;
> +	};
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +	multi-master;
> +	ipmb1@10 {

ipmb@10

> +		compatible = "ipmb-dev";
> +		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> +		i2c-protocol;
> +	};
> +};
> +
> +&i2c2 {
> +	status = "okay";
> +	multi-master;
> +	ipmb2@10 {

ipmb@10

> +		compatible = "ipmb-dev";
> +		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> +		i2c-protocol;
> +	};
> +};
> +
> +&i2c3 {
> +	status = "okay";
> +	multi-master;
> +	ipmb3@10 {

ipmb@10

> +		compatible = "ipmb-dev";
> +		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> +		i2c-protocol;
> +	};
> +};
> +
> +&i2c4 {
> +	status = "okay";
> +};
> +
> +&i2c5 {
> +	status = "okay";
> +};
> +
> +&i2c6 {
> +	status = "okay";
> +};
> +
> +&i2c7 {
> +	status = "okay";
> +};
> +
> +&i2c8 {
> +	status = "okay";
> +	temperature-sensor@1f {
> +		compatible = "ti,tmp421";
> +		reg = <0x1f>;
> +	};
> +	// NIC EEPROM
> +	eeprom@50 {
> +		compatible = "st,24c32";
> +		reg = <0x50>;
> +	};
> +};
> +
> +&i2c9 {
> +	status = "okay";
> +	multi-master;
> +	ipmb9@10 {

ipmb@10

> +		compatible = "ipmb-dev";
> +		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> +		i2c-protocol;
> +	};
> +};
> +
> +&i2c10 {
> +	status = "okay";
> +};
> +
> +&i2c11 {
> +	status = "okay";
> +	eeprom@51 {
> +		compatible = "atmel,24c128";
> +		reg = <0x51>;
> +	};
> +	eeprom@54 {
> +		compatible = "atmel,24c128";
> +		reg = <0x54>;
> +	};
> +};
> +
> +&i2c12 {
> +	status = "okay";
> +	temperature-sensor@4f {
> +		compatible = "lm75";
> +		reg = <0x4f>;
> +	};
> +};
> +
> +&i2c13 {
> +	status = "okay";
> +};
> +
> +&adc0 {
> +	ref_voltage = <2500>;
> +	status = "okay";
> +	pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
> +			&pinctrl_adc2_default &pinctrl_adc3_default
> +			&pinctrl_adc4_default &pinctrl_adc5_default
> +			&pinctrl_adc6_default &pinctrl_adc7_default>;
> +};
> +
> +&adc1 {
> +	ref_voltage = <2500>;
> +	status = "okay";
> +	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc10_default
> +			&pinctrl_adc11_default &pinctrl_adc12_default
> +			&pinctrl_adc13_default &pinctrl_adc14_default>;
> +};
> +
> +
> +&ehci0 {
> +	status = "okay";
> +};
> +
> +&ehci1 {
> +	status = "okay";
> +};
> +
> +&uhci {
> +	status = "okay";
> +};
> +
> +&gpio0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_gpiu1_default &pinctrl_gpiu7_default>;
> +};
> +
> +

No need for two blank lines at the end. Drop both.

Best regards,
Krzysztof

