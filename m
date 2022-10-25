Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C7860CBFE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 14:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbiJYMhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 08:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbiJYMhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 08:37:25 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6244B188A8F;
        Tue, 25 Oct 2022 05:37:22 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id w29so263639qtv.9;
        Tue, 25 Oct 2022 05:37:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DEjQC8UwPSpJbdU9AEdKNSZFHoUYuJmVXV6mmwXFmnE=;
        b=kPoaRQDk7c03OxLLlwxc/8TvgirLoU8gjI0HHW2VjngQ3RG+390WQ4sqxfBZlmM1Ct
         R9wle9KvdhO4NfemC2o9Ec0DEX3rWoVPZmM4JZoWl1oC63Kgalkn5uopv7vXQzca8XR4
         nOLjNv4S5H0oEi3uflSndg9wet7UF0CrBx+zUIAmckCRO35KE3aCCbuk/ZhjOpt442uE
         F2SzG6fffYfzeztkET3uTivkslDy061lir5Z5Gza/Hp305tpDn63BnFcEDgSsqMub9zB
         0L4jzT/tk0NCivB48vSC0ZvczO99X1TDDJRJH6DJU7f8p29cd3ASqq8CbF6wX+Qb8mCV
         yNqw==
X-Gm-Message-State: ACrzQf14jH4zgyRTdjFTDGHBapHMfQNL1tBhgVUiehq3BRyNeLae0toV
        n5cEuIgObrDOCSSyhBr1FuP0cVXcgWeW0Q==
X-Google-Smtp-Source: AMsMyM6fy6Pk9aSnxvpfj4ewVzTeuNY4HOgACqJEkX2PwEBilrcbv7P5dWvPqGTVm2je/ZXnL4P5mA==
X-Received: by 2002:a05:622a:49:b0:39c:e83e:8839 with SMTP id y9-20020a05622a004900b0039ce83e8839mr30682325qtw.424.1666701441266;
        Tue, 25 Oct 2022 05:37:21 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id g3-20020ac87d03000000b00342f8984348sm1570874qtb.87.2022.10.25.05.37.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 05:37:19 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-369426664f9so111664067b3.12;
        Tue, 25 Oct 2022 05:37:19 -0700 (PDT)
X-Received: by 2002:a0d:de43:0:b0:349:31bd:e8d5 with SMTP id
 h64-20020a0dde43000000b0034931bde8d5mr32925900ywe.283.1666701438736; Tue, 25
 Oct 2022 05:37:18 -0700 (PDT)
MIME-Version: 1.0
References: <20221017091201.199457-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20221017091201.199457-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221017091201.199457-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 25 Oct 2022 14:37:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXuiCne2NvCzu8x9LeM_W8rxwLX-0w=kHnGa30bdzFaDQ@mail.gmail.com>
Message-ID: <CAMuHMdXuiCne2NvCzu8x9LeM_W8rxwLX-0w=kHnGa30bdzFaDQ@mail.gmail.com>
Subject: Re: [RFC RESEND PATCH 2/2] arm64: dts: renesas: r9a07g043: Split out
 RZ/G2UL SoC specific parts
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Mon, Oct 17, 2022 at 11:12 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Move RZ/G2UL SoC specific parts to r9a07g043u.dtsi so that r9a07g043.dtsi
> can be shared with RZ/Five (RISC-V SoC).
>
> Below are the changes due to which SoC specific parts are moved to
> r9a07g043u.dtsi:
> - RZ/G2UL has Cortex-A55 (ARM64) whereas the RZ/Five has AX45MP (RISC-V)
> - RZ/G2UL has GICv3 as interrupt controller whereas the RZ/Five has PLIC
> - RZ/G2UL has interrupts for SYSC block whereas interrupts are missing
>   for SYSC block on RZ/Five
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

This assumes the operating points tables are the same for both variants?
I guess that's OK.

Overall, LGTM.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
