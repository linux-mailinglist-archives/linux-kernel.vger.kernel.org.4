Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84D2693214
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 16:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjBKPqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 10:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjBKPqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 10:46:51 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB435FD8;
        Sat, 11 Feb 2023 07:46:50 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id i21-20020a4ad395000000b00517895ed15dso829799oos.0;
        Sat, 11 Feb 2023 07:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lUGI7ysF27nqFYN0a0c1wPDqmYizsBmvIXJzpPikZpY=;
        b=dWMg/3UL2OAX2IZDsKVWWbMACiB8+LBK4bnFVmtDFLznw/Zx+QOR+6uzYwb871oZSd
         YHBAPnYGPfVVh9FgZBVivpiP+GRwWxHlsPjzoGlp4f9Fv/+cAID9arupyiHxymLDiZJU
         FHxhqLqSDVz4YR3ZFGcIRgygK16CS5JcEEXIjDkWUeeAhvlDKbJcB8LGtbjCIS/vMGdR
         m40WN+uCurGTfc2ASHBGE19nF4BTIDcBg1mwtr75ei77zWMXy5CSSMj5kt7i98eFb6Ke
         oauIyMZ9OQWAZhuGZIsGanAceewUb90vyGJujS7BkEXtIh4YxhLn6gZOrnBBoyv/yJto
         iqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lUGI7ysF27nqFYN0a0c1wPDqmYizsBmvIXJzpPikZpY=;
        b=mqtDHxcps3tTxLH+21wLurpAW20C4ZJcMeLrshaU+6VzrlF1no8aGVhzWrbFviFTSO
         F34IJ9W9cWds0hadAGD3xeu/UyL8AtYQgr4ehAa7Q3VmAq210zT14fsa9Mh15noxmovw
         tuxyNak5tTY356GIcPqWRcNFz8I3hXfVluYBe27WNG8wgHuo11iR87CtyVPf6oAetesc
         OBD5KJSquZLMT7CDzpfPneumjU/9KQUp+i7TEda8fm4lvlyZfB02Z8QG8hHKGbeIvRLX
         1cFdkg4ok+1RiScIE/X+4E0GvicQHSnUxknvPbIwQnuR7f5sEqhsb4wh6JSYogsDpsIJ
         BkWw==
X-Gm-Message-State: AO0yUKVUouMxAEvYeTyUXMiPTSRYDG60jW95kbFdwz6cOnGSMRc936D7
        0+VTEYUxzRY8uvtzNHC3t1Y8uQ1/cPQ=
X-Google-Smtp-Source: AK7set/QYs9hpuCmg5/y/CHtw6IJBNOGjEVpRsx1KYMqo8C8MP/xBixVgJzARl+XwEhEaABrzVs1Vw==
X-Received: by 2002:a4a:d65b:0:b0:517:9157:9480 with SMTP id y27-20020a4ad65b000000b0051791579480mr9677066oos.4.1676130409445;
        Sat, 11 Feb 2023 07:46:49 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f2-20020a4aa682000000b0051ac0f54447sm3041734oom.33.2023.02.11.07.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 07:46:48 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 11 Feb 2023 07:46:47 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] hwmon: (pmbus/core): Notify hwmon events
Message-ID: <20230211154647.GA204954@roeck-us.net>
References: <20230207120241.2800662-1-Naresh.Solanki@9elements.com>
 <20230207120241.2800662-4-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207120241.2800662-4-Naresh.Solanki@9elements.com>
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

On Tue, Feb 07, 2023 at 01:02:41PM +0100, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Notify hwmon events using the pmbus irq handler.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ...
> Changes in V2
> - Remove __maybe_unsed attribute as its not needed.
> ---
>  drivers/hwmon/pmbus/pmbus_core.c | 48 ++++++++++++++++++++++++++++----
>  1 file changed, 43 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index d5403baad60a..f6778a9c7126 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -2735,8 +2735,36 @@ static const struct pmbus_status_category __maybe_unused pmbus_status_flag_map[]
>  	},
>  };
>  
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
> +static int pmbus_get_flags(struct pmbus_data *data, u8 page, unsigned int *flags,
> +			   bool notify)
>  
> -static int __maybe_unused pmbus_get_flags(struct pmbus_data *data, u8 page, unsigned int *flags)
>  {
>  	int i, status, ret;
>  	const struct pmbus_status_category *cat;
> @@ -2764,6 +2792,10 @@ static int __maybe_unused pmbus_get_flags(struct pmbus_data *data, u8 page, unsi
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
> @@ -2866,7 +2898,7 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
>  	struct i2c_client *client = to_i2c_client(dev->parent);
>  	struct pmbus_data *data = i2c_get_clientdata(client);
>  
> -	return pmbus_get_flags(data, rdev_get_id(rdev), flags);
> +	return pmbus_get_flags(data, rdev_get_id(rdev), flags, false);
>  }
>  
>  static int pmbus_regulator_get_status(struct regulator_dev *rdev)
> @@ -3108,10 +3140,14 @@ static irqreturn_t pmbus_fault_handler(int irq, void *pdata)
>  {
>  	struct pmbus_data *data = pdata;
>  	struct i2c_client *client = to_i2c_client(data->dev);
> -	int i, status;
> +	int i, status, ret;
>  
> -	mutex_lock(&data->update_lock);
>  	for (i = 0; i < data->info->pages; i++) {
> +		ret = pmbus_get_flags(data, i, &status, true);
> +		if (ret)
> +			return ret;
> +
> +		mutex_lock(&data->update_lock);

You should introduce a locked version of pmbus_get_flags() and call
that function, and keep the existing locking in place.

>  		status = pmbus_read_status_word(client, i);
>  		if (status < 0) {
>  			mutex_unlock(&data->update_lock);
> @@ -3120,8 +3156,10 @@ static irqreturn_t pmbus_fault_handler(int irq, void *pdata)
>  
>  		if (status & ~(PB_STATUS_OFF | PB_STATUS_BUSY | PB_STATUS_POWER_GOOD_N))
>  			pmbus_clear_fault_page(client, i);
> +
> +		mutex_unlock(&data->update_lock);
>  	}
> -	mutex_unlock(&data->update_lock);
> +

This would add a second empty line (not that it matters because the code
should not change the locking in the first place).

>  
>  	return IRQ_HANDLED;
>  }
