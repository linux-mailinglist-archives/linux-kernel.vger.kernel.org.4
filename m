Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDE15F2C2D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 10:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiJCIm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 04:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiJCImF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 04:42:05 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0FB20C
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 01:17:58 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id l1-20020a17090a72c100b0020a6949a66aso4777254pjk.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 01:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=8j6ZKu0VKQ7UFJHYONa1qnlLnHrkBbn87LJDOHuo5pQ=;
        b=gbBjONrirBqX/bI3ZAv2UuJ7gVnMy8FTTYPnc879Vb9MF47QxSX3gUYMSth08JQAw2
         mkCwuMehND9/qeXTnM42n4MXglWyoW5TK7wnLDN55DiMKRDjSnlIx2tVtD2ihWY6cLaY
         TZOr11+sg0vEz32n9aT6u42SIB4b2YPjp5lqZSIQnV8hP1K6rz9fXAgQ9A6YqrtwDwe6
         odrzKDr4OuKH4Q9Q5PiU3GOtrC8AtzdaEMNjKJUHBmgkFa+m5ndIQ9rcgs//OGZd4GHG
         Rl2lwiQojp+8lGexyJDhSOoqOpALeDtHPmcSCRerLZICpyEdlu/3Oo3z3tsHDyw8+0+s
         t6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=8j6ZKu0VKQ7UFJHYONa1qnlLnHrkBbn87LJDOHuo5pQ=;
        b=3NLC8M4OcG2FxG4zHbimn5ERcQ0JxmNzEEshN+7/VuCrTyQ6uHxVYwYE+ZjzWz+rNi
         A5gU2wQGgmAlTqfhSlZmmYcCrdmr39pCfwMSuP1zZL1iTlRGtRWX1LE8yf5PQ9Hah7uH
         aJ7SO93doxwqZBwRWrio0iZ7bRFphUnGlQyhjfnE78N1GykzX9Z5vXLCbQXfkzmtGn5d
         g1GHuJRb5pR+d+QR3CFQS0lDLDzD45w3dixdgtNBsJJeZ/9XIQADOPMPg4i4N3/E31jH
         zcn1yHsoq+wKQLJ+NbLLnHnWfzJ4a9CYpT4Rjp60cyMrvZi42F1VByPrPZ1yMSaqSy+H
         YOtw==
X-Gm-Message-State: ACrzQf3CgHYaiWutafylJNxGvm73y5Dq2REaM3B3p5+ja5/Vzml5GqXB
        5tiCIdCKUfnjL13V7dz2wlQ=
X-Google-Smtp-Source: AMsMyM55PTHgWjtRPxqW1UZf2+dEwuUCiTSZcSixQtt+bFmZS43MzpXtzrwQsB8UqvEzsk03XieqRA==
X-Received: by 2002:a17:90a:fe13:b0:20a:8fc8:60ec with SMTP id ck19-20020a17090afe1300b0020a8fc860ecmr6081911pjb.69.1664785078153;
        Mon, 03 Oct 2022 01:17:58 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id s17-20020a170903215100b00173411a4385sm6594953ple.43.2022.10.03.01.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 01:17:57 -0700 (PDT)
Date:   Mon, 3 Oct 2022 17:17:51 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: slub: make slab_sysfs_init() a late_initcall
Message-ID: <Yzqary4Fi1sTHVSQ@hyeyoo>
References: <20220930102712.789755-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930102712.789755-1-linux@rasmusvillemoes.dk>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 12:27:12PM +0200, Rasmus Villemoes wrote:
> Currently, slab_sysfs_init() is an __initcall aka device_initcall. It
> is rather time-consuming; on my board it takes around 11ms. That's
> about 1% of the time budget I have from U-Boot letting go and until
> linux must assume responsibility of keeping the external watchdog
> happy.
> 
> There's no particular reason this would need to run at device_initcall
> time, so instead make it a late_initcall to allow vital functionality
> to get started a bit sooner.
> 
> This actually ends up winning more than just those 11ms, because the
> slab caches that get created during other device_initcalls (and before
> my watchdog device gets probed) now don't end up doing the somewhat
> expensive sysfs_slab_add() themselves. Some example lines (with
> initcall_debug set) before/after:
> 
> initcall ext4_init_fs+0x0/0x1ac returned 0 after 1386 usecs
> initcall journal_init+0x0/0x138 returned 0 after 517 usecs
> initcall init_fat_fs+0x0/0x68 returned 0 after 294 usecs
> 
> initcall ext4_init_fs+0x0/0x1ac returned 0 after 240 usecs
> initcall journal_init+0x0/0x138 returned 0 after 32 usecs
> initcall init_fat_fs+0x0/0x68 returned 0 after 18 usecs
> 
> Altogether, this means I now get to petting the watchdog around 17ms
> sooner. [Of course, the time the other initcalls save is instead spent
> in slab_sysfs_init(), which goes from 11ms to 16ms, so there's no
> overall change in boot time.]

This looks okay and just curious,
can you explain what kind of benefit does enabling watchdog early provides?

> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
> 
> The numbers certainly suggest that someone might want to look into
> making sysfs/kobject/kset perform better. But that would be way more
> complicated than this patch, and could not possibly achieve the same
> win as getting the sysfs_slab_add() overhead completely out of the
> way.
> 
> 
>  mm/slub.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 4b98dff9be8e..dade5c84a7bb 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -6070,8 +6070,7 @@ static int __init slab_sysfs_init(void)
>  	mutex_unlock(&slab_mutex);
>  	return 0;
>  }
> -
> -__initcall(slab_sysfs_init);
> +late_initcall(slab_sysfs_init);
>  #endif /* CONFIG_SYSFS */
>  
>  #if defined(CONFIG_SLUB_DEBUG) && defined(CONFIG_DEBUG_FS)
> -- 
> 2.37.2

This is only deferring slub's sysfs initialization step (still before init process) 
So IIUC it shouldn't be serious.

-- 
Thanks,
Hyeonggon
