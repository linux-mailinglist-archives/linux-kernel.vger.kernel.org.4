Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF96C70EB0E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 03:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239064AbjEXB51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 21:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237665AbjEXB5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 21:57:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B4013E;
        Tue, 23 May 2023 18:57:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F5FF637C7;
        Wed, 24 May 2023 01:57:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76251C4339B;
        Wed, 24 May 2023 01:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684893441;
        bh=7ddKEhh0kiBc1mXu8T6uZMyQXUcxoMJ/u+OB30ZYfZ8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dtN1DTk78Zd6o7YTZTsV4ey2RqPRDR32Q/f7+ie7HMr3GgbfSIe77ro99gKns8qXf
         ciBti6xdnIvaKyFyiflNNgHeG2HvbHCX8Ac8eyAWHmn4qj5B0R1iMbCMxq5+ePPArN
         xXhMLIKjT9f9Y21LNZjlv7KEwPlqYm+JDPyEGaCrLMdr/Al29Kq4hXI+Sw/+k1Wf63
         7iV0VELNIkF6tpb8/sSNmhOes/f/w7SvbWPKixSHZgRKWkXLeXnCJVlAiIJwMpGG5y
         u7CSpc6PhaEqgVV5FOFSWXMqoXjygQgq3ppMEQ6IALB+JuLmDZWrcHUI7CmlWWjxL3
         NiATnOs+PKwcQ==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-510f3db1cd8so1054355a12.1;
        Tue, 23 May 2023 18:57:21 -0700 (PDT)
X-Gm-Message-State: AC+VfDxufS/jbYGEjuEmXAE6X5iG6jK66p8hCDxkHIa+n7pErzPoX+2k
        E9hyMFWQt80+4AJJ6qkv3ZULs0kGJK1cYeR7hkk=
X-Google-Smtp-Source: ACHHUZ6vO1jiuAGpmZaNYY9BE9/G3fiUoK5LrgSjqTJca/TnBH1NBozEBatdrHL1wewJixuFRcxxxxtRUaFQ0rUoPlY=
X-Received: by 2002:a17:907:9807:b0:96f:e7cf:501b with SMTP id
 ji7-20020a170907980700b0096fe7cf501bmr9055951ejc.33.1684893439694; Tue, 23
 May 2023 18:57:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230522093156.7108-1-zhuyinbo@loongson.cn> <20230522093156.7108-2-zhuyinbo@loongson.cn>
In-Reply-To: <20230522093156.7108-2-zhuyinbo@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 24 May 2023 09:57:08 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5Your97dAMOWjGCMgq5QsGPS21QNPa7OmfOHO6vM8sqw@mail.gmail.com>
Message-ID: <CAAhV-H5Your97dAMOWjGCMgq5QsGPS21QNPa7OmfOHO6vM8sqw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] loongarch: export loongarch pm interface
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Marc Zyngier <maz@kernel.org>,
        Youling Tang <tangyouling@loongson.cn>,
        Baoqi Zhang <zhangbaoqi@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>, Yun Liu <liuyun@loongson.cn>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yinbo,

The title can be regular:
 LoongArch: Export some arch-specific pm interfaces

And in commit message,
"Some Power Management Controllers" should be
"Some power management controllers" or
"Some PMC (Power Management Controllers)"

Huacai

On Mon, May 22, 2023 at 5:32=E2=80=AFPM Yinbo Zhu <zhuyinbo@loongson.cn> wr=
ote:
>
> Some Power Management Controllers need to support DTS and will use
> the suspend interface thus this patch was to export such interface
> for their use.
>
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
>  arch/loongarch/include/asm/acpi.h    |  5 ++---
>  arch/loongarch/include/asm/suspend.h | 10 ++++++++++
>  arch/loongarch/power/suspend.c       | 10 +++++-----
>  arch/loongarch/power/suspend_asm.S   |  8 ++++----
>  4 files changed, 21 insertions(+), 12 deletions(-)
>  create mode 100644 arch/loongarch/include/asm/suspend.h
>
> diff --git a/arch/loongarch/include/asm/acpi.h b/arch/loongarch/include/a=
sm/acpi.h
> index 976a810352c6..d63507cc705f 100644
> --- a/arch/loongarch/include/asm/acpi.h
> +++ b/arch/loongarch/include/asm/acpi.h
> @@ -8,6 +8,7 @@
>  #ifndef _ASM_LOONGARCH_ACPI_H
>  #define _ASM_LOONGARCH_ACPI_H
>
> +#include <asm/suspend.h>
>  #ifdef CONFIG_ACPI
>  extern int acpi_strict;
>  extern int acpi_disabled;
> @@ -37,13 +38,11 @@ extern struct list_head acpi_wakeup_device_list;
>
>  extern int loongarch_acpi_suspend(void);
>  extern int (*acpi_suspend_lowlevel)(void);
> -extern void loongarch_suspend_enter(void);
>
>  static inline unsigned long acpi_get_wakeup_address(void)
>  {
>  #ifdef CONFIG_SUSPEND
> -       extern void loongarch_wakeup_start(void);
> -       return (unsigned long)loongarch_wakeup_start;
> +       return (unsigned long)loongson_wakeup_start;
>  #endif
>         return 0UL;
>  }
> diff --git a/arch/loongarch/include/asm/suspend.h b/arch/loongarch/includ=
e/asm/suspend.h
> new file mode 100644
> index 000000000000..a40b42f4f7f3
> --- /dev/null
> +++ b/arch/loongarch/include/asm/suspend.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_SUSPEND_H
> +#define __ASM_SUSPEND_H
> +
> +void loongson_common_resume(void);
> +void loongson_common_suspend(void);
> +void loongson_suspend_enter(void);
> +void loongson_wakeup_start(void);
> +
> +#endif
> diff --git a/arch/loongarch/power/suspend.c b/arch/loongarch/power/suspen=
d.c
> index 5e19733e5e05..0587681b33ce 100644
> --- a/arch/loongarch/power/suspend.c
> +++ b/arch/loongarch/power/suspend.c
> @@ -27,7 +27,7 @@ struct saved_registers {
>  };
>  static struct saved_registers saved_regs;
>
> -static void arch_common_suspend(void)
> +void loongson_common_suspend(void)
>  {
>         save_counter();
>         saved_regs.pgd =3D csr_read64(LOONGARCH_CSR_PGDL);
> @@ -40,7 +40,7 @@ static void arch_common_suspend(void)
>         loongarch_suspend_addr =3D loongson_sysconf.suspend_addr;
>  }
>
> -static void arch_common_resume(void)
> +void loongson_common_resume(void)
>  {
>         sync_counter();
>         local_flush_tlb_all();
> @@ -62,12 +62,12 @@ int loongarch_acpi_suspend(void)
>         enable_gpe_wakeup();
>         enable_pci_wakeup();
>
> -       arch_common_suspend();
> +       loongson_common_suspend();
>
>         /* processor specific suspend */
> -       loongarch_suspend_enter();
> +       loongson_suspend_enter();
>
> -       arch_common_resume();
> +       loongson_common_resume();
>
>         return 0;
>  }
> diff --git a/arch/loongarch/power/suspend_asm.S b/arch/loongarch/power/su=
spend_asm.S
> index e2fc3b4e31f0..809abd3b119d 100644
> --- a/arch/loongarch/power/suspend_asm.S
> +++ b/arch/loongarch/power/suspend_asm.S
> @@ -57,13 +57,13 @@
>         .align 12
>
>  /* Sleep/wakeup code for Loongson-3 */
> -SYM_FUNC_START(loongarch_suspend_enter)
> +SYM_FUNC_START(loongson_suspend_enter)
>         SETUP_SLEEP
>         bl              __flush_cache_all
>
>         /* Pass RA and SP to BIOS */
>         addi.d          a1, sp, 0
> -       la.pcrel        a0, loongarch_wakeup_start
> +       la.pcrel        a0, loongson_wakeup_start
>         la.pcrel        t0, loongarch_suspend_addr
>         ld.d            t0, t0, 0
>         jirl            a0, t0, 0 /* Call BIOS's STR sleep routine */
> @@ -72,7 +72,7 @@ SYM_FUNC_START(loongarch_suspend_enter)
>          * This is where we return upon wakeup.
>          * Reload all of the registers and return.
>          */
> -SYM_INNER_LABEL(loongarch_wakeup_start, SYM_L_GLOBAL)
> +SYM_INNER_LABEL(loongson_wakeup_start, SYM_L_GLOBAL)
>         li.d            t0, CSR_DMW0_INIT       # UC, PLV0
>         csrwr           t0, LOONGARCH_CSR_DMWIN0
>         li.d            t0, CSR_DMW1_INIT       # CA, PLV0
> @@ -89,4 +89,4 @@ SYM_INNER_LABEL(loongarch_wakeup_start, SYM_L_GLOBAL)
>         SETUP_WAKEUP
>         addi.d          sp, sp, PT_SIZE
>         jr              ra
> -SYM_FUNC_END(loongarch_suspend_enter)
> +SYM_FUNC_END(loongson_suspend_enter)
> --
> 2.20.1
>
