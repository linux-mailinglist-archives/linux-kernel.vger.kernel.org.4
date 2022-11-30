Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05DE063DCB9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 19:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiK3SJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 13:09:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiK3SJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 13:09:12 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD21554C2;
        Wed, 30 Nov 2022 10:09:12 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-142faa7a207so21917592fac.13;
        Wed, 30 Nov 2022 10:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TpD+JGqOMGs2MeIZyqATUrufBsNvtAFqMyggyDXflm4=;
        b=axAmxBBVR4g6OXgHAw6gRM6ZHLAa43II+Pld8l3xyvNm4GWSFBN/ignqTtfTXTyxpY
         7Wxu6+pmsthblkD7l0ZbFRwoj0Qo5ADa7UyaaqmH4/nOlA+3aQ7Z96Vl7/TtKzCIrjpZ
         W3UOt+nfM8/oRR3DJm9khijEHIvwPHCCD+Hr/JEsv1DsTvDwOFNgv9dromjIn5+k29SG
         GoPn0FQp0VdfSsY6Nww8RTR7rEPc0YbpkBaOCOjuHpuH4mIsgTCvwsljJYaYbLQn6bFn
         Em7Bs/kAW1JX0vKif+NYt8n+DxoBBlgxq/p1XMrMl5Tn7ZRM4fax0R8+2r+Klc5Efnhv
         CYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TpD+JGqOMGs2MeIZyqATUrufBsNvtAFqMyggyDXflm4=;
        b=V3u0J25y859dP2q1E+UUY7/4geOAGluTDJsPlcYDAvHjseuKDqZZiHqpdpcdaz7mQ+
         f6/ogVsCwR5mSkrsH6bqy+jK3ngyeOO/zNjmNTfoFD0JB1ZwFX/R83mXLlUjHnZCKZs4
         BDGVKLvh8Fmv472YKK/3/kmN7Y5PbBGJUDNFaT1j3DnzA5ckpZRJkjDmBOp0JZfgN7bc
         q71DKAjE+rlGl14kuGgiy6jHqME9V66Ae7DU4uAVs441R6xq390Z8zV+62JEaA4ugaOw
         i/huJdNAdjZTJRz9mal0Gcs4ZR2IZ1LncEw5Q4lYKg+woDy+YrCWj2/myXWZzUytCzer
         K27g==
X-Gm-Message-State: ANoB5pluMpyWGMmGGvthWaqReT9/shWUimKvhwiA3RR2Ac9EduENZJt9
        5bn5PmjQa8gy9UqtCNqT1ug=
X-Google-Smtp-Source: AA0mqf4+eipE4lzlpjOg3nwCm9azv/aSfRikgtXomKhXLUW/PdGkwUwudO+y15quQvVnXw1EY7wVLA==
X-Received: by 2002:a05:6871:9b:b0:115:1923:57be with SMTP id u27-20020a056871009b00b00115192357bemr38680745oaa.88.1669831751463;
        Wed, 30 Nov 2022 10:09:11 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c14-20020a4ad8ce000000b0049bfbf7c5a8sm952218oov.38.2022.11.30.10.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 10:09:11 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 30 Nov 2022 10:09:10 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH v3 1/4] hwmon: (pmbus/core): Update regulator flag map
Message-ID: <20221130180910.GB2656856@roeck-us.net>
References: <20221130165833.3478555-1-Naresh.Solanki@9elements.com>
 <20221130165833.3478555-2-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130165833.3478555-2-Naresh.Solanki@9elements.com>
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

On Wed, Nov 30, 2022 at 05:58:29PM +0100, Naresh Solanki wrote:
> Add regulator flag map for PMBUS status byte & status input.
> 

Now you lost me. Two 1/4 patches with overlapping and different
content ???

Guenter

> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>  drivers/hwmon/pmbus/pmbus_core.c | 30 ++++++++++++++++++++++--------
>  1 file changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 95e95783972a..f5caceaaef2a 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -2752,6 +2752,15 @@ struct pmbus_regulator_status_category {
>  
>  static const struct pmbus_regulator_status_category pmbus_regulator_flag_map[] = {
>  	{
> +		.func = -1,
> +		.reg = PMBUS_STATUS_BYTE,
> +		.bits = (const struct pmbus_regulator_status_assoc[]) {
> +			{ PB_STATUS_IOUT_OC,   REGULATOR_ERROR_OVER_CURRENT },
> +			{ PB_STATUS_VOUT_OV,   REGULATOR_ERROR_REGULATION_OUT },
> +			{ PB_STATUS_VIN_UV,    REGULATOR_ERROR_UNDER_VOLTAGE },
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
> +			{ PB_POUT_OP_FAULT,      REGULATOR_ERROR_OVER_CURRENT },
>  			{ },
>  		},
>  	}, {
> @@ -2778,6 +2788,18 @@ static const struct pmbus_regulator_status_category pmbus_regulator_flag_map[] =
>  			{ PB_TEMP_OT_FAULT,      REGULATOR_ERROR_OVER_TEMP },
>  			{ },
>  		},
> +	}, {
> +		.func = PMBUS_HAVE_STATUS_INPUT,
> +		.reg = PMBUS_STATUS_INPUT,
> +		.bits = (const struct pmbus_regulator_status_assoc[]) {
> +			{ PB_IIN_OC_FAULT,       REGULATOR_ERROR_OVER_CURRENT },
> +			{ PB_IIN_OC_WARNING,     REGULATOR_ERROR_OVER_CURRENT_WARN },
> +			{ PB_VOLTAGE_UV_FAULT,   REGULATOR_ERROR_UNDER_VOLTAGE },
> +			{ PB_VOLTAGE_UV_WARNING, REGULATOR_ERROR_UNDER_VOLTAGE_WARN },
> +			{ PB_VOLTAGE_OV_WARNING, REGULATOR_ERROR_OVER_VOLTAGE_WARN },
> +			{ PB_VOLTAGE_OV_FAULT,   REGULATOR_ERROR_OVER_VOLTAGE_WARN },
> +			{ },
> +		},
>  	},
>  };
>  
> @@ -2834,14 +2856,6 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
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
