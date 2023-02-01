Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD896865BF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 13:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjBAMNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 07:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjBAMNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 07:13:33 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBBC7D9F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 04:13:33 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id 5so18256927plo.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 04:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fZKtpTgkqaYU4jEZ3IrkFfLCfdP2+CMiYu/MZz8jd5Q=;
        b=jRNEy6L9ISEqRKtajxe7+ZTCDp0rQAwUvPfegZ0GutynyhtLd1nHin6cQMibCoCzqP
         jLvR7lVsJSLpxM2phE3Cv7qVNjKggmtrCBPI3e2oNpzPPOkuoqJuf/EycKq86614i4iN
         1nChwfHb72oH4OLlKqrybeYPXFrpJ5WVcRdeZO+UppIx9ytqn1bKdyYwzsRfOfXqXvV8
         iSx1xiUxnEj/dp9VSGEctcvxA7B5u8PKRMgF9eQa7u8UnWeeXlCj39yOO4DdOHllktT6
         LPjs0M3f6wGq+96fbNLlWeMgBRWjz+rBAed0EQJ/RlZ36LyjnwR+IKxeV5vlXzwhVHYO
         t5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZKtpTgkqaYU4jEZ3IrkFfLCfdP2+CMiYu/MZz8jd5Q=;
        b=nd8aj43YqDoNQxEjF/O/xpxtxwt8M2NWJ7DVQaet+f06ogRqMyQXxIHpyFHd/Q+0vh
         Vpg5cju2Oe0TLS2tjLus2zv8hvSU66ry5+F16iQ8K7nAXeqxiFMUgzNUyA/K6eFMgVn4
         nTunTrn5nHC2hmeSG97j163quBg2SPcVJtAOtvp5iHNCOgZEbLCTB0+mcWz5q0I4TapE
         JjWaOvr81kza3eGwLQjXTLGDtlrBFoF0D/H5NgfyGKsWtqPaiE17RDvn82r/zlc2L07G
         f6AjR8X8uy7X6kzrDWKYHxIOENUl9zrYiQWr42ih+HUUrQQ8SOSa209nDcnW+lyYjtIA
         ZwOA==
X-Gm-Message-State: AO0yUKV/obZebgfnUHOUXZuyWqh7jOf3plLpV5KO7hYnF5PjwNyHHuGG
        oBvUyx4UVwrPs1S6MixLbgw=
X-Google-Smtp-Source: AK7set/YWfFU4RInB3p0bI1nUQDVXzDUFc21yvyI0IF5VsiSAQSlmEd5DnS+4URi7lMxfkRjnK2eUQ==
X-Received: by 2002:a05:6a20:2d0f:b0:bf:58d1:ce9d with SMTP id g15-20020a056a202d0f00b000bf58d1ce9dmr373675pzl.28.1675253612416;
        Wed, 01 Feb 2023 04:13:32 -0800 (PST)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id o18-20020a639212000000b0047850cecbdesm10178996pgd.69.2023.02.01.04.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 04:13:31 -0800 (PST)
Date:   Wed, 1 Feb 2023 21:13:26 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Hyunmin Lee <hn.min.lee@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Jeungwoo Yoo <casionwoo@gmail.com>,
        Sangyun Kim <sangyun.kim@snu.ac.kr>,
        Mike Rapoport <rppt@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v4] mm/vmalloc: replace BUG_ON to a simple if statement
Message-ID: <Y9pXZrU9uZj7clry@hyeyoo>
References: <20230201115142.GA7772@min-iamroot>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201115142.GA7772@min-iamroot>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 08:51:42PM +0900, Hyunmin Lee wrote:
> As per the coding standards, in the event of an abnormal condition that
> should not occur under normal circumstances, the kernel should attempt
> recovery and proceed with execution, rather than halting the machine.
> 
> Specifically, in the alloc_vmap_area() function, use a simple if()
> instead of using BUG_ON() halting the machine.
> 
> Co-Developed-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> Co-Developed-by: Jeungwoo Yoo <casionwoo@gmail.com>
> Co-Developed-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
> Signed-off-by: Hyunmin Lee <hn.min.lee@gmail.com>
> Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> Signed-off-by: Jeungwoo Yoo <casionwoo@gmail.com>
> Signed-off-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> ---
> v1->v2 : Add commit description
> v2->v3 : Change WARN_ON() to if()
> v3->v4 : Use only one if() for three conditions
> ---
>  mm/vmalloc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 74afa2208558..3b7e8856be35 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1587,9 +1587,8 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  	int purged = 0;
>  	int ret;
>  
> -	BUG_ON(!size);
> -	BUG_ON(offset_in_page(size));
> -	BUG_ON(!is_power_of_2(align));
> +	if (unlikely(!size || offset_in_page(size) || !is_power_of_2(align)))
> +		return ERR_PTR(-EINVAL);
>  
>  	if (unlikely(!vmap_initialized))
>  		return ERR_PTR(-EBUSY);

Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Thanks!

> -- 
> 2.25.1

Regards,
Hyeonggon
