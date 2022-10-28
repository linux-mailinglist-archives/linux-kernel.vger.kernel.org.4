Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3F6611C81
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 23:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiJ1Vka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 17:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiJ1Vk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 17:40:27 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F6110D6A8;
        Fri, 28 Oct 2022 14:40:25 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id l11so8511702edb.4;
        Fri, 28 Oct 2022 14:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F9RrxUZJauba3tX3ZE6+TwL/IhjYDGu0yvNBASjmvvg=;
        b=DDqlitA/aZVBQxso46/Iv2q/qaCkZ5lo3I8GWq1a8re4mIEroveoDgzrRxpMlppt9u
         0KVqnFkXh59kEX6GswJHjBKN6I/iBoKjQUt8v2cQc22yymdzv7rCq4PYKUk0rkmHvySs
         VB0dqoVUFiWfCZpbLiSIySOUfp7O4BPAXS42ILfvdsUEMDFViM+qOE08A7vEhIPdZGGS
         fEyj4speB2Yk69V2CD2MN9IE5/dU7lHv7Z7Gvh3tzYP21dZke6ipgNWt7ndcMxeZIsER
         FcDNzWfC8ydsRNLz0i/dUDDu+ZNKpy+cZuN88qNTy2T0wRzqeDY9F0bCcgcENkhZ7389
         PyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F9RrxUZJauba3tX3ZE6+TwL/IhjYDGu0yvNBASjmvvg=;
        b=bYeFx9cags0R+j2VSm4hEzLocl2bUccFZnKij401sWiGoHqN5sDGrMTeu2tpcSpnqN
         EG4YFCBSlvg8xrEF591l1yRjBMJ5Kf+PhuLcxFmE9S3iIRFP3TVb/vm/f4cXPXweXRJP
         CBi8QiOn+UhjtFOBUe8lFAUL26AAbTsfuDhb+gbA2q7hqBeHT3HlovHfmeXfQzhGSbrw
         +714agvBYlsWag4V7ThGyGnLazN9gNl9NkFCvQUlC6ImlLo6KW1JHqFnMC0AMLbJsADp
         3CNBMpDISza7k2YUP6kkIOCQNWPyOy+cqKHQ4nj1cDBSsp0KDm7rNav1BbTqFnyiG88I
         BS9Q==
X-Gm-Message-State: ACrzQf04InyKD0ZPQJldYZG3wjh6Huyli8HG17cm1O+x75oiTQcy/o3o
        J1RckB6vH7aZY/Fs0EFrYd1B/yvCDrVMhqa07/gs4nSoLRvK4ScV
X-Google-Smtp-Source: AMsMyM6UDRzIvlNjYKY0c4hyt+nkhmalBHjieXw4tVuo5TgPqmtCi4sFsVHsHu+LH6Z1/MXVj9DUPehnJMCJxo9Pco4=
X-Received: by 2002:aa7:d744:0:b0:45c:e353:e891 with SMTP id
 a4-20020aa7d744000000b0045ce353e891mr1485536eds.36.1666993223904; Fri, 28 Oct
 2022 14:40:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220921084302.43631-1-yangyicong@huawei.com> <20220921084302.43631-3-yangyicong@huawei.com>
 <168eac93-a6ee-0b2e-12bb-4222eff24561@arm.com> <8e391962-4e3a-5a56-64b4-78e8637e3b8c@huawei.com>
 <CAGsJ_4z=dZbrAUD9jczT08S3qi_ep-h+EK35UfayVk1S+Cnp2A@mail.gmail.com>
 <ecd161db-b290-7997-a81e-a0a00bd1c599@arm.com> <87o7tx5oyx.fsf@stealth>
 <bc44cf85-aee9-03ca-9911-dbd904a43cc8@huawei.com> <87bkpw5bzm.fsf@stealth>
In-Reply-To: <87bkpw5bzm.fsf@stealth>
From:   Barry Song <21cnbao@gmail.com>
Date:   Sat, 29 Oct 2022 10:40:11 +1300
Message-ID: <CAGsJ_4xj2fKLOEHYC46P8ZhUPX8rw=yTNv3Zs=CPxLON6Xxvqw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] arm64: support batched/deferred tlb shootdown
 during page reclamation
To:     Punit Agrawal <punit.agrawal@bytedance.com>
Cc:     Yicong Yang <yangyicong@huawei.com>, yangyicong@hisilicon.com,
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
        catalin.marinas@arm.com, will@kernel.org,
        linux-doc@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
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

On Sat, Oct 29, 2022 at 2:11 AM Punit Agrawal
<punit.agrawal@bytedance.com> wrote:
>
> Yicong Yang <yangyicong@huawei.com> writes:
>
> > On 2022/10/27 22:19, Punit Agrawal wrote:
> >>
> >> [ Apologies for chiming in late in the conversation ]
> >>
> >> Anshuman Khandual <anshuman.khandual@arm.com> writes:
> >>
> >>> On 9/28/22 05:53, Barry Song wrote:
> >>>> On Tue, Sep 27, 2022 at 10:15 PM Yicong Yang <yangyicong@huawei.com> wrote:
> >>>>>
> >>>>> On 2022/9/27 14:16, Anshuman Khandual wrote:
> >>>>>> [...]
> >>>>>>
> >>>>>> On 9/21/22 14:13, Yicong Yang wrote:
> >>>>>>> +static inline bool arch_tlbbatch_should_defer(struct mm_struct *mm)
> >>>>>>> +{
> >>>>>>> +    /* for small systems with small number of CPUs, TLB shootdown is cheap */
> >>>>>>> +    if (num_online_cpus() <= 4)
> >>>>>>
> >>>>>> It would be great to have some more inputs from others, whether 4 (which should
> >>>>>> to be codified into a macro e.g ARM64_NR_CPU_DEFERRED_TLB, or something similar)
> >>>>>> is optimal for an wide range of arm64 platforms.
> >>>>>>
> >>>>
> >>>> I have tested it on a 4-cpus and 8-cpus machine. but i have no machine
> >>>> with 5,6,7
> >>>> cores.
> >>>> I saw improvement on 8-cpus machines and I found 4-cpus machines don't need
> >>>> this patch.
> >>>>
> >>>> so it seems safe to have
> >>>> if (num_online_cpus()  < 8)
> >>>>
> >>>>>
> >>>>> Do you prefer this macro to be static or make it configurable through kconfig then
> >>>>> different platforms can make choice based on their own situations? It maybe hard to
> >>>>> test on all the arm64 platforms.
> >>>>
> >>>> Maybe we can have this default enabled on machines with 8 and more cpus and
> >>>> provide a tlbflush_batched = on or off to allow users enable or
> >>>> disable it according
> >>>> to their hardware and products. Similar example: rodata=on or off.
> >>>
> >>> No, sounds bit excessive. Kernel command line options should not be added
> >>> for every possible run time switch options.
> >>>
> >>>>
> >>>> Hi Anshuman, Will,  Catalin, Andrew,
> >>>> what do you think about this approach?
> >>>>
> >>>> BTW, haoxin mentioned another important user scenarios for tlb bach on arm64:
> >>>> https://lore.kernel.org/lkml/393d6318-aa38-01ed-6ad8-f9eac89bf0fc@linux.alibaba.com/
> >>>>
> >>>> I do believe we need it based on the expensive cost of tlb shootdown in arm64
> >>>> even by hardware broadcast.
> >>>
> >>> Alright, for now could we enable ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH selectively
> >>> with CONFIG_EXPERT and for num_online_cpus()  > 8 ?
> >>
> >> When running the test program in the commit in a VM, I saw benefits from
> >> the patches at all sizes from 2, 4, 8, 32 vcpus. On the test machine,
> >> ptep_clear_flush() went from ~1% in the unpatched version to not showing
> >> up.
> >>
> >
> > Maybe you're booting VM on a server with more than 32 cores and Barry tested
> > on his 4 CPUs embedded platform. I guess a 4 CPU VM is not fully equivalent to
> > a 4 CPU real machine as the tbli and dsb in the VM may influence the host
> > as well.
>
> Yeah, I also wondered about this.
>
> I was able to test on a 6-core RK3399 based system - there the
> ptep_clear_flush() was only 0.10% of the overall execution time. The
> hardware seems to do a pretty good job of keeping the TLB flushing
> overhead low.

RK3399 has Dual-core ARM Cortex-A72 MPCore processor and
Quad-core ARM Cortex-A53 MPCore processor. you are probably
going to see different overhead of ptep_clear_flush() when you
bind the micro-benchmark on different cores.

>
> [...]
>

Thanks
Barry
