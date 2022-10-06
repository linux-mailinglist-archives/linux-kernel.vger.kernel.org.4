Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBB05F6648
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 14:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiJFMmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 08:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiJFMlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 08:41:53 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EEA9C2FA
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 05:41:52 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id bj12so4190768ejb.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 05:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=AK+3/ho4RvmuiMuVJwr3Rpg3eo+stcqQKAj7PVtNyyk=;
        b=Cn5WuPb4Je4FcUwPxSwP26BPdp11/zoskFJi5zb67Br/FE3od2wcCzBU9vAZAc9iVX
         2jZ1jngYT90kB69JX4wfUxYtSl0HShjHlB0fTVejxdULPmLS5Iyb3xq+dob4S4X+2InN
         OGJ/V0F8ZnG646cAcqFEsdNTsGzSw4zijnBZJOj72ttfr8lCWPIPzL1K65z2v46/ahkd
         nsEwXeCtXu3Ad4EhE4KStgBO9/QsjDNYFzPKBczoRFikiKSf2DPyWq6SU9lUu29GhMVU
         SHiqJVWRjPXwGCBpVOfvVKY3Jbb64nzyYK0YLwcPjEvd1yAd03Oy/QhuEGhOYhtzr6kM
         6LWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=AK+3/ho4RvmuiMuVJwr3Rpg3eo+stcqQKAj7PVtNyyk=;
        b=POfmo1VcfRKI1tZxGFKCqGAJTGrB4OWNVHov+s+pC4GdPkdfPPNxMMcGyIm7OYerqO
         4qFv3gBVqonfVti14k6/gk6gOQ6DfMjkAGO4MjNL6wt6QZP/WsirCYsZYpAiDsviQ+Gf
         dLbNFpDoZJq3xc/rke8ajSfNgfCWi+Sv7KUUENc1vNWHRMONmk3fmbSfYRn4uHWuwku/
         71jfRitehoYjBKbrRu+r2QHLun5x2EzW2znAbUQSFmoeHcwSswyhe627Vo2ACBRYyNsC
         1+RLrUM1hq8vBveWcUv2f9vzsAiyyvWY7tYhZAT6ZdhvmZ93X/V+LaZ0pKzV74AhRYzT
         Ix0Q==
X-Gm-Message-State: ACrzQf0aGRJEGcgIuAzUgRbU0oZMizqnnBTF+UZt7k7GpM7Itwb+7LLa
        J6m2UZGAZobIaEhloPMxI3AItQ==
X-Google-Smtp-Source: AMsMyM4scPQ+Y5tFL519YUkAx65QeYpdy6w2QhHwhZZiZP7g4wirk8VfwX+qvhk5Zefggdmvnh97sA==
X-Received: by 2002:a17:906:9b8e:b0:78c:65a4:af84 with SMTP id dd14-20020a1709069b8e00b0078c65a4af84mr3755800ejc.127.1665060110985;
        Thu, 06 Oct 2022 05:41:50 -0700 (PDT)
Received: from localhost (cst2-173-61.cust.vodafone.cz. [31.30.173.61])
        by smtp.gmail.com with ESMTPSA id k7-20020a170906a38700b0078d2a2ca930sm2742860ejz.85.2022.10.06.05.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 05:41:50 -0700 (PDT)
Date:   Thu, 6 Oct 2022 14:41:44 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] riscv: jump_label: mark arguments as const to satisfy
 asm constraints
Message-ID: <20221006124144.abaz74g7nxrb5hxj@kamzik>
References: <20221006064028.548-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006064028.548-1-jszhang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 02:40:28PM +0800, Jisheng Zhang wrote:
> Samuel reported that the static branch usage in cpu_relax() breaks
> building with CONFIG_CC_OPTIMIZE_FOR_SIZE[1]:
> 
> In file included from <command-line>:
> ./arch/riscv/include/asm/jump_label.h: In function 'cpu_relax':
> ././include/linux/compiler_types.h:285:33: warning: 'asm' operand 0
> probably does not match constraints
>   285 | #define asm_volatile_goto(x...) asm goto(x)
>       |                                 ^~~
> ./arch/riscv/include/asm/jump_label.h:41:9: note: in expansion of macro
> 'asm_volatile_goto'
>    41 |         asm_volatile_goto(
>       |         ^~~~~~~~~~~~~~~~~
> ././include/linux/compiler_types.h:285:33: error: impossible constraint
> in 'asm'
>   285 | #define asm_volatile_goto(x...) asm goto(x)
>       |                                 ^~~
> ./arch/riscv/include/asm/jump_label.h:41:9: note: in expansion of macro
> 'asm_volatile_goto'
>    41 |         asm_volatile_goto(
>       |         ^~~~~~~~~~~~~~~~~
> make[1]: *** [scripts/Makefile.build:249:
> arch/riscv/kernel/vdso/vgettimeofday.o] Error 1
> make: *** [arch/riscv/Makefile:128: vdso_prepare] Error 2
> 
> Maybe "-Os" prevents GCC from detecting that the key/branch arguments
> can be treated as constants and used as immediate operands. Inspired
> by x86's commit 864b435514b2("x86/jump_label: Mark arguments as const to
> satisfy asm constraints"), and as pointed out by Steven in [2] "The "i"
> constraint needs to be a constant.", let's do similar modifications to
> riscv.
> 
> Tested by CC_OPTIMIZE_FOR_SIZE + gcc and CC_OPTIMIZE_FOR_SIZE + clang.
> 
> [1]https://lore.kernel.org/linux-riscv/20220922060958.44203-1-samuel@sholland.org/
> [2]https://lore.kernel.org/all/20210212094059.5f8d05e8@gandalf.local.home/
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/include/asm/jump_label.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/jump_label.h b/arch/riscv/include/asm/jump_label.h
> index 38af2ec7b9bf..6d58bbb5da46 100644
> --- a/arch/riscv/include/asm/jump_label.h
> +++ b/arch/riscv/include/asm/jump_label.h
> @@ -14,8 +14,8 @@
>  
>  #define JUMP_LABEL_NOP_SIZE 4
>  
> -static __always_inline bool arch_static_branch(struct static_key *key,
> -					       bool branch)
> +static __always_inline bool arch_static_branch(struct static_key * const key,
> +					       const bool branch)
>  {
>  	asm_volatile_goto(
>  		"	.option push				\n\t"
> @@ -35,8 +35,8 @@ static __always_inline bool arch_static_branch(struct static_key *key,
>  	return true;
>  }
>  
> -static __always_inline bool arch_static_branch_jump(struct static_key *key,
> -						    bool branch)
> +static __always_inline bool arch_static_branch_jump(struct static_key * const key,
> +						    const bool branch)
>  {
>  	asm_volatile_goto(
>  		"	.option push				\n\t"
> -- 
> 2.37.2
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
