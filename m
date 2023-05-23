Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE2F70D760
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 10:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235993AbjEWI00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 04:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236324AbjEWIZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 04:25:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2408D18C
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 01:23:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8998139F;
        Tue, 23 May 2023 01:24:03 -0700 (PDT)
Received: from [10.162.42.7] (unknown [10.162.42.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF7893F762;
        Tue, 23 May 2023 01:23:15 -0700 (PDT)
Message-ID: <6fc450c6-98cb-5c14-8580-3f1a6b8ef10f@arm.com>
Date:   Tue, 23 May 2023 13:53:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH 1/5] arm64/sysreg: Remove some unused sysreg definitions
To:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev
References: <20230419-arm64-syreg-gen-v1-0-936cd769cb9e@kernel.org>
 <20230419-arm64-syreg-gen-v1-1-936cd769cb9e@kernel.org>
Content-Language: en-US
In-Reply-To: <20230419-arm64-syreg-gen-v1-1-936cd769cb9e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/22/23 21:52, Mark Brown wrote:
> Since there are no references to OSDTRRX_EL1 or OSECCR_EL1 in the code
> just remove the definitions rather than converting to automatic
> generation.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  arch/arm64/include/asm/sysreg.h | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 9e3ecba3c4e6..6505665624d4 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -134,11 +134,8 @@
>  #define SYS_SVCR_SMSTART_SM_EL0		sys_reg(0, 3, 4, 3, 3)
>  #define SYS_SVCR_SMSTOP_SMZA_EL0	sys_reg(0, 3, 4, 6, 3)
>  
> -#define SYS_OSDTRRX_EL1			sys_reg(2, 0, 0, 0, 2)
>  #define SYS_MDCCINT_EL1			sys_reg(2, 0, 0, 2, 0)
>  #define SYS_MDSCR_EL1			sys_reg(2, 0, 0, 2, 2)
> -#define SYS_OSDTRTX_EL1			sys_reg(2, 0, 0, 3, 2)
> -#define SYS_OSECCR_EL1			sys_reg(2, 0, 0, 6, 2)
>  #define SYS_DBGBVRn_EL1(n)		sys_reg(2, 0, 0, n, 4)
>  #define SYS_DBGBCRn_EL1(n)		sys_reg(2, 0, 0, n, 5)
>  #define SYS_DBGWVRn_EL1(n)		sys_reg(2, 0, 0, n, 6)
> 
