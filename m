Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A9863F8C2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 21:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiLAUEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 15:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiLAUEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 15:04:22 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CC2A2801;
        Thu,  1 Dec 2022 12:04:21 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id q186so3184714oia.9;
        Thu, 01 Dec 2022 12:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KB2rkAyzghkJoF+4UvQK5LbNR3vGX6gvot0xzapn8tw=;
        b=TIRXRb0mjUwtLMIYiHL3+NNzco4o1HfZxaBKCOfJ8VIfzE3tSuwpFegJ+1ntUgqKsA
         tJzY2I3EdibxGBVxehOUricTlcFD3dW1uk8FndCxwU+M/g4Hmc20rJUgBydkk+t7PfsY
         8nazNQyb9GR5JNDSpafDI2uD9xJJXfTaYoQPQQxBrSrxLauQD7ky85+X37dAQW7SCHpL
         zKnpk9yDUwgdPrA9Eal0ag9RUt5KMK/k2y611vnm603006rYU2upqFn19TYrSqpNldaQ
         o6mW/n/IqqlZI8psOeTRWIp4Ex8xbA/VAxj/i0vexCHMyPwAFW2ZvUbMPo31kARLQt1J
         BpNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KB2rkAyzghkJoF+4UvQK5LbNR3vGX6gvot0xzapn8tw=;
        b=7yOwMHHAEJ/gSAGkLmF9PvZEroglux/1lczpmmr3qfOoY8q+2yFZLfVzOvPLpMPIh+
         6IAw1ThFKV77xIyLhnvzHKbfUrXk/kz/FKYsO2j3uiSDp5EcHPqugT62rKr74Ydg3obS
         rwB4VZdlzFmOijXgFhcroY0gPPaOSRkPN6r9YoVLfqdQj4hRW059EUOaigqM4eKVQmOo
         DDZjxzAi98rikNElPA8sGYv3gvHZqzGWoBRpXOTNBkLIwYg0WmJ0zoBJJRmxm4wX9b0K
         jw0DVuzz7fmOTr5mLOqvKJ+Pb2xN/bUEXvpuJXmt92NsESeeVxMjt4MSoePHLlLTlQJO
         D7Dw==
X-Gm-Message-State: ANoB5pmcgG/ismVs10xzx3GJYDiXT4eGCOeVPMM5MqrNP4Fqw9GEc08a
        eGYjcaCk/1dFDdohE4Tyvpk=
X-Google-Smtp-Source: AA0mqf4tQeS6OpB1bbAUG/vTVtBJ//PfvzjA6jMy878lMgJJbsBmPKvOu84v8fdnbr2LXsWgrgbZ0g==
X-Received: by 2002:aca:e057:0:b0:35b:ae45:b9e9 with SMTP id x84-20020acae057000000b0035bae45b9e9mr11387188oig.201.1669925061148;
        Thu, 01 Dec 2022 12:04:21 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a2-20020a05680804c200b0035418324b78sm2188761oie.11.2022.12.01.12.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 12:04:20 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 1 Dec 2022 12:04:19 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH v5 1/5] hwmon: (pmbus/core): Add rdev in pmbus_data struct
Message-ID: <20221201200419.GA2110128@roeck-us.net>
References: <20221201193025.1584365-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201193025.1584365-1-Naresh.Solanki@9elements.com>
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

On Thu, Dec 01, 2022 at 08:30:20PM +0100, Naresh Solanki wrote:
> Add regulator device in pmbus_data & initialize the same during PMBus
> regulator register.
> 

This needs an explanation why this change is needed.

Guenter

> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> 
> ---
> Change in V5:
> - Fix error check for rdev
> ---
>  drivers/hwmon/pmbus/pmbus_core.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 95e95783972a..a95f998ca247 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -81,6 +81,7 @@ struct pmbus_label {
>  struct pmbus_data {
>  	struct device *dev;
>  	struct device *hwmon_dev;
> +	struct regulator_dev **rdevs;
>  
>  	u32 flags;		/* from platform data */
>  
> @@ -3050,9 +3051,13 @@ static int pmbus_regulator_register(struct pmbus_data *data)
>  	struct device *dev = data->dev;
>  	const struct pmbus_driver_info *info = data->info;
>  	const struct pmbus_platform_data *pdata = dev_get_platdata(dev);
> -	struct regulator_dev *rdev;
>  	int i;
>  
> +	data->rdevs = devm_kzalloc(dev, sizeof(struct regulator_dev *) * info->num_regulators,
> +				  GFP_KERNEL);
> +	if (!data->rdevs)
> +		return -ENOMEM;
> +
>  	for (i = 0; i < info->num_regulators; i++) {
>  		struct regulator_config config = { };
>  
> @@ -3062,10 +3067,10 @@ static int pmbus_regulator_register(struct pmbus_data *data)
>  		if (pdata && pdata->reg_init_data)
>  			config.init_data = &pdata->reg_init_data[i];
>  
> -		rdev = devm_regulator_register(dev, &info->reg_desc[i],
> +		data->rdevs[i] = devm_regulator_register(dev, &info->reg_desc[i],
>  					       &config);
> -		if (IS_ERR(rdev))
> -			return dev_err_probe(dev, PTR_ERR(rdev),
> +		if (IS_ERR(data->rdevs[i]))
> +			return dev_err_probe(dev, PTR_ERR(data->rdevs[i]),
>  					     "Failed to register %s regulator\n",
>  					     info->reg_desc[i].name);
>  	}
> 
> base-commit: 9494c53e1389b120ba461899207ac8a3aab2632c
> -- 
> 2.37.3
> 
