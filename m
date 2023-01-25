Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E3B67B122
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 12:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235274AbjAYLZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 06:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjAYLZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 06:25:15 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20979EF1;
        Wed, 25 Jan 2023 03:25:14 -0800 (PST)
Received: by mail-qt1-f179.google.com with SMTP id x5so15624948qti.3;
        Wed, 25 Jan 2023 03:25:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AMUD0RKspnOJT0fL1Ughd3ZRCNw/KqSlhNrqgOj0lHg=;
        b=u6ZT0e+1/3oYmTRUWqhz2FjvpbYc87aAE2GBMPb22wHIR6W++vddHKcbq4s+Lb/NbR
         ev5UhtTr/7LGJDsmnLkTye/au7Yg9f7WZTzcxKVQKrZGtqFKWI5RbaPTGR1kK9xUpdf9
         z8xIxfdwsRQKLiO5yA8crp/zrl92i/j2GnSB8Fxr1P+ByV0j7slqEO3AKR62cBhdRwvE
         DkP0MZZddyP6F7diW4nBlDETcm3t1EUVpMPiX2/kOgi35kVBtVQAg4ca0I4aA0NnBgG8
         dsi3rMx6nfneJQykpfjp4aMEObuYlqVwFOCgPEzyF7QgXIPU2/rO5UuiAuXmpeTh4mj0
         /8nA==
X-Gm-Message-State: AO0yUKWLJ86anFgW1HCilUl4U3D+cKQa1e/UZBVXBSR/ET/mhH2FD8vG
        BMkl2PV7q/0McwnyDa2NCtdyrVwYWn4now==
X-Google-Smtp-Source: AK7set+ird2aTpgnhCMgOGUFJU1IP09u9ikqz4oHzonZWhjSzHy3YEwik2PH+Vd6yRPh1qtKKJUevg==
X-Received: by 2002:a05:622a:8c:b0:3b6:9418:ad6f with SMTP id o12-20020a05622a008c00b003b69418ad6fmr2622996qtw.67.1674645913616;
        Wed, 25 Jan 2023 03:25:13 -0800 (PST)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id dx14-20020a05620a608e00b006b95b0a714esm3343988qkb.17.2023.01.25.03.25.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 03:25:13 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id d132so1033129ybb.5;
        Wed, 25 Jan 2023 03:25:13 -0800 (PST)
X-Received: by 2002:a25:9ac1:0:b0:7b4:6a33:d89f with SMTP id
 t1-20020a259ac1000000b007b46a33d89fmr2482812ybo.543.1674645912722; Wed, 25
 Jan 2023 03:25:12 -0800 (PST)
MIME-Version: 1.0
References: <20230102221815.273719-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20230102221815.273719-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230102221815.273719-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 25 Jan 2023 12:25:01 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVTUiPpUgmyqx_UMPDWCCcWApsduJtXUE9ZNY0iOmxXjw@mail.gmail.com>
Message-ID: <CAMuHMdVTUiPpUgmyqx_UMPDWCCcWApsduJtXUE9ZNY0iOmxXjw@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: interrupt-controller:
 renesas,rzg2l-irqc: Document RZ/G2UL SoC
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 2, 2023 at 11:19 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Document RZ/G2UL (R9A07G043U) IRQC bindings. The IRQC block on RZ/G2UL SoC
> is almost identical to one found on the RZ/G2L SoC the only difference
> being it can support BUS_ERR_INT for which it has additional registers.
> Hence new generic compatible string "renesas,r9a07g043u-irqc" is added
> for RZ/G2UL SoC.
>
> Now that we have additional interrupt for RZ/G2UL and RZ/Five SoC
> interrupt-names property is added so that we can parse them based on
> names.
>
> While at it updated the example node to four spaces and added
> interrupt-names property.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v2->v3
> * Dropped RZ/G2UL specific string

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
