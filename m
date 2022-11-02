Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273A66156D5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 02:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiKBBA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 21:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiKBBAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 21:00:25 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DD71F60B;
        Tue,  1 Nov 2022 18:00:25 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id d26so41365170eje.10;
        Tue, 01 Nov 2022 18:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cKOPjxW6hMffC27C/SCX+FUVc2eMjho9VRyb1I26W+A=;
        b=WMeekXVXt4lsAnluw5FHfJXlbxIcWLcnK0/RbVL1jCWnwcib9Y/v8p/XxVAeCBO9DQ
         sNQ6Q/hQkfJCuB3h5z7fiH09wV2j3CsLzSjQKJoaCnjvn1vOZcv9Y8Ofna042Tng4guC
         RR742cQGy1mL7xZVk/+8ThiEG0hcPC3AdbHs8LmE0YtoDzy6PpgN4TU8VmDowr2XB4vs
         IK77xH1Q1BB6X24V0KWE1p8qBtzIiupySA3AMX5CiqITFm2O+IggA3y0nmWZoGhTAwb6
         gpmNVwNjfxUrSO8STeE10KBGR4kV7qNLS+RqCG9FXfiKc6sdLUaI3q0Nc3jZvXLShbMe
         q1Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cKOPjxW6hMffC27C/SCX+FUVc2eMjho9VRyb1I26W+A=;
        b=ygecsmz1MENijTEyWn0tdEpxy5J1UHK6oB+1Z3KlNp0QxZDqJIAIyYU4qwecLF4CIO
         Fj0hAjDUg6yahO9WSCGfst1WrqHrueqCiRDlkjt0ghLc4FZ4SuTL86oDeFyhfWDM96Cy
         +uUcuT6gCLpFDxKIi5SGw0zrn0d9zEqjAPvCrShwhyVVyxf0i8Mqj3x8iu8wDJ35y4xE
         o7DOgqePbtZ54bK4lmGeF+D8BoxZHWAGTqM2JnWLWiixfdFvJCpmimvtZs4vamqpDYLo
         T6SJIrXEBUH6TIRCO2l9UnmryPxILNCeE4SwOOHWBRp1Opa87L+FuBULFFYBgm+9T3yw
         oEgQ==
X-Gm-Message-State: ACrzQf3Q8Kep7rWvu0HOsy/B+LGmgJpOUeix6BLautUqVbyHpgRFL+7x
        AuWs/KZLVDlnJYQbFxv+whIVd/RVoNcK6Y7zdZQ=
X-Google-Smtp-Source: AMsMyM7c/ABaJaKAKRpL8Ijw/KO0JHwmCdEqPhD5GS9nFJ96c+cfsR284v8V2kqJHwH5onhRriMFhzTVZ3Xb/F628+Q=
X-Received: by 2002:a17:906:c14f:b0:793:30e1:96be with SMTP id
 dp15-20020a170906c14f00b0079330e196bemr21349587ejc.447.1667350823464; Tue, 01
 Nov 2022 18:00:23 -0700 (PDT)
MIME-Version: 1.0
References: <20221019220242.4746-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221019220242.4746-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdU6+qNQh2vFic89cnqDmUoyhrJTROCHPdoPguXAEnZMfA@mail.gmail.com>
In-Reply-To: <CAMuHMdU6+qNQh2vFic89cnqDmUoyhrJTROCHPdoPguXAEnZMfA@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 2 Nov 2022 00:59:57 +0000
Message-ID: <CA+V-a8sv9QVDfokN5LExu9p5GeCuHb99-mxBpugDk6J2LSB8SQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/2] soc: renesas: Add L2 cache management for
 RZ/Five SoC
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Tue, Nov 1, 2022 at 1:38 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Thu, Oct 20, 2022 at 12:02 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > On the AX45MP core, cache coherency is a specification option so it may
> > not be supported. In this case DMA will fail. As a workaround, firstly we
> > allocate a global dma coherent pool from which DMA allocations are taken
> > and marked as non-cacheable + bufferable using the PMA region as specified
> > in the device tree. Synchronization callbacks are implemented to
> > synchronize when doing DMA transactions.
> >
> > The Andes AX45MP core has a Programmable Physical Memory Attributes (PMA)
> > block that allows dynamic adjustment of memory attributes in the runtime.
> > It contains a configurable amount of PMA entries implemented as CSR
> > registers to control the attributes of memory locations in interest.
> >
> > Below are the memory attributes supported:
> > * Device, Non-bufferable
> > * Device, bufferable
> > * Memory, Non-cacheable, Non-bufferable
> > * Memory, Non-cacheable, Bufferable
> > * Memory, Write-back, No-allocate
> > * Memory, Write-back, Read-allocate
> > * Memory, Write-back, Write-allocate
> > * Memory, Write-back, Read and Write-allocate
> >
> > This patch adds support to configure the memory attributes of the memory
> > regions as passed from the l2 cache node and exposes the cache management
> > ops.
> >
> > More info about PMA (section 10.3):
> > http://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-5.0.0-Datasheet.pdf
> >
> > This feature is based on the work posted [0] by Vincent Chen
> > <vincentc@andestech.com> for the Andes AndeStart RISC-V CPU.
> >
> > [0] https://lore.kernel.org/lkml/1540982130-28248-1-git-send-email-vincentc@andestech.com/
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> > --- a/arch/riscv/include/asm/errata_list.h
> > +++ b/arch/riscv/include/asm/errata_list.h
> > @@ -89,6 +89,7 @@ asm volatile(ALTERNATIVE(                                             \
> >  #define ALT_THEAD_PMA(_val)
> >  #endif
> >
> > +#ifdef CONFIG_ERRATA_THEAD_CMO
> >  /*
> >   * dcache.ipa rs1 (invalidate, physical address)
> >   * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
> > @@ -143,5 +144,6 @@ asm volatile(ALTERNATIVE_2(                                         \
> >         : "a0")
> >
> >  #endif /* __ASSEMBLY__ */
> > +#endif
>
> FTR, the new #endif should be above the old #endif.
>
> I noticed because after rebasing on top of commit 65e9fb081877a18c
> ("drivers/perf: riscv_pmu_sbi: add support for PMU variant on T-Head
> C9xx cores") in riscv/for-next, the build failed because the new
> ALT_SBI_PMU_OVERFLOW() definition ended up inside both #endifs,
> instead of between.
>
Thanks for pointing this out.

Cheers,
Prabhakar
