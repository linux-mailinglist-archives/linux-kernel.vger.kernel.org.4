Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B2072FFA3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 15:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244892AbjFNNML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 09:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244887AbjFNNMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:12:09 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3D31FDC;
        Wed, 14 Jun 2023 06:12:07 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b1b084620dso9698381fa.0;
        Wed, 14 Jun 2023 06:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686748326; x=1689340326;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2ofFz6j0w1h52wpwFHzKwpwQnJKOAaqIFRmzp53L4L8=;
        b=nrRBhAta/xwv1niX9VIZhYN63cL5NN9DYVwSE1FgTIlOBaFVwSts8NK9fC/ADtlMVf
         6U/is5TcDC2vvDEvPUfrOLg66fQ5esfPvVEUQuH1WGQ4CAhPy9+vB503OjbaORknSKQ3
         Kv7Bm3zIQGsAEcAK/mLoDiQjp26wbGAuSQ2hTpCZlADzwb452zKBa0V/vZe0iElHU/+d
         hbIIFFE190iU8xPWWDbW2fn2dAxLjYBZ2tDFMhKzy18WdWOCgP/S1hueuSRiq7bYKoBO
         bFCnBbqT4Bm6GAOVxUoVqsjH9cCMkmTi/b88bWlt6VUoJ06fLM8pOYvbwUBMbuR1v8F8
         ZEcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686748326; x=1689340326;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ofFz6j0w1h52wpwFHzKwpwQnJKOAaqIFRmzp53L4L8=;
        b=iK6Bp+zISTLtvVX2FXNKqkLGp3KIYO1vNNhJ/ZGnf1Bzt0+kEx4YU8rnmewPaOGaC+
         YCDKGEIc+0/ujgUvmE9nLUhW5wM3VOVHczfm+fq1+OcIXxhsAk19aiFl1YP8puJQuYYl
         1bDDuic1n3ufyxQVvyjGPq2dl5t94jPA0VsOzh2zmvko9eGlckX2FbXCn2cj4rbsktKY
         Hzw3/cWf4fs1RWeWyeN9cnsqKUM1EBVKEAzzQkVL9NK7yIx9xX3+PGl2UA6FIutVIcsw
         kd5GGaebrkKph5SZ3u1rqodeMPaM+lhtH0vcMQxyDGOakOCD1P5SM4VibloxJRtFGrdV
         CCPg==
X-Gm-Message-State: AC+VfDwgxXaujxrKNfsksqkdTh7DTBktsgmSRLKZ+P5iFxrBh1NvrGSa
        FcW2mQJTgnLS5PkhMxwG/rVumoQX4ELzSjUJ6eg=
X-Google-Smtp-Source: ACHHUZ7c+VGmZ+oRHR/ijyH1xqCTCaIUHofWncciBJXX8uB+xgDzPBRa0TtTYkeL6xthuNrMwiHEJfQRgmjQbtmSDVQ=
X-Received: by 2002:a2e:961a:0:b0:2b1:e807:f0f with SMTP id
 v26-20020a2e961a000000b002b1e8070f0fmr6346627ljh.28.1686748325287; Wed, 14
 Jun 2023 06:12:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230614130952.253349-1-tmaimon77@gmail.com>
In-Reply-To: <20230614130952.253349-1-tmaimon77@gmail.com>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Wed, 14 Jun 2023 16:11:54 +0300
Message-ID: <CAP6Zq1gQV2wnFvEVmo3SZrgW6t77JmZjUgGMSqRZZjhGDy0kOA@mail.gmail.com>
Subject: Re: [PATCH v16 0/1] Introduce Nuvoton Arbel NPCM8XX BMC SoC
To:     mturquette@baylibre.com, sboyd@kernel.org, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com
Cc:     openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, please ignore this mail.

On Wed, 14 Jun 2023 at 16:10, Tomer Maimon <tmaimon77@gmail.com> wrote:
>
> This patchset adds clock support for the Nuvoton
> Arbel NPCM8XX Board Management controller (BMC) SoC family.
>
> This patchset cover letter is based from the initial support for NPCM8xx BMC to
> keep tracking the version history.
>
> all the other initial support patches had been applied to Linux kernel 6.0.
>
> This patchset was tested on the Arbel NPCM8XX evaluation board.
>
> Addressed comments from:
>
>  - Stephen Boyd: https://www.spinics.net/lists/kernel/msg4729384.html
>
> Changes since version 15:
>  - NPCM8XX clock driver
>         - Remove unused regs parameter from npcm8xx_pll_data structure.
>         - Using index and clk_hw parameters to set the clock parent in the clock structures.
>
> Changes since version 14:
>  - NPCM8XX clock driver
>         - Remove unnecessary register definitions.
>         - Remove the internal reference clock, instead use the external DT reference clock.
>         - rearrange the driver.
>         - using .names parameter in DT to define clock (refclk).
>
> Changes since version 13:
>  - NPCM8XX clock driver
>         - Remove unnecessary definitions and add module.h define
>         - Use in clk_parent_data struct.fw_name and .name.
>         - Add module_exit function.
>         - Add const to divider clock names.
>         - Add MODULE_DESCRIPTION and MODULE_LICENSE
>
> Changes since version 12:
>  - NPCM8XX clock driver
>         - Use clk_parent_data in mux and div clock structure.
>         - Add const to mux tables.
>         - Using devm_clk_hw_register_fixed_rate function.
>         - use only .name clk_parent_data instead .name and .fw_name.
>         - Modify mask values in mux clocks.
>
> Changes since version 11:
>  - NPCM8XX clock driver
>         - Modify Kconfig help.
>         - Modify loop variable to unsigned int.
>
> Changes since version 11:
>  - NPCM8XX clock driver
>         - Modify Kconfig help.
>         - Modify loop variable to unsigned int.
>
> Changes since version 10:
>  - NPCM8XX clock driver
>         - Fix const warning.
>
> Changes since version 9:
>  - NPCM8XX clock driver
>         - Move configuration place.
>         - Using clk_parent_data instead of parent_name
>         - using devm_ioremap instead of ioremap. deeply sorry, I know we had
>          a long discussion on what should the driver use, from other examples
>          (also in other clock drivers) I see the combination of
>          platform_get_resource and devm_ioremap are commonly used and it answer
>          the reset and clock needs.
>
> Changes since version 8:
>  - NPCM8XX clock driver
>         - Move configuration place.
>         - Add space before and aftre '{' '}'.
>         - Handle devm_of_clk_add_hw_provider function error.
>
> Changes since version 7:
>  - NPCM8XX clock driver
>         - The clock and reset registers using the same memory region,
>           due to it the clock driver should claim the ioremap directly
>           without checking the memory region.
>
> Changes since version 6:
>  - NPCM reset driver
>         - Modify warning message.
>  - dt-bindings: serial: 8250: Add npcm845 compatible string patch accepted, due
>    to it the patch removed from the patchset.
>
> Changes since version 5:
>  - NPCM8XX clock driver
>         - Remove refclk if devm_of_clk_add_hw_provider function failed.
>  - NPCM8XX clock source driver
>         - Remove NPCM8XX TIMER_OF_DECLARE support, using the same as NPCM7XX.
>
> Changes since version 4:
>  - NPCM8XX clock driver
>         - Use the same quote in the dt-binding file.
>
> Changes since version 3:
>  - NPCM8XX clock driver
>         - Rename NPCM8xx clock dt-binding header file.
>         - Remove unused structures.
>         - Improve Handling the clocks registration.
>  - NPCM reset driver
>         - Add ref phandle to dt-binding.
>
> Changes since version 2:
>  - Remove NPCM8xx WDT compatible patch.
>  - Remove NPCM8xx UART compatible patch.
>  - NPCM8XX clock driver
>         - Add debug new line.
>         - Add 25M fixed rate clock.
>         - Remove unused clocks and clock name from dt-binding.
>  - NPCM reset driver
>         - Revert to npcm7xx dt-binding.
>         - Skip dt binding quotes.
>         - Adding DTS backward compatibility.
>         - Remove NPCM8xx binding include file.
>         - Warp commit message.
> - NPCM8XX device tree:
>         - Remove unused clock nodes (used in the clock driver)
>         - Modify gcr and rst node names.
>
> Changes since version 1:
>  - NPCM8XX clock driver
>         - Modify dt-binding.
>         - Remove unsed definition and include.
>         - Include alphabetically.
>         - Use clock devm.
>  - NPCM reset driver
>         - Modify dt-binding.
>         - Modify syscon name.
>         - Add syscon support to NPCM7XX dts reset node.
>         - use data structure.
>  - NPCM8XX device tree:
>         - Modify evb compatible name.
>         - Add NPCM7xx compatible.
>         - Remove disable nodes from the EVB DTS.
>
> Tomer Maimon (1):
>   clk: npcm8xx: add clock controller
>
>  drivers/clk/Kconfig       |   8 +
>  drivers/clk/Makefile      |   1 +
>  drivers/clk/clk-npcm8xx.c | 566 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 575 insertions(+)
>  create mode 100644 drivers/clk/clk-npcm8xx.c
>
> --
> 2.33.0
>
