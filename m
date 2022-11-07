Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5879461FB4F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 18:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbiKGR1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 12:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbiKGR1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 12:27:10 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C469C23EBD
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 09:27:08 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso10108620wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 09:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/Pcc8LRKgOyNv6WsjXvv239va06IdZNjx9Vjm48MX3I=;
        b=PLmwVV82R5Wj8J0VZxf7f7iWHEEQqSkq3KHI8gpsvXg2CFmMAgjzLBPraztFCHyRoU
         xvYI3cuwIukME3111uI0OL5iMLrEoZAV+zwL5SLn8xGBfE7AAloAmtlsETM11/6c5OvY
         mrcbx5+2SlJVT0raHHxZ+rJxavVscGLpLD4s2dNGhskwBAtkWehBBTETyWBEfhJLP7zO
         EUCpH1bo4cIeoYIH5K50cNP3vz7QukPKTY77f+gEj/Vr9YAIXbXeVLmUDDTu87rMRw77
         2/P5aCzcws0xLi/FBlISevTDKeK3I2TqDWFxW9Oy+WB5DcMpgxhWrFK+95FuGO5Ja84a
         kH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Pcc8LRKgOyNv6WsjXvv239va06IdZNjx9Vjm48MX3I=;
        b=35DB+whWt7ubE5Lmn9+9PfGfnCaL7yEIpaSrwD3ehdwH/0Wya2JL3CB9h19Xbnu/gc
         yl9qh1DWkpRq/ZXRA/nXFBoaOLtoe8bq6ulKhzQmYgDq/iny/+guj1dZg65CUAOwuhsL
         1umrUMuDeIBxn4Kqy6v6+NmW7zXT6CkvoZnGq6UKYt3H8PvQY3w2Yu2SxrS30UXs9iJk
         aObcigAQ5S0KnIwGp42VoiA2PB17JPx7B0/gEcLXquvZua/4ITcP7rryMAFHW2e/GJp2
         2c6crZxVMYwpn11sc6DHGXzDhMnIP3YDOuoaj9Q9nh7zjZGQ7zrNAKHjmS8+bdJb8y0/
         2LjQ==
X-Gm-Message-State: ACrzQf2dpDnxk5q9yc0KrE6gI0hCHNQMcHwlNA7SQaphqLDhbHPYjSL3
        8T3drKb0wMXROPdS3QzBdfWtWw==
X-Google-Smtp-Source: AMsMyM6q6PZGGJUkukBvogL8l9nQiTpwonjfKWwZwZJBCkrL7u7qFaLzMj9WHibspzoBS2eqtJ9qhQ==
X-Received: by 2002:a7b:cc13:0:b0:3cf:8297:d61 with SMTP id f19-20020a7bcc13000000b003cf82970d61mr23045340wmh.160.1667842027294;
        Mon, 07 Nov 2022 09:27:07 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:64c8:555c:905:adc6? ([2a01:e0a:982:cbb0:64c8:555c:905:adc6])
        by smtp.gmail.com with ESMTPSA id m6-20020a1c2606000000b003c6edc05159sm12139091wmm.1.2022.11.07.09.27.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 09:27:06 -0800 (PST)
Message-ID: <cb47f89f-00ea-96e8-1e10-ae84406b924b@linaro.org>
Date:   Mon, 7 Nov 2022 18:27:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] arm64: dts: meson-s4-s805x2: add 12V/3.3V/1.8V/vddcpu
 nodes for Regulator
Content-Language: en-US
To:     Chao Zhang <chao.zhang@amlogic.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>
References: <20221107021116.2732032-1-chao.zhang@amlogic.com>
Organization: Linaro Developer Services
In-Reply-To: <20221107021116.2732032-1-chao.zhang@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07/11/2022 03:11, Chao Zhang wrote:
> From: "chao.zhang" <chao.zhang@amlogic.com>
> 
> Add 12V/3.3V/1.8V/vddcpu nodes for Regulator on Amlogic S4 SoCs.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Link: https://lore.kernel.org/r/20221004-up-aml-fix-spi-v4-3-0342d8e10c49@baylibre.com
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

I think you did a bad copy paste because those lines comes from another already applied commit.

Please add your own Signed-off-by.

> ---
>   .../dts/amlogic/meson-s4-s805x2-aq222.dts     | 85 +++++++++++++++++++
>   arch/arm64/boot/dts/amlogic/meson-s4.dtsi     |  4 +
>   2 files changed, 89 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts b/arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts
> index 8ffbcb2b1ac5..80c959766b79 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts
> @@ -22,6 +22,91 @@ memory@0 {
>   		device_type = "memory";
>   		reg = <0x0 0x0 0x0 0x40000000>;
>   	};
> +	main_12v: regulator-main_12v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "12V";
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;
> +		regulator-always-on;
> +	};
> +
> +	vddao_3v3: regulator-vddao_3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VDDAO_3V3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&main_12v>;
> +		regulator-always-on;
> +	};
> +
> +	vddio_ao1v8: regulator-vddio_ao1v8 {
> +	       compatible = "regulator-fixed";
> +	       regulator-name = "VDDIO_AO1V8";
> +	       regulator-min-microvolt = <1800000>;
> +	       regulator-max-microvolt = <1800000>;
> +	       vin-supply = <&vddao_3v3>;
> +	       regulator-always-on;
> +	};
> +
> +	vddcpu: regulator-vddcpu {
> +		/*
> +		 * SY8120B1ABC DC/DC Regulator.
> +		 */
> +		compatible = "pwm-regulator";
> +
> +		regulator-name = "VDDCPU";
> +		regulator-min-microvolt = <689000>;
> +		regulator-max-microvolt = <1049000>;
> +
> +		vin-supply = <&main_12v>;
> +
> +		pwms = <&pwm_ij 1 1500 0>;

Without the PWM node this won't apply.

> +		pwm-dutycycle-range = <100 0>;
> +
> +		regulator-boot-on;
> +		regulator-always-on;
> +		max-duty-cycle = <1500>;
> +		/* Voltage Duty-Cycle */
> +		voltage-table = <1049000 0>,
> +				<1039000 3>,
> +				<1029000 6>,
> +				<1019000 9>,
> +				<1009000 12>,
> +				<999000 14>,
> +				<989000 17>,
> +				<979000 20>,
> +				<969000 23>,
> +				<959000 26>,
> +				<949000 29>,
> +				<939000 31>,
> +				<929000 34>,
> +				<919000 37>,
> +				<909000 40>,
> +				<899000 43>,
> +				<889000 45>,
> +				<879000 48>,
> +				<869000 51>,
> +				<859000 54>,
> +				<849000 56>,
> +				<839000 59>,
> +				<829000 62>,
> +				<819000 65>,
> +				<809000 68>,
> +				<799000 70>,
> +				<789000 73>,
> +				<779000 76>,
> +				<769000 79>,
> +				<759000 81>,
> +				<749000 84>,
> +				<739000 87>,
> +				<729000 89>,
> +				<719000 92>,
> +				<709000 95>,
> +				<699000 98>,
> +				<689000 100>;

This is wrong, the regulator-min-microvolt and regulator-max-microvolt + pwm-dutycycle-range is enough.

> +		status = "okay";
> +	};
> +
>   
>   };
>   
> diff --git a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
> index ad50cba42d19..405a5af9ac1d 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
> @@ -17,6 +17,7 @@ cpu0: cpu@0 {
>   			compatible = "arm,cortex-a35";
>   			reg = <0x0 0x0>;
>   			enable-method = "psci";
> +			cpu-supply = <&vddcpu>;
>   		};
>   
>   		cpu1: cpu@1 {
> @@ -24,6 +25,7 @@ cpu1: cpu@1 {
>   			compatible = "arm,cortex-a35";
>   			reg = <0x0 0x1>;
>   			enable-method = "psci";
> +			cpu-supply = <&vddcpu>;
>   		};
>   
>   		cpu2: cpu@2 {
> @@ -31,6 +33,7 @@ cpu2: cpu@2 {
>   			compatible = "arm,cortex-a35";
>   			reg = <0x0 0x2>;
>   			enable-method = "psci";
> +			cpu-supply = <&vddcpu>;
>   		};
>   
>   		cpu3: cpu@3 {
> @@ -38,6 +41,7 @@ cpu3: cpu@3 {
>   			compatible = "arm,cortex-a35";
>   			reg = <0x0 0x3>;
>   			enable-method = "psci";
> +			cpu-supply = <&vddcpu>;
>   		};
>   	};
>   

Without a clock, this is useless.

Neil

