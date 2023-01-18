Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C6D6727C0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 20:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjARTCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 14:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjARTCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 14:02:15 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055775D7EB
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 11:01:22 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-4c24993965eso475246727b3.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 11:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8DSKYHJgJYKJvmPul/jqy2wXXzLUlUgLi7Tkf9YlXU=;
        b=ejwY3+LKtxm5x3E+GJzfTUchB7m+L1YRon9Aa8Q50Ti4tQZzVZ6M7ddAXR8QuYX2/+
         QbFt7G90bRjsGKuh+F1lDNIo0H7p5+Ztjzb+JsV1kzQB8MPN72CITN8khcfMdZzVCClr
         0rfR86j8uR9XfP3lcG3CmwEZq8gGCNYy4GMw9BXNuo+B0XfUKFLgpaKByDGEKF5m5ob0
         nAirCQpTYQiGnADXyL4rHN55X+6T7+KDx4Lknv/dk8Nf1obhK0VCQYfoZive5NaouN9J
         rWZ8CpiuCsm5NmaCNzdlzyweXpQ+VQ7Pr9lxoMOtqkqySGFLw02OuYspEMabUBJR88+S
         njvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z8DSKYHJgJYKJvmPul/jqy2wXXzLUlUgLi7Tkf9YlXU=;
        b=5n05tczG4QyegsmSEKaiHwiB4AoXff0uXMMAjrBYm0Cm+cGTy76cICfDP+cadom17F
         msta4lIXOvBk7EAgyLJ11hvqSz7r0Ve5Gzyl1Ybw9B/q8nuv06U7s/tONhTFxUxTDxua
         OO5J+ccJ6a0RALc65qitRg8PWKQYUXgPryTX3UxQxKq9AmhXv9ONlt3HVbi1hD+lOibR
         D/QGOJBXJG41Hhw24KitIQBhbP8MaEE3T+zwWNkes8nW3wAGbK5v2QOhxpGV5gnlkxAG
         7KFhUEmqx+Ur13SmjxTanMmpsf7JxV5RUSOejf6B6l+O3MZ5rv0nlh2gTiTU2CZWrQGJ
         GA/A==
X-Gm-Message-State: AFqh2kp6EknkB1Hq4Gxc/MgkVx8UbriKgXNXHLatexlLHq8sVxMpV574
        s/z9zh0FdufjFk1n5xFa6o4/iFs//wV3I9imKwC1uA==
X-Google-Smtp-Source: AMrXdXubzcxtFjj0yWcsl/wowi8G0fcdGwos3LuYoWDDm/OjCNfgTh+Wjt7geFYZ2EGxVPVcRjYpoDeL03CkmRv1g5o=
X-Received: by 2002:a81:6d8d:0:b0:490:89c3:21b0 with SMTP id
 i135-20020a816d8d000000b0049089c321b0mr1053073ywc.132.1674068480621; Wed, 18
 Jan 2023 11:01:20 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-40-surenb@google.com>
 <Y8bFdB47JT/luMld@dhcp22.suse.cz> <CAJuCfpHVYW5aBVmT0vwn+j=m=Jo2KhSTzgVtxSEusUZJdzetUA@mail.gmail.com>
 <Y8fApgKJaTs9nrPO@dhcp22.suse.cz> <CAJuCfpERMyQc96Z5Qn9RFK0UD7fNugZE4DujFs4xqFWM8T6EqA@mail.gmail.com>
 <20230118183447.GG2948950@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20230118183447.GG2948950@paulmck-ThinkPad-P17-Gen-1>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 18 Jan 2023 11:01:08 -0800
Message-ID: <CAJuCfpHZuKq45FL1gs+=rx5s2AOaZ9TPC1bdAWjYzfkrOABTOw@mail.gmail.com>
Subject: Re: [PATCH 39/41] kernel/fork: throttle call_rcu() calls in vm_area_free
To:     paulmck@kernel.org
Cc:     Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org,
        michel@lespinasse.org, jglisse@google.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
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

On Wed, Jan 18, 2023 at 10:34 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Wed, Jan 18, 2023 at 10:04:39AM -0800, Suren Baghdasaryan wrote:
> > On Wed, Jan 18, 2023 at 1:49 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Tue 17-01-23 17:19:46, Suren Baghdasaryan wrote:
> > > > On Tue, Jan 17, 2023 at 7:57 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > >
> > > > > On Mon 09-01-23 12:53:34, Suren Baghdasaryan wrote:
> > > > > > call_rcu() can take a long time when callback offloading is enabled.
> > > > > > Its use in the vm_area_free can cause regressions in the exit path when
> > > > > > multiple VMAs are being freed.
> > > > >
> > > > > What kind of regressions.
> > > > >
> > > > > > To minimize that impact, place VMAs into
> > > > > > a list and free them in groups using one call_rcu() call per group.
> > > > >
> > > > > Please add some data to justify this additional complexity.
> > > >
> > > > Sorry, should have done that in the first place. A 4.3% regression was
> > > > noticed when running execl test from unixbench suite. spawn test also
> > > > showed 1.6% regression. Profiling revealed that vma freeing was taking
> > > > longer due to call_rcu() which is slow when RCU callback offloading is
> > > > enabled.
> > >
> > > Could you be more specific? vma freeing is async with the RCU so how
> > > come this has resulted in a regression? Is there any heavy
> > > rcu_synchronize in the exec path? That would be an interesting
> > > information.
> >
> > No, there is no heavy rcu_synchronize() or any other additional
> > synchronous load in the exit path. It's the call_rcu() which can block
> > the caller if CONFIG_RCU_NOCB_CPU is enabled and there are lots of
> > other call_rcu()'s going on in parallel. Note that call_rcu() calls
> > rcu_nocb_try_bypass() if CONFIG_RCU_NOCB_CPU is enabled and profiling
> > revealed that this function was taking multiple ms (don't recall the
> > actual number, sorry). Paul's explanation implied that this happens
> > due to contention on the locks taken in this function. For more
> > in-depth details I'll have to ask Paul for help :) This code is quite
> > complex and I don't know all the details of RCU implementation.
>
> There are a couple of possibilities here.
>
> First, if I am remembering correctly, the time between the call_rcu()
> and invocation of the corresponding callback was taking multiple seconds,
> but that was because the kernel was built with CONFIG_LAZY_RCU=y in
> order to save power by batching RCU work over multiple call_rcu()
> invocations.  If this is causing a problem for a given call site, the
> shiny new call_rcu_hurry() can be used instead.  Doing this gets back
> to the old-school non-laziness, but can of course consume more power.

That would not be the case because CONFIG_LAZY_RCU was not an option
at the time I was profiling this issue.
Laxy RCU would be a great option to replace this patch but
unfortunately it's not the default behavior, so I would still have to
implement this batching in case lazy RCU is not enabled.

>
> Second, there is a much shorter one-jiffy delay between the call_rcu()
> and the invocation of the corresponding callback in kernels built with
> either CONFIG_NO_HZ_FULL=y (but only on CPUs mentioned in the nohz_full
> or rcu_nocbs kernel boot parameters) or CONFIG_RCU_NOCB_CPU=y (but only
> on CPUs mentioned in the rcu_nocbs kernel boot parameters).  The purpose
> of this delay is to avoid lock contention, and so this delay is incurred
> only on CPUs that are queuing callbacks at a rate exceeding 16K/second.
> This is reduced to a per-jiffy limit, so on a HZ=1000 system, a CPU
> invoking call_rcu() at least 16 times within a given jiffy will incur
> the added delay.  The reason for this delay is the use of a separate
> ->nocb_bypass list.  As Suren says, this bypass list is used to reduce
> lock contention on the main ->cblist.  This is not needed in old-school
> kernels built without either CONFIG_NO_HZ_FULL=y or CONFIG_RCU_NOCB_CPU=y
> (including most datacenter kernels) because in that case the callbacks
> enqueued by call_rcu() are touched only by the corresponding CPU, so
> that there is no need for locks.

I believe this is the reason in my profiled case.

>
> Third, if you are instead seeing multiple milliseconds of CPU consumed by
> call_rcu() in the common case (for example, without the aid of interrupts,
> NMIs, or SMIs), please do let me know.  That sounds to me like a bug.

I don't think I've seen such a case.
Thanks for clarifications, Paul!

>
> Or have I lost track of some other slow case?
>
>                                                         Thanx, Paul
