Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D086C66D561
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 05:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235287AbjAQEe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 23:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235199AbjAQEeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 23:34:50 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081082196F
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 20:34:49 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-4d59d518505so237880807b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 20:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yRWBrMnmbVU6x7T0LPdTvz2nVvy3IZspLp0UQMF1irY=;
        b=hM38RCzSZziAG4zDZljPcNKfKjFLxHw4U/hoqCGnc2uhhpiLyfSuGpOTWJdWIMlxUv
         KjjhlBQmiQD8oPmw8rC7puYkrtFzSPrLW3kUpLnqfZC4c3aQzBYS/77dZgZ3jxcmGSFw
         GIuig9k6wQaOTlDLxqIH8XTIgBM6dLPj+spsFwsvjdG67Vdq/GY9waM9rX8RSrpCp0x3
         8BaL/NOYp7Q0chsNamh7WaEtB2GnL40hJ1GgUHERDPj8PKO5UjxdqJIQNfLL/BykPZf1
         B0tiiASa/wxaXtgB66A7Qm1/fEYloC8AH7VIbm0aHwYy1hzVUqvaTtSyE9Wgwz9LlOij
         3bYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yRWBrMnmbVU6x7T0LPdTvz2nVvy3IZspLp0UQMF1irY=;
        b=wXPIxQoNNlaR6xVo1qCaHMW/fCRgrwfvTxcxLhADQQ+/opXVBTQrUCz77vfHl80oZr
         CXuYLClmqTjd++j+GnODdE5iTCXUAAZWvLiuX0PGaZH3yAYqanAn8ebkHY2QOLbmQQV2
         DKTgKe4JSiQR8jvYuiECwx58wiU5u03x6sHRw2KJCeQoUeNL+veGUzIbkqRj7nSjHQrN
         X+dcqyCJLmi9mAgKbViREFfiYhJMeedHwwQ5JtNFBzZkToB2hkDCeH8pB5F+2sn6UATU
         cba6BSh+VbtV7LDPn1noxTS2QtXxPTjB1J7DbbDmGNJZjm4Xcc9R874Hy0FbSu6rE9rr
         DYiA==
X-Gm-Message-State: AFqh2kofRbg96sNzuhXT8v+QOXjAGFUO0BPWePuJWsyaO8blU0qqKYLP
        BFfQ1NZoIvbK/hpREsRbdyTLZnsEnEmlfvHwUKaPbw==
X-Google-Smtp-Source: AMrXdXseXKT6jNFxFMT1V3/l2fB00iDOPtEl/NQbThFwW0Hm+cjzFDqP3MAncylx3ySdnaL+hEiuL1zL4iLHm5r9qaI=
X-Received: by 2002:a81:708c:0:b0:479:b6a1:d9a4 with SMTP id
 l134-20020a81708c000000b00479b6a1d9a4mr179033ywc.263.1673930087969; Mon, 16
 Jan 2023 20:34:47 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-42-surenb@google.com>
 <Y8UxnqPCTLbbD+2F@localhost> <Y8YgomKF189vmgLz@casper.infradead.org>
In-Reply-To: <Y8YgomKF189vmgLz@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 16 Jan 2023 20:34:36 -0800
Message-ID: <CAJuCfpECJhUu3fvWbBzmAkEA3+1LTkKqJOVadQB_-_mEHME=xg@mail.gmail.com>
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

On Mon, Jan 16, 2023 at 8:14 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Jan 16, 2023 at 11:14:38AM +0000, Hyeonggon Yoo wrote:
> > > @@ -643,20 +647,28 @@ static inline void vma_write_lock(struct vm_area_struct *vma)
> > >  static inline bool vma_read_trylock(struct vm_area_struct *vma)
> > >  {
> > >     /* Check before locking. A race might cause false locked result. */
> > > -   if (vma->vm_lock_seq == READ_ONCE(vma->vm_mm->mm_lock_seq))
> > > +   if (vma->vm_lock->lock_seq == READ_ONCE(vma->vm_mm->mm_lock_seq))
> > >             return false;
> > >
> > > -   if (unlikely(down_read_trylock(&vma->vm_lock->lock) == 0))
> > > +   if (unlikely(!atomic_inc_unless_negative(&vma->vm_lock->count)))
> > >             return false;
> > >
> > > +   /* If atomic_t overflows, restore and fail to lock. */
> > > +   if (unlikely(atomic_read(&vma->vm_lock->count) < 0)) {
> > > +           if (atomic_dec_and_test(&vma->vm_lock->count))
> > > +                   wake_up(&vma->vm_mm->vma_writer_wait);
> > > +           return false;
> > > +   }
> > > +
> > >     /*
> > >      * Overflow might produce false locked result.
> > >      * False unlocked result is impossible because we modify and check
> > >      * vma->vm_lock_seq under vma->vm_lock protection and mm->mm_lock_seq
> > >      * modification invalidates all existing locks.
> > >      */
> > > -   if (unlikely(vma->vm_lock_seq == READ_ONCE(vma->vm_mm->mm_lock_seq))) {
> > > -           up_read(&vma->vm_lock->lock);
> > > +   if (unlikely(vma->vm_lock->lock_seq == READ_ONCE(vma->vm_mm->mm_lock_seq))) {
> > > +           if (atomic_dec_and_test(&vma->vm_lock->count))
> > > +                   wake_up(&vma->vm_mm->vma_writer_wait);
> > >             return false;
> > >     }
> >
> > With this change readers can cause writers to starve.
> > What about checking waitqueue_active() before or after increasing
> > vma->vm_lock->count?
>
> I don't understand how readers can starve a writer.  Readers do
> atomic_inc_unless_negative() so a writer can always force readers
> to fail.

I think the point here was that if page faults keep occuring and they
prevent vm_lock->count from reaching 0 then a writer will be blocked
and there is no reader throttling mechanism (no max time that writer
will be waiting).
