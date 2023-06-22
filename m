Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6991673A845
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 20:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjFVS24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 14:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjFVS2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 14:28:54 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762A5FE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 11:28:53 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-2553663f71eso3752918a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 11:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687458533; x=1690050533;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YI/oCnDdll7xeXkfLFG5RlPTvHgVHccCn8qZKbqDchc=;
        b=0qRaxcys4YmbQ0xcwXtiYKCybCP3eDqqZcNt0EbFptR/i+sEiqixTdVlSVvUpEcFUC
         J7Krjuhdik4DEZJt1cb4j4jIcBa6bbacTwDYK6hYa+FfrljIdxcVB2qgbrGYnMbcTU5L
         3ksBCu08lF6m0rLzc1hRaO4d45MtypJenIKGuj5T29bbEAY/hZm/ZkfIPRpQCWwPZlkG
         mnpZR95MjsTb7Gm1lFjUwmBt607YMeQxY3OziiQ82YbuR+c799mYDAPhNQXk9rhhI/bJ
         ssKDqayfpmuC8VnBsG6xJY5XunTaA406nT8NiK0HByc+KGgU9UeNCTxn5lVvjbClLirC
         DObg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687458533; x=1690050533;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YI/oCnDdll7xeXkfLFG5RlPTvHgVHccCn8qZKbqDchc=;
        b=cEHSxkMimIwN+hxk/kfKCt4yuPJjzj7iU/W9hJvakVeFUEYVuusgedROPdaU3Ne7H7
         s+yqDrSxJ+SqLo6OG08zi0Cs9nPtnt4cMie3Uo8p9H5KpbbiVX4pM4yINWID+4toygyX
         22DiMJNkFwxRmDA5VaTc7I/q6C9bJ7/5NdkbwMS2v7g14x8FUUeNkEQjmxHPJ5abI7gr
         tTeIkvIZAuoVFQ+tnXvfppUg9T7VlIBOipYFdn82osZ35GIKOrUW8PMugiDr7+NOGuZ/
         lNYKqDrCl7yd53Qa72MA9vqjwbSXNLO1iGxuDxzFq8CTg24Vl6VHXjDq3Vc3pv5kCAUI
         BkXQ==
X-Gm-Message-State: AC+VfDyJKHXdHVowLSOwI4h1DK3p3DUx79lClUv3KkPuVJOdDCmzZGBG
        2MX1jLfhyxko28OVKUCz+nl6xA==
X-Google-Smtp-Source: ACHHUZ5tzCgAIP975zn3FHFf5anIJ68kDIOS19I6Ykf6+fcDrv81ohoKWXn+RZu67MiKIpItDRgU1Q==
X-Received: by 2002:a17:902:ec8b:b0:1b6:b445:36d4 with SMTP id x11-20020a170902ec8b00b001b6b44536d4mr1659052plg.43.1687458532934;
        Thu, 22 Jun 2023 11:28:52 -0700 (PDT)
Received: from [10.0.16.165] ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id ja7-20020a170902efc700b001b3c7e5ed8csm5688527plb.74.2023.06.22.11.28.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 11:28:52 -0700 (PDT)
Message-ID: <b990638b-a86a-ee43-f8b1-18a0a0651ad0@rivosinc.com>
Date:   Thu, 22 Jun 2023 11:28:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] riscv: Discard vector state on syscalls
Content-Language: en-US
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux@rivosinc.com,
        Palmer Dabbelt <palmer@rivosinc.com>,
        =?UTF-8?Q?R=c3=a9mi_Denis-Courmont?= <remi@remlab.net>,
        Darius Rad <darius@bluespec.com>,
        Andy Chiu <andy.chiu@sifive.com>
References: <20230622173613.30722-1-bjorn@kernel.org>
From:   Vineet Gupta <vineetg@rivosinc.com>
In-Reply-To: <20230622173613.30722-1-bjorn@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/22/23 10:36, Björn Töpel wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
>
> The RISC-V vector specification states:
>    Executing a system call causes all caller-saved vector registers
>    (v0-v31, vl, vtype) and vstart to become unspecified.

So the only use case of saving/restoring V regs in __switch_to is an 
interrupt induced task switch ?

>
> The vector registers are cleared, vill is set (invalid), and the
> vector status is set to Initial.
>
> That way we can prevent userspace from accidentally relying on the
> stated save.
>
> Rémi pointed out [1] that clearing the registers might be superfluous,
> and setting vill is sufficient.
>
> Link: https://lore.kernel.org/linux-riscv/12784326.9UPPK3MAeB@basile.remlab.net/ # [1]
> Suggested-by: Palmer Dabbelt <palmer@rivosinc.com>
> Suggested-by: Rémi Denis-Courmont <remi@remlab.net>
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
> ---
>
> I figured I'd sent out a proper patch. I like Andy's optimization
> patch, but TBH I think we should do that as a follow up.
>
> As Rémi pointed out, the clearing might be opted out, but I left it in
> here.
>
>
> Björn
>
> ---
>   arch/riscv/include/asm/vector.h | 25 +++++++++++++++++++++++++
>   arch/riscv/kernel/traps.c       |  2 ++
>   2 files changed, 27 insertions(+)
>
> diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
> index 04c0b07bf6cd..692ce55e4a69 100644
> --- a/arch/riscv/include/asm/vector.h
> +++ b/arch/riscv/include/asm/vector.h
> @@ -163,6 +163,30 @@ static inline void __switch_to_vector(struct task_struct *prev,
>   void riscv_v_vstate_ctrl_init(struct task_struct *tsk);
>   bool riscv_v_vstate_ctrl_user_allowed(void);
>   
> +static inline void riscv_v_vstate_discard(struct pt_regs *regs)
> +{
> +	unsigned long vl, vtype_inval = 1UL << (BITS_PER_LONG - 1);
> +
> +	if (!riscv_v_vstate_query(regs))
> +		return;
> +
> +	riscv_v_enable();
> +	asm volatile (
> +		".option push\n\t"
> +		".option arch, +v\n\t"
> +		"vsetvli	%0, x0, e8, m8, ta, ma\n\t"
> +		"vmv.v.i	v0, 0\n\t"
> +		"vmv.v.i	v8, 0\n\t"
> +		"vmv.v.i	v16, 0\n\t"
> +		"vmv.v.i	v24, 0\n\t"
> +		"vsetvl		%0, x0, %1\n\t"
> +		".option pop\n\t"
> +		: "=&r" (vl) : "r" (vtype_inval) : "memory");
> +	riscv_v_disable();
> +
> +	riscv_v_vstate_on(regs);
> +}
> +
>   #else /* ! CONFIG_RISCV_ISA_V  */
>   
>   struct pt_regs;
> @@ -178,6 +202,7 @@ static inline bool riscv_v_vstate_ctrl_user_allowed(void) { return false; }
>   #define __switch_to_vector(__prev, __next)	do {} while (0)
>   #define riscv_v_vstate_off(regs)		do {} while (0)
>   #define riscv_v_vstate_on(regs)			do {} while (0)
> +#define riscv_v_vstate_discard(regs)		do {} while (0)
>   
>   #endif /* CONFIG_RISCV_ISA_V */
>   
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 05ffdcd1424e..00c68b57ff88 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -295,6 +295,8 @@ asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
>   		regs->epc += 4;
>   		regs->orig_a0 = regs->a0;
>   
> +		riscv_v_vstate_discard(regs);
> +
>   		syscall = syscall_enter_from_user_mode(regs, syscall);
>   
>   		if (syscall < NR_syscalls)
>
> base-commit: 4681dacadeefa5ca6017e00736adc1d7dc963c6a

