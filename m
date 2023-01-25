Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF5767B1AE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 12:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235614AbjAYLlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 06:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjAYLlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 06:41:23 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB948E;
        Wed, 25 Jan 2023 03:41:22 -0800 (PST)
Received: by mail-qt1-f182.google.com with SMTP id j9so15659431qtv.4;
        Wed, 25 Jan 2023 03:41:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N0Lw6g01TroemQ7j6adGGcs3s/PeT68xQ37YefaRRX8=;
        b=JXnwLXomTaDDuCQdyQIXrrD8dfRfQ7x2t4LR2b0W/LF3xGrn1aPfixeiKvM0v8146T
         V/tjqYJn+AATEwZCwg9P/L3hK+Lnh2a9QeKrYP0IOLBhAmsU907yMeaR14EXxHDfcNgr
         GzWLnE+SD7XRM0Gdn0HFsdQG4V3/WEK5v4QdJa7cIT0j9JtG4WS42c90rPmJ4oXfPqTW
         3mocrUN/tJK+OcEgPuv/ItyV+HkPnUsStPAOHmAZX5N5xv7DDkfZeuSwKCsUZ/yzEQET
         65QPtQY6kgF/eQyfl2TewPPRSWHodBQ2Gt+4rgukmMXH/qTgP/81vOg4kPGS32d81Mcm
         vBqw==
X-Gm-Message-State: AFqh2kovHZ19s7aSzi3nZcyWnT9mLMJ3v2XhBQ2EPZaH4MOx5Mh0J0ZN
        b8qvd+W/6OqzfAr5dgWLEj2dNuvKQRUbwQ==
X-Google-Smtp-Source: AMrXdXtJhmmnrEt7JiqVZeSmCadPFrF3/R+BVI+zjTLULL+v2baBDPzd061hEYp7n+8cgeBWCqV1HA==
X-Received: by 2002:ac8:58c3:0:b0:3b6:2c85:6fe8 with SMTP id u3-20020ac858c3000000b003b62c856fe8mr57146161qta.53.1674646881380;
        Wed, 25 Jan 2023 03:41:21 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id l19-20020a05622a175300b0039cc944ebdasm3228914qtk.54.2023.01.25.03.41.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 03:41:20 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id t16so17949516ybk.2;
        Wed, 25 Jan 2023 03:41:20 -0800 (PST)
X-Received: by 2002:a25:37d4:0:b0:80b:8602:f3fe with SMTP id
 e203-20020a2537d4000000b0080b8602f3femr556918yba.36.1674646880330; Wed, 25
 Jan 2023 03:41:20 -0800 (PST)
MIME-Version: 1.0
References: <20230102222708.274369-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230102222708.274369-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 25 Jan 2023 12:41:09 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU5Aj_BNSOOOCTiqi3oLWV7qNv6-pbEo6ytf88DJB8taA@mail.gmail.com>
Message-ID: <CAMuHMdU5Aj_BNSOOOCTiqi3oLWV7qNv6-pbEo6ytf88DJB8taA@mail.gmail.com>
Subject: Re: [PATCH] riscv: dts: renesas: rzfive-smarc-som: Drop PHY interrupt
 support for ETH{0,1}
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
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

On Mon, Jan 2, 2023 at 11:27 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> IRQC support for RZ/Five is still missing so drop the interrupts and
> interrupt-parent properties from the PHY nodes of ETH{0,1}.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> Hi All,
>
> This patch is to avoid build issues due to patch series [0]. This patch
> applies on top of [1]
>
> [0] https://patchwork.kernel.org/project/linux-renesas-soc/cover/20230102221815.273719-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> [1] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20221229230300.104524-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.3.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
