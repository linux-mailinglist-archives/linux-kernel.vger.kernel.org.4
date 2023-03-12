Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7586B6903
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 18:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjCLR4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 13:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjCLR4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 13:56:08 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E1537B6F;
        Sun, 12 Mar 2023 10:56:07 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id bi17so7967754oib.3;
        Sun, 12 Mar 2023 10:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678643766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BlEzqNfjcrEjglxe+A1T2KUkUEySUY5I6uLCcu4h+Mc=;
        b=Cs3fUmtvd+smCvPcmo51M+QK2M7PSStes5FdS3A4/JFqFKBUGqxJzBZr4mfJWP+ESV
         pDxi35iJP1ku7WfewTebVmiJgWC2yrPlwl1zFfRvJjK6uPktsClC2oTO0b7YNF2L4a9s
         fnRw8aRDmTjsDSDzv9OZ2+Q2i2Zy+RnvxkVXX0/eY5Zv/MkhQ6kTzeM8RNfzQRB04vBT
         mccCdiYONzrV658TpJo2pYwnstRP2PMfgK+qJX+OdzsZmGo0Kcezr4iXuPj3VN7J0h7P
         OSneaB/0wVfvEG8JsYjfp/Nk8AS4TxSDAwvvreTfZ1okQv+DtoJBGVxYUFUL91f7BUKJ
         Ax2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678643766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BlEzqNfjcrEjglxe+A1T2KUkUEySUY5I6uLCcu4h+Mc=;
        b=79DlFNBMXXCftNmEx3zqMHoCUrm+0ar5fXCHm4Su+yWAoKuhO1VjDw/Dd+CJtXkJRj
         8lk/hUUOM8Dx644LJ3ncXx/BzFeBxX1uRUWL8OQJxSPOxuLsZpukffnrH/O8OOGx97t/
         FrXwRjvfGB6mVyMuJ8X/+RTeXG0EGT2nK+dhW/ZjShLv7pZwP7DHeQlu92WDBN9c0gfC
         w5RkMor5s/s1R47PBuBAFNmAIyfrlKVXNCNzxrNeXD1JBgJx2ZCnqXnTvVNNCDT0FJKT
         NDs0htfb57gMjLm47j1FV4hzb5azxMkgdmX2gZD7yJnSOqM+yrOTGl0PleHFh95vqU5U
         MBxw==
X-Gm-Message-State: AO0yUKW6Lv0PVhTkr/tjHA162oyZ/P5cJ2L2CM4sVsKZRxsmBamalcio
        IsdaMqscK8jh913QJHACPxc=
X-Google-Smtp-Source: AK7set//8A3sevl5TYpFZdOi41ZJLUWzDJ/rSrkocrc/JjTwZ/g49koOUMhOcL6XMcxuN7ZCem1GJw==
X-Received: by 2002:a05:6808:983:b0:384:3c76:e20a with SMTP id a3-20020a056808098300b003843c76e20amr16630558oic.10.1678643766290;
        Sun, 12 Mar 2023 10:56:06 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k8-20020aca3d08000000b00383e12e20c5sm2276547oia.24.2023.03.12.10.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 10:56:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 12 Mar 2023 10:56:04 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] hwmon: (pmbus/core): Notify hwmon events
Message-ID: <d88b6755-0942-464c-8853-cbef5ad41799@roeck-us.net>
References: <20230301164434.1928237-1-Naresh.Solanki@9elements.com>
 <20230301164434.1928237-4-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301164434.1928237-4-Naresh.Solanki@9elements.com>
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

On Wed, Mar 01, 2023 at 05:44:34PM +0100, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Notify hwmon events using the pmbus irq handler.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ...

Again, "---"

Applied.

Thanks,
Guenter

> Changes in V4:
> - Ignore return error in irq handle & instead continue loop.
> Changes in V3:
> - Remove empty line
> - locked version of pmbus_get_flags
> Changes in V2
> - Remove __maybe_unsed attribute as its not needed.
> ---
>  drivers/hwmon/pmbus/pmbus_core.c | 46 +++++++++++++++++++++++++++-----
>  1 file changed, 40 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index dfd227459d8b..0ddef2c9ba9b 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -2761,7 +2761,35 @@ static int __maybe_unused pmbus_is_enabled(struct device *dev, u8 page)
>  	return !!(ret & PB_OPERATION_CONTROL_ON);
>  }
>  
> -static int _pmbus_get_flags(struct pmbus_data *data, u8 page, unsigned int *flags)
> +#define to_dev_attr(_dev_attr) \
> +	container_of(_dev_attr, struct device_attribute, attr)
> +
> +static void pmbus_notify(struct pmbus_data *data, int page, int reg, int flags)
> +{
> +	int i;
> +
> +	for (i = 0; i < data->num_attributes; i++) {
> +		struct device_attribute *da = to_dev_attr(data->group.attrs[i]);
> +		struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
> +		int index = attr->index;
> +		u16 smask = pb_index_to_mask(index);
> +		u8 spage = pb_index_to_page(index);
> +		u16 sreg = pb_index_to_reg(index);
> +
> +		if (reg == sreg && page == spage && (smask & flags)) {
> +			dev_dbg(data->dev, "sysfs notify: %s", da->attr.name);
> +			sysfs_notify(&data->dev->kobj, NULL, da->attr.name);
> +			kobject_uevent(&data->dev->kobj, KOBJ_CHANGE);
> +			flags &= ~smask;
> +		}
> +
> +		if (!flags)
> +			break;
> +	}
> +}
> +
> +static int _pmbus_get_flags(struct pmbus_data *data, u8 page, unsigned int *flags,
> +			    bool notify)
>  {
>  	int i, status;
>  	const struct pmbus_status_category *cat;
> @@ -2785,6 +2813,10 @@ static int _pmbus_get_flags(struct pmbus_data *data, u8 page, unsigned int *flag
>  			if (status & bit->pflag)
>  				*flags |= bit->rflag;
>  		}
> +
> +		if (notify && status)
> +			pmbus_notify(data, page, cat->reg, status);
> +
>  	}
>  
>  	/*
> @@ -2828,12 +2860,13 @@ static int _pmbus_get_flags(struct pmbus_data *data, u8 page, unsigned int *flag
>  	return 0;
>  }
>  
> -static int __maybe_unused pmbus_get_flags(struct pmbus_data *data, u8 page, unsigned int *flags)
> +static int __maybe_unused pmbus_get_flags(struct pmbus_data *data, u8 page, unsigned int *flags,
> +					  bool notify)
>  {
>  	int ret;
>  
>  	mutex_lock(&data->update_lock);
> -	ret = _pmbus_get_flags(data, page, flags);
> +	ret = _pmbus_get_flags(data, page, flags, notify);
>  	mutex_unlock(&data->update_lock);
>  
>  	return ret;
> @@ -2878,7 +2911,7 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
>  	struct i2c_client *client = to_i2c_client(dev->parent);
>  	struct pmbus_data *data = i2c_get_clientdata(client);
>  
> -	return pmbus_get_flags(data, rdev_get_id(rdev), flags);
> +	return pmbus_get_flags(data, rdev_get_id(rdev), flags, false);
>  }
>  
>  static int pmbus_regulator_get_status(struct regulator_dev *rdev)
> @@ -3114,9 +3147,10 @@ static irqreturn_t pmbus_fault_handler(int irq, void *pdata)
>  {
>  	struct pmbus_data *data = pdata;
>  	struct i2c_client *client = to_i2c_client(data->dev);
> -
> +	int i, status;
>  	mutex_lock(&data->update_lock);
> -	/* TODO: Check status flag & notify hwmon events */
> +	for (i = 0; i < data->info->pages; i++)
> +		_pmbus_get_flags(data, i, &status, true);
>  
>  	pmbus_clear_faults(client);
>  	mutex_unlock(&data->update_lock);
