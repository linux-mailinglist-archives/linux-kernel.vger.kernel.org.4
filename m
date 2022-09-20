Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F155BE9AE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 17:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiITPHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 11:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiITPHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 11:07:35 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C8A15FED;
        Tue, 20 Sep 2022 08:07:33 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id y2so1785689qkl.11;
        Tue, 20 Sep 2022 08:07:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=beo87QLkKwCHQVFvRevjYmIvSu6gsEO9BIku51wSlXE=;
        b=oh7YQxx4Wx9STZnAnyUKAO4aBmPiOmY8n1uiYeyub4FEKBacxm14TDNpGlNv+WvVGE
         IHtcriPs9cjt03oqVdhr9RuTSgs0wkIPM2nHBV7InOcFnOh0AupZgVYBraR6iIZtZ2L6
         2JjmVXKD4HPdnfzmoQz/u9uzVIxg8F21QlkjPaeGoK7zEo8TRo2vIf8ewpk/3t/W0s2j
         J6UtOL8/7ArswYZ5o2TKwZkos7gsUWKjwNgzSZ3fRBnAY1xQWP7ZbPRFWimDbDdZB/TM
         ZOZHRxAl5IkGPNN8azOnL5eK7lwgLSfv4K3FICaZzHW8v1EhTXNOvSZSO5N1VrWYOw8V
         v8tQ==
X-Gm-Message-State: ACrzQf0VC8HcY2GxmbnHZXONX/zXyI40dcHfuJea8aaIpBqCZg1GkH5l
        jfuSETEMliFwZToYlbbqIxfyyFEHv9WSyw==
X-Google-Smtp-Source: AMsMyM7iTFuRDkRqCv4yKePkNuqurAmE9VL9By98xxAjL6Yj3lEfR372ozdeNWpjbYQPqVk7suPRCA==
X-Received: by 2002:a05:620a:222f:b0:6cb:dc20:f0c3 with SMTP id n15-20020a05620a222f00b006cbdc20f0c3mr15932688qkh.366.1663686452218;
        Tue, 20 Sep 2022 08:07:32 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id de4-20020a05620a370400b006bb87c4833asm230950qkb.109.2022.09.20.08.07.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 08:07:31 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-3452214cec6so30865657b3.1;
        Tue, 20 Sep 2022 08:07:31 -0700 (PDT)
X-Received: by 2002:a81:8d3:0:b0:34d:1215:fb4b with SMTP id
 202-20020a8108d3000000b0034d1215fb4bmr7135561ywi.383.1663686450814; Tue, 20
 Sep 2022 08:07:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220915181558.354737-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220915181558.354737-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdW99EutciosPtOTU9AztfvfMdKTaS+YRmpmS4VnhZ9KAA@mail.gmail.com> <CA+V-a8s9y0Jq4TJk9E_ptsZTW3iCoysaBSrUeQV8qfDFO3wzeQ@mail.gmail.com>
In-Reply-To: <CA+V-a8s9y0Jq4TJk9E_ptsZTW3iCoysaBSrUeQV8qfDFO3wzeQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 20 Sep 2022 16:07:18 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWy=uU-QQgkz+-sBHfuK9tE-E4LijVLrYX7Efh9=C9vLg@mail.gmail.com>
Message-ID: <CAMuHMdWy=uU-QQgkz+-sBHfuK9tE-E4LijVLrYX7Efh9=C9vLg@mail.gmail.com>
Subject: Re: [PATCH v3 08/10] riscv: dts: renesas: Add minimal DTS for Renesas
 RZ/Five SMARC EVK
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
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
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Tue, Sep 20, 2022 at 3:05 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Tue, Sep 20, 2022 at 1:32 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Thu, Sep 15, 2022 at 8:17 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Enable the minimal blocks required for booting the Renesas RZ/Five
> > > SMARC EVK with initramfs.
> > >
> > > Below are the blocks enabled:
> > > - CPG
> > > - CPU0
> > > - DDR (memory regions)
> > > - PINCTRL
> > > - PLIC
> > > - SCIF0
> > >
> > > Note we have deleted the nodes from the DT for which support needs to be
> > > added for RZ/Five SoC and are enabled by RZ/G2UL SMARC EVK SoM/carrier
> > > board DTS/I.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

> > > --- /dev/null
> > > +++ b/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
> > > @@ -0,0 +1,42 @@
> > > +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +/*
> > > + * Device Tree Source for the RZ/Five SMARC EVK SOM
> > > + *
> > > + * Copyright (C) 2022 Renesas Electronics Corp.
> > > + */
> > > +
> > > +#include <arm64/renesas/rzg2ul-smarc-som.dtsi>
> > > +
> > > +/ {
> > > +       aliases {
> > > +               /delete-property/ ethernet0;
> > > +               /delete-property/ ethernet1;
> >
> > OK
> >
> I assume you are OK with dropping the above too?

I did intend to delete these properties (hence the "OK"), as their
presence may confuse U-Boot.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
