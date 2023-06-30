Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9ABE743A67
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 13:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbjF3LIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 07:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjF3LIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 07:08:44 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7543A90
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 04:08:40 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fba545d743so19852415e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 04:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1688123319; x=1690715319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tDxZeyWjG8voQtkWAj7haga7jzNlySrufIHEDinVRhc=;
        b=mU71kGybzegk3SNLhxxVv/82FXfcG7/n+/iiTiVl9mtEARj6xaGXqsL0wU0Ik6ti6+
         YBQuXQ6YPYLuU0q674KZBGmsGtS14Cq7UvOtbVmKRMN6NriHNe2pAxQrKGdfAXoqfAe8
         l1BtcHikAncd5A1fv0R5//BNKQ9KQcdWH5RsCdzrXHOoNRCa+LvwfObH2nGLZtq/oA6k
         ZpSxtOK487glmnLh3e8n6fjfkSDk5Ox85JlAT2zxAUB3TWx9/Owx75X5qNdJObQlp0Zq
         N7J+jtPlwy9UpmNHW3UyqRMlmXLHxWi/SFPl27bJ9XH0r0f0iKyHzS9eOXQ9bLzNs9/O
         kjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688123319; x=1690715319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDxZeyWjG8voQtkWAj7haga7jzNlySrufIHEDinVRhc=;
        b=WZzuMvTUdvU3ocpQ2Kga3WhVFF3oNZR52ZFVtD3cQU9gaBIwaSiNCZ/UoSqIiE5Eq6
         Z1MmdRMaQ16l/lbnfY9iH+FVE6S+IWs9VA7BYrQLTCCZD17DQHL0tOvDGmJkjfZkIBVC
         oTC31b/FgOwXaQxcivk79KPhy5OmsTadVK4kzDaGCIO0f8vJKy4Wh16PuYnczSj+wMvd
         ZgeXD+OyRIwchGOhH9ZYtyA3xEM+K43d/Bf2gRMdJrT0yTnpSEQVQmJEw0qM53AQkrVd
         qWCeS72v4Jt+0mUK+rq1sjm9UMowYnzgzYwMTGupZhI1oWTOfoYUlWndLLU7UhhhA772
         E7RQ==
X-Gm-Message-State: AC+VfDwYH/Y+SFWZvSa2WCg+Cks6J1TGwpCrfjJ1FPaCFDcUAAXL+6EI
        E6djBDTSZ+ywQf306n9gw2yyaR2DMJXnwYuQsno=
X-Google-Smtp-Source: ACHHUZ6TA2kCJQE4gLb4pjlwWzGI5RJ2yDfMHlvX8PuClCMLJZME5R+JidBo884efY6Dw1+i+l1N1g==
X-Received: by 2002:a1c:7903:0:b0:3fa:8c68:4aba with SMTP id l3-20020a1c7903000000b003fa8c684abamr1782549wme.25.1688123318872;
        Fri, 30 Jun 2023 04:08:38 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id g11-20020a7bc4cb000000b003fbab76165asm8034556wmk.48.2023.06.30.04.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 04:08:38 -0700 (PDT)
Date:   Fri, 30 Jun 2023 13:08:37 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
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
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 07/10] drivers: perf: Implement perf event mmap
 support in the SBI backend
Message-ID: <20230630-ae0abe0611576cd52111903c@orel>
References: <20230630083013.102334-1-alexghiti@rivosinc.com>
 <20230630083013.102334-8-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630083013.102334-8-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 10:30:10AM +0200, Alexandre Ghiti wrote:
> We used to unconditionnally expose the cycle and instret csrs to
> userspace, which gives rise to security concerns.
> 
> So now we only allow access to hw counters from userspace through the perf
> framework which will handle context switches, per-task events...etc. But
> as we cannot break userspace, we give the user the choice to go back to
> the previous behaviour by setting the sysctl perf_user_access.
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  drivers/perf/riscv_pmu.c     |   9 +-
>  drivers/perf/riscv_pmu_sbi.c | 192 +++++++++++++++++++++++++++++++++--
>  2 files changed, 194 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
> index e1b0992f34df..80c052e93f9e 100644
> --- a/drivers/perf/riscv_pmu.c
> +++ b/drivers/perf/riscv_pmu.c
> @@ -38,8 +38,15 @@ void arch_perf_update_userpage(struct perf_event *event,
>  	userpg->cap_user_time_short = 0;
>  	userpg->cap_user_rdpmc = riscv_perf_user_access(event);
>  
> +#ifdef CONFIG_RISCV_PMU
> +	/*
> +	 * The counters are 64-bit but the priv spec doesn't mandate all the
> +	 * bits to be implemented: that's why, counter width can vary based on
> +	 * the cpu vendor.
> +	 */
>  	if (userpg->cap_user_rdpmc)
> -		userpg->pmc_width = 64;
> +		userpg->pmc_width = to_riscv_pmu(event->pmu)->ctr_get_width(event->hw.idx) + 1;
> +#endif
>  
>  	do {
>  		rd = sched_clock_read_begin(&seq);
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 83c3f1c4d2f1..acabb6c273c1 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -24,6 +24,14 @@
>  #include <asm/sbi.h>
>  #include <asm/hwcap.h>
>  
> +#define SYSCTL_NO_USER_ACCESS	0
> +#define SYSCTL_USER_ACCESS	1
> +#define SYSCTL_LEGACY		2
> +
> +#define PERF_EVENT_FLAG_NO_USER_ACCESS	BIT(SYSCTL_NO_USER_ACCESS)
> +#define PERF_EVENT_FLAG_USER_ACCESS	BIT(SYSCTL_USER_ACCESS)
> +#define PERF_EVENT_FLAG_LEGACY		BIT(SYSCTL_LEGACY)
> +
>  PMU_FORMAT_ATTR(event, "config:0-47");
>  PMU_FORMAT_ATTR(firmware, "config:63");
>  
> @@ -43,6 +51,9 @@ static const struct attribute_group *riscv_pmu_attr_groups[] = {
>  	NULL,
>  };
>  
> +/* Allow user mode access by default */
> +static int sysctl_perf_user_access __read_mostly = SYSCTL_USER_ACCESS;
> +
>  /*
>   * RISC-V doesn't have heterogeneous harts yet. This need to be part of
>   * per_cpu in case of harts with different pmu counters
> @@ -301,6 +312,11 @@ int riscv_pmu_get_hpm_info(u32 *hw_ctr_width, u32 *num_hw_ctr)
>  }
>  EXPORT_SYMBOL_GPL(riscv_pmu_get_hpm_info);
>  
> +static uint8_t pmu_sbi_csr_index(struct perf_event *event)
> +{
> +	return pmu_ctr_list[event->hw.idx].csr - CSR_CYCLE;
> +}
> +
>  static unsigned long pmu_sbi_get_filter_flags(struct perf_event *event)
>  {
>  	unsigned long cflags = 0;
> @@ -329,18 +345,34 @@ static int pmu_sbi_ctr_get_idx(struct perf_event *event)
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(rvpmu->hw_events);
>  	struct sbiret ret;
>  	int idx;
> -	uint64_t cbase = 0;
> +	uint64_t cbase = 0, cmask = rvpmu->cmask;
>  	unsigned long cflags = 0;
>  
>  	cflags = pmu_sbi_get_filter_flags(event);
> +
> +	/*
> +	 * In legacy mode, we have to force the fixed counters for those events
> +	 * but not in the user access mode as we want to use the other counters
> +	 * that support sampling/filtering.
> +	 */
> +	if (hwc->flags & PERF_EVENT_FLAG_LEGACY) {
> +		if (event->attr.config == PERF_COUNT_HW_CPU_CYCLES) {
> +			cflags |= SBI_PMU_CFG_FLAG_SKIP_MATCH;
> +			cmask = 1;
> +		} else if (event->attr.config == PERF_COUNT_HW_INSTRUCTIONS) {
> +			cflags |= SBI_PMU_CFG_FLAG_SKIP_MATCH;
> +			cmask = 1UL << (CSR_INSTRET - CSR_CYCLE);
> +		}
> +	}
> +
>  	/* retrieve the available counter index */
>  #if defined(CONFIG_32BIT)
>  	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_CFG_MATCH, cbase,
> -			rvpmu->cmask, cflags, hwc->event_base, hwc->config,
> +			cmask, cflags, hwc->event_base, hwc->config,
>  			hwc->config >> 32);
>  #else
>  	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_CFG_MATCH, cbase,
> -			rvpmu->cmask, cflags, hwc->event_base, hwc->config, 0);
> +			cmask, cflags, hwc->event_base, hwc->config, 0);
>  #endif
>  	if (ret.error) {
>  		pr_debug("Not able to find a counter for event %lx config %llx\n",
> @@ -474,6 +506,14 @@ static u64 pmu_sbi_ctr_read(struct perf_event *event)
>  	return val;
>  }
>  
> +static void pmu_sbi_set_scounteren(void *arg)
> +{
> +	struct perf_event *event = (struct perf_event *)arg;
> +
> +	csr_write(CSR_SCOUNTEREN,
> +		  csr_read(CSR_SCOUNTEREN) | (1 << pmu_sbi_csr_index(event)));
> +}
> +
>  static void pmu_sbi_ctr_start(struct perf_event *event, u64 ival)
>  {
>  	struct sbiret ret;
> @@ -490,6 +530,18 @@ static void pmu_sbi_ctr_start(struct perf_event *event, u64 ival)
>  	if (ret.error && (ret.error != SBI_ERR_ALREADY_STARTED))
>  		pr_err("Starting counter idx %d failed with error %d\n",
>  			hwc->idx, sbi_err_map_linux_errno(ret.error));
> +
> +	if (hwc->flags & PERF_EVENT_FLAG_USER_ACCESS &&
> +	    hwc->flags & PERF_EVENT_FLAG_USER_READ_CNT)

nit: Add () around the &'s. I thought checkpatch complained about that?

> +		pmu_sbi_set_scounteren((void *)event);
> +}
> +
> +static void pmu_sbi_reset_scounteren(void *arg)
> +{
> +	struct perf_event *event = (struct perf_event *)arg;
> +
> +	csr_write(CSR_SCOUNTEREN,
> +		  csr_read(CSR_SCOUNTEREN) & ~(1 << pmu_sbi_csr_index(event)));
>  }

nit: I'd collocate pmu_sbi_set_scounteren() and
pmu_sbi_reset_scounteren() since they're counterparts.

>  
>  static void pmu_sbi_ctr_stop(struct perf_event *event, unsigned long flag)
> @@ -497,6 +549,10 @@ static void pmu_sbi_ctr_stop(struct perf_event *event, unsigned long flag)
>  	struct sbiret ret;
>  	struct hw_perf_event *hwc = &event->hw;
>  
> +	if (hwc->flags & PERF_EVENT_FLAG_USER_ACCESS &&
> +	    hwc->flags & PERF_EVENT_FLAG_USER_READ_CNT)

nit: () around &'s

> +		pmu_sbi_reset_scounteren((void *)event);
> +
>  	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, hwc->idx, 1, flag, 0, 0, 0);
>  	if (ret.error && (ret.error != SBI_ERR_ALREADY_STOPPED) &&
>  		flag != SBI_PMU_STOP_FLAG_RESET)
> @@ -704,10 +760,13 @@ static int pmu_sbi_starting_cpu(unsigned int cpu, struct hlist_node *node)
>  	struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
>  
>  	/*
> -	 * Enable the access for CYCLE, TIME, and INSTRET CSRs from userspace,
> -	 * as is necessary to maintain uABI compatibility.
> +	 * We keep enabling userspace access to CYCLE, TIME and INSRET via the
> +	 * legacy option but that will be removed in the future.
>  	 */
> -	csr_write(CSR_SCOUNTEREN, 0x7);
> +	if (sysctl_perf_user_access == SYSCTL_LEGACY)
> +		csr_write(CSR_SCOUNTEREN, 0x7);
> +	else
> +		csr_write(CSR_SCOUNTEREN, 0x2);
>  
>  	/* Stop all the counters so that they can be enabled from perf */
>  	pmu_sbi_stop_all(pmu);
> @@ -851,6 +910,121 @@ static void riscv_pmu_destroy(struct riscv_pmu *pmu)
>  	cpuhp_state_remove_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
>  }
>  
> +static void pmu_sbi_event_init(struct perf_event *event)
> +{
> +	/*
> +	 * The permissions are set at event_init so that we do not depend
> +	 * on the sysctl value that can change.
> +	 */
> +	if (sysctl_perf_user_access == SYSCTL_NO_USER_ACCESS)
> +		event->hw.flags |= PERF_EVENT_FLAG_NO_USER_ACCESS;
> +	else if (sysctl_perf_user_access == SYSCTL_USER_ACCESS)
> +		event->hw.flags |= PERF_EVENT_FLAG_USER_ACCESS;
> +	else
> +		event->hw.flags |= PERF_EVENT_FLAG_LEGACY;
> +}
> +
> +static void pmu_sbi_event_mapped(struct perf_event *event, struct mm_struct *mm)
> +{
> +	if (event->hw.flags & PERF_EVENT_FLAG_NO_USER_ACCESS)
> +		return;
> +
> +	if (event->hw.flags & PERF_EVENT_FLAG_LEGACY) {
> +		if (event->attr.config != PERF_COUNT_HW_CPU_CYCLES &&
> +		    event->attr.config != PERF_COUNT_HW_INSTRUCTIONS) {
> +			return;
> +		}
> +	}
> +
> +	/*
> +	 * The user mmapped the event to directly access it: this is where
> +	 * we determine based on sysctl_perf_user_access if we grant userspace
> +	 * the direct access to this event. That means that within the same
> +	 * task, some events may be directly accessible and some other may not,
> +	 * if the user changes the value of sysctl_perf_user_accesss in the
> +	 * meantime.
> +	 */
> +
> +	event->hw.flags |= PERF_EVENT_FLAG_USER_READ_CNT;
> +
> +	/*
> +	 * We must enable userspace access *before* advertising in the user page
> +	 * that it is possible to do so to avoid any race.
> +	 * And we must notify all cpus here because threads that currently run
> +	 * on other cpus will try to directly access the counter too without
> +	 * calling pmu_sbi_ctr_start.
> +	 */
> +	if (event->hw.flags & PERF_EVENT_FLAG_USER_ACCESS)
> +		on_each_cpu_mask(mm_cpumask(mm),
> +				 pmu_sbi_set_scounteren, (void *)event, 1);
> +}
> +
> +static void pmu_sbi_event_unmapped(struct perf_event *event, struct mm_struct *mm)
> +{
> +	if (event->hw.flags & PERF_EVENT_FLAG_NO_USER_ACCESS)
> +		return;
> +
> +	if (event->hw.flags & PERF_EVENT_FLAG_LEGACY) {
> +		if (event->attr.config != PERF_COUNT_HW_CPU_CYCLES &&
> +		    event->attr.config != PERF_COUNT_HW_INSTRUCTIONS) {
> +			return;
> +		}
> +	}
> +
> +	/*
> +	 * Here we can directly remove user access since the user does not have
> +	 * access to the user page anymore so we avoid the racy window where the
> +	 * user could have read cap_user_rdpmc to true right before we disable
> +	 * it.
> +	 */
> +	event->hw.flags &= ~PERF_EVENT_FLAG_USER_READ_CNT;
> +
> +	if (event->hw.flags & PERF_EVENT_FLAG_USER_ACCESS)
> +		on_each_cpu_mask(mm_cpumask(mm),
> +				 pmu_sbi_reset_scounteren, (void *)event, 1);
> +}
> +
> +static void riscv_pmu_update_counter_access(void *info)
> +{
> +	if (sysctl_perf_user_access == SYSCTL_LEGACY)
> +		csr_write(CSR_SCOUNTEREN, 0x7);
> +	else
> +		csr_write(CSR_SCOUNTEREN, 0x2);
> +}
> +
> +static int riscv_pmu_proc_user_access_handler(struct ctl_table *table,
> +					      int write, void *buffer,
> +					      size_t *lenp, loff_t *ppos)
> +{
> +	int prev = sysctl_perf_user_access;
> +	int ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
> +
> +	/*
> +	 * Test against the previous value since we clear SCOUNTEREN when
> +	 * sysctl_perf_user_access is set to SYSCTL_USER_ACCESS, but we should
> +	 * not do that if that was already the case.
> +	 */
> +	if (ret || !write || prev == sysctl_perf_user_access)
> +		return ret;
> +
> +	on_each_cpu(riscv_pmu_update_counter_access, NULL, 1);
> +
> +	return 0;
> +}
> +
> +static struct ctl_table sbi_pmu_sysctl_table[] = {
> +	{
> +		.procname       = "perf_user_access",
> +		.data		= &sysctl_perf_user_access,
> +		.maxlen		= sizeof(unsigned int),
> +		.mode           = 0644,
> +		.proc_handler	= riscv_pmu_proc_user_access_handler,
> +		.extra1		= SYSCTL_ZERO,
> +		.extra2		= SYSCTL_TWO,
> +	},
> +	{ }
> +};
> +
>  static int pmu_sbi_device_probe(struct platform_device *pdev)
>  {
>  	struct riscv_pmu *pmu = NULL;
> @@ -888,6 +1062,10 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
>  	pmu->ctr_get_width = pmu_sbi_ctr_get_width;
>  	pmu->ctr_clear_idx = pmu_sbi_ctr_clear_idx;
>  	pmu->ctr_read = pmu_sbi_ctr_read;
> +	pmu->event_init = pmu_sbi_event_init;
> +	pmu->event_mapped = pmu_sbi_event_mapped;
> +	pmu->event_unmapped = pmu_sbi_event_unmapped;
> +	pmu->csr_index = pmu_sbi_csr_index;
>  
>  	ret = cpuhp_state_add_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
>  	if (ret)
> @@ -901,6 +1079,8 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto out_unregister;
>  
> +	register_sysctl("kernel", sbi_pmu_sysctl_table);
> +
>  	return 0;
>  
>  out_unregister:
> -- 
> 2.39.2
>

Other than the nits,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
