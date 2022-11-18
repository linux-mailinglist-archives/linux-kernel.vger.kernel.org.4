Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A871562FA79
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 17:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242011AbiKRQj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 11:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235320AbiKRQj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 11:39:56 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20F86A690
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 08:39:54 -0800 (PST)
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4E4BE3F1C4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 16:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1668789593;
        bh=SsveInIwU24siw10wAq/NG6g2hNfWM6tCvxZ3GyhJoo=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=BpK/hgogY7klKwLnz5h9htcZo6pIz1bBDDbVZWE6RvtU8/TXVpZ7ATW5O+Y/Kx7Lx
         W8u0OuMZKgQWlwzzv92/eHs87LhabBH+YgktOG6nr8wS9uxwGAIHER4RIAIzhdBpxN
         RajOMiRrTf62kzeNp671keyDfBsSB5xXgK3n9Lgr50ZCvQP8a3j37G7eEpvDher8iP
         kfPTRURxZXR5rC5PvxkqKF7dNxa+kqErKF38EIL+As8FK+cBJDy+G7OZdmPzcFOGZc
         q6ic2FvHLdNRLFjJHbIZ4L1Xwhtg+SpX9qArBC0se3aYB/UpQrJDZ/6aWYqgOAF/oR
         B9oeO5itmvK6g==
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-385bbf9bc8fso54222527b3.23
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 08:39:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SsveInIwU24siw10wAq/NG6g2hNfWM6tCvxZ3GyhJoo=;
        b=tnoS/yd9EVGnXnvU+ABLNoNpPSeh+2PSURuKZ57O7qjYPf9vJkUduhaZch1qmOUPu/
         0iYwYwtYCJ8Rhw+Kd6cAw9h9uPETo8ZZjq3rjYymOZwq14cQ+8wsMNwHDLdGQ8t+H0Tk
         fA5OScY2udmqvAsxjP5L/6380AbF6+yfjw8w3cN4Wx+uVu7QUKta/rCba5LuDiv7Pdn/
         3pwQu9r5pqhijrrIFh9Q76z+6ezpE6+KYykKBrFsHqG9ypzr0av7rsLc2yeiSqIReH84
         jIUuFpPwVTqwY6PmhnAibYvX+3sytFGrtv0kK0VJcudZIOoHpwyQF7hmL8B5XZbhoTXw
         fS7g==
X-Gm-Message-State: ANoB5pmuXLGo5OwidCSWbnWXHydzpitwoMmmc8DpGY30cA9olEJSDhJO
        zpiYMApPnIx5t7qceiQYEWll109YKgd/NzAeLEcHFJpkx0JgMzkF41mLnOXAbvDOq4fRTpxHy3s
        KVg1xSxWPjuS9eDFy+Z7LkTfsXdFTYVFc+5GzB1K3giY0SEVmRLqDrfbGqQ==
X-Received: by 2002:a81:9a0b:0:b0:370:2d3:c361 with SMTP id r11-20020a819a0b000000b0037002d3c361mr7130563ywg.251.1668789592132;
        Fri, 18 Nov 2022 08:39:52 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5Yld5FemVhuwD7WkUFVAvYXFldId6zOG67hlerCJ0EArUo8YQNLpF0HZrvMzsx8hyDkoM7JQBj9nkzNnyf8Nk=
X-Received: by 2002:a81:9a0b:0:b0:370:2d3:c361 with SMTP id
 r11-20020a819a0b000000b0037002d3c361mr7130538ywg.251.1668789591844; Fri, 18
 Nov 2022 08:39:51 -0800 (PST)
MIME-Version: 1.0
References: <20221118010627.70576-1-hal.feng@starfivetech.com> <20221118010627.70576-5-hal.feng@starfivetech.com>
In-Reply-To: <20221118010627.70576-5-hal.feng@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Fri, 18 Nov 2022 17:39:35 +0100
Message-ID: <CAJM55Z8z9OLU5_Z0HiyKN0mMZHrKSkGJqbP_1QOw3nEt6b5MxQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/14] reset: starfive: Factor out common JH71X0 reset code
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
> The StarFive JH7100 SoC has additional reset controllers for audio and
> video, but the registers follow the same structure. On the JH7110 the
> reset registers don't get their own memory range, but instead follow the
> clock control registers. The registers still follow the same structure
> though, so let's factor out the common code to handle all these cases.
>
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  drivers/reset/starfive/Kconfig                |   4 +
>  drivers/reset/starfive/Makefile               |   2 +
>  .../reset/starfive/reset-starfive-jh7100.c    | 121 ++----------------
>  ...rfive-jh7100.c => reset-starfive-jh71x0.c} |  92 ++++---------
>  .../reset/starfive/reset-starfive-jh71x0.h    |  14 ++
>  5 files changed, 56 insertions(+), 177 deletions(-)
>  copy drivers/reset/starfive/{reset-starfive-jh7100.c => reset-starfive-jh71x0.c} (50%)
>  create mode 100644 drivers/reset/starfive/reset-starfive-jh71x0.h
>
> diff --git a/drivers/reset/starfive/Kconfig b/drivers/reset/starfive/Kconfig
> index cddebdba7177..9d15c4110e40 100644
> --- a/drivers/reset/starfive/Kconfig
> +++ b/drivers/reset/starfive/Kconfig
> @@ -1,8 +1,12 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>
> +config RESET_STARFIVE_JH71X0
> +       bool
> +
>  config RESET_STARFIVE_JH7100
>         bool "StarFive JH7100 Reset Driver"
>         depends on SOC_STARFIVE || COMPILE_TEST
> +       select RESET_STARFIVE_JH71X0
>         default SOC_STARFIVE
>         help
>           This enables the reset controller driver for the StarFive JH7100 SoC.
> diff --git a/drivers/reset/starfive/Makefile b/drivers/reset/starfive/Makefile
> index 670d049423f5..f6aa12466fad 100644
> --- a/drivers/reset/starfive/Makefile
> +++ b/drivers/reset/starfive/Makefile
> @@ -1,2 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_RESET_STARFIVE_JH71X0)            += reset-starfive-jh71x0.o
> +
>  obj-$(CONFIG_RESET_STARFIVE_JH7100)            += reset-starfive-jh7100.o
> diff --git a/drivers/reset/starfive/reset-starfive-jh7100.c b/drivers/reset/starfive/reset-starfive-jh7100.c
> index fc44b2fb3e03..43248e8135fd 100644
> --- a/drivers/reset/starfive/reset-starfive-jh7100.c
> +++ b/drivers/reset/starfive/reset-starfive-jh7100.c
> @@ -5,14 +5,10 @@
>   * Copyright (C) 2021 Emil Renner Berthing <kernel@esmil.dk>
>   */
>
> -#include <linux/bitmap.h>
> -#include <linux/io.h>
> -#include <linux/io-64-nonatomic-lo-hi.h>
> -#include <linux/iopoll.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
> -#include <linux/reset-controller.h>
> -#include <linux/spinlock.h>
> +
> +#include "reset-starfive-jh71x0.h"
>
>  #include <dt-bindings/reset/starfive-jh7100.h>
>
> @@ -48,114 +44,19 @@ static const u64 jh7100_reset_asserted[2] = {
>         0,
>  };
>
> -struct jh7100_reset {
> -       struct reset_controller_dev rcdev;
> -       /* protect registers against concurrent read-modify-write */
> -       spinlock_t lock;
> -       void __iomem *base;
> -};
> -
> -static inline struct jh7100_reset *
> -jh7100_reset_from(struct reset_controller_dev *rcdev)
> -{
> -       return container_of(rcdev, struct jh7100_reset, rcdev);
> -}
> -
> -static int jh7100_reset_update(struct reset_controller_dev *rcdev,
> -                              unsigned long id, bool assert)
> -{
> -       struct jh7100_reset *data = jh7100_reset_from(rcdev);
> -       unsigned long offset = BIT_ULL_WORD(id);
> -       u64 mask = BIT_ULL_MASK(id);
> -       void __iomem *reg_assert = data->base + JH7100_RESET_ASSERT0 + offset * sizeof(u64);
> -       void __iomem *reg_status = data->base + JH7100_RESET_STATUS0 + offset * sizeof(u64);
> -       u64 done = jh7100_reset_asserted[offset] & mask;
> -       u64 value;
> -       unsigned long flags;
> -       int ret;
> -
> -       if (!assert)
> -               done ^= mask;
> -
> -       spin_lock_irqsave(&data->lock, flags);
> -
> -       value = readq(reg_assert);
> -       if (assert)
> -               value |= mask;
> -       else
> -               value &= ~mask;
> -       writeq(value, reg_assert);
> -
> -       /* if the associated clock is gated, deasserting might otherwise hang forever */
> -       ret = readq_poll_timeout_atomic(reg_status, value, (value & mask) == done, 0, 1000);
> -
> -       spin_unlock_irqrestore(&data->lock, flags);
> -       return ret;
> -}
> -
> -static int jh7100_reset_assert(struct reset_controller_dev *rcdev,
> -                              unsigned long id)
> -{
> -       return jh7100_reset_update(rcdev, id, true);
> -}
> -
> -static int jh7100_reset_deassert(struct reset_controller_dev *rcdev,
> -                                unsigned long id)
> -{
> -       return jh7100_reset_update(rcdev, id, false);
> -}
> -
> -static int jh7100_reset_reset(struct reset_controller_dev *rcdev,
> -                             unsigned long id)
> -{
> -       int ret;
> -
> -       ret = jh7100_reset_assert(rcdev, id);
> -       if (ret)
> -               return ret;
> -
> -       return jh7100_reset_deassert(rcdev, id);
> -}
> -
> -static int jh7100_reset_status(struct reset_controller_dev *rcdev,
> -                              unsigned long id)
> -{
> -       struct jh7100_reset *data = jh7100_reset_from(rcdev);
> -       unsigned long offset = BIT_ULL_WORD(id);
> -       u64 mask = BIT_ULL_MASK(id);
> -       void __iomem *reg_status = data->base + JH7100_RESET_STATUS0 + offset * sizeof(u64);
> -       u64 value = readq(reg_status);
> -
> -       return !((value ^ jh7100_reset_asserted[offset]) & mask);
> -}
> -
> -static const struct reset_control_ops jh7100_reset_ops = {
> -       .assert         = jh7100_reset_assert,
> -       .deassert       = jh7100_reset_deassert,
> -       .reset          = jh7100_reset_reset,
> -       .status         = jh7100_reset_status,
> -};
> -
>  static int __init jh7100_reset_probe(struct platform_device *pdev)
>  {
> -       struct jh7100_reset *data;
> -
> -       data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> -       if (!data)
> -               return -ENOMEM;
> -
> -       data->base = devm_platform_ioremap_resource(pdev, 0);
> -       if (IS_ERR(data->base))
> -               return PTR_ERR(data->base);
> +       void __iomem *base = devm_platform_ioremap_resource(pdev, 0);
>
> -       data->rcdev.ops = &jh7100_reset_ops;
> -       data->rcdev.owner = THIS_MODULE;
> -       data->rcdev.nr_resets = JH7100_RSTN_END;
> -       data->rcdev.dev = &pdev->dev;
> -       data->rcdev.of_node = pdev->dev.of_node;
> -       spin_lock_init(&data->lock);
> +       if (IS_ERR(base))
> +               return PTR_ERR(base);
>
> -       return devm_reset_controller_register(&pdev->dev, &data->rcdev);
> +       return reset_starfive_jh7100_register(&pdev->dev, pdev->dev.of_node,
> +                                             base + JH7100_RESET_ASSERT0,
> +                                             base + JH7100_RESET_STATUS0,
> +                                             jh7100_reset_asserted,
> +                                             JH7100_RSTN_END,
> +                                             true);
>  }
>
>  static const struct of_device_id jh7100_reset_dt_ids[] = {
> diff --git a/drivers/reset/starfive/reset-starfive-jh7100.c b/drivers/reset/starfive/reset-starfive-jh71x0.c
> similarity index 50%
> copy from drivers/reset/starfive/reset-starfive-jh7100.c
> copy to drivers/reset/starfive/reset-starfive-jh71x0.c
> index fc44b2fb3e03..1e230f3f9841 100644
> --- a/drivers/reset/starfive/reset-starfive-jh7100.c
> +++ b/drivers/reset/starfive/reset-starfive-jh71x0.c
> @@ -6,53 +6,20 @@
>   */
>
>  #include <linux/bitmap.h>
> +#include <linux/device.h>
>  #include <linux/io.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/iopoll.h>
> -#include <linux/mod_devicetable.h>
> -#include <linux/platform_device.h>
>  #include <linux/reset-controller.h>
>  #include <linux/spinlock.h>
>
> -#include <dt-bindings/reset/starfive-jh7100.h>
> -
> -/* register offsets */
> -#define JH7100_RESET_ASSERT0   0x00
> -#define JH7100_RESET_ASSERT1   0x04
> -#define JH7100_RESET_ASSERT2   0x08
> -#define JH7100_RESET_ASSERT3   0x0c
> -#define JH7100_RESET_STATUS0   0x10
> -#define JH7100_RESET_STATUS1   0x14
> -#define JH7100_RESET_STATUS2   0x18
> -#define JH7100_RESET_STATUS3   0x1c
> -
> -/*
> - * Writing a 1 to the n'th bit of the m'th ASSERT register asserts
> - * line 32m + n, and writing a 0 deasserts the same line.
> - * Most reset lines have their status inverted so a 0 bit in the STATUS
> - * register means the line is asserted and a 1 means it's deasserted. A few
> - * lines don't though, so store the expected value of the status registers when
> - * all lines are asserted.
> - */
> -static const u64 jh7100_reset_asserted[2] = {
> -       /* STATUS0 */
> -       BIT_ULL_MASK(JH7100_RST_U74) |
> -       BIT_ULL_MASK(JH7100_RST_VP6_DRESET) |
> -       BIT_ULL_MASK(JH7100_RST_VP6_BRESET) |
> -       /* STATUS1 */
> -       BIT_ULL_MASK(JH7100_RST_HIFI4_DRESET) |
> -       BIT_ULL_MASK(JH7100_RST_HIFI4_BRESET),
> -       /* STATUS2 */
> -       BIT_ULL_MASK(JH7100_RST_E24) |
> -       /* STATUS3 */
> -       0,
> -};
> -
>  struct jh7100_reset {
>         struct reset_controller_dev rcdev;
>         /* protect registers against concurrent read-modify-write */
>         spinlock_t lock;
> -       void __iomem *base;
> +       void __iomem *assert;
> +       void __iomem *status;
> +       const u64 *asserted;
>  };
>
>  static inline struct jh7100_reset *
> @@ -67,9 +34,9 @@ static int jh7100_reset_update(struct reset_controller_dev *rcdev,
>         struct jh7100_reset *data = jh7100_reset_from(rcdev);
>         unsigned long offset = BIT_ULL_WORD(id);
>         u64 mask = BIT_ULL_MASK(id);
> -       void __iomem *reg_assert = data->base + JH7100_RESET_ASSERT0 + offset * sizeof(u64);
> -       void __iomem *reg_status = data->base + JH7100_RESET_STATUS0 + offset * sizeof(u64);
> -       u64 done = jh7100_reset_asserted[offset] & mask;
> +       void __iomem *reg_assert = data->assert + offset * sizeof(u64);
> +       void __iomem *reg_status = data->status + offset * sizeof(u64);
> +       u64 done = data->asserted ? data->asserted[offset] & mask : 0;
>         u64 value;
>         unsigned long flags;
>         int ret;
> @@ -123,10 +90,10 @@ static int jh7100_reset_status(struct reset_controller_dev *rcdev,
>         struct jh7100_reset *data = jh7100_reset_from(rcdev);
>         unsigned long offset = BIT_ULL_WORD(id);
>         u64 mask = BIT_ULL_MASK(id);
> -       void __iomem *reg_status = data->base + JH7100_RESET_STATUS0 + offset * sizeof(u64);
> +       void __iomem *reg_status = data->status + offset * sizeof(u64);
>         u64 value = readq(reg_status);
>
> -       return !((value ^ jh7100_reset_asserted[offset]) & mask);
> +       return !((value ^ data->asserted[offset]) & mask);
>  }
>
>  static const struct reset_control_ops jh7100_reset_ops = {
> @@ -136,38 +103,29 @@ static const struct reset_control_ops jh7100_reset_ops = {
>         .status         = jh7100_reset_status,
>  };
>
> -static int __init jh7100_reset_probe(struct platform_device *pdev)
> +int reset_starfive_jh7100_register(struct device *dev, struct device_node *of_node,
> +                                  void __iomem *assert, void __iomem *status,
> +                                  const u64 *asserted, unsigned int nr_resets,
> +                                  bool is_module)
>  {
>         struct jh7100_reset *data;
>
> -       data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +       data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>         if (!data)
>                 return -ENOMEM;
>
> -       data->base = devm_platform_ioremap_resource(pdev, 0);
> -       if (IS_ERR(data->base))
> -               return PTR_ERR(data->base);
> -
>         data->rcdev.ops = &jh7100_reset_ops;
> -       data->rcdev.owner = THIS_MODULE;
> -       data->rcdev.nr_resets = JH7100_RSTN_END;
> -       data->rcdev.dev = &pdev->dev;
> -       data->rcdev.of_node = pdev->dev.of_node;
> +       if (is_module)
> +               data->rcdev.owner = THIS_MODULE;

nit: consider just passing the owner directly, so this would just be
data->rcdev.owner = owner;

..and callers that used false can just pass NULL.

> +       data->rcdev.nr_resets = nr_resets;
> +       data->rcdev.dev = dev;
> +       data->rcdev.of_node = of_node;

Is it important to register this with the auxiliary device and not
just use the parent device?
If not you can just always pass the device that has the right of_node
and have this be

data->rcdev.of_node = dev->of_node;

> +
>         spin_lock_init(&data->lock);
> +       data->assert = assert;
> +       data->status = status;
> +       data->asserted = asserted;
>
> -       return devm_reset_controller_register(&pdev->dev, &data->rcdev);
> +       return devm_reset_controller_register(dev, &data->rcdev);
>  }
> -
> -static const struct of_device_id jh7100_reset_dt_ids[] = {
> -       { .compatible = "starfive,jh7100-reset" },
> -       { /* sentinel */ }
> -};
> -
> -static struct platform_driver jh7100_reset_driver = {
> -       .driver = {
> -               .name = "jh7100-reset",
> -               .of_match_table = jh7100_reset_dt_ids,
> -               .suppress_bind_attrs = true,
> -       },
> -};
> -builtin_platform_driver_probe(jh7100_reset_driver, jh7100_reset_probe);
> +EXPORT_SYMBOL_GPL(reset_starfive_jh7100_register);
> diff --git a/drivers/reset/starfive/reset-starfive-jh71x0.h b/drivers/reset/starfive/reset-starfive-jh71x0.h
> new file mode 100644
> index 000000000000..10770c55ab0e
> --- /dev/null
> +++ b/drivers/reset/starfive/reset-starfive-jh71x0.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2021 Emil Renner Berthing <kernel@esmil.dk>
> + */
> +
> +#ifndef __RESET_STARFIVE_JH71X0_H
> +#define __RESET_STARFIVE_JH71X0_H
> +
> +int reset_starfive_jh7100_register(struct device *dev, struct device_node *of_node,
> +                                  void __iomem *assert, void __iomem *status,
> +                                  const u64 *asserted, unsigned int nr_resets,
> +                                  bool is_module);
> +
> +#endif /* __RESET_STARFIVE_JH71X0_H */
> --
> 2.38.1
>
