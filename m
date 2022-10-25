Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0A260D158
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 18:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbiJYQL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 12:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbiJYQLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 12:11:24 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F00EEAB2;
        Tue, 25 Oct 2022 09:11:23 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id y69so18009906ede.5;
        Tue, 25 Oct 2022 09:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JlXbIDv9437lExc8ejab3R1D1/KjaGnyi1kzpCh97FY=;
        b=gLjcHgW+H7vRYcAMMpizp/Ql0s90VR4SnYym1rTloiMZSZCth0n7GsoLxeVMBofFSS
         fKW5dOM0xYdyi+G1CfGzjNYq9ldtyS/J+wetGAbPYOhde5gAjMMYi/YvfoBbGJb1+hAh
         mOUQT9ilxzCCK/OLWaWFBzNKpQiPdeZTjOKrGSYZRQYxau7PMiq5bBwpbtJzZ5Ps1IrW
         mWpOrApdt4w+Nmrn4+SjhC3eoJ+LzlrXCRSY671e0BoRbSyBDcvMhPqNzqcwip7kWzYQ
         rSuVu/bZjF2NhLAamh8akKhlTWGtZuBioS7moKOJtYVyW9HAtmrKSSwRhLMj2TqD/Pde
         bZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JlXbIDv9437lExc8ejab3R1D1/KjaGnyi1kzpCh97FY=;
        b=CXW5cAVlZCbORGexRyzmwDZlg5whPXHF3tco4s1REh/e2PPiI/rBTYRXy7h0uVrJUA
         YQkPZnZ0NpDqs+xgcRIwQOizQYM/ex7xFGi7jz/6dqWKFvAdywk9Qx6l0Ei1lgBLplfp
         BKWpSuZhifMdBuvvOtwhn5SgG+0aiWQ2RZsgprAtlYp+P6CVDwLj2PeSUx0Uurcw3gX4
         W5D9/7M6rNZ+Mv3StkBnyyQJ7AZvcxp4rXwnbBSkPkILT45PyLSFJEz9WgmaOT06DnYk
         l0BjVue2VatF5uOuGXEfyGLugX5xjxZBjwICSNBuPbHIb9DVXTvkSDMnjhTofnHaH5RP
         V4Ag==
X-Gm-Message-State: ACrzQf3++muZfvioh/OjyrAYGNmFkvuVVrcggLTbfsq6vBi4XwpEZV0h
        v/uMRK76zyrjfhqCKfpKs1HiV9XIN/00iycVHF4=
X-Google-Smtp-Source: AMsMyM5IYA65H7Pr/6Jmn0rANYjXlWU97pLnIVRzuk9t3RJDMspuL/wBdeTH2rr9fzryGYGCc8oupzb6cw4vPMk3DVM=
X-Received: by 2002:a05:6402:40c2:b0:461:a29c:4ac0 with SMTP id
 z2-20020a05640240c200b00461a29c4ac0mr13289160edb.319.1666714281900; Tue, 25
 Oct 2022 09:11:21 -0700 (PDT)
MIME-Version: 1.0
References: <20221017091201.199457-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221017091201.199457-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdXiim0bDBxaGWi2GjAmKS1gKj8D8TUBPXnZtm0EphKsmQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXiim0bDBxaGWi2GjAmKS1gKj8D8TUBPXnZtm0EphKsmQ@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 25 Oct 2022 17:10:55 +0100
Message-ID: <CA+V-a8s43vAhX4gf+AtgNoru_V4tq0e=cC+oB-VsSPJ_hWjj4A@mail.gmail.com>
Subject: Re: [RFC RESEND PATCH 1/2] arm64: dts: renesas: r9a07g043: Introduce
 SOC_PERIPHERAL_IRQ() macro to specify interrupt property
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
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

Thank you for the review.

On Tue, Oct 25, 2022 at 1:28 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Mon, Oct 17, 2022 at 11:12 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Introduce SOC_PERIPHERAL_IRQ() macro to specify interrupt property so
> > that we can share the common parts of the SoC DTSI with the RZ/Five
> > (RISC-V) SoC and the RZ/G2UL (ARM64) SoC.
> >
> > This patch adds a new file r9a07g043u.dtsi to separate out RZ/G2UL
> > (ARM64) SoC specific parts. No functional changes (same DTB).
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
> > @@ -0,0 +1,12 @@
> > +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +/*
> > + * Device Tree Source for the RZ/G2UL SoC
> > + *
> > + * Copyright (C) 2022 Renesas Electronics Corp.
> > + */
> > +
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +#define SOC_PERIPHERAL_IRQ(nr, na)     GIC_SPI nr na
>
> s/na/flags/
>
> Originally, when I assumed incorrectly that dtc does not support
> arithmetic, I used "nr" and "na" in the macro I proposed to mean RISC-V
> ("r") resp. ARM ("a") interrupt number.  Apparently the names stuck,
> although the second parameter now has a completely different meaning ;-)
>
> However, as the NCEPLIC does support interrupt flags, unlike the SiFive
> PLIC, there is no need to have the flags parameter in the macro.
>
Ok, I'll drop the second parameter.

Cheers,
Prabhakar
