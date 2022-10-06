Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788CA5F6839
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 15:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbiJFNc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 09:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbiJFNcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 09:32:51 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F3EABD68
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 06:32:27 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id kg6so4555733ejc.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 06:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jLWyENnFNe547LYKA1l7p+V/55M9Qg7wqXNSQA+tPh4=;
        b=nfG8TGPZxwjq9nowPYag+alN8xtu6pejhDtfYE3OhQch5uXaWTBml/QIGfPxYDUNwu
         +WXVC7j1jDM33vPzl1VBqXVPTPXxIrHOnIKLJPe6xptKo6mInngkiHKX3HJLCm09bDB+
         GyFh2WHI6SIl4eSfO8Evw75JTMX4gm3DxD5EZkGNGd6bTO9A3qjQrphbIJLLRWkFd7gQ
         ORT1z5SjhmXjqEQC5y3GIwMLELg1u6TK++pgfuJ2LYDNMSKRru9GVT8g7EcJWVQhvLhP
         nio6yB/9ntQLDq5Cn1fJIDTBxvrNKxtrxmlXJccLrjfYw24ZOqVhvybo3WUYcFfU1I+H
         t1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jLWyENnFNe547LYKA1l7p+V/55M9Qg7wqXNSQA+tPh4=;
        b=6DmF7eGzdeioIYx8AwW0RRL6qjiNuPkHPSlRIXeS/Ccn/gSVR/imASRnLQSW8bm51+
         5RhME97yyVXwU7aPSP+csxGaCcZ/OrfSTSjNOHzapbvVl4tJqECIGMEcQ68Ng9yvI8eA
         TUEt9UnUw7cRsc6iGGwtS8WDfuiwTUf17Av7tmJlMDNOiPSqANsGjWyGi9MZznMlcU3X
         GobU0zY1VyV6vq9Nj2S1nCnTTzyNEUtcwWl2iUrgwsnINGeCYr6ioyElJCimlt7zQTaL
         n9epolFoM8/7u++gjnZZuxgnvxg6I0kAvHqbdK0WldFED8EFNk90Qfk4CfCgHwEff4A0
         UNMA==
X-Gm-Message-State: ACrzQf2w/kUv7SwwYvRIkuCrEIyGQ3pEmoOSTpNBXYXUKAIFQv1ymihY
        ZfACIV46ADDnGGRg5KQvPB3BC2KE3nrtZA==
X-Google-Smtp-Source: AMsMyM6YGeAonCo9d5iqTsdyfBooPTFkF3ZB935YD873xQHdht4JfA2MNitsVbozbRgnrNAha2YkmA==
X-Received: by 2002:a17:907:7210:b0:783:37b0:b5ca with SMTP id dr16-20020a170907721000b0078337b0b5camr3937247ejc.689.1665063067246;
        Thu, 06 Oct 2022 06:31:07 -0700 (PDT)
Received: from localhost (cst2-173-61.cust.vodafone.cz. [31.30.173.61])
        by smtp.gmail.com with ESMTPSA id d1-20020a170906304100b00788c622fa2csm9459973ejd.135.2022.10.06.06.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 06:31:06 -0700 (PDT)
Date:   Thu, 6 Oct 2022 15:31:05 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] riscv: cpufeature: extend
 riscv_cpufeature_patch_func to all ISA extensions
Message-ID: <20221006133105.hj3r2z4loybsfeqe@kamzik>
References: <20221006070818.3616-1-jszhang@kernel.org>
 <20221006070818.3616-5-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006070818.3616-5-jszhang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 03:08:14PM +0800, Jisheng Zhang wrote:
> make the riscv_cpufeature_patch_func() scan all ISA extensions rather
> than limited feature macros.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/include/asm/errata_list.h |  9 ++--
>  arch/riscv/kernel/cpufeature.c       | 61 +++-------------------------
>  2 files changed, 9 insertions(+), 61 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
> index 19a771085781..722525f4fc96 100644
> --- a/arch/riscv/include/asm/errata_list.h
> +++ b/arch/riscv/include/asm/errata_list.h
> @@ -6,6 +6,7 @@
>  #define ASM_ERRATA_LIST_H
>  
>  #include <asm/alternative.h>
> +#include <asm/hwcap.h>
>  #include <asm/vendorid_list.h>
>  
>  #ifdef CONFIG_ERRATA_SIFIVE
> @@ -20,10 +21,6 @@
>  #define	ERRATA_THEAD_NUMBER 2
>  #endif
>  
> -#define	CPUFEATURE_SVPBMT 0
> -#define	CPUFEATURE_ZICBOM 1
> -#define	CPUFEATURE_NUMBER 2
> -
>  #ifdef __ASSEMBLY__
>  
>  #define ALT_INSN_FAULT(x)						\
> @@ -53,7 +50,7 @@ asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,	\
>  #define ALT_SVPBMT(_val, prot)						\
>  asm(ALTERNATIVE_2("li %0, 0\t\nnop",					\
>  		  "li %0, %1\t\nslli %0,%0,%3", 0,			\
> -			CPUFEATURE_SVPBMT, CONFIG_RISCV_ISA_SVPBMT,	\
> +			RISCV_ISA_EXT_SVPBMT, CONFIG_RISCV_ISA_SVPBMT,	\
>  		  "li %0, %2\t\nslli %0,%0,%4", THEAD_VENDOR_ID,	\
>  			ERRATA_THEAD_PBMT, CONFIG_ERRATA_THEAD_PBMT)	\
>  		: "=r"(_val)						\
> @@ -127,7 +124,7 @@ asm volatile(ALTERNATIVE_2(						\
>  	"add a0, a0, %0\n\t"						\
>  	"2:\n\t"							\
>  	"bltu a0, %2, 3b\n\t"						\
> -	"nop", 0, CPUFEATURE_ZICBOM, CONFIG_RISCV_ISA_ZICBOM,		\
> +	"nop", 0, RISCV_ISA_EXT_ZICBOM, CONFIG_RISCV_ISA_ZICBOM,	\
>  	"mv a0, %1\n\t"							\
>  	"j 2f\n\t"							\
>  	"3:\n\t"							\
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index afa54635c180..2b1f18f97253 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -251,61 +251,11 @@ void __init riscv_fill_hwcap(void)
>  }
>  
>  #ifdef CONFIG_RISCV_ALTERNATIVE
> -static bool __init_or_module cpufeature_probe_svpbmt(unsigned int stage)
> -{
> -#ifdef CONFIG_RISCV_ISA_SVPBMT
> -	switch (stage) {
> -	case RISCV_ALTERNATIVES_EARLY_BOOT:
> -		return false;
> -	default:
> -		return riscv_isa_extension_available(NULL, SVPBMT);
> -	}
> -#endif
> -
> -	return false;
> -}
> -
> -static bool __init_or_module cpufeature_probe_zicbom(unsigned int stage)
> -{
> -#ifdef CONFIG_RISCV_ISA_ZICBOM
> -	switch (stage) {
> -	case RISCV_ALTERNATIVES_EARLY_BOOT:
> -		return false;
> -	default:
> -		return riscv_isa_extension_available(NULL, ZICBOM);
> -	}
> -#endif
> -
> -	return false;
> -}
> -
> -/*
> - * Probe presence of individual extensions.
> - *
> - * This code may also be executed before kernel relocation, so we cannot use
> - * addresses generated by the address-of operator as they won't be valid in
> - * this context.
> - */
> -static u32 __init_or_module cpufeature_probe(unsigned int stage)
> -{
> -	u32 cpu_req_feature = 0;
> -
> -	if (cpufeature_probe_svpbmt(stage))
> -		cpu_req_feature |= (1U << CPUFEATURE_SVPBMT);
> -
> -	if (cpufeature_probe_zicbom(stage))
> -		cpu_req_feature |= (1U << CPUFEATURE_ZICBOM);
> -
> -	return cpu_req_feature;
> -}
> -
>  void __init_or_module riscv_cpufeature_patch_func(struct alt_entry *begin,
>  						  struct alt_entry *end,
>  						  unsigned int stage)
>  {
> -	u32 cpu_req_feature = cpufeature_probe(stage);
>  	struct alt_entry *alt;
> -	u32 tmp;
>  
>  	if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
>  		return;
> @@ -313,15 +263,16 @@ void __init_or_module riscv_cpufeature_patch_func(struct alt_entry *begin,
>  	for (alt = begin; alt < end; alt++) {
>  		if (alt->vendor_id != 0)
>  			continue;
> -		if (alt->errata_id >= CPUFEATURE_NUMBER) {
> -			WARN(1, "This feature id:%d is not in kernel cpufeature list",
> +		if (alt->errata_id >= RISCV_ISA_EXT_ID_MAX) {

Ok, so RISCV_ISA_EXT_ID_MAX is used here now, but we could use
RISCV_ISA_EXT_MAX directly instead.

> +			WARN(1, "This extension id:%d is not in ISA extension list",
                                                               ^ the
>  				alt->errata_id);
>  			continue;
>  		}
>  
> -		tmp = (1U << alt->errata_id);
> -		if (cpu_req_feature & tmp)
> -			patch_text_nosync(alt->old_ptr, alt->alt_ptr, alt->alt_len);
> +		if (!test_bit(alt->errata_id, riscv_isa))

Maybe avoid using riscv_isa directly in case we want to move this function
out of cpufeature.c some day?

  if (!__riscv_isa_extension_available(NULL, alt->errata_id))


> +			continue;
> +
> +		patch_text_nosync(alt->old_ptr, alt->alt_ptr, alt->alt_len);
>  	}
>  }
>  #endif
> -- 
> 2.37.2
>

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
