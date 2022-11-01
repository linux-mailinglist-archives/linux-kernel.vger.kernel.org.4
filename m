Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223B9614C81
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 15:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiKAOYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 10:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiKAOYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 10:24:17 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71001DF0D;
        Tue,  1 Nov 2022 07:24:16 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id c129so4239584oia.0;
        Tue, 01 Nov 2022 07:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EE0XcLJ7tlN4+Gpra1p2zrGH2q6ua0PePgQYbA+K560=;
        b=DIajBAMGMWeuqFX4ECPGYXQt2mnWe9JsLo0tFIQguvTOIWw1i/1GbsIaqzOID9F6F/
         jXADbeBlMJKUQl3gq8Owo+Hbl8X8fwQTOl24NI9O+CRZNeodjRruBnxdwrwV5Pl2OENL
         aY+aHbs/FwQypmsjr4y8lE2NKRSeL1i0qqF8wZHMTIBfy7apfK8Oqf8Mk8OtZuGs/ZwV
         khJORYBPewNC3k6AbTgfqvD1+nQleJEf2Cqvi7f/MIHaIn5KzyJHTneV/FtsopmcY/dt
         P2jJQVq4azPQwNnHM0IlbNrOx0s+Hk/vnpPaz8IVyU52FdMaQsZMVhGzoYDd6nXI4cRf
         fSVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EE0XcLJ7tlN4+Gpra1p2zrGH2q6ua0PePgQYbA+K560=;
        b=s1Q+Z3tQxoFgkpO9DrH34xQfV50gTJOfeBvvod7EUdvv3CvMRsIZW2+a+YfxsBSzNO
         APUT+V8KTp9xWNFA1E1R2IjqREGBhbDIx9BPZbVfCqEwUZGoAsJl6um+E0gvx4koFCxY
         B5Ys8baIMBhlWDQpBzTplSVD0Whc6sr0/WaZc2iI8RuDqiyOOWd9P5Wtov1QfxU0+u9P
         u0Qtns2fE2hssd2oP8XiV6nbAscLdQiT15bnMNob5itsLQ0iPva3LfYVh1Khltt/UDyM
         L2XEnX7HhRMBdF5GTq9SDRW6vixFTeMIMLPlulnEYE1sa7BVgVBBEFpI3ZPfBq3bBn/3
         5+JA==
X-Gm-Message-State: ACrzQf2hZfVc5m039PZItbRFWBxwjirkRRuDJsnxp/rMpz+cDBwb9J0K
        EnngdNnaj7vywrOIdsqsnkU=
X-Google-Smtp-Source: AMsMyM5IxquE+OZpBIsfcHw6qDWYNbcJWxyCu6FxqzGQ6Ib8KFFth9M+bGmQPSZlc+EovzWuEDUIgQ==
X-Received: by 2002:a05:6808:1207:b0:353:e6cf:6d46 with SMTP id a7-20020a056808120700b00353e6cf6d46mr10197966oil.207.1667312655700;
        Tue, 01 Nov 2022 07:24:15 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d11-20020a9d5e0b000000b00660e833baddsm3912980oti.29.2022.11.01.07.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 07:24:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 1 Nov 2022 07:24:12 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-hwmon@vger.kernel.org, jdelvare@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (jc42) Consistently use bit and bitfield macros
 in the driver
Message-ID: <20221101142412.GA1311621@roeck-us.net>
References: <20221031215140.482457-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031215140.482457-1-martin.blumenstingl@googlemail.com>
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

On Mon, Oct 31, 2022 at 10:51:40PM +0100, Martin Blumenstingl wrote:
> Use BIT() and GENMASK() macros for defining the bitfields inside the
> registers. Also use FIELD_GET() and FIELD_PREP() where appropriate. This
> makes the coding style within the driver consistent. No functional
> changes intended.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
> This is a small patch with what I consider non-functional improvements.
> It makes the driver code consistent with what I am familiar with from
> other drivers (not limited to hwmon).
> So I'm curious if others also feel that this is an improvement.
> 

I like it. I'll queue it up for 6.2.

Guenter

> 
>  drivers/hwmon/jc42.c | 36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/hwmon/jc42.c b/drivers/hwmon/jc42.c
> index 6593d81cb901..8523bf974310 100644
> --- a/drivers/hwmon/jc42.c
> +++ b/drivers/hwmon/jc42.c
> @@ -10,6 +10,7 @@
>   */
>  
>  #include <linux/bitops.h>
> +#include <linux/bitfield.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/slab.h>


> @@ -37,20 +38,19 @@ static const unsigned short normal_i2c[] = {
>  #define JC42_REG_SMBUS		0x22 /* NXP and Atmel, possibly others? */
>  
>  /* Status bits in temperature register */
> -#define JC42_ALARM_CRIT_BIT	15
> -#define JC42_ALARM_MAX_BIT	14
> -#define JC42_ALARM_MIN_BIT	13
> +#define JC42_ALARM_CRIT		BIT(15)
> +#define JC42_ALARM_MAX		BIT(14)
> +#define JC42_ALARM_MIN		BIT(13)
>  
>  /* Configuration register defines */
> -#define JC42_CFG_CRIT_ONLY	(1 << 2)
> -#define JC42_CFG_TCRIT_LOCK	(1 << 6)
> -#define JC42_CFG_EVENT_LOCK	(1 << 7)
> -#define JC42_CFG_SHUTDOWN	(1 << 8)
> -#define JC42_CFG_HYST_SHIFT	9
> -#define JC42_CFG_HYST_MASK	(0x03 << 9)
> +#define JC42_CFG_CRIT_ONLY	BIT(2)
> +#define JC42_CFG_TCRIT_LOCK	BIT(6)
> +#define JC42_CFG_EVENT_LOCK	BIT(7)
> +#define JC42_CFG_SHUTDOWN	BIT(8)
> +#define JC42_CFG_HYST_MASK	GENMASK(10, 9)
>  
>  /* Capabilities */
> -#define JC42_CAP_RANGE		(1 << 2)
> +#define JC42_CAP_RANGE		BIT(2)
>  
>  /* Manufacturer IDs */
>  #define ADT_MANID		0x11d4  /* Analog Devices */
> @@ -277,8 +277,8 @@ static int jc42_read(struct device *dev, enum hwmon_sensor_types type,
>  			break;
>  
>  		temp = jc42_temp_from_reg(regval);
> -		hyst = jc42_hysteresis[(data->config & JC42_CFG_HYST_MASK)
> -						>> JC42_CFG_HYST_SHIFT];
> +		hyst = jc42_hysteresis[FIELD_GET(JC42_CFG_HYST_MASK,
> +						 data->config)];
>  		*val = temp - hyst;
>  		break;
>  	case hwmon_temp_crit_hyst:
> @@ -288,8 +288,8 @@ static int jc42_read(struct device *dev, enum hwmon_sensor_types type,
>  			break;
>  
>  		temp = jc42_temp_from_reg(regval);
> -		hyst = jc42_hysteresis[(data->config & JC42_CFG_HYST_MASK)
> -						>> JC42_CFG_HYST_SHIFT];
> +		hyst = jc42_hysteresis[FIELD_GET(JC42_CFG_HYST_MASK,
> +						 data->config)];
>  		*val = temp - hyst;
>  		break;
>  	case hwmon_temp_min_alarm:
> @@ -297,21 +297,21 @@ static int jc42_read(struct device *dev, enum hwmon_sensor_types type,
>  		if (ret)
>  			break;
>  
> -		*val = (regval >> JC42_ALARM_MIN_BIT) & 1;
> +		*val = FIELD_GET(JC42_ALARM_MIN, regval);
>  		break;
>  	case hwmon_temp_max_alarm:
>  		ret = regmap_read(data->regmap, JC42_REG_TEMP, &regval);
>  		if (ret)
>  			break;
>  
> -		*val = (regval >> JC42_ALARM_MAX_BIT) & 1;
> +		*val = FIELD_GET(JC42_ALARM_MAX, regval);
>  		break;
>  	case hwmon_temp_crit_alarm:
>  		ret = regmap_read(data->regmap, JC42_REG_TEMP, &regval);
>  		if (ret)
>  			break;
>  
> -		*val = (regval >> JC42_ALARM_CRIT_BIT) & 1;
> +		*val = FIELD_GET(JC42_ALARM_CRIT, regval);
>  		break;
>  	default:
>  		ret = -EOPNOTSUPP;
> @@ -370,7 +370,7 @@ static int jc42_write(struct device *dev, enum hwmon_sensor_types type,
>  				hyst = 3;	/* 6.0 degrees C */
>  		}
>  		data->config = (data->config & ~JC42_CFG_HYST_MASK) |
> -				(hyst << JC42_CFG_HYST_SHIFT);
> +				FIELD_PREP(JC42_CFG_HYST_MASK, hyst);
>  		ret = regmap_write(data->regmap, JC42_REG_CONFIG,
>  				   data->config);
>  		break;
> -- 
> 2.38.1
> 
