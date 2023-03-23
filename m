Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36326C68E4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjCWMyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjCWMyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:54:20 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073CCAF1E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:54:18 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id t17-20020a05600c451100b003edc906aeeaso1782725wmo.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1679576056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJkjkDDXcfaVEj/wzBuynagqiTlGyMneMBfA6NRDFpA=;
        b=HR6KCQS776uoD7UGnbRZdWuSA1KClPo4MTXzADx7rQ2WKrUdB81NFWVPwPPMCgCMWv
         XJ/u5N+tal5a/MZ33HO7NrBNUxCV1KKSM59x9+tRwHY5c30FzgE8vRD45dNTh0IWEmCx
         2geo29vy+AAc9Duo/xCij7+X8gJX+NLjuGuulf1OhXoWlC6J7z0ReGShAGQWrAj67P3t
         YHXlZVk+pHgCvkfDlu3gPh6oqsCzJ13wNrX5bBiEatSnaTriNuLp3PdBKmUdMUQcMUgQ
         tClyIx+mExQFvfArw5D3bFM8yIcqIPiqXG+Qs91CkHKBtOJ9zXu/7B1k6baKFrJjx9r6
         08LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679576056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJkjkDDXcfaVEj/wzBuynagqiTlGyMneMBfA6NRDFpA=;
        b=riCOldvJOCI8JWafkcZJZC11H1t15bvNXoRTexm0TZt9RiPmGkmMZiFCc/otMiqg1V
         d6JUem2oeIy8XXC8ZV/L45qecn42iJtu914QoGS4iA29NgD46K/IECXEnBgd1gqmyo02
         8sXbd5jEHRJ71If/Dyzs7s1Ukm6qyWluO1NSZXg+W/wJKeT90HApGI2JBVK7nZfNSgE8
         zndWbCFt0RfwclvgKmVzkcRU53e5+6BMtGTiCCdKJllUM4p68OTA41zKuvPMvwibGlL8
         F0gsdB2ljDC/eK0DPs3ixfNR8gCuR1zYZhVdB3CiCDY9Ssw+15rvs8eSbEnxl5oqPDCi
         RJNA==
X-Gm-Message-State: AO0yUKV1gJ0xlE2L37D+zS3GXgWMrjO1j3Cv85QDDUbVZRBvasGVS99P
        AZ2fC8FR5EUq1dsx1Q9tvOw3uGkuRyLacP3M/0RZQA==
X-Google-Smtp-Source: AK7set+cxes5jKFyq91uR4zzQ+z8CDae/libm0ngmGBzyHd+HlvVpBhotdASHGu/nauWRHYX/FvMVf1MWJijHfR/THk=
X-Received: by 2002:a05:600c:217:b0:3df:97cf:4590 with SMTP id
 23-20020a05600c021700b003df97cf4590mr704838wmi.3.1679576056462; Thu, 23 Mar
 2023 05:54:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230316131711.1284451-1-alexghiti@rivosinc.com> <CAK9=C2XJtSG2d_nsyDv7kU1v7Jj0chdevqrMc0MpJswukcEABA@mail.gmail.com>
In-Reply-To: <CAK9=C2XJtSG2d_nsyDv7kU1v7Jj0chdevqrMc0MpJswukcEABA@mail.gmail.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Thu, 23 Mar 2023 13:54:05 +0100
Message-ID: <CAHVXubhhxpzHDM-n91V_rceY5t_VqLvrwZj3RP_tNL2=F9mqjQ@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] riscv: Use PUD/P4D/PGD pages for the linear mapping
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup@brainfault.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anup,

On Thu, Mar 23, 2023 at 1:18=E2=80=AFPM Anup Patel <apatel@ventanamicro.com=
> wrote:
>
> Hi Alex,
>
> On Thu, Mar 16, 2023 at 6:48=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosi=
nc.com> wrote:
> >
> > This patchset intends to improve tlb utilization by using hugepages for
> > the linear mapping.
> >
> > As reported by Anup in v6, when STRICT_KERNEL_RWX is enabled, we must
> > take care of isolating the kernel text and rodata so that they are not
> > mapped with a PUD mapping which would then assign wrong permissions to
> > the whole region: it is achieved by introducing a new memblock API.
> >
> > Another patch makes use of this new API in arm64 which used some sort o=
f
> > hack to solve this issue: it was built/boot tested successfully.
> >
> > base-commit-tag: v6.3-rc1
> >
> > v8:
> > - Fix rv32, as reported by Anup
> > - Do not modify memblock_isolate_range and fixes comment, as suggested =
by Mike
> > - Use the new memblock API for crash kernel too in arm64, as suggested =
by Andrew
> > - Fix arm64 double mapping (which to me did not work in v7), but ends u=
p not
> >   being pretty at all, will wait for comments from arm64 reviewers, but
> >   this patch can easily be dropped if they do not want it.
> >
> > v7:
> > - Fix Anup bug report by introducing memblock_isolate_memory which
> >   allows us to split the memblock mappings and then avoid to map the
> >   the PUD which contains the kernel as read only
> > - Add a patch to arm64 to use this newly introduced API
> >
> > v6:
> > - quiet LLVM warning by casting phys_ram_base into an unsigned long
> >
> > v5:
> > - Fix nommu builds by getting rid of riscv_pfn_base in patch 1, thanks
> >   Conor
> > - Add RB from Andrew
> >
> > v4:
> > - Rebase on top of v6.2-rc3, as noted by Conor
> > - Add Acked-by Rob
> >
> > v3:
> > - Change the comment about initrd_start VA conversion so that it fits
> >   ARM64 and RISCV64 (and others in the future if needed), as suggested
> >   by Rob
> >
> > v2:
> > - Add a comment on why RISCV64 does not need to set initrd_start/end th=
at
> >   early in the boot process, as asked by Rob
> >
> > Alexandre Ghiti (4):
> >   riscv: Get rid of riscv_pfn_base variable
> >   mm: Introduce memblock_isolate_memory
> >   arm64: Make use of memblock_isolate_memory for the linear mapping
> >   riscv: Use PUD/P4D/PGD pages for the linear mapping
>
> Kernel boot fine on RV64 but there is a failure which is still not
> addressed. You can see this failure as following message in
> kernel boot log:
>     0.000000] Failed to add a System RAM resource at 80200000

Hmmm I don't get that in any of my test configs, would you mind
sharing yours and your qemu command line?

Thanks

>
> Regards,
> Anup
>
> >
> >  arch/arm64/mm/mmu.c           | 25 +++++++++++------
> >  arch/riscv/include/asm/page.h | 19 +++++++++++--
> >  arch/riscv/mm/init.c          | 53 ++++++++++++++++++++++++++++-------
> >  arch/riscv/mm/physaddr.c      | 16 +++++++++++
> >  drivers/of/fdt.c              | 11 ++++----
> >  include/linux/memblock.h      |  1 +
> >  mm/memblock.c                 | 20 +++++++++++++
> >  7 files changed, 119 insertions(+), 26 deletions(-)
> >
> > --
> > 2.37.2
> >
