Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A45672515
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 18:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjARRhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 12:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjARRhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:37:04 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848F83669F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:36:57 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-4bf16baa865so477601547b3.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7FB5EOY5hb7iPFiUX3NpId4y3troCBBuKL10fDCZ/VE=;
        b=TdGBbEjT3c8FkCFMbizsOKUqjInchQaYeYbuYCI45A0Of4q0DsrHxcxoNeSqgTTSo/
         1FC/lWARbpCLzdl/khoXTHfPlPOxXqsvpRF41br3KEPdLvUAbIeVyq41RkfEXu7OhDaB
         r3V01Bf0NKaliWQ6Qu4RzuXpj1m35e7+6+JPuB6zmgeDSlv8CAWRm1JjKPnbtCO+RDpx
         DzqUdpRuBR858L/xC0UnyaG6/ry+MRD6Lz3DVVcRbf7BUAFTrksTEHadWN6zivUozpGI
         bsQd/3/X6dn1SwD3uVh48zwzhCCmEHpGXkuRfqSZIpkJ2RL7bUzz3De0szbAzoTNvN2x
         4CgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7FB5EOY5hb7iPFiUX3NpId4y3troCBBuKL10fDCZ/VE=;
        b=aoUnb9Xih2mZGr/m6LmBl5pDuh+3+9jKHc5fM04Yq54i4UPS+mrKfk9RoPPbu+0NXh
         NXDCnAvivAqoy88cGujuXdqmT7tKXJd6oguq4O4gjx2ZeWnCZ8areSIGsypv48r7Oguq
         FudUwLbQTMeqbxA8eTKe6mRnpPh+af4q7D/cGsqipJK0PJmurfH4iv8BqNP9jyy5yLn6
         /+eWc+LHIU5Zf5GficHuZcVUXoxulh2pdzvryzzNnqOX0zkUKKYrxuGaGVFQ5c3AkDyN
         4H0YchKCSBinHO4MpoLU0vQiv1wsYMmzW6ITGZKlrEvXtVWpZTcabUxrSjkmvBy1Am6n
         A+Bw==
X-Gm-Message-State: AFqh2kqOuojydnP7g1fIqSTtsA4LOO+3sFn8WoSoC3kVnx1FHO11ctSF
        aFv1C9JE2v3Xzsaa6FnKpcFpoVsyCJEuUFiEh6C9Cw==
X-Google-Smtp-Source: AMrXdXvGlQnqWtohEVY0K40X0Qaw7x+bFnBfbHiuNEi6ba/kM3CM/pTJjhlNp36i/YWBo1WjmgiXo2A0zCb3+hfB0F0=
X-Received: by 2002:a81:6d8d:0:b0:490:89c3:21b0 with SMTP id
 i135-20020a816d8d000000b0049089c321b0mr1021671ywc.132.1674063416448; Wed, 18
 Jan 2023 09:36:56 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-13-surenb@google.com>
 <CAG48ez0RhQ6=W01brLUXDXqQxz2M1FEMNqd2OvL+LhcJQY=NqA@mail.gmail.com>
 <Y8fl8lqS4QHZO1gV@dhcp22.suse.cz> <CAG48ez0dCo6KHPJrjAra=2Hm9aTm_3ERwCN3j64p3T82xNWScg@mail.gmail.com>
 <Y8gMISwBLVNLhsAq@dhcp22.suse.cz>
In-Reply-To: <Y8gMISwBLVNLhsAq@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 18 Jan 2023 09:36:44 -0800
Message-ID: <CAJuCfpGGU9TpL62EzwUCjsUy0frmR33Nyk5BQiN=AiQUkiq7yg@mail.gmail.com>
Subject: Re: [PATCH 12/41] mm: add per-VMA lock and helper functions to
 control it
To:     Michal Hocko <mhocko@suse.com>
Cc:     Jann Horn <jannh@google.com>, peterz@infradead.org,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, vbabka@suse.cz, hannes@cmpxchg.org,
        mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        paulmck@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        shakeelb@google.com, tatashin@google.com, edumazet@google.com,
        gthelen@google.com, gurua@google.com, arjunroy@google.com,
        soheil@google.com, hughlynch@google.com, leewalsh@google.com,
        posk@google.com, linux-mm@kvack.org,
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

On Wed, Jan 18, 2023 at 7:11 AM 'Michal Hocko' via kernel-team
<kernel-team@android.com> wrote:
>
> On Wed 18-01-23 14:23:32, Jann Horn wrote:
> > On Wed, Jan 18, 2023 at 1:28 PM Michal Hocko <mhocko@suse.com> wrote:
> > > On Tue 17-01-23 19:02:55, Jann Horn wrote:
> > > > +locking maintainers
> > > >
> > > > On Mon, Jan 9, 2023 at 9:54 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > > > > Introduce a per-VMA rw_semaphore to be used during page fault handling
> > > > > instead of mmap_lock. Because there are cases when multiple VMAs need
> > > > > to be exclusively locked during VMA tree modifications, instead of the
> > > > > usual lock/unlock patter we mark a VMA as locked by taking per-VMA lock
> > > > > exclusively and setting vma->lock_seq to the current mm->lock_seq. When
> > > > > mmap_write_lock holder is done with all modifications and drops mmap_lock,
> > > > > it will increment mm->lock_seq, effectively unlocking all VMAs marked as
> > > > > locked.
> > > > [...]
> > > > > +static inline void vma_read_unlock(struct vm_area_struct *vma)
> > > > > +{
> > > > > +       up_read(&vma->lock);
> > > > > +}
> > > >
> > > > One thing that might be gnarly here is that I think you might not be
> > > > allowed to use up_read() to fully release ownership of an object -
> > > > from what I remember, I think that up_read() (unlike something like
> > > > spin_unlock()) can access the lock object after it's already been
> > > > acquired by someone else.
> > >
> > > Yes, I think you are right. From a look into the code it seems that
> > > the UAF is quite unlikely as there is a ton of work to be done between
> > > vma_write_lock used to prepare vma for removal and actual removal.
> > > That doesn't make it less of a problem though.
> > >
> > > > So if you want to protect against concurrent
> > > > deletion, this might have to be something like:
> > > >
> > > > rcu_read_lock(); /* keeps vma alive */
> > > > up_read(&vma->lock);
> > > > rcu_read_unlock();
> > > >
> > > > But I'm not entirely sure about that, the locking folks might know better.
> > >
> > > I am not a locking expert but to me it looks like this should work
> > > because the final cleanup would have to happen rcu_read_unlock.
> > >
> > > Thanks, I have completely missed this aspect of the locking when looking
> > > into the code.
> > >
> > > Btw. looking at this again I have fully realized how hard it is actually
> > > to see that vm_area_free is guaranteed to sync up with ongoing readers.
> > > vma manipulation functions like __adjust_vma make my head spin. Would it
> > > make more sense to have a rcu style synchronization point in
> > > vm_area_free directly before call_rcu? This would add an overhead of
> > > uncontended down_write of course.
> >
> > Something along those lines might be a good idea, but I think that
> > rather than synchronizing the removal, it should maybe be something
> > that splats (and bails out?) if it detects pending readers. If we get
> > to vm_area_free() on a VMA that has pending readers, we might already
> > be in a lot of trouble because the concurrent readers might have been
> > traversing page tables while we were tearing them down or fun stuff
> > like that.
> >
> > I think maybe Suren was already talking about something like that in
> > another part of this patch series but I don't remember...
>
> This http://lkml.kernel.org/r/20230109205336.3665937-27-surenb@google.com?

Yes, I spent a lot of time ensuring that __adjust_vma locks the right
VMAs and that VMAs are freed or isolated under VMA write lock
protection to exclude any readers. If the VM_BUG_ON_VMA in the patch
Michal mentioned gets hit then it's a bug in my design and I'll have
to fix it. But please, let's not add synchronize_rcu() in the
vm_area_free(). That will slow down any path that frees a VMA,
especially the exit path which might be freeing thousands of them. I
had an SPF version with synchronize_rcu() in the vm_area_free() and
phone vendors started yelling at me the very next day. call_rcu() with
CONFIG_RCU_NOCB_CPU (which Android uses for power saving purposes) is
already bad enough to show up in the benchmarks and that's why I had
to add call_rcu() batching in
https://lore.kernel.org/all/20230109205336.3665937-40-surenb@google.com.

>
> --
> Michal Hocko
> SUSE Labs
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
