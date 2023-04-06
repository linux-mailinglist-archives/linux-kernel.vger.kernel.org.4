Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7B26D8EC5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 07:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234979AbjDFFUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 01:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234076AbjDFFUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 01:20:34 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2011B5
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 22:20:29 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-17e140619fdso41110696fac.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 22:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680758429;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=lTQen24Ps++j6vXq82pkSJOfvZNDwo+mL4QS7eMljms=;
        b=HzBo9BuiVK+ieq4hAereyA6CLygTsynpDqwzI7aS46PfM0znN+VFQbdkLMhaGOapi7
         V9Ix9g9UKKzS0+eJnQc2MWb55fRRuN9AjB/rWvza20Xpwq+y924YbjvIGx6QzG5uGiEW
         JMZXwW0EZVSdlN1170YYJmB3OD7jnSnmA8F8avP8eaB7GI6Eh/L3Xh4ySzrOA18zt6Uj
         fElxFu4eEghxFn2lSbpgjMy1KXuEgdPQ17HmJkiKqGeOhJrTfYT+Gf/wjvkygerHH5Iy
         TUBvxPDx4RG7B8ApWr/Mbo5nDa9jUopcXIY4ffiChfJgYHBWgVh8MM+ofRE2T6QV//dN
         mEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680758429;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lTQen24Ps++j6vXq82pkSJOfvZNDwo+mL4QS7eMljms=;
        b=L1FU493DnukKFaDxztPnIViS9nalWV11DFOOxVDkk+B/Sncf/lba7BkmArJNU51eJp
         b94FRs8VafWJm/kSd6AudvInnS/NOwsD4Tr97VrfMjfXahmo68jZmZXa7hX8EVEkJtFL
         xnFsrBJlM2c7EnEqS6gLmJrgpDsC4sgRSN+I9A39v6bRt4pmZf0ck50r290KaolD9l97
         WkHvK/qGNXlI1eRvQKcaad2CurZYYXzbBrHtCyaxYOWLoEhrc/+mMjKwdZxTmMduJDp4
         psIjBBe0ujugFqpXRGJbkF+X/IGPjFa+xhCLStDgomiQeosJAydIoR4Z1UCPsCLk4K2s
         RnUw==
X-Gm-Message-State: AAQBX9eXXXAO6RWLQMzJlwEDLBmNRbaPOt1kMUSdwvOSJMVswVnKI+bX
        JkYOxOZNpm4+Cu8CbblWGAEaVPTI4Yg=
X-Google-Smtp-Source: AKy350ZMcSUgfjJW4sJA7K3zD8hRQ75jOEF9SU+ptU0yJ3k5GPg3yHCF5YmeEC24kg9GBBqzkEFO0A==
X-Received: by 2002:a05:6870:d356:b0:177:a92e:ee6 with SMTP id h22-20020a056870d35600b00177a92e0ee6mr4525131oag.54.1680758429001;
        Wed, 05 Apr 2023 22:20:29 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y1-20020a056870458100b001777244e3f9sm341041oao.8.2023.04.05.22.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 22:20:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 5 Apr 2023 22:20:26 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm-treewide-redefine-max_order-sanely-fix.txt
Message-ID: <9460377a-38aa-4f39-ad57-fb73725f92db@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=0.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 15, 2023 at 06:38:00PM +0300, Kirill A. Shutemov wrote:
> fix min() warning
> 
> Link: https://lkml.kernel.org/r/20230315153800.32wib3n5rickolvh@box
> Reported-by: kernel test robot <lkp@intel.com>
>   Link: https://lore.kernel.org/oe-kbuild-all/202303152343.D93IbJmn-lkp@intel.com/
> Signed-off-by: "Kirill A. Shutemov" <kirill@shutemov.name>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

This patch results in various boot failures (hang) on arm targets
in linux-next. Debug messages reveal the reason.

########### MAX_ORDER=10 start=0 __ffs(start)=-1 min()=10 min_t=-1
                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If start==0, __ffs(start) returns 0xfffffff or (as int) -1, which min_t()
interprets as such, while min() apparently uses the returned unsigned long
value. Obviously a negative order isn't received well by the rest of the
code.

Guenter

> ---
>  mm/memblock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 338b8cb0793e..7911224b1ed3 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -2043,7 +2043,7 @@ static void __init __free_pages_memory(unsigned long start, unsigned long end)
>  	int order;
>  
>  	while (start < end) {
> -		order = min(MAX_ORDER, __ffs(start));
> +		order = min_t(int, MAX_ORDER, __ffs(start));
>  
>  		while (start + (1UL << order) > end)
>  			order--;
> -- 
> 2.39.2
