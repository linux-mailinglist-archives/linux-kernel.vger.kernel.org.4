Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F20E5BF325
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 03:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbiIUBvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 21:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbiIUBvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 21:51:44 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515E45A8BC;
        Tue, 20 Sep 2022 18:51:43 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id b35so6581149edf.0;
        Tue, 20 Sep 2022 18:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=exktuqp3Yz0O7DTOQAZcnS95GYeriR3HpkAUKtRfC9k=;
        b=prR2d7IC8d3KTQfnrJuC6umcuUbOTsTHYnt/TN+mB7C0ksEVF09+y5pzwSr5hUcgfQ
         3S6TNC1vUWzt0CWTWTgxvQjIa+srt85URQX7boT8YzDwD04EMRwBIQ5wnmBXQh5ojZFP
         mb5cXtroEJ1QUj5aQRtcZ2eSbRkZJBKgrfwSP3a1AOX3PzhiPJyWAxUHhPNM+zljeEdC
         RPEj/BOnWcjjlJYt0fOi284UWlelcdxkXKEvCjZSCzcEsRYi4gcGLSaSfe1/qg6igU91
         8UMCYOG2BCz3q0FrpJnwDfEEW2sdvH6TIn+LqzqIaLzJkw4LJ5e/RUB96Vy1z5+wyzxa
         40yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=exktuqp3Yz0O7DTOQAZcnS95GYeriR3HpkAUKtRfC9k=;
        b=S55VB+qTcprBHueLRMfKA/50Dfh98PowgptRj/vawGlrO265TOYv9zllgi/6T9BSRA
         iLMw7G+CbV0p1CXCgV2o44Uq58DSbEV1U9aWtxEw7ooXy2jBN32IbahrHuddQWmk98FN
         1aFirpfUSwunAag1Ukdix6sf5xcThvvmhFqZ17zXKCBbNbMxuLoUof1vU+pWsdwjDo9D
         jeoLgFGuxL1XEu9e68oSp0zobNfJIEFWVpHoLENsaybGYX7yXmef15hn4lLb8+t73BnL
         fhBEsL4LbvJFBkU8ws8tvTIkUXQlAotB3m1Jy6IKINZn4z4jJroDgeZSkBuu2MSTlauQ
         JUyA==
X-Gm-Message-State: ACrzQf3OsbW8d+x2tIxvFWpWhk2Xj3H6XGBo24j7SdF3S0S1m2d4Nm+h
        7rA92mEvemi0WWWpP9hjHhmwv0BT9HZq003e+Mo=
X-Google-Smtp-Source: AMsMyM5v9dTlzaqMHbzByB0iQp6q4d17pnEGAvmmK5ZnmNrYfXTWs2nOXnV+B27bLIMXIY5zqA4ppXvLi5hsTQlRwTY=
X-Received: by 2002:a05:6402:184:b0:442:fd54:2a21 with SMTP id
 r4-20020a056402018400b00442fd542a21mr22357803edv.129.1663725101717; Tue, 20
 Sep 2022 18:51:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220822082120.8347-1-yangyicong@huawei.com> <20220822082120.8347-5-yangyicong@huawei.com>
 <302febae-508c-d73e-8676-d51752946645@arm.com> <CAGsJ_4ywwFJFi+q3Ra5UE3twzS9eExtvuXgoGK-8u4c1ZdXCBw@mail.gmail.com>
 <8c4f103b-8f04-d0ad-b30a-2db7e52b36a3@arm.com> <CAGsJ_4xCpSFneh7dPriGeM2_z5njB71cXKGfrarc8Kq0CA37CQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4xCpSFneh7dPriGeM2_z5njB71cXKGfrarc8Kq0CA37CQ@mail.gmail.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Wed, 21 Sep 2022 13:51:30 +1200
Message-ID: <CAGsJ_4y0HrWd90ApAn=eDpYrkCigM6MyH=3cYnSuunZ5QpsD3w@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] arm64: support batched/deferred tlb shootdown
 during page reclamation
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Yicong Yang <yangyicong@huawei.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        linux-doc@vger.kernel.org, corbet@lwn.net, peterz@infradead.org,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        darren@os.amperecomputing.com, yangyicong@hisilicon.com,
        huzhanyuan@oppo.com, lipeifeng@oppo.com, zhangshiming@oppo.com,
        guojian@oppo.com, realmz6@gmail.com, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        wangkefeng.wang@huawei.com, xhao@linux.alibaba.com,
        prime.zeng@hisilicon.com, Barry Song <v-songbaohua@oppo.com>,
        Nadav Amit <namit@vmware.com>, Mel Gorman <mgorman@suse.de>
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

On Wed, Sep 21, 2022 at 1:50 PM Barry Song <21cnbao@gmail.com> wrote:
>
> On Tue, Sep 20, 2022 at 8:45 PM Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
> >
> >
> >
> > On 9/20/22 09:09, Barry Song wrote:
> > > On Tue, Sep 20, 2022 at 3:00 PM Anshuman Khandual
> > > <anshuman.khandual@arm.com> wrote:
> > >>
> > >>
> > >> On 8/22/22 13:51, Yicong Yang wrote:
> > >>> +static inline bool arch_tlbbatch_should_defer(struct mm_struct *mm)
> > >>> +{
> > >>> +     return true;
> > >>> +}
> > >>
> > >> This needs to be conditional on systems, where there will be performance
> > >> improvements, and should not just be enabled all the time on all systems.
> > >> num_online_cpus() > X, which does not hold any cpu hotplug lock would be
> > >> a good metric ?
> > >
> > > for a small system, i don't see how this patch will help, e.g. cpus <= 4;
> > > so we can actually disable tlb-batch on small systems.
> >
> > Do not subscribe ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH based on NR_CPUS ?
> > That might not help much as the default value is 256 for NR_CPUS.
> >
> > OR
> >
> > arch_tlbbatch_should_defer() checks on
> >
> > 1. online cpus                  (dont enable batched TLB if <= X)
> > 2. ARM64_WORKAROUND_REPEAT_TLBI (dont enable batched TLB)
> >
> > > just need to check if we will have any race condition since hotplug will
> > > make the condition true and false dynamically.
> >
> > If should_defer_flush() evaluate to be false, then ptep_clear_flush()
> > clears and flushes the entry right away. This should not race with other
> > queued up TLBI requests, which will be flushed separately. Wondering how
> > there can be a race here !
>
> Right. How about we make something as below?
>
> static inline bool arch_tlbbatch_should_defer(struct mm_struct *mm)
> {
>     /* for a small system very small number of CPUs, TLB shootdown is cheap */
>     if (num_online_cpus() <= 4 ||
> unlikely(this_cpu_has_cap(ARM64_WORKAROUND_REPEAT_TLBI)))
>           return false;
>
> #ifdef CONFIG_ARM64_WORKAROUND_REPEAT_TLBI
>     if (unlikely(this_cpu_has_cap(ARM64_WORKAROUND_REPEAT_TLBI)))
>          return false;
> #endif
>
>     return true;
> }

sorry, i mean

static inline bool arch_tlbbatch_should_defer(struct mm_struct *mm)
{
    /* for a small system very small number of CPUs, TLB shootdown is cheap */
    if (num_online_cpus() <= 4)
            return false;

#ifdef CONFIG_ARM64_WORKAROUND_REPEAT_TLBI
    if (unlikely(this_cpu_has_cap(ARM64_WORKAROUND_REPEAT_TLBI)))
            return false;
#endif

    return true;
}

>
> Thanks
> Barry
