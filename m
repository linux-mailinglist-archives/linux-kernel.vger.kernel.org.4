Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79366671729
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 10:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjARJLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 04:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjARJKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 04:10:13 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4438769B37
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 00:29:30 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id iv8-20020a05600c548800b003db04a0a46bso972797wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 00:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FCQqfrft4nNMYWaf4oRTo5ElYIhffOhrEXz0Ei6E2KY=;
        b=OQFRPpW1P6EbBM0nhgrkuTB1o/48hyPGrfSk+caPmpM4wj9QIRHwtcGkzZSxxA1KoC
         hK/sOW3tjfLf7+26ygoRxl4FUrSzqblun8NNIH4PudEn6y9gj+X/Spy6s690+6QW5rdf
         3tO1tfNvPu0zeNQ+LMr7Rr3WBbDRUq8K9p4wlYrAZyK03VtqjB1ixFJxsNt+ElaMmqYo
         XXOti7Vu+TMfRp+O8lzWBTrRHS1mJMWZC92ig96gpYqNMOCfQ9u7L2BBWVJAPM8Oa00j
         xIPRd2WTAbpuJo23SDlpX52JXe2RRwwZ7KO+kPufpyB9214x9AkvOqIXYKBHtvYWSBUj
         pcjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FCQqfrft4nNMYWaf4oRTo5ElYIhffOhrEXz0Ei6E2KY=;
        b=Nn10AaaPmf6+acO1PPwL8NlEjlx/ieSR6tS9Yy1ggGe2DbDJbsjXq7aGSuRzSAZo1s
         RZ+T5xZI05mMWmvDl4ezjzOddVS6+O9ho+2hCbEPIjw7rLhy+PcNJ95cvmy4TAr7JbAA
         0WRn5d2s+OwTJbOoyHIi/U7PE9WFT8hPariRaCK1N+cigr4lteDSZ2ipUY//B0IwM/xy
         60MwBmbWfmvdP1T2DtL28V8x0b4521yVdAVlK6d+s7i9svecupT1KitVmIQpHGEAkMDR
         QycD6hh6jG9TgqxcSpNnRtwyAHzqT4uDalbPIKV+w5XEgpmEkDk9Y6tP++PPs+fL8wvQ
         BwRQ==
X-Gm-Message-State: AFqh2kqwJrE+jg0qRChavGvyo2N5fi2/YMkp68z9iHTXS6PAhlKc+9W7
        lgvaa2N0Pw8smA+VeZ0FjM9F8g==
X-Google-Smtp-Source: AMrXdXtvgIwDo0loMiZXyN3wNMfe5sPwfyDF3BLvMsN+tfAR+7RYoBd2yaB9EHThbSOJ6AhBhhN4/w==
X-Received: by 2002:a05:600c:3596:b0:3da:1357:4ca2 with SMTP id p22-20020a05600c359600b003da13574ca2mr5999266wmq.11.1674030567354;
        Wed, 18 Jan 2023 00:29:27 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:37dc:5071:959c:93e4? ([2a01:e0a:982:cbb0:37dc:5071:959c:93e4])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b003daff80f16esm1598134wmq.27.2023.01.18.00.29.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 00:29:26 -0800 (PST)
Message-ID: <b112ee8e-93ab-2c30-ced3-82ff858884b4@linaro.org>
Date:   Wed, 18 Jan 2023 09:29:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 7/9] arm64: dts: amlogic: Used onboard usb hub reset on
 odroid c4
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
 <20230118044418.875-8-linux.amoon@gmail.com>
Organization: Linaro Developer Services
In-Reply-To: <20230118044418.875-8-linux.amoon@gmail.com>
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
> On Odroid c4 previously use gpio-hog to reset the usb hub,
> switch to used on-board usb hub reset to enable the usb hub
> and enable power to hub.
> 
> USB hub is combination of USB 2.0 and USB 3.0 root hub so
> use peer-hub node to link then.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> v2: - fix the compatible string.
>      - Fix the hub node to use peer-hub to link the usb 2.0 and usb 3.0.
> ---
>   .../boot/dts/amlogic/meson-sm1-odroid-c4.dts  | 36 ++++++++++++-------
>   1 file changed, 23 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts
> index 8c30ce63686e..d04768a66bfe 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts
> @@ -26,20 +26,30 @@ led-blue {
>   	sound {
>   		model = "ODROID-C4";
>   	};
> -};
>   
> -&gpio {
> -	/*
> -	 * WARNING: The USB Hub on the Odroid-C4 needs a reset signal
> -	 * to be turned high in order to be detected by the USB Controller
> -	 * This signal should be handled by a USB specific power sequence
> -	 * in order to reset the Hub when USB bus is powered down.
> -	 */
> -	hog-0 {
> -		gpio-hog;
> -		gpios = <GPIOH_4 GPIO_ACTIVE_HIGH>;
> -		output-high;
> -		line-name = "usb-hub-reset";
> +	/* USB hub supports both USB 2.0 and USB 3.0 root hub */
> +	usb-hub {
> +		dr_mode = "host";

Is this really needed ?

> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		/* 2.0 hub on port 1 */
> +		hub_2_0: hub@1 {
> +			compatible = "usb2109,2817";
> +			reg = <1>;
> +			peer-hub = <&hub_3_0>;
> +			reset-gpios = <&gpio GPIOH_4 GPIO_ACTIVE_LOW>;
> +			vdd-supply = <&vcc_5v>;
> +		};
> +
> +		/* 3.1 hub on port 4 */
> +		hub_3_0: hub@2 {
> +			compatible = "usb2109,817";
> +			reg = <2>;
> +			peer-hub = <&hub_2_0>;
> +			reset-gpios = <&gpio GPIOH_4 GPIO_ACTIVE_LOW>;
> +			vdd-supply = <&vcc_5v>;
> +		};

The final discussion in v1 was to drop this /usb-hub node and move the
hub_2_0 & hub_3_0 node under the dwc3 node.

Neil

>   	};
>   };
>   

