Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2AD60E416
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 17:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234453AbiJZPGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 11:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbiJZPGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 11:06:42 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058FF10A7CD;
        Wed, 26 Oct 2022 08:06:42 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-13b6c1c89bdso14520341fac.13;
        Wed, 26 Oct 2022 08:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k0LK9u8XJtE34YRMppExjpqw6XCtzWuWp+A28eDwlPc=;
        b=MzTsyzC8A6URqJFUiRx9rCxfCk/++opZxMtVJv4OD3svRDwkMMCU4UrDY3Z61o3Dsv
         opMHNSBNx7i0oK41FUusYltQvD6yErUO+Mioso1R8wS02JrSiHHfWTff/4/fgPXDmFVN
         7DJRiIaJT55jOFenT5cUHhLQsNp8AtGAgcxWclV/pOO7eFPfsxQEzvY1Pqc4Bf5k2Aip
         v6lh/paXIINe2x2Bag5xhI+2CMfFT2WvS/sMKhDbudsPNiyhslheobIZjI2L28xwKlu4
         3Az8P5mJNUP6dO2ey82+kgQa5tGq9mriKu1Pr7ig/+/zRiMi2gT1GWQJmWsWOzavzaX0
         hKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k0LK9u8XJtE34YRMppExjpqw6XCtzWuWp+A28eDwlPc=;
        b=TdRidvGTDzs/6n1fK8G6Zse7VUIZwgS8jY/JSJJvzwT9IkcJu/NooAfqeJBU+e5Zzm
         ooLoPwIK/u1rmpq9prmFgcP2Trfow/c5MBqWzswh7M/h3bl1x/LLhznuDGzQp85sNz5C
         X2WprqASA2C6xHZLlMmpka5/EjINv91RdjBzD0JjtepY3kwmNnHcQHFb06t8/BLUaRoD
         yNY09uKwpW5A6gsmv3a0Do5ewxL0jnD8VAXXZCKrPdxxmCozyDgOqApys0kmbqxnm/51
         jKToy4zU0vTpVT4TGaaVSuoagcJMRRAfF4S758nmXFwJS8gZQA4RCZVQO+vquCM52Njc
         pHrg==
X-Gm-Message-State: ACrzQf1peK4dh1gRDPzzmUwkBhIK1BkfHaNdICJFFbzIqaFNq7em1DVH
        1ZYWFpBA5gsZzgoRO/cRdOk=
X-Google-Smtp-Source: AMsMyM6ZylsdBQYhTx7bBGXb+NMjeR5s6oWPc5YEaDA9CbqHlkDu/AK3CsrZVUcwvVcRB2ZyoLuZvw==
X-Received: by 2002:a05:6870:b155:b0:132:bf4:d451 with SMTP id a21-20020a056870b15500b001320bf4d451mr2345401oal.160.1666796801265;
        Wed, 26 Oct 2022 08:06:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k16-20020a056870d39000b0011dca1bd2cdsm3235736oag.0.2022.10.26.08.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 08:06:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 26 Oct 2022 08:06:39 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-hwmon@vger.kernel.org, jdelvare@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] hwmon: (jc42) Restore the min/max/critical
 temperatures on resume
Message-ID: <20221026150639.GA2546475@roeck-us.net>
References: <20221023213157.11078-1-martin.blumenstingl@googlemail.com>
 <20221023213157.11078-3-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221023213157.11078-3-martin.blumenstingl@googlemail.com>
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

On Sun, Oct 23, 2022 at 11:31:57PM +0200, Martin Blumenstingl wrote:
> The JC42 compatible thermal sensor on Kingston KSM32ES8/16ME DIMMs
> (using Micron E-Die) is an ST Microelectronics STTS2004 (manufacturer
> 0x104a, device 0x2201). It does not keep the previously programmed
> minimum, maximum and critical temperatures after system suspend and
> resume (which is a shutdown / startup cycle for the JC42 temperature
> sensor). This results in an alarm on system resume because the hardware
> default for these values is 0°C (so any environment temperature greater
> than 0°C will trigger the alarm).
> 
> Example before system suspend:
>   jc42-i2c-0-1a
>   Adapter: SMBus PIIX4 adapter port 0 at 0b00
>   temp1:        +34.8°C  (low  =  +0.0°C)
>                          (high = +85.0°C, hyst = +85.0°C)
>                          (crit = +95.0°C, hyst = +95.0°C)
> 
> Example after system resume (without this change):
>   jc42-i2c-0-1a
>   Adapter: SMBus PIIX4 adapter port 0 at 0b00
>   temp1:        +34.8°C  (low  =  +0.0°C)             ALARM (HIGH, CRIT)
>                          (high =  +0.0°C, hyst =  +0.0°C)
>                          (crit =  +0.0°C, hyst =  +0.0°C)
> 
> Apply the cached values from the JC42_REG_TEMP_UPPER,
> JC42_REG_TEMP_LOWER, JC42_REG_TEMP_CRITICAL and JC42_REG_SMBUS (where
> the SMBUS register is not related to this issue but a side-effect of
> using regcache_sync() during system resume with the previously
> cached/programmed values. This fixes the alarm due to the hardware
> defaults of 0°C because the previously applied limits (set by userspace)
> are re-applied on system resume.
> 
> Fixes: 175c490c9e7f ("hwmon: (jc42) Add support for STTS2004 and AT30TSE004")
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/jc42.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/jc42.c b/drivers/hwmon/jc42.c
> index 355639d208d0..0554b41c32bc 100644
> --- a/drivers/hwmon/jc42.c
> +++ b/drivers/hwmon/jc42.c
> @@ -578,6 +578,10 @@ static int jc42_suspend(struct device *dev)
>  
>  	data->config |= JC42_CFG_SHUTDOWN;
>  	regmap_write(data->regmap, JC42_REG_CONFIG, data->config);
> +
> +	regcache_cache_only(data->regmap, true);
> +	regcache_mark_dirty(data->regmap);
> +
>  	return 0;
>  }
>  
> @@ -585,9 +589,13 @@ static int jc42_resume(struct device *dev)
>  {
>  	struct jc42_data *data = dev_get_drvdata(dev);
>  
> +	regcache_cache_only(data->regmap, false);
> +
>  	data->config &= ~JC42_CFG_SHUTDOWN;
>  	regmap_write(data->regmap, JC42_REG_CONFIG, data->config);
> -	return 0;
> +
> +	/* Restore cached register values to hardware */
> +	return regcache_sync(data->regmap);
>  }
>  
>  static const struct dev_pm_ops jc42_dev_pm_ops = {
