Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8B06539FC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 01:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbiLVADN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 19:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbiLVADK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 19:03:10 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13526250
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 16:03:06 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id m19so298309wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 16:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CNllVDs9Qyhjp9PrGXopMtZh54uW9rQgSBY6Q9L2kGM=;
        b=KVTlayKDPZKGej0slx668biCWYZUYUsP+/RgpAhC2dIBXYGLL6Xd42VmnNCQnGKiN0
         Ti8xztY7NPvLlDfKn0x/7x2HAnggy40U6Gg3LBRAd+jOxoK9a01MUVjDqh6WynYznAGx
         dkgzgyw9Qlhn7zwBzmQTyMesRW9h6RschShSkXd7eZggM9gS4Dc9xwFitMzt0I/tMCaB
         +/stG9omqsAFsEQeEQ1EDjVkMeBaI6d+0dbtvCWKXICg1Aga1fOOoGgsfpJovSrRPVzS
         qFZT+kq9e+RuVHPF8L0O9vMvV3UaI6gHZAcSchK2/s3NI+A/g5zeXchck6u7iPKwuc6s
         7vTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CNllVDs9Qyhjp9PrGXopMtZh54uW9rQgSBY6Q9L2kGM=;
        b=YPYVWOrFPjHY/kjFhFeLoaPXjN4igXg++JflI7qf79lSvN3LHlmn7i3y9UkRjaIEAQ
         QZglAQd7FlNiZOwsShtSK997hPocufV+krtWQ5GndtxFkTUn/Tgq5+7xwqcOvdscc66m
         /5e6s8S2m0gfJe352esLsrw0l6fDGIrZ9MnUWtKhOpP2qAEMp7LLHa9ishelk9rkqbVW
         2+o/+dzvYGcm9xTbXRLqQ8DqzF0hi/deIPjGQ71hXpbZd3AH8PmXxhyizGr5jhDVR+jX
         5sUbp9xIXyZg8KPlmvxe9NxXa7pVBhN2zDPVDs5M8sg0B/ghnlIGXoy36dmiCEigYBU5
         XdWQ==
X-Gm-Message-State: AFqh2krqd4F2jjR47fBb0P6NFHhvJUrIy3GFizqNXtaPDVjaNtEsyLAO
        mrdQdhOHcXsMHpeLFvIdbECR53GZnELIJMx8ZkQ3wA==
X-Google-Smtp-Source: AMrXdXssMeuEThAwiuA/nPhG8lWMTjYmTl90S+idsxGr6PF4pZQDqXoK9RYeSpQC0LZxyoBXCnn2H7m8lujbtZfJMgk=
X-Received: by 2002:a1c:1901:0:b0:3cf:878c:6555 with SMTP id
 1-20020a1c1901000000b003cf878c6555mr291926wmz.38.1671667385359; Wed, 21 Dec
 2022 16:03:05 -0800 (PST)
MIME-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-34-jthoughton@google.com> <Y3VkIdVKRuq+fO0N@x1n>
 <CADrL8HXixUPyTVmYMiwc11Ot5sDMsA3x7VhgXQjimJ93MSZihA@mail.gmail.com>
 <Y6NdN2ADVCcK70ym@x1n> <CADrL8HXqE3s4ckxh0OU5onkhystj=1jMTS+S7GFeiO+kwBo0QQ@mail.gmail.com>
 <Y6N9G0Y2j98V8Pnz@monkey> <Y6OEQB3dLSa083F6@x1n> <Y6OJUtVkvdptEgW7@monkey>
In-Reply-To: <Y6OJUtVkvdptEgW7@monkey>
From:   James Houghton <jthoughton@google.com>
Date:   Wed, 21 Dec 2022 19:02:53 -0500
Message-ID: <CADrL8HX997CguZWkH3vB4+cYjwLc0mYV4GkroE41bCLRqFiPpg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 33/47] userfaultfd: add UFFD_FEATURE_MINOR_HUGETLBFS_HGM
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Peter Xu <peterx@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
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

On Wed, Dec 21, 2022 at 5:32 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 12/21/22 17:10, Peter Xu wrote:
> > On Wed, Dec 21, 2022 at 01:39:39PM -0800, Mike Kravetz wrote:
> > > On 12/21/22 15:21, James Houghton wrote:
> > > > Thanks for bringing this up, Peter. I think the main reason was:
> > > > having separate UFFD_FEATUREs clearly indicates to userspace what is
> > > > and is not supported.
> > >
> > > IIRC, I think we wanted to initially limit the usage to the very
> > > specific use case (live migration).  The idea is that we could then
> > > expand usage as more use cases came to light.
> > >
> > > Another good thing is that userfaultfd has versioning built into the
> > > API.  Thus a user can determine if HGM is enabled in their running
> > > kernel.
> >
> > I don't worry much on this one, afaiu if we have any way to enable hgm then
> > the user can just try enabling it on a test vma, just like when an app
> > wants to detect whether a new madvise() is present on the current host OS.

That would be enough to test if HGM was merely present, but if
specific features like 4K UFFDIO_CONTINUEs or 4K UFFDIO_WRITEPROTECTs
were available. You could always check these by making a HugeTLB VMA
and setting it up correctly for userfaultfd/etc., but that's a little
messy.

> >
> > Besides, I'm wondering whether something like /sys/kernel/vm/hugepages/hgm
> > would work too.

I'm not opposed to this.

> >
> > >
> > > > For UFFDIO_WRITEPROTECT, a user could remap huge pages into smaller
> > > > pages by issuing a high-granularity UFFDIO_WRITEPROTECT. That isn't
> > > > allowed as of this patch series, but it could be allowed in the
> > > > future. To add support in the same way as this series, we would add
> > > > another feature, say UFFD_FEATURE_WP_HUGETLBFS_HGM. I agree that
> > > > having to add another feature isn't great; is this what you're
> > > > concerned about?
> > > >
> > > > Considering MADV_ENABLE_HUGETLB...
> > > > 1. If a user provides this, then the contract becomes: "the kernel may
> > > > allow UFFDIO_CONTINUE and UFFDIO_WRITEPROTECT for HugeTLB at
> > > > high-granularities, provided the support exists", but it becomes
> > > > unclear to userspace to know what's supported and what isn't.
> > > > 2. We would then need to keep track if a user explicitly enabled it,
> > > > or if it got enabled automatically in response to memory poison, for
> > > > example. Not a big problem, just a complication. (Otherwise, if HGM
> > > > got enabled for poison, suddenly userspace would be allowed to do
> > > > things it wasn't allowed to do before.)
> >
> > We could alternatively have two flags for each vma: (a) hgm_advised and (b)
> > hgm_enabled.  (a) always sets (b) but not vice versa.  We can limit poison
> > to set (b) only.  For this patchset, it can be all about (a).

My thoughts exactly. :)

> >
> > > > 3. This API makes sense for enabling HGM for something outside of
> > > > userfaultfd, like MADV_DONTNEED.
> > >
> > > I think #3 is key here.  Once we start applying HGM to things outside
> > > userfaultfd, then more thought will be required on APIs.  The API is
> > > somewhat limited by design until the basic functionality is in place.
> >
> > Mike, could you elaborate what's the major concern of having hgm used
> > outside uffd and live migration use cases?
> >
> > I feel like I miss something here.  I can understand we want to limit the
> > usage only when the user specifies using hgm because we want to keep the
> > old behavior intact.  However if we want another way to enable hgm it'll
> > still need one knob anyway even outside uffd, and I thought that'll service
> > the same purpose, or maybe not?
>
> I am not opposed to using hgm outside the use cases targeted by this series.
>
> It seems that when we were previously discussing the API we spent a bunch of
> time going around in circles trying to get the API correct.  That is expected
> as it is more difficult to take all users/uses/abuses of the API into account.
>
> Since the initial use case was fairly limited, it seemed like a good idea to
> limit the API to userfaultfd.  In this way we could focus on the underlying
> code/implementation and then expand as needed.  Of course, with an eye on
> anything that may be a limiting factor in the future.
>
> I was not aware of the uffd-wp use case, and am more than happy to discuss
> expanding the API.

So considering two API choices:

1. What we have now: UFFD_FEATURE_MINOR_HUGETLBFS_HGM for
UFFDIO_CONTINUE, and later UFFD_FEATURE_WP_HUGETLBFS_HGM for
UFFDIO_WRITEPROTECT. For MADV_DONTNEED, we could just suddenly start
allowing high-granularity choices (not sure if this is bad; we started
allowing it for HugeTLB recently with no other API change, AFAIA).

2. MADV_ENABLE_HGM or something similar. The changes to
UFFDIO_CONTINUE/UFFDIO_WRITEPROTECT/MADV_DONTNEED come automatically,
provided they are implemented.

I don't mind one way or the other. Peter, I assume you prefer #2.
Mike, what about you? If we decide on something other than #1, I'll
make the change before sending v1 out.

- James
