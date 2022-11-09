Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A50622F71
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 16:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiKIPz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 10:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiKIPz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 10:55:26 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07097DFFA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 07:55:26 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id y16so26345279wrt.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 07:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oC3qlLRJ47OYiKt2MuPBl+C96HUx+UlLAcCO9vjhcFM=;
        b=drktL9Af7wuGtb7h/lyoYfgHHNaTrNBRe2M50ZDhnQwFC6D/xYn2cpX2Xxh3us1yng
         ipB8ZIBrECZ/3m8dU6GRqK/2nqQA+8o64TCG6M6jkd9N97tw1U8b8XqbesE1KKN6jssj
         MDvflxMY9qTf7nQuIO75eMkzp0q/+wECFxc3MljQYBK6MDMt3rY0WEmC/hCkKBW9i+On
         4YakE9zJaC2rYKyr8+L4ydC7+Hxm9Q5ZUC6lYSEugkF6M1Kg3dfKuglm6hlC4mMs2lCE
         tIxt0pTzow/1BJZrYKqe1jaw0ZQ1Yh0/mnGabigAnHdQMnKovQDm+/0rIbVgCi3fuiiF
         0U1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oC3qlLRJ47OYiKt2MuPBl+C96HUx+UlLAcCO9vjhcFM=;
        b=Ub7wmWQrnd+SSFJdwbPNRdRAOF+wPHkslNc4wfwpwJA8inobOYR5uqv8H0IBD4sP0w
         7vdHTco7yUHho+zlbNYq/Y6vZ/CRXRfOrCjFTrD23LR7aCW1qS3rVXmBmG1z+zz14tZz
         NuJ0lPnS72mgqDjczirWqyfKpAI+F77F584Ic46FZeX96gSiZ73QOeM4cN3bIej0blLZ
         Nld3iQhu1o/eBTny7+3yAY0c1InG2MquO06nSU+3cBaF4NvaGjgVXjYlF0UaUSMVVsPq
         bJ14UQCxuyMse0LJkoin5tU32AVnfXcXAG5fV4dDaM7oRXW/W7y8uXqvbrqogb8mJ5gd
         TEGA==
X-Gm-Message-State: ACrzQf02p5tPFx3/LmEyWr/2eWSco5QaWSbN9XB9Bs1k5+c6QCeXAeam
        4nfL2t8iAMSWSrS1ZTwph5Y=
X-Google-Smtp-Source: AMsMyM46xqMd8erT6wqZKDKoVvZIYTWtuAsz5LmiSU1MLJUgA7XyzjmMlrvZiIPKb0qFQJpW2yz6ww==
X-Received: by 2002:a05:6000:1a46:b0:236:9cb4:f2a7 with SMTP id t6-20020a0560001a4600b002369cb4f2a7mr38547372wry.141.1668009324458;
        Wed, 09 Nov 2022 07:55:24 -0800 (PST)
Received: from [192.168.2.181] (84-238-195-21.ip.btc-net.bg. [84.238.195.21])
        by smtp.gmail.com with ESMTPSA id b9-20020a05600010c900b002368424f89esm13379538wrx.67.2022.11.09.07.55.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 07:55:24 -0800 (PST)
Message-ID: <42515e33-3f99-83d5-d14b-3b8e00d97b4a@gmail.com>
Date:   Wed, 9 Nov 2022 17:55:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3] drm/vmwgfx: Fix race issue calling pin_user_pages
To:     Dawei Li <set_pte_at@outlook.com>, zackr@vmware.com,
        airlied@gmail.com, daniel@ffwll.ch
Cc:     krastevm@vmware.com, linux-graphics-maintainer@vmware.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <TYWP286MB23193621CB443E1E1959A00BCA3E9@TYWP286MB2319.JPNP286.PROD.OUTLOOK.COM>
Content-Language: en-US
From:   "Martin Krastev (VMware)" <martinkrastev768@gmail.com>
In-Reply-To: <TYWP286MB23193621CB443E1E1959A00BCA3E9@TYWP286MB2319.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Krastev <krastevm@vmware.com>


Looks great!


Reviewed-by: Martin Krastev <krastevm@vmware.com>


Regards,
Martin


On 9.11.22 г. 17:37 ч., Dawei Li wrote:
> pin_user_pages() is unsafe without protection of mmap_lock,
> fix it by calling pin_user_pages_fast().
>
> Fixes: 7a7a933edd6c ("drm/vmwgfx: Introduce VMware mks-guest-stats")
> Signed-off-by: Dawei Li <set_pte_at@outlook.com>
> ---
> v1:
> https://lore.kernel.org/all/TYCP286MB23235C9A9FCF85C045F95EA7CA4F9@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM/
>
> v1->v2:
> Rebased to latest vmwgfx/drm-misc-fixes.
>
> v2->v3
> Replace pin_user_pages() with pin_user_pages_fast().
> ---
>   drivers/gpu/drm/vmwgfx/vmwgfx_msg.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
> index 089046fa21be..50fa3df0bc0c 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
> @@ -1085,21 +1085,21 @@ int vmw_mksstat_add_ioctl(struct drm_device *dev, void *data,
>   	reset_ppn_array(pdesc->strsPPNs, ARRAY_SIZE(pdesc->strsPPNs));
>   
>   	/* Pin mksGuestStat user pages and store those in the instance descriptor */
> -	nr_pinned_stat = pin_user_pages(arg->stat, num_pages_stat, FOLL_LONGTERM, pages_stat, NULL);
> +	nr_pinned_stat = pin_user_pages_fast(arg->stat, num_pages_stat, FOLL_LONGTERM, pages_stat);
>   	if (num_pages_stat != nr_pinned_stat)
>   		goto err_pin_stat;
>   
>   	for (i = 0; i < num_pages_stat; ++i)
>   		pdesc->statPPNs[i] = page_to_pfn(pages_stat[i]);
>   
> -	nr_pinned_info = pin_user_pages(arg->info, num_pages_info, FOLL_LONGTERM, pages_info, NULL);
> +	nr_pinned_info = pin_user_pages_fast(arg->info, num_pages_info, FOLL_LONGTERM, pages_info);
>   	if (num_pages_info != nr_pinned_info)
>   		goto err_pin_info;
>   
>   	for (i = 0; i < num_pages_info; ++i)
>   		pdesc->infoPPNs[i] = page_to_pfn(pages_info[i]);
>   
> -	nr_pinned_strs = pin_user_pages(arg->strs, num_pages_strs, FOLL_LONGTERM, pages_strs, NULL);
> +	nr_pinned_strs = pin_user_pages_fast(arg->strs, num_pages_strs, FOLL_LONGTERM, pages_strs);
>   	if (num_pages_strs != nr_pinned_strs)
>   		goto err_pin_strs;
>   
