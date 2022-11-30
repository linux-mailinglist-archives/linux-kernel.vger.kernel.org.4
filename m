Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD47563CF9F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 08:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbiK3HQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 02:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbiK3HP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 02:15:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3248E5F87A
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 23:15:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A61D1B81A7A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 07:15:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5406AC433C1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 07:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669792554;
        bh=Cs89uJGCDT7nwbyOANh15I+gIUbN//CQRuDTvx/5B/s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YGRsAZZKkq8nJ9r4ZyoJ7IXCgOjwa+zJqz0RP+yqjmV92EkaAHicMIK2Ck1mLRlbY
         8qpMVHYKiRB76NFO7lOBLEPz1nB8080xo5rwIJ0Fq/lQ0hrYVU8vDoUHm7qLTaEZKe
         GEjepvIlwDPugbS2NmUP7HZ0KupOeM6atVtOUIP8knrDLgQKzFWDmhnX4E5RQvmvaY
         ApldyaNl5tKWQRx6uBu1gP5BxU2mSg+XJPo/F4ouenlpmQmrGpqsT/ExguWpCSeZAC
         sv6GXQQDAQgMpnMuhIerofLF68n4+cvpSzXDAqUyVqNfxuA5Iv8kn8nyOdxWS2NGbf
         4BreI6C7WrDzA==
Received: by mail-ed1-f42.google.com with SMTP id d20so12061277edn.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 23:15:54 -0800 (PST)
X-Gm-Message-State: ANoB5pnICc9VSIkEK+JtRuAV50UZyOFfj68emvSIHP9AN38hjoODMmd5
        xONJnf+Ei4/cKcDj/0Rg/Vr7tEb9IKwGzg0YlaY=
X-Google-Smtp-Source: AA0mqf6iO7zEMAHQthAsZZCwb0TfAQtr1pQ+1guep+gxvta8+32QKZjb7/yFncCMFX0iDzZpDpcZ6EuMQkDOmPBIfbo=
X-Received: by 2002:aa7:c046:0:b0:461:54f0:f7dc with SMTP id
 k6-20020aa7c046000000b0046154f0f7dcmr54737158edo.117.1669792552420; Tue, 29
 Nov 2022 23:15:52 -0800 (PST)
MIME-Version: 1.0
References: <20221130022442.18358-1-palmer@rivosinc.com>
In-Reply-To: <20221130022442.18358-1-palmer@rivosinc.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 30 Nov 2022 15:15:40 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ0xuJo6uzB+8SudZOFiZ2_o1sLB=Hn5XuCw6g2tXUtkQ@mail.gmail.com>
Message-ID: <CAJF2gTQ0xuJo6uzB+8SudZOFiZ2_o1sLB=Hn5XuCw6g2tXUtkQ@mail.gmail.com>
Subject: Re: [PATCH v4] riscv: fix race when vmap stack overflow
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     jszhang@kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment becomes better. Thx.

On Wed, Nov 30, 2022 at 10:29 AM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>
> From: Jisheng Zhang <jszhang@kernel.org>
>
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
> Reviewed-by: Guo Ren <guoren@kernel.org>
> Link: https://lore.kernel.org/r/20221030124517.2370-1-jszhang@kernel.org
> [Palmer: Add AQ to the swap, and also some comments.]
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
> Sorry to just re-spin this one without any warning, but I'd read patch a
> few times and every time I'd managed to convice myself there was a much
> simpler way of doing this.  By the time I'd figured out why that's not
> the case it seemed faster to just write the comments.
>
> I've stashed this, right on top of the offending commit, at
> palmer/riscv-fix_vmap_stack.
>
> Since v3:
>  - Add AQ to the swap.
>  - Add a bunch of comments.
>
> Since v2:
>  - use REG_AMOSWAP
>  - add comment to the purpose of smp_store_release()
>
> Since v1:
>  - use smp_store_release directly
>  - use unsigned int instead of atomic_t
> ---
>  arch/riscv/include/asm/asm.h |  1 +
>  arch/riscv/kernel/entry.S    | 13 +++++++++++++
>  arch/riscv/kernel/traps.c    | 18 ++++++++++++++++++
>  3 files changed, 32 insertions(+)
>
> diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
> index 618d7c5af1a2..e15a1c9f1cf8 100644
> --- a/arch/riscv/include/asm/asm.h
> +++ b/arch/riscv/include/asm/asm.h
> @@ -23,6 +23,7 @@
>  #define REG_L          __REG_SEL(ld, lw)
>  #define REG_S          __REG_SEL(sd, sw)
>  #define REG_SC         __REG_SEL(sc.d, sc.w)
> +#define REG_AMOSWAP_AQ __REG_SEL(amoswap.d.aq, amoswap.w.aq)
Below is the reason why I use the relax version here:
https://lore.kernel.org/all/CAJF2gTRAEX_jQ_w5H05dyafZzHq+P5j05TJ=C+v+OL__GQam4A@mail.gmail.com/T/#u

>  #define REG_ASM                __REG_SEL(.dword, .word)
>  #define SZREG          __REG_SEL(8, 4)
>  #define LGREG          __REG_SEL(3, 2)
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 98f502654edd..5fdb6ba09600 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -387,6 +387,19 @@ handle_syscall_trace_exit:
>
>  #ifdef CONFIG_VMAP_STACK
>  handle_kernel_stack_overflow:
> +       /*
> +        * Takes the psuedo-spinlock for the shadow stack, in case multiple
> +        * harts are concurrently overflowing their kernel stacks.  We could
> +        * store any value here, but since we're overflowing the kernel stack
> +        * already we only have SP to use as a scratch register.  So we just
> +        * swap in the address of the spinlock, as that's definately non-zero.
> +        *
> +        * Pairs with a store_release in handle_bad_stack().
> +        */
> +1:     la sp, spin_shadow_stack
> +       REG_AMOSWAP_AQ sp, sp, (sp)
> +       bnez sp, 1b
> +
>         la sp, shadow_stack
>         addi sp, sp, SHADOW_OVERFLOW_STACK_SIZE
>
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index bb6a450f0ecc..be54ccea8c47 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -213,11 +213,29 @@ asmlinkage unsigned long get_overflow_stack(void)
>                 OVERFLOW_STACK_SIZE;
>  }
>
> +/*
> + * A pseudo spinlock to protect the shadow stack from being used by multiple
> + * harts concurrently.  This isn't a real spinlock because the lock side must
> + * be taken without a valid stack and only a single register, it's only taken
> + * while in the process of panicing anyway so the performance and error
> + * checking a proper spinlock gives us doesn't matter.
> + */
> +unsigned long spin_shadow_stack;
> +
>  asmlinkage void handle_bad_stack(struct pt_regs *regs)
>  {
>         unsigned long tsk_stk = (unsigned long)current->stack;
>         unsigned long ovf_stk = (unsigned long)this_cpu_ptr(overflow_stack);
>
> +       /*
> +        * We're done with the shadow stack by this point, as we're on the
> +        * overflow stack.  Tell any other concurrent overflowing harts that
> +        * they can proceed with panicing by releasing the pseudo-spinlock.
> +        *
> +        * This pairs with an amoswap.aq in handle_kernel_stack_overflow.
> +        */
> +       smp_store_release(&spin_shadow_stack, 0);
> +
>         console_verbose();
>
>         pr_emerg("Insufficient stack space to handle exception!\n");
> --
> 2.38.1
>


--
Best Regards

 Guo Ren
