Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A195BCB6C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 14:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiISMHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 08:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiISMHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 08:07:49 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6156027FE4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 05:07:48 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id q3so27597027pjg.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 05:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=EVK8PXwi2Ipbx2nYX9NE/Drl0fbix3hzVw5SYu8VoBw=;
        b=Uy179iTKkuUOCxCMlkQ12IjxEwdA3a0PzEjtU5lZ3VlpwlAvZ8F1Lg+9LKggmnub9Z
         yFy0n0FH7cBE0al3+n9yIWkQI07XZvBOld4wGOd/2ZYt3pNGEgw3aPK+hgY7IT9nozBf
         ffCrVDMIt7ZRdqBKAk7Dsw1qPNi5hp+s19DMpc/xhaJa+TKFrtyeMDcRvAIso55Kzi4H
         2G0I9UTK/poI3loTg3hZf9S7JyDD2/xZ1Exu9vKYsnu+7EKnL96s+zmhHuHKip3PXXiG
         AFTKYGwYFupRZHl2cDKDDzAaOLVT5ifiTOAMoQp/Y8vbc4GcXtFt1SkchvHIRW71Guur
         lDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=EVK8PXwi2Ipbx2nYX9NE/Drl0fbix3hzVw5SYu8VoBw=;
        b=Fhj0KayLKpcD6WlKdscJe2qlxr4InMx9HW7lBitD0631S2uzPqZpabDHtWR+O3/eMr
         fXOxt8zzod4fG6YDipQ7mUg6jDpyF/9a7tRE6OggW7V62sq6id7TsWbQpp27KDwjLB7R
         TJ7hqk13uDnPlVINf8zcV+WqHnDNU4GoymHloJcSiHOw4PZiYeYFZ75Higjebp7E6OCL
         zt5+BPN67H7DauA3l9dQQbvKWKZEE2p9veFTw4GpJjaz5CKa+wI73hBLTx+w0X95ZO+U
         fBJOAZX2H2THN6nv9lFCMq7HFyBchp012R+CFIuVEQ2T6soZ5Slbchsb0/tZ4qNTy3D4
         x7ug==
X-Gm-Message-State: ACrzQf3zgfoGlKbYRAfElBqd84Tg8CPb03igHCMVgeKQQ9cVspyxkdYq
        Dh5DxwCsA9+5t+PHUeBN+Gw=
X-Google-Smtp-Source: AMsMyM4yleRu5n8257cDzaYvwl74TjEFl3GdKBHK3mvMp8CeoOH/o4MVLXK+6s4AgNL25+UOe1XXKQ==
X-Received: by 2002:a17:902:f7ca:b0:178:9c90:b010 with SMTP id h10-20020a170902f7ca00b001789c90b010mr5985752plw.149.1663589267834;
        Mon, 19 Sep 2022 05:07:47 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id x5-20020a628605000000b00540d75197f2sm20956047pfd.143.2022.09.19.05.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 05:07:46 -0700 (PDT)
Date:   Mon, 19 Sep 2022 21:07:41 +0900
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
Message-ID: <YyhbjUG3SqU8A5Me@hyeyoo>
References: <20220919031241.1358001-1-feng.tang@intel.com>
 <e38cc728-f5e5-86d1-d6a1-c3e99cc02239@suse.cz>
 <YyhY7RBLxCEuSHp9@hyeyoo>
 <e736ad09-e29d-7a76-6823-55e14fec87c1@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e736ad09-e29d-7a76-6823-55e14fec87c1@suse.cz>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 02:03:15PM +0200, Vlastimil Babka wrote:
> On 9/19/22 13:56, Hyeonggon Yoo wrote:
> > On Mon, Sep 19, 2022 at 11:12:38AM +0200, Vlastimil Babka wrote:
> >> On 9/19/22 05:12, Feng Tang wrote:
> >> > When doing slub_debug test, kfence's 'test_memcache_typesafe_by_rcu'
> >> > kunit test case cause a use-after-free error:
> >> >
> > 
> > If I'm not mistaken, I think the subject should be:
> > s/double free/use after free/g
> 
> Well, it's both AFAICS. By the initial use-after-free we can read a wrong
> s->flags that was modified since we freed for the first time, and it can
> lead to another kmem_cache_release() which is basically a double free.
>

Yeah, I realized that just after sending the mail ;)
it is use-after-free bug that can potentially lead to double free.

Thank you for correction!

> >> >   BUG: KASAN: use-after-free in kobject_del+0x14/0x30
> >> >   Read of size 8 at addr ffff888007679090 by task kunit_try_catch/261
> >> > 
> >> >   CPU: 1 PID: 261 Comm: kunit_try_catch Tainted: G    B            N 6.0.0-rc5-next-20220916 #17
> >> >   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> >> >   Call Trace:
> >> >    <TASK>
> >> >    dump_stack_lvl+0x34/0x48
> >> >    print_address_description.constprop.0+0x87/0x2a5
> >> >    print_report+0x103/0x1ed
> >> >    kasan_report+0xb7/0x140
> >> >    kobject_del+0x14/0x30
> >> >    kmem_cache_destroy+0x130/0x170
> >> >    test_exit+0x1a/0x30
> >> >    kunit_try_run_case+0xad/0xc0
> >> >    kunit_generic_run_threadfn_adapter+0x26/0x50
> >> >    kthread+0x17b/0x1b0
> >> >    </TASK>
> >> > 
> >> > The cause is inside kmem_cache_destroy():
> >> > 
> >> > kmem_cache_destroy
> >> >     acquire lock/mutex
> >> >     shutdown_cache
> >> >         schedule_work(kmem_cache_release) (if RCU flag set)
> >> >     release lock/mutex
> >> >     kmem_cache_release (if RCU flag set)
> >> 
> >> 				      ^ not set
> >> 
> >> I've fixed that up.
> >> 
> >> > 
> >> > in some certain timing, the scheduled work could be run before
> >> > the next RCU flag checking which will get a wrong state.
> >> > 
> >> > Fix it by caching the RCU flag inside protected area, just like 'refcnt'
> > 
> > Very nice catch, thanks!
> > 
> > Otherwise (and with Vlastimil's fix):
> > 
> > Looks good to me.
> > Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > 
> >> > 
> >> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> >> 
> >> Thanks!
> >> 
> >> > ---
> >> > 
> >> > note:
> >> > 
> >> > The error only happens on linux-next tree, and not in Linus' tree,
> >> > which already has Waiman's commit:
> >> > 0495e337b703 ("mm/slab_common: Deleting kobject in kmem_cache_destroy()
> >> > without holding slab_mutex/cpu_hotplug_lock")
> >> 
> >> Actually that commit is already in Linus' rc5 too, so I will send your fix
> >> this week too. Added a Fixes: 0495e337b703 (...) too.
> >> 
> >> >  mm/slab_common.c | 5 ++++-
> >> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >> > 
> >> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> >> > index 07b948288f84..ccc02573588f 100644
> >> > --- a/mm/slab_common.c
> >> > +++ b/mm/slab_common.c
> >> > @@ -475,6 +475,7 @@ void slab_kmem_cache_release(struct kmem_cache *s)
> >> >  void kmem_cache_destroy(struct kmem_cache *s)
> >> >  {
> >> >  	int refcnt;
> >> > +	bool rcu_set;
> >> >  
> >> >  	if (unlikely(!s) || !kasan_check_byte(s))
> >> >  		return;
> >> > @@ -482,6 +483,8 @@ void kmem_cache_destroy(struct kmem_cache *s)
> >> >  	cpus_read_lock();
> >> >  	mutex_lock(&slab_mutex);
> >> >  
> >> > +	rcu_set = s->flags & SLAB_TYPESAFE_BY_RCU;
> >> > +
> >> >  	refcnt = --s->refcount;
> >> >  	if (refcnt)
> >> >  		goto out_unlock;
> >> > @@ -492,7 +495,7 @@ void kmem_cache_destroy(struct kmem_cache *s)
> >> >  out_unlock:
> >> >  	mutex_unlock(&slab_mutex);
> >> >  	cpus_read_unlock();
> >> > -	if (!refcnt && !(s->flags & SLAB_TYPESAFE_BY_RCU))
> >> > +	if (!refcnt && !rcu_set)
> >> >  		kmem_cache_release(s);
> >> >  }
> >> >  EXPORT_SYMBOL(kmem_cache_destroy);
> >> 
> > 
> 

-- 
Thanks,
Hyeonggon
