Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF8A65BF19
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 12:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237555AbjACLeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 06:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237607AbjACLdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 06:33:39 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90F311444
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 03:30:43 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id g25-20020a7bc4d9000000b003d97c8d4941so17307788wmk.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 03:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AaoqwLXNd+Nz9MWozTVAllt6QGl7h33IQzMR/AB+Kr0=;
        b=HUPZMWdsi2AuvTdn8RF8dL21BsHzEAxCGBURaoDxxLk9hZAPD763lN/U3uQVwe8bdf
         8wsbVG+tgxEkcw/6QZOhB9tiwBJfLaMYHERDDxv7Y/m9vWBBgFzHoXzOk7rLgpSZ8RJ/
         xqwH92Jv7b9gxbibHPcSWvPPHr9psyDVnhX/qrF2zakUZ3Npu2rMff9xI98Jcp2/8DCY
         lky7MgAN+trCwX18jr0SRIjRyP5b3PneyWoBgicZfp23q9dXomp4EcrsjKWphftICaxw
         M7fzJFYXmX4UUL9IbPKmU9c8GIykYj63Rk/o8yl6fqKSmvcyiOrzCX843WCxLCmNgxlN
         qdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AaoqwLXNd+Nz9MWozTVAllt6QGl7h33IQzMR/AB+Kr0=;
        b=N0Oqs0S3PJj4rfLiqeTh+ncaHxGZs6aQiSFjPana8SCpGdfV2Nppl5I0TRf1oX7cCD
         lWlfziAzQBKpos9wLvHeM1GqxwbVPrzv7r6mvL5Qjy2lLUxoWYpVPqRrldtfa+NA6kgl
         nU6IZEFK3aIZZU/FSFr9uKjE0V2Aeg8ykj8P/mhrTI7sTNg8rgunE6ahHGH491IUtega
         7rvie8OGUcYM3gEcKhirj0cXtQluB/EjIWseSjOqdAvSwjHOD25ZLnF8gh+jeF7hM4vH
         etpGpdJSPHO7CTuJLqkA3eiNkf/EFLhgeYEhmGC4XcdZIsiurXdt7PY8lkbMEeAqeWq3
         3Mgw==
X-Gm-Message-State: AFqh2krJKGllXg50elC4mpRbs8cJdKgt/AlHo8Hmvg6AkwFUrz486+LJ
        tU6aUQkHL9rtkm/MutWir8w8JA==
X-Google-Smtp-Source: AMrXdXt4jhLz1x+jeDN1TjI8YRO1uTOwF6oRgU+etPH52kbYUO0uHTJOc+wM9A1CCNpEISdyCw8Rag==
X-Received: by 2002:a05:600c:43ca:b0:3d0:73f5:b2c0 with SMTP id f10-20020a05600c43ca00b003d073f5b2c0mr32698726wmn.20.1672745438153;
        Tue, 03 Jan 2023 03:30:38 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id m28-20020a05600c3b1c00b003d1e3b1624dsm50704696wms.2.2023.01.03.03.30.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 03:30:37 -0800 (PST)
Message-ID: <bad6a162-3e82-2f5e-1822-23951b61450b@linaro.org>
Date:   Tue, 3 Jan 2023 11:30:36 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] nvmem: fix registration vs use race
Content-Language: en-US
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
References: <E1pCdoY-0044aT-A5@rmk-PC.armlinux.org.uk>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <E1pCdoY-0044aT-A5@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/01/2023 09:42, Russell King (Oracle) wrote:
> The i.MX6 CPU frequency driver sometimes fails to register at boot time
> due to nvmem_cell_read_u32() sporadically returning -ENOENT.
> 
> This happens because there is a window where __nvmem_device_get() in
> of_nvmem_cell_get() is able to return the nvmem device, but as cells
> have been setup, nvmem_find_cell_entry_by_node() returns NULL.
> 
> The occurs because the nvmem core registration code violates one of the
> fundamental principles of kernel programming: do not publish data
> structures before their setup is complete.
> 
> Fix this by making nvmem core code conform with this principle.
> 
how about a Fixes tag and Cc stable?

> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>   drivers/nvmem/core.c | 18 ++++++++----------
>   1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 321d7d63e068..6b89fb6fa582 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -835,22 +835,16 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>   	nvmem->dev.groups = nvmem_dev_groups;
>   #endif
>   
> -	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
> -
> -	rval = device_register(&nvmem->dev);
> -	if (rval)
> -		goto err_put_device;
> -
>   	if (nvmem->nkeepout) {
>   		rval = nvmem_validate_keepouts(nvmem);
>   		if (rval)
> -			goto err_device_del;
> +			goto err_put_device;

AFAIU, as we never did a get_device/kobject_get, calling put_device at 
this point will not invoke a release callback which can potentially leak 
both nvmem and ida.


--srini
>   	}
>   
>   	if (config->compat) {
>   		rval = nvmem_sysfs_setup_compat(nvmem, config);
>   		if (rval)
> -			goto err_device_del;
> +			goto err_put_device;
>   	}
>   
>   	if (config->cells) {
> @@ -867,6 +861,12 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>   	if (rval)
>   		goto err_remove_cells;
>   
> +	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
> +
> +	rval = device_register(&nvmem->dev);
> +	if (rval)
> +		goto err_remove_cells;
> +
>   	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem);
>   
>   	return nvmem;
> @@ -876,8 +876,6 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>   err_teardown_compat:
>   	if (config->compat)
>   		nvmem_sysfs_remove_compat(nvmem, config);
> -err_device_del:
> -	device_del(&nvmem->dev);
>   err_put_device:
>   	put_device(&nvmem->dev);
>   
