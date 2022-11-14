Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F65962786E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236701AbiKNJCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236673AbiKNJCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:02:36 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC0D1D0E0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:02:33 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id e13so7294854edj.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=85z0FueDeeX/w3Y1hW/rg/FK4TTzV51haj7VJfYVY+Y=;
        b=cU/WGLQ47YlFBkz3SzXQW8qPwSrx7snlBaAhdRLW+iIppj875eVKouALr1r6Ssoawj
         ivLTT4BZaYq0tJRlgjO7d0u9UdCljcFSmJwP+tlAlHn+Rcyv9/M2K9c1eVrDdmrsJE6m
         oBF17BbXOLaUKZLQ6ZgdbB9SS40xQDkppzLydGIIXD6YSF0oNGQeTXscgaPFsBBFAuTn
         FShRXbiLv7/Z4w/Cc/9yVxbEwyNlRQ5eXNjmAWN2Km7SwXZztalajPPmdsxDsR9syJzS
         vUEXI14K4YyhyIXBLn84xY6a61ylhdHu+R+xG7PBE4NQnAaeSo/E3NzQ9Lyh08VLBbVh
         MucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=85z0FueDeeX/w3Y1hW/rg/FK4TTzV51haj7VJfYVY+Y=;
        b=Kn3gFKDi8Cn4WrQxX5o/xz8UklyZQEM1MZeUSB+qcAtU6LcN1vQvztdSjIxsnCoOZg
         JV8OohhYpHRBzyat4PKs2go+d9L2E0e0Jo6R1COvpIbVuLtTDx2KHytiBgQnMtI86xxL
         6qNOxPjXaZ7tYPZ2bt+ZgrDnW7tryzIdc7bEjHCwVat/ibrVukHOL+Zan1Tk7q4EnARw
         7vOmIqgRCC+6QrZJh7qCD+KX5ZXBMUCBKIlMLf1dT6GiSDvaetUw3Huj8r6KeKG0O4Ve
         J5V8QXlzpemsMBX/q6jw3J8n/4INGt1InfqbxpPO1pWPppUPHFNlDUCw07IJMc8yDe6m
         vrOQ==
X-Gm-Message-State: ANoB5pm6BrlhnUZjn5roEmHiwUphX6kpvallByv+9bQQU6C80QhrX+0R
        rvF+ntwLJzWkXhZtOfLNWZW/sr8l5VRBuDp2UtMypA==
X-Google-Smtp-Source: AA0mqf6nXnxNB8DjWcrr7dD1lyFcvSY2ucw4lFnep9j5lmKVTaWv/vUXrbIG1XG/rUmaJHYaxbihG59sQwcMeJW5edY=
X-Received: by 2002:a50:d657:0:b0:461:17e9:4ea3 with SMTP id
 c23-20020a50d657000000b0046117e94ea3mr10358974edj.49.1668416553238; Mon, 14
 Nov 2022 01:02:33 -0800 (PST)
MIME-Version: 1.0
References: <20221020075846.305576-1-apatel@ventanamicro.com>
 <20221020075846.305576-4-apatel@ventanamicro.com> <Y1bs50GXeUoTcv2V@spud>
In-Reply-To: <Y1bs50GXeUoTcv2V@spud>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 14 Nov 2022 14:32:04 +0530
Message-ID: <CAAhSdy317XVDXO6DPaEwL7_xBbAO=RTmfQMiMu5DAdWOLa1iTA@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] RISC-V: Implement arch specific PMEM APIs
To:     Conor Dooley <conor@kernel.org>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atishp@atishpatra.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Arnd Bergmann <arnd@arndb.de>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Mayuresh Chitale <mchitale@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 1:22 AM Conor Dooley <conor@kernel.org> wrote:
>
> On Thu, Oct 20, 2022 at 01:28:45PM +0530, Anup Patel wrote:
> > The NVDIMM PMEM driver expects arch specific APIs for cache maintenance
> > and if arch does not provide these APIs then NVDIMM PMEM driver will
> > always use MEMREMAP_WT to map persistent memory which in-turn maps as
> > UC memory type defined by the RISC-V Svpbmt specification.
> >
> > Now that the Svpbmt and Zicbom support is available in RISC-V kernel,
> > we implement PMEM APIs using ALT_CMO_OP() macros so that the NVDIMM
> > PMEM driver can use MEMREMAP_WB to map persistent memory.
> >
> > Co-developed-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> > Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  arch/riscv/Kconfig     |  1 +
> >  arch/riscv/mm/Makefile |  1 +
> >  arch/riscv/mm/pmem.c   | 21 +++++++++++++++++++++
> >  3 files changed, 23 insertions(+)
> >  create mode 100644 arch/riscv/mm/pmem.c
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 6b48a3ae9843..025e2a1b1c60 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -25,6 +25,7 @@ config RISCV
> >       select ARCH_HAS_GIGANTIC_PAGE
> >       select ARCH_HAS_KCOV
> >       select ARCH_HAS_MMIOWB
> > +     select ARCH_HAS_PMEM_API
> >       select ARCH_HAS_PTE_SPECIAL
> >       select ARCH_HAS_SET_DIRECT_MAP if MMU
> >       select ARCH_HAS_SET_MEMORY if MMU
> > diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
> > index d76aabf4b94d..3b368e547f83 100644
> > --- a/arch/riscv/mm/Makefile
> > +++ b/arch/riscv/mm/Makefile
> > @@ -31,3 +31,4 @@ endif
> >
> >  obj-$(CONFIG_DEBUG_VIRTUAL) += physaddr.o
> >  obj-$(CONFIG_RISCV_DMA_NONCOHERENT) += dma-noncoherent.o
> > +obj-$(CONFIG_ARCH_HAS_PMEM_API) += pmem.o
>
> Hey Anup,
> Might be a silly question - ARCH_HAS_PMEM_API is unconditionally enabled
> right? It should therefore be okay to make this an obj-y?

Yes, it is simpler to just add pmem.o in obj-y

I will update and send v6.

Thanks,
Anup


> Thanks
> Conor.
>
> > diff --git a/arch/riscv/mm/pmem.c b/arch/riscv/mm/pmem.c
> > new file mode 100644
> > index 000000000000..089df92ae876
> > --- /dev/null
> > +++ b/arch/riscv/mm/pmem.c
> > @@ -0,0 +1,21 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2022 Ventana Micro Systems Inc.
> > + */
> > +
> > +#include <linux/export.h>
> > +#include <linux/libnvdimm.h>
> > +
> > +#include <asm/cacheflush.h>
> > +
> > +void arch_wb_cache_pmem(void *addr, size_t size)
> > +{
> > +     ALT_CMO_OP(clean, addr, size, riscv_cbom_block_size);
> > +}
> > +EXPORT_SYMBOL_GPL(arch_wb_cache_pmem);
> > +
> > +void arch_invalidate_pmem(void *addr, size_t size)
> > +{
> > +     ALT_CMO_OP(inval, addr, size, riscv_cbom_block_size);
> > +}
> > +EXPORT_SYMBOL_GPL(arch_invalidate_pmem);
> > --
> > 2.34.1
> >
