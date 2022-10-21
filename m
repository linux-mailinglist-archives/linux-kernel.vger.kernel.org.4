Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19FF607D78
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 19:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiJURZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 13:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbiJURZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 13:25:12 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4108766107;
        Fri, 21 Oct 2022 10:25:10 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id w74so4025304oie.0;
        Fri, 21 Oct 2022 10:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uU2xV/0eJNzQnhtR+ImVQXD3AapgCQJA6TByFZapDUo=;
        b=lQ1lkKZV3X7IjrcuDBeAvJjBIDTggOdehoSkKrYjC84OcnWtEo60VKFwYfpgGynfba
         lsP9qvx0MxdDMgN2+4uHbUiqUaqxXVgIHvXh8MBofVZGDbeDp5wgEm+DliMdzPw/EhRu
         +OgWw14elW7/1VS47okWwD36NP/HJ6of8sMWm4l8aJhnDmsB5l/6NBNkSSkiU5AghTAW
         zq1Jp+BduX+9g09VDIFU6Wd08glxgyxwtiiGTOl5Gf/SV6H+NFHXu4X6vGDBx/HY1NeD
         j+h4YFZy2vFrl2CP1e1gmFnD6TwvGVUkUKQhmTDUv0rG7Yx7VnrovKfQ9huuUCiKn39j
         HIjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uU2xV/0eJNzQnhtR+ImVQXD3AapgCQJA6TByFZapDUo=;
        b=4nuU68ix6kdcrWB5UkR69Iai8zDfNRqiRn4mDQ1k2WISOtlNfGvZKrDMD9BL9yFmDg
         RUD3v2jwvb+f9XTl84iW2Cn60xJPxiDKZJexlouuP9iAUFh3BAWV+VkVhHu5IDsj8qzo
         nP6JbdHgZ8yWqkwtspTyTISTna4S+fP8fYkKIzlUgKCy9KbzIEcoRB9SpefPnTFPLMv8
         BwyHTmG0r7IiR4yogVSxAwwBz1qCyQfW7Yy7GDLmgExt1QoXdGQYRcjHpk04Rp1EQcNz
         7js8C7LqYo1fk4SGpPJqivF6ReMKRTV/cHruUFS9IYG3gQ/mhj61taCBbcbOQ8WZSUbQ
         8ckw==
X-Gm-Message-State: ACrzQf1SSKbm7h6+Tx57fs9S/1MoJKE+2WtBITzmTypZKDnSsByYg1pF
        Xayfji1rB0mJ6sWoh26mUgU=
X-Google-Smtp-Source: AMsMyM6wQJpnbrOCZ/2JAKj/VhhX654hpUvzaAlvauILg9u0oA0wGy+OA87Y7qbG9/1ugeNt3IMO8A==
X-Received: by 2002:a54:4899:0:b0:354:add8:52ab with SMTP id r25-20020a544899000000b00354add852abmr11260314oic.229.1666373109465;
        Fri, 21 Oct 2022 10:25:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y206-20020acae1d7000000b00353ef11d6c9sm1318638oig.19.2022.10.21.10.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 10:25:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 21 Oct 2022 10:25:08 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-hwmon@vger.kernel.org, jdelvare@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] hwmon: (jc42) Restore the min/max/critical
 temperatures on resume
Message-ID: <20221021172508.GA1890395@roeck-us.net>
References: <20221021165000.1865615-1-martin.blumenstingl@googlemail.com>
 <20221021165000.1865615-3-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221021165000.1865615-3-martin.blumenstingl@googlemail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 06:50:00PM +0200, Martin Blumenstingl wrote:
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
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Nice use of regmap.

For my reference:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Thanks,
Guenter

> ---
>  drivers/hwmon/jc42.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/jc42.c b/drivers/hwmon/jc42.c
> index 8d70960d5444..52a60eb0791b 100644
> --- a/drivers/hwmon/jc42.c
> +++ b/drivers/hwmon/jc42.c
> @@ -565,6 +565,10 @@ static int jc42_suspend(struct device *dev)
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
> @@ -572,9 +576,13 @@ static int jc42_resume(struct device *dev)
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
> -- 
> 2.38.1
> 
