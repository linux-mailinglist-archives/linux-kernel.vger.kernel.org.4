Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4E6637B54
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 15:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbiKXOUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 09:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiKXOT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 09:19:57 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC75E12BFFD;
        Thu, 24 Nov 2022 06:18:59 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id p27-20020a056830319b00b0066d7a348e20so999698ots.8;
        Thu, 24 Nov 2022 06:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DLP2RmW6KppuUSYRYtgdQEVaoUbbSPTBaC+J7IgyCrU=;
        b=evxYmkAsS4/H6gbAopMShJnAZcvJI4ApTWHc9q/PxTzvrOY6vHXOGz9PvnZl19hnp+
         n8L0WfDXw+PAvBYKIw6MDuQK3qzqIUVJg4+4L5atOC1z+IFm1RY6R3QgQ5KtX0q1zsIc
         N/wjfBI7CSdFaLQKYVAg3uMhhSmALO091LtE+LxE1P1CkkfU9ItuvagvmJouXS7WkzQE
         PISdbuym2IqMZ48BSOPfj4CBlwHQeiaVE44iZ7D6b2oFAQmR6ATjxaNWmPnxiYAGoiN7
         Gy2iFBzOLIPmazbkBhGO2aJTEHQQsYYBeMX8UaddAD9fKyfrnFEWkXO9RVi/WF+PD1Vi
         2xsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DLP2RmW6KppuUSYRYtgdQEVaoUbbSPTBaC+J7IgyCrU=;
        b=x6DiJt6G790gdGnqP7aF3uL5/3uXiHPgckYiaJ/0S+b498RCAm5xU9/Q0u/ayZgSti
         qh+6R3t6pk1/TSqTWQz4ujbYxEfG9vwTdBRNUn+a1AqqstheqFtgng+nj/pmZfQHiTsS
         FF8Qx8/ZjbpBo3bvrjMs0Fj24vP5NVz3dOoDM0PlTtMqI3aV6U5mxiLd05c28wqu6rxE
         FcYtxOPmVxsqfI++G9FtbfVWApS/lwhyc1aVQYfKJob75wfJwpJyZWo50VLI+TDNyJRh
         p47e5g8EgXXNSe68s0g92AB5cE2b9wCutjP4slx97wZR+jhUJvQqL1kYdo51CosxVl4x
         CNKQ==
X-Gm-Message-State: ANoB5plqcZXniTPLhA/N2W60cadlsMB2PGHW1WLlpwL79Dabnvfv8DkQ
        gBEOjXn2eaTvxyAmvjeNaGUkKfrn2SE=
X-Google-Smtp-Source: AA0mqf72VU88Bps6oJ9yKdM6o9A1507CNXiSmQPLbu9wzvowI5Fnb8IODIlt6MuSjhPD6Kx4oZSujg==
X-Received: by 2002:a05:6830:1510:b0:655:bd84:a806 with SMTP id k16-20020a056830151000b00655bd84a806mr6552762otp.108.1669299538871;
        Thu, 24 Nov 2022 06:18:58 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m46-20020a05683026ee00b0066dc76d9b7fsm424848otu.31.2022.11.24.06.18.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 06:18:58 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1fcf36d3-0579-3e23-2613-61f523bcb046@roeck-us.net>
Date:   Thu, 24 Nov 2022 06:18:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
References: <20221124083439.3840025-1-Naresh.Solanki@9elements.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v5] hwmon: (pmbus/core): Implement regulator get_status
In-Reply-To: <20221124083439.3840025-1-Naresh.Solanki@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24/22 00:34, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Add get_status for pmbus_regulator_ops.
> 
> ---
> Changes:
> - use lock throughout the function
> - Avoid line continuation upto 100 column
> - Optimize use of & and | operator
> - Check for VOUT, IOUT, TEMPERATURE bit in status word before checking
>    respective status register for fault.
> - Report regulator current status.
> - Utilize get_error_flag to check for regulator errors.
> - Check for return value of function get_error_flag
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>   drivers/hwmon/pmbus/pmbus_core.c | 44 ++++++++++++++++++++++++++++++++
>   1 file changed, 44 insertions(+)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 20ca26e19db7..0b13214c662f 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -2855,6 +2855,49 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
>   	return 0;
>   }
>   
> +static int pmbus_regulator_get_status(struct regulator_dev *rdev)
> +{
> +	struct device *dev = rdev_get_dev(rdev);
> +	struct i2c_client *client = to_i2c_client(dev->parent);
> +	struct pmbus_data *data = i2c_get_clientdata(client);
> +	u8 page = rdev_get_id(rdev);
> +	int status, ret;
> +
> +	mutex_lock(&data->update_lock);
> +	status = pmbus_get_status(client, page, PMBUS_STATUS_WORD);
> +	if (status < 0) {
> +		ret = status;
> +		goto unlock;
> +	}
> +
> +	if (status & PB_STATUS_OFF) {
> +		ret = REGULATOR_STATUS_OFF;
> +		goto unlock;
> +	}
> +
> +	/* If regulator is ON & reports power good then return ON */
> +	if (!(status & PB_STATUS_POWER_GOOD_N)) {
> +		ret = REGULATOR_STATUS_ON;
> +		goto unlock;
> +	}
> +
> +	if (rdev->desc->ops->get_error_flags) {

Looking into this again, why is this check necessary ? Isn't this
the regulator_ops from below ? Also, why not just call
pmbus_regulator_get_error_flags() directly ?

> +		ret = rdev->desc->ops->get_error_flags(rdev, &status);
> +		if (ret)
> +			goto unlock;
> +
> +		if (status & (REGULATOR_ERROR_UNDER_VOLTAGE | REGULATOR_ERROR_OVER_CURRENT |
> +		   REGULATOR_ERROR_REGULATION_OUT | REGULATOR_ERROR_FAIL |
> +		   REGULATOR_ERROR_OVER_TEMP))
> +			ret = REGULATOR_STATUS_ERROR;

If the condition above is false, the return value will be 0, or
REGULATOR_STATUS_OFF. Is that intentional ?

> +	} else
> +		ret = REGULATOR_STATUS_UNDEFINED;
> +

CHECK: braces {} should be used on all arms of this statement
#72: FILE: drivers/hwmon/pmbus/pmbus_core.c:2884:
+	if (rdev->desc->ops->get_error_flags) {
[...]
+	} else

Guenter

> +unlock:
> +	mutex_unlock(&data->update_lock);
> +	return ret;
> +}
> +
>   static int pmbus_regulator_get_low_margin(struct i2c_client *client, int page)
>   {
>   	struct pmbus_data *data = i2c_get_clientdata(client);
> @@ -2995,6 +3038,7 @@ const struct regulator_ops pmbus_regulator_ops = {
>   	.disable = pmbus_regulator_disable,
>   	.is_enabled = pmbus_regulator_is_enabled,
>   	.get_error_flags = pmbus_regulator_get_error_flags,
> +	.get_status = pmbus_regulator_get_status,
>   	.get_voltage = pmbus_regulator_get_voltage,
>   	.set_voltage = pmbus_regulator_set_voltage,
>   	.list_voltage = pmbus_regulator_list_voltage,
> 
> base-commit: 2c71b3246ec3246522e8cb7c8191dc7a5d62cc70

