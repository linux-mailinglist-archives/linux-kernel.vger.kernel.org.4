Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8E2608F78
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 21:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiJVTy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 15:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiJVTyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 15:54:55 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFA9EE29
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 12:54:52 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id a67so17648529edf.12
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 12:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3HfWPRu5q58QJ1JKXH68bmCGHok/snJYWZPaSUmG49w=;
        b=iy6YbSr70F78qE2NooxPIao3DPxphTPr9RnYeG3jQ0tTosLAp2CQoReO6/hn3dnB8b
         qtAIXo/uoBNqOAPAk+wVcxRNkQGo7WjvQ/k3KPJryfAMYaLt24FHfsCR4GWLj7Gx+a5J
         EHtgQ5CvYXXcSVGFaHMsHKnwVj0q2fEu0hfhRff9mRkniVjUyvRsLuXo4gxzDWxKmMw8
         wTYm3y5aQ+AbNCMe5kalWnrNySTgUOGwF2dUT1His7LtFE+AmLoejKXxqoWqiHLlfE7l
         kaXm3pD49DMxtPGvTPxz3JMAjvCQiu21bmvevaSr+VDC+4korJeZhgtInOcGoBa7bL1g
         pU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3HfWPRu5q58QJ1JKXH68bmCGHok/snJYWZPaSUmG49w=;
        b=gn+RheQrrKa1M6mHsZw17v6HAxI8arPfi0fNEw39Udr3UTup/shd7OLXgc2X7y9QQL
         P+nDEZvjF31zBU2GKstwljgH7v5LnyUkPIm6Vn8w0RRoRY5fe6xj9/0uxG8o1d8e2e3B
         e5opsTzKHGrO/8xndMBgkFd1PGI20JOsGE9NT+4IP1/p1VgkCDR+jIe+xvwWecTD9VTc
         ahzwUyPRq3YNfNFHd/kP51TNrjLjEFbUgpgEhrJ3pfTRamNEjyv1D3VCAwJ0k7Vp0MvG
         Vd8ywIaeTK6MKOE2Rud8N88UyWr97WSA98TV9Mqgi0GTDj20Yd4xxeYXV/Fp+b9W30uT
         odIQ==
X-Gm-Message-State: ACrzQf230gMgXOlSk+2LVx3BPm9pSxtMBVXqJJTsAfYvmFBoE7QRI+n9
        KWXcHdAZdoAyUWl5XjrSLu2jLMO+jrpulA==
X-Google-Smtp-Source: AMsMyM5B4qLC2JNOJa9o1IXQHrOZMCtNDiSgCHnorj368usir9HcPehxyyr20AxDJFnoc7Rps0p7Ig==
X-Received: by 2002:a17:907:94d1:b0:790:65a:3a18 with SMTP id dn17-20020a17090794d100b00790065a3a18mr20584651ejc.428.1666468491062;
        Sat, 22 Oct 2022 12:54:51 -0700 (PDT)
Received: from andrea (host-87-17-41-249.retail.telecomitalia.it. [87.17.41.249])
        by smtp.gmail.com with ESMTPSA id cx25-20020a05640222b900b004482dd03fe8sm15453828edb.91.2022.10.22.12.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 12:54:50 -0700 (PDT)
Date:   Sat, 22 Oct 2022 21:54:45 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v2] riscv: fix race when vmap stack overflow
Message-ID: <Y1RKFXEc5mqwQz6l@andrea>
References: <20221020143329.3276-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020143329.3276-1-jszhang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 10:33:29PM +0800, Jisheng Zhang wrote:
> Currently, when detecting vmap stack overflow, riscv firstly switches
> to the so called shadow stack, then use this shadow stack to call the
> get_overflow_stack() to get the overflow stack. However, there's
> a race here if two or more harts use the same shadow stack at the same
> time.
> 
> To solve this race, we introduce spin_shadow_stack atomic var, which
> will be swap between its own address and 0 in atomic way, when the
> var is set, it means the shadow_stack is being used; when the var
> is cleared, it means the shadow_stack isn't being used.
> 
> Fixes: 31da94c25aea ("riscv: add VMAP_STACK overflow detection")
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Suggested-by: Guo Ren <guoren@kernel.org>
> ---
> Since v1:
>  - use smp_store_release directly
>  - use unsigned int instead of atomic_t
> 
>  arch/riscv/kernel/entry.S | 4 ++++
>  arch/riscv/kernel/traps.c | 4 ++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index b9eda3fcbd6d..7b924b16792b 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -404,6 +404,10 @@ handle_syscall_trace_exit:
>  
>  #ifdef CONFIG_VMAP_STACK
>  handle_kernel_stack_overflow:
> +1:	la sp, spin_shadow_stack
> +	amoswap.w sp, sp, (sp)
> +	bnez sp, 1b
> +
>  	la sp, shadow_stack
>  	addi sp, sp, SHADOW_OVERFLOW_STACK_SIZE
>  
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index f3e96d60a2ff..f1f57c1241b6 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -221,11 +221,15 @@ asmlinkage unsigned long get_overflow_stack(void)
>  		OVERFLOW_STACK_SIZE;
>  }
>  
> +unsigned int spin_shadow_stack;
> +
>  asmlinkage void handle_bad_stack(struct pt_regs *regs)
>  {
>  	unsigned long tsk_stk = (unsigned long)current->stack;
>  	unsigned long ovf_stk = (unsigned long)this_cpu_ptr(overflow_stack);
>  
> +	smp_store_release(&spin_shadow_stack, 0);
> +

Maybe add a comment integrating Guo's remarks,

  https://lore.kernel.org/all/CAJF2gTRAEX_jQ_w5H05dyafZzHq+P5j05TJ=C+v+OL__GQam4A@mail.gmail.com/T/#u
  https://lore.kernel.org/all/CAJF2gTRdtcpccL5W48O8VEXCMvxNAyyrKJzhwNJkc8js+H2iJg@mail.gmail.com/T/#u

It will come in handy to future reviewers (and it would address the
checkpatch.pl's "memory barrier without comment" warning).

Thanks,
  Andrea


>  	console_verbose();
>  
>  	pr_emerg("Insufficient stack space to handle exception!\n");
> -- 
> 2.37.2
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
