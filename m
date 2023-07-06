Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6BF7492B7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 02:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbjGFAnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 20:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjGFAnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 20:43:07 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0FE1992
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 17:43:06 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-c5f98fc4237so84258276.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 17:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688604185; x=1691196185;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AkSspCOErsANmUQHMJUgc/2V9u039DDqqjUdLJyc3Ek=;
        b=rvWFOwKtRNWWzTzEX/nBgwZIxcHC2IimRJHDuCmWnR5IBpsHWKYO9VjvjRpzBLhXaA
         LPkdziDbBvB+PTsZDOzr9FZi+4hf37P93hiLqdUOztORPgZOHR88YnlZ1vGI8x1UFje5
         QKXnGkYf3PMUBEckpFsGvJLiFuLj+RJtSKrp8PZtJOurJ+3Vpe65kzIdIvPqepwzBFWy
         E1PFNKAk8zWvOqkHxK2o9lrlOHM6aESe5Y+a5+iOXkMnVWtP3b97KZ2kXiORe4PToWWB
         1NvdfpViGy60l3TZJmahSYNmlX4CqN+3AWfYkfY8tfss7Oqxan8OYazkZonS87YeEsAg
         BiTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688604185; x=1691196185;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AkSspCOErsANmUQHMJUgc/2V9u039DDqqjUdLJyc3Ek=;
        b=E6DkLBi7UZ+MY2Q6plyixtGTram4mIpPniCKo5oB8QeS5W/xFocSW6ZGrDXIwKaJw+
         iI7xSRZTYSJfVsK0hixCM30SOkLlLxXAngDuLo2tMXWPNoPK7tRRdl4iV9/yqerSAy/k
         IRbsFZKiSWEYODZkSSoClwyS2/RjgUXPeqNonH8xxCY7VbovszF55zzy3LE8TZK+fOS5
         10pb6qbyP+4Yz8sLU67qwnoANAYXi8P4u7nPbuSM6AfqgIzEgzzPvBltDaxBxxPlIvpQ
         0c9INVIRtKIFNTTuZgHC1Te2lmb8AhDlXHG8oDfh9E6+ffj7Xz+VK3/svfnoD8GyI/3q
         SHtw==
X-Gm-Message-State: ABy/qLaKwDuVp7w8mNBpZpSoKYyART2mqfhu2xcG8jrVHaHs684UlWv/
        Yvx3xg8/1wBYTam2n9vtrwJdOxR4Y6AbxA095vJHdA==
X-Google-Smtp-Source: APBJJlGmkKX3Bo4nXDNgFWdLoKh/m7u78WfwSoJAB43jrQLyQj1eKp1pbDaBm86/UZaCYFq7AOjIBPRgo6EbMEwDuXM=
X-Received: by 2002:a25:ed03:0:b0:c14:f668:ebbc with SMTP id
 k3-20020a25ed03000000b00c14f668ebbcmr379338ybh.65.1688604185266; Wed, 05 Jul
 2023 17:43:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230705171213.2843068-1-surenb@google.com> <20230705171213.2843068-2-surenb@google.com>
 <10c8fe17-fa9b-bf34-cb88-c758e07c9d72@redhat.com> <CAJuCfpFBh647trAjgPfr0Wcd=7V2gbHUnBe8mR4Pgdmrzh6Hxg@mail.gmail.com>
 <20230705230647.twq3n5nb2iabr7uk@revolver> <CAJuCfpG1GCwvvOWgtHkGCNLk-emOsb_sA2hki5dMriAQzRQQNg@mail.gmail.com>
 <20230706003252.sj57tjmqb77yflqq@revolver>
In-Reply-To: <20230706003252.sj57tjmqb77yflqq@revolver>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 5 Jul 2023 17:42:54 -0700
Message-ID: <CAJuCfpGHa9c2WGFXk0OKPg4dU7izEZq-BbYccOz=4mzN7o1VVw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] fork: lock VMAs of the parent process when forking
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        David Hildenbrand <david@redhat.com>,
        akpm@linux-foundation.org, jirislaby@kernel.org,
        jacobly.alt@gmail.com, holger@applied-asynchrony.com,
        hdegoede@redhat.com, michel@lespinasse.org, jglisse@google.com,
        mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org,
        mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, peterz@infradead.org, ldufour@linux.ibm.com,
        paulmck@kernel.org, mingo@redhat.com, will@kernel.org,
        luto@kernel.org, songliubraving@fb.com, peterx@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        chriscli@google.com, axelrasmussen@google.com, joelaf@google.com,
        minchan@google.com, rppt@kernel.org, jannh@google.com,
        shakeelb@google.com, tatashin@google.com, edumazet@google.com,
        gthelen@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 5, 2023 at 5:33=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracle=
.com> wrote:
>
> * Suren Baghdasaryan <surenb@google.com> [230705 20:20]:
> > On Wed, Jul 5, 2023 at 4:07=E2=80=AFPM Liam R. Howlett <Liam.Howlett@or=
acle.com> wrote:
> > >
> > > * Suren Baghdasaryan <surenb@google.com> [230705 13:24]:
> > > > On Wed, Jul 5, 2023 at 10:14=E2=80=AFAM David Hildenbrand <david@re=
dhat.com> wrote:
> > > > >
> > > > > On 05.07.23 19:12, Suren Baghdasaryan wrote:
> > > > > > When forking a child process, parent write-protects an anonymou=
s page
> > > > > > and COW-shares it with the child being forked using copy_presen=
t_pte().
> > > > > > Parent's TLB is flushed right before we drop the parent's mmap_=
lock in
> > > > > > dup_mmap(). If we get a write-fault before that TLB flush in th=
e parent,
> > > > > > and we end up replacing that anonymous page in the parent proce=
ss in
> > > > > > do_wp_page() (because, COW-shared with the child), this might l=
ead to
> > > > > > some stale writable TLB entries targeting the wrong (old) page.
> > > > > > Similar issue happened in the past with userfaultfd (see flush_=
tlb_page()
> > > > > > call inside do_wp_page()).
> > > > > > Lock VMAs of the parent process when forking a child, which pre=
vents
> > > > > > concurrent page faults during fork operation and avoids this is=
sue.
> > > > > > This fix can potentially regress some fork-heavy workloads. Ker=
nel build
> > > > > > time did not show noticeable regression on a 56-core machine wh=
ile a
> > > > > > stress test mapping 10000 VMAs and forking 5000 times in a tigh=
t loop
> > > > > > shows ~5% regression. If such fork time regression is unaccepta=
ble,
> > > > > > disabling CONFIG_PER_VMA_LOCK should restore its performance. F=
urther
> > > > > > optimizations are possible if this regression proves to be prob=
lematic.
> > > > > >
> > > > > > Suggested-by: David Hildenbrand <david@redhat.com>
> > > > > > Reported-by: Jiri Slaby <jirislaby@kernel.org>
> > > > > > Closes: https://lore.kernel.org/all/dbdef34c-3a07-5951-e1ae-e9c=
6e3cdf51b@kernel.org/
> > > > > > Reported-by: Holger Hoffst=C3=A4tte <holger@applied-asynchrony.=
com>
> > > > > > Closes: https://lore.kernel.org/all/b198d649-f4bf-b971-31d0-e84=
33ec2a34c@applied-asynchrony.com/
> > > > > > Reported-by: Jacob Young <jacobly.alt@gmail.com>
> > > > > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217624
> > > > > > Fixes: 0bff0aaea03e ("x86/mm: try VMA lock-based page fault han=
dling first")
> > > > > > Cc: stable@vger.kernel.org
> > > > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > > > ---
> > > > > >   kernel/fork.c | 6 ++++++
> > > > > >   1 file changed, 6 insertions(+)
> > > > > >
> > > > > > diff --git a/kernel/fork.c b/kernel/fork.c
> > > > > > index b85814e614a5..403bc2b72301 100644
> > > > > > --- a/kernel/fork.c
> > > > > > +++ b/kernel/fork.c
> > > > > > @@ -658,6 +658,12 @@ static __latent_entropy int dup_mmap(struc=
t mm_struct *mm,
> > > > > >               retval =3D -EINTR;
> > > > > >               goto fail_uprobe_end;
> > > > > >       }
> > > > > > +#ifdef CONFIG_PER_VMA_LOCK
> > > > > > +     /* Disallow any page faults before calling flush_cache_du=
p_mm */
> > > > > > +     for_each_vma(old_vmi, mpnt)
> > > > > > +             vma_start_write(mpnt);
> > > > > > +     vma_iter_init(&old_vmi, oldmm, 0);
> > >
> > > vma_iter_set(&old_vmi, 0) is probably what you want here.
> >
> > Ok, I send another version with that.
> >
> > >
> > > > > > +#endif
> > > > > >       flush_cache_dup_mm(oldmm);
> > > > > >       uprobe_dup_mmap(oldmm, mm);
> > > > > >       /*
> > > > >
> > > > > The old version was most probably fine as well, but this certainl=
y looks
> > > > > even safer.
> > > > >
> > > > > Acked-by: David Hildenbrand <david@redhat.com>
> > >
> > > I think this is overkill and believe setting the vma_start_write() wi=
ll
> > > synchronize with any readers since it's using the per-vma rw semaphor=
e
> > > in write mode. Anything faulting will need to finish before the fork
> > > continues and faults during the fork will fall back to a read lock of
> > > the mmap_lock.  Is there a possibility of populate happening outside =
the
> > > mmap_write lock/vma_lock?
> >
> > Yes, I think we understand the loss of concurrency in the parent's
> > ability to fault pages while forking. Is that a real problem though?
>
> No, I don't think that part is an issue at all.  I wanted to be sure I
> didn't miss something.
>
> >
> > >
> > > Was your benchmarking done with this loop at the start?
> >
> > No, it was done with the initial version where the lock was inside the
> > existing loop. I just reran the benchmark and while kernel compilation
> > times did not change, the stress test shows ~7% regression now,
> > probably due to that additional tree walk. I'll update that number in
> > the new patch.
>
> ..but I expected a performance hit and didn't understand why you updated
> the patch this way.  It would probably only happen on really big trees
> though and, ah, the largest trees I see are from the android side.  I'd
> wager the impact will be felt more when larger trees encounter smaller
> CPU cache.

My test has 10000 vmas and even for Android that's a stretch (the
highest number I've seen was ~4000).
We can think of a less restrictive solution if this proves to be a
problem for some workloads but for now I would prefer to fix this in a
safe way and possibly improve that later. The alternative is to revert
this completely and we get no more testing until the next release.

>
> Thanks,
> Liam
