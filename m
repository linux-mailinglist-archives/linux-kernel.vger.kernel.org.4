Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3610695FD7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 10:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbjBNJyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 04:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbjBNJyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 04:54:04 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66B77292
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:54:02 -0800 (PST)
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BE5AF3F135
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 09:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1676368439;
        bh=JE/306lAIMQuM4AipngiHVIJwz47UBkV+PO3Q0pMIF8=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=YmgCoHQZG+A61GRK1u+T2GEhjKRQyAEy4eFcxeQSDvcPBgectNvGdbymus08pYAiW
         c3NACCGemyl7d9PqeNFg6yrnayxALRerQiiKNBiQQ1HuduvWlAb97mf4Q5GlQBoAFA
         +jP+ksXsp2zHmDTwHIHuVmpnO0AtBy2mdlbHVeeNTU6Et+aJPQLXOLleoY5Ob0EjVx
         x8NOW0jQwDsfVoySTdllrMJWmcEJz0p9QeeJ/NXWWk78QqQdY4grh9MCjJolyUi5mJ
         CFvSjM+Hj0BuHOqBSNXnZhaPmXSzr2UaYoPzmNEEsV638p1i5fd4gG8IS18JIU8fCk
         aZB1zu7dHuwWA==
Received: by mail-qk1-f198.google.com with SMTP id u11-20020a05620a0c4b00b0073b328e7d17so3555025qki.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:53:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JE/306lAIMQuM4AipngiHVIJwz47UBkV+PO3Q0pMIF8=;
        b=LzvZYKjxP51bf37wqm5ArG6tzDV3Dg/bUuopA+WP5mHHQCdQqnn9OF2p4vYlmgedq+
         +i62K9zd6/dgiUyfKaY41z3/hfGO0aKnnbykaOIuTdAKdt69KrTS9WpISjApM3prJ6E/
         TuXBK682sBfo4N5ZBz/MpLTbOJ68jT5fz1Ug/EB7vS4Y+X2nvZaJ3e1381Xx4sr3ALXr
         1vWZgqFbXhZFbMlSANI9v5ypEccdNv271SazpenT1UB6UxLgQRAXqVYHbML4eyQm/YFJ
         XJufW7Ksw4ceYalkVRvts+qPVdEC5YwLhXeuHuH2o95detYTDDIR1b/9hCmXLfah5yPZ
         O5IQ==
X-Gm-Message-State: AO0yUKWsxvTgC+likUH8jZKD99q8IfwLn/8m4BR8y5zx9v3Utts8u17o
        KgPOLVGsankdt2YIpo+6CzLj8uufz0V3a4ZPvSw7z/37QzWirSQntWlwvuzgRngVG54Ds1ft5uv
        mZKqP3tnUgG7H5l/mupTcOy/88lJJ67ktVUZhRij3Y99EY+ZWFmmR4mU5qQ==
X-Received: by 2002:a37:be82:0:b0:706:865e:b9a with SMTP id o124-20020a37be82000000b00706865e0b9amr55166qkf.118.1676368438314;
        Tue, 14 Feb 2023 01:53:58 -0800 (PST)
X-Google-Smtp-Source: AK7set+P1tLvVDMoWJksLgtZmywCs4zIgltb1yweBhnu/pJ0jYCGp6Zovo2ROkR5fEIrexl5hhzt+EmJIcp1JbGGxLw=
X-Received: by 2002:a37:be82:0:b0:706:865e:b9a with SMTP id
 o124-20020a37be82000000b00706865e0b9amr55163qkf.118.1676368438074; Tue, 14
 Feb 2023 01:53:58 -0800 (PST)
MIME-Version: 1.0
References: <20221220011247.35560-1-hal.feng@starfivetech.com> <20221220011247.35560-8-hal.feng@starfivetech.com>
In-Reply-To: <20221220011247.35560-8-hal.feng@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Tue, 14 Feb 2023 10:53:41 +0100
Message-ID: <CAJM55Z9Y_fF+4Dtu++C_jVS0+ohXp5U0GyuJCBpUh-SpTMGrVA@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] riscv: dts: starfive: Add StarFive JH7110
 VisionFive 2 board device tree
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
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

On Tue, 20 Dec 2022 at 02:12, Hal Feng <hal.feng@starfivetech.com> wrote:
>
> From: Emil Renner Berthing <kernel@esmil.dk>
>
> Add a minimal device tree for StarFive JH7110 VisionFive 2 board
> which has version A and version B. Support booting and basic
> clock/reset/pinctrl/uart drivers.
>
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Co-developed-by: Jianlong Huang <jianlong.huang@starfivetech.com>
> Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
> Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  arch/riscv/boot/dts/starfive/Makefile         |   1 +
>  .../jh7110-starfive-visionfive-2-va.dts       |  13 ++
>  .../jh7110-starfive-visionfive-2-vb.dts       |  13 ++
>  .../jh7110-starfive-visionfive-2.dtsi         | 111 ++++++++++++++++++
>  4 files changed, 138 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-va.dts
>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-vb.dts
>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
>
> diff --git a/arch/riscv/boot/dts/starfive/Makefile b/arch/riscv/boot/dts/starfive/Makefile
> index 0ea1bc15ab30..79e925a4a227 100644
> --- a/arch/riscv/boot/dts/starfive/Makefile
> +++ b/arch/riscv/boot/dts/starfive/Makefile
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
>  dtb-$(CONFIG_SOC_STARFIVE) += jh7100-beaglev-starlight.dtb
> +dtb-$(CONFIG_SOC_STARFIVE) += jh7110-starfive-visionfive-2-va.dtb jh7110-starfive-visionfive-2-vb.dtb
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-va.dts b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-va.dts
> new file mode 100644
> index 000000000000..188d3fddbe88
> --- /dev/null
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-va.dts
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
> + * Copyright (C) 2022 Emil Renner Berthing <kernel@esmil.dk>
> + */
> +
> +/dts-v1/;
> +#include "jh7110-starfive-visionfive-2.dtsi"
> +
> +/ {
> +       model = "StarFive VisionFive 2 VA";
> +       compatible = "starfive,visionfive-2-va", "starfive,jh7110";
> +};
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-vb.dts b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-vb.dts
> new file mode 100644
> index 000000000000..f75c10536f84
> --- /dev/null
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-vb.dts
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
> + * Copyright (C) 2022 Emil Renner Berthing <kernel@esmil.dk>
> + */
> +
> +/dts-v1/;
> +#include "jh7110-starfive-visionfive-2.dtsi"
> +
> +/ {
> +       model = "StarFive VisionFive 2 VB";
> +       compatible = "starfive,visionfive-2-vb", "starfive,jh7110";

Hi Hal,

I just want to double check, is "VisionFive 2 VA" / "visoinfive-2-va"
and "VisionFive 2 VB" / "visionfive-2-vb" really what you want? I
still think having these names match what is printed on the silkscreen
makes it a lot easier for everybody. Even your own releases calls the
boards "v1.2A" and "v1.3B":
https://github.com/starfive-tech/VisionFive2/releases/

So I'd suggest
model = "StarFive VisionFive 2 v1.3B";
compatible = "starfive,visionfive-2-v1.3b", "starfive,jh7110";

I haven't seen these "VA" and "VB" anywhere else, so if you don't want
the version numbers and can promise that there will be no incompatible
future revisions of the boards then maybe just drop the "V". Eg.
model = "StarFive VisionFive 2 B";
compatible = "starfive,visionfive-2-b", "starfive,jh7110";

/Emil

> +};
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> new file mode 100644
> index 000000000000..c60280b89c73
> --- /dev/null
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> @@ -0,0 +1,111 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
> + * Copyright (C) 2022 Emil Renner Berthing <kernel@esmil.dk>
> + */
> +
> +/dts-v1/;
> +#include "jh7110.dtsi"
> +#include "jh7110-pinfunc.h"
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +       aliases {
> +               serial0 = &uart0;
> +       };
> +
> +       chosen {
> +               stdout-path = "serial0:115200n8";
> +       };
> +
> +       cpus {
> +               timebase-frequency = <4000000>;
> +       };
> +
> +       memory@40000000 {
> +               device_type = "memory";
> +               reg = <0x0 0x40000000 0x1 0x0>;
> +       };
> +
> +       gpio-restart {
> +               compatible = "gpio-restart";
> +               gpios = <&gpio 35 GPIO_ACTIVE_HIGH>;
> +               priority = <224>;
> +       };
> +};
> +
> +&osc {
> +       clock-frequency = <24000000>;
> +};
> +
> +&rtc_osc {
> +       clock-frequency = <32768>;
> +};
> +
> +&gmac0_rmii_refin {
> +       clock-frequency = <50000000>;
> +};
> +
> +&gmac0_rgmii_rxin {
> +       clock-frequency = <125000000>;
> +};
> +
> +&gmac1_rmii_refin {
> +       clock-frequency = <50000000>;
> +};
> +
> +&gmac1_rgmii_rxin {
> +       clock-frequency = <125000000>;
> +};
> +
> +&i2stx_bclk_ext {
> +       clock-frequency = <12288000>;
> +};
> +
> +&i2stx_lrck_ext {
> +       clock-frequency = <192000>;
> +};
> +
> +&i2srx_bclk_ext {
> +       clock-frequency = <12288000>;
> +};
> +
> +&i2srx_lrck_ext {
> +       clock-frequency = <192000>;
> +};
> +
> +&tdm_ext {
> +       clock-frequency = <49152000>;
> +};
> +
> +&mclk_ext {
> +       clock-frequency = <12288000>;
> +};
> +
> +&uart0 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&uart0_pins>;
> +       status = "okay";
> +};
> +
> +&gpio {
> +       uart0_pins: uart0-0 {
> +               tx-pins {
> +                       pinmux = <GPIOMUX(5, GPOUT_SYS_UART0_TX, GPOEN_ENABLE, GPI_NONE)>;
> +                       bias-disable;
> +                       drive-strength = <12>;
> +                       input-disable;
> +                       input-schmitt-disable;
> +                       slew-rate = <0>;
> +               };
> +
> +               rx-pins {
> +                       pinmux = <GPIOMUX(6, GPOUT_LOW, GPOEN_DISABLE, GPI_SYS_UART0_RX)>;
> +                       bias-disable; /* external pull-up */
> +                       drive-strength = <2>;
> +                       input-enable;
> +                       input-schmitt-enable;
> +                       slew-rate = <0>;
> +               };
> +       };
> +};
> --
> 2.38.1
>
