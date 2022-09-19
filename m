Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86CC05BCB4F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 13:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiISL5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 07:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiISL4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 07:56:48 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97ED56358
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 04:56:36 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id q9so17426751pgq.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 04:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=w+dFo8W95tIbaQBNJMj5wAl0o5DxVWuVKQ51rqkGwCY=;
        b=NaOuw8SSxxqJ9ysb6JwnBPNiZwqql65Y51YAqXNA2eexEHTNXi4fEAMz4bhoBrfg09
         pezwwG7aoNzvZskhzIpgjniFHseiAnBPrcY4nIx3DWATu3NZSYVlyXzdceJPS5kTNMeX
         /tUNskE3Ehru0FUNBFzFuRhUJt9+DiakniLZhriqx8vRgFxwdnESzY1ZnNmnev8qeT0c
         k6UgM5uMK0cZWpXhevfg/QGrb1YgvPwyiMcnQjn0jxI0HlqRaOTCT9fJ95v2u9njnSWX
         VFYkRf4TSWf2D9jqZOOSSrvOvyq5rYMorR0RdEkYW4VT32bHtFH/E1g58qeNFNmszpyk
         ywXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=w+dFo8W95tIbaQBNJMj5wAl0o5DxVWuVKQ51rqkGwCY=;
        b=CZhXbgx2Q5SVXExu9HCwAuiyqj0O30Nc9cAc0SKG0KiIaQ+yJ57BRM4Dol6kqs28Rp
         QEjMzKTuvhVUbl8qgzeOKPigUEHk77DWSHANL/xz7fQbaJB4KxlPV36TOtfKI408KXdC
         D7B/u5UJUf1ZH2Fg69Wq1FYyIdKEc0lBguvMqNoKUHAWFTItI+jk5sauzPSAASC/SmxH
         nBj3ynP1Ba9l70cGzvnLX5BGeMsI/hxedcLH2BVAQ1hHU0IcIY0jOU2xYon1rUFLF0zc
         XUml2etA7NPAJ6t6F0hx7j1KGgU7XxcjUtheZoyAdmdetdbFmtevKhu7B9/gOUMAzhTa
         r8fA==
X-Gm-Message-State: ACrzQf3SEug0w/xpl5qz4IzNdkPTDrc8lMYgKUiwL3vWMnORUmF6ZsYH
        8z7B4qP34MiKRDmpfTFn2xg=
X-Google-Smtp-Source: AMsMyM53FmotOXSPejjaUMCTU5EKC+ZmNDr7kavVp1n986Cq0i7Ol/6XOC4YADW2KQljkolCgUtFBQ==
X-Received: by 2002:a63:ed4d:0:b0:438:8ba7:e598 with SMTP id m13-20020a63ed4d000000b004388ba7e598mr15031564pgk.226.1663588596054;
        Mon, 19 Sep 2022 04:56:36 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id e2-20020a17090301c200b001754e086eb3sm20543948plh.302.2022.09.19.04.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 04:56:35 -0700 (PDT)
Date:   Mon, 19 Sep 2022 20:56:29 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Feng Tang <feng.tang@intel.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH] mm/slab_common: fix possiable double free of kmem_cache
Message-ID: <YyhY7RBLxCEuSHp9@hyeyoo>
References: <20220919031241.1358001-1-feng.tang@intel.com>
 <e38cc728-f5e5-86d1-d6a1-c3e99cc02239@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e38cc728-f5e5-86d1-d6a1-c3e99cc02239@suse.cz>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 11:12:38AM +0200, Vlastimil Babka wrote:
> On 9/19/22 05:12, Feng Tang wrote:
> > When doing slub_debug test, kfence's 'test_memcache_typesafe_by_rcu'
> > kunit test case cause a use-after-free error:
> >

If I'm not mistaken, I think the subject should be:
s/double free/use after free/g

> >   BUG: KASAN: use-after-free in kobject_del+0x14/0x30
> >   Read of size 8 at addr ffff888007679090 by task kunit_try_catch/261
> > 
> >   CPU: 1 PID: 261 Comm: kunit_try_catch Tainted: G    B            N 6.0.0-rc5-next-20220916 #17
> >   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> >   Call Trace:
> >    <TASK>
> >    dump_stack_lvl+0x34/0x48
> >    print_address_description.constprop.0+0x87/0x2a5
> >    print_report+0x103/0x1ed
> >    kasan_report+0xb7/0x140
> >    kobject_del+0x14/0x30
> >    kmem_cache_destroy+0x130/0x170
> >    test_exit+0x1a/0x30
> >    kunit_try_run_case+0xad/0xc0
> >    kunit_generic_run_threadfn_adapter+0x26/0x50
> >    kthread+0x17b/0x1b0
> >    </TASK>
> > 
> > The cause is inside kmem_cache_destroy():
> > 
> > kmem_cache_destroy
> >     acquire lock/mutex
> >     shutdown_cache
> >         schedule_work(kmem_cache_release) (if RCU flag set)
> >     release lock/mutex
> >     kmem_cache_release (if RCU flag set)
> 
> 				      ^ not set
> 
> I've fixed that up.
> 
> > 
> > in some certain timing, the scheduled work could be run before
> > the next RCU flag checking which will get a wrong state.
> > 
> > Fix it by caching the RCU flag inside protected area, just like 'refcnt'

Very nice catch, thanks!

Otherwise (and with Vlastimil's fix):

Looks good to me.
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

> > 
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> 
> Thanks!
> 
> > ---
> > 
> > note:
> > 
> > The error only happens on linux-next tree, and not in Linus' tree,
> > which already has Waiman's commit:
> > 0495e337b703 ("mm/slab_common: Deleting kobject in kmem_cache_destroy()
> > without holding slab_mutex/cpu_hotplug_lock")
> 
> Actually that commit is already in Linus' rc5 too, so I will send your fix
> this week too. Added a Fixes: 0495e337b703 (...) too.
> 
> >  mm/slab_common.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > index 07b948288f84..ccc02573588f 100644
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -475,6 +475,7 @@ void slab_kmem_cache_release(struct kmem_cache *s)
> >  void kmem_cache_destroy(struct kmem_cache *s)
> >  {
> >  	int refcnt;
> > +	bool rcu_set;
> >  
> >  	if (unlikely(!s) || !kasan_check_byte(s))
> >  		return;
> > @@ -482,6 +483,8 @@ void kmem_cache_destroy(struct kmem_cache *s)
> >  	cpus_read_lock();
> >  	mutex_lock(&slab_mutex);
> >  
> > +	rcu_set = s->flags & SLAB_TYPESAFE_BY_RCU;
> > +
> >  	refcnt = --s->refcount;
> >  	if (refcnt)
> >  		goto out_unlock;
> > @@ -492,7 +495,7 @@ void kmem_cache_destroy(struct kmem_cache *s)
> >  out_unlock:
> >  	mutex_unlock(&slab_mutex);
> >  	cpus_read_unlock();
> > -	if (!refcnt && !(s->flags & SLAB_TYPESAFE_BY_RCU))
> > +	if (!refcnt && !rcu_set)
> >  		kmem_cache_release(s);
> >  }
> >  EXPORT_SYMBOL(kmem_cache_destroy);
> 

-- 
Thanks,
Hyeonggon
