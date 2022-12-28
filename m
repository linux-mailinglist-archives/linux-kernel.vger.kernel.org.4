Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162AA658515
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 18:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235297AbiL1RGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 12:06:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235247AbiL1RFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 12:05:52 -0500
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E52B1C407;
        Wed, 28 Dec 2022 09:01:14 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1447c7aa004so19083316fac.11;
        Wed, 28 Dec 2022 09:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0z20RMJFxTAl1qmZsHBxinhA5F3ohuVNdmbw+1zaGAw=;
        b=ozF+9nibkyA7J5/VkvQVdWayCJm0KWE0M7mlNyrhR2Y9TRA0CasK/oH6SskQyEHLf0
         wgUPdvStv1fMUTckWbgEr9Vp5mfbz9QDg7ocXiaWYg7aFEyWjCI27C8sGY8GHnMz5yXv
         21g5v7Hcw52nlhEGUnDWjP4QFu+b1URej8Q6iwcZSVbY/I9wKTkZGruAr2jEaiSNA8zz
         dgDX6JQc/HId3AC95D+QyVgMdrI6z0drYtvnTzZ1UQlLxPBI0y34J76rlbjAp/ZkspQm
         jn/ijBn8gJnkMyBVVOGDjKNqvE9n6k+sftkR+64Ijq+SIJHwpdK+pmJgIdiZLxULCHde
         ftaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0z20RMJFxTAl1qmZsHBxinhA5F3ohuVNdmbw+1zaGAw=;
        b=OlRZ+iLeQp6gxDtyML4bO4z8l9ifxi3I5+bGxNSRXn+UEUOwoXGKBxOsYBiXF+8ntL
         tSYazPNLAtKqjlgKR1Oid9yglF8fxreVcv4Vop/1kWrx+MC6wqSGk5oTtV+PCVTaNurs
         HDhQ9bD4SKtbEjSeLr3qx+w/dUBL4JFAQn0lNGjYb+GDozs+KPLEym6aL6D+ekeUvyHF
         suxSAJ0oAdFZFSe+z7z7n8aFWMGJJbiejJmHeVC0N3olqrynru8sIRgSIElN/EC5ya9T
         NUDWIU814/+v7jGAjWuYFojGLUWTxoQPH4S7XRHarJRa8opzXsG7BD3t0xM6zHPRWzWD
         /Siw==
X-Gm-Message-State: AFqh2kposwsN9umhOQgj3OBK27B9nytFqGqOp2DvhTznL50fibgnKNSk
        qaqOE0GkAaBxUEj2531y1DA=
X-Google-Smtp-Source: AMrXdXtcbQCBxtL/eFMjPoMUBNM1vOZuyflLPHGSQ2MhsNLOdZ1ewutsdrKYEl8xABKBh7dVMWKeEQ==
X-Received: by 2002:a05:6871:209:b0:144:fa85:7a6a with SMTP id t9-20020a056871020900b00144fa857a6amr14107502oad.15.1672246872537;
        Wed, 28 Dec 2022 09:01:12 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u3-20020a056871008300b0010d7242b623sm7573181oaa.21.2022.12.28.09.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 09:01:12 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 28 Dec 2022 09:01:10 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Cormier, Jonathan" <jcormier@criticallink.com>
Cc:     linux-hwmon@vger.kernel.org,
        John Pruitt <jpruitt@criticallink.com>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bob Duke <bduke@criticallink.com>
Subject: Re: [PATCH v2 4/4] hwmon: ltc2945: Fix possible overflows
Message-ID: <20221228170110.GC1267483@roeck-us.net>
References: <20221214220727.1350784-1-jcormier@criticallink.com>
 <20221220000457.1163446-1-jcormier@criticallink.com>
 <20221220000457.1163446-5-jcormier@criticallink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220000457.1163446-5-jcormier@criticallink.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 07:04:57PM -0500, Cormier, Jonathan wrote:
> From: John Pruitt <jpruitt@criticallink.com>
> 
> Use 64-bit values for intermediate calculations. Check for
> overflows and return INT_MAX if overflows happened.
> 
> Signed-off-by: John Pruitt <jpruitt@criticallink.com>
> Signed-off-by: "Cormier, Jonathan" <jcormier@criticallink.com>

The problems here are introduced with the previous patch
and thus would need a Fixes: tag. It just doesn't make sense
to submit that as separate patch.

> ---
>  drivers/hwmon/ltc2945.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwmon/ltc2945.c b/drivers/hwmon/ltc2945.c
> index fc7d399b2c85..7239422fc6db 100644
> --- a/drivers/hwmon/ltc2945.c
> +++ b/drivers/hwmon/ltc2945.c
> @@ -126,6 +126,10 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
>  		}
>  		val *= 1000;
>  		val = DIV_ROUND_CLOSEST_ULL(val, shunt_resistor);
> +		/* check for overflow, use MAX value if it happened */
> +		if (val > INT_MAX)
> +			val = INT_MAX;
> +

ltc2945_reg_to_val returns long long, and the calling code expects long long.
How would this ever overflow ?

>  		break;
>  	case LTC2945_VIN_H:
>  	case LTC2945_MAX_VIN_H:
> @@ -159,12 +163,14 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
>  }
> 
>  static int ltc2945_val_to_reg(struct device *dev, u8 reg,
> -			      unsigned long val)
> +			      unsigned long val_32)
>  {
>  	struct ltc2945_data *data = dev_get_drvdata(dev);
>  	struct regmap *regmap = data->regmap;
>  	u32 shunt_resistor = data->shunt_resistor;
>  	unsigned int control;
> +	/* use 64-bit val for intermediate calculations */
> +	unsigned long long val = val_32;

This is unnnecessary. The parameter can be unsigned long long,
making the conversion automatic.

>  	int ret;
> 
>  	switch (reg) {
> @@ -184,7 +190,7 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
>  		if (control & CONTROL_MULT_SELECT) {
>  			/* 25 mV * 25 uV = 0.625 uV resolution. */
>  			val *= shunt_resistor;
> -			val = DIV_ROUND_CLOSEST(val, 625 * 1000);
> +			val = DIV_ROUND_CLOSEST_ULL(val, 625LL * 1000LL);
>  		} else {
>  			/*
>  			 * 0.5 mV * 25 uV = 0.0125 uV resolution.
> @@ -192,7 +198,7 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
>  			 * accept loss of accuracy.
>  			 */
>  			val *= shunt_resistor;
> -			val = DIV_ROUND_CLOSEST(val, 25 * 1000) * 2;
> +			val = DIV_ROUND_CLOSEST_ULL(val, 25LL * 1000LL) * 2;
>  		}
>  		break;
>  	case LTC2945_VIN_H:
> @@ -201,7 +207,7 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
>  	case LTC2945_MAX_VIN_THRES_H:
>  	case LTC2945_MIN_VIN_THRES_H:
>  		/* 25 mV resolution. */
> -		val /= 25;
> +		val = DIV_ROUND_CLOSEST_ULL(val, 25LL);

Unrelated change causing behavioral change. Not that I mind, but it is
still unrelated and would have to be a separate patch.

>  		break;
>  	case LTC2945_ADIN_H:
>  	case LTC2945_MAX_ADIN_H:
> @@ -218,11 +224,15 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
>  	case LTC2945_MIN_SENSE_THRES_H:
>  		/* 25 uV resolution. Convert to  mA. */
>  		val *= shunt_resistor;
> -		val = DIV_ROUND_CLOSEST(val, 25 * 1000);
> +		val = DIV_ROUND_CLOSEST_ULL(val, 25LL * 1000LL);
>  		break;
>  	default:
>  		return -EINVAL;
>  	}
> +	/* If val is too large, just return the max value */
> +	if (val > INT_MAX)
> +		return INT_MAX;
> +

While the return value is declared as int, the calling code expects
unsigned long. It would be better to adjust the return value and clamp
against ULONG_MAX.

>  	return val;
>  }
> 
> --
> 2.25.1
