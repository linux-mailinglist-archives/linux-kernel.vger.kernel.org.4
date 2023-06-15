Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6678E7319EE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343531AbjFON2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344074AbjFON2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:28:35 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1912D49
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:28:00 -0700 (PDT)
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7552C3F15F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 13:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686835679;
        bh=pmiNPwgE3KMFqmooTFrN6Vn4u5JSaY1Dw1DCIEOod+Q=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=UtaKZPdhuJyfTbIMelyxar6Ulvwz/qNXADNe+69vxf8nju1d22Srdo5O6oV6R9xYu
         mDD1JrBuXD5sVxkg2qgxEoDFV9p0l8o12yKPKoDdk93D+ZT4h39txEZM9YnGKrIHst
         0akWnvr2qRjhUVKq4hHns1JKWOfBHB5gP6Eh5AHz6UBD2NUXfMirezwStymOFVIN5T
         cVe4B5S/vt6pmyQ0oEdWAWXaA0ULwj+l5bP3aXfw1jFplQXCVAMMAqR+LYmTtP2dCU
         TF7Dhldu+1UJl6c8hogBl+4btn0dC8vNn4gsdpi7X2EdsApcr1A4sovUroTgolauhM
         Q4M7+0MlNrioA==
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b36ed945abso11665221fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:27:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686835678; x=1689427678;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pmiNPwgE3KMFqmooTFrN6Vn4u5JSaY1Dw1DCIEOod+Q=;
        b=bVcfgSlOyKpoKtBW9sk/uUl4qLSVpekvm+vR8Yrs1DFUufogZqpQ+MVe1t/THivfn0
         f6F7fb51I/pkOUdjYtMxa1tGNY6+7rnvxAIJ+JGkYSGFHbmkWQjbHIZB3tlanqEFAQPw
         Z4Vp5mlott3xqxCcOInUpWkihet3t8bTNr43TRrQE0zfg9+ZP7O6Xq00AqHb+AYxi6TG
         BHyn5tR79pJ6RxY2geMtdzqqf5zAkLZdn+HeTVzV/hYaDE5TO7CNjVQt/1z5cyrKRWPN
         WKNO7lL/a2j6Uhjl6Ml81LzNXND8V1CM/GA4MnB/QpLfZF6WAEKNczuyQaiZlq36K8is
         H9yg==
X-Gm-Message-State: AC+VfDwqR/Nfp3/fxGNxTWYTjiVuA99nmx2nwzMntQRE5SwWgs3lIVNg
        231wf2ZX5fv58IuM4AHdfMMhpsqKbFGwjf3IjFny2IReBn5q1dx7IZPlHPs6TwnfitBMTnIA661
        PM9UZXYtchtxj/gQJCHEWW4RjhP6gXwdfhZyiMbPV4w==
X-Received: by 2002:adf:d0c7:0:b0:30f:d1e3:22b7 with SMTP id z7-20020adfd0c7000000b0030fd1e322b7mr4523138wrh.6.1686835657060;
        Thu, 15 Jun 2023 06:27:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5tc18E1shmQlP6r5bTT/RRUzeEmZ44GxOZaz29SXvOsOZC9mLd47i2MmyxuogDSrd+n91t+A==
X-Received: by 2002:adf:d0c7:0:b0:30f:d1e3:22b7 with SMTP id z7-20020adfd0c7000000b0030fd1e322b7mr4523106wrh.6.1686835656550;
        Thu, 15 Jun 2023 06:27:36 -0700 (PDT)
Received: from [192.168.123.67] (ip-084-119-033-219.um24.pools.vodafone-ip.de. [84.119.33.219])
        by smtp.gmail.com with ESMTPSA id h17-20020a5d4311000000b003048477729asm21028155wrq.81.2023.06.15.06.27.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 06:27:36 -0700 (PDT)
Message-ID: <51af30bd-9913-8ba6-fa5e-d38e4617a7ef@canonical.com>
Date:   Thu, 15 Jun 2023 15:27:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 07/10] drivers: perf: Implement perf event mmap support
 in the SBI backend
Content-Language: en-US
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Aurelien Jarno <aurelien@aurel32.net>,
        Andreas Schwab <schwab@suse.de>,
        Andrew Jones <ajones@ventanamicro.com>
References: <20230512085321.13259-1-alexghiti@rivosinc.com>
 <20230512085321.13259-8-alexghiti@rivosinc.com>
 <20230531-7e3740ca04a3fe6e2fd25a01@orel>
 <CAOnJCULmOuP=EGuR7RXgkBU0LrQ9c++M43UXc1dy86kaLxOeVQ@mail.gmail.com>
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAOnJCULmOuP=EGuR7RXgkBU0LrQ9c++M43UXc1dy86kaLxOeVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/23 10:41, Atish Patra wrote:
> On Wed, May 31, 2023 at 8:02 AM Andrew Jones <ajones@ventanamicro.com> wrote:
>>
>> On Fri, May 12, 2023 at 10:53:18AM +0200, Alexandre Ghiti wrote:
>>> We used to unconditionnally expose the cycle and instret csrs to
>>> userspace, which gives rise to security concerns.
>>>
>>> So now we only allow access to hw counters from userspace through the perf
>>> framework which will handle context switches, per-task events...etc. But
>>> as we cannot break userspace, we give the user the choice to go back to
>>> the previous behaviour by setting the sysctl perf_user_access.
>>>
>>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>>> ---
>>>   arch/riscv/kernel/perf_event.c |  18 ++-
>>>   drivers/perf/riscv_pmu_sbi.c   | 194 ++++++++++++++++++++++++++++++++-
>>>   2 files changed, 205 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/arch/riscv/kernel/perf_event.c b/arch/riscv/kernel/perf_event.c
>>> index 94174a0fc251..3af9ca45b43f 100644
>>> --- a/arch/riscv/kernel/perf_event.c
>>> +++ b/arch/riscv/kernel/perf_event.c
>>> @@ -1,9 +1,13 @@
>>>   // SPDX-License-Identifier: GPL-2.0-only
>>> +#include <linux/perf/riscv_pmu.h>
>>>   #include <linux/sched_clock.h>
>>>
>>>   void arch_perf_update_userpage(struct perf_event *event,
>>>                               struct perf_event_mmap_page *userpg, u64 now)
>>>   {
>>> +#ifdef CONFIG_RISCV_PMU_SBI
>>> +     struct riscv_pmu *rvpmu = to_riscv_pmu(event->pmu);
>>> +#endif
>>
>> Can avoid this pair of #ifdef/#endif's by just declaring rvpmu inside the
>> if block below where it's needed. Or even just using to_riscv_pmu()
>> directly in place of rvpmu.
>>
>>>        struct clock_read_data *rd;
>>>        unsigned int seq;
>>>        u64 ns;
>>> @@ -14,7 +18,19 @@ void arch_perf_update_userpage(struct perf_event *event,
>>>        userpg->cap_user_rdpmc =
>>>                !!(event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT);
>>>
>>> -     userpg->pmc_width = 64;
>>> +#ifdef CONFIG_RISCV_PMU_SBI
>>> +     /*
>>> +      * The counters are 64-bit but the priv spec doesn't mandate all the
>>> +      * bits to be implemented: that's why, counter width can vary based on
>>> +      * the cpu vendor.
>>> +      */
>>> +     if (event->pmu->name &&
>>> +         !strncmp(event->pmu->name,
>>> +                  RISCV_PMU_PDEV_NAME, sizeof(RISCV_PMU_PDEV_NAME)))
>>> +             userpg->pmc_width = rvpmu->ctr_get_width(event->hw.idx) + 1;
>>> +     else
>>> +#endif
>>> +             userpg->pmc_width = 64;
>>
>> Can leave the initialization to 64 above the #ifdef CONFIG_RISCV_PMU_SBI
>> as is and drop the else.
>>
>>>
>>>        do {
>>>                rd = sched_clock_read_begin(&seq);
>>> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
>>> index 3b0ee2148054..d9bcc5cc6df5 100644
>>> --- a/drivers/perf/riscv_pmu_sbi.c
>>> +++ b/drivers/perf/riscv_pmu_sbi.c
>>> @@ -24,6 +24,14 @@
>>>   #include <asm/sbi.h>
>>>   #include <asm/hwcap.h>
>>>
>>> +#define SYSCTL_NO_USER_ACCESS        0
>>> +#define SYSCTL_USER_ACCESS   1
>>> +#define SYSCTL_LEGACY                2
>>> +
>>> +#define PERF_EVENT_FLAG_NO_USER_ACCESS       BIT(SYSCTL_NO_USER_ACCESS)
>>> +#define PERF_EVENT_FLAG_USER_ACCESS  BIT(SYSCTL_USER_ACCESS)
>>> +#define PERF_EVENT_FLAG_LEGACY               BIT(SYSCTL_LEGACY)
>>> +
>>>   PMU_FORMAT_ATTR(event, "config:0-47");
>>>   PMU_FORMAT_ATTR(firmware, "config:63");
>>>
>>> @@ -43,6 +51,9 @@ static const struct attribute_group *riscv_pmu_attr_groups[] = {
>>>        NULL,
>>>   };
>>>
>>> +/* Allow legacy access by default */
>>> +static int sysctl_perf_user_access __read_mostly = SYSCTL_LEGACY;
>>> +
>>
>> I'm still not in favor of this. Hopefully the distro discussions result in
>> it being changed.
>>
> 
> I did not see any feedback from distro guys. I talked to David (fedora
> maintainer) and he is even okay with
> SYSCTL_NO_USER_ACCESS :). I would love to hear back from others (cc'd
> a few distro folks to this thread).

In future we will have to support scenarios for confidential compute. 
Here we have to avoid timing attacks against virtual machines. If access 
to the cycle register is critical, this implies that hiding it behind a 
sysctl setting is not good enough.

If we keep this sysctl based access at all, it should be behind a 
Kconfig setting that is disabled by default and were the help text 
clearly indicates the security implications.

Best regards

Heinrich

> 
>>>   /*
>>>    * RISC-V doesn't have heterogeneous harts yet. This need to be part of
>>>    * per_cpu in case of harts with different pmu counters
>>> @@ -301,6 +312,11 @@ int riscv_pmu_get_hpm_info(u32 *hw_ctr_width, u32 *num_hw_ctr)
>>>   }
>>>   EXPORT_SYMBOL_GPL(riscv_pmu_get_hpm_info);
>>>
>>> +static uint8_t pmu_sbi_csr_index(struct perf_event *event)
>>> +{
>>> +     return pmu_ctr_list[event->hw.idx].csr - CSR_CYCLE;
>>> +}
>>> +
>>>   static unsigned long pmu_sbi_get_filter_flags(struct perf_event *event)
>>>   {
>>>        unsigned long cflags = 0;
>>> @@ -329,18 +345,34 @@ static int pmu_sbi_ctr_get_idx(struct perf_event *event)
>>>        struct cpu_hw_events *cpuc = this_cpu_ptr(rvpmu->hw_events);
>>>        struct sbiret ret;
>>>        int idx;
>>> -     uint64_t cbase = 0;
>>> +     uint64_t cbase = 0, cmask = rvpmu->cmask;
>>>        unsigned long cflags = 0;
>>>
>>>        cflags = pmu_sbi_get_filter_flags(event);
>>> +
>>> +     /*
>>> +      * In legacy mode, we have to force the fixed counters for those events
>>> +      * but not in the user access mode as we want to use the other counters
>>> +      * that support sampling/filtering.
>>> +      */
>>> +     if (hwc->flags & PERF_EVENT_FLAG_LEGACY) {
>>> +             if (event->attr.config == PERF_COUNT_HW_CPU_CYCLES) {
>>> +                     cflags |= SBI_PMU_CFG_FLAG_SKIP_MATCH;
>>> +                     cmask = 1;
>>> +             } else if (event->attr.config == PERF_COUNT_HW_INSTRUCTIONS) {
>>> +                     cflags |= SBI_PMU_CFG_FLAG_SKIP_MATCH;
>>> +                     cmask = 1UL << (CSR_INSTRET - CSR_CYCLE);
>>> +             }
>>> +     }
>>> +
>>>        /* retrieve the available counter index */
>>>   #if defined(CONFIG_32BIT)
>>>        ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_CFG_MATCH, cbase,
>>> -                     rvpmu->cmask, cflags, hwc->event_base, hwc->config,
>>> +                     cmask, cflags, hwc->event_base, hwc->config,
>>>                        hwc->config >> 32);
>>>   #else
>>>        ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_CFG_MATCH, cbase,
>>> -                     rvpmu->cmask, cflags, hwc->event_base, hwc->config, 0);
>>> +                     cmask, cflags, hwc->event_base, hwc->config, 0);
>>>   #endif
>>>        if (ret.error) {
>>>                pr_debug("Not able to find a counter for event %lx config %llx\n",
>>> @@ -474,6 +506,14 @@ static u64 pmu_sbi_ctr_read(struct perf_event *event)
>>>        return val;
>>>   }
>>>
>>> +static void pmu_sbi_set_scounteren(void *arg)
>>> +{
>>> +     struct perf_event *event = (struct perf_event *)arg;
>>> +
>>> +     csr_write(CSR_SCOUNTEREN,
>>> +               csr_read(CSR_SCOUNTEREN) | (1 << pmu_sbi_csr_index(event)));
>>> +}
>>> +
>>>   static void pmu_sbi_ctr_start(struct perf_event *event, u64 ival)
>>>   {
>>>        struct sbiret ret;
>>> @@ -490,6 +530,18 @@ static void pmu_sbi_ctr_start(struct perf_event *event, u64 ival)
>>>        if (ret.error && (ret.error != SBI_ERR_ALREADY_STARTED))
>>>                pr_err("Starting counter idx %d failed with error %d\n",
>>>                        hwc->idx, sbi_err_map_linux_errno(ret.error));
>>> +
>>> +     if (hwc->flags & PERF_EVENT_FLAG_USER_ACCESS &&
>>> +         hwc->flags & PERF_EVENT_FLAG_USER_READ_CNT)
>>> +             pmu_sbi_set_scounteren((void *)event);
>>> +}
>>> +
>>> +static void pmu_sbi_reset_scounteren(void *arg)
>>> +{
>>> +     struct perf_event *event = (struct perf_event *)arg;
>>> +
>>> +     csr_write(CSR_SCOUNTEREN,
>>> +               csr_read(CSR_SCOUNTEREN) & ~(1 << pmu_sbi_csr_index(event)));
>>>   }
>>>
>>>   static void pmu_sbi_ctr_stop(struct perf_event *event, unsigned long flag)
>>> @@ -497,6 +549,10 @@ static void pmu_sbi_ctr_stop(struct perf_event *event, unsigned long flag)
>>>        struct sbiret ret;
>>>        struct hw_perf_event *hwc = &event->hw;
>>>
>>> +     if (hwc->flags & PERF_EVENT_FLAG_USER_ACCESS &&
>>> +         hwc->flags & PERF_EVENT_FLAG_USER_READ_CNT)
>>> +             pmu_sbi_reset_scounteren((void *)event);
>>> +
>>>        ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, hwc->idx, 1, flag, 0, 0, 0);
>>>        if (ret.error && (ret.error != SBI_ERR_ALREADY_STOPPED) &&
>>>                flag != SBI_PMU_STOP_FLAG_RESET)
>>> @@ -704,10 +760,13 @@ static int pmu_sbi_starting_cpu(unsigned int cpu, struct hlist_node *node)
>>>        struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
>>>
>>>        /*
>>> -      * Enable the access for CYCLE, TIME, and INSTRET CSRs from userspace,
>>> -      * as is necessary to maintain uABI compatibility.
>>> +      * We keep enabling userspace access to CYCLE, TIME and INSRET via the
>>> +      * legacy option but that will be removed in the future.
>>>         */
>>> -     csr_write(CSR_SCOUNTEREN, 0x7);
>>> +     if (sysctl_perf_user_access == SYSCTL_LEGACY)
>>> +             csr_write(CSR_SCOUNTEREN, 0x7);
>>> +     else
>>> +             csr_write(CSR_SCOUNTEREN, 0x2);
>>>
>>>        /* Stop all the counters so that they can be enabled from perf */
>>>        pmu_sbi_stop_all(pmu);
>>> @@ -851,6 +910,123 @@ static void riscv_pmu_destroy(struct riscv_pmu *pmu)
>>>        cpuhp_state_remove_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
>>>   }
>>>
>>> +static void pmu_sbi_event_init(struct perf_event *event)
>>> +{
>>> +     /*
>>> +      * The permissions are set at event_init so that we do not depend
>>> +      * on the sysctl value that can change.
>>> +      */
>>> +     if (sysctl_perf_user_access == SYSCTL_NO_USER_ACCESS)
>>> +             event->hw.flags |= PERF_EVENT_FLAG_NO_USER_ACCESS;
>>> +     else if (sysctl_perf_user_access == SYSCTL_USER_ACCESS)
>>> +             event->hw.flags |= PERF_EVENT_FLAG_USER_ACCESS;
>>> +     else
>>> +             event->hw.flags |= PERF_EVENT_FLAG_LEGACY;
>>> +}
>>> +
>>> +static void pmu_sbi_event_mapped(struct perf_event *event, struct mm_struct *mm)
>>> +{
>>> +     if (event->hw.flags & PERF_EVENT_FLAG_NO_USER_ACCESS)
>>> +             return;
>>> +
>>> +     /* In legacy mode, the first 3 CSRs are available. */
>>
>> first and third
>>
>>> +     if (event->hw.flags & PERF_EVENT_FLAG_LEGACY) {
>>> +             if (event->attr.config != PERF_COUNT_HW_CPU_CYCLES &&
>>> +                 event->attr.config != PERF_COUNT_HW_INSTRUCTIONS) {
>>> +                     return;
>>> +             }
>>> +     }
>>> +
>>> +     /*
>>> +      * The user mmapped the event to directly access it: this is where
>>> +      * we determine based on sysctl_perf_user_access if we grant userspace
>>> +      * the direct access to this event. That means that within the same
>>> +      * task, some events may be directly accessible and some other may not,
>>> +      * if the user changes the value of sysctl_perf_user_accesss in the
>>> +      * meantime.
>>> +      */
>>> +
>>> +     event->hw.flags |= PERF_EVENT_FLAG_USER_READ_CNT;
>>> +
>>> +     /*
>>> +      * We must enable userspace access *before* advertising in the user page
>>> +      * that it is possible to do so to avoid any race.
>>> +      * And we must notify all cpus here because threads that currently run
>>> +      * on other cpus will try to directly access the counter too without
>>> +      * calling pmu_sbi_ctr_start.
>>> +      */
>>> +     if (event->hw.flags & PERF_EVENT_FLAG_USER_ACCESS)
>>> +             on_each_cpu_mask(mm_cpumask(mm),
>>> +                              pmu_sbi_set_scounteren, (void *)event, 1);
>>> +}
>>> +
>>> +static void pmu_sbi_event_unmapped(struct perf_event *event, struct mm_struct *mm)
>>> +{
>>> +     if (event->hw.flags & PERF_EVENT_FLAG_NO_USER_ACCESS)
>>> +             return;
>>> +
>>> +     /* In legacy mode, the first 3 CSRs are available. */
>>
>> first and third
>>
>>> +     if (event->hw.flags & PERF_EVENT_FLAG_LEGACY) {
>>> +             if (event->attr.config != PERF_COUNT_HW_CPU_CYCLES &&
>>> +                 event->attr.config != PERF_COUNT_HW_INSTRUCTIONS) {
>>> +                     return;
>>> +             }
>>> +     }
>>> +
>>> +     /*
>>> +      * Here we can directly remove user access since the user does not have
>>> +      * access to the user page anymore so we avoid the racy window where the
>>> +      * user could have read cap_user_rdpmc to true right before we disable
>>> +      * it.
>>> +      */
>>> +     event->hw.flags &= ~PERF_EVENT_FLAG_USER_READ_CNT;
>>> +
>>> +     if (event->hw.flags & PERF_EVENT_FLAG_USER_ACCESS)
>>> +             on_each_cpu_mask(mm_cpumask(mm),
>>> +                              pmu_sbi_reset_scounteren, (void *)event, 1);
>>> +}
>>> +
>>> +static void riscv_pmu_update_counter_access(void *info)
>>> +{
>>> +     if (sysctl_perf_user_access == SYSCTL_LEGACY)
>>> +             csr_write(CSR_SCOUNTEREN, 0x7);
>>> +     else
>>> +             csr_write(CSR_SCOUNTEREN, 0x2);
>>> +}
>>> +
>>> +static int riscv_pmu_proc_user_access_handler(struct ctl_table *table,
>>> +                                           int write, void *buffer,
>>> +                                           size_t *lenp, loff_t *ppos)
>>> +{
>>> +     int prev = sysctl_perf_user_access;
>>> +     int ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
>>> +
>>> +     /*
>>> +      * Test against the previous value since we clear SCOUNTEREN when
>>> +      * sysctl_perf_user_access is set to SYSCTL_USER_ACCESS, but we should
>>> +      * not do that if that was already the case.
>>> +      */
>>> +     if (ret || !write || prev == sysctl_perf_user_access)
>>> +             return ret;
>>> +
>>> +     on_each_cpu(riscv_pmu_update_counter_access, (void *)&prev, 1);
>>
>> Instead of passing prev shouldn't we pass NULL, as it's not used?
>>
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static struct ctl_table sbi_pmu_sysctl_table[] = {
>>> +     {
>>> +             .procname       = "perf_user_access",
>>> +             .data           = &sysctl_perf_user_access,
>>> +             .maxlen         = sizeof(unsigned int),
>>> +             .mode           = 0644,
>>> +             .proc_handler   = riscv_pmu_proc_user_access_handler,
>>> +             .extra1         = SYSCTL_ZERO,
>>> +             .extra2         = SYSCTL_TWO,
>>> +     },
>>> +     { }
>>> +};
>>> +
>>>   static int pmu_sbi_device_probe(struct platform_device *pdev)
>>>   {
>>>        struct riscv_pmu *pmu = NULL;
>>> @@ -888,6 +1064,10 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
>>>        pmu->ctr_get_width = pmu_sbi_ctr_get_width;
>>>        pmu->ctr_clear_idx = pmu_sbi_ctr_clear_idx;
>>>        pmu->ctr_read = pmu_sbi_ctr_read;
>>> +     pmu->event_init = pmu_sbi_event_init;
>>> +     pmu->event_mapped = pmu_sbi_event_mapped;
>>> +     pmu->event_unmapped = pmu_sbi_event_unmapped;
>>> +     pmu->csr_index = pmu_sbi_csr_index;
>>>
>>>        ret = cpuhp_state_add_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
>>>        if (ret)
>>> @@ -901,6 +1081,8 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
>>>        if (ret)
>>>                goto out_unregister;
>>>
>>> +     register_sysctl("kernel", sbi_pmu_sysctl_table);
>>> +
>>>        return 0;
>>>
>>>   out_unregister:
>>> --
>>> 2.37.2
>>>
>>
>> Thanks,
>> drew
> 
> 
> 

