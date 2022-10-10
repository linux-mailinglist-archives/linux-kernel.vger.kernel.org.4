Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF145F9C24
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 11:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbiJJJmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 05:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiJJJmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 05:42:04 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670EB647E0;
        Mon, 10 Oct 2022 02:42:03 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id z3so14123634edc.10;
        Mon, 10 Oct 2022 02:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6+VUqgiuTjQeU7l/kUlUaXroa9OGkZIBVKyyM//tCkE=;
        b=cOlIQVEPtsG0/kS92o9AAxQRvGADlegSQ8wMhpusAZLn/yq6ZeAZvk5NUIH98Cm1dc
         ez1l5+ixbepOhoYD2hHYoRkHY7OX/oJeFwwOuHCfk+syJUKWrmzQXPD4KZS3Sb6Ahzz8
         nmMyQSsdd1hZ0tEOESMtoa5/UXcLtlujg82xYx9mVSx6OzQ99H3pY8O1LdRi76ud3DCq
         r6WudUjHXXTMmrFcFFeC+Tav2r8dai0EEdNia0uLalEgz9NoOLQjGEKZYnkk2Jh3VP5x
         hcTrlnRq4vM27T38cOqY/5vy82whi3VQxHfQSYjTVk5oh6pIhZGd3xkVUYVMlmZgU+g4
         CSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6+VUqgiuTjQeU7l/kUlUaXroa9OGkZIBVKyyM//tCkE=;
        b=P2hJU7hUk1lLJuQIWGjdJXNj9tk3qe+Q0v93GTHwvHoSvum9dddxhnzKTTIiR1WycW
         /UluroLS8cGDjam+4eTYn/BrNdk0ytDt95zxghxQpXCYrY8K+BGTTYTvQ1wrV6Dd8Y1O
         s3DkLRtmMHIw6004GXb44CkiFTveMwh5rXJ+IwOaZ7MC9JgHrkyJ0xYJy3PQ60Dn9J5S
         JjRCB31gkmC9twUMuazy2wdznEKG2YSa9VpWHlIojEgzkkLvLCUjbzrZ+pzOlEoy+eGR
         2UUyAmTVEfr6/JLIwFJFI97AMXGYZdLd7rWc1cXfBaYToFIY0h27H1+EaQYCRr70M3O4
         OfCA==
X-Gm-Message-State: ACrzQf3t6xE0VyOJkzLDrBB0XSnjSWwV6ICTCarnSCnNh7E3eFGnbl2t
        GqwsDTCkIhXFWA/B9AZd9Vvpb9vkVngwaWtUT2I=
X-Google-Smtp-Source: AMsMyM5uf3VBi7wDQS52pr75/TL9qL/dFM8EyIsrXPwepN7iHNubY9D8z0yViEy8YHNOHkmbJ1lJGMTwWDU1EbB6m/Q=
X-Received: by 2002:a05:6402:40c6:b0:459:6749:9e1f with SMTP id
 z6-20020a05640240c600b0045967499e1fmr17085133edb.319.1665394921761; Mon, 10
 Oct 2022 02:42:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220929172356.301342-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220929172356.301342-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 10 Oct 2022 10:41:35 +0100
Message-ID: <CA+V-a8vD1+kbby8rbZqYv2Ux1GaT=7n7V9qHJS3Djv-fKdWrAQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] RZ/G2UL separate out SoC specific parts
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        DT <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
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

Hi Rob, Krzysztof,

On Thu, Sep 29, 2022 at 6:24 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
>
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Hi All,
>
> This patch series aims to split up the RZ/G2UL SoC DTSI into common parts
> so that this can be shared with the RZ/Five SoC.
>
> Implementation is based on the discussion [0] where I have used option#2.
>
> The Renesas RZ/G2UL (ARM64) and RZ/Five (RISC-V) have almost the same
> identical blocks to avoid duplication a base SoC dtsi (r9a07g043.dtsi) is
> created which will be used by the RZ/G2UL (r9a07g043u.dtsi) and RZ/Five
> (r9a07g043F.dtsi)
>
> Sending this as an RFC to get some feedback.
>
> r9a07g043f.dtsi will look something like below:
>
> #include <dt-bindings/interrupt-controller/irq.h>
>
> #define SOC_PERIPHERAL_IRQ_NUMBER(nr)   (nr + 32)
> #define SOC_PERIPHERAL_IRQ(nr, na)      SOC_PERIPHERAL_IRQ_NUMBER(nr) na
>
> #include <arm64/renesas/r9a07g043.dtsi>
>
> / {
>    ...
>    ...
> };
>
> Although patch#2 can be merged into patch#1 just wanted to keep them separated
> for easier review.
>
> [0] https://lore.kernel.org/linux-arm-kernel/Yyt8s5+pyoysVNeC@spud/T/
>
> Cheers,
> Prabhakar
>
> Lad Prabhakar (2):
>   arm64: dts: renesas: r9a07g043: Introduce SOC_PERIPHERAL_IRQ() macro
>     to specify interrupt property

Can either of you please review patch #1.

Cheers,
Prabhakar

>   arm64: dts: renesas: r9a07g043: Split out RZ/G2UL SoC specific parts
>
>  arch/arm64/boot/dts/renesas/r9a07g043.dtsi    | 362 +++++++-----------
>  arch/arm64/boot/dts/renesas/r9a07g043u.dtsi   |  87 +++++
>  .../boot/dts/renesas/r9a07g043u11-smarc.dts   |   2 +-
>  3 files changed, 235 insertions(+), 216 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
>
> --
> 2.25.1
>
