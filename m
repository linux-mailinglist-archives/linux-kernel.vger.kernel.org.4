Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A486A3A17
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 05:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjB0EVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 23:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjB0EVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 23:21:51 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1FB113E2;
        Sun, 26 Feb 2023 20:21:45 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id b12so3347373ils.8;
        Sun, 26 Feb 2023 20:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uL6XkSFPewb/bqhbM0dxLzxYJ/yXX81IlEpLJkZ8YvY=;
        b=a5g52OINO5dl9EO/xhXhMYV3JB8p0+1Aff8RT4c3TrROvrtHkyU6RmQRj4hXLDw2b5
         cwVOINTszUJw7T16BYWOuq+EYpQs0LUoDdzSJhSIm17NqzziT91jaqKdT3KwDgSlsxt1
         9MoWzjK3O86evXDEOROgxRt50/Zm9FU8MRbkvKREqXVMdx6Z8sxiNXl3NfcYI/aH5YVO
         Nmd3lezj+bT/ovkXfUFzETG+SFdxSK6sALZN/Ejz2MGAtgXcl599WSLzz690uAJs67oc
         W90zBUm5vk/gXDO4ZJUqHi3QBiffF36hVDv2cJNEyvN3mrHMCuq6tRiEU9CucEy57Ojt
         JNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uL6XkSFPewb/bqhbM0dxLzxYJ/yXX81IlEpLJkZ8YvY=;
        b=jLsN7VAHezOd5I7mlxAyxJK2QntCluyJssgFjydeSxmxP44dAq5ceZgKe8CCS4nBn4
         bPvJlF85rUGLVZbqY/nrEGbJBLXwc4MpXxeRvW2HXS5vOnm144yvj/QVBS+XL7ox3g2k
         VilVgoCfnQze+sD//8c0/YBI5YY0tSRQVAq9MVdK2Mar1Q+RgnoeyrQf4yKfynXvQ2FH
         2Jl+/6I/mdMYJ/gWxxvtwtKQrYi78BReJiXBfp/6VXL3lvNetRvwA1knpN3gE94lSapM
         q5m5wqKgVglliSEnYREXKs5GxcrCZSLp7gLR46ZgEXXeLzvwmPl9ShhTl7kPTQEHDli/
         4S6g==
X-Gm-Message-State: AO0yUKUsp+DVv5IepL1QZoCv+dB8FvkTa8mkcx/BdUcwWGJmpC7CXo4z
        z22FWuN+T23kS2CrDAmojhs=
X-Google-Smtp-Source: AK7set8tqjlxO3zVRD4wQzFy7pQHkVp8d+oiP/UFQBZjDowIpuK2GwZgM1Um1RGmIp70MvrIk9/M0w==
X-Received: by 2002:a05:6e02:19cf:b0:314:e56:54fb with SMTP id r15-20020a056e0219cf00b003140e5654fbmr23675802ill.2.1677471705160;
        Sun, 26 Feb 2023 20:21:45 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q26-20020a02cf1a000000b003b4a1b58572sm1778417jar.152.2023.02.26.20.21.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Feb 2023 20:21:44 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f5043281-9b3e-e454-16fe-ef4cde36dfdb@roeck-us.net>
Date:   Sun, 26 Feb 2023 20:21:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     void0red <void0red@gmail.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, mezin.alexander@gmail.com
References: <42cdd5e4-c9da-b31a-0ffd-76846757645c@roeck-us.net>
 <20230227030913.893004-1-void0red@gmail.com>
 <20230227030913.893004-2-void0red@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 2/2] hwmon: nzxt-smart2: add a check of devm_add_action
 in nzxt_smart2_hid_probe
In-Reply-To: <20230227030913.893004-2-void0red@gmail.com>
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

On 2/26/23 19:09, void0red wrote:
> From: Kang Chen <void0red@gmail.com>
> 
> devm_add_action may fails, check it and return early.
> 
> Signed-off-by: Kang Chen <void0red@gmail.com>
> ---
> v2 -> v1: split the patch
> 
>   drivers/hwmon/nzxt-smart2.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/nzxt-smart2.c b/drivers/hwmon/nzxt-smart2.c
> index 2b93ba896..725974cb3 100644
> --- a/drivers/hwmon/nzxt-smart2.c
> +++ b/drivers/hwmon/nzxt-smart2.c
> @@ -737,8 +737,10 @@ static int nzxt_smart2_hid_probe(struct hid_device *hdev,
>   	init_waitqueue_head(&drvdata->wq);
>   
>   	mutex_init(&drvdata->mutex);
> -	devm_add_action(&hdev->dev, (void (*)(void *))mutex_destroy,
> +	ret = devm_add_action(&hdev->dev, (void (*)(void *))mutex_destroy,
>   			&drvdata->mutex);

Please watch for multi-line alignment. Also, turns out the original
code is wrong: Type casting a function pointer argument like this,
while it typically works in practice, is undefined in C. The function
pointer passed to devm_add_action() needs to point to a local
function with void * argument, and that function needs to call
mutex_destroy() with the same argument. Also, based on the context,
this needs to call devm_add_action_or_reset() to ensure that
the destroy function is called on error.

Thanks,
Guenter

> +	if (ret)
> +		return ret;
>   
>   	ret = hid_parse(hdev);
>   	if (ret)

