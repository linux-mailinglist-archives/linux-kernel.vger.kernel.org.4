Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185416A2A8F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 16:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjBYPmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 10:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjBYPmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 10:42:04 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E7F13DF9;
        Sat, 25 Feb 2023 07:42:03 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id c11so1902481oiw.2;
        Sat, 25 Feb 2023 07:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=JEtKRStA2bHuzIFtVkVypGs/AFmlxL1y5/cG+CYplHk=;
        b=DjJVHZoOUB2fLbZj4U/C0HrrfXUtlaJn9WNsACmLo4zSV25HqZazhm/y93EmvUnia5
         ur1U6OD+q28ibjUZNc0yTV+aN8awtLmQbymcxcghtVG+adqnZAhKAeytFhPY6XPjqz8i
         RZDebbe7TRgTo19EJvXNeWJqVAtso/yteSTpyEm3YUa76nueL2N1gYSvWOR0Dlor9svS
         2fYZDApphpbQlWylFaFmQzToOscCClO4BIzFmyRDI6ogGJR/2e5ttG+BXt+qgtHqFlen
         pdMfJZfXjF8EXsOsq6oHV9ywoC/AM44aRhYEcr0GBOfpE6C45U8qtTl39RcpD12l6Ol1
         +DSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JEtKRStA2bHuzIFtVkVypGs/AFmlxL1y5/cG+CYplHk=;
        b=YDMqaSeoePT1UNLQipU9yd6ZySEKqqCuC18J7ileYe/g5lZ7VLNiWijLBiGnBSOKSJ
         s94E/XqVGsl9DLYU9LPLHuLimFzJsmM1h6wBdnldhzesN3wTXlgofk3fsqJQtC+LW1Fe
         FngdOAdpom/16+tYFd2C3O05wltXRY6+qZGVjVwydb5Nseood5DK280GWn73TPCPPDvt
         hVXLXFln1095qvCfsRgX0jL5N1M4pj51OOCG3YBUlwGNPKjHeAlrVIwyOrkxoULicqZC
         6GYuO7MSyugDTlDrv2pQyxh29GZkVGFcw5FtopMHJKVzoJxJXQaVxL9aDv4jOfj4ByqE
         8zew==
X-Gm-Message-State: AO0yUKVvtDpYWSJTkLIscOKHExiVsba9Y2NlFyIc3xLLsUcA90E/V/Qy
        wn1hLjlCQTVc13b+C1UCBWW7KJNG8pk=
X-Google-Smtp-Source: AK7set/RMNM/Jyr0Z7xXgRp/j/EMIzGhSovPlsZMQooNKRX34ezFO21smOy7CCl1vl4Nzo8n55JGWA==
X-Received: by 2002:a05:6808:a98:b0:383:f55d:62bc with SMTP id q24-20020a0568080a9800b00383f55d62bcmr2720660oij.46.1677339722467;
        Sat, 25 Feb 2023 07:42:02 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s130-20020acadb88000000b00383f58e7e95sm1019030oig.17.2023.02.25.07.42.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Feb 2023 07:42:02 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <dc9985d2-bce0-9645-1010-b195f53164c0@roeck-us.net>
Date:   Sat, 25 Feb 2023 07:42:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 4/4] hwmon: (pmbus/core): Notify hwmon events
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
References: <20230217083631.657430-1-Naresh.Solanki@9elements.com>
 <20230217083631.657430-4-Naresh.Solanki@9elements.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230217083631.657430-4-Naresh.Solanki@9elements.com>
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

On 2/17/23 00:36, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Notify hwmon events using the pmbus irq handler.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ...
> Changes in V3:
> - Remove empty line
> - locked version of pmbus_get_flags
> Changes in V2
> - Remove __maybe_unsed attribute as its not needed.
> ---
>   drivers/hwmon/pmbus/pmbus_core.c | 48 ++++++++++++++++++++++++++++----
>   1 file changed, 43 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index d0415d5ac7d9..2d10a354fe7a 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -2761,7 +2761,35 @@ static int __maybe_unused pmbus_is_enabled(struct device *dev, u8 page)
>   	return !!(ret & PB_OPERATION_CONTROL_ON);
>   }
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
>   {
>   	int i, status;
>   	const struct pmbus_status_category *cat;
> @@ -2785,6 +2813,10 @@ static int _pmbus_get_flags(struct pmbus_data *data, u8 page, unsigned int *flag
>   			if (status & bit->pflag)
>   				*flags |= bit->rflag;
>   		}
> +
> +		if (notify && status)
> +			pmbus_notify(data, page, cat->reg, status);
> +
>   	}
>   
>   	/*
> @@ -2828,12 +2860,13 @@ static int _pmbus_get_flags(struct pmbus_data *data, u8 page, unsigned int *flag
>   	return 0;
>   }
>   
> -static int __maybe_unused pmbus_get_flags(struct pmbus_data *data, u8 page, unsigned int *flags)
> +static int __maybe_unused pmbus_get_flags(struct pmbus_data *data, u8 page, unsigned int *flags,
> +					  bool notify)
>   {
>   	int ret;
>   
>   	mutex_lock(&data->update_lock);
> -	ret = _pmbus_get_flags(data, page, flags);
> +	ret = _pmbus_get_flags(data, page, flags, notify);
>   	mutex_unlock(&data->update_lock);
>   
>   	return ret;
> @@ -2878,7 +2911,7 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
>   	struct i2c_client *client = to_i2c_client(dev->parent);
>   	struct pmbus_data *data = i2c_get_clientdata(client);
>   
> -	return pmbus_get_flags(data, rdev_get_id(rdev), flags);
> +	return pmbus_get_flags(data, rdev_get_id(rdev), flags, false);
>   }
>   
>   static int pmbus_regulator_get_status(struct regulator_dev *rdev)
> @@ -3114,10 +3147,14 @@ static irqreturn_t pmbus_fault_handler(int irq, void *pdata)
>   {
>   	struct pmbus_data *data = pdata;
>   	struct i2c_client *client = to_i2c_client(data->dev);
> -	int i, status;
> +	int i, status, ret;
>   
>   	mutex_lock(&data->update_lock);
>   	for (i = 0; i < data->info->pages; i++) {
> +		ret = _pmbus_get_flags(data, i, &status, true);
> +		if (ret)
> +			return ret;
> +

Same as with patch 3 - this is not a valid return value for an
interrupt handler.

>   		status = pmbus_read_status_word(client, i);
>   		if (status < 0) {
>   			mutex_unlock(&data->update_lock);
> @@ -3126,6 +3163,7 @@ static irqreturn_t pmbus_fault_handler(int irq, void *pdata)
>   
>   		if (status & ~(PB_STATUS_OFF | PB_STATUS_BUSY | PB_STATUS_POWER_GOOD_N))
>   			pmbus_clear_fault_page(client, i);
> +

Stray whitespace change.

>   	}
>   	mutex_unlock(&data->update_lock);
>   

