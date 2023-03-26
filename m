Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA936C97B5
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 22:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjCZUGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 16:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjCZUGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 16:06:52 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7E94EFE
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 13:06:50 -0700 (PDT)
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 17E7D44306
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 20:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1679861207;
        bh=B1v1iH+fF/1+vTpKguvwCqEy5/hkXODIAl2CV+b61Yg=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=OHa8rIra/GgR45o676aFcg+J4ma07N3ETL7AiPlTs8rVRrEr951ZIV7xRSLzqb3nV
         6WonftSNBjjEKAN1mYF81lxKbQQvL2cbqVTiPYXWyQ3BraNojIDkYv7QZfBfxoIODE
         7O0AH+bf6P4iOuG8U9BIGPl2d5faIzcmNieOut9YGavpOIyg6lI7PnZPRj/LqJ1vyS
         KIal59fe+dtIfdhmRgJB5s/zxztwELZMCRfKxYYZfOiXgHIJCBbV+Wyunr+eYxkd2Z
         50KUZ8y5wvoP8HJTQUUdRdZ4IcMcNcBZO/1AdzUPtNa8A7k09v9j/0Bp8R2+0R5S5o
         uwwITGDI8sweQ==
Received: by mail-qv1-f69.google.com with SMTP id l18-20020ad44bd2000000b005a9cf5f609eso2807130qvw.15
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 13:06:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679861206;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B1v1iH+fF/1+vTpKguvwCqEy5/hkXODIAl2CV+b61Yg=;
        b=QJOUe5C2i4u6s5+fuZueoOATQtmv1OEz7sA6fKskLiog256SiaHMKTEmIw4n7E++Mt
         iP9cU2jHuqI0LvGMdwWPlkVJsdRXX2LkgRYvDE1aJe7SHIkKPKAI6KivTflWcHVwO3Fv
         IvFn0rhDE+g+ao/EsNGTi2wHeoqcDkAMx8/nKY0jqt9IlwFiQh1tFJX0FjNjQQiLlWzH
         11loocRcsUEGtgJnBb0tRFMbveDOeZ3fiF4NBM5LKT0hhQOBcgu6+8PKoXPVf2VoGALD
         SIIw973fDeKhs+vjgKHh/AI4u6hnryo7wCm5sCM8pRqGXnWtWccYdruslM/7bO/gbWcP
         x7Aw==
X-Gm-Message-State: AO0yUKW6xg4+bvnjMh2tIQksLIIiOLMBZeiHtctej91psh2CQXRg6HB3
        GZpSk70hZh+XZ9v3RA2E5Ttht4ObvhBGeh9jtyw2r5r6gj9SRnw/vJOSC283ypY+YqtUoMO/AYD
        LI3spvgEBfvuVzmEYNNHnivlssKx4Eo8hqeRyiH1wYFvrh7fPqFTfSrTvKA==
X-Received: by 2002:a05:620a:3186:b0:745:a35f:ad71 with SMTP id bi6-20020a05620a318600b00745a35fad71mr2333699qkb.13.1679861206108;
        Sun, 26 Mar 2023 13:06:46 -0700 (PDT)
X-Google-Smtp-Source: AK7set8TkaE8FZSbREPKLW5Qlp+WuBYnT/gzlAiwH6L+GhwYNfQi8KBW9TXeSiBXBhxpryDxhtJkhJB8dLOlt3rFtRM=
X-Received: by 2002:a05:620a:3186:b0:745:a35f:ad71 with SMTP id
 bi6-20020a05620a318600b00745a35fad71mr2333680qkb.13.1679861205809; Sun, 26
 Mar 2023 13:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230320103750.60295-1-hal.feng@starfivetech.com>
 <20230320103750.60295-14-hal.feng@starfivetech.com> <CAJM55Z_jY67-SUZm3PDRKQTXZS4BJ6jUTBKXMqMTNW5MTFXK_g@mail.gmail.com>
 <c7bd699c-77fe-c01b-bbc6-be7ddc511a20@starfivetech.com>
In-Reply-To: <c7bd699c-77fe-c01b-bbc6-be7ddc511a20@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Sun, 26 Mar 2023 22:06:29 +0200
Message-ID: <CAJM55Z-GAFO_7sUv0KeX28h=PWRscDie1S2=+kg6O0rZevhBug@mail.gmail.com>
Subject: Re: [PATCH v6 13/21] clk: starfive: Add StarFive JH7110 system clock driver
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Mar 2023 at 16:54, Hal Feng <hal.feng@starfivetech.com> wrote:
> On Fri, 24 Mar 2023 15:39:54 +0100, Emil Renner Berthing wrote:
> > On Mon, 20 Mar 2023 at 11:38, Hal Feng <hal.feng@starfivetech.com> wrote:
> [...]
> >> diff --git a/drivers/clk/starfive/clk-starfive-jh7110-sys.c b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
> >> new file mode 100644
> >> index 000000000000..f98a508969c3
> >> --- /dev/null
> >> +++ b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
> >> @@ -0,0 +1,450 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * StarFive JH7110 System Clock Driver
> >> + *
> >> + * Copyright (C) 2022 Emil Renner Berthing <kernel@esmil.dk>
> >> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
> >> + */
> >> +
> >> +#include <linux/clk.h>
> >> +#include <linux/clk-provider.h>
> >> +#include <linux/init.h>
> >> +#include <linux/io.h>
> >> +#include <linux/platform_device.h>
> >> +
> >> +#include <dt-bindings/clock/starfive,jh7110-crg.h>
> >> +
> >> +#include "clk-starfive-jh71x0.h"
> >> +
> >> +/* external clocks */
> >> +#define JH7110_SYSCLK_OSC                      (JH7110_SYSCLK_END + 0)
> >> +#define JH7110_SYSCLK_GMAC1_RMII_REFIN         (JH7110_SYSCLK_END + 1)
> >> +#define JH7110_SYSCLK_GMAC1_RGMII_RXIN         (JH7110_SYSCLK_END + 2)
> >> +#define JH7110_SYSCLK_I2STX_BCLK_EXT           (JH7110_SYSCLK_END + 3)
> >> +#define JH7110_SYSCLK_I2STX_LRCK_EXT           (JH7110_SYSCLK_END + 4)
> >> +#define JH7110_SYSCLK_I2SRX_BCLK_EXT           (JH7110_SYSCLK_END + 5)
> >> +#define JH7110_SYSCLK_I2SRX_LRCK_EXT           (JH7110_SYSCLK_END + 6)
> >> +#define JH7110_SYSCLK_TDM_EXT                  (JH7110_SYSCLK_END + 7)
> >> +#define JH7110_SYSCLK_MCLK_EXT                 (JH7110_SYSCLK_END + 8)
> >> +#define JH7110_SYSCLK_PLL0_OUT                 (JH7110_SYSCLK_END + 9)
> >> +#define JH7110_SYSCLK_PLL1_OUT                 (JH7110_SYSCLK_END + 10)
> >> +#define JH7110_SYSCLK_PLL2_OUT                 (JH7110_SYSCLK_END + 11)
> >> +
> >> +static const struct jh71x0_clk_data jh7110_sysclk_data[] __initconst = {
> >> +       /* root */
> >> +       JH71X0__MUX(JH7110_SYSCLK_CPU_ROOT, "cpu_root", 2,
> >> +                   JH7110_SYSCLK_OSC,
> >> +                   JH7110_SYSCLK_PLL0_OUT),
> >> +       JH71X0__DIV(JH7110_SYSCLK_CPU_CORE, "cpu_core", 7, JH7110_SYSCLK_CPU_ROOT),
> [...]
> >> +       /* qspi */
> >> +       JH71X0_GATE(JH7110_SYSCLK_QSPI_AHB, "qspi_ahb", CLK_IGNORE_UNUSED, JH7110_SYSCLK_AHB1),
> >> +       JH71X0_GATE(JH7110_SYSCLK_QSPI_APB, "qspi_apb", CLK_IGNORE_UNUSED, JH7110_SYSCLK_APB_BUS),
> >
> > Hi Hal,
> >
> > Thanks for going through clocks marked with CLK_IGNORE_UNUSED and
> > either remove the flags or mark them as critical.. It seems you've
> > missed these two though.
>
> The QSPI module of JH7110 supported by Cadence, requires three
> clocks (qspi_ahb, qspi_apb and qspi_ref), but the Cadence QSPI
> driver only supports one clock. As the StarFive QSPI support
> patches [1] had been accepted, I kept these two flags here.

The QSPI driver obviously needs to be fixed so it doesn't depend on
the bootloader leaving the clocks enabled. I don't think we should add
these flags just to work around that until it gets fixed.

> [1] https://lore.kernel.org/all/20230302105221.197421-1-william.qiu@starfivetech.com/
>
> >
> [...]
> >> diff --git a/drivers/clk/starfive/clk-starfive-jh71x0.c b/drivers/clk/starfive/clk-starfive-jh71x0.c
> >> index b372083d11c3..a8c60630ae73 100644
> >> --- a/drivers/clk/starfive/clk-starfive-jh71x0.c
> >> +++ b/drivers/clk/starfive/clk-starfive-jh71x0.c
> >> @@ -5,6 +5,7 @@
> >>   * Copyright (C) 2021-2022 Emil Renner Berthing <kernel@esmil.dk>
> >>   */
> >>
> >> +#include <linux/auxiliary_bus.h>
> >>  #include <linux/clk-provider.h>
> >>  #include <linux/debugfs.h>
> >>  #include <linux/device.h>
> >> @@ -331,3 +332,52 @@ const struct clk_ops *starfive_jh71x0_clk_ops(u32 max)
> >>         return &jh71x0_clk_inv_ops;
> >>  }
> >>  EXPORT_SYMBOL_GPL(starfive_jh71x0_clk_ops);
> >> +
> >> +#if IS_ENABLED(CONFIG_CLK_STARFIVE_JH7110_SYS)
> >> +
> >> +static void jh7110_reset_unregister_adev(void *_adev)
> >> +{
> >> +       struct auxiliary_device *adev = _adev;
> >> +
> >> +       auxiliary_device_delete(adev);
> >> +}
> >> +
> >> +static void jh7110_reset_adev_release(struct device *dev)
> >> +{
> >> +       struct auxiliary_device *adev = to_auxiliary_dev(dev);
> >> +
> >> +       auxiliary_device_uninit(adev);
> >> +}
> >> +
> >> +int jh7110_reset_controller_register(struct jh71x0_clk_priv *priv,
> >> +                                    const char *adev_name,
> >> +                                    u32 adev_id)
> >> +{
> >> +       struct auxiliary_device *adev;
> >> +       int ret;
> >> +
> >> +       adev = devm_kzalloc(priv->dev, sizeof(*adev), GFP_KERNEL);
> >> +       if (!adev)
> >> +               return -ENOMEM;
> >> +
> >> +       adev->name = adev_name;
> >> +       adev->dev.parent = priv->dev;
> >> +       adev->dev.release = jh7110_reset_adev_release;
> >> +       adev->id = adev_id;
> >> +
> >> +       ret = auxiliary_device_init(adev);
> >> +       if (ret)
> >> +               return ret;
> >> +
> >> +       ret = auxiliary_device_add(adev);
> >> +       if (ret) {
> >> +               auxiliary_device_uninit(adev);
> >> +               return ret;
> >> +       }
> >> +
> >> +       return devm_add_action_or_reset(priv->dev,
> >> +                                       jh7110_reset_unregister_adev, adev);
> >> +}
> >> +EXPORT_SYMBOL_GPL(jh7110_reset_controller_register);
> >> +
> >> +#endif
> >
> > Hey, sorry for not noticing this before, but is there a reason these
> > JH7110-specific functions must be added to the generic JH71x0 code?
> > Can't they be added to the JH7110 SYSCRG driver, and then let the
> > other CRG drivers depend on that (which they already do because of
> > clock dependencies)?
>
> It's ok to move these functions to clk-starfive-jh7110-sys.c. By the
> way, could I still keep the declaration in clk-starfive-jh71x0.h?

I'd just add a clk-starfive-jh7110.h file.

> Best regards,
> Hal
>
> >
> >> diff --git a/drivers/clk/starfive/clk-starfive-jh71x0.h b/drivers/clk/starfive/clk-starfive-jh71x0.h
> >> index 34bb11c72eb7..cfe69aabd65a 100644
> >> --- a/drivers/clk/starfive/clk-starfive-jh71x0.h
> >> +++ b/drivers/clk/starfive/clk-starfive-jh71x0.h
> >> @@ -120,4 +120,12 @@ struct jh71x0_clk_priv {
> >>
> >>  const struct clk_ops *starfive_jh71x0_clk_ops(u32 max);
> >>
> >> +#if IS_ENABLED(CONFIG_CLK_STARFIVE_JH7110_SYS)
> >> +
> >> +int jh7110_reset_controller_register(struct jh71x0_clk_priv *priv,
> >> +                                    const char *adev_name,
> >> +                                    u32 adev_id);
> >> +
> >> +#endif
> >> +
> >>  #endif
> >> --
> >> 2.38.1
> >>
>
