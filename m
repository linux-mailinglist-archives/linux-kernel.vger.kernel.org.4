Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490476260A3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 18:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbiKKRoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 12:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbiKKRoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 12:44:15 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E029B19C22
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 09:44:13 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id cl5so7366132wrb.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 09:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FMV5iT6EwMJMBOTsytjNlah8Ii1TaPBrsBydlJ5BQQc=;
        b=sgtmBWetEjZ8iUpAOZ5ubXzAaDIt+3JPUBKXSRR4F0Y2DbqotpQ4jo5ZPZRcwscIai
         zh49KdKxysg/3mnnczjjM6ytsercCGZ6q68pynqR+n+hLDG4XlytXxO1wjJgJpJ/cx1+
         pyDWWJ0Lcwvr9WUE1tKFeoIY1XdQLZCtXHQaWdZehX9np/xIXHohERqSbGKu0dCkcGM7
         ZtAzDOdI8wUfAC4uyXoKVSzqB69rDsyemyrVrouZ0BxNTvn0M6t70pBQLU3k8qAVblRD
         pYmh3KpIgTtbemmvhbWbPQetIXJI3U/Dj0E/ECqwvw9VqRPoHoT5boDbB+H0gWds7HMp
         hm2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FMV5iT6EwMJMBOTsytjNlah8Ii1TaPBrsBydlJ5BQQc=;
        b=GckfmOePGDc+EaFOu9ZT0ujzpaK8392dwMq1nUqm8UOgUhingswKV8GlcOfwisBvGd
         pzjk2cimldVCqOhDff0nWL+ttjj1eeS/baq/XrOaRSJ4RDSUuVTK5OrjXehngzCDXeil
         88wZhI5XAsljZxcELtgXQc4SY33X/bHKJJBnW9A5MiYVoI0ifa6eqOAjrRAYsS0SDZ1+
         cnNvbG0gu4fB45B4cUcVBDstUgIaaQL0VZagKqXN2V7bq6IEzCe3shMBS1kgA+L2OAUk
         oXdPr58318dDjnwKGlmjl3/uT8CFuLGyIdYYaQ2FNEcGuWla2yS1edCs+kafcUj4DQ0W
         2qVg==
X-Gm-Message-State: ANoB5pnrmK1ZuQWQrzld6wAROplAfVcLa3fbf4KJaK5wHajQZR19suQI
        DxNi3DJPKNsie31fDwdJV0YqBUjqjUmj8A==
X-Google-Smtp-Source: AA0mqf75DnjwsqoUbjo6UIToo4CVck1T7/Dhqlop7bSiSNYQOaubZKpWS87zn+ZqhKo5hv8qHJqGRA==
X-Received: by 2002:a05:6000:98b:b0:236:6a53:3a19 with SMTP id by11-20020a056000098b00b002366a533a19mr1859593wrb.409.1668188652474;
        Fri, 11 Nov 2022 09:44:12 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id j5-20020a05600c1c0500b003cfbbd54178sm14479162wms.2.2022.11.11.09.44.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 09:44:11 -0800 (PST)
Message-ID: <1f230520-b035-c14d-4262-49a52ec6a557@linaro.org>
Date:   Fri, 11 Nov 2022 17:44:11 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH RESEND] nvmem: Fix return value check in rmem_read()
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org
Cc:     Wei Yongjun <weiyongjun1@huawei.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
References: <20221102032523.1488171-1-yangyingliang@huawei.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20221102032523.1488171-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/11/2022 03:25, Yang Yingliang wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> In case of error, the function memremap() returns NULL pointer
> not ERR_PTR(). The IS_ERR() test in the return value check
> should be replaced with NULL test.
> 
> Fixes: 5a3fa75a4d9c ("nvmem: Add driver to expose reserved memory as nvmem")
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
> The previous patch link:
> https://lore.kernel.org/all/2fff7c82d983baccb91c4a1c0891a9b6cdc50dd6.camel@suse.de/T/
> ---

Applied thanks,

--srini
>   drivers/nvmem/rmem.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvmem/rmem.c b/drivers/nvmem/rmem.c
> index b11c3c974b3d..80cb187f1481 100644
> --- a/drivers/nvmem/rmem.c
> +++ b/drivers/nvmem/rmem.c
> @@ -37,9 +37,9 @@ static int rmem_read(void *context, unsigned int offset,
>   	 * but as of Dec 2020 this isn't possible on arm64.
>   	 */
>   	addr = memremap(priv->mem->base, available, MEMREMAP_WB);
> -	if (IS_ERR(addr)) {
> +	if (!addr) {
>   		dev_err(priv->dev, "Failed to remap memory region\n");
> -		return PTR_ERR(addr);
> +		return -ENOMEM;
>   	}
>   
>   	count = memory_read_from_buffer(val, bytes, &off, addr, available);
