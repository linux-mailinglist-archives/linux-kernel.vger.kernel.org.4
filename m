Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA8B693BF6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 02:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjBMB4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 20:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBMB4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 20:56:22 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58021EF97;
        Sun, 12 Feb 2023 17:56:21 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 3339A32004E7;
        Sun, 12 Feb 2023 20:56:20 -0500 (EST)
Received: from imap50 ([10.202.2.100])
  by compute6.internal (MEProxy); Sun, 12 Feb 2023 20:56:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1676253379; x=1676339779; bh=zLpLD80M2L
        vq4/USAIGcEVrxzFXr/oAqqJkxrCE4o+Q=; b=cG+u8oZxu5Ep2TiLfexaGZqSy4
        zfP+QEUhp69nQYyp/y1HnNfO3u/QwZd8xyyjnpXp063xrupqIzwOkaav83HEhfOe
        YtaKXzYQw8sMUNeFQNzpMJ8E2WrjCOG9cc0IcO4RVSLPAr86XR890m+qenkCsUQs
        f50xgqp/LHGE0PndAHBISYh+ANXCfoRfybM+RA8fHhVW35WrfefhPme1jn/cDdV0
        xLnJq0yjZ+lW0Y+1L7S2DsT7LHoS5jIqA2oF5EfElfeE1kgXcTboifZ10FZniPnW
        B+1Mu8xDSuAlchRgASVWFnID1d1AhLHyuUALEpG3JtuhqdzTAgiIQZY35TjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676253379; x=1676339779; bh=zLpLD80M2Lvq4/USAIGcEVrxzFXr
        /oAqqJkxrCE4o+Q=; b=hRffhh10X3E6fuvaKZF+e8BYvrg3Eztwy53wiPNT1UL3
        HD14AODuWO1o+ABr9b9duOVW6OD0jnBcQER8lQgk1cYqb9CunJD1IsKJStXcc1P+
        Fc8kstnU+IcOtI/Crvn571Exv7hsYxROiloyoJZlSW26mGF9iuLoIhDWfWO0FEQV
        YoCqs1Hvcfu4w0HYc5MMbDfy5eiibKvG/hhOCPgzVlHek/qPRG673NAgboEGTpIZ
        eaaVfqhC/QSZHbZ0b2gHBvi8wC9x9JbQ3TUNrc++7pBIMscD834mzMKP2viCwoU9
        5+VDMeXz8iNje566aTxgH9B9h92ZfINNoTXmvTwLXQ==
X-ME-Sender: <xms:w5jpY0_06DPd-p6LHFlsy348pxwSw37j94riTMv05SJBdu4QDwk3zQ>
    <xme:w5jpY8sbeWgmFePn5cxHGmohcKD1J-5BESJokoPq3YmDzTfPJWWJOhPof2cP2QFoy
    J7rirzPspAFaD-pPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeitddggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehn
    ughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtf
    frrghtthgvrhhnpeekvdekjeekgfejudffteetgeejkeetteduvedtffdtledutdfhheev
    feetkeeiteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:w5jpY6CPDestTPsrbNAvivcxn2EazOjpLQwwYYCFM4pBM0ombMPT3Q>
    <xmx:w5jpY0dTM7C-wgX8EI4YY6x4eDXC7kwNLGa8RGLF-Z51ekzy8aWgSQ>
    <xmx:w5jpY5MDZLYXfRXEfzStgpI_BVpdAPl0Noc_XUuV1KydNTHC49y4Hw>
    <xmx:w5jpY8cuXSN_euPXt8uJbIYM_EcXzm_-OYelzESUV_EG3vdRpwjebA>
Feedback-ID: idfb84289:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 201031700089; Sun, 12 Feb 2023 20:56:19 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <12424bbd-cd3c-4d96-a7d8-1c83241b845f@app.fastmail.com>
In-Reply-To: <20230210103829.74470-2-jordan.chang@ufispace.com>
References: <20230210103829.74470-1-jordan.chang@ufispace.com>
 <20230210103829.74470-2-jordan.chang@ufispace.com>
Date:   Mon, 13 Feb 2023 12:25:57 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Jordan Chang" <jordan.chang@ufispace.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Joel Stanley" <joel@jms.id.au>, "Rob Herring" <robh+dt@kernel.org>
Cc:     jay.tc.lin@ufispace.com, eason.ys.huang@ufispace.com
Subject: Re: [PATCH v4 1/1] ARM: dts: aspeed: Add device tree for Ufispace NCPLite BMC
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 10 Feb 2023, at 21:08, Jordan Chang wrote:
> Add initial version of device tree for Ufispace NCPLite platform
> which is equipped with AST2600-based BMC.
>
> Signed-off-by: Jordan Chang <jordan.chang@ufispace.com>
> ---
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../boot/dts/aspeed-bmc-ufispace-ncplite.dts  | 359 ++++++++++++++++++
>  2 files changed, 360 insertions(+)
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
> diff --git a/arch/arm/boot/dts/aspeed-bmc-ufispace-ncplite.dts 
> b/arch/arm/boot/dts/aspeed-bmc-ufispace-ncplite.dts
> new file mode 100644
> index 000000000000..a3853bdcae9d
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed-bmc-ufispace-ncplite.dts
> @@ -0,0 +1,359 @@
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
> +		event-fan-alert {
> +			label = "fan-alert";
> +			gpios = <&gpio0 ASPEED_GPIO(M, 2) GPIO_ACTIVE_LOW>;
> +			linux,code = <ASPEED_GPIO(M, 2)>;
> +		};
> +
> +		event-allpwr-good {
> +			label = "allpwr-good";
> +			gpios = <&gpio0 ASPEED_GPIO(V, 4) GPIO_ACTIVE_HIGH>;
> +			linux,code = <ASPEED_GPIO(V, 4)>;
> +		};
> +
> +		event-psu0-alert {
> +			label = "psu0-alert";
> +			gpios = <&gpio0 ASPEED_GPIO(V, 1) GPIO_ACTIVE_LOW>;
> +			linux,code = <ASPEED_GPIO(V, 1)>;
> +		};
> +
> +		event-psu1-alert {
> +			label = "psu1-alert";
> +			gpios = <&gpio0 ASPEED_GPIO(V, 2) GPIO_ACTIVE_LOW>;
> +			linux,code = <ASPEED_GPIO(V, 2)>;
> +		};
> +
> +		event-thermal-alert {
> +			label = "thermal-alert";
> +			gpios = <&gpio0 ASPEED_GPIO(P, 2) GPIO_ACTIVE_LOW>;
> +			linux,code = <ASPEED_GPIO(P, 2)>;
> +		};
> +
> +		event-cpu-caterr {
> +			label = "cpu-caterr";
> +			gpios = <&gpio0 ASPEED_GPIO(N, 3) GPIO_ACTIVE_LOW>;
> +			linux,code = <ASPEED_GPIO(N, 3)>;
> +		};
> +
> +		event-cpu-thermtrip {
> +			label = "cpu-thermtrip";
> +			gpios = <&gpio0 ASPEED_GPIO(V, 5) GPIO_ACTIVE_LOW>;
> +			linux,code = <ASPEED_GPIO(V, 5)>;
> +		};
> +
> +		event-psu0-presence {
> +			label = "psu0-presence";
> +			gpios = <&gpio0 ASPEED_GPIO(F, 6) GPIO_ACTIVE_LOW>;
> +			linux,code = <ASPEED_GPIO(F, 6)>;
> +		};
> +
> +		event-psu1-presence {
> +			label = "psu1-presence";
> +			gpios = <&gpio0 ASPEED_GPIO(F, 7) GPIO_ACTIVE_LOW>;
> +			linux,code = <ASPEED_GPIO(F, 7)>;
> +		};
> +
> +		event-psu0-power-ok {
> +			label = "psu0-power-ok";
> +			gpios = <&gpio0 ASPEED_GPIO(M, 4) GPIO_ACTIVE_HIGH>;
> +			linux,code = <ASPEED_GPIO(M, 4)>;
> +		};
> +
> +		event-psu1-power-ok {
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
> +		event-fan0-presence {
> +			label = "fan0-presence";
> +			gpios = <&fan_ioexp 2 GPIO_ACTIVE_LOW>;
> +			linux,code = <2>;
> +		};
> +
> +		event-fan1-presence {
> +			label = "fan1-presence";
> +			gpios = <&fan_ioexp 6 GPIO_ACTIVE_LOW>;
> +			linux,code = <6>;
> +		};
> +
> +		event-fan2-presence {
> +			label = "fan2-presence";
> +			gpios = <&fan_ioexp 10 GPIO_ACTIVE_LOW>;
> +			linux,code = <10>;
> +		};
> +
> +		event-fan3-presence {
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
> +	temperature-sensor@48 {
> +		compatible = "national,lm75";
> +		reg = <0x48>;
> +	};
> +
> +	temperature-sensor@49 {
> +		compatible = "national,lm75";
> +		reg = <0x49>;
> +	};
> +
> +	temperature-sensor@4c {
> +		compatible = "national,lm86";
> +		reg = <0x4c>;
> +	};
> +};
> +
> +&i2c2 {
> +	status = "okay";
> +
> +	temperature-sensor@4f {
> +		cpmpatible = "national,lm75";

s/cpmp/comp/

Otherwise:

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
