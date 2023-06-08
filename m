Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331A172792A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbjFHHuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbjFHHt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:49:58 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7DA1BF9
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 00:49:56 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-30c55d2b9f3so189774f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 00:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1686210595; x=1688802595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TtmUwjwB5GnvCa4t/yItESHxoD/YIIhkFf3u0QhCFEU=;
        b=xHZvR8D8ubZlzKmO3AeT67Dan7R9Uya1zCc3WqXQriEUhsX7+QTOXWQzGP/uqPGEU3
         VlbS/DY1rw2R5vY4sackU8REgmFUUhAIZL2TlAejLw6EdXsyv+KFa6DpTMtCaCxFPkP0
         A8IRg4Fepnn7x4TvP4Rhz+sEmJmey5X6svMpU6ESSgq0oVF0uHL3ZrpIoLX5DYpMF7iU
         h4xApXNZ/tLs+1/BZkgeoJXQDa7kf/6e7A0+ffyDl7nkhuR5qW9X7JGjbEgAvY19v0wn
         UWbFO4EBork0PvWuQ353SZyamof5QZI2JERaNAa+qwp44YBjW63Ka7wx25xSMZ8ZR/ut
         aP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686210595; x=1688802595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TtmUwjwB5GnvCa4t/yItESHxoD/YIIhkFf3u0QhCFEU=;
        b=MYOZlEo+yZZH+Qo/Dr8ZUgyiQPlNTztnh5nbP1N2ojPL0lYW3ETR6NX2WUpf/DFUy6
         sfd4Yrv3A9IYmT2e5D+UK3h1q4NQjwTf6bJAYe2+eE2n3BrTHqZmJzJGpuhpdEeUzYWN
         Dbo90IqrnT2vIylXLIjdygXQl7ZSgQtVKsQmmv0sNdh+z8D/BcdL70rMEZYlJSkMVDTv
         AbnAbbcdWbaJ3O8CiFz8wNdZocKyk+vdTuuLTnLS8ZT1XL01wzxgXvDMSazEQzCochC3
         1GsitHL1CRYWxDkIigzlrIxSV5J0pbJwXrNXSf2Gucc31/qhBQVfpS6j2qoVMAXSrqJ9
         NzPQ==
X-Gm-Message-State: AC+VfDwbTj5Rhx4zTnDV7shDYdGhhsi6VGQMct6yhnjTNBcDqLoN2FkR
        uMg00lk6QayPAhDq8JqD5rghEOwutdqa0rlV6F2nZg==
X-Google-Smtp-Source: ACHHUZ7xonBX9mtbOt/iDujy0XqfgYu34JU3q4uwrHM1AsZR9QLNLK6ZW+hlqhCptuPlGRbKuLyi97bNcoYGMh4sD6Y=
X-Received: by 2002:a5d:4d46:0:b0:30e:5283:ec85 with SMTP id
 a6-20020a5d4d46000000b0030e5283ec85mr5367913wru.33.1686210594989; Thu, 08 Jun
 2023 00:49:54 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_B15C0F1F3105597D0DCE7DADC96C5EB5CF0A@qq.com> <20230607-jogging-grudging-70dede86bc53@spud>
In-Reply-To: <20230607-jogging-grudging-70dede86bc53@spud>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Thu, 8 Jun 2023 09:49:44 +0200
Message-ID: <CAHVXubggydGfNu3OzcxWXREJbB+G9dmr9sFD7vXhVxbG-N58Pg@mail.gmail.com>
Subject: Re: [PATCH] riscv: reserve DTB before possible memblock allocation
To:     Conor Dooley <conor@kernel.org>
Cc:     Woody Zhang <woodylab@foxmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 7, 2023 at 8:17=E2=80=AFPM Conor Dooley <conor@kernel.org> wrot=
e:
>
> +CC Alex, you should take a look at this patch.
>
> On Wed, Jun 07, 2023 at 09:35:19PM +0800, Woody Zhang wrote:
> > It's possible that early_init_fdt_scan_reserved_mem() allocates memory
> > from memblock for dynamic reserved memory in `/reserved-memory` node.
> > Any fixed reservation must be done before that to avoid potential
> > conflicts.
> >
> > Reserve the DTB in memblock just after early scanning it.
>
> The rationale makes sense to me, I am just wondering what compelling
> reason there is to move it away from the memblock_reserve()s for the
> initd and vmlinux? Moving it above early_init_fdt_scan_reserved_mem()
> should be the sufficient minimum & would keep things together.
>
> Cheers,
> Conor.

Thanks Conor.

So the patch looks good to me.

But I find this fragile:

- we do not check memblock_reserve() return value to make sure the
reservation really happened (and quickly looking at the code, I'm not
even sure it returns an error if the region was already allocated).
- we have to make sure no memblock allocation happens before setup_bootmem(=
).
- we also have to check that no fixed memblock_reserve() happens after.

The last 2 points may sound natural, but we'll have to take great care
when adding some code around here. I'm working on an "early boot
document" and I'll add something about that, but a runtime thing would
be way better IMO.

You can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex

>
> >
> > Signed-off-by: Woody Zhang <woodylab@foxmail.com>
> > ---
> >  arch/riscv/kernel/setup.c | 10 ++++++++++
> >  arch/riscv/mm/init.c      |  9 ---------
> >  2 files changed, 10 insertions(+), 9 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> > index 36b026057503..c147fa8da929 100644
> > --- a/arch/riscv/kernel/setup.c
> > +++ b/arch/riscv/kernel/setup.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/console.h>
> >  #include <linux/screen_info.h>
> >  #include <linux/of_fdt.h>
> > +#include <linux/libfdt.h>
> >  #include <linux/sched/task.h>
> >  #include <linux/smp.h>
> >  #include <linux/efi.h>
> > @@ -256,6 +257,15 @@ static void __init parse_dtb(void)
> >               pr_err("No DTB passed to the kernel\n");
> >       }
> >
> > +     /*
> > +      * If DTB is built in, no need to reserve its memblock.
> > +      * Otherwise, do reserve it but avoid using
> > +      * early_init_fdt_reserve_self() since __pa() does
> > +      * not work for DTB pointers that are fixmap addresses
> > +      */
> > +     if (!IS_ENABLED(CONFIG_BUILTIN_DTB))
> > +             memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va=
));
> > +
> >  #ifdef CONFIG_CMDLINE_FORCE
> >       strscpy(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
> >       pr_info("Forcing kernel command line to: %s\n", boot_command_line=
);
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index c6bb966e4123..f8c9a79acd94 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -254,15 +254,6 @@ static void __init setup_bootmem(void)
> >        */
> >       early_init_fdt_scan_reserved_mem();
> >
> > -     /*
> > -      * If DTB is built in, no need to reserve its memblock.
> > -      * Otherwise, do reserve it but avoid using
> > -      * early_init_fdt_reserve_self() since __pa() does
> > -      * not work for DTB pointers that are fixmap addresses
> > -      */
> > -     if (!IS_ENABLED(CONFIG_BUILTIN_DTB))
> > -             memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va=
));
> > -
> >       dma_contiguous_reserve(dma32_phys_limit);
> >       if (IS_ENABLED(CONFIG_64BIT))
> >               hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
> > --
> > 2.39.2
> >
