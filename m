Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F85065BEDD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 12:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjACLYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 06:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbjACLYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 06:24:15 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCDB10EE
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 03:24:14 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id b24-20020a05600c4a9800b003d21efdd61dso22844647wmp.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 03:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aM19bk+2PSoO6lDFC0lZ/JmQltFQ351Ko7Fkp/8cpJg=;
        b=FvQ2z2GpdrHYPMRbQ7exRNu0TReI7Pd2G2HPrkGzBDACmtFIVcCMpb8ZAVWPAUwTc5
         tFq99Tq4nSj8/0edkuZsgJYewmQ94M7JljTMPSeXZIgh6XMpSyFvDq/GU+wmIJm1RtHl
         AynPkEolxmN0ZqqlYYVZMENvtrRq770f1Mwais801+EZecQvVHgO57gHiOoK1OOBlJbI
         nlYgG8qF1xGloAdsZRIV0lzuYkqsWrTTJlYGyeKqfo9hy5W/XQHCXduhS970HhwTXZNV
         +4oAAdYepQGhIT94dkcLSIcc/ThwVGrjfy9zPLwckVffBO/rvdcW9BiHYVyjWDaOY88W
         ycpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aM19bk+2PSoO6lDFC0lZ/JmQltFQ351Ko7Fkp/8cpJg=;
        b=L9gKtXjY2AAuh0TsUsy5kystxh2/yysgThFgpZaZow6KhGThQ7GpAlv9zwKN+dzAuK
         02SFOF5QXfmy+MLbWut2xguBMC4iX53ddd3lcQaEVQ3iUdPMoRj8s0pSHs0wqMwY7Dkd
         bC2Hr85Kn8XhdSlgAQ25mHHCRkptrwE01QPkzaFaGDWXgF6DQdF9OjMQSGRRr+d+qTP4
         Cqrq3tECG64EwTX6iChx+xNEz22xauhTT1bjajqkIUhE9904D/CYOnHUTJRafIY/+EL2
         pi68RQaUP3x9Va49ZGjic4l6uXjHmwBNYU5GxLflLS0BDnmavE26I5t1o8bP+qDbFPQg
         68uA==
X-Gm-Message-State: AFqh2kqLVO65WZc0sG2UlQKPNpicwWHrV3JnZS+eq5PgFQO9sHzqwTDG
        zJ2YnIn1R9fX51uVdfZ/qh2VkmbjTEAw+886WPA=
X-Google-Smtp-Source: AMrXdXsu4u0wS962KDrqVuRXWqgErsy12KGEqrrdIuV/v8sTQ2HhnIDVP5FKAwi4HI638j+JyW33Lw==
X-Received: by 2002:a05:600c:a10:b0:3d5:64bf:ccb8 with SMTP id z16-20020a05600c0a1000b003d564bfccb8mr30880129wmp.12.1672745053251;
        Tue, 03 Jan 2023 03:24:13 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id r17-20020a05600c425100b003cffd3c3d6csm39874902wmm.12.2023.01.03.03.24.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 03:24:12 -0800 (PST)
Message-ID: <6b7d1e08-e27e-3f8a-5b08-ba622f206295@linaro.org>
Date:   Tue, 3 Jan 2023 11:24:11 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] nvmem: core: Fix race in nvmem_register()
To:     Hector Martin <marcan@marcan.st>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Russell King <rmk+kernel@armlinux.org.uk>
References: <20221214142952.9372-1-marcan@marcan.st>
Content-Language: en-US
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20221214142952.9372-1-marcan@marcan.st>
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

Thanks Hector for the patch,


On 14/12/2022 14:29, Hector Martin wrote:
> nvmem_register() currently registers the device before adding the nvmem
> cells, which creates a race window where consumers may find the nvmem
> device (and not get PROBE_DEFERred), but then fail to find the cells and
> error out.
> 
> Move device registration to the end of nvmem_register(), to close the
> race.
> 
> Observed when the stars line up on Apple Silicon machines with the (not
> yet upstream, but trivial) spmi nvmem driver and the macsmc-rtc client:
> 
> [    0.487375] macsmc-rtc macsmc-rtc: error -ENOENT: Failed to get rtc_offset NVMEM cell
> 
> Fixes: eace75cfdcf7 ("nvmem: Add a simple NVMEM framework for nvmem providers")
> Signed-off-by: Hector Martin <marcan@marcan.st>

Missing Cc Stable

> ---
>   drivers/nvmem/core.c | 18 ++++++++----------
>   1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 321d7d63e068..d255feca5e17 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -837,20 +837,16 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
> 
>   	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
> 
> -	rval = device_register(&nvmem->dev);
> -	if (rval)
> -		goto err_put_device;
> -
>   	if (nvmem->nkeepout) {
>   		rval = nvmem_validate_keepouts(nvmem);
>   		if (rval)
> -			goto err_device_del;
> +			return ERR_PTR(rval);

you can not do this as this will leak ida and nvmem itself.


>   	}
> 
>   	if (config->compat) {
>   		rval = nvmem_sysfs_setup_compat(nvmem, config);
>   		if (rval)
> -			goto err_device_del;
> +			return ERR_PTR(rval);

same here.

>   	}
> 
>   	if (config->cells) {
> @@ -867,19 +863,21 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>   	if (rval)
>   		goto err_remove_cells;
> 
> +	rval = device_register(&nvmem->dev);
> +	if (rval)
> +		goto err_put_device;
> +
>   	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem);
> 
>   	return nvmem;
> 
> +err_put_device:
> +	put_device(&nvmem->dev);

this will free nvmem and further down you are going to de-reference the 
freed pointer.

--srini

>   err_remove_cells:
>   	nvmem_device_remove_all_cells(nvmem);
>   err_teardown_compat:
>   	if (config->compat)
>   		nvmem_sysfs_remove_compat(nvmem, config);
> -err_device_del:
> -	device_del(&nvmem->dev);
> -err_put_device:
> -	put_device(&nvmem->dev);
> 
>   	return ERR_PTR(rval);
>   }
> --
> 2.35.1
> 
