Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044CB6C47AD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 11:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjCVKa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 06:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjCVKav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 06:30:51 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C5A5FE80
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 03:30:46 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id m2so16466132wrh.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 03:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679481045;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HS1TthkA1D783Zl2TDLfV0qjKb5jmiXmhJ6n2zgO/b0=;
        b=U0i1asBOZxJ6VioQ2kAaKVDljpLZYtdcXc8Qtpw0mFrPut11p+GGz293JmHGHT4yXl
         GdITAje81Q5pblvWTczmf205lakcLLGb0WYiyScp73RML8M46JgjmqZO4yNzyxnKecod
         v9Gzee/X/nvRBEnEnXTEqdFfs0EW4UAV7cx3MXT/ri/THcjeaqpYlfiOX1fpoA0MlPzQ
         pJHED/HiF0OLLC4trsX6ZpiY+MjtQ8DkUy03/Ng3GoKp2ulV4MQtj9w5aIr87pTBSzHv
         ZEVXXIXrlxHPxxjsI/1b+DsmHHy8tRjaHXcusXV72eC5DGzNSwvyvWpPy0d36BIHajqb
         nu8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679481045;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HS1TthkA1D783Zl2TDLfV0qjKb5jmiXmhJ6n2zgO/b0=;
        b=uvxRE38WotjmmwOwZLkXF8hzUF4KHmz0s/iwv1BMeJz2dWYZViOuRvC6qKl7G6Vwn1
         99jUv7xf2ayYqaZsU1prOiS/nGoGBND+J5j0vOGv9t2R2yzFjjr+zaBj6hZI0R3q+DvG
         7TqpoM4VWIIFxGH3rRwdie33eWQXN5QKWdCgEvYYCSyc6GHOPyaa0Id08bhxsNYLv9WC
         8U8GJqHOuMwHP8+mbEkRiGAtI5ioUmBKcZb6kXdFnR62EQVZtAfYJYreItStk/PGQYnc
         orym5woAGL/K19P64qPBY+KH0o2xupG0WtnDYnza3hm8CbjCEkzk7m9VPrPGoe8RSxhX
         8NCQ==
X-Gm-Message-State: AO0yUKW1QLAS5cRb8Ob0Tn1M81ikduqD2QGaHtIBq+/7+WTykHJOZpP6
        49SGxXglpuV3NlKVE5E0wrJShw==
X-Google-Smtp-Source: AK7set+SptPdFQRECxHi/SgpJ/cDbVBTk06DRTZBqXUJZ4lwFD0Oy7fakaIxrUXhCUUC38GcSeFuyw==
X-Received: by 2002:a5d:48c5:0:b0:2cf:e7d5:8fcb with SMTP id p5-20020a5d48c5000000b002cfe7d58fcbmr4648685wrs.49.1679481045491;
        Wed, 22 Mar 2023 03:30:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:3606:a601:f273:994a? ([2a01:e0a:982:cbb0:3606:a601:f273:994a])
        by smtp.gmail.com with ESMTPSA id w2-20020a5d6082000000b002c6d0462163sm13437081wrt.100.2023.03.22.03.30.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 03:30:45 -0700 (PDT)
Message-ID: <c16cfd67-d8b7-87a6-1b59-2ab351174513@linaro.org>
Date:   Wed, 22 Mar 2023 11:30:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 3/3] ARM: dts: meson8m2: mxiii-plus: Enable Bluetooth
 and WiFi support
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230321171213.2808460-1-martin.blumenstingl@googlemail.com>
 <20230321171213.2808460-4-martin.blumenstingl@googlemail.com>
Organization: Linaro Developer Services
In-Reply-To: <20230321171213.2808460-4-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2023 18:12, Martin Blumenstingl wrote:
> The MXIII Plus uses an Ampak AP6330 Bluetooth and WiFi combo chip.
> Bluetooth is connected to &uart_A and requires toggling GPIOX_20.
> WiFi can be routed to either &sdhc or &sdio. Route WiFi to &sdhc
> since  &sdio is already connected to the SD card. Additionally WiFi
> requires toggling GPIOX_11 and GPIOAO_6 as well as enabling the 32kHz
> clock signal.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>   arch/arm/boot/dts/meson8m2-mxiii-plus.dts | 48 ++++++++++++++++++++++-
>   1 file changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/meson8m2-mxiii-plus.dts b/arch/arm/boot/dts/meson8m2-mxiii-plus.dts
> index fa6d55f1cfb9..aa4d4bf70629 100644
> --- a/arch/arm/boot/dts/meson8m2-mxiii-plus.dts
> +++ b/arch/arm/boot/dts/meson8m2-mxiii-plus.dts
> @@ -19,7 +19,6 @@ aliases {
>   		ethernet0 = &ethmac;
>   		i2c0 = &i2c_AO;
>   		serial0 = &uart_AO;
> -		serial1 = &uart_A;
>   		mmc0 = &sd_card_slot;
>   	};
>   
> @@ -45,12 +44,32 @@ button-function {
>   		};
>   	};
>   
> +	sdio_pwrseq: sdio-pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +
> +		pinctrl-0 = <&xtal_32k_out_pins>;
> +		pinctrl-names = "default";
> +
> +		reset-gpios = <&gpio GPIOX_11 GPIO_ACTIVE_LOW>,
> +			      <&gpio_ao GPIOAO_6 GPIO_ACTIVE_LOW>;
> +
> +		clocks = <&xtal_32k_out>;
> +		clock-names = "ext_clock";
> +	};
> +
>   	vcc_3v3: regulator-vcc3v3 {
>   		compatible = "regulator-fixed";
>   		regulator-name = "VCC3V3";
>   		regulator-min-microvolt = <3300000>;
>   		regulator-max-microvolt = <3300000>;
>   	};
> +
> +	xtal_32k_out: xtal-32k-out-clk {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <32768>;
> +		clock-output-names = "xtal_32k_out";
> +	};
>   };
>   
>   &cpu0 {
> @@ -192,6 +211,27 @@ &saradc {
>   	vref-supply = <&vddio_ao1v8>;
>   };
>   
> +/* SDIO wifi */
> +&sdhc {
> +	status = "okay";
> +
> +	pinctrl-0 = <&sdxc_a_pins>;
> +	pinctrl-names = "default";
> +
> +	bus-width = <4>;
> +	max-frequency = <50000000>;
> +
> +	disable-wp;
> +	non-removable;
> +	cap-mmc-highspeed;
> +	cap-sd-highspeed;
> +
> +	mmc-pwrseq = <&sdio_pwrseq>;
> +
> +	vmmc-supply = <&vcc_3v3>;
> +	vqmmc-supply = <&vcc_3v3>;
> +};
> +
>   &sdio {
>   	status = "okay";
>   
> @@ -222,6 +262,12 @@ &uart_A {
>   	pinctrl-0 = <&uart_a1_pins>, <&uart_a1_cts_rts_pins>;
>   	pinctrl-names = "default";
>   	uart-has-rtscts;
> +
> +	bluetooth {
> +		compatible = "brcm,bcm20702a1";
> +		shutdown-gpios = <&gpio GPIOX_20 GPIO_ACTIVE_HIGH>;
> +		max-speed = <2000000>;
> +	};
>   };
>   
>   &uart_AO {

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
