Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E2B63DCAC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 19:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiK3SGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 13:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiK3SGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 13:06:46 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E7B7463E;
        Wed, 30 Nov 2022 10:06:45 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-142b72a728fso21945107fac.9;
        Wed, 30 Nov 2022 10:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4qOLqjoCvwfes3GQmLgLoYg/ASG8k1yJH17Rxdih0SY=;
        b=kE5G3GxdSPqfrcLgxjyjPNqXNQCCnSanobhJICb53P3pKWlKwNQyZaZFzYvZmug4vO
         615FCthVRwTMDoZ489UmNbudcB9H5zye46Wcivpq5uL3pw8SzTbXu3b2jOBL178ABJpW
         kU0XBPk17lHVIHtkZ7vi7tr+rMCbQBDEQw731FYEQZG1KEltaGGNUGXGh+qf5NqPrsma
         z7zREmmYiNwI6IcOwpDfOUCrGR3T7+YFgheEm/PunEa4Vu21asrhRObNn4x9x5nVp75f
         kwK32Vxt4zlLeijZSDyZR7TvdXD44SvFbYyhXb0Uwv5rMPiUUZIYGdl23xdMzujy/eS7
         TnrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4qOLqjoCvwfes3GQmLgLoYg/ASG8k1yJH17Rxdih0SY=;
        b=qTJnnNeNmSFQqVAqAKRdP9qeheo6IWo86jbsy9YJv040EXF+w6/nXqUP6zfr1IRqwn
         0/1RsF+ym2D2VKO8iwRn9FNA7WwjOiPVqJxjGE7qy7YIxeaXVcnKE2UWOaaFEiLqPezc
         z+XYq0W050/r+405FkrgKBJ19nF7srPXLUZSFkO2hgo0WKTIB/A/Ck9CBx6FTLRcdOm7
         SCHy/0UG9QJlk0xnzyxLVNIYORm5RPUlYpPi1Yd6nHk/EoUoJ0R9k6kdcYQQ03Q8ToAr
         RCQCdki19qC9HwxiLfRnGKDAQgyjy8xH446J+zZVVsYPeuUHOq1U0Dp6HizVPtJAdWoJ
         0BoA==
X-Gm-Message-State: ANoB5plvMh5f4rwiQTcQQvS3Ip8I1zp9NXmeawL153LQeoYBpieihU8F
        298DnykAfWsZ7L82+gxbDms=
X-Google-Smtp-Source: AA0mqf4k6nHdZ5M/3l7PVivz+vYtbO5uyFFzHkXeiQzGAa4Lhqqrdf5h4y14CqIuT7/AVGkBvZQ+sw==
X-Received: by 2002:a05:6870:51d:b0:13b:a486:fa2f with SMTP id j29-20020a056870051d00b0013ba486fa2fmr24796070oao.6.1669831605121;
        Wed, 30 Nov 2022 10:06:45 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l187-20020aca3ec4000000b003509cc4ad4esm863134oia.39.2022.11.30.10.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 10:06:44 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 30 Nov 2022 10:06:42 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH v3 1/4] hwmon: (pmbus/core): Add status byte to regulator
 flag map
Message-ID: <20221130180642.GA2656856@roeck-us.net>
References: <20221130165833.3478555-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130165833.3478555-1-Naresh.Solanki@9elements.com>
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

On Wed, Nov 30, 2022 at 05:58:28PM +0100, Naresh Solanki wrote:
> Add PMBus status byte to regulator flag map.
> 
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> 
> ---
> Changes:
> - Remove status input

Not really.

> - Add comment for PMBUS status byte.
> ---
>  drivers/hwmon/pmbus/pmbus_core.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 95e95783972a..a7b4ae0f1f3b 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -2751,7 +2751,16 @@ struct pmbus_regulator_status_category {
>  };
>  
>  static const struct pmbus_regulator_status_category pmbus_regulator_flag_map[] = {
> -	{
> +	{	/* STATUS byte is always present. */
> +		.func = -1,
> +		.reg = PMBUS_STATUS_BYTE,
> +		.bits = (const struct pmbus_regulator_status_assoc[]) {
> +			{ PB_STATUS_IOUT_OC,   REGULATOR_ERROR_OVER_CURRENT },
> +			{ PB_STATUS_VOUT_OV,   REGULATOR_ERROR_REGULATION_OUT },
> +			{ PB_STATUS_VIN_UV,    REGULATOR_ERROR_UNDER_VOLTAGE },

Still there.

> +			{ },
> +		},
> +	}, {
>  		.func = PMBUS_HAVE_STATUS_VOUT,
>  		.reg = PMBUS_STATUS_VOUT,
>  		.bits = (const struct pmbus_regulator_status_assoc[]) {
> @@ -2768,6 +2777,7 @@ static const struct pmbus_regulator_status_category pmbus_regulator_flag_map[] =
>  			{ PB_IOUT_OC_WARNING,    REGULATOR_ERROR_OVER_CURRENT_WARN },
>  			{ PB_IOUT_OC_FAULT,      REGULATOR_ERROR_OVER_CURRENT },
>  			{ PB_IOUT_OC_LV_FAULT,   REGULATOR_ERROR_OVER_CURRENT },
> +			{ PB_POUT_OP_FAULT,      REGULATOR_ERROR_FAIL },

Please document your changes in the description. There are two functional
changes hidden under "Add PMBus status byte to regulator flag map".
That is inappropriate. Those, as I have pointed out, should be separate
patches.

Guenter

>  			{ },
>  		},
>  	}, {
> @@ -2834,14 +2844,6 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
>  		if (status & PB_STATUS_POWER_GOOD_N)
>  			*flags |= REGULATOR_ERROR_REGULATION_OUT;
>  	}
> -	/*
> -	 * Unlike most other status bits, PB_STATUS_{IOUT_OC,VOUT_OV} are
> -	 * defined strictly as fault indicators (not warnings).
> -	 */
> -	if (status & PB_STATUS_IOUT_OC)
> -		*flags |= REGULATOR_ERROR_OVER_CURRENT;
> -	if (status & PB_STATUS_VOUT_OV)
> -		*flags |= REGULATOR_ERROR_REGULATION_OUT;
>  
>  	/*
>  	 * If we haven't discovered any thermal faults or warnings via
> 
> base-commit: 9494c53e1389b120ba461899207ac8a3aab2632c
> -- 
> 2.37.3
> 
