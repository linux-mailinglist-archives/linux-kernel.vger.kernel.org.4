Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5242B61055C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 00:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbiJ0WIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 18:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234810AbiJ0WIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 18:08:17 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D195A2204;
        Thu, 27 Oct 2022 15:08:14 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id r14so5216523edc.7;
        Thu, 27 Oct 2022 15:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r9RELUveKiUS67KqsZJxwv+GhPKYSZmmNpqGyp3KeL0=;
        b=JfXFlJ4wCnFvi9jr1lx+vzRzL6wNpHsAjP9ImZnD7o4RBGnGK2q+Hkr1AfP8BCQ9Em
         ClHUmPJP2mw+Jv3BwJXHu6/WlG1YnKxhdbpWzIIvAY5/f9Vxpo+eZyR9J2P450gcz8d1
         ZC0/nutQ/zH7Y66UzyXySNTXBIJautFH3rHTDUUKyL6h8tPUGGZe1HOupswJUrG2WXWh
         +9GBIBs7lmr8PJ9X8My5e7ss2akjSuXDKad86M5NIahpuIZGpF+4dt+j5j1ukAM1P/2k
         hXW1Ih6c/LqiyAWoQITdGwfnPwsd65hnISqhXdmzfZ1XLNvFKrTDl6KQGSY4zv9DIe2f
         JDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r9RELUveKiUS67KqsZJxwv+GhPKYSZmmNpqGyp3KeL0=;
        b=zrm/S1VMhZBxZrDfMZ6Y4EHEOtv5jh91kreKJnWuiOF7uypO939+YZnCE5JrD5ot5E
         deQQyf4ymnEv9SiQ242aLSrhZSEwaReuIJVI9qPLPruAQ7xbXTKuQCyEdwOVF+1dXujU
         NmUu+KAv2Eps7XtqcZKV5CkbwCk64Gyk+SvSk2kQIbmmx5CsxVrVl8GDMm0tYLom7eYy
         8UBW/MXS7KwHbrpgMouvuQepB8UCOOfsBbas5QB0FsnxpSNdV6L5GIl25C2Y2x80YTHJ
         exZb7678MMTWgxvjcXIlQ29/1/8GLLvMew7FIDeRRh2vBlFPMELJRsSLAu1A2xchZsBT
         Y/mg==
X-Gm-Message-State: ACrzQf170zEhJ9SiMNexqH+jdE46TQciUakJwLDxWyLjvbzvsAIOJcwA
        G8QiywNWspmQ1ncR8zRXUgdnMI95hj+Nh3BffiM=
X-Google-Smtp-Source: AMsMyM7WF/u9jCTtkVgKvkXWMMsUAzTmGbv2jIoDElJSEwL95CQMTNB+W2XiN6KO+oglta/8KUl11BElPtkjS3OhWbc=
X-Received: by 2002:aa7:d80a:0:b0:462:2c1c:8716 with SMTP id
 v10-20020aa7d80a000000b004622c1c8716mr13941343edq.185.1666908492601; Thu, 27
 Oct 2022 15:08:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220921084302.43631-1-yangyicong@huawei.com> <20220921084302.43631-3-yangyicong@huawei.com>
 <168eac93-a6ee-0b2e-12bb-4222eff24561@arm.com> <8e391962-4e3a-5a56-64b4-78e8637e3b8c@huawei.com>
 <CAGsJ_4z=dZbrAUD9jczT08S3qi_ep-h+EK35UfayVk1S+Cnp2A@mail.gmail.com> <ecd161db-b290-7997-a81e-a0a00bd1c599@arm.com>
In-Reply-To: <ecd161db-b290-7997-a81e-a0a00bd1c599@arm.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Fri, 28 Oct 2022 11:07:58 +1300
Message-ID: <CAGsJ_4x0KhEjm5a9jhtS+YK1AT49u3sHnp2rHZVSuTGZp4nKzA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] arm64: support batched/deferred tlb shootdown
 during page reclamation
To:     Anshuman Khandual <anshuman.khandual@arm.com>
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

On Thu, Oct 27, 2022 at 11:42 PM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
>
> On 9/28/22 05:53, Barry Song wrote:
> > On Tue, Sep 27, 2022 at 10:15 PM Yicong Yang <yangyicong@huawei.com> wrote:
> >>
> >> On 2022/9/27 14:16, Anshuman Khandual wrote:
> >>> [...]
> >>>
> >>> On 9/21/22 14:13, Yicong Yang wrote:
> >>>> +static inline bool arch_tlbbatch_should_defer(struct mm_struct *mm)
> >>>> +{
> >>>> +    /* for small systems with small number of CPUs, TLB shootdown is cheap */
> >>>> +    if (num_online_cpus() <= 4)
> >>>
> >>> It would be great to have some more inputs from others, whether 4 (which should
> >>> to be codified into a macro e.g ARM64_NR_CPU_DEFERRED_TLB, or something similar)
> >>> is optimal for an wide range of arm64 platforms.
> >>>
> >
> > I have tested it on a 4-cpus and 8-cpus machine. but i have no machine
> > with 5,6,7
> > cores.
> > I saw improvement on 8-cpus machines and I found 4-cpus machines don't need
> > this patch.
> >
> > so it seems safe to have
> > if (num_online_cpus()  < 8)
> >
> >>
> >> Do you prefer this macro to be static or make it configurable through kconfig then
> >> different platforms can make choice based on their own situations? It maybe hard to
> >> test on all the arm64 platforms.
> >
> > Maybe we can have this default enabled on machines with 8 and more cpus and
> > provide a tlbflush_batched = on or off to allow users enable or
> > disable it according
> > to their hardware and products. Similar example: rodata=on or off.
>
> No, sounds bit excessive. Kernel command line options should not be added
> for every possible run time switch options.
>
> >
> > Hi Anshuman, Will,  Catalin, Andrew,
> > what do you think about this approach?
> >
> > BTW, haoxin mentioned another important user scenarios for tlb bach on arm64:
> > https://lore.kernel.org/lkml/393d6318-aa38-01ed-6ad8-f9eac89bf0fc@linux.alibaba.com/
> >
> > I do believe we need it based on the expensive cost of tlb shootdown in arm64
> > even by hardware broadcast.
>
> Alright, for now could we enable ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH selectively
> with CONFIG_EXPERT and for num_online_cpus()  > 8 ?

Sounds good to me. It is a good start to bring up tlb batched flush in
ARM64. Later on, we
might want to see it in both memory reclamation and migration.

Thanks
Barry
