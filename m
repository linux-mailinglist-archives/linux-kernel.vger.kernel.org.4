Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01CB75BE810
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbiITOGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbiITOGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:06:08 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8C41275B;
        Tue, 20 Sep 2022 07:05:37 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id w28so4004939edi.7;
        Tue, 20 Sep 2022 07:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=EwHes8ZciAYGoy8BwMgXo7aFIkW9k1/APFM7gcA+YE4=;
        b=UNDKskzLSAqbQLUP+UeVxwK0UrKWnS2e0H/TwbCQJ2rixeaZaYlbvCdGVYky9wfOby
         tp77xiWquLD1kWTMXO3uaWndWNce0DO6Tk/8LoU6eUapjDLrI0DkVT2VOESjxO5pjgm+
         dtagsyw2LVi+F7SCvTt6bRm4tbwmPSpojCL1wPR5020nN8WG2wjhN0BJ8J76o6cYTOM2
         44np7Wcpo+TYzPQZHqhhUNCQU56IFY4g4iMZJ1w+ltXtvEhbArAOijIiatTP1QHxBtEt
         SJbr4N+xQE3+on7lfFHYYb8DJ9C4mw1R5U3Co6UQ0VnZYbyu9J3orCJgOjAdOtOyHftD
         nTag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=EwHes8ZciAYGoy8BwMgXo7aFIkW9k1/APFM7gcA+YE4=;
        b=f8eVF29GyHKR+iP1f23UYAVq/mnAvAO7bNVCEGLQ9XACm12k+bdIFO/7UqUd+hp4eM
         qsL/hqr0GS+r7Om8CoZ7lvg+U5AE4ik8OYbgFVhLd7zHWYaWWvzUFEtO6cBUtgl+mAuI
         KWsTUYPp/QzPkr7tijKiY6hmuGrQIWpWiq00feg3PGt0xSWzQ7+c5jq1D2Ft9u7eTo7y
         BRhB8Etz+lBsFGMRf+U3pzOVIbXKIv4gKqBD+XqAMa8vZcOl3Pi1dWs39f8EzyCugMeM
         PqtiUczY22u0ulhZoEGZza1wjK03AeaNP/+JaEg0AIZRAjv7WTLdpsYrXvflh3vOIM6F
         WFeA==
X-Gm-Message-State: ACrzQf1iequQShcxSjdcTqQG2KeV7NxLy6k0oaOnjndxnBR3MoabRqJS
        jQF72GfVCNPj3ONBMhHEE8mglh4jC4SIzkyXHe/xRQN+o2Y=
X-Google-Smtp-Source: AMsMyM5XSfvvCDjeoAw6txH9Jh1QnO4jMEY9JZD9n/EemS81naNt3d916d86R2GXAfqdBjhL4qYHRFonHHvh+LhWNDo=
X-Received: by 2002:a05:6402:518d:b0:451:6655:5fb4 with SMTP id
 q13-20020a056402518d00b0045166555fb4mr20197904edd.150.1663682735470; Tue, 20
 Sep 2022 07:05:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220915181558.354737-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220915181558.354737-9-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdW99EutciosPtOTU9AztfvfMdKTaS+YRmpmS4VnhZ9KAA@mail.gmail.com>
In-Reply-To: <CAMuHMdW99EutciosPtOTU9AztfvfMdKTaS+YRmpmS4VnhZ9KAA@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 20 Sep 2022 15:05:05 +0100
Message-ID: <CA+V-a8s9y0Jq4TJk9E_ptsZTW3iCoysaBSrUeQV8qfDFO3wzeQ@mail.gmail.com>
Subject: Re: [PATCH v3 08/10] riscv: dts: renesas: Add minimal DTS for Renesas
 RZ/Five SMARC EVK
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko@sntech.de>,
        Atish Patra <atishp@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
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

On Tue, Sep 20, 2022 at 1:32 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Thu, Sep 15, 2022 at 8:17 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Enable the minimal blocks required for booting the Renesas RZ/Five
> > SMARC EVK with initramfs.
> >
> > Below are the blocks enabled:
> > - CPG
> > - CPU0
> > - DDR (memory regions)
> > - PINCTRL
> > - PLIC
> > - SCIF0
> >
> > Note we have deleted the nodes from the DT for which support needs to be
> > added for RZ/Five SoC and are enabled by RZ/G2UL SMARC EVK SoM/carrier
> > board DTS/I.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v2->v3
> > * Dropped RB tags from Conor and Geert
> > * Now re-using the SoM and carrier board DTS/I from RZ/G2UL
>
> Thanks for the update!
>
> > --- /dev/null
> > +++ b/arch/riscv/boot/dts/renesas/r9a07g043f01-smarc.dts
> > @@ -0,0 +1,27 @@
> > +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +/*
> > + * Device Tree Source for the RZ/Five SMARC EVK
> > + *
> > + * Copyright (C) 2022 Renesas Electronics Corp.
> > + */
> > +
> > +/dts-v1/;
> > +
> > +/*
> > + * DIP-Switch SW1 setting
> > + * 1 : High; 0: Low
> > + * SW1-2 : SW_SD0_DEV_SEL      (0: uSD; 1: eMMC)
> > + * SW1-3 : SW_ET0_EN_N         (0: ETHER0; 1: CAN0, CAN1, SSI1, RSPI1)
> > + * Please change below macros according to SW1 setting on SoM
>
> "on the SoM" (like in r9a07g043u11-smarc.dts)?
>
Agreed, I will update it.

> > --- /dev/null
> > +++ b/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
> > @@ -0,0 +1,42 @@
> > +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +/*
> > + * Device Tree Source for the RZ/Five SMARC EVK SOM
> > + *
> > + * Copyright (C) 2022 Renesas Electronics Corp.
> > + */
> > +
> > +#include <arm64/renesas/rzg2ul-smarc-som.dtsi>
> > +
> > +/ {
> > +       aliases {
> > +               /delete-property/ ethernet0;
> > +               /delete-property/ ethernet1;
>
> OK
>
I assume you are OK with dropping the above too?

> > +       };
> > +
> > +       chosen {
> > +               bootargs = "ignore_loglevel";
> > +       };
> > +};
> > +
> > +#if (SW_SW0_DEV_SEL)
> > +/delete-node/ &adc;
> > +#endif
> > +
> > +#if (!SW_ET0_EN_N)
> > +/delete-node/ &eth0;
> > +#endif
> > +/delete-node/ &eth1;
> > +
> > +/delete-node/ &ostm1;
> > +/delete-node/ &ostm2;
>
> Given they are all placeholders, do you really need to delete them?
> (more below)
>
I did retest without deleting the place holders and I dont see any
issues (or splat) while booting up so I'll drop them while sending the
v4.

Cheers,
Prabhakar
