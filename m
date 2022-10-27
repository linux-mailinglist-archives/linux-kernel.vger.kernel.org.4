Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B7B6104DF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 23:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237119AbiJ0V4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 17:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbiJ0Vz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 17:55:58 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603C08E718;
        Thu, 27 Oct 2022 14:55:57 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id t25so8536108ejb.8;
        Thu, 27 Oct 2022 14:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NBF9nN1amKjoEJYkIjpsAIirOQycb1TH6Xv8hrGX720=;
        b=mDkvDqdAij8U7APRP9yt0MpP0X4VRBno0CXMoN30kyF44cwwyG6SWPi0RMmgixT3Bt
         gDGI3NQdLQgzAOkEJRsHlv30WGUJ2hQblLeSpwcJ5STMlX4u4j8a3tQV2KR2m0LIQzBm
         AQJ503ah+Ml5VjRZNjjXGPE/NDYPCFMXA8zgjE5t0SVsx9Hw9IWLWZ3AMAqfOZwZ+V+e
         qYuMVsdT8DFxXyS63KjEsQME+nw+FVWDILA1TQjyCKoVJwx1GB6oAfX2SEHxx6BUkppp
         FRbFNc1nFH6dDsPv8S53kFNtYm8nzlkRSUmQ01A3lEAB9LpF+C23K7NNIPQTDmTy9HCd
         Qzng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NBF9nN1amKjoEJYkIjpsAIirOQycb1TH6Xv8hrGX720=;
        b=6BVG8AZlvHBdNfDuq3y0z0cB4b1Wz77p1Qw9M60GA2NEmU3KgTPr2ySvQQHz7shLSp
         c7/7/4S7F/XYaHq+sDa85+TCuzKNUuspSDKOczKSArB/GAhRVU3TpQeeiKyT5asUY3HD
         IBPVGA+822LvOWeul5Rk7bpegwv4o3zFHUps2GE8xf4tgwQxpgozAEL5tT3m0hCpZhIE
         RCt1nl74uaaac8dywy+LwjBWlv3VyYuIr9P0mv2K0dAzo9pWXgQ3rjx8rzm4QwOk4E3M
         tkWsvgIVTHQY1SmkihR84tviWtfpvldiUCXeBrbBBGGOJDcLyK/jc8gbZQREJiWX6gpc
         60KA==
X-Gm-Message-State: ACrzQf3oqve7tszSgB1J/9Vf7QOWwXmlx46uMoffqRrJHQsZXqAEVGxP
        VaOO3lBr+QoJl6MaDDecDaOSFd5IzH1CT8+lKUU=
X-Google-Smtp-Source: AMsMyM6xp5XG883Sfz6qxUaX5+gPHPonCP4MPn0vbsj6Bzy6ERW5G8ermHkmXVNLJ97zdVUdhxlu0w7L/DMiIXxWfLY=
X-Received: by 2002:a17:906:8442:b0:7ad:960b:ef61 with SMTP id
 e2-20020a170906844200b007ad960bef61mr2610486ejy.702.1666907755828; Thu, 27
 Oct 2022 14:55:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220921084302.43631-1-yangyicong@huawei.com> <20220921084302.43631-3-yangyicong@huawei.com>
 <168eac93-a6ee-0b2e-12bb-4222eff24561@arm.com> <8e391962-4e3a-5a56-64b4-78e8637e3b8c@huawei.com>
 <CAGsJ_4z=dZbrAUD9jczT08S3qi_ep-h+EK35UfayVk1S+Cnp2A@mail.gmail.com>
 <ecd161db-b290-7997-a81e-a0a00bd1c599@arm.com> <87o7tx5oyx.fsf@stealth>
In-Reply-To: <87o7tx5oyx.fsf@stealth>
From:   Barry Song <21cnbao@gmail.com>
Date:   Fri, 28 Oct 2022 10:55:42 +1300
Message-ID: <CAGsJ_4zrGfPYAXGW0g3Z-GF4vT7GD0xDjZn1dv-qruztEQTghg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] arm64: support batched/deferred tlb shootdown
 during page reclamation
To:     Punit Agrawal <punit.agrawal@bytedance.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Yicong Yang <yangyicong@huawei.com>, yangyicong@hisilicon.com,
        corbet@lwn.net, peterz@infradead.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, darren@os.amperecomputing.com,
        huzhanyuan@oppo.com, lipeifeng@oppo.com, zhangshiming@oppo.com,
        guojian@oppo.com, realmz6@gmail.com, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linux-mm@kvack.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        wangkefeng.wang@huawei.com, xhao@linux.alibaba.com,
        prime.zeng@hisilicon.com, Barry Song <v-songbaohua@oppo.com>,
        Nadav Amit <namit@vmware.com>, Mel Gorman <mgorman@suse.de>,
        catalin.marinas@arm.com, will@kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 3:19 AM Punit Agrawal
<punit.agrawal@bytedance.com> wrote:
>
>
> [ Apologies for chiming in late in the conversation ]
>
> Anshuman Khandual <anshuman.khandual@arm.com> writes:
>
> > On 9/28/22 05:53, Barry Song wrote:
> >> On Tue, Sep 27, 2022 at 10:15 PM Yicong Yang <yangyicong@huawei.com> wrote:
> >>>
> >>> On 2022/9/27 14:16, Anshuman Khandual wrote:
> >>>> [...]
> >>>>
> >>>> On 9/21/22 14:13, Yicong Yang wrote:
> >>>>> +static inline bool arch_tlbbatch_should_defer(struct mm_struct *mm)
> >>>>> +{
> >>>>> +    /* for small systems with small number of CPUs, TLB shootdown is cheap */
> >>>>> +    if (num_online_cpus() <= 4)
> >>>>
> >>>> It would be great to have some more inputs from others, whether 4 (which should
> >>>> to be codified into a macro e.g ARM64_NR_CPU_DEFERRED_TLB, or something similar)
> >>>> is optimal for an wide range of arm64 platforms.
> >>>>
> >>
> >> I have tested it on a 4-cpus and 8-cpus machine. but i have no machine
> >> with 5,6,7
> >> cores.
> >> I saw improvement on 8-cpus machines and I found 4-cpus machines don't need
> >> this patch.
> >>
> >> so it seems safe to have
> >> if (num_online_cpus()  < 8)
> >>
> >>>
> >>> Do you prefer this macro to be static or make it configurable through kconfig then
> >>> different platforms can make choice based on their own situations? It maybe hard to
> >>> test on all the arm64 platforms.
> >>
> >> Maybe we can have this default enabled on machines with 8 and more cpus and
> >> provide a tlbflush_batched = on or off to allow users enable or
> >> disable it according
> >> to their hardware and products. Similar example: rodata=on or off.
> >
> > No, sounds bit excessive. Kernel command line options should not be added
> > for every possible run time switch options.
> >
> >>
> >> Hi Anshuman, Will,  Catalin, Andrew,
> >> what do you think about this approach?
> >>
> >> BTW, haoxin mentioned another important user scenarios for tlb bach on arm64:
> >> https://lore.kernel.org/lkml/393d6318-aa38-01ed-6ad8-f9eac89bf0fc@linux.alibaba.com/
> >>
> >> I do believe we need it based on the expensive cost of tlb shootdown in arm64
> >> even by hardware broadcast.
> >
> > Alright, for now could we enable ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH selectively
> > with CONFIG_EXPERT and for num_online_cpus()  > 8 ?
>
> When running the test program in the commit in a VM, I saw benefits from
> the patches at all sizes from 2, 4, 8, 32 vcpus. On the test machine,
> ptep_clear_flush() went from ~1% in the unpatched version to not showing
> up.
>
> Yicong mentioned that he didn't see any benefit for <= 4 CPUs but is
> there any overhead? I am wondering what are the downsides of enabling
> the config by default.

As we are deferring tlb flush, but sometimes while we are modifying the vma
which are deferred, we need to do a sync by flush_tlb_batched_pending() in
mprotect() , madvise() to make sure they can see the flushed result. if nobody
is doing mprotect(), madvise() etc in the deferred period, the overhead is zero.

>
> Thanks,
> Punit

Thanks
Barry
