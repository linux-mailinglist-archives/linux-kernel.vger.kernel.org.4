Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF99F5F6854
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 15:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbiJFNjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 09:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbiJFNjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 09:39:03 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1831AABD75
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 06:38:53 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id r17so4632304eja.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 06:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sUDJFwpi3D9p54FCGhtc/TJtBY99tL98QNMdHSax0Nw=;
        b=O4jzZcjYNcIZT7UDHuBzKPGPtHMrh/6Z5hwV4bb1unQUPxIovugk8H1NvFxz8iSEgv
         jSn3cjGLo/uuMLBVPmnzyT1cZzeUuETKt4B08tNhMFXnOij7PYbcWjZ+qJuHFpo6dbeE
         Kiz3226r6+pGi1kuDflonGZa2V7FZbD0ta/fc666m94jv/GnmjkavvLQIqUOR9F9BcUk
         K43LzAJtlxdyOMLuKmS5uFKAbhRytFx4Ynp8T7ErDikGMherBB6+UJHjsW2y/mRrhGtW
         Sc3cINu9Az9PFVPB56DjlQ6sU9KDyamomme3E6p54QnWpD9eXrw22RWJpPZgSv65dS9B
         m1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUDJFwpi3D9p54FCGhtc/TJtBY99tL98QNMdHSax0Nw=;
        b=C08z0jvKcv7Ss05cV+2rN/niHa8OUixArMJpfgIEuBjdO4iMFy1SnXmx/MO0MIElyn
         NA8EsWJl7DqquTfrZSCGQhkh8pheDn0k7cXkEQrJB8qp0saCkYV19okouoJTRnYoNYw5
         RVygyc/A6VanDOWRnaQISiSsWpoxvPqumsFo6i4xSQSIL4G5CuOblsOFUTokZTYrzlqK
         fQFiE5mQIXkmSvqpufGslN/5mw2Y0U+eU62TE6bbaXDD99potlFl3/mRK4arvGCoXDX6
         4EhKIi476g1/0Ukz5Ha6Yy3rMCVSWV8KFx4qSD0SXauoBRjfjWmDALu/XQtsNd8G5Mec
         GOzQ==
X-Gm-Message-State: ACrzQf2A11FKN0WTSetBs/NG1XNMSXAazpwcGYJX4q+srTH91sxdevdO
        FYR9+sxjtyjzhlFIqu+JoC9kMA==
X-Google-Smtp-Source: AMsMyM4zztHFjkSy6dGW91nxRT6YpzNMD5p9mKeSvTg+RiDwHxlP/A3a0eV47w38Rix7Cny4p7qGng==
X-Received: by 2002:a17:907:2719:b0:782:b261:e9eb with SMTP id w25-20020a170907271900b00782b261e9ebmr4202845ejk.104.1665063531988;
        Thu, 06 Oct 2022 06:38:51 -0700 (PDT)
Received: from localhost (cst2-173-61.cust.vodafone.cz. [31.30.173.61])
        by smtp.gmail.com with ESMTPSA id oz35-20020a1709077da300b0073022b796a7sm10495703ejc.93.2022.10.06.06.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 06:38:51 -0700 (PDT)
Date:   Thu, 6 Oct 2022 15:38:50 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] riscv: remove riscv_isa_ext_keys[] array and related
 usage
Message-ID: <20221006133850.vkmy466uuzliobjw@kamzik>
References: <20221006070818.3616-1-jszhang@kernel.org>
 <20221006070818.3616-9-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006070818.3616-9-jszhang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 03:08:18PM +0800, Jisheng Zhang wrote:
> All users have switched to riscv_has_extension_*, removed unused
> definitions, vars and related setting code.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/include/asm/hwcap.h | 28 ----------------------------
>  arch/riscv/kernel/cpufeature.c |  9 ---------

Nice stats :-)

>  2 files changed, 37 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index 54b88ee6cae1..f52fbc121ebe 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -62,18 +62,6 @@ enum {
>  
>  extern unsigned long elf_hwcap;
>  
> -
> -/*
> - * This enum represents the logical ID for each RISC-V ISA extension static
> - * keys. We can use static key to optimize code path if some ISA extensions
> - * are available.
> - */
> -enum riscv_isa_ext_key {
> -	RISCV_ISA_EXT_KEY_FPU,		/* For 'F' and 'D' */
> -	RISCV_ISA_EXT_KEY_ZIHINTPAUSE,
> -	RISCV_ISA_EXT_KEY_MAX,
> -};
> -
>  struct riscv_isa_ext_data {
>  	/* Name of the extension displayed to userspace via /proc/cpuinfo */
>  	char uprop[RISCV_ISA_EXT_NAME_LEN_MAX];
> @@ -81,22 +69,6 @@ struct riscv_isa_ext_data {
>  	unsigned int isa_ext_id;
>  };
>  
> -extern struct static_key_false riscv_isa_ext_keys[RISCV_ISA_EXT_KEY_MAX];
> -
> -static __always_inline int riscv_isa_ext2key(int num)
> -{
> -	switch (num) {
> -	case RISCV_ISA_EXT_f:
> -		return RISCV_ISA_EXT_KEY_FPU;
> -	case RISCV_ISA_EXT_d:
> -		return RISCV_ISA_EXT_KEY_FPU;
> -	case RISCV_ISA_EXT_ZIHINTPAUSE:
> -		return RISCV_ISA_EXT_KEY_ZIHINTPAUSE;
> -	default:
> -		return -EINVAL;
> -	}
> -}

Yay! One less extension mapping to track!

> -
>  static __always_inline bool
>  riscv_has_extension_likely(const unsigned long ext)
>  {
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 2b1f18f97253..6bc3fb749274 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -28,9 +28,6 @@ unsigned long elf_hwcap __read_mostly;
>  /* Host ISA bitmap */
>  static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
>  
> -DEFINE_STATIC_KEY_ARRAY_FALSE(riscv_isa_ext_keys, RISCV_ISA_EXT_KEY_MAX);
> -EXPORT_SYMBOL(riscv_isa_ext_keys);
> -
>  /**
>   * riscv_isa_extension_base() - Get base extension word
>   *
> @@ -242,12 +239,6 @@ void __init riscv_fill_hwcap(void)
>  		if (elf_hwcap & BIT_MASK(i))
>  			print_str[j++] = (char)('a' + i);
>  	pr_info("riscv: ELF capabilities %s\n", print_str);
> -
> -	for_each_set_bit(i, riscv_isa, RISCV_ISA_EXT_MAX) {
> -		j = riscv_isa_ext2key(i);
> -		if (j >= 0)
> -			static_branch_enable(&riscv_isa_ext_keys[j]);
> -	}
>  }
>  
>  #ifdef CONFIG_RISCV_ALTERNATIVE
> -- 
> 2.37.2
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
