Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A33566E722
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234641AbjAQTi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234608AbjAQTeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:34:07 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0AD3D90E
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:36:44 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id n85so7658029iod.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jj3U7X8MKNKls/ApV8M/SIHb1JIZAnMiTroClnO0tIA=;
        b=hdtpgggmeza9Z3pLGAnK9eWNRXRJ8TuOMpGGF8K/Ox2wLV+5aJK/pkS6I3WCDgcd1w
         cznonG/IHQEkdT4zLXwgi/XwivWOA7xaKUkD0ALnxDSc5zCmIpzCzUPk7akauP5ckopU
         crdQLpL4Vr0IVV/WwRoT4uWiQ9hBDyVeELqlF8FMmOsEdlYEj5g0Q771x/Cx3u8tZqX9
         TEXAX7OWsom5ymUdM/T9wOReXyCQkLnYkT3qKAvu6JiYDLBNZtewDyPRH3r444BsByVZ
         lHoUoSdJtGorfD8w3TrWg2anPLMdnJ2U+fGfyJE2XZjfcvVnx6fIzUPuqKDopozwtpui
         KL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jj3U7X8MKNKls/ApV8M/SIHb1JIZAnMiTroClnO0tIA=;
        b=S42CeA+N4tfQcyne5ad+Tm8H3ayufp8yNdi4quBpUUnH/sV7tqspXMd6ghbRifnn05
         zmrD5sHg5MB8UKtjRXoO7OkbMwACBq6Pr8nj/jLMT8XG8A1Otp+pPrwzUZnarSYov1a7
         /dE9IiYiZB1ZS2O7GiwWdCjnwae3MbDJ/ZWuh8CgNgq03sHCNd5breM3rPTM4DnMHYlT
         rY6NMfiQEpw1ASILtxggSH2TbQr08bAG2aHPHPXqcHfS6+l05345mcQZRthMZLzYp25b
         Km1oUXkeMt7+gAbPphzhXGj4EYu5hFV6KnREF1wEMXZJ0YfZcMHMIGMcO6lhB9kaWTlh
         BGlA==
X-Gm-Message-State: AFqh2kplBBbb4qmEWX02Rh+ODQ7j/ZgB2gb+OKXvQUWILy1bBD5auAP+
        gM7cjSwklHG6iVqn6XTxgUx8T7h7SHJyOygGr7HjGQ==
X-Google-Smtp-Source: AMrXdXvCH+b5CERll6lmutHDNNFVayFzrE8mxmTDaMWhbUfTorpT1Hz8BgbCIPElX7EZcrJh5yYvliMsy3/p4P0XO8Q=
X-Received: by 2002:a02:c884:0:b0:39e:9d33:a47 with SMTP id
 m4-20020a02c884000000b0039e9d330a47mr271546jao.58.1673980603471; Tue, 17 Jan
 2023 10:36:43 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-42-surenb@google.com>
 <CAG48ez3ZNt+B3XvAMP1OaeEYuwpXJ1epmT9YtNonFLEJ6yANVQ@mail.gmail.com>
 <CAJuCfpFruHecz9NssGGFrG-RqbJFHCfRuZ7c6GbTBD4x4AU8aA@mail.gmail.com> <Y8bpfzYvWq/3ttr+@casper.infradead.org>
In-Reply-To: <Y8bpfzYvWq/3ttr+@casper.infradead.org>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 17 Jan 2023 19:36:07 +0100
Message-ID: <CAG48ez0ScQMc_5Ch-d63pX4vT6L7=peQjnpneooGcXfyddXc8A@mail.gmail.com>
Subject: Re: [PATCH 41/41] mm: replace rw_semaphore with atomic_t in vma_lock
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
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

On Tue, Jan 17, 2023 at 7:31 PM Matthew Wilcox <willy@infradead.org> wrote:
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

I don't see that. When do_user_addr_fault() is calling
vma_read_unlock(), there's no RCU read lock held, right?
