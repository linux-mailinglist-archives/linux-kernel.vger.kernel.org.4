Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CD560CBD5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 14:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbiJYM2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 08:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiJYM2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 08:28:50 -0400
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8A0180ADC;
        Tue, 25 Oct 2022 05:28:49 -0700 (PDT)
Received: by mail-qk1-f182.google.com with SMTP id j21so7857987qkk.9;
        Tue, 25 Oct 2022 05:28:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zk1x69BorUq5EOLXWvjLkthJmpSNSl2Oga4mvV/7nWM=;
        b=CV/5X84xLpBtdrdzbHrJxbXKT0HSho93jBDhdAQngR/0jwUxtxvaMSt7676dfX7K6R
         m6bBgjjRLFcVvomO6O3JUrzpQRDjB6VlLhgl5UnOODgZX60eY9NIU6ZJ4w7oj3n5bqwy
         oARE0GXw4mHul38kK8Hl0QReY8asKLWJEXyDCG7nWJAg1IP8lIqWpft90ASzZe5tZc38
         /LlpoK+6TelflD4jAw458OrNdfV/Iu0s4gezSkT9nvIWWCfHeV1vc2BZP2XMIRAs7ZoN
         eYLnLmaXCCX5q06BLI0Hb35jCmw07B2OqNyH5ieD5tuodrIV/Sr+x9cc/sw+ha55D8IQ
         aJlw==
X-Gm-Message-State: ACrzQf1z2Kq8+JK4cH2CL1w4HaTFYWZr0LbYPiAcUBLj1BSJynGdUOlx
        aq8spmXJ8mgmZK5O0tkOhoP+EQ1W4WZ1wQ==
X-Google-Smtp-Source: AMsMyM6mYXpc4bKLmwIUwPrBFz8/OFbToakjxyQFAQ/8Kgcp6DIFwKS7woc8bwZrwTE8TPIHpHIrKA==
X-Received: by 2002:a05:620a:d96:b0:6ce:bca6:9dd0 with SMTP id q22-20020a05620a0d9600b006cebca69dd0mr26604621qkl.152.1666700927585;
        Tue, 25 Oct 2022 05:28:47 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id g10-20020ac8480a000000b0039cc9d24843sm1526666qtq.66.2022.10.25.05.28.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 05:28:46 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-3321c2a8d4cso111798507b3.5;
        Tue, 25 Oct 2022 05:28:45 -0700 (PDT)
X-Received: by 2002:a81:12c8:0:b0:36a:bd6b:92fb with SMTP id
 191-20020a8112c8000000b0036abd6b92fbmr16103916yws.316.1666700925399; Tue, 25
 Oct 2022 05:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <20221017091201.199457-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20221017091201.199457-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221017091201.199457-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 25 Oct 2022 14:28:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXiim0bDBxaGWi2GjAmKS1gKj8D8TUBPXnZtm0EphKsmQ@mail.gmail.com>
Message-ID: <CAMuHMdXiim0bDBxaGWi2GjAmKS1gKj8D8TUBPXnZtm0EphKsmQ@mail.gmail.com>
Subject: Re: [RFC RESEND PATCH 1/2] arm64: dts: renesas: r9a07g043: Introduce
 SOC_PERIPHERAL_IRQ() macro to specify interrupt property
To:     Prabhakar <prabhakar.csengg@gmail.com>
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
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Mon, Oct 17, 2022 at 11:12 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Introduce SOC_PERIPHERAL_IRQ() macro to specify interrupt property so
> that we can share the common parts of the SoC DTSI with the RZ/Five
> (RISC-V) SoC and the RZ/G2UL (ARM64) SoC.
>
> This patch adds a new file r9a07g043u.dtsi to separate out RZ/G2UL
> (ARM64) SoC specific parts. No functional changes (same DTB).
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +/*
> + * Device Tree Source for the RZ/G2UL SoC
> + *
> + * Copyright (C) 2022 Renesas Electronics Corp.
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +#define SOC_PERIPHERAL_IRQ(nr, na)     GIC_SPI nr na

s/na/flags/

Originally, when I assumed incorrectly that dtc does not support
arithmetic, I used "nr" and "na" in the macro I proposed to mean RISC-V
("r") resp. ARM ("a") interrupt number.  Apparently the names stuck,
although the second parameter now has a completely different meaning ;-)

However, as the NCEPLIC does support interrupt flags, unlike the SiFive
PLIC, there is no need to have the flags parameter in the macro.

> +
> +#include "r9a07g043.dtsi"

The rest LGTM.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
