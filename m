Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2842D63C65C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 18:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236592AbiK2RXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 12:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235987AbiK2RXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 12:23:21 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6379686AD
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 09:23:20 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id ns17so6491188pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 09:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u9yTJMGnmqe1ocfWJaFwIJrFk9X2tNjSo/XyqrEyYTg=;
        b=NVAAIrOm+zwhwAynH4tmwyAJDzvlUYizLXYBektwykRzEZ8ornpx9Y1h+cAltGYSLa
         EH0GRdXMKm1U3UABCWyfNANg0e6kpRBepsqJERzIfRXbXc0yJ//dMbqVZC57iaPphEug
         naAicUgU1HyCVFoxsELNPD+o2xFXmnrKZq3ryabT3rdvG79uDl5T81/fsuTnJaOcelGt
         7DDuJR2EBGojKe0qOGs8xN2k7Sa7FHqi4YGaOCjGtPD6dayM22FnTFh7sp7jldhQx8Bt
         cmrkBUT6L/2b5kvbwKHeDP/1tj+25OwV3y1pRKG+TKeBdLaCVwB3GEsn+SGL/SSWkqvy
         W5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u9yTJMGnmqe1ocfWJaFwIJrFk9X2tNjSo/XyqrEyYTg=;
        b=dssLUIfV4rt+4cLgTS8a0yWFapBsmjkxGjc1E72OUk/0rcr+wGWIZrU5oYEseU7EQX
         mVicfW4FhAnxCrBiyEBKuG1vtwdsalaOJzW2UykcoJjrEXcOaYmS4aYUj2g1edSfcu8h
         cmpNX1kcKTcOvst5RIa5XkT9ITLrN0vtW2Q9fDWvo3YFSxkmsjecXLeP2eEdzjo/vl3f
         0dVxGdJEFH8ecGIT9pSXgO/Hr++WghYhhG/ea7YhcKtwJVVly9YWbMD0fRCdw9WfXiS4
         tJIVhcAsUibJbI/Wj7qAHPH0H0voI3oxu8UEMNz3edaUexstNI2BGkF3plXlXp4NMsrJ
         8rHQ==
X-Gm-Message-State: ANoB5plwtf2rrR1kZoWvWvnY1IXMIWcw8sCBLZznkQwhmWgsiQjNZsjP
        BgAhirGBBWg+A/h9lYn+iqNVrCfQP2BdvpimDAQ=
X-Google-Smtp-Source: AA0mqf5TgaOtnh6ZD+VZ+Y2+ooxF3sLbJ8NQpWTrM/UdV9o/8xW0FUwnbSE7bNNiqCto4rmu6ijGBu3v5aKU0BVDhBo=
X-Received: by 2002:a17:903:258f:b0:189:754b:9d9e with SMTP id
 jb15-20020a170903258f00b00189754b9d9emr18087055plb.119.1669742600312; Tue, 29
 Nov 2022 09:23:20 -0800 (PST)
MIME-Version: 1.0
References: <8a2f2644-71d0-05d7-49d8-878aafa99652@huawei.com>
 <CAHbLzkr-eXk8gateN=EmMoBuW3wxoQKTCfJcTRQsQX3QxD+CmA@mail.gmail.com> <6b7142cf-386e-e1d2-a122-b923337a593e@huawei.com>
In-Reply-To: <6b7142cf-386e-e1d2-a122-b923337a593e@huawei.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 29 Nov 2022 09:23:08 -0800
Message-ID: <CAHbLzkpENMxuPQdHyehR_kMO8msAbGtHC+N=VD0eE7Nkeo799Q@mail.gmail.com>
Subject: Re: [QUESTION] memcg page_counter seems broken in MADV_DONTNEED with
 THP enabled
To:     Yongqiang Liu <liuyongqiang13@huawei.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        aarcange@redhat.com, hughd@google.com, mgorman@suse.de,
        mhocko@suse.cz, cl@gentwo.org, zokeefe@google.com,
        rientjes@google.com, Matthew Wilcox <willy@infradead.org>,
        peterx@redhat.com,
        "Wangkefeng (OS Kernel Lab)" <wangkefeng.wang@huawei.com>,
        "zhangxiaoxu (A)" <zhangxiaoxu5@huawei.com>,
        kirill.shutemov@linux.intel.com, Lu Jialin <lujialin4@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 5:14 AM Yongqiang Liu <liuyongqiang13@huawei.com> w=
rote:
>
>
> =E5=9C=A8 2022/11/29 4:01, Yang Shi =E5=86=99=E9=81=93:
> > On Sat, Nov 26, 2022 at 5:10 AM Yongqiang Liu <liuyongqiang13@huawei.co=
m> wrote:
> >> Hi,
> >>
> >> We use mm_counter to how much a process physical memory used. Meanwhil=
e,
> >> page_counter of a memcg is used to count how much a cgroup physical
> >> memory used.
> >> If a cgroup only contains a process, they looks almost the same. But w=
ith
> >> THP enabled, sometimes memory.usage_in_bytes in memcg may be twice or
> >> more than rss
> >> in proc/[pid]/smaps_rollup as follow:
> >>
> >> [root@localhost sda]# cat /sys/fs/cgroup/memory/test/memory.usage_in_b=
ytes
> >> 1080930304
> >> [root@localhost sda]# cat /sys/fs/cgroup/memory/test/cgroup.procs
> >> 1290
> >> [root@localhost sda]# cat /proc/1290/smaps_rollup
> >> 55ba80600000-ffffffffff601000 ---p 00000000 00:00 0
> >> [rollup]
> >> Rss:              500648 kB
> >> Pss:              498337 kB
> >> Shared_Clean:       2732 kB
> >> Shared_Dirty:          0 kB
> >> Private_Clean:       364 kB
> >> Private_Dirty:    497552 kB
> >> Referenced:       500648 kB
> >> Anonymous:        492016 kB
> >> LazyFree:              0 kB
> >> AnonHugePages:    129024 kB
> >> ShmemPmdMapped:        0 kB
> >> Shared_Hugetlb:        0 kB
> >> Private_Hugetlb:       0 kB
> >> Swap:                  0 kB
> >> SwapPss:               0 kB
> >> Locked:                0 kB
> >> THPeligible:    0
> >>
> >> I have found the differences was because that __split_huge_pmd decreas=
e
> >> the mm_counter but page_counter in memcg was not decreased with refcou=
nt
> >> of a head page is not zero. Here are the follows:
> >>
> >> do_madvise
> >>     madvise_dontneed_free
> >>       zap_page_range
> >>         unmap_single_vma
> >>           zap_pud_range
> >>             zap_pmd_range
> >>               __split_huge_pmd
> >>                 __split_huge_pmd_locked
> >>                   __mod_lruvec_page_state
> >>               zap_pte_range
> >>                  add_mm_rss_vec
> >>                     add_mm_counter                    -> decrease the
> >> mm_counter
> >>         tlb_finish_mmu
> >>           arch_tlb_finish_mmu
> >>             tlb_flush_mmu_free
> >>               free_pages_and_swap_cache
> >>                 release_pages
> >>                   folio_put_testzero(page)            -> not zero, ski=
p
> >>                     continue;
> >>                   __folio_put_large
> >>                     free_transhuge_page
> >>                       free_compound_page
> >>                         mem_cgroup_uncharge
> >>                           page_counter_uncharge        -> decrease the
> >> page_counter
> >>
> >> node_page_stat which shows in meminfo was also decreased. the
> >> __split_huge_pmd
> >> seems free no physical memory unless the total THP was free.I am
> >> confused which
> >> one is the true physical memory used of a process.
> > This should be caused by the deferred split of THP. When MADV_DONTNEED
> > is called on the partial of the map, the huge PMD is split, but the
> > THP itself will not be split until the memory pressure is hit (global
> > or memcg limit). So the unmapped sub pages are actually not freed
> > until that point. So the mm counter is decreased due to the zapping
> > but the physical pages are not actually freed then uncharged from
> > memcg.
>
> Thanks!
>
> I don't know how much memory a real workload will cost.So I just
>
> test the max_usage_in_bytes of memcg with THP disabled and add a little b=
it
>
> more for the limit_in_byte of memcg with THP enabled which trigger a oom.=
..
>
> (actually it costed 100M more with THP enabled). Another testcase which I
>
> known the amout of memory will cost don't trigger a oom with suitable
>
> memcg limit  and I see the THP split when the memory hit the limit.
>
>
> I have another concern that k8s usually use (rss - files) to estimate

Do you mean "workingset" used by some 3rd party k8s monitoring tools?
I recall that depends on what monitoring tools you use, for example,
some monitoring use active_anon + active_file.

>
> the memory workload but the anon_thp in the defered list charged
>
> in memcg will make it look higher than actucal. And it seems the

Yes, but the deferred split shrinker should handle this quite gracefully.

>
> container will be killed without oom...

If you have some userspace daemons which monitor the memory usage by
rss, and try to behave smarter to kill the container by looking at rss
solely, you may kill the container prematurely.

>
> Is it suitable to add meminfo of a deferred split list of THP?

We could, but I don't think of how it will be used to improve the
usecase. Any more thoughts?

>
> >>
> >> Kind regards,
> >>
> >> Yongqiang Liu
> >>
> >>
> > .
