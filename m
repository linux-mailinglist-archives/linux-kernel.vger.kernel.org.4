Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D9667253A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 18:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjARRmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 12:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjARRlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:41:35 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BBB5A80E
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:40:49 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id 66so3830014yba.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O+c3praop+F4hgZx9fYsgBqwRZyACPImTP4EJ0i5h+4=;
        b=Ka6nVunrhz4AtVb4ez9bPbZMrA+BT0HLYjQWV2A83Am/7vZHMnwaJyxrzb3BG1Ge4V
         jClzWXorirsqV3khCBOP4ggO2Tn0WG07oU9lIclP9VHGeoB6qrpZtnGhe7bo/ttx6zDC
         TMjP/ThYyG7YcvLasV/vCtOVTAZsP1RDT6VNGtA88feNmFKy0+OV9yXL+HJ0AxWhqfSt
         pSmnW0q7C+E7rigeF6haineNjehNr7CNxIMAgv0g5lIonW0kqwLOFL/u5eriUgrmlkcF
         2HtNHfIc9raNIqPYMX6fhNH4Ttqpzmn1gyvx4VhRfWtC7xh2fn/uQa3Wc5QgHD/pyLWB
         Ygag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O+c3praop+F4hgZx9fYsgBqwRZyACPImTP4EJ0i5h+4=;
        b=T/2rLi9aqpJYm/s4BaWVzrwiPeM6a89VpBSpnpvqh4BfTUQvzckeSlVas3w/rc7IW5
         HJ/ljO2C42cgOugfjPRoxvxeWJzQo0R/k7NOmgKQMUT9btjB3lLKgxx0/MZkvDEZer3U
         INCSy57KNWP1G8+jxhc5Cb3bvI2dXqUR7BsC5b0gtRnZuJ4TnHOYxgvbiS31ZRqewD6H
         vPiLY+BnhSpQy2BJv3E5mEV0Ng6LDFhl1G+57QMwYxODfw9aYdCcPV4T2cJGQcjE5hIB
         Ob276SKXmWX0soZSugMEsTkf1Y4+aOhOMlELSoU/FKJ1ytlVTbHAjXHHhVxb/KMbF0O8
         yehQ==
X-Gm-Message-State: AFqh2krf+WujjVx+N5gr5y9I7yOKQiW9Jj3LAQRQwGpFVYwBmgpU/VcD
        0vBJhOdr0cvFjftV5eoEMUswJphO5T5vlIKofqVhag==
X-Google-Smtp-Source: AMrXdXs1k5W3HoVGCiUVOI7jTqOyluR9eRrHzCwGnTn1al/nkArE3wLdMkVcHMHmAcyunh8GSfVeJdebmQPCKJ8WsTw=
X-Received: by 2002:a05:6902:685:b0:7e9:646d:2da3 with SMTP id
 i5-20020a056902068500b007e9646d2da3mr1102592ybt.340.1674063648863; Wed, 18
 Jan 2023 09:40:48 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-28-surenb@google.com>
 <CAG48ez3EAai=1ghnCMF6xcgUebQRm-u2xhwcpYsfP9=r=oVXig@mail.gmail.com>
In-Reply-To: <CAG48ez3EAai=1ghnCMF6xcgUebQRm-u2xhwcpYsfP9=r=oVXig@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 18 Jan 2023 09:40:37 -0800
Message-ID: <CAJuCfpETt1NHOhOzkP+pgUnNLNRq3LRRyadsc20pW+cCDLuyPg@mail.gmail.com>
Subject: Re: [PATCH 27/41] mm/mmap: prevent pagefault handler from racing with
 mmu_notifier registration
To:     Jann Horn <jannh@google.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
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

On Wed, Jan 18, 2023 at 4:51 AM Jann Horn <jannh@google.com> wrote:
>
> On Mon, Jan 9, 2023 at 9:54 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > Page fault handlers might need to fire MMU notifications while a new
> > notifier is being registered. Modify mm_take_all_locks to write-lock all
> > VMAs and prevent this race with fault handlers that would hold VMA locks.
> > VMAs are locked before i_mmap_rwsem and anon_vma to keep the same
> > locking order as in page fault handlers.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  mm/mmap.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 30c7d1c5206e..a256deca0bc0 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -3566,6 +3566,7 @@ static void vm_lock_mapping(struct mm_struct *mm, struct address_space *mapping)
> >   * of mm/rmap.c:
> >   *   - all hugetlbfs_i_mmap_rwsem_key locks (aka mapping->i_mmap_rwsem for
> >   *     hugetlb mapping);
> > + *   - all vmas marked locked
>
> The existing comment above says that this is an *ordered* listing of
> which locks are taken.
>
> >   *   - all i_mmap_rwsem locks;
> >   *   - all anon_vma->rwseml
> >   *
> > @@ -3591,6 +3592,7 @@ int mm_take_all_locks(struct mm_struct *mm)
> >         mas_for_each(&mas, vma, ULONG_MAX) {
> >                 if (signal_pending(current))
> >                         goto out_unlock;
> > +               vma_write_lock(vma);
> >                 if (vma->vm_file && vma->vm_file->f_mapping &&
> >                                 is_vm_hugetlb_page(vma))
> >                         vm_lock_mapping(mm, vma->vm_file->f_mapping);
>
> Note that multiple VMAs can have the same ->f_mapping, so with this,
> the lock ordering between VMA locks and the mapping locks of hugetlb
> VMAs is mixed: If you have two adjacent hugetlb VMAs with the same
> ->f_mapping, then the following operations happen:
>
> 1. lock VMA 1
> 2. lock mapping of VMAs 1 and 2
> 3. lock VMA 2
> 4. [second vm_lock_mapping() is a no-op]
>
> So for VMA 1, we ended up taking the VMA lock first, but for VMA 2, we
> took the mapping lock first.
>
> The existing code has one loop per lock type to ensure that the locks
> really are taken in the specified order, even when some of the locks
> are associated with multiple VMAs.
>
> If we don't care about the ordering between these two, maybe that's
> fine and you just have to adjust the comment; but it would be clearer
> to add a separate loop for the VMA locks.

Oh, thanks for pointing out this detail. A separate loop is definitely
needed here. Will do that in the next respin.

>
> > @@ -3677,6 +3679,7 @@ void mm_drop_all_locks(struct mm_struct *mm)
> >                 if (vma->vm_file && vma->vm_file->f_mapping)
> >                         vm_unlock_mapping(vma->vm_file->f_mapping);
> >         }
> > +       vma_write_unlock_mm(mm);
> >
> >         mutex_unlock(&mm_all_locks_mutex);
> >  }
> > --
> > 2.39.0
> >
