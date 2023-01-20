Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4812675CE7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 19:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjATSme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 13:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjATSmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 13:42:32 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FD56E0D6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 10:42:31 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-4a2f8ad29d5so84849947b3.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 10:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8yb9zlv0Fl/IYbvB0WWSWiKf6OADONZOE7K+mXp3Y6I=;
        b=OqxeLPVY+krRPbuAleh+D+kRq9eoi+WL0Zg5tLk44bbMXCJnLKnQkTPFE9zZ13gTLi
         mBKFHB2WR8VOw8TFwSbJU8qQHmF2D93Ce11KWQvbaS0HcMXyvbCe+on43LRjPMtc4xZ1
         vCkWPK81+Uta9ojjKc3K9f5xlmFs7LyMOLiDJD8riY/ChroO5zXDIpIZDTGX0iq+wXjX
         rAciU0bPyVQXYsQ9xMvFLi5tpJhrpjfcZ2LiYJ1fFw4Nya5+RPjUeeJ9GS4rPkenYIZk
         EcZmC4ATyI97rxHsPOnbYUvVNqazmV8mcNLa8DK6m69+95LCWL1M2XqUvs430E3UA3Mu
         MKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8yb9zlv0Fl/IYbvB0WWSWiKf6OADONZOE7K+mXp3Y6I=;
        b=UWtK7o/y/yWY7QSdbiDS7P0x/EK3apF1PDi+Xh0afZRPo5XZb5S1hwVkmZIqC/KNf/
         YQyY+/h+mevIMogCm5i0c4oEYrbUuXSH/NvBQa21VW9d1TyElxBS3l23uY8lFS+KdhPO
         GIzik6AiaHqmd0Dywkk3NsfrBfqGoy6ThRzcpM46JOA1nFLF4d76sf61ibte7VnWoEim
         15CmBy2NZ0GujVJ8n6SjimkmyKh2iF56LW5haH3PEgl35ZMEXQXzK/h58CHmpqTxfK1Q
         pzqCku3XTgf3uthgzigocczT+1DAppLGkWIseTrGMLTye/yoLkOX9FIJrQx2DmX4PEA+
         s7UA==
X-Gm-Message-State: AFqh2kq6mRGnjn5D+wUV8KXfSoOEGBUlGWgZN+C4m/d00a5sMx+UteKx
        3La0j+xE4SQk43SDGff6ojLekZIUsScGVgITYVsZzw==
X-Google-Smtp-Source: AMrXdXvtn4UGZgzxG45YYNgiCF8TyR8V/vYHcCDAw2jaiyhLgI91qbTnWOU4ys0ojd68P8jMZVqiv5UrhWKEYqhpeOs=
X-Received: by 2002:a0d:c0c7:0:b0:502:30d7:5fff with SMTP id
 b190-20020a0dc0c7000000b0050230d75fffmr159281ywd.347.1674240150044; Fri, 20
 Jan 2023 10:42:30 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-40-surenb@google.com>
 <Y8k+syJu7elWAjRj@dhcp22.suse.cz> <CAJuCfpEAL9y70KJ_a=Z_kJpJnNC-ge1aN2ofTupeQ5-FaKh84g@mail.gmail.com>
 <Y8pWW9Am3mDP53qJ@dhcp22.suse.cz> <CAJuCfpHeuckG8YuNTgdDcNHNzJ3sQExD_f1hwXG_xmS7Z-925g@mail.gmail.com>
 <CAJuCfpF20nuP6Meib9h7NVrJv+wybYS==vZFQXxUW6n-ir9bvQ@mail.gmail.com>
 <Y8rGJq8LvX2C+Cr7@casper.infradead.org> <20230120172140.GL2948950@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20230120172140.GL2948950@paulmck-ThinkPad-P17-Gen-1>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 20 Jan 2023 10:42:18 -0800
Message-ID: <CAJuCfpGjUSJ3ccJVfU=QAmLUKnDGs-sMHLg=EU_sa7pOZnzX4A@mail.gmail.com>
Subject: Re: [PATCH 39/41] kernel/fork: throttle call_rcu() calls in vm_area_free
To:     paulmck@kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org,
        michel@lespinasse.org, jglisse@google.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 9:21 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Fri, Jan 20, 2023 at 04:49:42PM +0000, Matthew Wilcox wrote:
> > On Fri, Jan 20, 2023 at 08:45:21AM -0800, Suren Baghdasaryan wrote:
> > > On Fri, Jan 20, 2023 at 8:20 AM Suren Baghdasaryan <surenb@google.com> wrote:
> > > >
> > > > On Fri, Jan 20, 2023 at 12:52 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > >
> > > > > On Thu 19-01-23 10:52:03, Suren Baghdasaryan wrote:
> > > > > > On Thu, Jan 19, 2023 at 4:59 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > > > >
> > > > > > > On Mon 09-01-23 12:53:34, Suren Baghdasaryan wrote:
> > > > > > > > call_rcu() can take a long time when callback offloading is enabled.
> > > > > > > > Its use in the vm_area_free can cause regressions in the exit path when
> > > > > > > > multiple VMAs are being freed. To minimize that impact, place VMAs into
> > > > > > > > a list and free them in groups using one call_rcu() call per group.
> > > > > > >
> > > > > > > After some more clarification I can understand how call_rcu might not be
> > > > > > > super happy about thousands of callbacks to be invoked and I do agree
> > > > > > > that this is not really optimal.
> > > > > > >
> > > > > > > On the other hand I do not like this solution much either.
> > > > > > > VM_AREA_FREE_LIST_MAX is arbitrary and it won't really help all that
> > > > > > > much with processes with a huge number of vmas either. It would still be
> > > > > > > in housands of callbacks to be scheduled without a good reason.
> > > > > > >
> > > > > > > Instead, are there any other cases than remove_vma that need this
> > > > > > > batching? We could easily just link all the vmas into linked list and
> > > > > > > use a single call_rcu instead, no? This would both simplify the
> > > > > > > implementation, remove the scaling issue as well and we do not have to
> > > > > > > argue whether VM_AREA_FREE_LIST_MAX should be epsilon or epsilon + 1.
> > > > > >
> > > > > > Yes, I agree the solution is not stellar. I wanted something simple
> > > > > > but this is probably too simple. OTOH keeping all dead vm_area_structs
> > > > > > on the list without hooking up a shrinker (additional complexity) does
> > > > > > not sound too appealing either.
> > > > >
> > > > > I suspect you have missed my idea. I do not really want to keep the list
> > > > > around or any shrinker. It is dead simple. Collect all vmas in
> > > > > remove_vma and then call_rcu the whole list at once after the whole list
> > > > > (be it from exit_mmap or remove_mt). See?
> > > >
> > > > Yes, I understood your idea but keeping dead objects until the process
> > > > exits even when the system is low on memory (no shrinkers attached)
> > > > seems too wasteful. If we do this I would advocate for attaching a
> > > > shrinker.
> > >
> > > Maybe even simpler, since we are hit with this VMA freeing flood
> > > during exit_mmap (when all VMAs are destroyed), we pass a hint to
> > > vm_area_free to batch the destruction and all other cases call
> > > call_rcu()? I don't think there will be other cases of VMA destruction
> > > floods.
> >
> > ... or have two different call_rcu functions; one for munmap() and
> > one for exit.  It'd be nice to use kmem_cache_free_bulk().
>
> Good point, kfree_rcu(p, r) where "r" is the name of the rcu_head
> structure's field, is much more cache-efficient.
>
> The penalty is that there is no callback function to do any cleanup.
> There is just a kfree()/kvfree (bulk version where applicable),
> nothing else.

If Liam's suggestion works then we won't need anything additional. We
will free the vm_area_structs directly on process exit and use
call_rcu() in all other cases. Let's see if Michal knows of any case
which still needs an RCU grace period during exit_mmap.

>
>                                                         Thanx, Paul
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
