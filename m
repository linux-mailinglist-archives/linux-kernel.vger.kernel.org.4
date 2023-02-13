Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7156B6947CE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 15:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjBMORN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 09:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjBMORI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 09:17:08 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0F81ABED;
        Mon, 13 Feb 2023 06:17:06 -0800 (PST)
Received: by mail-qt1-f178.google.com with SMTP id 5so13786387qtp.9;
        Mon, 13 Feb 2023 06:17:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uWwIFJOtD/5nTjh0xdxTUtOn5+bh8hMlg/S9rD8p40Y=;
        b=GqFmNpGMVlXiZ12NugNw77nW+bGBdnJZN8f5dgOuXIMw4eh5DWZReHlDaDWGqbh6gj
         dtW6flmI5ZDVfxhMMnPDSnrMsy94r5LR9J7nPSB/1TG9dRIdjRemk5N4PAxpeiCgisLt
         knAMdSgbz7qQueA+PA+65a4wGDOd7kVPIfheMnnwBlLNHe+oWHS5MTECesqrk06pf/50
         9nbUapCBCVuK2TbMRjGwPZ1t0zHFOUVlB9VSnk7G0AD4bD6gwqZiq1wChoZF8dnCzVjZ
         gq8Ck7oUZw7Uqcjzjtl9VuNyv7UlLsTlpr/TE+VheGTIia9mi1AosZecJ8jgioorVQkQ
         NjKg==
X-Gm-Message-State: AO0yUKVbv0VV8ts9qQUDagXu5RQIOGUTeQe8HpBH5Cr0wMAmLqe6cF5r
        yeIwimTvwB0ZHfTqJcDFzO3dz4jCFrPi5Q==
X-Google-Smtp-Source: AK7set+0Wur+fN9OUhja8QhnMw0F3uyMXb6bDHBpvIQw0y6V3Ox6+BgYRfvVnOH690nTpA3TWROeug==
X-Received: by 2002:ac8:5a87:0:b0:3ab:a3d9:c5c8 with SMTP id c7-20020ac85a87000000b003aba3d9c5c8mr44963626qtc.3.1676297824926;
        Mon, 13 Feb 2023 06:17:04 -0800 (PST)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id t22-20020a05622a149600b003b323387c1asm9500960qtx.18.2023.02.13.06.17.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 06:17:04 -0800 (PST)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-51ba4b1b9feso164393677b3.11;
        Mon, 13 Feb 2023 06:17:04 -0800 (PST)
X-Received: by 2002:a0d:e2c6:0:b0:52f:972:e6a1 with SMTP id
 l189-20020a0de2c6000000b0052f0972e6a1mr718671ywe.235.1676297823894; Mon, 13
 Feb 2023 06:17:03 -0800 (PST)
MIME-Version: 1.0
References: <20230131223529.11905-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230131223529.11905-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 13 Feb 2023 15:16:52 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX3OHuq15m=g56faaU6EySYeKmRvbmJdty1xZ6JOu-yzg@mail.gmail.com>
Message-ID: <CAMuHMdX3OHuq15m=g56faaU6EySYeKmRvbmJdty1xZ6JOu-yzg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Share RZ/G2L SoC DTSI with RZ/V2L SoC
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob, Krzysztof,

On Tue, Jan 31, 2023 at 11:42 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> This series aims to reuse RZ/G2L SoC DTSI with RZ/V2L as both the SoCs are
> almost identical.
>
> v1 -> v2
> * Patch 1/2 unchanged, for patch 2/2 sorted the nodes based on the names.
>
> v1: https://patchwork.kernel.org/project/linux-renesas-soc/cover/20230127133909.144774-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
>
> Cheers,
> Prabhakar
>
> Lad Prabhakar (2):
>   arm64: dts: renesas: r9a07g044: Use SoC specific macro for CPG and
>     RESET
>   arm64: dts: renesas: r9a07g054: Reuse RZ/G2L SoC DTSI
>
>  arch/arm64/boot/dts/renesas/r9a07g044.dtsi |  254 ++---
>  arch/arm64/boot/dts/renesas/r9a07g054.dtsi | 1149 +++-----------------
>  2 files changed, 256 insertions(+), 1147 deletions(-)

Do you have an opinion on this series?
Is this acceptable for you?
The final generated DTBs are identical to before.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
