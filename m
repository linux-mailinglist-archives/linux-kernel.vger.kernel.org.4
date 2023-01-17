Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A1766D5C6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 06:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235616AbjAQF7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 00:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235484AbjAQF6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 00:58:50 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDB6222ED
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 21:58:47 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id v19so26867521ybv.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 21:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B1UEa3M1jP3y0W29RzNqF9B+ZNIIlo3tNbOA7FKp7Wg=;
        b=szFCOms07Q53JQEnknyv2QcVn4fy3vBXVmKKspUTNnPlLtZTRF0d428TYfV9jDTsLX
         ycdeb1Skm451H4kEb5YktOhQk47tSUAqY6ZKdXDHxntmfT/T2YvRnXr8768wBLUZQYsf
         NloTHm46j/BZ7LoTaIJJF+P9tpVsuTHp1412qVOeK43J5yJ5SNABR1ITdDod7FabVFjH
         0vuzHwBnFOhDtgJLMxLErKRZrVlCIUNa6khChg4g51rInsOaIMS3n4wIXMdHkkz6p02s
         pbHk2LcOHyoWkStGKc3E4jxHxQYWx4SfSGVVdA9DloQ/MHNTDm37A6udp1IgHDbr11kS
         kSTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B1UEa3M1jP3y0W29RzNqF9B+ZNIIlo3tNbOA7FKp7Wg=;
        b=6M0TmaZW2lF83S4qT8+UPgIT7BdrBFCkw88uZO2xMY1MI+yozok7ln4AxtSuLN0IL+
         G+cTKAreM0gnVY65lNAo9gYxLPHZ5X9sF8sgogXXoxwKZMIae6390GEllj13kbPRCKSk
         ywADV06w5GKrE7yx4SR9pw6MwFMKmO1OHjNZm777X7/jiar/40R16PfC2DpphGgSwfio
         cxKmkeKuXXnBjeLFDpv1uvuccjU0irE3rWzmHfel6MNLpu/29aLAtvNKOMBhdZD0tJZs
         HqfoVeh7uDlSrxIpsCiwpKqJcHYSRATuKO6PB0sk9mSwbPJYpakp6VlYq6stt4h/NUB0
         Npmg==
X-Gm-Message-State: AFqh2kq+osKlDQaObKZyFFSp/KeIb8U0eaEIajSToeKSrHvk9rk+TTjL
        pymokRv/aWMLm92ig7XTDzNLIkPiWWFPL7CdiF0SAA==
X-Google-Smtp-Source: AMrXdXvdHf1+toW/1/obAcs98q3sqrmqpnAvEMhZ2E5TLuL8tC57gEqh2hzxqreEm8uMFGnaV8bTWU/bWAWqALbg44k=
X-Received: by 2002:a25:f305:0:b0:7b8:6d00:ef23 with SMTP id
 c5-20020a25f305000000b007b86d00ef23mr296920ybs.119.1673935126396; Mon, 16 Jan
 2023 21:58:46 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-42-surenb@google.com>
 <Y8UxnqPCTLbbD+2F@localhost> <Y8YgomKF189vmgLz@casper.infradead.org>
 <CAJuCfpECJhUu3fvWbBzmAkEA3+1LTkKqJOVadQB_-_mEHME=xg@mail.gmail.com> <Y8Y2JErbNQOhL8ee@casper.infradead.org>
In-Reply-To: <Y8Y2JErbNQOhL8ee@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 16 Jan 2023 21:58:35 -0800
Message-ID: <CAJuCfpEx6FJpm0Js=cvcHw6mY3izPfoskxseSMyxFAxLX97X_w@mail.gmail.com>
Subject: Re: [PATCH 41/41] mm: replace rw_semaphore with atomic_t in vma_lock
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, akpm@linux-foundation.org,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, liam.howlett@oracle.com, peterz@infradead.org,
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

On Mon, Jan 16, 2023 at 9:46 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Jan 16, 2023 at 08:34:36PM -0800, Suren Baghdasaryan wrote:
> > On Mon, Jan 16, 2023 at 8:14 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Mon, Jan 16, 2023 at 11:14:38AM +0000, Hyeonggon Yoo wrote:
> > > > > @@ -643,20 +647,28 @@ static inline void vma_write_lock(struct vm_area_struct *vma)
> > > > >  static inline bool vma_read_trylock(struct vm_area_struct *vma)
> > > > >  {
> > > > >     /* Check before locking. A race might cause false locked result. */
> > > > > -   if (vma->vm_lock_seq == READ_ONCE(vma->vm_mm->mm_lock_seq))
> > > > > +   if (vma->vm_lock->lock_seq == READ_ONCE(vma->vm_mm->mm_lock_seq))
> > > > >             return false;
> > > > >
> > > > > -   if (unlikely(down_read_trylock(&vma->vm_lock->lock) == 0))
> > > > > +   if (unlikely(!atomic_inc_unless_negative(&vma->vm_lock->count)))
> > > > >             return false;
> > > > >
> > > > > +   /* If atomic_t overflows, restore and fail to lock. */
> > > > > +   if (unlikely(atomic_read(&vma->vm_lock->count) < 0)) {
> > > > > +           if (atomic_dec_and_test(&vma->vm_lock->count))
> > > > > +                   wake_up(&vma->vm_mm->vma_writer_wait);
> > > > > +           return false;
> > > > > +   }
> > > > > +
> > > > >     /*
> > > > >      * Overflow might produce false locked result.
> > > > >      * False unlocked result is impossible because we modify and check
> > > > >      * vma->vm_lock_seq under vma->vm_lock protection and mm->mm_lock_seq
> > > > >      * modification invalidates all existing locks.
> > > > >      */
> > > > > -   if (unlikely(vma->vm_lock_seq == READ_ONCE(vma->vm_mm->mm_lock_seq))) {
> > > > > -           up_read(&vma->vm_lock->lock);
> > > > > +   if (unlikely(vma->vm_lock->lock_seq == READ_ONCE(vma->vm_mm->mm_lock_seq))) {
> > > > > +           if (atomic_dec_and_test(&vma->vm_lock->count))
> > > > > +                   wake_up(&vma->vm_mm->vma_writer_wait);
> > > > >             return false;
> > > > >     }
> > > >
> > > > With this change readers can cause writers to starve.
> > > > What about checking waitqueue_active() before or after increasing
> > > > vma->vm_lock->count?
> > >
> > > I don't understand how readers can starve a writer.  Readers do
> > > atomic_inc_unless_negative() so a writer can always force readers
> > > to fail.
> >
> > I think the point here was that if page faults keep occuring and they
> > prevent vm_lock->count from reaching 0 then a writer will be blocked
> > and there is no reader throttling mechanism (no max time that writer
> > will be waiting).
>
> Perhaps I misunderstood your description; I thought that a _waiting_
> writer would make the count negative, not a successfully acquiring
> writer.

A waiting writer does not modify the counter, instead it's placed on
the wait queue and the last reader which sets the count to 0 while
releasing its read lock will wake it up. Once the writer is woken it
will try to set the count to negative and if successful will own the
lock, otherwise it goes back to sleep.
