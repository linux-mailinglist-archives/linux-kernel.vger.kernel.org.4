Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECCA617DD3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbiKCNYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiKCNYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:24:03 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3C910B9
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 06:24:02 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id m6so1622367pfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 06:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XrHkiVdh+qB5p2Sw2z7czeCm3PU3sfVYaV65IQbO0PU=;
        b=GckebTsM5Af16DqURlc/Nk6EqDA1yWwlUEZUnmFCufGlYsJq7EN5hk8iaWXuyYu87L
         a4pY5j+sghuYrvVbi+AE5Cey+7OBhp3ltyN0dzzgXBAe5uCkMOiuJ6/XCaT3u2McLQN9
         zM49chGJm65xj1uyXFPxzKne2YcxbEb8qjpgmvthOf5EmFQwJU8HHKYUTrR8P20+wQUw
         FzbPw024UiRRdQd4R7yZEkRkCR3RTwI8NINJS2JgPYhoqObGl89eWapH0vKZPMX+fTNz
         v7qpnSZVc2L/Z1JZj7TrY8bPfNz82WQJgf+BJZgPrlwVhIcbEVC4mGWoUVxLaCOGMARK
         txFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XrHkiVdh+qB5p2Sw2z7czeCm3PU3sfVYaV65IQbO0PU=;
        b=BM8w6jQ7VCumG5wq7X5CCC3BCgjY/xyIht8qMbGy2bnvz8TH5dYl9NS1rf6q5KQT4N
         UgXVvG5XvUWSbWn1SOOWMNODAAUl52K1/XdZg01vsrUI6pzDnVrjvT0w7cgq7t3ZvLyB
         rfLLgvcMSGx9BTUSAlsY8DiAdDrZJxSmMkQ1JpAz8Hq2uEJnKFuDNq98KVhlkxuvuT1F
         FKKEwerVuzIKGQmw0YPC6P1vrNStj2h+a0aXz5tjUM9/zJpEOGcGSp5F2M9HWzhoWvxL
         kxTOdiOKaELFoEueW4bxI4I1ZHf/JHeVJfcz3FBqjuqETuwjvisSvBJ2I4dXBunmL+uc
         6Kjg==
X-Gm-Message-State: ACrzQf2xfK7iETnAHwC10MGpkk6rqPkF0Y5bMdcnYN3sJ4p3slBNxHjp
        sytGsbNpARkNMfHykm9r1RY=
X-Google-Smtp-Source: AMsMyM79JtxqP7QPxDsd1kRRmNFm8mQSnZb7l9ngiFkoEpvsK/cLZZXbTypytMz3gUgO5X6xJqdqNQ==
X-Received: by 2002:a62:a503:0:b0:56b:cb10:2d87 with SMTP id v3-20020a62a503000000b0056bcb102d87mr30453796pfm.79.1667481841750;
        Thu, 03 Nov 2022 06:24:01 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id nm1-20020a17090b19c100b00209a12b3879sm949113pjb.37.2022.11.03.06.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 06:24:00 -0700 (PDT)
Date:   Thu, 3 Nov 2022 22:23:52 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Refactor __kmem_cache_create() and fix memory leak
Message-ID: <Y2PA6JBklwwtLlST@hyeyoo>
References: <20221031134747.3049593-1-liushixin2@huawei.com>
 <Y2IgUwTH/dO06Tot@hyeyoo>
 <c03620e3-6159-1c46-c472-c15186f4ccae@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c03620e3-6159-1c46-c472-c15186f4ccae@huawei.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 04:53:08PM +0800, Liu Shixin wrote:
> On 2022/11/2 15:46, Hyeonggon Yoo wrote:
> > On Mon, Oct 31, 2022 at 09:47:44PM +0800, Liu Shixin wrote:
> >> I found a memory leak of kobj->name in sysfs_slab_add() which is introduced
> >> by 80da026a8e5d ("mm/slub: fix slab double-free in case of duplicate sysfs filename").
> >> Following the rules stated in the comment for kobject_init_and_add():
> > Thank you for reporting this! Indeed it seems tried to fix double free but
> > introduced a leak.
> >
> >>  If this function returns an error, kobject_put() must be called to
> >>  properly clean up the memory associated with the object.
> >>
> >> We should use kobject_put() to free kobject.
> > But what to do if a cache is created early and later sysfs_slab_add() failed?
> > (Which is unlikely on normal condition)
> >
> > With this series it introduces use-after-free if sysfs_slab_add() in
> > slab_sysfs_init() failed.  Should we just call BUG() or something like that?
>
> Thanks for your discovery, what I missed.

You're welcome.

> I prefer to panic directly, just as create_boot_cache() does.

IMHO that should be nothing serious. but let's hear maintainers' opinion.

> Of couse, if you want the system to continue booting, I think it's possible to distinguish them
> by slab_state.

I'm afraid to make it more complex :(

> Looking forward to your advice.
> Thanks,
> >
> >> But we can't simply add kobject_put() since it will free kmem_cache too.
> >> If we use kobject_put(), we need to skip other release functions.
> >>
> >> In this series, We refactor the code to separate sysfs_slab_add() and
> >> debugfs_slab_add() from __kmem_cache_create(), and then use kobject_put()
> >> to free kobject in sysfs_slab_add(). This can fix the memory leak of
> >> kobject->name.
> >>
> >> v1->v2: Fix build error reported by kernel test robot <lkp@intel.com>.
> >>
> >> Liu Shixin (3):
> >>   mm/slab_common: Move cache_name to create_cache()
> >>   mm/slub: Refactor __kmem_cache_create()
> >>   mm/slub: Fix memory leak of kobj->name in sysfs_slab_add()
> >>
> >>  include/linux/slub_def.h | 11 +++++++++
> >>  mm/slab_common.c         | 44 ++++++++++++++++++----------------
> >>  mm/slub.c                | 52 ++++++++++------------------------------
> >>  3 files changed, 48 insertions(+), 59 deletions(-)
> >>
> >> -- 
> >> 2.25.1
> >>
> 

-- 
Thanks,
Hyeonggon
