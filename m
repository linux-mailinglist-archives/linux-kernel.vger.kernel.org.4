Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C488E67718E
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 19:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjAVScf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 13:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjAVScd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 13:32:33 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B741BAC3;
        Sun, 22 Jan 2023 10:32:33 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id b1so7120462ybn.11;
        Sun, 22 Jan 2023 10:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jFqf1bPadYagtCEH5xHccY/TN2b4Q4DsXKb1D0SyqPM=;
        b=AF3tLNYFJUKlLedYe0WvVYfxagzBTQ/RlwQQDyC8WcFuY1K9MY5cEdy+k+oqjGAM6O
         tHr+Rv/h+LcjTeNyPMtuVm26WYtnYbZ4OCeQWpQWitfSJTguXsN1tp4t6lZfGqy2MdAr
         i0L2h9nYle77peZRiWvsWvh5HJHNrUeXxZzoggw2b5KyVz84G2JtcHY+uAMzkKRDn7TZ
         CjIsxrOCujH9ktegykViXDRginS9auDXM+8f9TUrkccQh91fGGDD8rjIPu/yNZ5SDepr
         iiw4qyJEL0Q28bX2IT5BX3XZNsc4DkNelMK7aWlJcN5XHyI/V6sC2BrJ0iXD9ViZt6ap
         cVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jFqf1bPadYagtCEH5xHccY/TN2b4Q4DsXKb1D0SyqPM=;
        b=UhJ12M2M4aqPASrY1Vh0QHDX9FDpO2zzoFEEcGjYiN0MPoT8qrhAKOkneOEw7Ujptg
         80BE3/n+f7WK4bszbkdEOPFdxBEqeW33Um4WAYPJG1upNFyIytF/1UH3ku0WogmPr4ep
         EP/Q4g/+OTDTfkQPWt5yePuwpMRdLuG3drmf/Pbg7gsTdplc1xT0klxGBZpT5WYLphr8
         QSGNT3J/wUyLL2bVL9TmZIlyMBHiV2G2ac1luknW+qJl3uugkdEbXdjGmUNAkmkV7ZKv
         bI7G5G1VVAwR6I4+PO+EY+Q7asLhgFH+HjNG2QUNA4Pt/uMkUI409i3YIKkrFPi7oHCV
         RNHg==
X-Gm-Message-State: AFqh2kpXEao816YCwHffkX2PW8iQvw6JBspXxw/5sJv41I7pUCWiiZwn
        GljDWADGUfph2f1oWEMhL7rn4xg1Ac/CNIjpzrQ=
X-Google-Smtp-Source: AMrXdXsQrJ3i8eIYwEJvIqY4SUF5+zXHNCEjle7c+mtLGomXzeiV/zWZG1lMnuq5i7GrLlpKwAwOuWY3+BsZneiidW8=
X-Received: by 2002:a25:f305:0:b0:7b8:6d00:ef23 with SMTP id
 c5-20020a25f305000000b007b86d00ef23mr2579319ybs.119.1674412352283; Sun, 22
 Jan 2023 10:32:32 -0800 (PST)
MIME-Version: 1.0
References: <20230102221815.273719-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230102221815.273719-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Sun, 22 Jan 2023 18:32:06 +0000
Message-ID: <CA+V-a8s-arEYz9j7Dg4Lcn32aGtsAaW7va75m1q6jQhT03Tm_g@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Add IRQC support to RZ/G2UL SoC
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-gpio@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
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

On Mon, Jan 2, 2023 at 10:18 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
>
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Hi All,
>
> This patch series does the following:
> * Adds IRQC support to the RZ/G2UL SoC.
> * Drops mapping NMI interrupt as part of IRQ domain
> * Parses interrupts based in interrupt-names
> * Includes a fix for pinctrl driver when using GPIO pins as interrupts
> * Adds PHY interrupt support for ETH{0/1}
>
> v2->v3
> * Dropped skipping of NMI interrupt, as it can be used as an external
>   interrupt.
> * Dropped parsing interrupts based on names
> * Dropped "renesas,rzg2ul-irqc" compatible string
>
> v1->v2
> * Updated binding doc
> * Dropped mapping NMI interrupt as part of IRQ domain
> * Fixed review comments pointed by Geert
> * Added support to parse interrupts by name
> * Added compile time checks for gpio config arrays
>
> RFC v1: https://patchwork.kernel.org/project/linux-renesas-soc/cover/20221107175305.63975-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
>
> Cheers,
> Prabhakar
>
> Lad Prabhakar (6):
>   dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document
>     RZ/G2UL SoC
>   pinctrl: renesas: rzg2l: Fix configuring the GPIO pins as interrupts
>   pinctrl: renesas: rzg2l: Add BUILD_BUG_ON() checks
>   arm64: dts: renesas: r9a07g043u: Add IRQC node
>   arm64: dts: renesas: r9a07g043[u]: Update pinctrl node to handle GPIO
>     interrupts
>   arm64: dts: renesas: rzg2ul-smarc-som: Add PHY interrupt support for
>     ETH{0/1}
>
Gentle ping.

Cheers,
Prabhakar

>  .../renesas,rzg2l-irqc.yaml                   | 225 +++++++++++++-----
>  arch/arm64/boot/dts/renesas/r9a07g043.dtsi    |   2 +
>  arch/arm64/boot/dts/renesas/r9a07g043u.dtsi   |  72 ++++++
>  .../boot/dts/renesas/rzg2ul-smarc-som.dtsi    |  11 +-
>  drivers/pinctrl/renesas/pinctrl-rzg2l.c       |  25 +-
>  5 files changed, 270 insertions(+), 65 deletions(-)
>
> --
> 2.25.1
>
