Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6330963F8DC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 21:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbiLAUPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 15:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiLAUPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 15:15:40 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC19FBEC72;
        Thu,  1 Dec 2022 12:15:39 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id v82so3242939oib.4;
        Thu, 01 Dec 2022 12:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cx/dXzV+nw2cMGlEUPmY5JkZ0PYrvvk4+sLDPTJC+io=;
        b=VzYNQKCW44no4QxA7cvybq82fpSGELJktNVb3/lK/g/Nj5qslUiakrTzaz6x0mt6vI
         xdHY9pCl6KAgpClwI1qEwPF/5DmHXYLxK7IbkxXXzgDnQkaiI2ipbwQ4ktEts5Swxeys
         pwPQxLsQwu0LUefDL241dMY2UTcIBfMgYbe+XMmfWyyqZmGBK4vYe7oGqqROiMWZTzb1
         6vUw+Qiz2sMLeGKgy8hxUEpILRvyLMN5AoOM7O1xuy4w/YJTW4974RNu6uLQD9rFBSwF
         q7tjhi0QrgpUNQML9+WYhmIvFzWhd4YMBSt3rgwKWmOsiAhaMfinUtsyxCdmc7/yJQEt
         u2+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cx/dXzV+nw2cMGlEUPmY5JkZ0PYrvvk4+sLDPTJC+io=;
        b=F852e+/zoB8uLJ5o7hB8vpvzGahmKgHICDsXmXZXQvYOqhWSdpcGD+8kKRiHoVRtPn
         uzrTmg78WgUR5QDpsf919bhP2QOasQpeHcH1zOLE4zony2AwpcPOcL5CoIZGv1nKOwkd
         3U+kCIOzdZybYAPivgdwsKGrH1SKOJ6ucE/FwUF0YvFbGvtmqyK4c+6iBtxKl5hkrSIW
         QyTSVAiU/jvyMoBE405qBGCB5fTXuhzYWmoRvW4sk4OCQhnM++LIj0HCAGDJU4zwmgQt
         Lhjza67jCA2SYZfJSG+cz7Mc28KYv9rdJAp/MqMPotUWxFD+HnK15qcT64hVYY2fdN5m
         mpNg==
X-Gm-Message-State: ANoB5pmsOvrr8iEoUQydTpDz81ZJIHuTJ9q0HKuaVtot00o0xiPbHhwj
        9JBxqvj35RdigRLJDXK2xM4=
X-Google-Smtp-Source: AA0mqf7O8cEz3ykaMHe/4sbE2lKDD0qHiZTeUGZia7JI4a3hb4lPVpSZ8n7nniKNaQ78qpyxcjr5Pw==
X-Received: by 2002:a05:6808:7:b0:35b:758e:1cda with SMTP id u7-20020a056808000700b0035b758e1cdamr20329916oic.148.1669925739135;
        Thu, 01 Dec 2022 12:15:39 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r8-20020a9d5cc8000000b0066cc0525476sm2448396oti.75.2022.12.01.12.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 12:15:38 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 1 Dec 2022 12:15:37 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH v5 3/5] hwmon: (pmbus/core): Notify hwmon events
Message-ID: <20221201201537.GC2110128@roeck-us.net>
References: <20221201193025.1584365-1-Naresh.Solanki@9elements.com>
 <20221201193025.1584365-3-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201193025.1584365-3-Naresh.Solanki@9elements.com>
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

On Thu, Dec 01, 2022 at 08:30:22PM +0100, Naresh Solanki wrote:
> Notify hwmon events using the pmbus irq handler.
> 

Unfortunately, as implemented, this only works if regulator support
is enabled, which is unacceptable.

Guenter

> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>  drivers/hwmon/pmbus/pmbus_core.c | 46 +++++++++++++++++++++++++++++---
>  1 file changed, 43 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 6a3a3fd59b8e..ad3c0cc884a4 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -2782,7 +2782,35 @@ static const struct pmbus_regulator_status_category pmbus_regulator_flag_map[] =
>  	},
>  };
>  
> -static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned int *flags)
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
> +static int pmbus_regulator_get_flags(struct regulator_dev *rdev, unsigned int *error,
> +				    bool notify)
>  {
>  	int i, status;
>  	const struct pmbus_regulator_status_category *cat;
> @@ -2812,6 +2840,9 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
>  			if (status & bit->pflag)
>  				*flags |= bit->rflag;
>  		}
> +
> +		if (notify && status)
> +			pmbus_notify(data, page, cat->reg, status);
>  	}
>  
>  	/*
> @@ -2856,6 +2887,11 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
>  	return 0;
>  }
>  
> +static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned int *flags)
> +{
> +	return pmbus_regulator_get_flags(rdev, flags, false);
> +}
> +
>  static int pmbus_regulator_get_status(struct regulator_dev *rdev)
>  {
>  	struct device *dev = rdev_get_dev(rdev);
> @@ -3087,7 +3123,7 @@ static irqreturn_t pmbus_fault_handler(int irq, void *pdata)
>  {
>  	struct pmbus_data *data = pdata;
>  	struct i2c_client *client = to_i2c_client(data->dev);
> -	int i, status;
> +	int i, ret = IRQ_NONE, status;
>  	u8 page;
>  
>  	for (i = 0; i < data->info->num_regulators; i++) {
> @@ -3095,6 +3131,10 @@ static irqreturn_t pmbus_fault_handler(int irq, void *pdata)
>  		if (!data->rdevs[i])
>  			continue;
>  
> +		ret = pmbus_regulator_get_flags(data->rdevs[i], &status, true);
> +		if (ret)
> +			return ret;
> +
>  		page = rdev_get_id(data->rdevs[i]);
>  		mutex_lock(&data->update_lock);
>  		status = pmbus_read_status_word(client, page);
> @@ -3109,7 +3149,7 @@ static irqreturn_t pmbus_fault_handler(int irq, void *pdata)
>  		mutex_unlock(&data->update_lock);
>  	}
>  
> -	return IRQ_HANDLED;
> +	return ret;
>  }
>  
>  static int pmbus_irq_setup(struct i2c_client *client, struct pmbus_data *data)
> -- 
> 2.37.3
> 
