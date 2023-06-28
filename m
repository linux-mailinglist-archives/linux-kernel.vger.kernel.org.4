Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91AF6741695
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 18:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbjF1QkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 12:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbjF1QkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 12:40:20 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A6510EC;
        Wed, 28 Jun 2023 09:40:19 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-666e97fcc60so3658060b3a.3;
        Wed, 28 Jun 2023 09:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687970418; x=1690562418;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=NgH0xFXB78gww0842WKP7TdRsc0P358NQ2JRQ2T5QSU=;
        b=fYUHvSQKwv2K2FUoJ+LMoSOW8PSb+vPjJjS9NQjgQ4mb4aEd8JdOBAJVs7XUwKpffz
         luLmeC2Er3iwQV+0oy2o2CQhiHGC2SvY64TtQcJtS+KlyfQU5KVVF149fh4koGGReDZM
         CzJKip+ePmhFuuy7WNbh1DFHtNkf7t8zhVHICs7HSZq/6vUS7xZF9czIc0DUR/OYcdc4
         Bv/AH1MwdJJT7jsAwyGkBtXaOoSJtGGFDQwXpQ9zAqFZmZf4Dn5jW5v9cfan/BCgI+SD
         NbXiCh1H9UcWLI4jo5/bLyAtge7fM+jFMAeqE4+TnS7Nlo4gEl/xWuW0AwWji+fsTuug
         czwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687970418; x=1690562418;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NgH0xFXB78gww0842WKP7TdRsc0P358NQ2JRQ2T5QSU=;
        b=RaGDrrTsHwNkWADBoZs89v0Kbqx+hoLygBo162yisT97Q2wDsfDl7xSkCEqGeKHwQu
         znsmz2BNiIm6vzzvPl9L+65ILYjfAsrUTEUYQGmAZCQ7cIZKKHHsjhxtG5p/4dQzHdVo
         aWid3cPd2/dyajcwW6gtn8mlktwkOTg55PSWNXqZjkCLXMTRezCiPLrrADvcANq01syq
         +cZyoC9lylxGD/ocnMvsIjJkuogzYrtncJHL+oFSqsNBBVJ2pj9/WlQp/Wpzn2YtMLjb
         CG0Ad9hgQo0hbBJBSEVrivKrAKcLXrVzrOfiNXwELQ5zDVX9l255uEKYnIkXSOT6rOeX
         FlLA==
X-Gm-Message-State: AC+VfDyzlomknvlJPqgrEjsCamiOCJu2/RliiVVpiwb0APv8XsmSJQSG
        uNM3fy0C31M9paHhU+VXZrk=
X-Google-Smtp-Source: ACHHUZ77RNKYTnEbcvUnwxzdTILvYv00tgcRVJLyFl6N9LlWYpRqjm47Nt62GTh6lm9b+eeUo5Sl+g==
X-Received: by 2002:a05:6a00:124b:b0:680:6d16:8f8c with SMTP id u11-20020a056a00124b00b006806d168f8cmr2945739pfi.32.1687970418562;
        Wed, 28 Jun 2023 09:40:18 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 3-20020aa79103000000b00634dde2992bsm1131941pfh.132.2023.06.28.09.40.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 09:40:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <146c79a7-22f6-8466-150d-8cfe3ac46337@roeck-us.net>
Date:   Wed, 28 Jun 2023 09:40:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] hwmon: (pmbus/acbel-fsg032) Add firmware version
 debugfs attribute
Content-Language: en-US
To:     Eddie James <eajames@linux.ibm.com>, linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jdelvare@suse.com,
        lakshmiy@us.ibm.com
References: <20230628153453.122213-1-eajames@linux.ibm.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230628153453.122213-1-eajames@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/23 08:34, Eddie James wrote:
> Like the IBM CFFPS driver, export the PSU's firmware version to a
> debugfs attribute as reported in the manufacturer register.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

For my reference:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

I'll apply after the commit window closes.

Thanks,
Guenter

> ---
> Changes since v1:
>   - Remove locking since there's only one page
>   - Switch to %*ph in snprintf instead of loop of %02x
> 
>   drivers/hwmon/pmbus/acbel-fsg032.c | 39 ++++++++++++++++++++++++++++++
>   1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/hwmon/pmbus/acbel-fsg032.c b/drivers/hwmon/pmbus/acbel-fsg032.c
> index 0a0ef4ce3493..6413f5ae605f 100644
> --- a/drivers/hwmon/pmbus/acbel-fsg032.c
> +++ b/drivers/hwmon/pmbus/acbel-fsg032.c
> @@ -3,14 +3,52 @@
>    * Copyright 2023 IBM Corp.
>    */
>   
> +#include <linux/debugfs.h>
>   #include <linux/device.h>
>   #include <linux/fs.h>
>   #include <linux/i2c.h>
> +#include <linux/minmax.h>
>   #include <linux/module.h>
>   #include <linux/pmbus.h>
>   #include <linux/hwmon-sysfs.h>
>   #include "pmbus.h"
>   
> +#define ACBEL_MFR_FW_REVISION	0xd9
> +
> +static ssize_t acbel_fsg032_debugfs_read(struct file *file, char __user *buf, size_t count,
> +					 loff_t *ppos)
> +{
> +	struct i2c_client *client = file->private_data;
> +	char data[I2C_SMBUS_BLOCK_MAX + 2] = { 0 };
> +	char out[8];
> +	int rc;
> +	int i;
> +
> +	rc = i2c_smbus_read_block_data(client, ACBEL_MFR_FW_REVISION, data);
> +	if (rc < 0)
> +		return rc;
> +
> +	rc = snprintf(out, sizeof(out), "%*phN\n", min(rc, 3), data);
> +	return simple_read_from_buffer(buf, count, ppos, out, rc);
> +}
> +
> +static const struct file_operations acbel_debugfs_ops = {
> +	.llseek = noop_llseek,
> +	.read = acbel_fsg032_debugfs_read,
> +	.write = NULL,
> +	.open = simple_open,
> +};
> +
> +static void acbel_fsg032_init_debugfs(struct i2c_client *client)
> +{
> +	struct dentry *debugfs = pmbus_get_debugfs_dir(client);
> +
> +	if (!debugfs)
> +		return;
> +
> +	debugfs_create_file("fw_version", 0444, debugfs, client, &acbel_debugfs_ops);
> +}
> +
>   static const struct i2c_device_id acbel_fsg032_id[] = {
>   	{ "acbel_fsg032" },
>   	{}
> @@ -59,6 +97,7 @@ static int acbel_fsg032_probe(struct i2c_client *client)
>   	if (rc)
>   		return rc;
>   
> +	acbel_fsg032_init_debugfs(client);
>   	return 0;
>   }
>   

