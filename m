Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567C76343F3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 19:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234582AbiKVSsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 13:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234599AbiKVSsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 13:48:40 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42F28C4A7;
        Tue, 22 Nov 2022 10:48:30 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id e205so16751924oif.11;
        Tue, 22 Nov 2022 10:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1vnassmWHEOpjrJ1nRETirxtdv149npQRWnOMLYVjOg=;
        b=dLspgz+bpzT+EedBtattbgdqyXTzab5fJIyizJY4ppPsafC0paWmwTgBd9Yhrh2bQU
         spxelrQIWyopdGa39HgeehGp9zsRSdCEtBuzTwUTtpTnqKC+IkFCK8F7iVnDKk0ZC/mH
         yYGaJYV4XV7l9C7Ydwnm8l2j7L6nmtAe/yJhNc9UhPQx4K4N6Xqpd5roSnQI9s8h39M7
         TJmLtv+8emi+NILKZOUIggf96GNXvF9w3hbrohnMAd+ykYr/li9VOo0d0pgUaQWGDKvw
         K0pEiN0DVsANgAI/rHSBNz2GuLCT8FOvy7k0G/KF3hOSwmfbLm0rEuxsSDLLz7ktaw70
         7S7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1vnassmWHEOpjrJ1nRETirxtdv149npQRWnOMLYVjOg=;
        b=jlY+ukK/ONW8Yee5gLzA5PVsOGNKkUO+0mz5bOfSrBnccyMNrP8pxQf0UMJGTKipRV
         ANsup4DlMrQDRT7mhfe16hL4Dq+sMJxlqA8PqHMY76aKU5ekID3ZLD0cjc16hmDDc44y
         LG1GJqkF0245K0vJjFKJmJdBRjuQbFIo0yllDa2c/neRl0xuVPpCvNp1lHTymRXy2U+A
         oIGIW6LwbyCH4v1wIELolaJgMSbPmmC2eYAyaBqdU4y/4slDM0UwzeAJ4/+9CDhfGAbz
         MfERUhiXwfCTv1D7jprqNvvCT/9hwh+K89JtsipiN3hjvF+znfgKlt1J5QOsj6d8lUjB
         Tw3A==
X-Gm-Message-State: ANoB5pmxgRb8UOSZqEMCCn8U1PeZYysptOuI9harqtPWuru/v1OjWLzQ
        Ao2tUFAKkSd22m9Bzs8FpS7HFydAtVM=
X-Google-Smtp-Source: AA0mqf7+NMNs5yf4Vf5mplcyAR78eLvXgyCD3YXldRymsFhezRJgkEVhNTgqxFjOOdIO9LE7Tidyzg==
X-Received: by 2002:a05:6808:219c:b0:35a:33d7:a447 with SMTP id be28-20020a056808219c00b0035a33d7a447mr2835663oib.186.1669142910117;
        Tue, 22 Nov 2022 10:48:30 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bd32-20020a056870d7a000b0013d6d924995sm7897781oab.19.2022.11.22.10.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 10:48:29 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 22 Nov 2022 10:48:28 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        broonie@kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] hwmon: (pmbus/core): Implement regulator get_status
Message-ID: <20221122184828.GA554748@roeck-us.net>
References: <20221122090302.3053092-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122090302.3053092-1-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 10:03:02AM +0100, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Add get_status for pmbus_regulator_ops.
> ---
> Changes:
> - use lock throughout the function
> - Avoid line continuation upto 100 column
> - Optimize use of & and | operator
> - Check for VOUT, IOUT, TEMPERATURE bit in status word before checking
>   respective status register for fault.
> - Report regulator current status.
> - Utilize get_error_flag to check for regulator errors.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>  drivers/hwmon/pmbus/pmbus_core.c | 41 ++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> 
> base-commit: 27fea302952d8c90cafbdbee96bafeca03544401
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 7ec04934747e..5df2aee549e6 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -2851,6 +2851,46 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
>  	return 0;
>  }
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
> +	if (rdev->desc->ops->get_error_flags)
> +		ret = rdev->desc->ops->get_error_flags(rdev, &status);
> +

What about checking ret ?

> +	if (status & (REGULATOR_ERROR_UNDER_VOLTAGE | REGULATOR_ERROR_OVER_CURRENT |
> +	   REGULATOR_ERROR_REGULATION_OUT | REGULATOR_ERROR_FAIL | REGULATOR_ERROR_OVER_TEMP))
> +		ret = REGULATOR_STATUS_ERROR;
> +	else
> +		ret = REGULATOR_STATUS_UNDEFINED;

This part has to be inside "if (rdev->desc->ops->get_error_flags)"
or status will still contain the status word.

Guenter

> +
> +unlock:
> +	mutex_unlock(&data->update_lock);
> +	return ret;
> +}
> +
>  static int pmbus_regulator_get_low_margin(struct i2c_client *client, int page)
>  {
>  	struct pmbus_data *data = i2c_get_clientdata(client);
> @@ -2991,6 +3031,7 @@ const struct regulator_ops pmbus_regulator_ops = {
>  	.disable = pmbus_regulator_disable,
>  	.is_enabled = pmbus_regulator_is_enabled,
>  	.get_error_flags = pmbus_regulator_get_error_flags,
> +	.get_status = pmbus_regulator_get_status,
>  	.get_voltage = pmbus_regulator_get_voltage,
>  	.set_voltage = pmbus_regulator_set_voltage,
>  	.list_voltage = pmbus_regulator_list_voltage,
