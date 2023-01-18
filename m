Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C3A671716
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 10:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjARJH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 04:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjARJFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 04:05:23 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2C645BCF
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 00:27:12 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id k16so3421865wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 00:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wPklGmCKpWXW1sPBjuXeSY81LEryO5M2FkZvwa+g5bk=;
        b=y5gqCfEhei778A0yLVB+OCdWfWYH4YUVgnxsXfj+BGeYXksfO+yeTSKY2uy0sxVUrU
         omBm2V7VGDubcUxAWzkTOGLb0Ire4ccHjLmPu4umxaWM5ik+Zbnt4BH3r9ayP9Qh0nCI
         qp8M0Kus3QEFz9wE+WHvD4yVh0Lmu29N100tn+vM2pdMY+xQ1hj9aAWmHySUwbJXbKmy
         ekrEbPC/NeRt2+1GBu4CGsOpmb+nlyJCzAiA10ephtoEOocCZluoANXREPX7Ucx/lcBK
         6FFZMKO6qyTC5i/VF3PyMXDlKzcFoQm3fYXAfGFi4rx55r8NKVgcJwa6VzbRzKcC+A5c
         l0xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wPklGmCKpWXW1sPBjuXeSY81LEryO5M2FkZvwa+g5bk=;
        b=Y29kkoVqneMfS3KzvjjX6yCBtFTM7LRBcoHot00hUfUwjm5wKoK08ebhRoeK1iMFs1
         e/TFgY692QW2Zb9lMweCmdJlAKsa4yUnnh063m/BI/572Mz/1XXU4WEexkXZIP/iiw89
         84azfV/U87Z/cYSOBOQ07UvL9s8iBx9a8OxqY5qQ6ieaAZoc8qU0/Uc7b/I7uCC99VDc
         gCEapf7HqaX0/ZeSKTAyDDRVnzYNVdoABQ+buhphxz52v+yIrk/pXXZZlYtbFGzNH2NL
         YNxSDlkevIZPP5oitF0fPX0wezSStsrm8E+haEh9gwN7hFqN6QdpPb5Kb7nRVzPW/R74
         164g==
X-Gm-Message-State: AFqh2kqGklxaT4coYPCO9r2lza3VaoifZ80wn3bcC/AodqiCxG2ricfH
        Gj5MehWbhSbrAd+eqCbvh+SXVg==
X-Google-Smtp-Source: AMrXdXstS3MtA+pzDnK8u4CMcgqvZDe24SOYcHgjh7I+abxQ/HkeRlggDKfm7mWbesuJ3dS9ey9Fww==
X-Received: by 2002:a05:600c:4e05:b0:3c6:e61e:ae71 with SMTP id b5-20020a05600c4e0500b003c6e61eae71mr6025760wmq.1.1674030423378;
        Wed, 18 Jan 2023 00:27:03 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:37dc:5071:959c:93e4? ([2a01:e0a:982:cbb0:37dc:5071:959c:93e4])
        by smtp.gmail.com with ESMTPSA id o2-20020a05600c510200b003c6f8d30e40sm1302363wms.31.2023.01.18.00.27.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 00:27:02 -0800 (PST)
Message-ID: <3f0ade86-cab1-1f5a-fd49-326802473b76@linaro.org>
Date:   Wed, 18 Jan 2023 09:27:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 3/9] arm64: dts: amlogic: Used onboard usb hub reset on
 odroid c2
Content-Language: en-US
To:     Anand Moon <linux.amoon@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230118044418.875-1-linux.amoon@gmail.com>
 <20230118044418.875-4-linux.amoon@gmail.com>
Organization: Linaro Developer Services
In-Reply-To: <20230118044418.875-4-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2023 05:44, Anand Moon wrote:
> On Odroid c2 previously use gpio-hog to reset the usb hub,
> switch to used on-board usb hub reset to enable the usb hub
> and enable power to hub.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> v2 - drop the vendor name from compatible string.
>     - move the hub node to USB controller node.
>     - drop the usb_otg_pwr since it only liked to OTG port
>           and link p5v0 to the vdd-supply.
> ---
>   .../boot/dts/amlogic/meson-gxbb-odroidc2.dts  | 26 ++++++++-----------
>   1 file changed, 11 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> index 201596247fd9..01356437a077 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> @@ -250,21 +250,6 @@ eth_phy0: ethernet-phy@0 {
>   	};
>   };
>   
> -&gpio_ao {
> -	/*
> -	 * WARNING: The USB Hub on the Odroid-C2 needs a reset signal
> -	 * to be turned high in order to be detected by the USB Controller
> -	 * This signal should be handled by a USB specific power sequence
> -	 * in order to reset the Hub when USB bus is powered down.
> -	 */
> -	hog-0 {
> -		gpio-hog;
> -		gpios = <GPIOAO_4 GPIO_ACTIVE_HIGH>;
> -		output-high;
> -		line-name = "usb-hub-reset";
> -	};
> -};
> -
>   &hdmi_tx {
>   	status = "okay";
>   	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
> @@ -414,5 +399,16 @@ &usb0 {
>   };
>   
>   &usb1 {
> +	dr_mode = "host";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
>   	status = "okay";
> +
> +	hub@1 {
> +		/* Genesys Logic GL852G USB 2.0 hub */
> +		compatible = "usb5e3,610";
> +		reg = <1>;
> +		vdd-supply = <&p5v0>;
> +		reset-gpio = <&gpio_ao GPIOAO_4 GPIO_ACTIVE_LOW>;
> +	};
>   };

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
