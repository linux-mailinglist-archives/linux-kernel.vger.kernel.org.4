Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DA566E793
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 21:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjAQURP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 15:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233868AbjAQUNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 15:13:21 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382332194A
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 11:06:19 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-4e9adf3673aso99878497b3.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 11:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=piMG1DuaESd4yy9T0vjqeBkSs2tcq+RGiCxRBd42BoU=;
        b=b9kN9m9+LabFupWBnO6H5aHhXpoHc5BSqt7en/Mb5CT4XEPZ4W6ihdsZ3Kt0NQdxbV
         FXlGQHOyL96F9u+bat4+2WfAeVL7mzvf+bfGCyJECTytFkyXDEA2sv8AO+kXuB9YMv5C
         y+JptZiatc2M/xTaI9ZdPokBb8M5mIHAV7SA8YUtwO6KojGENrqGQWHiofVHA7pRWHVa
         O/gxATF6aNNdKysBt4wffZjeepbmoA4mwMLVmtfnf75tHPxQw9MLhdpHp2ufGE8604Bz
         XVS+eSKEEZ//VK8aFHGIe9vam2ZiDCrz0+7L3uT1pn5crMRAf+bqYRQbSPbEvguZ4Hrc
         OG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=piMG1DuaESd4yy9T0vjqeBkSs2tcq+RGiCxRBd42BoU=;
        b=ZlJd67Mzg0KHexy5Cgb64Y/j67RWkRDVV8J3IrChXczilZjqsXOnuWcpq9cai/q1eq
         X8+7UjTVzgWQHWuHN2TF1DYCk9jy+3DMTYjVwGRbOAp4A+SzYMFQaoaKDMW0djNxaOLL
         oc55hoRG24tyzLff5ujFEoUpPrWvmmHKoHMWMmwRHVo3+L/J62/Uv0nzQM9kfSD1fVYE
         bYfnL9b/dZ21z31EZIcWfOJZ0F5H+0WjtUwo9mFpZwr3Y88AleMR509OnWTcSqqLwd1H
         v6NZSDW60ybnSaZMlEqgwc/owhLTmZb2mUnvVNAct0wJb9gZvoYJjvXp0mIJVxvwRNvD
         nzow==
X-Gm-Message-State: AFqh2kqd92Ad5jYmGbVRhcX5atgfeftpZjsLuVGl/V2V7e8gn2Nqh7fR
        ZtQeYmjlvepYwWt/uJ8qMphEXyivcx+Vi0qnEKNfWw==
X-Google-Smtp-Source: AMrXdXsHweBQHW7UKmgjom3Su1ShwZEHL2ksGWMc4WBurYbdzNOC4U9my8HdnEHW8tGQ814YZRnt9q0m/btBoe0x5Xw=
X-Received: by 2002:a81:9105:0:b0:3dc:fd91:ef89 with SMTP id
 i5-20020a819105000000b003dcfd91ef89mr462069ywg.347.1673982377776; Tue, 17 Jan
 2023 11:06:17 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-42-surenb@google.com>
 <CAG48ez3ZNt+B3XvAMP1OaeEYuwpXJ1epmT9YtNonFLEJ6yANVQ@mail.gmail.com>
 <CAJuCfpFruHecz9NssGGFrG-RqbJFHCfRuZ7c6GbTBD4x4AU8aA@mail.gmail.com>
 <Y8bpfzYvWq/3ttr+@casper.infradead.org> <CAJuCfpHkgRDpMJXd6vnCmB50PnSOwDY9pjhW5LcdR+fU5JUseA@mail.gmail.com>
 <Y8btYASD3jmdCf5n@casper.infradead.org> <CAJuCfpGcufxmL7A-ea_JDKU2pxrTQJ7Sez7C6zcVyFK9q1CXUg@mail.gmail.com>
 <CAG48ez3Je1Jht_vqJf-qQ5R=KDuE1gzmHy5wN8oYZTwr+0PwBA@mail.gmail.com>
In-Reply-To: <CAG48ez3Je1Jht_vqJf-qQ5R=KDuE1gzmHy5wN8oYZTwr+0PwBA@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 17 Jan 2023 11:06:06 -0800
Message-ID: <CAJuCfpGPjEz_aK41hFDmz8Fd=xyjfS8X0dgEAJWQMteL2=yebQ@mail.gmail.com>
Subject: Re: [PATCH 41/41] mm: replace rw_semaphore with atomic_t in vma_lock
To:     Jann Horn <jannh@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
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

On Tue, Jan 17, 2023 at 11:00 AM Jann Horn <jannh@google.com> wrote:
>
> On Tue, Jan 17, 2023 at 7:55 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > On Tue, Jan 17, 2023 at 10:47 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Tue, Jan 17, 2023 at 10:36:42AM -0800, Suren Baghdasaryan wrote:
> > > > On Tue, Jan 17, 2023 at 10:31 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > > >
> > > > > On Tue, Jan 17, 2023 at 10:26:32AM -0800, Suren Baghdasaryan wrote:
> > > > > > On Tue, Jan 17, 2023 at 10:12 AM Jann Horn <jannh@google.com> wrote:
> > > > > > >
> > > > > > > On Mon, Jan 9, 2023 at 9:55 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > > > > > > > rw_semaphore is a sizable structure of 40 bytes and consumes
> > > > > > > > considerable space for each vm_area_struct. However vma_lock has
> > > > > > > > two important specifics which can be used to replace rw_semaphore
> > > > > > > > with a simpler structure:
> > > > > > > [...]
> > > > > > > >  static inline void vma_read_unlock(struct vm_area_struct *vma)
> > > > > > > >  {
> > > > > > > > -       up_read(&vma->vm_lock->lock);
> > > > > > > > +       if (atomic_dec_and_test(&vma->vm_lock->count))
> > > > > > > > +               wake_up(&vma->vm_mm->vma_writer_wait);
> > > > > > > >  }
> > > > > > >
> > > > > > > I haven't properly reviewed this, but this bit looks like a
> > > > > > > use-after-free because you're accessing the vma after dropping your
> > > > > > > reference on it. You'd have to first look up the vma->vm_mm, then do
> > > > > > > the atomic_dec_and_test(), and afterwards do the wake_up() without
> > > > > > > touching the vma. Or alternatively wrap the whole thing in an RCU
> > > > > > > read-side critical section if the VMA is freed with RCU delay.
> > > > > >
> > > > > > vm_lock->count does not control the lifetime of the VMA, it's a
> > > > > > counter of how many readers took the lock or it's negative if the lock
> > > > > > is write-locked.
> > > > >
> > > > > Yes, but ...
> > > > >
> > > > >         Task A:
> > > > >         atomic_dec_and_test(&vma->vm_lock->count)
> > > > >                         Task B:
> > > > >                         munmap()
> > > > >                         write lock
> > > > >                         free VMA
> > > > >                         synchronize_rcu()
> > > > >                         VMA is really freed
> > > > >         wake_up(&vma->vm_mm->vma_writer_wait);
> > > > >
> > > > > ... vma is freed.
> > > > >
> > > > > Now, I think this doesn't occur.  I'm pretty sure that every caller of
> > > > > vma_read_unlock() is holding the RCU read lock.  But maybe we should
> > > > > have that assertion?
> > > >
> > > > Yep, that's what this patch is doing
> > > > https://lore.kernel.org/all/20230109205336.3665937-27-surenb@google.com/
> > > > by calling vma_assert_no_reader() from __vm_area_free().
> > >
> > > That's not enough though.  Task A still has a pointer to vma after it
> > > has called atomic_dec_and_test(), even after vma has been freed by
> > > Task B, and before Task A dereferences vma->vm_mm.
> >
> > Ah, I see your point now. I guess I'll have to store vma->vm_mm in a
> > local variable and call mmgrab() before atomic_dec_and_test(), then
> > use it in wake_up() and call mmdrop(). Is that what you are thinking?
>
> You shouldn't need mmgrab()/mmdrop(), because whoever is calling you
> for page fault handling must be keeping the mm_struct alive.

Good point. Will update in the next revision to store mm before
dropping the count. Thanks for all the comments folks!
