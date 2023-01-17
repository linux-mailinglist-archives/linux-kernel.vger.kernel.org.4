Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A724666E716
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbjAQTgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234875AbjAQTeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:34:31 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832B345BE5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:36:54 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id d62so19038090ybh.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V1H5fXM2fL2DdrWpyoXMBctTJAS8jb7T6PCl+Qy5zOw=;
        b=gxjnHvj8cVe25xe+zX4WRnwKZ/brVkr5NAQvQhig97cn/WdPwEKXJ0CcxWDRdQjTgL
         CXjwieZIUVlSTyILqrTiUbDRF+ea1UDehvweav5P1CuJOVEyBuDTsE3qvQqobL8xO6AP
         hCH0dgiIRYxBj6IumfW7TGL56+UaWnuSKlqJ21JgE0enoNkA++ErvEnjd5UB4xrMV6Jf
         uG/GUaOWc80u2H1KfcKnHUfrKMiW/71Ep2ENhqfcG0DCYRUSZUZbjGFDfpgzNkbmGKzW
         a+pu7tysx22k06eWclORI9cJLUxOPOxAJoVnZ1Td/WfLw2pThNtKXmCaWj7fKFEdQY0p
         MTvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V1H5fXM2fL2DdrWpyoXMBctTJAS8jb7T6PCl+Qy5zOw=;
        b=CGYAuwXQZIn6r/3mNA9FnZeRXYo3AOlamqpwGmox7Y+1Eij1XV+5xp9BJ7oBsjxCht
         xwIqcoF8GRmYaJqOjM9VZU73p3b4pppUw1sXgkyVdyarYoh452+etLWX+POOHV1tjR0n
         7Nmz3y/Gpav3XGFljKtNTaRzuRcrItoP1AmzIa6vMtH1j5dqJUlEkNwt+AquK/HWLtk0
         MAny9jvQnuaaAgT46KVJKaMbhftX4ucGwIo1gJFw3plQOQKWmjLmxPUphZ3V31x2YS9u
         NfbZjXUSgpuUyTcoyuhsmL6BSzQNOhJSaeiXKOMsrO8FZrUwaW0Fk0oc57864eiY9fHV
         ocNw==
X-Gm-Message-State: AFqh2koe4s1NmKGtQNV+wRW6DIPn4tVH8f35cK1ThYhAFmXj+Ssy9W2a
        Qeb7/LKmIOKk5++2vV0xnNXHLiEIVfsBiYKS0MFwBg==
X-Google-Smtp-Source: AMrXdXtyj7e8dbA/BNCU251BtN/VoE0bK1PziTZuFr/9sT9i9A5FERt6459sIvPd/PApW3XUSMSS+TJrm1BvJY90WKw=
X-Received: by 2002:a25:ceca:0:b0:7e4:115c:9cf6 with SMTP id
 x193-20020a25ceca000000b007e4115c9cf6mr540428ybe.316.1673980613192; Tue, 17
 Jan 2023 10:36:53 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-42-surenb@google.com>
 <CAG48ez3ZNt+B3XvAMP1OaeEYuwpXJ1epmT9YtNonFLEJ6yANVQ@mail.gmail.com>
 <CAJuCfpFruHecz9NssGGFrG-RqbJFHCfRuZ7c6GbTBD4x4AU8aA@mail.gmail.com> <Y8bpfzYvWq/3ttr+@casper.infradead.org>
In-Reply-To: <Y8bpfzYvWq/3ttr+@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 17 Jan 2023 10:36:42 -0800
Message-ID: <CAJuCfpHkgRDpMJXd6vnCmB50PnSOwDY9pjhW5LcdR+fU5JUseA@mail.gmail.com>
Subject: Re: [PATCH 41/41] mm: replace rw_semaphore with atomic_t in vma_lock
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jann Horn <jannh@google.com>, akpm@linux-foundation.org,
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

On Tue, Jan 17, 2023 at 10:31 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Jan 17, 2023 at 10:26:32AM -0800, Suren Baghdasaryan wrote:
> > On Tue, Jan 17, 2023 at 10:12 AM Jann Horn <jannh@google.com> wrote:
> > >
> > > On Mon, Jan 9, 2023 at 9:55 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > > > rw_semaphore is a sizable structure of 40 bytes and consumes
> > > > considerable space for each vm_area_struct. However vma_lock has
> > > > two important specifics which can be used to replace rw_semaphore
> > > > with a simpler structure:
> > > [...]
> > > >  static inline void vma_read_unlock(struct vm_area_struct *vma)
> > > >  {
> > > > -       up_read(&vma->vm_lock->lock);
> > > > +       if (atomic_dec_and_test(&vma->vm_lock->count))
> > > > +               wake_up(&vma->vm_mm->vma_writer_wait);
> > > >  }
> > >
> > > I haven't properly reviewed this, but this bit looks like a
> > > use-after-free because you're accessing the vma after dropping your
> > > reference on it. You'd have to first look up the vma->vm_mm, then do
> > > the atomic_dec_and_test(), and afterwards do the wake_up() without
> > > touching the vma. Or alternatively wrap the whole thing in an RCU
> > > read-side critical section if the VMA is freed with RCU delay.
> >
> > vm_lock->count does not control the lifetime of the VMA, it's a
> > counter of how many readers took the lock or it's negative if the lock
> > is write-locked.
>
> Yes, but ...
>
>         Task A:
>         atomic_dec_and_test(&vma->vm_lock->count)
>                         Task B:
>                         munmap()
>                         write lock
>                         free VMA
>                         synchronize_rcu()
>                         VMA is really freed
>         wake_up(&vma->vm_mm->vma_writer_wait);
>
> ... vma is freed.
>
> Now, I think this doesn't occur.  I'm pretty sure that every caller of
> vma_read_unlock() is holding the RCU read lock.  But maybe we should
> have that assertion?

Yep, that's what this patch is doing
https://lore.kernel.org/all/20230109205336.3665937-27-surenb@google.com/
by calling vma_assert_no_reader() from __vm_area_free().

>
