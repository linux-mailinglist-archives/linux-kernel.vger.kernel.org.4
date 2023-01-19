Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21EF8674734
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 00:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjASX1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 18:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjASX0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 18:26:54 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870A02311E
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 15:26:52 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id h16so3353682wrz.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 15:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=40LgfDwwqvfjRnUGyNomYpSm1i7JBkT2517SKwFcnxI=;
        b=JVyNF0Wx+eYZBS7lBgkGeULR8ggZpszg8hnyfTKqIUcXmbuJ9AdEJ+M6cd+XTkN2Vk
         QbdElF7jQRG2Myyyd6W4rGJvidTT9p5Cqo58p1hcOOe7cXZ2y81PtSk5i4zzHVeGSxxG
         /XsZF8u5TgSrLTDB+E/wVu7hn7FgJaa6ft0mH3GjyoOSNdqVNgJS7RNtf/XSSpZElNTT
         hl4dMOmLwO2YrfR1YIOn6i130+6AX2L2YEPlSKLH8eX/KP/oHCHCPdEKpwGnHHSdCY2r
         MDsJresiVeeso4U/J2hxIix2CobVNDMu1SoLMgiZ6wLV+b0srb46kmFACELbLiTDC1Wk
         MkOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=40LgfDwwqvfjRnUGyNomYpSm1i7JBkT2517SKwFcnxI=;
        b=uRfKZ7/vVp/DIehUido+vMHvJFuOHpVfnN3cofa9/BH3yMYdDQTxri6OG/Hmj0XQoZ
         UCDoNJprKMq5yDJgXvCvGUugrDhvra6dpgDYtqAQ7J4UQho8h4DN5dg8Q04L1uvmZMup
         dktz+1170Oo56Do2UY5PMbH2jRk4NFW+jHAl4nzJs9qm1BYTsvpnCnzQQOGSUeCepwbP
         nOVOs5dl2dG11a0gLylqDV6ZRmAS/0zAAvJVaPYnckXLdW1tin92IkIGG6IvwJdiLFIz
         6ijmO+Vyp+K1CKUgiKrp4FBznH2dq+o4P3GCx7rnBhF+g0PNAVWBwRqZVvQQ8vB+OT2f
         8YgA==
X-Gm-Message-State: AFqh2koJ06Bh5UKB4XLhbBawLfJLEm/kbfjTTvjBW5hRpxUyGb46tiZW
        GlJLr5XOyP1Xt5mJL0/XxBI7zEOx30rUNO5xKosu9w==
X-Google-Smtp-Source: AMrXdXsD7PC94a50u/hDpg3XcznQNf8nSyRxEQjutmkeiom4nbkewooWrQv+knhx0pEDv8PB9GX9RsnOtcksZLFxHeQ=
X-Received: by 2002:a5d:5184:0:b0:2be:a9e:8686 with SMTP id
 k4-20020a5d5184000000b002be0a9e8686mr734455wrv.664.1674170810901; Thu, 19 Jan
 2023 15:26:50 -0800 (PST)
MIME-Version: 1.0
References: <6548b3b3-30c9-8f64-7d28-8a434e0a0b80@redhat.com>
 <Y8gRpEonhXgqfb41@x1n> <CADrL8HVGMTowH4trJhS+eM_EwZKoUgu7LmfwyTGyGRnNnwL3Zg@mail.gmail.com>
 <Y8hITxr/BBMuO6WX@monkey> <CADrL8HUggALQET-09Zw3BhFjZdw_G9+v6CU=qtGtK=KZ_DeAsw@mail.gmail.com>
 <Y8l+f2wNp2gAjvYg@monkey> <CADrL8HVdL_NMdNq2mEemNCfwkYBAWnbqwyjsAYdQ2fF0iz34Hw@mail.gmail.com>
 <Y8m9gJX4PNoIrpjE@monkey> <Y8nCyqLF71g88Idv@x1n> <CADrL8HXkdxDdixWRKNw6RFdbiBX-Cb1Lk7qxg6LdeNywbMOaOA@mail.gmail.com>
 <Y8nNHKW0sTnrq8hw@x1n>
In-Reply-To: <Y8nNHKW0sTnrq8hw@x1n>
From:   James Houghton <jthoughton@google.com>
Date:   Thu, 19 Jan 2023 15:26:14 -0800
Message-ID: <CADrL8HUvcXn5rjaS+WNt0Gz=1YV7273VVy-o-EdQHSQObuGNkA@mail.gmail.com>
Subject: Re: [PATCH 21/46] hugetlb: use struct hugetlb_pte for walk_hugetlb_range
To:     Peter Xu <peterx@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Thu, Jan 19, 2023 at 3:07 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Jan 19, 2023 at 02:35:12PM -0800, James Houghton wrote:
> > On Thu, Jan 19, 2023 at 2:23 PM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > On Thu, Jan 19, 2023 at 02:00:32PM -0800, Mike Kravetz wrote:
> > > > I do not know much about the (primary) live migration use case.  My
> > > > guess is that page table lock contention may be an issue?  In this use
> > > > case, HGM is only enabled for the duration the live migration operation,
> > > > then a MADV_COLLAPSE is performed.  If contention is likely to be an
> > > > issue during this time, then yes we would need to pass around with
> > > > something like hugetlb_pte.
> > >
> > > I'm not aware of any such contention issue.  IMHO the migration problem is
> > > majorly about being too slow transferring a page being so large.  Shrinking
> > > the page size should resolve the major problem already here IIUC.
> >
> > This will be problematic if you scale up VMs to be quite large.
>
> Do you mean that for the postcopy use case one can leverage e.g. 2M
> mappings (over 1G) to avoid lock contentions when VM is large I agree it
> should be more efficient than having 512 4K page installed, but I think
> it'll make the page fault resolution slower too if some thead is only
> looking for a 4k portion of it.

No, that's not what I meant. Sorry. If you can use the PTL that is
normally used for 4K PTEs, then you're right, there is no contention
problem. However, this PTL is determined by the value of the PMD, so
you need a pointer to the PMD to determine what the PTL should be (or
a pointer to the PTL itself).

In hugetlb, we only ever pass around the PTE pointer, and we rely on
huge_pte_lockptr() to find the PTL for us (and it does so
appropriately for everything except 4K PTEs). We would need to add the
complexity of passing around a PMD or PTL everywhere, and that's what
hugetlb_pte does for us. So that complexity is basically unavoidable,
unless you're ok with 4K PTEs with taking mm->page_table_lock (I'm
not).

>
> > Google upstreamed the "TDP MMU" for KVM/x86 that removed the need to take
> > the MMU lock for writing in the EPT violation path. We found that this
> > change is required for VMs >200 or so vCPUs to consistently avoid CPU
> > soft lockups in the guest.
>
> After the kvm mmu rwlock convertion, it'll allow concurrent page faults
> even if only 4K pages are used, so it seems not directly relevant to what
> we're discussing here, no?

Right. I was just bringing it up to say that if 4K PTLs were
mm->page_table_lock, we would have a problem.

>
> >
> > Requiring each UFFDIO_CONTINUE (in the post-copy path) to serialize on
> > the same PTL would be problematic in the same way.
>
> Pte-level pgtable lock only covers 2M range, so I think it depends on which
> is the address that the vcpu is faulted on?  IIUC the major case should be
> that the faulted threads are not falling upon the same 2M range.

Right. I think my comment should make more sense with the above clarification.

>
> >
> > >
> > > AFAIU 4K-only solution should only reduce any lock contention because locks
> > > will always be pte-level if VM_HUGETLB_HGM set.  When walking and creating
> > > the intermediate pgtable entries we can use atomic ops just like generic
> > > mm, so no lock needed at all.  With uncertainty on the size of mappings,
> > > we'll need to take any of the multiple layers of locks.
> > >
> >
> > Other than taking the HugeTLB VMA lock for reading, walking/allocating
> > page tables won't need any additional locking.
>
> Actually when revisiting the locks I'm getting a bit confused on whether
> the vma lock is needed if pmd sharing is anyway forbidden for HGM.  I
> raised a question in the other patch of MADV_COLLAPSE, maybe they're
> related questions so we can keep it there.

We can discuss there. :) I take both the VMA lock and mapping lock so
that it can stay in sync with huge_pmd_unshare(), and so HGM walks
have the same synchronization as regular hugetlb PT walks.

>
> >
> > We take the PTL to allocate the next level down, but so does generic
> > mm (look at __pud_alloc, __pmd_alloc for example). Maybe I am
> > misunderstanding.
>
> Sorry you're right, please ignore that.  I don't know why I had that
> impression that spinlocks are not needed in that process.
>
> Actually I am also curious why atomics won't work (by holding mmap read
> lock, then do cmpxchg(old_entry=0, new_entry) upon the pgtable entries).  I
> think it's possible I just missed something else.

I think there are cases where we need to make sure the value of a PTE
isn't going to change from under us while we're doing some kind of
other operation, and so a compare-and-swap won't really be what we
need.
