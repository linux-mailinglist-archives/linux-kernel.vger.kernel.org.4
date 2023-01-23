Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684B4678381
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 18:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbjAWRn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 12:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjAWRnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:43:55 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1641E1EF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:43:54 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id m199so94687ybm.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MbdRXrDm0G4b0pDa706c1R5MiAQkWSslBdaNrC2lB8E=;
        b=UKgyvnaqxpZWuAuXbcWe7aJn7XDOmRlf6QqbtRqmjjqrNsksyykciJsCGgdpFt2CQN
         XaM6W9briujGFL1RejiKuJCKUrqcWGECuEv0OBka8AMNnOltN07JzxO9woC07V5MRuOK
         lIGOuD1tj2+OitLRlkQ9TOXjMyPT3MOwju8jAeSrJY3jOJu7B0x9/0b4Rr46ORcFPUPL
         9m5ShhmVH+bnYWtWaCQ9gf7B6SXzpYPqiyo6wDJ1V+8nI9leCdCm54s2S2l3cLlB1Z/A
         1s3Xgs5ERx34l8e2oApkBnckWM17ROseI1caWCFSAoNsCQy8/3j2aKxxnE8MsD360zHk
         6R6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MbdRXrDm0G4b0pDa706c1R5MiAQkWSslBdaNrC2lB8E=;
        b=m/s2vJq2OtiRmWeAswlERxLVUhG3w0USdS0OK7o9opodz/Y2yWBq5h38/w52VCWgfN
         nvDxQEfn3NwjcQOnVaja/BpoPSqjy/4FBdD7sS7ujpYqJsG2gwvQUez5V8NR6EIsrSIj
         EmUQK6uO2Vebp1I2aXITOd9IjJD9T02nPXC9RtIyygQH4wZIRfKWpH0tawqukjxYZuUO
         uMjVukbiMRWLtJbE5cpiDMD+NWOk3Q5vfy1RCOmss1ae2UsOP4VE0670QQtE9XfbXh0c
         32PFnjcsMTRg1tb+OLfZi+kWSzY+zQuEs5psWfNdnc1pbs4McY+JJbUEuFZMqH2EHoe8
         mF9w==
X-Gm-Message-State: AFqh2kqd8bN+JdsYlnYp8+b0Zfv1aSeeSYTGUOruSohdlzRSEZRrrNFS
        URhtUk5dUS8sZ3HVaV+nW8KRWrkujPGgmvCT/e2vqw==
X-Google-Smtp-Source: AMrXdXv3CgHU7SkUBkM9SwlNLny2wsFhjN99Oj3tapcuDlBqTQ5sZwoVRHtRKxpb3b0xJuv4qrd+j5dOi4ahKRGg9aQ=
X-Received: by 2002:a25:a408:0:b0:800:28d4:6936 with SMTP id
 f8-20020a25a408000000b0080028d46936mr1456121ybi.431.1674495833086; Mon, 23
 Jan 2023 09:43:53 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-40-surenb@google.com>
 <Y8k+syJu7elWAjRj@dhcp22.suse.cz> <CAJuCfpEAL9y70KJ_a=Z_kJpJnNC-ge1aN2ofTupeQ5-FaKh84g@mail.gmail.com>
 <Y8pWW9Am3mDP53qJ@dhcp22.suse.cz> <CAJuCfpHeuckG8YuNTgdDcNHNzJ3sQExD_f1hwXG_xmS7Z-925g@mail.gmail.com>
 <Y85acuBFkGr03Qd7@dhcp22.suse.cz>
In-Reply-To: <Y85acuBFkGr03Qd7@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 23 Jan 2023 09:43:41 -0800
Message-ID: <CAJuCfpGRcrbnSC3gBnfdnSU32p+5NU=7D=eWLU0F10czPdrm5A@mail.gmail.com>
Subject: Re: [PATCH 39/41] kernel/fork: throttle call_rcu() calls in vm_area_free
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, vbabka@suse.cz, hannes@cmpxchg.org,
        mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        paulmck@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
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

On Mon, Jan 23, 2023 at 1:59 AM 'Michal Hocko' via kernel-team
<kernel-team@android.com> wrote:
>
> On Fri 20-01-23 08:20:43, Suren Baghdasaryan wrote:
> > On Fri, Jan 20, 2023 at 12:52 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Thu 19-01-23 10:52:03, Suren Baghdasaryan wrote:
> > > > On Thu, Jan 19, 2023 at 4:59 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > >
> > > > > On Mon 09-01-23 12:53:34, Suren Baghdasaryan wrote:
> > > > > > call_rcu() can take a long time when callback offloading is enabled.
> > > > > > Its use in the vm_area_free can cause regressions in the exit path when
> > > > > > multiple VMAs are being freed. To minimize that impact, place VMAs into
> > > > > > a list and free them in groups using one call_rcu() call per group.
> > > > >
> > > > > After some more clarification I can understand how call_rcu might not be
> > > > > super happy about thousands of callbacks to be invoked and I do agree
> > > > > that this is not really optimal.
> > > > >
> > > > > On the other hand I do not like this solution much either.
> > > > > VM_AREA_FREE_LIST_MAX is arbitrary and it won't really help all that
> > > > > much with processes with a huge number of vmas either. It would still be
> > > > > in housands of callbacks to be scheduled without a good reason.
> > > > >
> > > > > Instead, are there any other cases than remove_vma that need this
> > > > > batching? We could easily just link all the vmas into linked list and
> > > > > use a single call_rcu instead, no? This would both simplify the
> > > > > implementation, remove the scaling issue as well and we do not have to
> > > > > argue whether VM_AREA_FREE_LIST_MAX should be epsilon or epsilon + 1.
> > > >
> > > > Yes, I agree the solution is not stellar. I wanted something simple
> > > > but this is probably too simple. OTOH keeping all dead vm_area_structs
> > > > on the list without hooking up a shrinker (additional complexity) does
> > > > not sound too appealing either.
> > >
> > > I suspect you have missed my idea. I do not really want to keep the list
> > > around or any shrinker. It is dead simple. Collect all vmas in
> > > remove_vma and then call_rcu the whole list at once after the whole list
> > > (be it from exit_mmap or remove_mt). See?
> >
> > Yes, I understood your idea but keeping dead objects until the process
> > exits even when the system is low on memory (no shrinkers attached)
> > seems too wasteful. If we do this I would advocate for attaching a
> > shrinker.
>
> I am still not sure we are on the same page here. No, vmas shouldn't lay
> around un ntil the process exit. I am really suggesting queuing only for
> remove_vma paths. You can have a different rcu callback than the one
> used for trivial single vma removal paths.

Oh, I also missed the remove_mt() part and thought you want to drain
the list only in exit_mmap(). I think that's a good option!

>
> --
> Michal Hocko
> SUSE Labs
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
