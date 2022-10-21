Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4F46079E4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 16:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiJUOsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 10:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiJUOsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 10:48:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A72280806;
        Fri, 21 Oct 2022 07:48:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 221E2B82C32;
        Fri, 21 Oct 2022 14:48:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B18C433D6;
        Fri, 21 Oct 2022 14:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666363699;
        bh=di/tYVb8lgGpk3SCJ1xRtYETc3Ywu0RjkuoTCdS1qwA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OeL2Pm+zbVw8lbR9xNhzNXypwxncX53aboVeJbBuQXPs64wZ97EYSrw7q8pUn49zV
         6sEKDSq7gNrtrt+o8+4J2rdRKZFXyTe/feH9VuGwJWpbgbBkjRy7+7Z330yRqSSudo
         wsykk68v4rD1uhwTx28G/4vQ3ofQiibd525+7uPrPa0NdVjQ2sov8+hxByAx59fuuo
         zUJz+fVr7Xv/EiWNDCiHUMXrnvABTdm9SU230x4vj+YIeGIcgUAhvhsIuorSoY1pHW
         oLH/OJ0sjkfAR2uthjTVowSCg5PYe806G46AkKBRn0Z221S/5pNiNT+1Ugs9glT3/w
         ZDqtHm/t+d00Q==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-131dda37dddso3885800fac.0;
        Fri, 21 Oct 2022 07:48:19 -0700 (PDT)
X-Gm-Message-State: ACrzQf1xfksla0CiN0K+6GxdMoIWKs1Aeml8a9swOCQRivRF172YsUii
        A+8RtBIkHmH2XbETcUIg2lSjxn488Z+bKAKo/bE=
X-Google-Smtp-Source: AMsMyM66OHnIpUp/v8q/GxCvAmlpLvHtP6DUy2wnlF1LlRwNJ9djFNDbeIcVOWUIe6rsaPf3YTVkpaMHLJ2sznffdPE=
X-Received: by 2002:a05:6870:5803:b0:12c:c3e0:99dc with SMTP id
 r3-20020a056870580300b0012cc3e099dcmr27936696oap.19.1666363699006; Fri, 21
 Oct 2022 07:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <20221021115654.5278-1-tongtiangen@huawei.com>
In-Reply-To: <20221021115654.5278-1-tongtiangen@huawei.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 21 Oct 2022 22:48:07 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQN9j=cXLTgUp++438b2acqNoZF0r_D_9xFdaxUEc3c-w@mail.gmail.com>
Message-ID: <CAJF2gTQN9j=cXLTgUp++438b2acqNoZF0r_D_9xFdaxUEc3c-w@mail.gmail.com>
Subject: Re: [PATCH -next] csky: add arch support current_stack_pointer
To:     Tong Tiangen <tongtiangen@huawei.com>
Cc:     linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangkefeng.wang@huawei.com, Guohanjun <guohanjun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 7:31 PM Tong Tiangen <tongtiangen@huawei.com> wrote:
>
> To follow the existing per-arch conventions, using "current_stack_pointer"
> to set sp.
>
> This will let it be used in non-arch places(like HARDENED_USERCOPY).
>

Add a Link tag here. The original patch series lore.kernel.org link.
One tip: commit fdecfea09328b33fd08a4d418237cce9fd176d69 riscv: Rename
"sp_in_global" to "current_stack_pointer"

    To follow the existing per-arch conventions, rename "sp_in_global" to
    "current_stack_pointer". This will let it be used in non-arch places
    (like HARDENED_USERCOPY).
> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
> ---
>  arch/csky/Kconfig                 | 1 +
>  arch/csky/include/asm/processor.h | 2 ++
>  arch/csky/kernel/stacktrace.c     | 6 ++----
>  3 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
> index adee6ab36862..2236b5c0c213 100644
> --- a/arch/csky/Kconfig
> +++ b/arch/csky/Kconfig
> @@ -9,6 +9,7 @@ config CSKY
>         select ARCH_USE_BUILTIN_BSWAP
>         select ARCH_USE_QUEUED_RWLOCKS
>         select ARCH_USE_QUEUED_SPINLOCKS
> +       select ARCH_HAS_CURRENT_STACK_POINTER
>         select ARCH_INLINE_READ_LOCK if !PREEMPTION
>         select ARCH_INLINE_READ_LOCK_BH if !PREEMPTION
>         select ARCH_INLINE_READ_LOCK_IRQ if !PREEMPTION
> diff --git a/arch/csky/include/asm/processor.h b/arch/csky/include/asm/processor.h
> index 63ad71fab30d..ea75d72dea86 100644
> --- a/arch/csky/include/asm/processor.h
> +++ b/arch/csky/include/asm/processor.h
> @@ -84,4 +84,6 @@ unsigned long __get_wchan(struct task_struct *p);
>
>  #define cpu_relax() barrier()
>
> +register unsigned long current_stack_pointer __asm__("sp");
> +
>  #endif /* __ASM_CSKY_PROCESSOR_H */
> diff --git a/arch/csky/kernel/stacktrace.c b/arch/csky/kernel/stacktrace.c
> index 9f78f5d21511..27ecd63e321b 100644
> --- a/arch/csky/kernel/stacktrace.c
> +++ b/arch/csky/kernel/stacktrace.c
> @@ -23,10 +23,9 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
>                 sp = user_stack_pointer(regs);
>                 pc = instruction_pointer(regs);
>         } else if (task == NULL || task == current) {
> -               const register unsigned long current_sp __asm__ ("sp");
>                 const register unsigned long current_fp __asm__ ("r8");
>                 fp = current_fp;
> -               sp = current_sp;
> +               sp = current_stack_pointer;
>                 pc = (unsigned long)walk_stackframe;
>         } else {
>                 /* task blocked in __switch_to */
> @@ -68,8 +67,7 @@ static void notrace walk_stackframe(struct task_struct *task,
>                 sp = user_stack_pointer(regs);
>                 pc = instruction_pointer(regs);
>         } else if (task == NULL || task == current) {
> -               const register unsigned long current_sp __asm__ ("sp");
> -               sp = current_sp;
> +               sp = current_stack_pointer;
>                 pc = (unsigned long)walk_stackframe;
>         } else {
>                 /* task blocked in __switch_to */
> --
> 2.25.1
>


-- 
Best Regards
 Guo Ren
