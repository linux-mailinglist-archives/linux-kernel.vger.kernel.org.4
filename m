Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D905658DFD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 15:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbiL2Oqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 09:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiL2Oqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 09:46:47 -0500
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF54F71;
        Thu, 29 Dec 2022 06:46:46 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-142b72a728fso21862668fac.9;
        Thu, 29 Dec 2022 06:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mjny4r3e+yHFwg3COWI/pc1YRKBJT4hl+VX4zVowcfU=;
        b=JCrmXzWkZ+Xl1P6FmoFZyRZUilc99pfMaNOtXu2ey5cmvn/E7ueVMhQ6GJRe2CRN2I
         b/DIxIZ6T9V1e5XuSoEBcuk5TlMmE39+dsFgMgkzPTYA4V+FR7aJ8ShnyA6Lu1HJfKgO
         8WYk2Zhw1yufDcqOLMRTLUoHf3PFoOik5q/3iSLAuJK7mjysidg0T5koG51BORYTPvDb
         fWewWY1BgNQQVMg+PyZrpOCcYAuox+BRpz3vUDmrxSymLB2kcf7ayOAwZbg7bT04CObN
         Z3zk3Z8CstJU38uKvWtuVBxmX+cn9QFgEviQsXp9+TAsJY9JBcNhfZsEQXW0V3FIx1ML
         1gLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mjny4r3e+yHFwg3COWI/pc1YRKBJT4hl+VX4zVowcfU=;
        b=HCbs+C2lIz7nslds0XWiFctmcYaV/zZKCN7nK9xmawuFWRrGqwgIHQTAlMuD2z3HYy
         bTXA8sm6OX3g6+KlNSztgv4HRf2j/C7Q1LHiadx0fFZ6ncFtUTj4ifzd8ztww6L/Enz2
         nPr3ZMDIbBltpS2eeMscvxNJBWnnTr2K89RPM6l4QwtftSBEJeTk8yVL3y56iTBStqA2
         e5etQwb7CeiDsFQf6kAX1TwFEgeU6A2fnbo4VWbbFrEgTGq8bHXrd0zsKLpnMTp8od+x
         nCCATcnjFoGG4PdOY+UWavceCBOwSxioZzpYD8ZK7dMCEuQP3nhU8VG0MbdQKS6CzvOa
         /OEQ==
X-Gm-Message-State: AFqh2kp7QulJV1w0qQdhDR6+ZMBeqNPvw3dWS4MOqepz50AnwKPYtuch
        5JRYxS2tNxkO+Md13F47lSsdN5rSK7g=
X-Google-Smtp-Source: AMrXdXul+qhuUeEnULbMFsfEq4K5r2x2MJGyn57HRRl+RP+oXKI1r4+qVhFmiDmNRXj4pnzEghza2Q==
X-Received: by 2002:a05:6870:6789:b0:143:8299:2b5a with SMTP id gc9-20020a056870678900b0014382992b5amr14549082oab.57.1672325205725;
        Thu, 29 Dec 2022 06:46:45 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id cv18-20020a056870c69200b0013ae5246449sm8640191oab.22.2022.12.29.06.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 06:46:45 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 29 Dec 2022 06:46:43 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH RESEND v6 2/5] hwmon: (pmbus/core): Notify hwmon events
Message-ID: <20221229144643.GA21642@roeck-us.net>
References: <20221214080715.2700442-1-Naresh.Solanki@9elements.com>
 <20221214080715.2700442-2-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214080715.2700442-2-Naresh.Solanki@9elements.com>
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

On Wed, Dec 14, 2022 at 09:07:12AM +0100, Naresh Solanki wrote:
> Notify hwmon events using the pmbus irq handler.
> 
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>  drivers/hwmon/pmbus/pmbus_core.c | 95 ++++++++++++++++++++++++--------
>  1 file changed, 72 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 244fd2597252..b005a1c8ad7e 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -2781,18 +2781,43 @@ static const struct pmbus_regulator_status_category pmbus_regulator_flag_map[] =
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

Interrupt aupport as well as sysfs and kobject notifications are not
regulator specific and do not depend on regulator support. It has to be
independent of regulator support, meaning it must also work if regulator
support is disabled.

I seem to have trouble expressing myself, but I don't know how else to say
it, sorry.

It doesn't make sense to review the series further until this is addressed.

Guenter

> +
> +static int pmbus_get_flags(struct pmbus_data *data, u8 page, unsigned int *error,
> +				    bool notify)
>  {
> -	int i, status;
>  	const struct pmbus_regulator_status_category *cat;
>  	const struct pmbus_regulator_status_assoc *bit;
> -	struct device *dev = rdev_get_dev(rdev);
> -	struct i2c_client *client = to_i2c_client(dev->parent);
> -	struct pmbus_data *data = i2c_get_clientdata(client);
> -	u8 page = rdev_get_id(rdev);
> +	struct i2c_client *client = to_i2c_client(data->dev);
>  	int func = data->info->func[page];
> +	int i, status, ret;
>  
> -	*flags = 0;
> +	*error = 0;
>  
>  	mutex_lock(&data->update_lock);
>  
> @@ -2803,14 +2828,17 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
>  
>  		status = _pmbus_read_byte_data(client, page, cat->reg);
>  		if (status < 0) {
> -			mutex_unlock(&data->update_lock);
> -			return status;
> +			ret = status;
> +			goto unlock;
>  		}
>  
>  		for (bit = cat->bits; bit->pflag; bit++) {
>  			if (status & bit->pflag)
> -				*flags |= bit->rflag;
> +				*error |= bit->rflag;
>  		}
> +
> +		if (notify && status)
> +			pmbus_notify(data, page, cat->reg, status);
>  	}
>  
>  	/*
> @@ -2823,36 +2851,53 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
>  	 * REGULATOR_ERROR_<foo>_WARN.
>  	 */
>  	status = pmbus_get_status(client, page, PMBUS_STATUS_WORD);
> -	mutex_unlock(&data->update_lock);
> -	if (status < 0)
> -		return status;
>  
> -	if (pmbus_regulator_is_enabled(rdev)) {
> +	if (status < 0) {
> +		ret = status;
> +		goto unlock;
> +	}
> +
> +	ret = _pmbus_read_byte_data(client, page, PMBUS_OPERATION);
> +	if (ret < 0)
> +		goto unlock;
> +
> +	if (ret & PB_OPERATION_CONTROL_ON) {
>  		if (status & PB_STATUS_OFF)
> -			*flags |= REGULATOR_ERROR_FAIL;
> +			*error |= REGULATOR_ERROR_FAIL;
>  
>  		if (status & PB_STATUS_POWER_GOOD_N)
> -			*flags |= REGULATOR_ERROR_REGULATION_OUT;
> +			*error |= REGULATOR_ERROR_REGULATION_OUT;
>  	}
>  	/*
>  	 * Unlike most other status bits, PB_STATUS_{IOUT_OC,VOUT_OV} are
>  	 * defined strictly as fault indicators (not warnings).
>  	 */
>  	if (status & PB_STATUS_IOUT_OC)
> -		*flags |= REGULATOR_ERROR_OVER_CURRENT;
> +		*error |= REGULATOR_ERROR_OVER_CURRENT;
>  	if (status & PB_STATUS_VOUT_OV)
> -		*flags |= REGULATOR_ERROR_REGULATION_OUT;
> +		*error |= REGULATOR_ERROR_REGULATION_OUT;
>  
>  	/*
>  	 * If we haven't discovered any thermal faults or warnings via
>  	 * PMBUS_STATUS_TEMPERATURE, map PB_STATUS_TEMPERATURE to a warning as
>  	 * a (conservative) best-effort interpretation.
>  	 */
> -	if (!(*flags & (REGULATOR_ERROR_OVER_TEMP | REGULATOR_ERROR_OVER_TEMP_WARN)) &&
> +	if (!(*error & (REGULATOR_ERROR_OVER_TEMP | REGULATOR_ERROR_OVER_TEMP_WARN)) &&
>  	    (status & PB_STATUS_TEMPERATURE))
> -		*flags |= REGULATOR_ERROR_OVER_TEMP_WARN;
> +		*error |= REGULATOR_ERROR_OVER_TEMP_WARN;
>  
> -	return 0;
> +unlock:
> +	mutex_unlock(&data->update_lock);
> +	return ret;
> +}
> +
> +static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned int *flags)
> +{
> +	struct device *dev = rdev_get_dev(rdev);
> +	struct i2c_client *client = to_i2c_client(dev->parent);
> +	struct pmbus_data *data = i2c_get_clientdata(client);
> +
> +	return pmbus_get_flags(data, rdev_get_id(rdev), flags, false);
>  }
>  
>  static int pmbus_regulator_get_status(struct regulator_dev *rdev)
> @@ -3082,10 +3127,14 @@ static irqreturn_t pmbus_fault_handler(int irq, void *pdata)
>  {
>  	struct pmbus_data *data = pdata;
>  	struct i2c_client *client = to_i2c_client(data->dev);
> -	int i, status;
> +	int i, status, ret;
>  
>  	for (i = 0; i < data->info->pages; i++) {
>  
> +		ret = pmbus_get_flags(data, i, &status, true);
> +		if (ret)
> +			return ret;
> +
>  		mutex_lock(&data->update_lock);
>  		status = pmbus_read_status_word(client, i);
>  		if (status < 0) {
> @@ -3099,7 +3148,7 @@ static irqreturn_t pmbus_fault_handler(int irq, void *pdata)
>  		mutex_unlock(&data->update_lock);
>  	}
>  
> -	return IRQ_HANDLED;
> +	return ret;
>  }
>  
>  static int pmbus_irq_setup(struct i2c_client *client, struct pmbus_data *data)
