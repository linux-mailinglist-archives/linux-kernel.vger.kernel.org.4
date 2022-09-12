Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1E65B5547
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 09:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiILHVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 03:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiILHVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 03:21:05 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6239E32053
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 00:18:10 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso11497407pjk.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 00:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=FWAgKNPfCinc6qD4niSWvgkzCEX7z6+nrY4Z/gZWqPw=;
        b=aB+Q8RfAzCbG3/IzAcmRHBx8p8ATtIqcqqtuUO1/4QC8QLbfCQH9UG8xfOaoy4IEET
         q8z1MNtlvgloGUZpLuXSf6x9qlWLDmrKoPGXIQzWXMZq2oipE+mhtNZBK/JDtppyl8J2
         44mE605hN0IuF/AuI8Dip+5YDQodVDbeFL8OTT9xx5Qxrgk5adikVCR7RIfKGawSfrKB
         mkdHrcIlBM+qrLaVaBbDTGnoWHr9Zxlmazt1SKf3qjwOXLXxfmdmz3uNPIoZsFNzrlnc
         J/kD8sdpfsbcSACsDDCJ9Z9D9zrmtYUJcV5cxH5w6NNgbd/2rs4F4CLCDHMPubub+v5S
         mkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=FWAgKNPfCinc6qD4niSWvgkzCEX7z6+nrY4Z/gZWqPw=;
        b=FbSNk+c1sUNXr8uBVCMd/1Pdstk5EillJ3V3XR6dKucyOljZ2Ws45vIomTBosiHtvi
         WoVmnjstzmKMa4bcSUQrPOGGk74WtQo3soTdzeNxbdKRDJhUmhU/HO+win2hIZv74/OL
         Vao0J48HHqx2UJTMkcY1FsSOcu1sxF9/h8M5p7QZKkvMNCwo0zTUBAZD/cmI0fZqetHo
         LfadlYW1UQD3TZmePnPGbyz/p90AzTHwC9j7AYRCxstjHJFzDQcPcrDpwMy62vlJjo1X
         6jmmIpDdH6K5KCoVt8CHvGF6X/w0uycwYB57gA3yurbUERfC6Pgiqj8VhlP5eApFYk6O
         LZfw==
X-Gm-Message-State: ACgBeo1+NdptOVBIjJaF4adCOcOb0O26V8+tFjVWp7z0CwYnADRZmWzU
        e2Cm70STPU/rk//1NeZ9xmk=
X-Google-Smtp-Source: AA6agR59s2thu9I42pAf4k79SXby4Cz8U1Ux40VIz0G/+JyFbLW4Mdp70WV6fkBD6X/sVpO8GdVdJw==
X-Received: by 2002:a17:902:8f81:b0:178:1276:59e6 with SMTP id z1-20020a1709028f8100b00178127659e6mr12790503plo.94.1662967089533;
        Mon, 12 Sep 2022 00:18:09 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id m17-20020a637d51000000b0042ff6b0cf4dsm4790142pgn.58.2022.09.12.00.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 00:18:08 -0700 (PDT)
Date:   Mon, 12 Sep 2022 16:18:03 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Ben Luo <luoben@linux.alibaba.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: return 0 when object pointer is NULL
Message-ID: <Yx7dKxwxlNmCr9Ai@hyeyoo>
References: <1662962379-16174-1-git-send-email-luoben@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1662962379-16174-1-git-send-email-luoben@linux.alibaba.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 01:59:39PM +0800, Ben Luo wrote:
> NULL is definitly not a valid address
> 
> Signed-off-by: Ben Luo <luoben@linux.alibaba.com>
> ---
>  mm/slub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 862dbd9..50fad18 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -674,7 +674,7 @@ static inline int check_valid_pointer(struct kmem_cache *s,
>  	void *base;
>  
>  	if (!object)
> -		return 1;
> +		return 0;
>  
>  	base = slab_address(slab);
>  	object = kasan_reset_tag(object);
> -- 
> 1.8.3.1
> 

Hello Ben.

The return value is used to check if the @object has valid pointer
in @slab. (used for debugging) the return value is 0 if valid, 1 if invalid.

It does not return a pointer. So changing it to 0 because 1 is invalid
address does not make sense.

-- 
Thanks,
Hyeonggon
