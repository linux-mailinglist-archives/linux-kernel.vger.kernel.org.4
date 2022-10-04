Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C745F3D36
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 09:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiJDH0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 03:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJDH0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 03:26:30 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946FF3ED73;
        Tue,  4 Oct 2022 00:26:29 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id lt21so1657144ejb.0;
        Tue, 04 Oct 2022 00:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=T3VGRLa6aY7lVkf/VuhGMNa+o18TjOrgkKnR6deWLjE=;
        b=nTdCXM20HL5cFabkBUv1DnQX20uSpePVUtP19e2qSGkWNdmYwRslvNTJ1T8SmB7LQf
         cAHyD6MQIbYIfRFr9qJZU4idDuvQfy3eBTDk+mu9RouqgQkuGLl+jfCL3zMRX4P9JhVL
         6iSEAABhrLD8NPVNyKR9g9W9BUTV0MTgtVUxiMx3OQp4ileKlqMgwv8tVuiesimdiRTo
         rqekcAdj3HXnTKd4ObTe5Xe18PSIg1zl5eDHu55aYGE4lx7rEk4o+ZUEquvIOL3mD+dj
         CGgwCEfL1clKoRdJ4nk/HSLZGAbrI60PTOao0Cq8Tqu4zy1Y2RotrbZisgo5OjecBPXa
         3U2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=T3VGRLa6aY7lVkf/VuhGMNa+o18TjOrgkKnR6deWLjE=;
        b=WOE+jXpVPm9Ps/kwQpX8otTyHB+Bjgh0BqGWdKRQ9MsFa97simvpkr7eayEZnK20ca
         CeUb6BRXpF8tCJU1sq3Af9C1K7hlNq0Xiyti7ulsx8Z4toTC17nYu4b3sNUM8mHvggAq
         9UmpBAFzGxKH7sWhKjXtTXSRiyFh4uD+X7p/OXuq48niJ4msoOUxftHjYb20GPrkIaGx
         zmc2vQcl0zwFVztQsxWDei6azR0qZ6J5geBks1f6Ly+p5pP6FJ23pj1a3uefsD7HfKwd
         Qeazq9YMPi/QlVBtQ+NcTfBbXrFq6keBYuB04bk+uQxFj0+giFO8IjsxAdSZ3z6ah7xy
         g6FQ==
X-Gm-Message-State: ACrzQf0a/PAw7shm67bBoGTr1xvzE6mlSPPPJFFFmNxTZl8tLxEeaEKq
        /lU5CtOmEk3fKjmJoeuqBdusKL0ompVetB9wkGc=
X-Google-Smtp-Source: AMsMyM7REJDwTonQC1YNeER8EI+7qTq2llohoFBpu6tNo14D20X5S629XxELZSCTnSFF+grYSwJw237zL9ganyg38Bw=
X-Received: by 2002:a17:907:75dc:b0:78b:339:63c7 with SMTP id
 jl28-20020a17090775dc00b0078b033963c7mr7383359ejc.480.1664868388049; Tue, 04
 Oct 2022 00:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <20221003223222.448551-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221003223222.448551-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdX1BuvHz46QWd+ajEcwmWMeSmvN4AtODuFEysRk14ArZQ@mail.gmail.com>
In-Reply-To: <CAMuHMdX1BuvHz46QWd+ajEcwmWMeSmvN4AtODuFEysRk14ArZQ@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 4 Oct 2022 08:26:01 +0100
Message-ID: <CA+V-a8vnNQDMgjhJfz91g++dVVv5Z5FTuFrNRHLW3PjPump0Mg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/2] dt-bindings: soc: renesas: r9a07g043f-l2-cache:
 Add DT binding documentation for L2 cache controller
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
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

On Tue, Oct 4, 2022 at 7:42 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Tue, Oct 4, 2022 at 12:32 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Add DT binding documentation for L2 cache controller found on RZ/Five SoC.
> >
> > The Renesas RZ/Five microprocessor includes a RISC-V CPU Core (AX45MP
> > Single) from Andes. The AX45MP core has an L2 cache controller, this patch
> > describes the L2 cache block.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/soc/renesas/r9a07g043f-l2-cache.yaml
>
> Not andestech,ax45mp-cache.yaml?
>
I wasn't sure as we were including this in soc/renesas so named it as
r9a07g043f-l2-cache.yaml if there are no issues I'll rename it
andestech,ax45mp-cache.yaml.

> > @@ -0,0 +1,82 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +# Copyright (C) 2022 Renesas Electronics Corp.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/soc/renesas/r9a07g043f-l2-cache.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: SiFive L2 Cache Controller
>
> Andestech AX45MP?
>
Ouch!

> > +
> > +maintainers:
> > +  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > +
> > +description:
> > +  A level-2 cache (L2C) is used to improve the system performance by providing
> > +  a larger amount of cache line entries and reasonable access delays. The L2C
> > +  is shared between cores, and a non-inclusive non-exclusive policy is used.
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: andestech,ax45mp-cache
> > +      - const: cache
>
> This makes the schema apply to any node which is compatible with
> "cache", cfr. the report from Rob's bot.
>
Actually dt_binding_check didn't complain when I ran it locally (maybe
it's time to update dt-schema).

> You need a select block to avoid that, cfr.
> Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml.
>
Thanks for the pointer.

Cheers,
Prabhakar
