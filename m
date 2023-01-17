Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57A366E6EC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjAQTYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:24:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233989AbjAQTOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:14:11 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D842E381
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:28:52 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id o75so35195655yba.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xJ9a5k62K2ffRLYGDnXiEVgAqCOpETFmSpdpD6ZFTEU=;
        b=TugNNA6IW3kjjXC0UB9Q4zYArPnczNcobp3A2tpyLPyt4MtQKyr6zzhhrfsm7d8XZz
         plZwibra7wIvfScF9ZMs3g3vVO8FjrRNHdle/svQaIXQsOx9qxV3vfbolg5PUUICJ3Kf
         d7qgMgVGJnBSkAUqbq6g1OreLXwU+87l5mwXQwW706kG5xO5+05EIi5bOXg79nz32Qrw
         dsQMNA/Gw2YTnH7r5UvQ4jWIKQWbtUYH+IOPS2OMLDSqBX7I9IH8i+VuO9kGuLBAVeFC
         nOreMEr4mt8weNwZnB7rkFh3VQKPCypGe5gwLoMmY+xBGfo+wxqPOBVJpImescmSooeA
         4IFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xJ9a5k62K2ffRLYGDnXiEVgAqCOpETFmSpdpD6ZFTEU=;
        b=iknRcieQSscgcHMmYvVQrA5Pqjop7AdYg9DZTBJMcVMYrlq6xXjn27U6Rl3QaqNejN
         51iZ6lfgX6SLCllFE6DypMAaqnicz/BuvA0JrBC8mAOWg2OoQJESfD81GIcBdv0NumnR
         bygaH5LpUCfY9/a/bwthsZIWoJILjxDBx3pto9jVdzqX+ATLTjDb1OQCocL90aw+x4/u
         MO6mzDecBaNIt5IeQGwMseh6x30X6oBpy5+F3Eyv5JoRChcRLoYfTnGw4p+STHnkISK4
         2SqXM+zc6ono3tagjKbpKIsiGbq7EF+ke54XnTi22EkwRHhKKSPJ/uI1B0Cp46z7EeK+
         T1YA==
X-Gm-Message-State: AFqh2kpQGmbosqcHiEZnue7WQ4GD2NWYCwgr0jNtkTYQuPg7JD6Mupab
        9v8Ch1F/FSViEGnhfKwlc1LspoSqqlO939O9qoDUWA==
X-Google-Smtp-Source: AMrXdXul+ds4BnedPHTIDuUTPwQ9kRruzqOz+sh02Z6/mQHpytATwg44fNmM1minbyCreXoEm6RuK7SuXwA7MwL42W8=
X-Received: by 2002:a25:f305:0:b0:7b8:6d00:ef23 with SMTP id
 c5-20020a25f305000000b007b86d00ef23mr555146ybs.119.1673980131146; Tue, 17 Jan
 2023 10:28:51 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-42-surenb@google.com>
 <Y8UxnqPCTLbbD+2F@localhost> <Y8YgomKF189vmgLz@casper.infradead.org>
 <CAJuCfpECJhUu3fvWbBzmAkEA3+1LTkKqJOVadQB_-_mEHME=xg@mail.gmail.com>
 <Y8Y2JErbNQOhL8ee@casper.infradead.org> <CAJuCfpEx6FJpm0Js=cvcHw6mY3izPfoskxseSMyxFAxLX97X_w@mail.gmail.com>
 <Y8bnpqw134CHenz/@casper.infradead.org>
In-Reply-To: <Y8bnpqw134CHenz/@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 17 Jan 2023 10:28:40 -0800
Message-ID: <CAJuCfpGKRLshk1oWf1Nz4jhDrMGnkWs7qtWYaj=j_iQwPq0THQ@mail.gmail.com>
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

On Tue, Jan 17, 2023 at 10:23 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Jan 16, 2023 at 09:58:35PM -0800, Suren Baghdasaryan wrote:
> > On Mon, Jan 16, 2023 at 9:46 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Mon, Jan 16, 2023 at 08:34:36PM -0800, Suren Baghdasaryan wrote:
> > > > On Mon, Jan 16, 2023 at 8:14 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > > >
> > > > > On Mon, Jan 16, 2023 at 11:14:38AM +0000, Hyeonggon Yoo wrote:
> > > > > > > @@ -643,20 +647,28 @@ static inline void vma_write_lock(struct vm_area_struct *vma)
> > > > > > >  static inline bool vma_read_trylock(struct vm_area_struct *vma)
> > > > > > >  {
> > > > > > >     /* Check before locking. A race might cause false locked result. */
> > > > > > > -   if (vma->vm_lock_seq == READ_ONCE(vma->vm_mm->mm_lock_seq))
> > > > > > > +   if (vma->vm_lock->lock_seq == READ_ONCE(vma->vm_mm->mm_lock_seq))
> > > > > > >             return false;
> > > > > > >
> > > > > > > -   if (unlikely(down_read_trylock(&vma->vm_lock->lock) == 0))
> > > > > > > +   if (unlikely(!atomic_inc_unless_negative(&vma->vm_lock->count)))
> > > > > > >             return false;
> > > > > > >
> > > > > > > +   /* If atomic_t overflows, restore and fail to lock. */
> > > > > > > +   if (unlikely(atomic_read(&vma->vm_lock->count) < 0)) {
> > > > > > > +           if (atomic_dec_and_test(&vma->vm_lock->count))
> > > > > > > +                   wake_up(&vma->vm_mm->vma_writer_wait);
> > > > > > > +           return false;
> > > > > > > +   }
> > > > > > > +
> > > > > > >     /*
> > > > > > >      * Overflow might produce false locked result.
> > > > > > >      * False unlocked result is impossible because we modify and check
> > > > > > >      * vma->vm_lock_seq under vma->vm_lock protection and mm->mm_lock_seq
> > > > > > >      * modification invalidates all existing locks.
> > > > > > >      */
> > > > > > > -   if (unlikely(vma->vm_lock_seq == READ_ONCE(vma->vm_mm->mm_lock_seq))) {
> > > > > > > -           up_read(&vma->vm_lock->lock);
> > > > > > > +   if (unlikely(vma->vm_lock->lock_seq == READ_ONCE(vma->vm_mm->mm_lock_seq))) {
> > > > > > > +           if (atomic_dec_and_test(&vma->vm_lock->count))
> > > > > > > +                   wake_up(&vma->vm_mm->vma_writer_wait);
> > > > > > >             return false;
> > > > > > >     }
> > > > > >
> > > > > > With this change readers can cause writers to starve.
> > > > > > What about checking waitqueue_active() before or after increasing
> > > > > > vma->vm_lock->count?
> > > > >
> > > > > I don't understand how readers can starve a writer.  Readers do
> > > > > atomic_inc_unless_negative() so a writer can always force readers
> > > > > to fail.
> > > >
> > > > I think the point here was that if page faults keep occuring and they
> > > > prevent vm_lock->count from reaching 0 then a writer will be blocked
> > > > and there is no reader throttling mechanism (no max time that writer
> > > > will be waiting).
> > >
> > > Perhaps I misunderstood your description; I thought that a _waiting_
> > > writer would make the count negative, not a successfully acquiring
> > > writer.
> >
> > A waiting writer does not modify the counter, instead it's placed on
> > the wait queue and the last reader which sets the count to 0 while
> > releasing its read lock will wake it up. Once the writer is woken it
> > will try to set the count to negative and if successful will own the
> > lock, otherwise it goes back to sleep.
>
> Then yes, that's a starvable lock.  Preventing starvation on the mmap
> sem was the original motivation for making rwsems non-starvable, so
> changing that behaviour now seems like a bad idea.  For efficiency, I'd
> suggest that a waiting writer set the top bit of the counter.  That way,
> all new readers will back off without needing to check a second variable
> and old readers will know that they *may* need to do the wakeup when
> atomic_sub_return_release() is negative.
>
> (rwsem.c has a more complex bitfield, but I don't think we need to go
> that far; the important point is that the waiting writer indicates its
> presence in the count field so that readers can modify their behaviour)

Got it. Ok, I think we can figure something out to check if there are
waiting write-lockers and prevent new readers from taking the lock.
