Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F9A657A3C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 16:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbiL1PJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 10:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233640AbiL1PJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 10:09:03 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364CA13DDC
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 07:09:02 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id bf43so23984350lfb.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 07:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gmtzdmo2KThie2rygVM6gP58Xp8wt3BXaHi7Yl4AiAo=;
        b=aIEQthuYYFP2u5JfqSwCIwrX6pmtwHj4uKu/TPmyjwKjHetmAFuw1XODvI1ksigK6G
         lz4x4V1+LYWrS69Y7O4l7UAptRwq8w54nAbS3h4FHQU60AdvnHf5zIHeMwDi2Hl8tzIY
         8BD6fwiT1k3PCDLPgDc0TTRJsFUy9jE9qZ3KsBOaY0BuqnIvtYZar456VJkxwhR14T9C
         r+QfzJY/nYQ1YPRC/chI+6lsVhqlvOY+unQY3iiY/CDbz/PJ32LxMjdPrpKdpcpcqeEJ
         /gVcMA3swWTHHi8wD7MCjpw2nnZVBNrwNGQkM3unZSatZm2JCRD6kGqJVggh70z6FKUC
         mqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gmtzdmo2KThie2rygVM6gP58Xp8wt3BXaHi7Yl4AiAo=;
        b=KEUSS77Lfqo9hojPnP4n70ryoE4F9NpAYGGDBLvtbpOkkja6rr+P78nHm/QRDCdwG6
         0SqR97zO8LRsMPTBYzxIcFd95MmIntnJzbxaOMgZopyw2DyG4tN/wLDvAFkHEw5vaO+x
         h9LNam2/K2jHMgqGfGurGakLMwvEmBBy+03p1o5wCZB3PMKQG2VdlNBcCjw7nn9Hy8Qy
         Di8OpsM9YGwE4ZTuQMreYbqEn99mfCLlAkiZaJJQrI0Bz8qM2VWM7WbXl30pD8js6ZTM
         vAMF4etv7SmQrMITj4jbV8pGJXF68fivrGH9ceB1/WiQcPgV//GMRvPhEl/GBO0J9tGL
         meWA==
X-Gm-Message-State: AFqh2kpTgcMbccDsDbTdrB/Imaw2WD2CecnALuRG0+dKONo2mkcnBfad
        Wi9RgRmNBOB0wtwC+RVhxvDBmA==
X-Google-Smtp-Source: AMrXdXtpRI5PKCqyRot0pgpuz1wAaTYR67+7gZgy3rUY+4sjGmfy+SH5CBZzaltjcR2FFjL39uNMfw==
X-Received: by 2002:a05:6512:2008:b0:4b6:ed8b:4f17 with SMTP id a8-20020a056512200800b004b6ed8b4f17mr6598667lfb.51.1672240140575;
        Wed, 28 Dec 2022 07:09:00 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p9-20020ac24ec9000000b004caffc90c29sm232333lfr.55.2022.12.28.07.08.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Dec 2022 07:09:00 -0800 (PST)
Message-ID: <c5b0e7e3-7e74-308f-a64b-f472acd670eb@linaro.org>
Date:   Wed, 28 Dec 2022 16:08:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 02/11] ARM: dts: amlogic: Used onboard usb hub reset to
 enable usb hub
Content-Language: en-US
To:     Anand Moon <linux.amoon@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221228100321.15949-1-linux.amoon@gmail.com>
 <20221228100321.15949-3-linux.amoon@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221228100321.15949-3-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/12/2022 11:03, Anand Moon wrote:
> On Odroid c1 previously use gpio-hog to reset the usb hub,
> switch to used on board usb hub reset to enable the usb hub
> and enable power to usb hub.
> 
> Add usb hub regulator as per the schematic.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  arch/arm/boot/dts/meson8b-odroidc1.dts | 40 +++++++++++++++++---------
>  1 file changed, 27 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
> index 04356bc639fa..3b29169aac43 100644
> --- a/arch/arm/boot/dts/meson8b-odroidc1.dts
> +++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
> @@ -185,6 +185,33 @@ vdd_rtc: regulator-vdd-rtc {
>  
>  		vin-supply = <&vcc_3v3>;
>  	};
> +
> +	usb_otg_pwr: regulator-usb-pwrs {
> +		compatible = "regulator-fixed";
> +		regulator-name = "USB_OTG_PWR";
> +
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +
> +		/* signal name from schematics: PWREN */
> +		gpio = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		vin-supply = <&p5v0>;
> +	};
> +
> +	usb {
> +		dr_mode = "host";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		hub@1 {
> +			/* Genesys Logic GL852G-OHG usb hub */
> +			compatible = "genesys,usb5e3,610";

Wrong compatible. Does not match pattern in usb-device.yaml.


Best regards,
Krzysztof

