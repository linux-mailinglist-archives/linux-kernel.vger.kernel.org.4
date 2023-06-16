Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0841273261C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 06:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239403AbjFPEEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 00:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjFPEEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 00:04:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D622685;
        Thu, 15 Jun 2023 21:04:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1156A61BFE;
        Fri, 16 Jun 2023 04:04:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF8CC43391;
        Fri, 16 Jun 2023 04:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686888259;
        bh=mM+ePtb7BuKhyXicQy73Wilwkxcyho5LfSxMZEjCC+U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=t/4FrNRf+HpGEQpn/4gnQq7WIrkrzyRZfKOAdt5SdfVSRU0gTA7MpkzLe5K4IUEF9
         CMvHU7F3mCAtd5PhJ3XlepeTElk22v0EgYDmG+q2B+E5C+2KLSTHSwWqmHFDRGhv4x
         B9nL1A4Lt/BQ/Y9JxAlgALUmVQk2b9usm/83u1yjWH3UHLkamUsoa3p6xloxk3Mqgv
         klguQgasGkXW4ivxULAaxbK5fpraox+R1+4tFqGScsvy0CVCcn0yaq17fq8ZYFX/rG
         jJFqpqvkOxh4cO9fLD7JhOhi45Z+dSIhxJRFatf8kAG7zOr6x3GoOyK+C0cb12C1y7
         oq4UVe25ktXzg==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-51a3e7a9127so16533a12.1;
        Thu, 15 Jun 2023 21:04:19 -0700 (PDT)
X-Gm-Message-State: AC+VfDzky2uESs+PQnYuubjroGh851xMeEcgbZYCFrUIUZJ6Jy2ME2iZ
        u1HmOFhUBbEq9jbIzXz3rqetZUpI8oEjMZ+MkOI=
X-Google-Smtp-Source: ACHHUZ6bTOrFVu2ifqXPtw4eiH/scWRZwhF3/BunnDnhrmuUNZtNKzzMETjOzHCVCIvYSDM/AjGy09btuxswxw8ow7U=
X-Received: by 2002:a05:6402:42c3:b0:514:8fdb:6354 with SMTP id
 i3-20020a05640242c300b005148fdb6354mr6909278edc.18.1686888257340; Thu, 15 Jun
 2023 21:04:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230615091757.24686-1-zhuyinbo@loongson.cn> <20230615091757.24686-2-zhuyinbo@loongson.cn>
In-Reply-To: <20230615091757.24686-2-zhuyinbo@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 16 Jun 2023 12:04:05 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5XxxGd_+NMRJKUCtk24dBQF0Fzdsg_5mZEWh1hs_u0qg@mail.gmail.com>
Message-ID: <CAAhV-H5XxxGd_+NMRJKUCtk24dBQF0Fzdsg_5mZEWh1hs_u0qg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] loongarch: export some arch-specific pm interfaces
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
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

I think this patch should go through the loongarch tree and the others
to go through the soc tree, so I just applied this one. The next
version you can only send the other two, thanks.

Huacai

On Thu, Jun 15, 2023 at 5:18=E2=80=AFPM Yinbo Zhu <zhuyinbo@loongson.cn> wr=
ote:
>
> Some power management controllers need to support DTS and will use
> the suspend interface thus this patch was to export such interface
> for their use.
>
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
>  arch/loongarch/include/asm/acpi.h    |  3 +--
>  arch/loongarch/include/asm/suspend.h | 10 ++++++++++
>  arch/loongarch/power/suspend.c       |  8 ++++----
>  3 files changed, 15 insertions(+), 6 deletions(-)
>  create mode 100644 arch/loongarch/include/asm/suspend.h
>
> diff --git a/arch/loongarch/include/asm/acpi.h b/arch/loongarch/include/a=
sm/acpi.h
> index 976a810352c6..1d7810798c08 100644
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
> @@ -37,12 +38,10 @@ extern struct list_head acpi_wakeup_device_list;
>
>  extern int loongarch_acpi_suspend(void);
>  extern int (*acpi_suspend_lowlevel)(void);
> -extern void loongarch_suspend_enter(void);
>
>  static inline unsigned long acpi_get_wakeup_address(void)
>  {
>  #ifdef CONFIG_SUSPEND
> -       extern void loongarch_wakeup_start(void);
>         return (unsigned long)loongarch_wakeup_start;
>  #endif
>         return 0UL;
> diff --git a/arch/loongarch/include/asm/suspend.h b/arch/loongarch/includ=
e/asm/suspend.h
> new file mode 100644
> index 000000000000..fc64089fefaa
> --- /dev/null
> +++ b/arch/loongarch/include/asm/suspend.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_SUSPEND_H
> +#define __ASM_SUSPEND_H
> +
> +void loongarch_common_resume(void);
> +void loongarch_common_suspend(void);
> +void loongarch_suspend_enter(void);
> +void loongarch_wakeup_start(void);
> +
> +#endif
> diff --git a/arch/loongarch/power/suspend.c b/arch/loongarch/power/suspen=
d.c
> index 5e19733e5e05..166d9e06a64b 100644
> --- a/arch/loongarch/power/suspend.c
> +++ b/arch/loongarch/power/suspend.c
> @@ -27,7 +27,7 @@ struct saved_registers {
>  };
>  static struct saved_registers saved_regs;
>
> -static void arch_common_suspend(void)
> +void loongarch_common_suspend(void)
>  {
>         save_counter();
>         saved_regs.pgd =3D csr_read64(LOONGARCH_CSR_PGDL);
> @@ -40,7 +40,7 @@ static void arch_common_suspend(void)
>         loongarch_suspend_addr =3D loongson_sysconf.suspend_addr;
>  }
>
> -static void arch_common_resume(void)
> +void loongarch_common_resume(void)
>  {
>         sync_counter();
>         local_flush_tlb_all();
> @@ -62,12 +62,12 @@ int loongarch_acpi_suspend(void)
>         enable_gpe_wakeup();
>         enable_pci_wakeup();
>
> -       arch_common_suspend();
> +       loongarch_common_suspend();
>
>         /* processor specific suspend */
>         loongarch_suspend_enter();
>
> -       arch_common_resume();
> +       loongarch_common_resume();
>
>         return 0;
>  }
> --
> 2.20.1
>
