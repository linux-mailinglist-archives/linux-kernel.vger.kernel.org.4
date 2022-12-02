Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043C064114F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 00:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbiLBXFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 18:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbiLBXFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 18:05:37 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CDBD96B3;
        Fri,  2 Dec 2022 15:05:36 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id k79so6230134pfd.7;
        Fri, 02 Dec 2022 15:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xoKGdyet0PQObJj6Xh0zsA2f36Pp85EMjbnYEnvmUQM=;
        b=fD0j8/NbOIYsu1b4LsqR19QLAAU7FAD8DTiDm65Mre41p1On8RUqOMsCRmJEWSTiAj
         kekt7P6VcIXmTxawyoMYYylhh8C7C6byqIGrsUa6Qv3R50VkDha0NMgqrAMOiEseP27P
         Kx8hwqLBvOb7OkhotbqBDZbRFyRIiqE98+bHrSxJCeMD7qjGfCwFl7SxgKWjEhkqcib6
         OIV5RlARpikUqdNKX7nXQPwv7bgUrMGWhozi0XhKJ137iGZwB4wMu8HSn/ec/bWCERaz
         s6HqsH87QsbvNnK25zSJibAl5Samwe1cYd5vaeabtsjLWV02dJFqkgieCdQ3Pt+O2kAG
         gDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xoKGdyet0PQObJj6Xh0zsA2f36Pp85EMjbnYEnvmUQM=;
        b=3oB4eWFiDht3Hy8oyghCgKEEc8pXc28FUtUEqDXo6KUEFlGrBxzj0OuIvPr7rCW40q
         YuK02VMxMCrG8YkRYE4FELJv0uCPCDSsh7y+hsKkJQd+M2uX3qPIjINtlqMdAyR/2jsL
         PMsD4/gX4AdDX7UfwojPbhW7VF2lclKvnKgwoGLEJCRsHPUfFjki+l6UX5zgYc3TaJgQ
         /Urfj35ZJredD9Wu0w1QFBbWXS3u8hm441w4YiTQnZau1zpjGmktTLxgXGrXgvPyBwpc
         9yY6jBPKZ3MX4GDtKskjydxTtEEcANh8q5EZykhA/yEXcGge40VOeF0IkVznlEfpFcdj
         Sobg==
X-Gm-Message-State: ANoB5pnPjreXWhe8rpZrXydlshYw4IPqYWWjvPa6mR2jzX2rsjmXUcUn
        7E4K51/Y5Lk20ZqEqE9IS+rf5w+Vh0YDkQ==
X-Google-Smtp-Source: AA0mqf6EbrtO+qzxMt/ip1UyDT+37W0dLxgRtcEst9/PNbIagRnYgmCD7sp6jsb7Y8V7vMu6GLrWsA==
X-Received: by 2002:a63:d34e:0:b0:477:650a:705c with SMTP id u14-20020a63d34e000000b00477650a705cmr45779060pgi.588.1670022335839;
        Fri, 02 Dec 2022 15:05:35 -0800 (PST)
Received: from [172.30.1.1] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id 3-20020a631543000000b0044ed37dbca8sm4590059pgv.2.2022.12.02.15.05.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 15:05:35 -0800 (PST)
Message-ID: <462db4cd-24d0-7541-1a7c-e4a87d69c217@gmail.com>
Date:   Sat, 3 Dec 2022 08:05:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] PM / devfreq: Use device_match_of_node()
Content-Language: en-US
To:     ye.xingchen@zte.com.cn, cw00.choi@samsung.com
Cc:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <202211251516222787845@zte.com.cn>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <202211251516222787845@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 11. 25. 16:16, ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Replace the open-code with device_match_of_node().
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/devfreq/devfreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 8c5f6f7fca11..817c71da391a 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -1057,7 +1057,7 @@ struct devfreq *devfreq_get_devfreq_by_node(struct device_node *node)
>  	mutex_lock(&devfreq_list_lock);
>  	list_for_each_entry(devfreq, &devfreq_list, node) {
>  		if (devfreq->dev.parent
> -			&& devfreq->dev.parent->of_node == node) {
> +			&& device_match_of_node(devfreq->dev.parent, node)) {
>  			mutex_unlock(&devfreq_list_lock);
>  			return devfreq;
>  		}

Applied it.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

