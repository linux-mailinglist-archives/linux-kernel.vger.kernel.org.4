Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BEF66E69B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjAQTLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234644AbjAQTHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:07:52 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B435AB76
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:21:41 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-4d4303c9de6so283783097b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UPkI1/XPnXEYuO+vM82XNHCrnZexpEfdFeQbNCsgLlg=;
        b=l09YM7DgpJrYenLsXlM+va6cEssEkvL2Rig3ks1d+kPEMg43Yd/9i46bxaNGqXrNzU
         WjF1S9YWMBF02gJj8qcCis6AocP2nZVkRUVdnFKhy5DP9owLAGDlI8QpovJ1pUrlvsJf
         5iE/N6rpZ0ZKIvHmwfer+HDs0VWYGFwkXi0U71ClRBTuOTTLuK579j4M/dCnSuSWepSf
         /nDjdkvzy41hV9c56R2hqZYfBpRF84Pgy/RtZpQb5JT0WJre7DoMqU8nMFrAk+BNJ8NI
         b0cHVD+ArloI/nXrbKgbrs41kZCzrBvh/ogxlblgEZoYQr3EkdK2FfU1iubwu4QJVZwy
         uA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UPkI1/XPnXEYuO+vM82XNHCrnZexpEfdFeQbNCsgLlg=;
        b=Q/A7w1UOc32coGa8zQQH+7ad5996sfgRJ+h8s6qBByiTL5wIU+7eHn47E64dFRsoVd
         x7NZCwtbfGLuSI3J57ZV1AzazlxfrR5JrUE6ybdmp9qbx40XMKLqBTCc6Iz5xetQXg9G
         H7muuBxbVBnVKNnqFr/ex1a2biCD7y1mq7P3MJe8/SkpXEgilRpRj2ONbNOIo4rbjob4
         D9cMpR187XUc49f0LOjzR5XCEjNxC4YB1zT8DWDZvD029foxwbpIaLPXROzZ8Izr3bhF
         m1JE+N5KRviQfQnyY9vm7N7bjibZV5AkNkSJ/zhBHYfk3VMfhXWwDuZCmjo3WOfOmw56
         ej0Q==
X-Gm-Message-State: AFqh2kr+blcuvOFUH7o4UGsQ960nOj6iA0tLOmN+sFWqJsKIUh0C+CBL
        32MtjTzp+usSKpbpcGxfZDtUnLCOy+GMguyb9TgvZvIunNOycoAT
X-Google-Smtp-Source: AMrXdXtR/XHP9ovCnWbD161pkcn3Hnd8M02agqfKeuyh3ZxoQTVKeW2ejwTZly26Cbevr74QXooOy2KdhiuW5tZJObA=
X-Received: by 2002:a0d:d484:0:b0:4dc:4113:f224 with SMTP id
 w126-20020a0dd484000000b004dc4113f224mr593908ywd.455.1673979699991; Tue, 17
 Jan 2023 10:21:39 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-42-surenb@google.com> <20230116140649.2012-1-hdanton@sina.com>
 <CAJuCfpHoHcZxQZgt4Ki1kiBu9O+sANZQambOa+1gSQu2brPoyA@mail.gmail.com>
 <20230117031632.2321-1-hdanton@sina.com> <CAJuCfpFq23m-KYKaDoCS2K2aM8rO7j8aPa0nVPs-_xP2Sf6GGg@mail.gmail.com>
 <20230117083355.2374-1-hdanton@sina.com>
In-Reply-To: <20230117083355.2374-1-hdanton@sina.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 17 Jan 2023 10:21:28 -0800
Message-ID: <CAJuCfpGU3c102mLZBY6UzkbW-DtfpYF77wLgzFpRWagBw8XfMQ@mail.gmail.com>
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

On Tue, Jan 17, 2023 at 12:34 AM Hillf Danton <hdanton@sina.com> wrote:
>
> On Mon, 16 Jan 2023 20:52:45 -0800 Suren Baghdasaryan <surenb@google.com>
> > On Mon, Jan 16, 2023 at 7:16 PM Hillf Danton <hdanton@sina.com> wrote:
> > > No you are not.
> >
> > I'm not wrong or the other way around? Please expand a bit.
>
> You are not wrong.

Ok, I think if I rewrite the vma_read_trylock() we should be fine?:

static inline bool vma_read_trylock(struct vm_area_struct *vma)
{
       int count, new;

        /* Check before locking. A race might cause false locked result. */
       if (READ_ONCE(vma->vm_lock->lock_seq) ==
           READ_ONCE(vma->vm_mm->mm_lock_seq))
                return false;

        count = atomic_read(&vma->vm_lock->count);
        for (;;) {
              /*
               * Is VMA is write-locked? Overflow might produce false
locked result.
               * False unlocked result is impossible because we modify and check
               * vma->vm_lock_seq under vma->vm_lock protection and
mm->mm_lock_seq
               * modification invalidates all existing locks.
               */
              if (count < 0)
                        return false;

             new = count + 1;
             /* If atomic_t overflows, fail to lock. */
             if (new < 0)
                        return false;

             /*
              * Atomic RMW will provide implicit mb on success to pair
with smp_wmb in
              * vma_write_lock, on failure we retry.
              */
              new = atomic_cmpxchg(&vma->vm_lock->count, count, new);
                if (new == count)
                        break;
                count = new;
                cpu_relax();
        }
       if (unlikely(READ_ONCE(vma->vm_lock->lock_seq) ==
           READ_ONCE(vma->vm_mm->mm_lock_seq))) {
               if (atomic_dec_and_test(&vma->vm_lock->count))
                       wake_up(&vma->vm_mm->vma_writer_wait);
                return false;
        }
        return true;
}
> > >
> > > If the writer lock owner is preempted by a reader while releasing lock,
> > >
> > >         set count to zero
> > >                           <-- preempt
> > >         wake up waiters
> > >
> > > then lock is owned by reader but with read waiters.
> > >
> > > That is buggy if write waiter starvation is allowed in this patchset.
> >
> > I don't quite understand your point here. Readers don't wait, so there
> > can't be "read waiters". Could you please expand with a race diagram
> > maybe?
>
>         cpu3                    cpu2
>         ---                     ---
>         taskA bond to cpu3
>         down_write(&mm->mmap_lock);
>         vma_write_lock L
>                                 taskB fail to take L for read
>                                 taskC fail to take mmap_lock for write
>                                 taskD fail to take L for read
>         vma_write_unlock_mm(mm);
>
>         preempted by taskE
>            taskE take L for read and
>            read waiters of L, taskB and taskD,
>            should be woken up
>
>         up_write(&mm->mmap_lock);

Readers never wait for vma lock, that's why we have only
vma_read_trylock and no vma_read_lock. In your scenario taskB and
taskD will fall back to taking mmap_lock for read after they failed
vma_read_trylock. Once taskA does up_write(mmap_lock) they will be
woken up since they are blocked on taking mmap_lock for read.

>
