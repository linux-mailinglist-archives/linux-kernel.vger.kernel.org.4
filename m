Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7553962B575
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 09:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbiKPIpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 03:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbiKPIpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 03:45:44 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73C819009
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 00:45:43 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id gv23so9622461ejb.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 00:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UEZ09dkupGOo3xXcLbSG5+c4w31xZYyKp2/9cbD0Y9A=;
        b=lDDFPoL6oHwy109XGi4/sz0M+BHdJSbE2zkOFdkJ5N3ENut10XegQf6XHb0M7eNjEh
         3nBCI4CypfugjLpQkIkO6araKQ4FbaodkJXEbEUPUaTh6jB8oHHNuimCXOHFoiePbD/5
         WaWP+8FSRgRDZBSRWP2ZV4evVo1eVMBrFSfVt8Dog/Ljx0HS2XJKFvkU0Hi6wfHRNZAa
         o6rWbugT/r/YIu7JnP8CTUbWgYpvO6TM7CkUNe6833wBHsIcNCn3KS/Y9rPHrZc8zKtS
         v5yMGBwX9A6ngtMprjkyf9QtqPgm5ciG4T1woWvpKCoJAp0zc+UmhXsj4UEvw1UJ/8LC
         5TQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UEZ09dkupGOo3xXcLbSG5+c4w31xZYyKp2/9cbD0Y9A=;
        b=4xhiZlUxIJ+cwxn+hi1gJN56UQIZhI8s1L0cuVWuW5TaIPzP+FHneX8EL1zZJoULlc
         okB78gSBQb9x5DC+Xye+0vtiuNtJKHZ5Y8OUgg46Obk+0fbQevera1jwgeVmNUBtX/9O
         NyFhyr/TWtraiYaoJONC2WrkONgkjdJtpprabS3wBYSfoIh+XNQbReTsAfUOW6H8YWzT
         QqVQiKKlrjnEwGWgT8RaASVJBinIByuOPSnImtdk/GKjsPkwj7SzguuyYSkZ0/myI81s
         UoLCnhHJcFSH89vw7kFrkL4zTlQm4HX4vkBSipjm6/0NZd/vvAsYDFFru6E+v1zMxVkU
         eJPQ==
X-Gm-Message-State: ANoB5plh/Ef25MvE/pjQFwF8pmC9mcphvNsgXUr3Umwyk3RajK53HQOF
        RnIEWxQSnm8l3NPiuCdC5HcPHA==
X-Google-Smtp-Source: AA0mqf6zGcBtNK1rK4xKOG0v95NApMPvWBjL6L4DGXBEWNMd8d5sVTR72FYbesN5H4lXaQmaZCUCkQ==
X-Received: by 2002:a17:906:344f:b0:79f:e0b3:3b99 with SMTP id d15-20020a170906344f00b0079fe0b33b99mr16745982ejb.381.1668588342285;
        Wed, 16 Nov 2022 00:45:42 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id h23-20020a170906585700b007317f017e64sm6572448ejs.134.2022.11.16.00.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 00:45:41 -0800 (PST)
Date:   Wed, 16 Nov 2022 09:45:40 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Song Shuai <suagrfillet@gmail.com>
Cc:     guoren@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
        mark.rutland@arm.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] riscv/ftrace: SAVE_ALL supports lightweight save
Message-ID: <20221116084540.aslzynq4bmar6f46@kamzik>
References: <20221116031305.286634-1-suagrfillet@gmail.com>
 <20221116031305.286634-3-suagrfillet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116031305.286634-3-suagrfillet@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 11:13:04AM +0800, Song Shuai wrote:
> In order to make the function graph use ftrace directly, ftrace_caller
> should be adjusted to save the necessary regs against the pt_regs layout
> so it can call ftrace_graph_func reasonably.
> 
> SAVE_ALL now saves all the regs according to the pt_regs struct. Here
> introduces a lightweight option for SAVE_ALL to save only the necessary
> regs for ftrace_caller.
> 
> For convenience, the original argument setup for the tracing function in
> ftrace_[regs]_caller is killed and appended to the tail of SAVE_ALL.
> 
> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> ---
>  arch/riscv/kernel/mcount-dyn.S | 110 +++++++++++++++++++++++++++------
>  1 file changed, 92 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
> index d171eca623b6..2f0a280bd7a0 100644
> --- a/arch/riscv/kernel/mcount-dyn.S
> +++ b/arch/riscv/kernel/mcount-dyn.S
> @@ -56,7 +56,51 @@
>  	.endm
>  
>  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> -	.macro SAVE_ALL
> +
> +/**
> +* SAVE_ALL - save regs against the pt_regs struct
> +*
> +* @all: tell if saving all the regs

I find it odd to have a macro name that includes 'ALL' in it
to require a parameter 'all' to be set in order to actually save
all. I suggest renaming the macro to something like SAVE_REGS.

> +*
> +* If all is set, all the regs will be saved, otherwise only ABI
> +* related regs (a0-a7,epc,ra and optional s0) will be saved.
> +*
> +* For convenience the argument setup for tracing function is appended here.
> +* Especially $sp is passed as the 4th argument of the tracing function.
> +*
> +* After the stack is established,
> +*
> +* 0(sp) stores the PC of the traced function which can be accessed
> +* by &(fregs)->regs->epc in tracing function. Note that the real
> +* function entry address should be computed with -FENTRY_RA_OFFSET.
> +*
> +* 8(sp) stores the function return address (i.e. parent IP) that
> +* can be accessed by &(fregs)->regs->ra in tracing function.
> +*
> +* The other regs are saved at the respective localtion and accessed
> +* by the respective pt_regs member.
> +*
> +* Here is the layout of stack for your reference.
> +*
> +*
> +*			=========
> +*			|  pip  |
> +* PT_SIZE_ON_STACK  ->  =========
> +*			+ ..... +
> +*			+ t3-t6 +
> +*			+ s2-s11+
> +*			+ a0-a7 + --++++-> ftrace_caller saved
> +*			+ s1    +   +
> +*			+ s0    + --+
> +*			+ t0-t2 +   +
> +*			+ tp    +   +
> +*			+ gp    +   +
> +*			+ sp    +   +
> +*			+ ra    + --+ // parent IP
> +*		sp  ->  + epc   + --+ // PC of the traced function
> +*			+++++++++
> +**/
> +	.macro SAVE_ALL, all=0
>  	addi	sp, sp, -SZREG
>  	addi	sp, sp, -PT_SIZE_ON_STACK
>  
> @@ -67,14 +111,8 @@
>  	REG_S x1,  PT_RA(sp)
>  	REG_L x1,  PT_EPC(sp)
>  
> -	REG_S x2,  PT_SP(sp)
> -	REG_S x3,  PT_GP(sp)
> -	REG_S x4,  PT_TP(sp)
> -	REG_S x5,  PT_T0(sp)
> -	REG_S x6,  PT_T1(sp)
> -	REG_S x7,  PT_T2(sp)
> -	REG_S x8,  PT_S0(sp)
> -	REG_S x9,  PT_S1(sp)
> +	/* always save the ABI regs */
> +
>  	REG_S x10, PT_A0(sp)
>  	REG_S x11, PT_A1(sp)
>  	REG_S x12, PT_A2(sp)
> @@ -83,6 +121,18 @@
>  	REG_S x15, PT_A5(sp)
>  	REG_S x16, PT_A6(sp)
>  	REG_S x17, PT_A7(sp)
> +
> +	/* save leftover regs for ftrace_regs_caller*/
> +
> +	.if \all == 1
> +	REG_S x2,  PT_SP(sp)
> +	REG_S x3,  PT_GP(sp)
> +	REG_S x4,  PT_TP(sp)
> +	REG_S x5,  PT_T0(sp)
> +	REG_S x6,  PT_T1(sp)
> +	REG_S x7,  PT_T2(sp)
> +	REG_S x8,  PT_S0(sp)
> +	REG_S x9,  PT_S1(sp)
>  	REG_S x18, PT_S2(sp)
>  	REG_S x19, PT_S3(sp)
>  	REG_S x20, PT_S4(sp)
> @@ -97,22 +147,31 @@
>  	REG_S x29, PT_T4(sp)
>  	REG_S x30, PT_T5(sp)
>  	REG_S x31, PT_T6(sp)
> +	.else
> +
> +	/* save s0 for ftrace_caller if FP_TEST defined */
> +
> +#ifdef HAVE_FUNCTION_GRAPH_FP_TEST
> +	REG_S x8,  PT_S0(sp)
> +#endif
> +	.endif
> +
> +	/* setup 4 args for tracing functions  */
> +
> +	addi	a0, ra, -FENTRY_RA_OFFSET // ip
> +	la	a1, function_trace_op
> +	REG_L	a2, 0(a1)		// op
> +	REG_L	a1, PT_SIZE_ON_STACK(sp) // parent_ip
> +	mv	a3, sp			// fregs

Please line up the comments.

>  	.endm
>  
> -	.macro RESTORE_ALL
> +	.macro RESTORE_ALL, all=0
>  	REG_L x1,  PT_RA(sp)
>  	addi	sp, sp, PT_SIZE_ON_STACK
>  	REG_S x1,  (sp)
>  	addi	sp, sp, -PT_SIZE_ON_STACK
>  	REG_L x1,  PT_EPC(sp)
> -	REG_L x2,  PT_SP(sp)
> -	REG_L x3,  PT_GP(sp)
> -	REG_L x4,  PT_TP(sp)
> -	REG_L x5,  PT_T0(sp)
> -	REG_L x6,  PT_T1(sp)
> -	REG_L x7,  PT_T2(sp)
> -	REG_L x8,  PT_S0(sp)
> -	REG_L x9,  PT_S1(sp)
> +
>  	REG_L x10, PT_A0(sp)
>  	REG_L x11, PT_A1(sp)
>  	REG_L x12, PT_A2(sp)
> @@ -121,6 +180,16 @@
>  	REG_L x15, PT_A5(sp)
>  	REG_L x16, PT_A6(sp)
>  	REG_L x17, PT_A7(sp)
> +
> +	.if \all == 1
> +	REG_L x2,  PT_SP(sp)
> +	REG_L x3,  PT_GP(sp)
> +	REG_L x4,  PT_TP(sp)
> +	REG_L x5,  PT_T0(sp)
> +	REG_L x6,  PT_T1(sp)
> +	REG_L x7,  PT_T2(sp)
> +	REG_L x8,  PT_S0(sp)
> +	REG_L x9,  PT_S1(sp)
>  	REG_L x18, PT_S2(sp)
>  	REG_L x19, PT_S3(sp)
>  	REG_L x20, PT_S4(sp)
> @@ -136,6 +205,11 @@
>  	REG_L x30, PT_T5(sp)
>  	REG_L x31, PT_T6(sp)
>  
> +	.else
> +#ifdef HAVE_FUNCTION_GRAPH_FP_TEST
> +	REG_L x8,  PT_S0(sp)
> +#endif
> +	.endif
>  	addi	sp, sp, PT_SIZE_ON_STACK
>  	addi	sp, sp, SZREG
>  	.endm
> -- 
> 2.20.1
> 
>

Thanks,
drew
