Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CEF66D573
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 05:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbjAQExF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 23:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235214AbjAQEw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 23:52:59 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C692366B
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 20:52:57 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-4b718cab0e4so407492577b3.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 20:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6cw4KABvzxyFyTr8U+aFOnDbCHOejbJ4PKoRgeioGcE=;
        b=Q2yAZjcOitMQvX26vUcaa9AFrjuCsba52/KOG4Iti5Hj+jvI9tbyNfN3Oc1HWbNWZv
         ljjQ+ykxuh8fFz165trv6V1C3jeu+OmSBNt/pGxUJin2o0zDUdFf9o7NytgGh2yKTSbt
         2Kd1W/STFE3dTmDISrylLaLTA/pIsdEOzqDgDI925ScM+SVAV4ufTIg3JYYLt5Hzt4Tp
         qub/t7eS+VUQjc+hdJ8yQMcVVQgogVoex6HhgmHkOBIU0x+/syByOU9bLHWKV66ejiLD
         Lcu5PWvj0ZUCXFI5Gr+7UEzaYek7iqfbBrGQnowq+6/7RBUZ8tEN4G3kz2tIhFmgzGUm
         v2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6cw4KABvzxyFyTr8U+aFOnDbCHOejbJ4PKoRgeioGcE=;
        b=6wodeZ9khi4uEeBv8OOdq7N7IQ+q5AGx+WX7JdKquxGRhoiT3V0B9z3ifKGbVyAJQM
         7pwnqLfoo/3yR+1R7lYYSRrkIVolVkH/X4riODFGYOt2yU5dAOOWvnR2Y3hVRw/eqQ8V
         fPo3lUUeOmtYdinM8lfKqaLkL/0OAoVCU3jVkqFvL80cYxbJ7EyNLvzFc3jR0ttOazF+
         ebJajR+tCYcm2gHG1oWjEDW8n4blwKaRFvKfAgv/DnLYbOX+74FoLDKB6UMqCpKpa8CD
         YN5cBS+0okSp+R10PSUpfvytg1yanyTYhPaFkEWt6pf7VF3+9o2RDP6H1An3q+tBWYyL
         onZg==
X-Gm-Message-State: AFqh2krwtgdX9+NT+hcBbBhAMpVEMEuo0BnAmP2qWcHWFxyCq4GvpL8b
        ewbF6QktAsbH0e3DuRz6rgD3zgnGIfrPIDNtJICoPQ==
X-Google-Smtp-Source: AMrXdXvcMR9BSaGwhNU0+zyHk9pwCldBcAo4dRNPFsCz0h2FJWOV0z6ELu4HGpTdDNaFFvi6tSOBflN/EtknrzMPBDk=
X-Received: by 2002:a0d:d484:0:b0:4dc:4113:f224 with SMTP id
 w126-20020a0dd484000000b004dc4113f224mr275356ywd.455.1673931176846; Mon, 16
 Jan 2023 20:52:56 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-42-surenb@google.com> <20230116140649.2012-1-hdanton@sina.com>
 <CAJuCfpHoHcZxQZgt4Ki1kiBu9O+sANZQambOa+1gSQu2brPoyA@mail.gmail.com> <20230117031632.2321-1-hdanton@sina.com>
In-Reply-To: <20230117031632.2321-1-hdanton@sina.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 16 Jan 2023 20:52:45 -0800
Message-ID: <CAJuCfpFq23m-KYKaDoCS2K2aM8rO7j8aPa0nVPs-_xP2Sf6GGg@mail.gmail.com>
Subject: Re: [PATCH 41/41] mm: replace rw_semaphore with atomic_t in vma_lock
To:     Hillf Danton <hdanton@sina.com>
Cc:     vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        peterz@infradead.org, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
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

On Mon, Jan 16, 2023 at 7:16 PM Hillf Danton <hdanton@sina.com> wrote:
>
> On Mon, 16 Jan 2023 15:08:48 -0800 Suren Baghdasaryan <surenb@google.com>
> > On Mon, Jan 16, 2023 at 6:07 AM Hillf Danton <hdanton@sina.com> wrote:
> > > On Mon, 9 Jan 2023 12:53:36 -0800 Suren Baghdasaryan <surenb@google.com>
> > > >  static inline bool vma_read_trylock(struct vm_area_struct *vma)
> > > >  {
> > > >       /* Check before locking. A race might cause false locked result. */
> > > > -     if (vma->vm_lock_seq == READ_ONCE(vma->vm_mm->mm_lock_seq))
> > > > +     if (vma->vm_lock->lock_seq == READ_ONCE(vma->vm_mm->mm_lock_seq))
> > > >               return false;
> > >
> > > Add mb to pair with the above wmb like
> >
> > The wmb above is to ensure the ordering between updates of lock_seq
> > and vm_lock->count (lock_seq is updated first and vm_lock->count only
> > after that). The first access to vm_lock->count in this function is
> > atomic_inc_unless_negative() and it's an atomic RMW operation with a
> > return value. According to documentation such functions are fully
> > ordered, therefore I think we already have an implicit full memory
> > barrier between reads of lock_seq and vm_lock->count here. Am I wrong?
>
> No you are not.

I'm not wrong or the other way around? Please expand a bit.

> Revisit it in case of full mb not ensured.
>
> #ifndef arch_atomic_inc_unless_negative
> static __always_inline bool
> arch_atomic_inc_unless_negative(atomic_t *v)
> {
>         int c = arch_atomic_read(v);
>
>         do {
>                 if (unlikely(c < 0))
>                         return false;
>         } while (!arch_atomic_try_cmpxchg(v, &c, c + 1));
>
>         return true;
> }
> #define arch_atomic_inc_unless_negative arch_atomic_inc_unless_negative
> #endif

I think your point is that the full mb is not ensured here, specifically if c<0?

>
> > >         int count = atomic_read(&vma->vm_lock->count);
> > >         for (;;) {
> > >                 int new = count + 1;
> > >
> > >                 if (count < 0 || new < 0)
> > >                         return false;
> > >
> > >                 new = atomic_cmpxchg(&vma->vm_lock->count, count, new);
> > >                 if (new == count)
> > >                         break;
> > >                 count = new;
> > >                 cpu_relax();
> > >         }
> > >
> > >         (wake up waiting readers after taking the lock;
> > >         but the write lock owner before this read trylock should be
> > >         responsible for waking waiters up.)
> > >
> > >         lock acquire for read.
> >
> > This schema might cause readers to wait, which is not an exact
>
> Could you specify a bit more on wait?

Oh, I misunderstood your intent with that for() loop. Indeed, if a
writer took the lock, the count will be negative and it terminates
with a failure. Yeah, I think that would work.

>
> > replacement for down_read_trylock(). The requirement to wake up
> > waiting readers also complicates things
>
> If the writer lock owner is preempted by a reader while releasing lock,
>
>         set count to zero
>                           <-- preempt
>         wake up waiters
>
> then lock is owned by reader but with read waiters.
>
> That is buggy if write waiter starvation is allowed in this patchset.

I don't quite understand your point here. Readers don't wait, so there
can't be "read waiters". Could you please expand with a race diagram
maybe?

>
> > and since we can always fall
> > back to mmap_lock, that complication is unnecessary IMHO. I could use
> > part of your suggestion like this:
> >
> >                  int new = count + 1;
> >
> >                  if (count < 0 || new < 0)
> >                          return false;
> >
> >                  new = atomic_cmpxchg(&vma->vm_lock->count, count, new);
> >                  if (new == count)
> >                          return false;
> >
> > Compared to doing atomic_inc_unless_negative() first, like I did
> > originally, this schema opens a bit wider window for the writer to get
> > in the middle and cause the reader to fail locking but I don't think
> > it would result in any visible regression.
>
> It is definitely fine for writer to acquire the lock while reader is
> doing trylock, no?

Yes.

>
