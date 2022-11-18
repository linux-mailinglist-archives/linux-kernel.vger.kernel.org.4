Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABAE162FBBD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 18:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242480AbiKRRdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 12:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242439AbiKRRdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 12:33:17 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B4C9737D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 09:32:29 -0800 (PST)
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2DB283F336
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 17:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1668792748;
        bh=fj8UhkKeU72W/99qO15nHbhyif25XpeQl7PAW0nT2E8=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=POuGlPE+NFJOvhT71OwaT/WzFvptG7faZML0qpUeGl7PGg5rhfnHNuDpr1VUfVg/j
         EXijm9bIsJbBnu2qunLoz/SjtCw9IKGa2UifsSiaxdzMlvZ+MO/GtAbqgY9MAKb4DB
         XmcE60U6Ufq3HRrycCX6iexw7qKmeLrRPULJjvqlV5jhrv5znEkXfsYRfZqMUmgf0i
         IZ2AKO4s0xAGlR6lqHg1Sjc1tLzbdUjD0Hpq1zzdSocnVefEcjQTffKtAOhjL113dy
         KP6S1eTRT9aE+OZiZcuR7ARf+KVaPkR0LvpUrndkwoIvyupk2NK/6OdP6aTn9XbMBj
         g0jZKGH2tBA5w==
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-3985077640fso7767177b3.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 09:32:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fj8UhkKeU72W/99qO15nHbhyif25XpeQl7PAW0nT2E8=;
        b=6M4D0WDYv2GWPnlDyGmvxKAEiq+JinhCBRilueWH3khZbTEYj/o1rdmU3kdSt+XyCR
         fWfsB3jRcsY4gQZWp6G0xBu6G1X6H4Yq1IPv4PeHzmpEUiDpN8ghcSb7xgeZLt7T/jlF
         h3J300EgbxqGkoLiXtEdwKwEdxPB8E2FxaGxK127UOvryW1LDDW5BF0UoD0ZQwnZKorL
         FiTsJfg1P8izfTnnzSffQu9Sxs+qK/y81evjrydw5ZuGEoJwyUXVABNIrjdDRiHNuKkx
         q2ZWeDFBIQctzrMkKZMifuCqOm8ckoOyNOZG3owaNIVkBbphqlpU2dKw0qcuLgTvWohm
         4vAg==
X-Gm-Message-State: ANoB5pmohDNhH2OZwhGAHa425XacUwcCBaaKH9QkzTabEI082etuBRBM
        HrmP9qu0MctufwcapaFdl99A12cOm1FpC7xhX65+Ws+IrFg/ycm9qljLYyq+syyWSEc86XpFaOX
        4YSBPxGK/hq3PYDi2jik2K3YYh4ufhX4ooIJex80wu56eV7rLWEfeiM7hoQ==
X-Received: by 2002:a81:9a0b:0:b0:370:2d3:c361 with SMTP id r11-20020a819a0b000000b0037002d3c361mr7344312ywg.251.1668792747073;
        Fri, 18 Nov 2022 09:32:27 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4HcIbrHIRYmL3dgFd+JbwTuttS78s3rG17fVAdC12Ry8v5uY8zZMQE2fsjsQN8AKs73vkYgU2af/B2EOp5ODM=
X-Received: by 2002:a81:9a0b:0:b0:370:2d3:c361 with SMTP id
 r11-20020a819a0b000000b0037002d3c361mr7344294ywg.251.1668792746848; Fri, 18
 Nov 2022 09:32:26 -0800 (PST)
MIME-Version: 1.0
References: <20221118011714.70877-1-hal.feng@starfivetech.com> <20221118011714.70877-6-hal.feng@starfivetech.com>
In-Reply-To: <20221118011714.70877-6-hal.feng@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Fri, 18 Nov 2022 18:32:10 +0100
Message-ID: <CAJM55Z-jo4x_qX85uFO0esqVFk12v3fS6H7ryx7-Heq1HEudNA@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] soc: sifive: ccache: Add StarFive JH7110 support
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2022 at 02:17, Hal Feng <hal.feng@starfivetech.com> wrote:
>
> From: Emil Renner Berthing <kernel@esmil.dk>
>
> This adds support for the StarFive JH7110 SoC which also
> features this SiFive cache controller.
>
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---

I'm fine with this, but it would be great if you could add the jh7100
support at the same time like the original patch did.

>  arch/riscv/Kconfig.socs            | 1 +
>  drivers/soc/Makefile               | 2 +-
>  drivers/soc/sifive/Kconfig         | 2 +-
>  drivers/soc/sifive/sifive_ccache.c | 1 +
>  4 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index 69774bb362d6..5a40e05f8cab 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -22,6 +22,7 @@ config SOC_STARFIVE
>         bool "StarFive SoCs"
>         select PINCTRL
>         select RESET_CONTROLLER
> +       select SIFIVE_CCACHE
>         select SIFIVE_PLIC
>         help
>           This enables support for StarFive SoC platform hardware.
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index 69ba6508cf2c..534669840858 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -26,7 +26,7 @@ obj-y                         += qcom/
>  obj-y                          += renesas/
>  obj-y                          += rockchip/
>  obj-$(CONFIG_SOC_SAMSUNG)      += samsung/
> -obj-$(CONFIG_SOC_SIFIVE)       += sifive/
> +obj-y                          += sifive/
>  obj-y                          += sunxi/
>  obj-$(CONFIG_ARCH_TEGRA)       += tegra/
>  obj-y                          += ti/
> diff --git a/drivers/soc/sifive/Kconfig b/drivers/soc/sifive/Kconfig
> index ed4c571f8771..e86870be34c9 100644
> --- a/drivers/soc/sifive/Kconfig
> +++ b/drivers/soc/sifive/Kconfig
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>
> -if SOC_SIFIVE
> +if SOC_SIFIVE || SOC_STARFIVE
>
>  config SIFIVE_CCACHE
>         bool "Sifive Composable Cache controller"
> diff --git a/drivers/soc/sifive/sifive_ccache.c b/drivers/soc/sifive/sifive_ccache.c
> index 1c171150e878..9489d1a90fbc 100644
> --- a/drivers/soc/sifive/sifive_ccache.c
> +++ b/drivers/soc/sifive/sifive_ccache.c
> @@ -107,6 +107,7 @@ static const struct of_device_id sifive_ccache_ids[] = {
>         { .compatible = "sifive,fu540-c000-ccache" },
>         { .compatible = "sifive,fu740-c000-ccache" },
>         { .compatible = "sifive,ccache0" },
> +       { .compatible = "starfive,jh7110-ccache" },
>         { /* end of table */ }
>  };
>
> --
> 2.38.1
>
