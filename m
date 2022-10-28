Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2346C6119B5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 19:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiJ1R5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 13:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJ1R5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:57:06 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EFB1EA57C
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:57:05 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id x26so3946572qki.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t2UMRrA6hypBk9YLVdB4VW5wHm8QCbjxxyhhAxXjkNU=;
        b=TMNb3V8AhX9WhX05Du+3fglf9uLfI9wB0ttrU8VotGjsWLsy0okAKTSDVz0xxOl8KF
         zNuPQHvd/kR3PyvJoVDXGlZtmmk79Al8rAIDjUZyXF2Fwu7ZOCYkfl5ZskGskw3M8Adl
         gC7ELE1lGzbXcSs2WJt6lNDm6lNeNGq0jdYSgh6kyvUGi+XiO9yfdeBb9hSvNqt4p6XE
         7cYKcAKDhAm76ea3Id6NcO6HkOhNkOf1EF+yN/P/F49LixWucVnI8O6FH+NX4iFeUohn
         JPi7sntU7rQcbCaIGTlRQNzUto/VcBquWadXxkhogBRtiHbE+sM4Zo6UgCkKuNuJQJXQ
         ppog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t2UMRrA6hypBk9YLVdB4VW5wHm8QCbjxxyhhAxXjkNU=;
        b=rVtAgTvYVIWa9rJ97j0KpURJbUEUOQbYE/sBMoLz1YVIT8B/chpkF0AvIvG98MpCau
         5fxqiaUFkEvWe087SivPmeW9tq4sgh6kSaf5L7tEY0nX30NLrGL12WCH25U2pUiEiXBt
         FYOMXvT/4afvYuGQJWVdSPqabEHAYhxltVfiUSrxzyhMCdKCT4guLfIjsB9tgzO/fn66
         fjis9IrcOdNqBU69X0cqdrsjUxv0bjZNCDkA+GqwLu2KYY7GX8ekhOo5kRibmRZIrQsR
         o2GIzCHA8IdvXbYwbe9xgRN0QWZg2ig33nJWfvvHHrhnCoL03DLdpRmxO1cfO6wSYVuk
         jt9g==
X-Gm-Message-State: ACrzQf2PmsYUeWbzypb03H7mrvraPie9PiQUyW06yLl9rNZ88Zg9cLBc
        JDX/cA6s8TpG6pS0ZvqR5F35Pg==
X-Google-Smtp-Source: AMsMyM6wLJNrR/80ICPG10nSm5Sgvsux4rOEUB/kGaglkjyZjg2hrXmZEnVbBBIKg8Bp7Mg07JvVuQ==
X-Received: by 2002:a05:620a:d4b:b0:6f6:b34a:53cb with SMTP id o11-20020a05620a0d4b00b006f6b34a53cbmr351470qkl.662.1666979824237;
        Fri, 28 Oct 2022 10:57:04 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id s9-20020ac85ec9000000b0039ccbf75f92sm2668431qtx.11.2022.10.28.10.56.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 10:57:03 -0700 (PDT)
Message-ID: <55b03c70-cc77-43e7-7ca2-8a0445a40cea@linaro.org>
Date:   Fri, 28 Oct 2022 13:56:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 3/4] arm64: dts: apple: t8103: Add PWM controller
Content-Language: en-US
To:     Sasha Finkelstein <fnkl.kernel@gmail.com>,
        thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221028165215.43662-1-fnkl.kernel@gmail.com>
 <20221028165215.43662-4-fnkl.kernel@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221028165215.43662-4-fnkl.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/10/2022 12:52, Sasha Finkelstein wrote:
> Adds PWM controller and keyboard backlight bindings for M1 MacBooks
> 
> Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
> ---
>  arch/arm64/boot/dts/apple/t8103-j293.dts | 20 ++++++++++++++++++++
>  arch/arm64/boot/dts/apple/t8103-j313.dts | 20 ++++++++++++++++++++
>  arch/arm64/boot/dts/apple/t8103.dtsi     |  9 +++++++++
>  3 files changed, 49 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/apple/t8103-j293.dts b/arch/arm64/boot/dts/apple/t8103-j293.dts
> index ecb10d237a05..5652cd41730a 100644
> --- a/arch/arm64/boot/dts/apple/t8103-j293.dts
> +++ b/arch/arm64/boot/dts/apple/t8103-j293.dts
> @@ -11,6 +11,7 @@
>  
>  #include "t8103.dtsi"
>  #include "t8103-jxxx.dtsi"
> +#include <dt-bindings/leds/common.h>
>  
>  / {
>  	compatible = "apple,j293", "apple,t8103", "apple,arm-platform";
> @@ -43,3 +44,22 @@ &i2c2 {
>  &i2c4 {
>  	status = "okay";
>  };
> +
> +/ {
> +	pwmleds {

Node names should be generic: led-controller
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +		compatible = "pwm-leds";
> +		kbd-backlight {

Does not look like you tested the DTS against bindings. Please run `make
dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
for instructions).

> +			pwms = <&fpwm1 0 40000>;
> +			label = "kbd_backlight";
> +			function = LED_FUNCTION_KBD_BACKLIGHT;
> +			color = <LED_COLOR_ID_WHITE>;
> +			max-brightness = <255>;
> +			default-state = "keep";
> +			pwm-names = "kbd-backlight";

This goes just after pwms.

> +		};
> +	};
> +};
> +
> +&fpwm1 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/apple/t8103-j313.dts b/arch/arm64/boot/dts/apple/t8103-j313.dts
> index df741737b8e6..cff53f8770f3 100644
> --- a/arch/arm64/boot/dts/apple/t8103-j313.dts
> +++ b/arch/arm64/boot/dts/apple/t8103-j313.dts
> @@ -11,6 +11,7 @@
>  
>  #include "t8103.dtsi"
>  #include "t8103-jxxx.dtsi"
> +#include <dt-bindings/leds/common.h>
>  
>  / {
>  	compatible = "apple,j313", "apple,t8103", "apple,arm-platform";
> @@ -35,3 +36,22 @@ &pcie0_dart_2 {
>  
>  /delete-node/ &port01;
>  /delete-node/ &port02;
> +
> +/ {
> +	pwmleds {

Same comments

> +		compatible = "pwm-leds";
> +		kbd-backlight {
> +			pwms = <&fpwm1 0 40000>;
> +			label = "kbd_backlight";
> +			function = LED_FUNCTION_KBD_BACKLIGHT;
> +			color = <LED_COLOR_ID_WHITE>;
> +			max-brightness = <255>;
> +			default-state = "keep";
> +			pwm-names = "kbd-backlight";
> +		};
> +	};
> +};
> +
> +&fpwm1 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
> index 51a63b29d404..a95dc482102e 100644
> --- a/arch/arm64/boot/dts/apple/t8103.dtsi
> +++ b/arch/arm64/boot/dts/apple/t8103.dtsi
> @@ -191,6 +191,15 @@ i2c4: i2c@235020000 {
>  			status = "disabled"; /* only used in J293 */
>  		};
>  
> +		fpwm1: fpwm@235044000 {

Node names should be generic, so pwm.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +			compatible = "apple,t8103-fpwm", "apple,s5l-fpwm";
> +			reg = <0x2 0x35044000 0x0 0x4000>;

Best regards,
Krzysztof

