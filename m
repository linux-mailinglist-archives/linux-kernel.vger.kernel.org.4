Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4E15F5C6A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 00:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiJEWIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 18:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiJEWIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 18:08:49 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C1A83066
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 15:08:41 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d10so260526pfh.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 15:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9svDT8ORTcq0fWO9r8OMLcDTyMMPAPgB288zzZCitY0=;
        b=oDFGMldwG8KZwyaCLbdaQPftkZxN3Moa8DT7hu2fp/5dKSDSPz/gpganRpov4mgikd
         IxtVOUJdJb8pETiG7IeSMayqcUVpwSKPJ8Rg4la7zDGCMqPv/f0eal5lej2C/gl9uhQj
         90kNESY5GaWQlNtWmCremFWjchXUgdezl0oKH9ZnVZcKdVDT9AM/HvnJeVjRLACdeOI0
         Ro6uPKzZNlbpoOHfaISusIzalGjBw4p3IcMCGfkKCJbvH0jeJRnyDhbtmaz3L93bOxZw
         3Zh2s9t3DqxaCf9AF/DyLGdMsX8XKJJo/vU3E4WflKrEZ3NCyWB5On0em0V2TRrNvvdM
         HC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9svDT8ORTcq0fWO9r8OMLcDTyMMPAPgB288zzZCitY0=;
        b=W0t3r4iLRsX50SInx9tVP/ssHmoPOY00SlYxXT5ouHCimzc0/EKp0aauN8/iv6XCM+
         3dPKuOM7S1ZLte/Wqpp+oWllEC/fxGtcopabIL2c44ibKteYlMbPfHt7twORDIo0zjPC
         BUdxCokAcPQ/3tAUh3M3oAHYzVh/kNCpQcLZsBrS5u2tDKXDBcHjCHOBDvc1O0BuVHm6
         p6/RR8yaPcqxiwj2JrFZ1hhJNyVshKATBOPbVkjGYQp/KMwW69msxBUCCieBotJdDjiB
         GY7xlaHn/AqloDznGDGoduUhFUgd5dgEZhl8VFfe8zNx4MY0/PelVjnYWVs1BDkLMs6L
         nwmw==
X-Gm-Message-State: ACrzQf1W/PB7mrcpllErA7+O9STks/eVjSVSP7fX2eSbPob2rvgwINSE
        UYnlc+4tMIgd+XiFxxwaaNh6Gw==
X-Google-Smtp-Source: AMsMyM4Qv3EPnbEPt5IAw3TfyWB5j7sKL+5LeDE+z/8pFek4M6fYLCe4pyOuY8embZ2T6oUiwC0+iQ==
X-Received: by 2002:a63:fa42:0:b0:44d:b59c:674b with SMTP id g2-20020a63fa42000000b0044db59c674bmr1604886pgk.207.1665007721016;
        Wed, 05 Oct 2022 15:08:41 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id c13-20020a170902d48d00b0016c0eb202a5sm10996155plg.225.2022.10.05.15.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 15:08:40 -0700 (PDT)
Date:   Wed, 5 Oct 2022 22:08:37 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sandipan Das <sandipan.das@amd.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [kvm-unit-tests PATCH 2/2] x86/pmu: Add AMD Guest PerfMonV2
 testcases
Message-ID: <Yz4AZZWE1/wWhXFP@google.com>
References: <20220905123946.95223-1-likexu@tencent.com>
 <20220905123946.95223-7-likexu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905123946.95223-7-likexu@tencent.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can you provide a single series for all of the KVM-Unit-Tests PMU work (separate
from the KVM patches)?  Ya, it'll be big and is a blatant violation of "do one
thing", but trying to manually handle the dependencies on the review side is time
consuming.

One thought to help keep track of dependencies between KVM and KUT would be to
add dummy commits between each sub-series, with the dummy commit containing a lore
link to the relevant KVM patches/series.  That would allow throwing everything into
one series without losing track of things.  Hopefully.

On Mon, Sep 05, 2022, Like Xu wrote:
> diff --git a/lib/x86/processor.h b/lib/x86/processor.h
> index 9c490d9..b9592c4 100644
> --- a/lib/x86/processor.h
> +++ b/lib/x86/processor.h
> @@ -796,8 +796,12 @@ static inline void flush_tlb(void)
>  
>  static inline u8 pmu_version(void)
>  {
> -	if (!is_intel())
> +	if (!is_intel()) {
> +		/* Performance Monitoring Version 2 Supported */
> +		if (cpuid(0x80000022).a & 0x1)

Add an X86_FEATURE_*, that way this is self-documenting.

> +			return 2;
>  		return 0;
> +	}
>  
>  	return cpuid(10).a & 0xff;
>  }
> @@ -824,6 +828,9 @@ static inline u8 pmu_nr_gp_counters(void)
>  {
>  	if (is_intel()) {
>  		return (cpuid(10).a >> 8) & 0xff;
> +	} else if (this_cpu_has_perf_global_ctrl()) {

Eww.  Took me too long to connect the dots to understand how this guarantees that
leaf 0x80000022 is available.  With an X86_FEATURE_* this can simply be:

	} else if (this_cpu_has(X86_FEATURE_AMD_PMU_V2) {

or whatever name is appropriate.

> +		/* Number of Core Performance Counters. */
> +		return cpuid(0x80000022).b & 0xf;
>  	} else if (!has_amd_perfctr_core()) {
>  		return AMD64_NUM_COUNTERS;
>  	}
> diff --git a/x86/pmu.c b/x86/pmu.c
> index 11607c0..6d5363b 100644
> --- a/x86/pmu.c
> +++ b/x86/pmu.c
> @@ -72,6 +72,9 @@ struct pmu_event {
>  #define PMU_CAP_FW_WRITES	(1ULL << 13)
>  static u32 gp_counter_base;
>  static u32 gp_select_base;
> +static u32 global_status_msr;
> +static u32 global_ctl_msr;
> +static u32 global_status_clr_msr;

What do you think about naming these like MSR #defines?  E.g.

  MSR_PERF_GLOBAL_CTRL
  MSR_PERF_GLOBAL_STATUS
  MSR_PERF_GLOBAL_STATUS_CLR

There's a little risk of causing confusing, but I think it would make the code
easier to read.

>  static unsigned int gp_events_size;
>  static unsigned int nr_gp_counters;
>  
> @@ -150,8 +153,7 @@ static void global_enable(pmu_counter_t *cnt)
>  		return;
>  
>  	cnt->idx = event_to_global_idx(cnt);
> -	wrmsr(MSR_CORE_PERF_GLOBAL_CTRL, rdmsr(MSR_CORE_PERF_GLOBAL_CTRL) |
> -			(1ull << cnt->idx));
> +	wrmsr(global_ctl_msr, rdmsr(global_ctl_msr) | (1ull << cnt->idx));

Opportunistically use BIT_ULL().

>  }
>  
>  static void global_disable(pmu_counter_t *cnt)
> @@ -159,8 +161,7 @@ static void global_disable(pmu_counter_t *cnt)
>  	if (pmu_version() < 2)
>  		return;
>  
> -	wrmsr(MSR_CORE_PERF_GLOBAL_CTRL, rdmsr(MSR_CORE_PERF_GLOBAL_CTRL) &
> -			~(1ull << cnt->idx));
> +	wrmsr(global_ctl_msr, rdmsr(global_ctl_msr) & ~(1ull << cnt->idx));

BIT_ULL()

>  }
>  
>  static inline uint32_t get_gp_counter_msr(unsigned int i)
> @@ -326,6 +327,23 @@ static void check_counters_many(void)
>  	report(i == n, "all counters");
>  }
>  
> +static bool is_the_count_reproducible(pmu_counter_t *cnt)
> +{
> +	unsigned int i;
> +	uint64_t count;
> +
> +	__measure(cnt, 0);
> +	count = cnt->count;
> +
> +	for (i = 0; i < 10; i++) {
> +		__measure(cnt, 0);
> +		if (count != cnt->count)
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
>  static void check_counter_overflow(void)
>  {
>  	uint64_t count;
> @@ -334,13 +352,14 @@ static void check_counter_overflow(void)
>  		.ctr = gp_counter_base,
>  		.config = EVNTSEL_OS | EVNTSEL_USR | (*gp_events)[1].unit_sel /* instructions */,
>  	};
> +	bool precise_event = is_the_count_reproducible(&cnt);
> +
>  	__measure(&cnt, 0);
>  	count = cnt.count;
>  
>  	/* clear status before test */
>  	if (pmu_version() > 1) {

Please provide helper(s) to replace the myriad open coded "pmu_version() > ???"
checks.  E.g. this one appears to be:

	if (this_cpu_has_perf_global_status_clr())

I obviously don't care about the verbosity, it's that people like me might not
know what the PMU version has to do with an MSR being accessible.
