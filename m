Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3E068E4F0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 01:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjBHA0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 19:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBHA0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 19:26:41 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD7EAD3F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 16:26:40 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id p10so18198266vsu.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 16:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1T7/74jCVAc+g57YAgAxUYhK4iJ3pnz2+ZFC3WYkFMg=;
        b=thI4fmZgrbgW0nNxnPtfQEso6w5NRBtwUDXsvrWKp0mRhwHBx9FqpA5sO0TwhpcNrI
         QiZzsEHqNSufX3dbjJpHi14VfSpDWb1mW2U2zWPm462OuwOfx3R0D0OlTvnU1smwhXu4
         96m++oWifVnn7B62x3Die2uJQqZ0UtVHI/Z/gS8muN+AzukmvVxZ1tJ8d9NBU1KEN+gL
         +FORO+C6CL7n5wD/ozJ9aKHS2XlppFNFbR7K4T4hG9w6z01BQVmrTDBQUzpBKQcEFWLw
         uBEkCsfbrGvjnT6bsm5mFqRq+AM+HVW4w78+pM5smI/s4IqgkjiiHJ8HJcoMDnL0Xpya
         3R4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1T7/74jCVAc+g57YAgAxUYhK4iJ3pnz2+ZFC3WYkFMg=;
        b=66bTPomx9a0nBrR6aDE/YwhiCW8J8R9RRkccjNZkB0Xtavqogve2SGSurdDLu5qcZ/
         BGiqfj2J0HYXChvEqKsboXFH6A8R1VhNeNXztiiYiJzgUzjatSyOyBdWDoDJ4dKtJkhG
         f1cW1Tge2fdGJURV5YMlWKlA01182TdbqaIQi8Iaik3YeG2Tft6vMT/WPuMHtOMqmFgl
         BTzSSjeU/7P1LQu6580jm6+1J0i/oKNQyL4PDwTIcRHOSU5c4YG6eK06MHab6HYfY29Q
         Qpf+llf0kCX9cAAhq/hqKTPl4x3o1uGuPu6GI7zKazzk+F4kIHfD8h92nEIlNYIkuqFp
         SssA==
X-Gm-Message-State: AO0yUKXCjjvlTUcIK6uWD4EZKhgSg2Gar+d9hQYM7vfgCUlU2RMgk0mU
        aMMsJIGvHM9nek+TVZMCgIx4VSIAUsB6o3HjSOODEg==
X-Google-Smtp-Source: AK7set/elwIdhkoBY9LPpQUGHPPZY/sW4DrUDovfAxLSzGuA2JGBEI7HfvMMbiI84rvHwqLB5FzHcQjcr0+TUIb/Glg=
X-Received: by 2002:a05:6102:304e:b0:3fc:58d:f90f with SMTP id
 w14-20020a056102304e00b003fc058df90fmr1378566vsa.60.1675815999311; Tue, 07
 Feb 2023 16:26:39 -0800 (PST)
MIME-Version: 1.0
References: <Y9gzOqwKcu7p/PEw@x1n> <CADrL8HXX9YDFUxmPPsm2s3Pno0XXgAyFB40fV1PdtP9eb-5D2A@mail.gmail.com>
 <Y9m/VVRABt0Blfjh@x1n> <CADrL8HXpfTE1+eE3rNGQyOr1QRtDtG5mBp-b3xcNX22QJRvPaQ@mail.gmail.com>
 <Y9qRta3bd4JqjUHx@x1n> <CADrL8HU809O0cPa9hXjf3k+ob139SQqvxOvpqm6UEv=zrPjHSg@mail.gmail.com>
 <Y9re82gctIZf08cX@x1n> <CADrL8HVja_xJ9qczsd-fQfEPvEEXswhXQwoan=a_LSMyORvqww@mail.gmail.com>
 <CADrL8HUSx6=K0QXQtTmv9ZJQmvhe6KEb+FiAviRfO3HjmRUeTw@mail.gmail.com>
 <CADrL8HUm7g4pBLv9vjmB-LhJqxm4jyksGJQAdwRsweKKAnofDg@mail.gmail.com> <Y+LbEY62MT/3yo7I@x1n>
In-Reply-To: <Y+LbEY62MT/3yo7I@x1n>
From:   James Houghton <jthoughton@google.com>
Date:   Tue, 7 Feb 2023 16:26:02 -0800
Message-ID: <CADrL8HUVCXHsaWU7beYQsLw0C7J730PQm45caKE26V8mCFHjKQ@mail.gmail.com>
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

On Tue, Feb 7, 2023 at 3:13 PM Peter Xu <peterx@redhat.com> wrote:
>
> James,
>
> On Tue, Feb 07, 2023 at 02:46:04PM -0800, James Houghton wrote:
> > > Here is the result: [1] (sorry it took a little while heh). The
>
> Thanks.  From what I can tell, that number shows that it'll be great we
> start with your rfcv1 mapcount approach, which mimics what's proposed by
> Matthew for generic folio.

Do you think the RFC v1 way is better than doing the THP-like way
*with the additional MMU notifier*?

>
> > > implementation of the "RFC v1" way is pretty horrible[2] (and this
>
> Any more information on why it's horrible? :)

I figured the code would speak for itself, heh. It's quite complicated.

I really didn't like:
1. The 'inc' business in copy_hugetlb_page_range.
2. How/where I call put_page()/folio_put() to keep the refcount and
mapcount synced up.
3. Having to check the page cache in UFFDIO_CONTINUE.

>
> A quick comment is I'm wondering whether that "whether we should boost the
> mapcount" value can be hidden in hugetlb_pte* so you don't need to pass
> over a lot of bool* deep into the hgm walk routines.

Oh yeah, that's a great idea.

>
> > > implementation probably has bugs anyway; it doesn't account for the
> > > folio_referenced() problem).
>
> I thought we reached a consensus on the resolution, by a proposal to remove
> folio_referenced_arg.mapcount.  Is it not working for some reason?

I think that works, I just didn't bother here. I just wanted to show
you approximately what it would look like to implement the RFC v1
approach.

>
> > >
> > > Matthew is trying to solve the same problem with THPs right now: [3].
> > > I haven't figured out how we can apply Matthews's approach to HGM
> > > right now, but there probably is a way. (If we left the mapcount
> > > increment bits in the same place, we couldn't just check the
> > > hstate-level PTE; it would have already been made present.)
>
> I'm just worried that (1) this may add yet another dependency to your work
> which is still during discussion phase, and (2) whether the folio approach
> is easily applicable here, e.g., we may not want to populate all the ptes
> for hugetlb HGMs by default.

That's true. I definitely don't want to wait for this either. It seems
like Matthew's approach won't work very well for us -- when doing a
lot of high-granularity UFFDIO_CONTINUEs on a 1G page, checking all
the PTEs to see if any of them are mapped would get really slow.

>
> > >
> > > We could:
> > > - use the THP-like way and tolerate ~1 second collapses
> >
> > Another thought here. We don't necessarily *need* to collapse the page
> > table mappings in between mmu_notifier_invalidate_range_start() and
> > mmu_notifier_invalidate_range_end(), as the pfns aren't changing,
> > we aren't punching any holes, and we aren't changing permission bits.
> > If we had an MMU notifier that simply informed KVM that we collapsed
> > the page tables *after* we finished collapsing, then it would be ok
> > for hugetlb_collapse() to be slow.
>
> That's a great point!  It'll definitely apply to either approach.
>
> >
> > If this MMU notifier is something that makes sense, it probably
> > applies to MADV_COLLAPSE for THPs as well.
>
> THPs are definitely different, mmu notifiers should be required there,
> afaict.  Isn't that what the current code does?
>
> See collapse_and_free_pmd() for shmem and collapse_huge_page() for anon.

Oh, yes, of course, MADV_COLLAPSE can actually move things around and
properly make THPs. Thanks. But it would apply if we were only
collapsing PTE-mapped THPs, I think?


- James
