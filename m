Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0045606C11
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 01:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiJTX0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 19:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiJTX01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 19:26:27 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0510C1D8F1C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 16:26:22 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id ot12so3258567ejb.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 16:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=apZEUeUXkxNIajez79xJytejwJ3FgKAFjaiHw46ypy0=;
        b=iUfPskxV7cbQERK1sx8pxMDt+pLYI/lY0JO9O2aq6ImLoGY3qte4OWHXDAnDlVxQOr
         uXw2OqcvvgD//rbNlYWMv4VBmnHTY5Oet13tUsTnx/d4J6L/hMPymw0XRvBzfAH9tjf4
         UPAJHnKOJmW+1m988Yy8fUPl7LING+AtJhyyO8efeD1uKIzORU0VJNeGjPOmiY16EkzD
         XcYE00crERhXRDUejQng72H9RT+v4sIzvXCYo0KUbFHZZjtMVh8mTYakjWPkrP2H9D1s
         T73p9jBYHEEfDlM7+XVPg12mLH+jVX7TNs5P3fIa9IK+Q2kvm6UiRwqaNKxuEQbIxgKe
         2HVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=apZEUeUXkxNIajez79xJytejwJ3FgKAFjaiHw46ypy0=;
        b=7+PUExG8ygpwpyxxydhztgK8uiYnIW1xB0lW2hzrbZldmHBqCq/X7G/Sf0sxXtsSBQ
         h0A2LkJ/Px2pTUmMfS5Jp1YCru3glFO/DdsPBeLEdJsYHlnvkjDDOgr6a2yI39b5iRze
         OfzktYWYes9EKVlTow047u9LKx0BPffRZQSYlH3uv71j6XgDbc9nLVfHoltxcpJVEfNR
         X3FO/PPvs7BoKKJnziGqW5gmmQzc/jhj2YJ6CgIiC8tw+Xj2C5saBSzj6FZCfX7tOFsD
         gj8du8+xVTIKK5X6VEajXI8r/0u2RP07szM6kMsYG57EoPD0W4wavqp8vji/b8IwQSIh
         7iqw==
X-Gm-Message-State: ACrzQf1SDLdUm3h0hlVP1iCc8bNkXA+2GovA8ohAp4676svMsGCdkKvR
        GBbp2ExYzP3RZbBPkosJOFY=
X-Google-Smtp-Source: AMsMyM6ODo5+3xnp+tlWJjTDesLy3Ko88edNSlOFVAkBnXBUEE1Yq0idWHXAYKRfWc5UUaMQCAEpFQ==
X-Received: by 2002:a17:906:eeca:b0:730:6880:c397 with SMTP id wu10-20020a170906eeca00b007306880c397mr12948538ejb.593.1666308380301;
        Thu, 20 Oct 2022 16:26:20 -0700 (PDT)
Received: from andrea (host-87-17-41-249.retail.telecomitalia.it. [87.17.41.249])
        by smtp.gmail.com with ESMTPSA id kv25-20020a17090778d900b0078cf8a743d6sm10875532ejc.100.2022.10.20.16.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 16:26:19 -0700 (PDT)
Date:   Fri, 21 Oct 2022 01:26:13 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH] riscv: fix race when vmap stack overflow
Message-ID: <Y1HZFcBo21SQzXVj@andrea>
References: <20221019154727.2395-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019154727.2395-1-jszhang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jisheng,

On Wed, Oct 19, 2022 at 11:47:27PM +0800, Jisheng Zhang wrote:
> Currently, when detecting vmap stack overflow, riscv firstly switches
> to the so called shadow stack, then use this shadow stack to call the
> get_overflow_stack() to get the overflow stack. However, there's
> a race here if two or more harts use the same shadow stack at the same
> time.
> 
> To solve this race, we introduce spin_shadow_stack atomic var, which
> will make the shadow stack usage serialized.
> 
> Fixes: 31da94c25aea ("riscv: add VMAP_STACK overflow detection")
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Suggested-by: Guo Ren <guoren@kernel.org>
> ---
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
> index f3e96d60a2ff..88a54947dffb 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -221,11 +221,15 @@ asmlinkage unsigned long get_overflow_stack(void)
>  		OVERFLOW_STACK_SIZE;
>  }
>  
> +atomic_t spin_shadow_stack;
> +
>  asmlinkage void handle_bad_stack(struct pt_regs *regs)
>  {
>  	unsigned long tsk_stk = (unsigned long)current->stack;
>  	unsigned long ovf_stk = (unsigned long)this_cpu_ptr(overflow_stack);
>  
> +	atomic_set_release(&spin_shadow_stack, 0);
> +

Have not really looked the details: should there be a matching acquire?

  Andrea


>  	console_verbose();
>  
>  	pr_emerg("Insufficient stack space to handle exception!\n");
> -- 
> 2.37.2
> 
