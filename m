Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB9C671713
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 10:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjARJGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 04:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjARJFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 04:05:00 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB172D17D
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 00:26:45 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id iv8-20020a05600c548800b003db04a0a46bso969139wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 00:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HIpUx6UqHWkJ4zuJvTxUu8V93VcUMi8yc/wqvH0Omdg=;
        b=G0l67gl6kvyMGKR4WY+7lC6Fs144ntkeeyy8IBP8BmkT4EtFY763aPrfBV3u1rcI50
         EN+z+Etl4zPqcPxKuYNId0RuMPU5t0sysboAed/ueHM7Mk3sVxDGuli99WnwiS65PoV/
         xYvBBDD5a0fJdIoqRVaQTMRp8ScrDark5XkKaM6XlG5n5j73AF2qON0rBZp2tvC85OFv
         ofS1/eXM/6wSLZFNXvwKew0PKjvszjMv1mnYicA37SknRntqLsHUnnk3VSZRf5mJdyh9
         7mjIx3GhzEgk2N6uoccWW7c37taUlT6YCFNkA/cn1oHrNc3kfg6OiV18gdLABoGfVhjM
         NSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HIpUx6UqHWkJ4zuJvTxUu8V93VcUMi8yc/wqvH0Omdg=;
        b=rQspS5ysUT2FG74UAI/8FDxzUtJhMg/UMk2sixp3H0x16YUorznrgsP7Joz8T1OTlS
         Puenx4GH3XZD4QKJFVIwypQ3dngBZ182WkUn9t3gwoCJEIg0BQA3Ul+bSFz8BfTCo8Ee
         QKv7yymAeG1EHEftD1xgizS2JAAG3WEb4dRj/vxKTYBl4pLW3qO5+3NJpCrEOMIkradx
         7+F+AElHqNCfweoo7WgudvQs0caljD94HPdYvAH0+oj6BVG8WbdpzietRNTfTapJD+jD
         mEmsBYq87lRNLASvWdMVdJKIIYxWmx1wdNbD6NHXAAdAGqAoHcl5UOQm3Jcr7jUNuPj8
         vdGA==
X-Gm-Message-State: AFqh2kprS0k3MajGm6JMNib50wkXo3nvgpbVUIQm7WbVgT54PG+HN3dH
        pVvdtldOfyzRAHgxbWSwM5ybiw==
X-Google-Smtp-Source: AMrXdXtxBm2mv1p0bJ5Nyphmqp547N7dW7SQll7t+PfgPw+rdH+xTpqBsjPzMxXobNsBOaz7fM1eHA==
X-Received: by 2002:a1c:4c0a:0:b0:3db:210:6a24 with SMTP id z10-20020a1c4c0a000000b003db02106a24mr5678854wmf.8.1674030404004;
        Wed, 18 Jan 2023 00:26:44 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:37dc:5071:959c:93e4? ([2a01:e0a:982:cbb0:37dc:5071:959c:93e4])
        by smtp.gmail.com with ESMTPSA id k14-20020a05600c1c8e00b003d9ed40a512sm1576767wms.45.2023.01.18.00.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 00:26:43 -0800 (PST)
Message-ID: <21daccb8-9e27-af65-4b90-4bae062be559@linaro.org>
Date:   Wed, 18 Jan 2023 09:26:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 2/9] ARM: dts: amlogic: Used onboard usb hub reset to
 enable usb hub
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
 <20230118044418.875-3-linux.amoon@gmail.com>
Content-Language: en-US
Organization: Linaro Developer Services
In-Reply-To: <20230118044418.875-3-linux.amoon@gmail.com>
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
> On Odroid c1 previously use gpio-hog to reset the usb hub,
> switch to used on board usb hub reset to enable the usb hub
> and enable power to usb hub.
> 
> Add usb hub regulator as per the schematic.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> v2 - drop the vendor name from compatible string.
>     - move the hub node to USB controller node.
>     - drop the usb_otg_pwr since it only liked to OTG port
>       and link p5v0 to the vdd-supply.
> ---
>   arch/arm/boot/dts/meson8b-odroidc1.dts | 24 +++++++++++-------------
>   1 file changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
> index 04356bc639fa..d1f9ce4742a8 100644
> --- a/arch/arm/boot/dts/meson8b-odroidc1.dts
> +++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
> @@ -281,19 +281,6 @@ &gpio_ao {
>   			  "J7 Header Pin 6", "J7 Header Pin 5",
>   			  "J7 Header Pin 7", "HDMI_CEC",
>   			  "SYS_LED", "", "";
> -
> -	/*
> -	 * WARNING: The USB Hub on the Odroid-C1/C1+ needs a reset signal
> -	 * to be turned high in order to be detected by the USB Controller.
> -	 * This signal should be handled by a USB specific power sequence
> -	 * in order to reset the Hub when USB bus is powered down.
> -	 */
> -	usb-hub {
> -		gpio-hog;
> -		gpios = <GPIOAO_4 GPIO_ACTIVE_HIGH>;
> -		output-high;
> -		line-name = "usb-hub-reset";
> -	};
>   };
>   
>   &ir_receiver {
> @@ -381,5 +368,16 @@ &usb1_phy {
>   };
>   
>   &usb1 {
> +	dr_mode = "host";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
>   	status = "okay";
> +
> +	hub@1 {
> +		/* Genesys Logic GL852G usb hub */
> +		compatible = "usb5e3,610";
> +		reg = <1>;
> +		vdd-supply = <&p5v0>;
> +		reset-gpio = <&gpio_ao GPIOAO_4 GPIO_ACTIVE_LOW>;
> +	};
>   };

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
