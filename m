Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7246BA89A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 08:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjCOHEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 03:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbjCOHES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 03:04:18 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3F317168;
        Wed, 15 Mar 2023 00:04:11 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id bi9so884465lfb.12;
        Wed, 15 Mar 2023 00:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678863849;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pJ8fAecpN0Qq1PSweyGZ9QIg3aw/gnG1ix8SMwm2828=;
        b=MAeRIROMZHSXUX9tKKJRxEl+qEL6Xo+hFPCMPuW+j7uWZMn6goS12PMycCKTew7kZI
         mZ46GJQyFswIbKOjBJhx/AsgM/Iy9C7BUiWZ4NICLWVrkXTOL4CP+Q8/KFPvEA2mx5ih
         GNTGnf+Bubbpl2DmLNvKQ5aIuT5C2YAyyXv6wk9LpZkU+apxNUFWuls7+KN0tAlZ/wkN
         xVFEvALjDfljusdEmxr/CKJUIfWxf2wYbR4Ln+hXtcWFcbJgZgBcbrvykVpUGyuSCUcW
         GWL2UiTyuu2ZRT5WEAvQ0ABqjBSk3g0BEY8HS4h96LJuCqNwO3Cz46BQ0vXNRhLiL7FM
         Bz+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678863849;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pJ8fAecpN0Qq1PSweyGZ9QIg3aw/gnG1ix8SMwm2828=;
        b=Y+GYrdVBgl9dJEZn6EIFbHTUNyRZpiJhiArCMTC2GOvgO1986w7bsQFitVja/xGvYn
         /yYO34LyKEdvCZ8y2j1VhsIxRt40gHtnebgXwJC4AspGzlJLS4JBHHgrwkWgGxLKL54G
         VR/9HalneXhT/6GRJUWKuPxHB/PIC58y1QN4BrhghWfUEWeGNwTqh0uBSC66j6+z6eJ0
         FbuC//tBUQlA4JT+8QqDWBec0+dfhchXsm0hRMpJRwuXDwqqvk7fSrkJzkPLBwIE6fdA
         tmyUoxoWB780i4IdNP2ibZ8vQ60YPm9iqB2R/h1tVbAgjVDNulIOiwWoW9LJvsyOHjWH
         KE5A==
X-Gm-Message-State: AO0yUKWrvwvJ/0NOKq1IrVLve77EhKmvbxWQHNShKEs7qsie0sGV3Zju
        +0zpuE9guoRtjAM7AeS7VSQ=
X-Google-Smtp-Source: AK7set8OE1TNHAjlPD+NRd4eeuIx74N/qXP/8XLXAuIOAwRgC5zpT8CT5ORl6zhzcKvwZKXWBIvgrw==
X-Received: by 2002:a05:6512:970:b0:4b9:a91c:b0c9 with SMTP id v16-20020a056512097000b004b9a91cb0c9mr1585548lft.7.1678863849430;
        Wed, 15 Mar 2023 00:04:09 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::6? (dc75zzyyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::6])
        by smtp.gmail.com with ESMTPSA id q11-20020a19a40b000000b00497a61453a9sm710471lfc.243.2023.03.15.00.04.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 00:04:09 -0700 (PDT)
Message-ID: <007d1471-6232-40a3-c938-e0062da9ef6d@gmail.com>
Date:   Wed, 15 Mar 2023 09:04:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCHv2 10/12] power: supply: generic-adc-battery: add
 temperature support
Content-Language: en-US, en-GB
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20230314225535.1321736-1-sre@kernel.org>
 <20230314225535.1321736-11-sre@kernel.org>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20230314225535.1321736-11-sre@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/23 00:55, Sebastian Reichel wrote:
> From: Sebastian Reichel <sebastian.reichel@collabora.com>
> 
> Another typical thing to monitor via an ADC line is
> the battery temperature.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

> ---
>   drivers/power/supply/generic-adc-battery.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
> index 4811e72df8cd..0124d8d51af7 100644
> --- a/drivers/power/supply/generic-adc-battery.c
> +++ b/drivers/power/supply/generic-adc-battery.c
> @@ -30,6 +30,7 @@ enum gab_chan_type {
>   	GAB_VOLTAGE = 0,
>   	GAB_CURRENT,
>   	GAB_POWER,
> +	GAB_TEMP,
>   	GAB_MAX_CHAN_TYPE
>   };
>   
> @@ -40,7 +41,8 @@ enum gab_chan_type {
>   static const char *const gab_chan_name[] = {
>   	[GAB_VOLTAGE]	= "voltage",
>   	[GAB_CURRENT]	= "current",
> -	[GAB_POWER]		= "power",
> +	[GAB_POWER]	= "power",
> +	[GAB_TEMP]	= "temperature",
>   };
>   
>   struct gab {
> @@ -77,6 +79,7 @@ static const enum power_supply_property gab_dyn_props[] = {
>   	POWER_SUPPLY_PROP_VOLTAGE_NOW,
>   	POWER_SUPPLY_PROP_CURRENT_NOW,
>   	POWER_SUPPLY_PROP_POWER_NOW,
> +	POWER_SUPPLY_PROP_TEMP,
>   };
>   
>   static bool gab_charge_finished(struct gab *adc_bat)
> @@ -115,6 +118,8 @@ static int gab_get_property(struct power_supply *psy,
>   		return read_channel(adc_bat, GAB_CURRENT, &val->intval);
>   	case POWER_SUPPLY_PROP_POWER_NOW:
>   		return read_channel(adc_bat, GAB_POWER, &val->intval);
> +	case POWER_SUPPLY_PROP_TEMP:
> +		return read_channel(adc_bat, GAB_TEMP, &val->intval);
>   	default:
>   		return -EINVAL;
>   	}

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

