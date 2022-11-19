Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C2D630EC7
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 13:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbiKSMlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 07:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiKSMlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 07:41:23 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96226B9F1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 04:41:22 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1322d768ba7so8989100fac.5
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 04:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ukIKYhKcZQpJNegqQ3ExbTO6FMrR9OLmlAf7eR0n2TU=;
        b=Dw0k+yWMHTCoPUk2OuSG3qdmxFTLbjwhGbhCa7cWdMqxgac5/bT/ks8OArPGczeRGB
         i9V0rT5g87bCv/ZC4xLKB9KiKz8QxImao4c45SDYUyBiFdoBHoBmYQfVX7+27hIi6K2i
         5LsTsUiPEIvVwzNgoqwMAWCPVD7WhBp2kxGt5Uswp+2t0puVx7ci4pejoRNmsck3O9zI
         zkvfRqoM8IhbHjE/ghPyVMmg0/2XCNHRXikvL2CBI15tjxZ1eSI/OEC0AzGG5OfSDkOr
         vr5Noz/xSjKKYyL1TnK7FNw1Q5nZXhe78C1wkJ1MlN7iYO6k9r5Kz11vgFX/TPcT+KvC
         U7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ukIKYhKcZQpJNegqQ3ExbTO6FMrR9OLmlAf7eR0n2TU=;
        b=iYf1X5xlV9Kfuf//6uPdJGWm9q2zQ2cf0c85G9uSPByfjPO78T1NeHO4UOcOmoM957
         bD4BPeO0Si8EmU41vmuMCjL6tNDVlgUcAXOFAdifyDogQKF8kVqvb0g51LDetMTLyyYv
         FLzD4AxacZmOxsKe88+HxS77g6HAkzkirL+3Zy3nhGw4eFZI1NYrwry0H/Fl8+JrhbVi
         AAhzdmmAnrPYy7AMP/eMPEa5UH86N93+SH4nsZFe77kfcErgL4MhxU2t17i+vU9+6Zum
         7/HqXUq/eTNYlr63y5pXG+vABrDernwMoTgQKKeAcTX1IB15y+DOSW4Y+jiK+sj8vLxX
         gFZw==
X-Gm-Message-State: ANoB5pnwYGHpisYlYiU6pmyJ2v0mTPRV44hpQW/s9mW6g65GcskmShj0
        edUgocMdYOKa3ND3mIoCxN5wVE8nqazmq8PLPlVQcQ==
X-Google-Smtp-Source: AA0mqf59eo6RB/JabY5iA+XwD4aELknMkiZwGCBNgxjw+gr7HUVOJK9NzHuAqsU7+shp++Rs2Hml8og4EeVGVLSpunQ=
X-Received: by 2002:a05:6870:ad0e:b0:132:a767:a2ba with SMTP id
 nt14-20020a056870ad0e00b00132a767a2bamr6249902oab.271.1668861681057; Sat, 19
 Nov 2022 04:41:21 -0800 (PST)
MIME-Version: 1.0
References: <20221114090536.1662624-1-apatel@ventanamicro.com> <Y3JvwagRsMOJyayy@spud>
In-Reply-To: <Y3JvwagRsMOJyayy@spud>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Sat, 19 Nov 2022 18:11:08 +0530
Message-ID: <CAK9=C2VRbUiFS2dCNVoC4KJNe4L+EMXNpfSfTrGoFuLRko1TkA@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] Add PMEM support for RISC-V
To:     Conor Dooley <conor@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atishp@atishpatra.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 10:11 PM Conor Dooley <conor@kernel.org> wrote:
>
> Hey Anup,
>
> Looks like patches 2 and 3 are failing for the nommu defconfigs:
> https://patchwork.kernel.org/project/linux-riscv/list/?series=694995
> Unfortunately, if the build fails NIPA doesn't appear to save a log.
>
> In case it's relevant, should be gcc-11 & bintutils 2.37.

I tried nommu defconfigs with gcc-12.1.0 and binutils-2.39 and I did
not see any failure.

Regards,
Anup

>
> Thanks,
> Conor.
>
> On Mon, Nov 14, 2022 at 02:35:33PM +0530, Anup Patel wrote:
> > The Linux NVDIMM PEM drivers require arch support to map and access the
> > persistent memory device. This series adds RISC-V PMEM support using
> > recently added Svpbmt and Zicbom support.
> >
> > First two patches are fixes and remaining two patches add the required
> > PMEM support for Linux RISC-V.
> >
> > These patches can also be found in riscv_pmem_v6 branch at:
> > https://github.com/avpatel/linux.git
> >
> > Changes since v5:
> >  - Rebased on Linux-6.1-rc5
> >  - Directly add pmem.o in obj-y of PATCH3
> >  - Dropped PATCH1 since this is already merged.
> >
> > Changes since v4:
> >  - Simplify PATCH2 by implementing RISC-V specific arch_memremap_wb()
> >
> > Changes since v3:
> >  - Pickup correct version of Drew's patch as PATCH1
> >
> > Changes since v2:
> >  - Rebased on Linux-6.1-rc1
> >  - Replaced PATCH1 with the patch proposed by Drew
> >
> > Changes since v1:
> >  - Fix error reported by test bot
> >    https://lore.kernel.org/all/202208272028.IwrNZ0Ur-lkp@intel.com/
> >
> > Anup Patel (3):
> >   RISC-V: Fix MEMREMAP_WB for systems with Svpbmt
> >   RISC-V: Implement arch specific PMEM APIs
> >   RISC-V: Enable PMEM drivers
> >
> >  arch/riscv/Kconfig           |  1 +
> >  arch/riscv/configs/defconfig |  1 +
> >  arch/riscv/include/asm/io.h  |  5 +++++
> >  arch/riscv/mm/Makefile       |  1 +
> >  arch/riscv/mm/pmem.c         | 21 +++++++++++++++++++++
> >  5 files changed, 29 insertions(+)
> >  create mode 100644 arch/riscv/mm/pmem.c
> >
> > --
> > 2.34.1
> >
