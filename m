Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493B266397C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 07:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjAJGtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 01:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjAJGss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 01:48:48 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 31BBF30558;
        Mon,  9 Jan 2023 22:48:46 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3D17AD7;
        Mon,  9 Jan 2023 22:49:27 -0800 (PST)
Received: from [10.162.42.6] (unknown [10.162.42.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E00AE3F71A;
        Mon,  9 Jan 2023 22:48:38 -0800 (PST)
Message-ID: <0cb01d4a-884e-0ee3-120e-b2df92b92a15@arm.com>
Date:   Tue, 10 Jan 2023 12:18:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4 1/8] perf: arm_spe: Use feature numbering for
 PMSEVFR_EL1 defines
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org,
        James Clark <james.clark@arm.com>
References: <20220825-arm-spe-v8-7-v4-0-327f860daf28@kernel.org>
 <20220825-arm-spe-v8-7-v4-1-327f860daf28@kernel.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220825-arm-spe-v8-7-v4-1-327f860daf28@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/10/23 00:56, Rob Herring wrote:
> Similar to commit 121a8fc088f1 ("arm64/sysreg: Use feature numbering for
> PMU and SPE revisions") use feature numbering instead of architecture
> versions for the PMSEVFR_EL1 Res0 defines.
> 
> Tested-by: James Clark <james.clark@arm.com>
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
> v4:
>  - Rebase on v6.2-rc1
> v3:
>  - No change
> v2:
>  - New patch
> ---
>  arch/arm64/include/asm/sysreg.h | 6 +++---
>  drivers/perf/arm_spe_pmu.c      | 4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 1312fb48f18b..c4ce16333750 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -273,11 +273,11 @@
>  #define SYS_PMSFCR_EL1_ST_SHIFT		18
>  
>  #define SYS_PMSEVFR_EL1			sys_reg(3, 0, 9, 9, 5)
> -#define SYS_PMSEVFR_EL1_RES0_8_2	\
> +#define PMSEVFR_EL1_RES0_IMP	\
>  	(GENMASK_ULL(47, 32) | GENMASK_ULL(23, 16) | GENMASK_ULL(11, 8) |\
>  	 BIT_ULL(6) | BIT_ULL(4) | BIT_ULL(2) | BIT_ULL(0))
> -#define SYS_PMSEVFR_EL1_RES0_8_3	\
> -	(SYS_PMSEVFR_EL1_RES0_8_2 & ~(BIT_ULL(18) | BIT_ULL(17) | BIT_ULL(11)))
> +#define PMSEVFR_EL1_RES0_V1P1	\
> +	(PMSEVFR_EL1_RES0_IMP & ~(BIT_ULL(18) | BIT_ULL(17) | BIT_ULL(11)))
>  
>  #define SYS_PMSLATFR_EL1		sys_reg(3, 0, 9, 9, 6)
>  #define SYS_PMSLATFR_EL1_MINLAT_SHIFT	0
> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> index 00e3a637f7b6..65cf93dcc8ee 100644
> --- a/drivers/perf/arm_spe_pmu.c
> +++ b/drivers/perf/arm_spe_pmu.c
> @@ -677,11 +677,11 @@ static u64 arm_spe_pmsevfr_res0(u16 pmsver)
>  {
>  	switch (pmsver) {
>  	case ID_AA64DFR0_EL1_PMSVer_IMP:
> -		return SYS_PMSEVFR_EL1_RES0_8_2;
> +		return PMSEVFR_EL1_RES0_IMP;
>  	case ID_AA64DFR0_EL1_PMSVer_V1P1:
>  	/* Return the highest version we support in default */
>  	default:
> -		return SYS_PMSEVFR_EL1_RES0_8_3;
> +		return PMSEVFR_EL1_RES0_V1P1;
>  	}
>  }
>  
> 
