Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBEEB6388B4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 12:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiKYLYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 06:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiKYLY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 06:24:29 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1A31BEA9;
        Fri, 25 Nov 2022 03:24:27 -0800 (PST)
Received: by mail-qt1-f176.google.com with SMTP id cg5so2335280qtb.12;
        Fri, 25 Nov 2022 03:24:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Zo8eiAW4zN+rDEorAgGhPKfwHubATfFtXeTA+vPKZw=;
        b=Jfo5/yLvXWXEpU5RoKTZ1ivfTPiaZqBuMjPCSp9rbV4uMq2Ttl8m1mIZddp6I8KQdU
         ZPe5BblFnT/BjrB7gbQQKqDVcmZMlbKG57GMuX9FiR0WPX7Z5naetoDoUtPSLL+/nAYK
         G6t/jxGHnOx1j94aiJdFPq37id97phUqnkREoKYPCAhTHw3scFgTaVQqgQagidlW8TTn
         2axKAy0cd7xI4SmPnLRCBUczih/1w/Fx7oTda1hPLoN95b6AZc0xckKDkdXXsMZlj+vk
         VqiCHqvG6+9ekdOe8LYdM9tq2yy+pgSKrq9SADs1tcEuctVccyfbULRXg0Anel6Ey3w2
         XbMA==
X-Gm-Message-State: ANoB5pmzoJNqUR9lQa2+vqOSEE6XG9TCGdcqdxJpwWSev8pKhSZjScYG
        zDeavqrol0mOmqSclxe8Z17ktRN0p17onA==
X-Google-Smtp-Source: AA0mqf4o4uz3twaftR8+CnMdAWQWKFF68zARNoUs3AzIf4vqCNMMEz9YxS3tsGN4yBqLH1rIudDyfA==
X-Received: by 2002:ac8:528f:0:b0:38a:9db4:8006 with SMTP id s15-20020ac8528f000000b0038a9db48006mr16442615qtn.166.1669375466668;
        Fri, 25 Nov 2022 03:24:26 -0800 (PST)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id k8-20020ac84748000000b003a569a0afcasm2035904qtp.66.2022.11.25.03.24.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 03:24:26 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id z192so4780948yba.0;
        Fri, 25 Nov 2022 03:24:26 -0800 (PST)
X-Received: by 2002:a25:2343:0:b0:6f3:c535:4e9c with SMTP id
 j64-20020a252343000000b006f3c5354e9cmr86466ybj.380.1669375077609; Fri, 25 Nov
 2022 03:17:57 -0800 (PST)
MIME-Version: 1.0
References: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221124172207.153718-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <70d1bfde-f57f-1741-08d3-23e362793595@linaro.org> <CA+V-a8s2awLp=YvbhA1Ohe500Oh1easLUcG9V4_FWov7Pf2i6g@mail.gmail.com>
In-Reply-To: <CA+V-a8s2awLp=YvbhA1Ohe500Oh1easLUcG9V4_FWov7Pf2i6g@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 25 Nov 2022 12:17:45 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXktJWskc8m-hL75gfkkkZnqsiuraAG+wPjWcs2JZpGKA@mail.gmail.com>
Message-ID: <CAMuHMdXktJWskc8m-hL75gfkkkZnqsiuraAG+wPjWcs2JZpGKA@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] dt-bindings: cache: r9a07g043f-l2-cache: Add DT
 binding documentation for L2 cache controller
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
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

, Hi Prabhakar,

On Fri, Nov 25, 2022 at 11:34 AM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Fri, Nov 25, 2022 at 8:16 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> > On 24/11/2022 18:22, Prabhakar wrote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Add DT binding documentation for L2 cache controller found on RZ/Five SoC.
> > >
> > > The Renesas RZ/Five microprocessor includes a RISC-V CPU Core (AX45MP
> > > Single) from Andes. The AX45MP core has an L2 cache controller, this patch
> > > describes the L2 cache block.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > ---
> > > RFC v3 -> v4
> > > * Dropped l2 cache configuration parameters
> > > * s/larger/large
> > > * Added minItems/maxItems for andestech,pma-regions

> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml

> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/interrupt-controller/irq.h>
> > > +    #include <dt-bindings/cache/andestech,ax45mp-cache.h>
> > > +
> > > +    cache-controller@2010000 {
> > > +        reg = <0x13400000 0x100000>;
> > > +        compatible = "andestech,ax45mp-cache", "cache";
> > > +        interrupts = <508 IRQ_TYPE_LEVEL_HIGH>;
> > > +        cache-line-size = <64>;
> > > +        cache-level = <2>;
> > > +        cache-sets = <1024>;
> > > +        cache-size = <262144>;
> > > +        cache-unified;
> > > +        andestech,pma-regions = <0x58000000 0x08000000
> > > +                                 (AX45MP_PMACFG_ETYP_NAPOT | AX45MP_PMACFG_MTYP_MEM_NON_CACHE_BUF)>;
> > > +    };
> > > diff --git a/include/dt-bindings/cache/andestech,ax45mp-cache.h b/include/dt-bindings/cache/andestech,ax45mp-cache.h
> > > new file mode 100644
> > > index 000000000000..aa1cad24075d
> > > --- /dev/null
> > > +++ b/include/dt-bindings/cache/andestech,ax45mp-cache.h
> > > @@ -0,0 +1,38 @@
> > > +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> > > +/*
> > > + * This header provides constants for Andes AX45MP PMA configuration
> > > + *
> > > + * Copyright (C) 2022 Renesas Electronics Corp.
> > > + */
> > > +
> > > +#ifndef __DT_BINDINGS_ANDESTECH_AX45MP_CACHE_H
> > > +#define __DT_BINDINGS_ANDESTECH_AX45MP_CACHE_H
> > > +
> > > +/* OFF: PMA entry is disabled */
> > > +#define AX45MP_PMACFG_ETYP_DISABLED                  0
> > > +/* Naturally aligned power of 2 region */
> > > +#define AX45MP_PMACFG_ETYP_NAPOT                     3
> > > +
> > > +/* Device, Non-bufferable */
> > > +#define AX45MP_PMACFG_MTYP_DEV_NON_BUF                       (0 << 2)
> > > +/* Device, bufferable */
> > > +#define AX45MP_PMACFG_MTYP_DEV_BUF                   (1 << 2)
> > > +/* Memory, Non-cacheable, Non-bufferable */
> > > +#define AX45MP_PMACFG_MTYP_MEM_NON_CACHE_NON_BUF     (2 << 2)
> > > +/* Memory, Non-cacheable, Bufferable */
> > > +#define AX45MP_PMACFG_MTYP_MEM_NON_CACHE_BUF         (3 << 2)
> >
> > What are all these? They don't look like flags, because 3 = 1 | 2...
> > they don't look like constants, because we do not use shifts in
> > constants. Are these some register values? I also do not see the header
> > being used in the code, so why having a bindings header if it is not
> > used (DTS is not usage...)?
> >
> These are register bit values for the MTYP[5:2] field. The DTS example
> in the binding doc (above) uses these macros. I haven't included the
> DTS/I patches with this patchset yet do think I should?

I think the main objection from Rob is that these look too much like
raw register values to be written unchanged to registers, which is
frowned upon in DT.

Now, can we make this more generic?

  1. Do you need AX45MP_PMACFG_ETYP_DISABLED, i.e. will it ever be
     specified in DTS, or is this a pure software thing?
  2. Obviously you can let the driver decide if AX45MP_PMACFG_ETYP_NAPOT
     can be set, based on address/size?
  3. If the two above are removed, the shifts can be handled in the
     driver instead,
  4. Are there existing (more generic) definitions that can be used
     instead?

BTW, what's the difference between non-bufferable and non-cacheable?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
