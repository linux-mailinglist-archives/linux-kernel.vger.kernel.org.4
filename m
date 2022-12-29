Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031A9658DF3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 15:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbiL2OkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 09:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiL2OkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 09:40:17 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A1C6555;
        Thu, 29 Dec 2022 06:40:14 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id p17-20020a9d6951000000b00678306ceb94so11570224oto.5;
        Thu, 29 Dec 2022 06:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a/XGav2fVBrMMfQpmyYq7BMpz+OnssndpRxnYupnueU=;
        b=AdJPo8vLnRuly1dfKC8NK6rj+69wFvWsRgK1CHo2eM6KQbkgBBUKgDa+HA7HgQjVLE
         6LuNL5ZgyejnpJBKdb3ucTYkXps4mpwHFarRa/7dTDhp0lc2FUyazciXTnQ48hUcxrEn
         fTZt9IkBJjmMwJqfLdZX8R9JPGombopx7ypyM253YhRn/+IlZsoItE+YvCWVK8PukJmf
         ksj7/Z8XMRHl8EqmwzNAeBFzm1cvRz8lqmAMEM1wU56QN8jCDhyQberebavtENPARZkI
         PsFrtau42cLMdwd3Ehf+RuuPz9T+ruzcyegELmiWOg2rKKfbn8yRb8a37gciIWZWjRiy
         8rkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/XGav2fVBrMMfQpmyYq7BMpz+OnssndpRxnYupnueU=;
        b=k+wua3fCnvYizgIo2emh1DaKchzpX7KKNvSODLLDTf8DCACXGvupzllFL5xq871O6l
         DgnPpo8tIFi7azHkUzhb6R9po34dLGQQQ357M1YFodQKx7HMNJOA2YB5MkG4J8lnTqWT
         57Ze8YJ8I1++EJiMRl13/GRBGrHElVCsAxVc/bJwUX7ynFSGGW9UFGe68I7KmEwTmesw
         ztI/10bijdbikbgBiwanVErm9pwmrclJUXoFBcKmAA7Zy9ehxFSEFB+zJprgXv8PM2n4
         BjMP3RuJzN8TNmfJhPKubLpBU/ljg4QJ4N0z8Tm3q5agH2W4QG85nn4n35R84Sbytizz
         +QzA==
X-Gm-Message-State: AFqh2koBaQVTMXH001jiZm1bkznqITX2p8dxnpdhk3njVfpJFFb5GKdb
        m+HDdqixfXdIJsU9Ygv11KCDNwA1LmQ=
X-Google-Smtp-Source: AMrXdXt9X/gPI2Xaz7I3GHM3wW4t6mk/eFPmGOU42r16earhKt0Cs6rBhsOR+7uHbk9gOpsGw58mOA==
X-Received: by 2002:a9d:6007:0:b0:661:dfeb:ae15 with SMTP id h7-20020a9d6007000000b00661dfebae15mr13982072otj.12.1672324813886;
        Thu, 29 Dec 2022 06:40:13 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r26-20020a05683001da00b006706247fdbfsm9196714ota.23.2022.12.29.06.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 06:40:13 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 29 Dec 2022 06:40:12 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH RESEND v6 1/5] hwmon: (pmbus/core): Add interrupt support
Message-ID: <20221229144012.GA21213@roeck-us.net>
References: <20221214080715.2700442-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214080715.2700442-1-Naresh.Solanki@9elements.com>
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

On Wed, Dec 14, 2022 at 09:07:11AM +0100, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Implement PMBUS irq handler.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>

$ scripts/checkpatch.pl --strict index.html
CHECK: Blank lines aren't necessary after an open brace '{'
#131: FILE: drivers/hwmon/pmbus/pmbus_core.c:3088:
+	for (i = 0; i < data->info->pages; i++) {
+

CHECK: Alignment should match open parenthesis
#183: FILE: drivers/hwmon/pmbus/pmbus_core.c:3140:
+	ret = devm_request_threaded_irq(dev, client->irq, NULL, pmbus_fault_handler,
+			      0, "pmbus-irq", data);

CHECK: Please use a blank line after function/struct/union/enum declarations
#197: FILE: drivers/hwmon/pmbus/pmbus_core.c:3154:
 }
+static int pmbus_irq_setup(struct i2c_client *client, struct pmbus_data *data)

total: 0 errors, 0 warnings, 3 checks, 109 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

index.html has style problems, please review.

Please run checkpatch --strict on your patches.
Also see Documentation/hwmon/submitting-patches.rst.

> ---
>  drivers/hwmon/pmbus/pmbus.h      |  2 +-
>  drivers/hwmon/pmbus/pmbus_core.c | 84 ++++++++++++++++++++++++++++++++
>  2 files changed, 85 insertions(+), 1 deletion(-)
> 
> 
> base-commit: 364ffd2537c44cb6914ff5669153f4a86fffad29
> 
> diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
> index 10fb17879f8e..6b2e6cf93b19 100644
> --- a/drivers/hwmon/pmbus/pmbus.h
> +++ b/drivers/hwmon/pmbus/pmbus.h
> @@ -26,7 +26,7 @@ enum pmbus_regs {
>  
>  	PMBUS_CAPABILITY		= 0x19,
>  	PMBUS_QUERY			= 0x1A,
> -
> +	PMBUS_SMBALERT_MASK		= 0x1B,
>  	PMBUS_VOUT_MODE			= 0x20,
>  	PMBUS_VOUT_COMMAND		= 0x21,
>  	PMBUS_VOUT_TRIM			= 0x22,
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 95e95783972a..244fd2597252 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -3072,11 +3072,89 @@ static int pmbus_regulator_register(struct pmbus_data *data)
>  
>  	return 0;
>  }
> +
> +static int pmbus_write_smbalert_mask(struct i2c_client *client, u8 page, u8 reg, u8 val)
> +{
> +	return pmbus_write_word_data(client, page, PMBUS_SMBALERT_MASK, reg | (val << 8));
> +}
> +
> +static irqreturn_t pmbus_fault_handler(int irq, void *pdata)
> +{
> +	struct pmbus_data *data = pdata;
> +	struct i2c_client *client = to_i2c_client(data->dev);
> +	int i, status;
> +
> +	for (i = 0; i < data->info->pages; i++) {
> +
> +		mutex_lock(&data->update_lock);
> +		status = pmbus_read_status_word(client, i);
> +		if (status < 0) {
> +			mutex_unlock(&data->update_lock);
> +			return status;
> +		}
> +
> +		if (status & ~(PB_STATUS_OFF | PB_STATUS_BUSY | PB_STATUS_POWER_GOOD_N))
> +			pmbus_clear_fault_page(client, i);
> +
> +		mutex_unlock(&data->update_lock);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int pmbus_irq_setup(struct i2c_client *client, struct pmbus_data *data)
> +{
> +	struct device *dev = &client->dev;
> +	const struct pmbus_regulator_status_category *cat;
> +	const struct pmbus_regulator_status_assoc *bit;
> +	int i, j, err, ret, func;
> +	u8 mask;
> +
> +	for (i = 0; i < data->info->pages; i++) {
> +		func = data->info->func[i];
> +
> +		for (j = 0; j < ARRAY_SIZE(pmbus_regulator_flag_map); j++) {
> +			cat = &pmbus_regulator_flag_map[j];
> +			if (!(func & cat->func))
> +				continue;
> +			mask = 0;
> +			for (bit = cat->bits; bit->pflag; bit++)
> +				mask |= bit->pflag;
> +
> +			err = pmbus_write_smbalert_mask(client, i, cat->reg, ~mask);
> +			if (err)
> +				dev_err(dev, "Failed to set smbalert for reg 0x%02x\n",	cat->reg);

This concerns me. It might mean that the chip does not support
PMBUS_SMBALERT_MASK. If so, there would be lots of error messages.

> +		}
> +
> +		pmbus_write_smbalert_mask(client, i, PMBUS_STATUS_CML, 0xff);
> +		pmbus_write_smbalert_mask(client, i, PMBUS_STATUS_OTHER, 0xff);
> +		pmbus_write_smbalert_mask(client, i, PMBUS_STATUS_MFR_SPECIFIC, 0xff);

Why check the return value from pmbus_write_smbalert_mask above but not here ?

> +		if (data->info->func[i] & PMBUS_HAVE_FAN12)
> +			pmbus_write_smbalert_mask(client, i, PMBUS_STATUS_FAN_12, 0xff);
> +		if (data->info->func[i] & PMBUS_HAVE_FAN34)
> +			pmbus_write_smbalert_mask(client, i, PMBUS_STATUS_FAN_34, 0xff);
> +	}
> +
> +	/* Register notifiers - can fail if IRQ is not given */

The comment does not make sense. pmbus_irq_setup() is not called
if the interrupt "is not given".

> +	ret = devm_request_threaded_irq(dev, client->irq, NULL, pmbus_fault_handler,
> +			      0, "pmbus-irq", data);
> +	if (ret) {
> +		dev_warn(dev, "IRQ disabled %d\n", ret);

This is not a warning, it is an error.

> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  #else

This is still in regulator code. I said several times that this is not
acceptable.

>  static int pmbus_regulator_register(struct pmbus_data *data)
>  {
>  	return 0;
>  }
> +static int pmbus_irq_setup(struct i2c_client *client, struct pmbus_data *data)
> +{
> +	return 0;
> +}
>  #endif
>  
>  static struct dentry *pmbus_debugfs_dir;	/* pmbus debugfs directory */
> @@ -3441,6 +3519,12 @@ int pmbus_do_probe(struct i2c_client *client, struct pmbus_driver_info *info)
>  	if (ret)
>  		return ret;
>  
> +	if (client->irq > 0) {
> +		ret = pmbus_irq_setup(client, data);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	ret = pmbus_init_debugfs(client, data);
>  	if (ret)
>  		dev_warn(dev, "Failed to register debugfs\n");
