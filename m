Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD2D740667
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 00:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjF0WTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 18:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjF0WT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 18:19:29 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC471272D;
        Tue, 27 Jun 2023 15:19:28 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b6824141b4so2300145ad.1;
        Tue, 27 Jun 2023 15:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687904368; x=1690496368;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=P+Fhk2g29iBTSAUG5HoCrEIPD53b4WWF0g9930Rklbc=;
        b=cpYDer6oYIb+sxh+QqbDBsxj2hMClIrc/xSpxzZLzX+9t8CUGinJC5eiLwFXpI9qH0
         kXyK3AOjSKq1qRCo7BDpEJAuOUUbA4K26eCE3/xZCZBolAY71Hxt/yHrVUVI6pL8HqNV
         2Den0f6dGuWPx2lrKHZ64yXcuUiOeJXBrDk9CjaSGGjp8FXR+znhYYldMco+AhBblF0D
         IcpSu4Q5jDveyTeqXZrjlg8DIryUJjfW+crOIlvltFK7iynt40/vR5eQpXIWvJKFGiRh
         FZdD81uZP3tjKmf223pwLSRpLRcsRvoKCkivuGVyvIOs9gbZuq/G2w8J15H42C44qmNZ
         7Siw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687904368; x=1690496368;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P+Fhk2g29iBTSAUG5HoCrEIPD53b4WWF0g9930Rklbc=;
        b=TBkyOOzTKCYQnQERnSf4jmAlBVzoKWfa3gezG/AEvyWSYAAuKO7HFNguWrRX1alQBo
         zjpozTGhWBW+OlVALKZqXJIzWi8QEz64xMoCzl7stV0JRC6rYPLYvfNZLwntwp9/irM4
         RBbrbobw9gyu9AfHso0KNbCEP4KmsJ0G5dh+VOk3cZKyArfANnArvC2uE3rD9yPtWy0Q
         sO73KjeefQILoS8g3wb+SPHEaSdb7Qzo81vqHtRv9GGVIfMQ5zx3DvoDvx+Ut0hNI7NI
         VRsM19FYL7yTEU/2bZ8GG2wqGIyR/SWKOhiltIe46mLItoTvoqNeG55JGlislh2DZr8U
         fGGg==
X-Gm-Message-State: AC+VfDwXnGMR4e62fcKQEt6WITuAtjKyrockIelNPRFuFzCJ/OFVh4gJ
        SUYvCYHvaPs1X+0qi+cJuEk=
X-Google-Smtp-Source: ACHHUZ4BL92o5s7HbEGrIxLqFW0xDI1fsPAebcBrhWoA23bcMEiVdiVman2cCs3uR7zgWt/GMoaCgw==
X-Received: by 2002:a17:902:d2c7:b0:1b8:2c2a:9629 with SMTP id n7-20020a170902d2c700b001b82c2a9629mr2332579plc.19.1687904368241;
        Tue, 27 Jun 2023 15:19:28 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e6-20020a170902cf4600b001b1c4d875f5sm6430822plg.44.2023.06.27.15.19.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 15:19:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <460709cb-3c5f-436a-e9e7-2562ab079677@roeck-us.net>
Date:   Tue, 27 Jun 2023 15:19:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] hwmon: (pmbus/acbel-fsg032) Add firmware version debugfs
 attribute
Content-Language: en-US
To:     Eddie James <eajames@linux.ibm.com>, linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jdelvare@suse.com,
        lakshmiy@us.ibm.com
References: <20230627184027.16343-1-eajames@linux.ibm.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230627184027.16343-1-eajames@linux.ibm.com>
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

On 6/27/23 11:40, Eddie James wrote:
> Like the IBM CFFPS driver, export the PSU's firmware version to a
> debugfs attribute as reported in the manufacturer register.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>   drivers/hwmon/pmbus/acbel-fsg032.c | 48 ++++++++++++++++++++++++++++++
>   1 file changed, 48 insertions(+)
> 
> diff --git a/drivers/hwmon/pmbus/acbel-fsg032.c b/drivers/hwmon/pmbus/acbel-fsg032.c
> index 0a0ef4ce3493..4b97f108cfe3 100644
> --- a/drivers/hwmon/pmbus/acbel-fsg032.c
> +++ b/drivers/hwmon/pmbus/acbel-fsg032.c
> @@ -3,6 +3,7 @@
>    * Copyright 2023 IBM Corp.
>    */
>   
> +#include <linux/debugfs.h>
>   #include <linux/device.h>
>   #include <linux/fs.h>
>   #include <linux/i2c.h>
> @@ -11,6 +12,52 @@
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
> +	rc = pmbus_lock_interruptible(client);

Is that needed here ?

> +	if (rc)
> +		return rc;
> +
> +	rc = i2c_smbus_read_block_data(client, ACBEL_MFR_FW_REVISION, data);
> +	pmbus_unlock(client);
> +	if (rc < 0)
> +		return rc;
> +
> +	for (i = 0; i < rc && i < 3; ++i)
> +		snprintf(&out[i * 2], 3, "%02X", data[i]);
> +
> +	rc = i * 2;
> +	out[rc++] = '\n';
> +	out[rc++] = 0;

Any reason for not using one of the %*ph variants ?

Thanks,
Guenter

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
> @@ -59,6 +106,7 @@ static int acbel_fsg032_probe(struct i2c_client *client)
>   	if (rc)
>   		return rc;
>   
> +	acbel_fsg032_init_debugfs(client);
>   	return 0;
>   }
>   

