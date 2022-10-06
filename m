Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52CE45F6100
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 08:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiJFGVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 02:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiJFGVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 02:21:07 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1098A1E7
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 23:21:04 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id e11-20020a17090a77cb00b00205edbfd646so3466332pjs.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 23:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=DNCHcypAqACyuqWx+p7IPwXAi8YgHbhoRcWSFbyaQks=;
        b=ZEpegq5D07sSgQNEZyxGsXiMR57KikRoeFDL1sOXN3CbkKPCi6sI4u9gbG4bL/Hl2F
         UTgcpmqU7XbCrAyR2WfDDdtcgsqIeLaSac7XV272DQXP4hLDjCizRoTsZH600bu4pCQk
         rKd4DNrlMueGNq9OwAXpLiYWENn00op+fsKtk9L9wQof+mRmo/InZ5kDNxGdbHAkQHhs
         Jhb5c1QH8CVE0lYM3wbSuxyI7uMFhh+lRRJdM+hhTJXGfGnArGi7WcssLfrczZfD3HE2
         vjJ8ix/gt/7oZcQwkP2qSOKN/MpoUp1T9Ws7AoVBB0v9K+FTKqnDqCyUr2aEP06a9rva
         hvzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=DNCHcypAqACyuqWx+p7IPwXAi8YgHbhoRcWSFbyaQks=;
        b=cT8Dd7EMX7/Lr8nYEsOhbZZdCtrTsAtgvUzF+gU47qivROOdRo38pUmHgqgfqcsCfP
         6pYl+emNsRfxSVPmUoXW+FiP5BV6WuNQo7wZKSVV1WbehkRxLrqgyc6C2ryny4ja64ju
         Z4tXFEGhcuMQUjBme9MraoimGvGnuvwUdYme7MQdrdCJoLIRdvf/7gDtACDyUvsZ4j3U
         kn718f7yAQL7oYCRA4WzPvkZ7izL/6kYXz0e10N3QNcciQ/Kckex8VnZNL3ZrfI4jaHb
         MtrCW8bwv/LZyYclaZMb8qgi8AvNA2sAF3XruTfH7/4wPbHNM1K18CdjiB0hNGzsnaIe
         g4nw==
X-Gm-Message-State: ACrzQf0oHDxhOP5wAXSTozA21dtqMMI5mjMFkLdmmwMLDGzbRVy+KAbv
        U+0VKf/QWQveI0vBfJU4/H0=
X-Google-Smtp-Source: AMsMyM7of5BeQtui09w593FobXfInNH4J8ZMlYDsuKxXQ1hfC9UspE+10JpDFYTxfiMVag84FGI8rg==
X-Received: by 2002:a17:90a:ce82:b0:20a:b20f:6d0e with SMTP id g2-20020a17090ace8200b0020ab20f6d0emr8866340pju.125.1665037264223;
        Wed, 05 Oct 2022 23:21:04 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id s13-20020a17090302cd00b00172dc6e1916sm11436708plk.220.2022.10.05.23.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 23:21:03 -0700 (PDT)
Date:   Thu, 6 Oct 2022 15:20:57 +0900
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
Subject: Re: [PATCH] mm: slub: remove dead and buggy code from
 sysfs_slab_add()
Message-ID: <Yz5zyRK1XfKfFITD@hyeyoo>
References: <20220930084742.771804-1-linux@rasmusvillemoes.dk>
 <YzqJFnCA1bfYqJ5x@hyeyoo>
 <dfa55d7d-4063-c249-f6b8-e7b7d2efc8cc@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfa55d7d-4063-c249-f6b8-e7b7d2efc8cc@rasmusvillemoes.dk>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2022 at 11:38:30AM +0200, Rasmus Villemoes wrote:
> On 03/10/2022 09.02, Hyeonggon Yoo wrote:
> > On Fri, Sep 30, 2022 at 10:47:42AM +0200, Rasmus Villemoes wrote:
> >> The function sysfs_slab_add() has two callers:
> >>
> >> One is slab_sysfs_init(), which first initializes slab_kset, and only
> >> when that succeeds sets slab_state to FULL, and then proceeds to call
> >> sysfs_slab_add() for all previously created slabs.
> >>
> >> The other is __kmem_cache_create(), but only after a
> >>
> >> 	if (slab_state <= UP)
> >> 		return 0;
> >>
> >> check.
> >>
> >> So in other words, sysfs_slab_add() is never called without
> >> slab_kset (aka the return value of cache_kset()) being non-NULL.
> >>
> >> And this is just as well, because if we ever did take this path and
> >> called kobject_init(&s->kobj), and then later when called again from
> >> slab_sysfs_init() would end up calling kobject_init_and_add(), we
> >> would hit
> >>
> >> 	if (kobj->state_initialized) {
> >> 		/* do not error out as sometimes we can recover */
> >> 		pr_err("kobject (%p): tried to init an initialized object, something is seriously wrong.\n",
> >> 		dump_stack();
> >> 	}
> >>
> >> in kobject.c.
> >>
> >> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> >> ---
> >>  mm/slub.c | 5 -----
> >>  1 file changed, 5 deletions(-)
> >>
> >> diff --git a/mm/slub.c b/mm/slub.c
> >> index 4b98dff9be8e..04a7f75a7b1f 100644
> >> --- a/mm/slub.c
> >> +++ b/mm/slub.c
> >> @@ -5937,11 +5937,6 @@ static int sysfs_slab_add(struct kmem_cache *s)
> >>  	struct kset *kset = cache_kset(s);
> >>  	int unmergeable = slab_unmergeable(s);
> >>  
> >> -	if (!kset) {
> >> -		kobject_init(&s->kobj, &slab_ktype);
> >> -		return 0;
> >> -	}
> >> -
> >>  	if (!unmergeable && disable_higher_order_debug &&
> >>  			(slub_debug & DEBUG_METADATA_FLAGS))
> >>  		unmergeable = 1;
> >> -- 
> >> 2.37.2
> > 
> > I assumed that it's hit when SLUB failed to initialize slab_kset in
> > slab_sysfs_init(). (Yeah, it is too unlikely, though....)
> 
> No, it is not, because if the creation of slab_kset fails,
> slab_sysfs_init() returns early, and hence slab_state never transitions
> to FULL.

Yeah, you are right ;-) I misread that.

> I don't see anywhere else where slab_state could become FULL
> (of course in slab.c and slob.c, but those are not built when slub.c
> is), so I do believe my analysis in the commit log is correct.

Right.

> > And obviously it's a bug if sysfs_slab_add() is called early than
> > slab_sysfs_init().
> 
> Yes, and that's already what the existing slab_state check guards.
> 
> Rasmus

Looks good to me,
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Thanks!

-- 
Thanks,
Hyeonggon
