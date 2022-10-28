Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512666111D2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 14:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiJ1MqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 08:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJ1MqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 08:46:21 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C8C1CEC07;
        Fri, 28 Oct 2022 05:46:20 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id g16so3361165qtu.2;
        Fri, 28 Oct 2022 05:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4PLs2L+UHYQFSiNXWVRX1eTlixniK4rGG++88ZUzDFM=;
        b=iDGyrBv6XU4b7i74SyvWcF583rlj3OchhpTUjhWlcHmIhB5exC/nXRhraB1ukSN7BM
         ROfknZZ4nLhoEvWIEcZstQ4I/tLLKGB/pK86hdKaSUQb7mbXOYQJV39qjlvHiSTL4x5w
         vBzdkKQO6qz8+6oIbtUr2yMCQ5cCpQMlrlex6gpVmXO0LI8yJieDr6sQlP/7wIdnuQOu
         p37fMeSKwFIo1SNnAuAR6AttHusvC1PHjZjYMRex8h6Ot3bSoBXrPxP1I0eYvwNbAePX
         1NSji0Q//oCVa6aYzlQVUTkNdYv+XTg8QIT9JFgPZYhR54X24tW03zgjtjKubvKKtInf
         mvlQ==
X-Gm-Message-State: ACrzQf2/j8KJ2Ub7seo0yBTySiT+UXLBAfbQ5YvgLspjHcXdQKoj4zV2
        aso/+mrdPNDxk7dwO8zENJNCdY0Qq1NDSA==
X-Google-Smtp-Source: AMsMyM7umw66oHKnWvFfDUrs+bpvdvF5NQCo7lwMTmEBqPCPXyn0qvQRIqDF8tubCjezPUhMQs+MOQ==
X-Received: by 2002:ac8:4e44:0:b0:399:efde:98c5 with SMTP id e4-20020ac84e44000000b00399efde98c5mr45464321qtw.640.1666961179564;
        Fri, 28 Oct 2022 05:46:19 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id h24-20020ac846d8000000b0039cc22a2c49sm2293682qto.47.2022.10.28.05.46.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 05:46:18 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id t186so5963064yba.12;
        Fri, 28 Oct 2022 05:46:18 -0700 (PDT)
X-Received: by 2002:a25:cd01:0:b0:6c2:6f0d:f4ce with SMTP id
 d1-20020a25cd01000000b006c26f0df4cemr46239035ybf.365.1666961178681; Fri, 28
 Oct 2022 05:46:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220920184904.90495-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220920184904.90495-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220920184904.90495-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 28 Oct 2022 14:46:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWNq2J40jiC-TkEA23hVWsWTk483KXuDO9-bMe3CiGRcw@mail.gmail.com>
Message-ID: <CAMuHMdWNq2J40jiC-TkEA23hVWsWTk483KXuDO9-bMe3CiGRcw@mail.gmail.com>
Subject: Re: [PATCH v4 04/10] dt-bindings: soc: renesas: renesas.yaml:
 Document Renesas RZ/Five SoC
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Atish Patra <atishp@rivosinc.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

On Tue, Sep 20, 2022 at 8:50 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Document Renesas RZ/Five (R9A07G043) SoC.
>
> More info about RZ/Five SoC:
> https://www.renesas.com/us/en/products/microcontrollers-microprocessors/rz-mpus/rzfive-risc-v-general-purpose-microprocessors-risc-v-cpu-core-andes-ax45mp-single-10-ghz-2ch-gigabit-ethernet
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v3 -> v4
> * No change

Will queue in renesas-devel for v6.2.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
