Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B17C62FA47
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 17:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242043AbiKRQ3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 11:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235153AbiKRQ3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 11:29:45 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A1BEB4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 08:29:43 -0800 (PST)
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B60CC3F2FF
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 16:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1668788982;
        bh=n1AmhPidXStte0cr7nALfz6QHVHOy3+6QsUv/gwlQZ0=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=NRX9svCKgLumKXTC9eHZmpfHmbspFYcRC920hDYaHtUZqiZodUzP3U3krlpxecu8h
         7VXC4QYZZJTtIWk7cbO7W3zm3bDs2QxJ6V1VEEGggGb3MGPBDS//Nv5aZtvQyWK/mJ
         VgGApKq+5nEbeMyfCfp/wn79EpEIpo5cdjMLVnclXsiA1rJBEEd2Qqhwe6vCLSm1Xi
         zr/ebWh9onAV6u9UNEyG1cZNZjaNt9s/0KRcbTJ5gTGztNkg7zuweAaRPSYlKBO8Gy
         xR74r/RtCrdwKRfRZ3h4f5p/TCAYas1hCAbkdrB9aBPwst6goEXy9uNApzf2D8s1/s
         xH0TbHSN9E+0w==
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-391bd92f931so44935407b3.22
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 08:29:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n1AmhPidXStte0cr7nALfz6QHVHOy3+6QsUv/gwlQZ0=;
        b=5Ej0B1bk1dWASkirbBi4lkZcS33H6RVBLEGsjTvackL5SaMR4DwYb3yyHAhW+qvVFK
         jSBXA02Fc8gVK+V9biMY8PX6a9WTJUFCn6ohs8OxKYxCTg6L4G4lEEqR5qJoHGXG+IfB
         Iu/2v45z6Kc7VycBr2TySDT4IUl62THpcj97TXu/pjpKfXrxOKcnxhsmK75lHyv/BfCc
         7EfRtH23a6FT9pPevIR8fmoJluLiKftY9az1wgBqvpY0Aj4TipBqIFFk9F93OvAMGhzO
         nTRUdDcoU1uUhsvot1INmwmRDL7HI4URox9a+6iScxJxzSK7EvgtBQBAZpLNWKtEpx4f
         ujpg==
X-Gm-Message-State: ANoB5pkDTi0xREFiiXoCI2WmWCKnwUXXHLIn7+7EejTDdwwtmoddrz2V
        gQEpUsXn/6n2ykWVnAls+NkMlW+mzrIRqkqfNh9eA1NH5kh+H/auubVk7gvKvQfF5MrhkrSDLIo
        aoPed3OmqWiiW8ywGgVWbYkLaBVdlL5JhfQh17wzpBNmbdvNcOagiPTco6A==
X-Received: by 2002:a25:abe4:0:b0:6e7:cbc4:1ac3 with SMTP id v91-20020a25abe4000000b006e7cbc41ac3mr5843272ybi.559.1668788981697;
        Fri, 18 Nov 2022 08:29:41 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7fF79tJ28ERAh84fO3zpC9Fb4cpHbLnel5aGbro1UBa0wzKWcqUZPvwK4sIlnHd/HGGprh2pvRWohAMVTvypE=
X-Received: by 2002:a25:abe4:0:b0:6e7:cbc4:1ac3 with SMTP id
 v91-20020a25abe4000000b006e7cbc41ac3mr5843258ybi.559.1668788981430; Fri, 18
 Nov 2022 08:29:41 -0800 (PST)
MIME-Version: 1.0
References: <20221118010627.70576-1-hal.feng@starfivetech.com> <20221118010627.70576-4-hal.feng@starfivetech.com>
In-Reply-To: <20221118010627.70576-4-hal.feng@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Fri, 18 Nov 2022 17:29:25 +0100
Message-ID: <CAJM55Z_f3K43TKpMKH6x8dQOW4jZMtPvHSvzG+Oeh3qWLWoj4Q@mail.gmail.com>
Subject: Re: [PATCH v2 03/14] reset: Create subdirectory for StarFive drivers
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
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

On Fri, 18 Nov 2022 at 02:06, Hal Feng <hal.feng@starfivetech.com> wrote:
>
> From: Emil Renner Berthing <kernel@esmil.dk>
>
> This moves the StarFive JH7100 reset driver to a new subdirectory in
> preparation for adding more StarFive reset drivers.
>
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  MAINTAINERS                                          | 4 ++--
>  drivers/reset/Kconfig                                | 8 +-------
>  drivers/reset/Makefile                               | 2 +-
>  drivers/reset/starfive/Kconfig                       | 8 ++++++++
>  drivers/reset/starfive/Makefile                      | 2 ++
>  drivers/reset/{ => starfive}/reset-starfive-jh7100.c | 0
>  6 files changed, 14 insertions(+), 10 deletions(-)
>  create mode 100644 drivers/reset/starfive/Kconfig
>  create mode 100644 drivers/reset/starfive/Makefile
>  rename drivers/reset/{ => starfive}/reset-starfive-jh7100.c (100%)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d43daa89d5f1..e6f1060e7964 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19613,11 +19613,11 @@ F:    Documentation/devicetree/bindings/pinctrl/starfive,jh7100-pinctrl.yaml
>  F:     drivers/pinctrl/starfive/
>  F:     include/dt-bindings/pinctrl/pinctrl-starfive-jh7100.h
>
> -STARFIVE JH7100 RESET CONTROLLER DRIVER
> +STARFIVE JH7100 RESET CONTROLLER DRIVERS
>  M:     Emil Renner Berthing <kernel@esmil.dk>
>  S:     Maintained
>  F:     Documentation/devicetree/bindings/reset/starfive,jh7100-reset.yaml
> -F:     drivers/reset/reset-starfive-jh7100.c
> +F:     drivers/reset/starfive/

When this entry covers all StarFive reset drivers the header should
also match. Eg.
STARFIVE RESET CONTROLLER DRIVERS

>  F:     include/dt-bindings/reset/starfive-jh7100.h
>
>  STATIC BRANCH/CALL
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index de176c2fbad9..1e8e1c4954cd 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -232,13 +232,6 @@ config RESET_SOCFPGA
>           This enables the reset driver for the SoCFPGA ARMv7 platforms. This
>           driver gets initialized early during platform init calls.
>
> -config RESET_STARFIVE_JH7100
> -       bool "StarFive JH7100 Reset Driver"
> -       depends on SOC_STARFIVE || COMPILE_TEST
> -       default SOC_STARFIVE
> -       help
> -         This enables the reset controller driver for the StarFive JH7100 SoC.
> -
>  config RESET_SUNPLUS
>         bool "Sunplus SoCs Reset Driver" if COMPILE_TEST
>         default ARCH_SUNPLUS
> @@ -320,6 +313,7 @@ config RESET_ZYNQ
>         help
>           This enables the reset controller driver for Xilinx Zynq SoCs.
>
> +source "drivers/reset/starfive/Kconfig"
>  source "drivers/reset/sti/Kconfig"
>  source "drivers/reset/hisilicon/Kconfig"
>  source "drivers/reset/tegra/Kconfig"
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index 3e7e5fd633a8..fee17a0e3a16 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-y += core.o
>  obj-y += hisilicon/
> +obj-$(CONFIG_SOC_STARFIVE) += starfive/
>  obj-$(CONFIG_ARCH_STI) += sti/
>  obj-$(CONFIG_ARCH_TEGRA) += tegra/
>  obj-$(CONFIG_RESET_A10SR) += reset-a10sr.o
> @@ -30,7 +31,6 @@ obj-$(CONFIG_RESET_RZG2L_USBPHY_CTRL) += reset-rzg2l-usbphy-ctrl.o
>  obj-$(CONFIG_RESET_SCMI) += reset-scmi.o
>  obj-$(CONFIG_RESET_SIMPLE) += reset-simple.o
>  obj-$(CONFIG_RESET_SOCFPGA) += reset-socfpga.o
> -obj-$(CONFIG_RESET_STARFIVE_JH7100) += reset-starfive-jh7100.o
>  obj-$(CONFIG_RESET_SUNPLUS) += reset-sunplus.o
>  obj-$(CONFIG_RESET_SUNXI) += reset-sunxi.o
>  obj-$(CONFIG_RESET_TI_SCI) += reset-ti-sci.o
> diff --git a/drivers/reset/starfive/Kconfig b/drivers/reset/starfive/Kconfig
> new file mode 100644
> index 000000000000..cddebdba7177
> --- /dev/null
> +++ b/drivers/reset/starfive/Kconfig
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config RESET_STARFIVE_JH7100
> +       bool "StarFive JH7100 Reset Driver"
> +       depends on SOC_STARFIVE || COMPILE_TEST
> +       default SOC_STARFIVE
> +       help
> +         This enables the reset controller driver for the StarFive JH7100 SoC.
> diff --git a/drivers/reset/starfive/Makefile b/drivers/reset/starfive/Makefile
> new file mode 100644
> index 000000000000..670d049423f5
> --- /dev/null
> +++ b/drivers/reset/starfive/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_RESET_STARFIVE_JH7100)            += reset-starfive-jh7100.o
> diff --git a/drivers/reset/reset-starfive-jh7100.c b/drivers/reset/starfive/reset-starfive-jh7100.c
> similarity index 100%
> rename from drivers/reset/reset-starfive-jh7100.c
> rename to drivers/reset/starfive/reset-starfive-jh7100.c
> --
> 2.38.1
>
