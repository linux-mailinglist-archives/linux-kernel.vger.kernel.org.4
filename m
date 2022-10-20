Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB286068C7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 21:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiJTTVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 15:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJTTVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 15:21:40 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C871F9A12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 12:21:39 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id f140so491282pfa.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 12:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MGWd55MQb3vBkEb2MC5NHIx5pr8IGRG3XR9906nE3CU=;
        b=TTJYvP8Sy39CMvqQXExyqYeiJNpgGzBuDkgLgRstXGV+u9l2gj387BjJvdJLf+fWSv
         4ZGD3e9nC0Al4r2RCDU6B0nUhjOjRk18sxI7pk23EAFhfUH19TfvJOT+fA0e0nOMYD+F
         IzjquSgkJXdSc+tOjXwF78644ZG8/ygfRc84cV1khJ9mOanhrv1TsQPtlWAFMCRJ5v6j
         CLbO/llDW6moxiJXLyuFfp/zATSiHfozQ0MJ5jsQFBAntZaPTYh6hhtZC/LCyeauaORh
         Tat2v1A4LbYx1XhhKO0McVOcxJ0yGzgcaLQKs2aEPFMMy8yTBDPDwThfCF1wmvGNQMgs
         FGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MGWd55MQb3vBkEb2MC5NHIx5pr8IGRG3XR9906nE3CU=;
        b=ZeSuy9N5trZCC7utBOD35GY4SWoTIBtEN/hb9oAb1k2qS9+oW3fohARSJYJ+W7qGhe
         LIMxqw4FIKRD1SDZTqjWs2CYjGaRA9INQO2IkgA3DGStY1SNfmYNOGZyjqVYFulWtHZE
         5SQNGw2p8fYrdHwhQETubSiUHqLkEooP9ni3/atenfJ2HqI0i6qglP//tqBw6zETd8z8
         CmVDq/uy2XzxTkXWjxUUkKHRGG3ROADxnveO9ZNlaF1o3ff8sw2vmmB11M+zJ5bdaN6q
         XSdEJVxdlqEEeW+VD9mNvYQlFFdP8oSo0IpD1sUleHg+/teHQvecI/pwCljEfjWa+vjD
         RZCg==
X-Gm-Message-State: ACrzQf0mpw5Qq1GzUtzzwNCwqZ6TwPCoiXBtfoD809519EgDaTlrEnco
        FjLfdbIojf5YV6Nu3TO8tc4Sh+E3GlkEn1FdH4s=
X-Google-Smtp-Source: AMsMyM5wM+eGGSaToRccX+wHcPfdv3XLev25laMftlhjjePiHav3A6iPAptZaMvnGH8fQB5fGfLwBG+JS5BnQMQsBeg=
X-Received: by 2002:aa7:9dcb:0:b0:565:89a8:c708 with SMTP id
 g11-20020aa79dcb000000b0056589a8c708mr15721779pfq.4.1666293698956; Thu, 20
 Oct 2022 12:21:38 -0700 (PDT)
MIME-Version: 1.0
References: <cc48dc1e4db8c33289f168cf380ab3641f45f8ad.1666251624.git.baolin.wang@linux.alibaba.com>
 <c44225ae71b1be21e32891e2143044863a0b91b1.1666251624.git.baolin.wang@linux.alibaba.com>
 <87mt9qnbrf.fsf@yhuang6-desk2.ccr.corp.intel.com> <dbfb24e8-e83e-5a70-618e-87e1cebdfe5e@linux.alibaba.com>
In-Reply-To: <dbfb24e8-e83e-5a70-618e-87e1cebdfe5e@linux.alibaba.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 20 Oct 2022 12:21:26 -0700
Message-ID: <CAHbLzkppCJ+Jpjkv6CE=fzufL+-=L=29W_oZc6X=MV9gmu85hA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: migrate: Try again if THP split is failed due to
 page refcnt
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>, akpm@linux-foundation.org,
        david@redhat.com, ziy@nvidia.com, jingshan@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 2:33 AM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 10/20/2022 4:24 PM, Huang, Ying wrote:
> > Baolin Wang <baolin.wang@linux.alibaba.com> writes:
> >
> >> When creating a virtual machine, we will use memfd_create() to get
> >> a file descriptor which can be used to create share memory mappings
> >> using the mmap function, meanwhile the mmap() will set the MAP_POPULATE
> >> flag to allocate physical pages for the virtual machine.
> >>
> >> When allocating physical pages for the guest, the host can fallback to
> >> allocate some CMA pages for the guest when over half of the zone's free
> >> memory is in the CMA area.
> >>
> >> In guest os, when the application wants to do some data transaction with
> >> DMA, our QEMU will call VFIO_IOMMU_MAP_DMA ioctl to do longterm-pin and
> >> create IOMMU mappings for the DMA pages. However, when calling
> >> VFIO_IOMMU_MAP_DMA ioctl to pin the physical pages, we found it will be
> >> failed to longterm-pin sometimes.
> >>
> >> After some invetigation, we found the pages used to do DMA mapping can
> >> contain some CMA pages, and these CMA pages will cause a possible
> >> failure of the longterm-pin, due to failed to migrate the CMA pages.
> >> The reason of migration failure may be temporary reference count or
> >> memory allocation failure. So that will cause the VFIO_IOMMU_MAP_DMA
> >> ioctl returns error, which makes the application failed to start.
> >>
> >> I observed one migration failure case (which is not easy to reproduce) is
> >> that, the 'thp_migration_fail' count is 1 and the 'thp_split_page_failed'
> >> count is also 1.
> >>
> >> That means when migrating a THP which is in CMA area, but can not allocate
> >> a new THP due to memory fragmentation, so it will split the THP. However
> >> THP split is also failed, probably the reason is temporary reference count
> >> of this THP. And the temporary reference count can be caused by dropping
> >> page caches (I observed the drop caches operation in the system), but we
> >> can not drop the shmem page caches due to they are already dirty at that time.
> >>
> >> Especially for THP split failure, which is caused by temporary reference
> >> count, we can try again to mitigate the failure of migration in this case
> >> according to previous discussion [1].
> >
> > Does the patch solved your problem?
>
> The problem is not easy to reproduce and I will test this patch on our
> products. However I think this is a likely case to fail the migration,
> which need to be addressed to mitigate the failure.

You may try to trace all migrations across your fleet (or just pick
some sample machines, this should make data analysis easier) and
filter the migration by reasons, for example, MR_LONGTERM_PIN, then
compare the migration success rate before and after the patch. It
should be a good justification. But it may need some work on data
aggregation, process and analysis, not sure how feasible it is.

>
> >> [1] https://lore.kernel.org/all/470dc638-a300-f261-94b4-e27250e42f96@redhat.com/
> >> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> >> ---
> >>   mm/huge_memory.c |  4 ++--
> >>   mm/migrate.c     | 18 +++++++++++++++---
> >>   2 files changed, 17 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >> index ad17c8d..a79f03b 100644
> >> --- a/mm/huge_memory.c
> >> +++ b/mm/huge_memory.c
> >> @@ -2666,7 +2666,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
> >>       * split PMDs
> >>       */
> >>      if (!can_split_folio(folio, &extra_pins)) {
> >> -            ret = -EBUSY;
> >> +            ret = -EAGAIN;
> >>              goto out_unlock;
> >>      }
> >>
> >> @@ -2716,7 +2716,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
> >>                      xas_unlock(&xas);
> >>              local_irq_enable();
> >>              remap_page(folio, folio_nr_pages(folio));
> >> -            ret = -EBUSY;
> >> +            ret = -EAGAIN;
> >>      }
> >>
> >>   out_unlock:
> >> diff --git a/mm/migrate.c b/mm/migrate.c
> >> index 8e5eb6e..55c7855 100644
> >> --- a/mm/migrate.c
> >> +++ b/mm/migrate.c
> >> @@ -1506,9 +1506,21 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
> >>                              if (is_thp) {
> >>                                      nr_thp_failed++;
> >>                                      /* THP NUMA faulting doesn't split THP to retry. */
> >> -                                    if (!nosplit && !try_split_thp(page, &thp_split_pages)) {
> >> -                                            nr_thp_split++;
> >> -                                            break;
> >> +                                    if (!nosplit) {
> >> +                                            rc = try_split_thp(page, &thp_split_pages);
> >> +                                            if (!rc) {
> >> +                                                    nr_thp_split++;
> >> +                                                    break;
> >> +                                            } else if (reason == MR_LONGTERM_PIN &&
> >> +                                                       rc == -EAGAIN) {
> >
> > In case reason != MR_LONGTERM_PIN, you change the return value of
> > migrate_pages().  So you need to use another variable for return value.
>
> Good catch, will fix in next version. Thanks for your comments.
