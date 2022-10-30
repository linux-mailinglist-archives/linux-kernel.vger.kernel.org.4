Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5079B612D4B
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 23:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiJ3WYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 18:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJ3WYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 18:24:17 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A83AF3A;
        Sun, 30 Oct 2022 15:24:16 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id a5so15136369edb.11;
        Sun, 30 Oct 2022 15:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ehgZaHubNZdo2CvP/zZp9+nzfQddeMRWlE6HcbIW7Bc=;
        b=fAiybpRL/t0xYJnQDs28gp1slIWnDCfdLof3SC3Fkl4g7yuZ52njLvwzyqEdePx2gY
         uzKemtzQoYrCR1UWi98cA+x39VO54pkp0J/P3mhCXjxAAMKUTbfIaEscy07tkGm2xvW4
         JxIAI3w0G7t06j8thtGI2bR2rcLsxnFJ495PDtKxaUYupEepcIg/+Baqc9hoaZ3NEYZY
         GVRNLjrrwdQTGGCjToWl72Dp1Iu07uxuGVNmtNRF9qQRLoj7cFRppgvfemUa/eP+/ICD
         PXA9V2HQn30y2x5myXeEicJqYBWrZfGH2M9hSW3K5xf1YhITGffjw+NE1GytWYX4d5uK
         VRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ehgZaHubNZdo2CvP/zZp9+nzfQddeMRWlE6HcbIW7Bc=;
        b=TOlEr9dm+0p5ICYK92MAtBcT6NJgv7K1qqyaZq7hjNanXoKfqyLljKB+pet1sFeR7y
         rlKLPkVLyXEu7WPA1xaBt5XKWjOKD4qAj8/SZ0gHQLZwVJ9JozLteOSXELq2Fn08vUi9
         KOfG79/jl7bgjX0c8Oq0pw/uX/pBcIfo/83K5fvCdlFckZYlpf9W4ks3vAFbJuHr2jNd
         MfLctQ/KNArOJM3fgLy+CLaOLrY/YtGlcPDa45G74chOfLGHvJBU7hTh4IvwwGch/ExT
         FhmUfjiQijYzPVd5etYuH61NwD7NMi1vOWsmiuN263tGX35lfbjYNJJTEav5OslYUSvQ
         SU3Q==
X-Gm-Message-State: ACrzQf0zl9Ak2p1l4AFMACes71NTaDPBo2gVcGyIWFWhwHyTX4MJAuNP
        swylnPjUz8Ex53o/Tl0xcNNLqrjFKMULVx7sdOI=
X-Google-Smtp-Source: AMsMyM4YcN1F9xu9xszEg4LkYX+BeJuqsPfuXm0qiSqiFXYi3Rf+npa6BKZj5fpEQxHUpudLRCxbwKeAW5O0Eu5nito=
X-Received: by 2002:a05:6402:158d:b0:463:2343:b980 with SMTP id
 c13-20020a056402158d00b004632343b980mr6021896edv.150.1667168654744; Sun, 30
 Oct 2022 15:24:14 -0700 (PDT)
MIME-Version: 1.0
References: <20221028165921.94487-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221028165921.94487-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAJF2gTQPU0FGmeVt9jrNfOAQSA=04Vcm4U_wcC_dGMc5X2Bo7w@mail.gmail.com>
 <CA+V-a8vBkHhTtq6Veb2vn-6o4S5Ter==yN6TFhYQvxko_Bk2LQ@mail.gmail.com> <CAJF2gTSQH0q4PoucBgr3abWWA+XCdxm1tk1j8Sqydt_XyCq2RA@mail.gmail.com>
In-Reply-To: <CAJF2gTSQH0q4PoucBgr3abWWA+XCdxm1tk1j8Sqydt_XyCq2RA@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Sun, 30 Oct 2022 22:23:48 +0000
Message-ID: <CA+V-a8v6Bd9byKVRsLXzh4Bzco+5gVkJm8Azwvr2y36LB5Hk3w@mail.gmail.com>
Subject: Re: [PATCH v5 4/7] riscv: dts: renesas: Add initial devicetree for
 Renesas RZ/Five SoC
To:     Guo Ren <guoren@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@rivosinc.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
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

Hi Guo,

On Sun, Oct 30, 2022 at 1:02 AM Guo Ren <guoren@kernel.org> wrote:
>
> On Sun, Oct 30, 2022 at 3:11 AM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> >
> > Hi Guo,
> >
> > Thank you for the review.
> >
> > On Sat, Oct 29, 2022 at 5:25 AM Guo Ren <guoren@kernel.org> wrote:
> > >
> > > On Sat, Oct 29, 2022 at 12:59 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > > >
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > Add initial device tree for Renesas RZ/Five RISC-V CPU Core (AX45MP
> > > > Single).
> > > >
> > > > RZ/Five SoC is almost identical to RZ/G2UL Type-1 SoC (ARM64) hence we
> > > > will be reusing r9a07g043.dtsi [0] as a base DTSI for both the SoC's.
> > > > r9a07g043f.dtsi includes RZ/Five SoC specific blocks.
> > > >
> > > > Below are the RZ/Five SoC specific blocks added in the initial DTSI which
> > > > can be used to boot via initramfs on RZ/Five SMARC EVK:
> > > > - AX45MP CPU
> > > > - PLIC
> > > >
> > > > [0] arch/arm64/boot/dts/renesas/r9a07g043.dtsi
> > > >
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > ---
> > > > v4 -> v5
> > > > * Fixed riscv,ndev value (should be 511)
> > > > * Reworked completely (sort of new patch)
> > > >
> > > > v3 -> v4
> > > > * No change
> > > >
> > > > v2 -> v3
> > > > * Fixed clock entry for CPU core
> > > > * Fixed timebase frequency to 12MHz
> > > > * Fixed sorting of the nodes
> > > > * Included RB tags
> > > >
> > > > v1 -> v2
> > > > * Dropped including makefile change
> > > > * Updated ndev count
> > > > ---
> > > >  arch/riscv/boot/dts/renesas/r9a07g043f.dtsi | 57 +++++++++++++++++++++
> > > >  1 file changed, 57 insertions(+)
> > > >  create mode 100644 arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
> > > >
> > > > diff --git a/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi b/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
> > > > new file mode 100644
> > > > index 000000000000..50134be548f5
> > > > --- /dev/null
> > > > +++ b/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
> > > > @@ -0,0 +1,57 @@
> > > > +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +/*
> > > > + * Device Tree Source for the RZ/Five SoC
> > > > + *
> > > > + * Copyright (C) 2022 Renesas Electronics Corp.
> > > > + */
> > > > +
> > > > +#include <dt-bindings/interrupt-controller/irq.h>
> > > > +
> > > > +#define SOC_PERIPHERAL_IRQ(nr) (nr + 32)
> > > > +
> > > > +#include <arm64/renesas/r9a07g043.dtsi>
^^^ look below...

> > > The initial patch shouldn't be broken. Combine them together with the
> > > minimal components and add others late. Don't separate the DTS files.
> > >
> > r9a07g043.dtsi [0] already exists in the kernel. r9a07g043.dtsi is
> > shared with the RZ/G2UL SoC (ARM64) and the RZ/Five SoC. There are two
> > more patches [1] which are required and are currently queued up in the
> > Renesas tree for v6.2 (Ive mentioned the dependencies in the cover
> > letter).
>
> You could just move the below part to the second dtsi patch. Then
> compile won't be broken.
>
>             clocks = <&cpg CPG_MOD R9A07G043_NCEPLIC_ACLK>;
>             power-domains = <&cpg>;
>             resets = <&cpg R9A07G043_NCEPLIC_ARESETN>;
>
Compile won't break at all, the CPG node [0] and the pinctrl node [1]
already exists in the kernel which is being re-used by this SoC DTSI.

... the include file above already exists in the kernel and is not
part of the next follow up patch.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/renesas/r9a07g043.dtsi?h=next-20221028#n541
[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/renesas/r9a07g043.dtsi?h=next-20221028#n563

Cheers,
Prabhakar
