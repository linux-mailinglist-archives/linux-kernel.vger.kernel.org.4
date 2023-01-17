Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72B8670C42
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 23:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjAQW67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 17:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjAQW54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 17:57:56 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA6E49559
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 14:36:59 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id l139so35963999ybl.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 14:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lm5RcDiW+2rGYFCauDaSwKbjJDggVLN2u6xrwVauKK0=;
        b=KfwF+ChqQI+spUNrTrCSVtdcoF8j4D0OPeze22WkmAhXl1Ur+BZ1OCwKXZcEIx8hfQ
         a7ONLKPiTn/QuLt6KSIjYS4Y80WenNjPid00GPCbKS8iDZHStcl5tUCHc3R3GK/eDLoG
         QPWWrKo4rNJk86Jhb+yPUhpv6SQMlfPAFQ73OSt5M/CLajTFfWZXd3Wxwp12inxJu+y6
         lP1Od8JnRwb/hbZQYbCYZy5IrI1v2NmOpcMZCXJTOwyTANa2XaglPW8Il8Q+vMrbXtJ/
         niyJNGhwX1gcX6jFIAyiAosZn3ypXcghVF309a2hAgVCwZY7kHVhn903odOn3nwV/X6x
         YH+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lm5RcDiW+2rGYFCauDaSwKbjJDggVLN2u6xrwVauKK0=;
        b=kzipbML3iSIPVMUBBo1B/eODZIRFnKxv7AWYqt1ZvQTRaO8MiCOwgl3+bc4eeQlX7b
         zfMIekxxHIrXSbH5vCrMQ3B+tTVy8CCb0I/sy2MTe2AEu1N7bondayNnFJZWKRyPZYse
         OrexQxwJXEDXDUCSzChCs5Jz0TPGNZOAvcwQQeI68e4H1aI/EUUE2cNF7qvk2BI483Cz
         ew7A9EDzomRo29TOTCdhT0YA8hJGqLJ7XxxbZslEiWBbPpsIhDXC60Ec3wS7ustn4/CF
         yZ+qYfQcJ9qApbD44P1nkRwOfaOKelp3GW3YNejcc8brGBDnSj8/3GrgEx82A37lq0rt
         pvFQ==
X-Gm-Message-State: AFqh2krMG6RZlSxhRhGtAGE6Adea6cuHAiRARIwvKfngkLTUTXh6ONfg
        z/L+aNBxOxCjwd27M4b2r69RpVwYat8+7arlsrh5cw==
X-Google-Smtp-Source: AMrXdXtGV2vg2X6848Sq5L1OnzZ5Haar7yCqj+6oRCCeUvwlEhxuO6ABcx4I+h0UVyNSvKE5u7BBhe5bspBtFhh/7Hs=
X-Received: by 2002:a05:6902:685:b0:7e9:646d:2da3 with SMTP id
 i5-20020a056902068500b007e9646d2da3mr702515ybt.340.1673995017981; Tue, 17 Jan
 2023 14:36:57 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-13-surenb@google.com>
 <CAG48ez0RhQ6=W01brLUXDXqQxz2M1FEMNqd2OvL+LhcJQY=NqA@mail.gmail.com>
 <CAJuCfpHawn-hj3yK6MEMHsvnH9xgO87h7Sj3_g0FA7rgut_mVg@mail.gmail.com> <CAG48ez3sCwasFzKD5CsqMFA2W57-2fazd75g7r0NaA_BVNTLow@mail.gmail.com>
In-Reply-To: <CAG48ez3sCwasFzKD5CsqMFA2W57-2fazd75g7r0NaA_BVNTLow@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 17 Jan 2023 14:36:47 -0800
Message-ID: <CAJuCfpFDyt2ZBGufhRz6oz2E=oyO47-d7BHwSeOiexD+UQ08jA@mail.gmail.com>
Subject: Re: [PATCH 12/41] mm: add per-VMA lock and helper functions to
 control it
To:     Jann Horn <jannh@google.com>
Cc:     peterz@infradead.org, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>, akpm@linux-foundation.org,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
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

On Tue, Jan 17, 2023 at 1:46 PM Jann Horn <jannh@google.com> wrote:
>
> On Tue, Jan 17, 2023 at 10:28 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > On Tue, Jan 17, 2023 at 10:03 AM Jann Horn <jannh@google.com> wrote:
> > >
> > > +locking maintainers
> >
> > Thanks! I'll CC the locking maintainers in the next posting.
> >
> > >
> > > On Mon, Jan 9, 2023 at 9:54 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > > > Introduce a per-VMA rw_semaphore to be used during page fault handling
> > > > instead of mmap_lock. Because there are cases when multiple VMAs need
> > > > to be exclusively locked during VMA tree modifications, instead of the
> > > > usual lock/unlock patter we mark a VMA as locked by taking per-VMA lock
> > > > exclusively and setting vma->lock_seq to the current mm->lock_seq. When
> > > > mmap_write_lock holder is done with all modifications and drops mmap_lock,
> > > > it will increment mm->lock_seq, effectively unlocking all VMAs marked as
> > > > locked.
> > > [...]
> > > > +static inline void vma_read_unlock(struct vm_area_struct *vma)
> > > > +{
> > > > +       up_read(&vma->lock);
> > > > +}
> > >
> > > One thing that might be gnarly here is that I think you might not be
> > > allowed to use up_read() to fully release ownership of an object -
> > > from what I remember, I think that up_read() (unlike something like
> > > spin_unlock()) can access the lock object after it's already been
> > > acquired by someone else. So if you want to protect against concurrent
> > > deletion, this might have to be something like:
> > >
> > > rcu_read_lock(); /* keeps vma alive */
> > > up_read(&vma->lock);
> > > rcu_read_unlock();
> >
> > But for deleting VMA one would need to write-lock the vma->lock first,
> > which I assume can't happen until this up_read() is complete. Is that
> > assumption wrong?
>
> __up_read() does:
>
> rwsem_clear_reader_owned(sem);
> tmp = atomic_long_add_return_release(-RWSEM_READER_BIAS, &sem->count);
> DEBUG_RWSEMS_WARN_ON(tmp < 0, sem);
> if (unlikely((tmp & (RWSEM_LOCK_MASK|RWSEM_FLAG_WAITERS)) ==
>       RWSEM_FLAG_WAITERS)) {
>   clear_nonspinnable(sem);
>   rwsem_wake(sem);
> }
>
> The atomic_long_add_return_release() is the point where we are doing
> the main lock-releasing.
>
> So if a reader dropped the read-lock while someone else was waiting on
> the lock (RWSEM_FLAG_WAITERS) and no other readers were holding the
> lock together with it, the reader also does clear_nonspinnable() and
> rwsem_wake() afterwards.
> But in rwsem_down_write_slowpath(), after we've set
> RWSEM_FLAG_WAITERS, we can return successfully immediately once
> rwsem_try_write_lock() sees that there are no active readers or
> writers anymore (if RWSEM_LOCK_MASK is unset and the cmpxchg
> succeeds). We're not necessarily waiting for the "nonspinnable" bit or
> the wake.
>
> So yeah, I think down_write() can return successfully before up_read()
> is done with its memory accesses.
>
> (Spinlocks are different - the kernel relies on being able to drop
> references via spin_unlock() in some places.)

Thanks for bringing this up. I can add rcu_read_{lock/unlock) as you
suggested and that would fix the issue because we free VMAs from
call_rcu(). However this feels to me as an issue of rw_semaphore
design that this locking pattern is unsafe and might lead to UAF.
