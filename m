Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD5E72435F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237881AbjFFM6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237880AbjFFM55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:57:57 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22A0E77
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 05:57:21 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f3ba703b67so7484381e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 05:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686056240; x=1688648240;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Zi9U7lw+Rmv5fPmQ5a1N7/KX1eblAqJrMCOPf7hQjU=;
        b=Ol6t/0tlizL9LbWvuIlizRXEsWvJHOavhVSubv+9cokguHXRCIzHSvxtVhXQuPZ7Tk
         x0hzioA03uGHg8SoWu5hsNK/Bi8u35Yl2u+gWdtplEcsZeBa89OKegUxgivnXr6RD4vG
         Rgt7XNoTlUdgxQzpIHeTdC2re210sk1XUuxbgnuBMQIOZ3/PWF9rLS4CGrXpADcU9hvf
         Dm8IZMag/OUv6B0Kie3vaMgA3xJGCkx3EAB7zr6hV0whyyMbt/JieeYR+iBieAkupnSl
         r42l3GmXvL8vuXulD10ETlmMfaIpAxVTfdgLy7bBDIzQhy4odPLAwnMl5wFw8Yt3Hf2b
         QMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686056240; x=1688648240;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Zi9U7lw+Rmv5fPmQ5a1N7/KX1eblAqJrMCOPf7hQjU=;
        b=ECQR2TV6ilRQ6/90ux10R/5FMCPMiENhAFEtfJ3/uKWda832ZeQ/F711xE8IjeNqJK
         6xANVsTpk032rinjhYjTGrGUg0nESLyWb1K14zRDDY+kibtal/dCHNr3ygW5x+zZAWcp
         HFkulYYpBlhegt+Ukgrmb2ykBgpIgl2QIoPEbxHeDVfx+E1ytT55SBDUFG67TAlzArd8
         TpIGnu6tOC93Lw6QBfqh7kAO+NGUv4Mx3Rkx80jILpPlIuKsudLDfpI5royPgoza1NWb
         Z70OGfhNCSST2iugOscxXnLaMRxi4RTFueyG2KMKBTkLBzY+qGEjjBoJ7LrJgwr/wd46
         QNIQ==
X-Gm-Message-State: AC+VfDyDy3WKJNTdY+3n3cevardxOax8kUB44ZMr2dC0kvqxkwK2Q3rD
        vZQHwShPlFwnwqbB0woLLG4JMA==
X-Google-Smtp-Source: ACHHUZ7mLqoIH/C3aDwfEn0ouGUAjY86F/ZLh417p6v5iPca9DuvSbjT9K74RGrPvR8UGvAZKlV3gA==
X-Received: by 2002:ac2:5610:0:b0:4ee:e0c7:434d with SMTP id v16-20020ac25610000000b004eee0c7434dmr892033lfd.51.1686056240006;
        Tue, 06 Jun 2023 05:57:20 -0700 (PDT)
Received: from [192.168.1.101] (abyl150.neoplus.adsl.tpnet.pl. [83.9.31.150])
        by smtp.gmail.com with ESMTPSA id q16-20020ac25290000000b004f25c29f64esm1452192lfm.176.2023.06.06.05.57.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 05:57:19 -0700 (PDT)
Message-ID: <669d2745-c7fc-dff5-a6e6-c2c55b4428ee@linaro.org>
Date:   Tue, 6 Jun 2023 14:57:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH V2 1/2] arm64: dts: qcom: ipq5332: enable GPIO based LEDs
 and Buttons
Content-Language: en-US
To:     Sridharan S N <quic_sridsn@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230605052907.18837-1-quic_sridsn@quicinc.com>
 <20230605052907.18837-2-quic_sridsn@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230605052907.18837-2-quic_sridsn@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5.06.2023 07:29, Sridharan S N wrote:
> Add support for wlan-2g LED on GPIO 36 and wps buttons on GPIO 35.
> 
> Signed-off-by: Sridharan S N <quic_sridsn@quicinc.com>
> ---
> Changes in V2:
> 	- Used the hypen in node name instead of underscore
> 	- Dropped the status property
>  
>  arch/arm64/boot/dts/qcom/ipq5332-mi01.2.dts | 42 +++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/ipq5332-rdp442.dts | 42 +++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts | 42 +++++++++++++++++++++
>  3 files changed, 126 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5332-mi01.2.dts b/arch/arm64/boot/dts/qcom/ipq5332-mi01.2.dts
> index 3af1d5556950..5bd4ff3ad86b 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5332-mi01.2.dts
> +++ b/arch/arm64/boot/dts/qcom/ipq5332-mi01.2.dts
> @@ -7,6 +7,8 @@
>  
>  /dts-v1/;
>  
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
>  #include "ipq5332.dtsi"
>  
>  / {
> @@ -20,6 +22,32 @@
>  	chosen {
>  		stdout-path = "serial0";
>  	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-0 = <&gpio_keys_default>;
> +		pinctrl-names = "default";
> +
> +		button-wps {
> +			label = "wps";
> +			linux,code = <KEY_WPS_BUTTON>;
> +			gpios = <&tlmm 35 GPIO_ACTIVE_LOW>;
> +			linux,input-type = <1>;
> +			debounce-interval = <60>;
> +		};
> +	};
All of these changes seem very repetetive.. Are these devboards based
on a common design? Maybe ipq5332-rdp-common.dtsi would be beneficial
here?

Konrad
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-0 = <&gpio_leds_default>;
> +		pinctrl-names = "default";
> +
> +		led-0 {
> +			gpios = <&tlmm 36 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "phy0tx";
> +			default-state = "off";
> +		};
> +	};
>  };
>  
>  &blsp1_uart0 {
> @@ -57,6 +85,20 @@
>  /* PINCTRL */
>  
>  &tlmm {
> +	gpio_keys_default: gpio-keys-default-state {
> +		pins = "gpio35";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		bias-pull-up;
> +	};
> +
> +	gpio_leds_default: gpio-leds-default-state {
> +		pins = "gpio36";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		bias-pull-down;
> +	};
> +
>  	i2c_1_pins: i2c-1-state {
>  		pins = "gpio29", "gpio30";
>  		function = "blsp1_i2c0";
> diff --git a/arch/arm64/boot/dts/qcom/ipq5332-rdp442.dts b/arch/arm64/boot/dts/qcom/ipq5332-rdp442.dts
> index bcf3b31c20e3..36cbebb75c48 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5332-rdp442.dts
> +++ b/arch/arm64/boot/dts/qcom/ipq5332-rdp442.dts
> @@ -7,6 +7,8 @@
>  
>  /dts-v1/;
>  
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
>  #include "ipq5332.dtsi"
>  
>  / {
> @@ -20,6 +22,32 @@
>  	chosen {
>  		stdout-path = "serial0";
>  	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-0 = <&gpio_keys_default>;
> +		pinctrl-names = "default";
> +
> +		button-wps {
> +			label = "wps";
> +			linux,code = <KEY_WPS_BUTTON>;
> +			gpios = <&tlmm 35 GPIO_ACTIVE_LOW>;
> +			linux,input-type = <1>;
> +			debounce-interval = <60>;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-0 = <&gpio_leds_default>;
> +		pinctrl-names = "default";
> +
> +		led-0 {
> +			gpios = <&tlmm 36 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "phy0tx";
> +			default-state = "off";
> +		};
> +	};
>  };
>  
>  &blsp1_uart0 {
> @@ -71,6 +99,20 @@
>  /* PINCTRL */
>  
>  &tlmm {
> +	gpio_keys_default: gpio-keys-default-state {
> +		pins = "gpio35";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		bias-pull-up;
> +	};
> +
> +	gpio_leds_default: gpio-leds-default-state {
> +		pins = "gpio36";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		bias-pull-down;
> +	};
> +
>  	i2c_1_pins: i2c-1-state {
>  		pins = "gpio29", "gpio30";
>  		function = "blsp1_i2c0";
> diff --git a/arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts b/arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts
> index 3b6a5cb8bf07..2d27f48f00c0 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts
> +++ b/arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts
> @@ -7,6 +7,8 @@
>  
>  /dts-v1/;
>  
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
>  #include "ipq5332.dtsi"
>  
>  / {
> @@ -20,6 +22,32 @@
>  	chosen {
>  		stdout-path = "serial0";
>  	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-0 = <&gpio_keys_default>;
> +		pinctrl-names = "default";
> +
> +		button-wps {
> +			label = "wps";
> +			linux,code = <KEY_WPS_BUTTON>;
> +			gpios = <&tlmm 35 GPIO_ACTIVE_LOW>;
> +			linux,input-type = <1>;
> +			debounce-interval = <60>;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-0 = <&gpio_leds_default>;
> +		pinctrl-names = "default";
> +
> +		led-0 {
> +			gpios = <&tlmm 36 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "phy0tx";
> +			default-state = "off";
> +		};
> +	};
>  };
>  
>  &blsp1_uart0 {
> @@ -64,6 +92,20 @@
>  /* PINCTRL */
>  
>  &tlmm {
> +	gpio_keys_default: gpio-keys-default-state {
> +		pins = "gpio35";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		bias-pull-up;
> +	};
> +
> +	gpio_leds_default: gpio-leds-default-state {
> +		pins = "gpio36";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		bias-pull-down;
> +	};
> +
>  	sdc_default_state: sdc-default-state {
>  		clk-pins {
>  			pins = "gpio13";
