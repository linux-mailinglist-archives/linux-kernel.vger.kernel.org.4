Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5166E438B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 11:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjDQJUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 05:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjDQJUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 05:20:41 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472044EE8;
        Mon, 17 Apr 2023 02:20:17 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 6243242404;
        Mon, 17 Apr 2023 09:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1681723215; bh=9jlVu198RfqwmaRiA8SNqHWeiiqMm+RyqmhZGbIcPz4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=w+ZM745qp5UA4iaN2535iZH+6vIHrUS7ZsqW+Tn+nml+2ZaejGEwCZmHQ+yw67cOU
         xCftyDtFkXnUbWInwP055JUKGLb/arnH0FyKwvdK8e4CQyrI73IFVMzVZCgKZJuhc7
         P6OxoJsRpfh4o1nJ9YhVgJ7GxQbKh4rMhZzbx2Uk/DQAF2kA3wBa1dsFA4j9P8Gyqn
         cE5XrjSXjKuJ4xNTrt4Asib4SYtjrAIiiBvJTvKZgg+B8UFPBD/X8TeMXomemIqqJV
         g/NBZ/xnsv4ENfC0XY7iAv03oVsX8XnZyzOpjPzYDZ2oqz8H2wsIWdJxhTWYFwQwu2
         fTYRBSRrvQqiQ==
Message-ID: <c366d449-542f-8365-9f04-74da4ef847be@marcan.st>
Date:   Mon, 17 Apr 2023 18:20:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] arm64: dts: apple: t8112: Add PWM controller
Content-Language: en-US
To:     fnkl.kernel@gmail.com, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230409-t8112-fpwm-v1-1-feffa5f8b99b@gmail.com>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <20230409-t8112-fpwm-v1-1-feffa5f8b99b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2023 18.18, Sasha Finkelstein via B4 Relay wrote:
> From: Sasha Finkelstein <fnkl.kernel@gmail.com>
> 
> This patch adds the device tree entries for the PWM controller
> present on M2 macbooks that is connected to the keyboard backlight.
> 
> Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
> ---
>  arch/arm64/boot/dts/apple/t8112-j413.dts | 17 +++++++++++++++++
>  arch/arm64/boot/dts/apple/t8112-j493.dts | 17 +++++++++++++++++
>  arch/arm64/boot/dts/apple/t8112.dtsi     |  9 +++++++++
>  3 files changed, 43 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/apple/t8112-j413.dts b/arch/arm64/boot/dts/apple/t8112-j413.dts
> index 9e758edeaa82..6f69658623bf 100644
> --- a/arch/arm64/boot/dts/apple/t8112-j413.dts
> +++ b/arch/arm64/boot/dts/apple/t8112-j413.dts
> @@ -11,6 +11,7 @@
>  
>  #include "t8112.dtsi"
>  #include "t8112-jxxx.dtsi"
> +#include <dt-bindings/leds/common.h>
>  
>  / {
>  	compatible = "apple,j413", "apple,t8112", "apple,arm-platform";
> @@ -20,6 +21,18 @@ aliases {
>  		bluetooth0 = &bluetooth0;
>  		wifi0 = &wifi0;
>  	};
> +
> +	led-controller {
> +		compatible = "pwm-leds";
> +		led-0 {
> +			pwms = <&fpwm1 0 40000>;
> +			label = "kbd_backlight";
> +			function = LED_FUNCTION_KBD_BACKLIGHT;
> +			color = <LED_COLOR_ID_WHITE>;
> +			max-brightness = <255>;
> +			default-state = "keep";
> +		};
> +	};
>  };
>  
>  /*
> @@ -61,3 +74,7 @@ hpm5: usb-pd@3a {
>  &i2c4 {
>  	status = "okay";
>  };
> +
> +&fpwm1 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/apple/t8112-j493.dts b/arch/arm64/boot/dts/apple/t8112-j493.dts
> index 8552c15be265..0ad908349f55 100644
> --- a/arch/arm64/boot/dts/apple/t8112-j493.dts
> +++ b/arch/arm64/boot/dts/apple/t8112-j493.dts
> @@ -11,6 +11,7 @@
>  
>  #include "t8112.dtsi"
>  #include "t8112-jxxx.dtsi"
> +#include <dt-bindings/leds/common.h>
>  
>  / {
>  	compatible = "apple,j493", "apple,t8112", "apple,arm-platform";
> @@ -20,6 +21,18 @@ aliases {
>  		bluetooth0 = &bluetooth0;
>  		wifi0 = &wifi0;
>  	};
> +
> +	led-controller {
> +		compatible = "pwm-leds";
> +		led-0 {
> +			pwms = <&fpwm1 0 40000>;
> +			label = "kbd_backlight";
> +			function = LED_FUNCTION_KBD_BACKLIGHT;
> +			color = <LED_COLOR_ID_WHITE>;
> +			max-brightness = <255>;
> +			default-state = "keep";
> +		};
> +	};
>  };
>  
>  /*
> @@ -50,3 +63,7 @@ bluetooth0: bluetooth@0,1 {
>  &i2c4 {
>  	status = "okay";
>  };
> +
> +&fpwm1 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/apple/t8112.dtsi b/arch/arm64/boot/dts/apple/t8112.dtsi
> index 698a436e7dac..1666e6ab250b 100644
> --- a/arch/arm64/boot/dts/apple/t8112.dtsi
> +++ b/arch/arm64/boot/dts/apple/t8112.dtsi
> @@ -458,6 +458,15 @@ i2c4: i2c@235020000 {
>  			status = "disabled";
>  		};
>  
> +		fpwm1: pwm@235044000 {
> +			compatible = "apple,t8112-fpwm", "apple,s5l-fpwm";
> +			reg = <0x2 0x35044000 0x0 0x4000>;
> +			power-domains = <&ps_fpwm1>;
> +			clocks = <&clkref>;
> +			#pwm-cells = <2>;
> +			status = "disabled";
> +		};
> +
>  		serial0: serial@235200000 {
>  			compatible = "apple,s5l-uart";
>  			reg = <0x2 0x35200000 0x0 0x1000>;
> 
> ---
> base-commit: 8d59efc33fdaa2c82072b4d3ba5f67d7dd9270d0
> change-id: 20230409-t8112-fpwm-06e434cc358d

Applied to asahi-soc/dt, thanks!

- Hector

