Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4055569B62D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 00:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjBQXIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 18:08:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjBQXH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 18:07:58 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D27CC67D;
        Fri, 17 Feb 2023 15:07:55 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id m11so2162018qtp.7;
        Fri, 17 Feb 2023 15:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dBiTrHReRxmuq/9ozf1YQmOmI8tYHPrT2vLjZ6Of39U=;
        b=SoMY0E1BvDBjWlixSetu3T3kRtG1qgLRdMDknsr2oJpCO1yU7CtnGNE1w57d0wLaop
         UMpar1wE0v9jIOuhYeTDB0ZqAlz1pfa2whY+RCpvab/TG0KdG9yLZ1wEchU3IjxaCf4R
         FfguaD51uN4COGXhaAXgE81XwhD5HYOeszxONbKcJjluweFV9QYgESNCiEtNOz25DXQS
         4pE0TV/0BhA1hTKjLxsI7e8K8Rf5sSHaW60ETWThSFQnivQpbzvY+hQBfyKra9GhLs5R
         0q0znVmvLn8fEg0Jwk0OT7ZbeyB8+E9153xQ9HZOv4liSOk1tN7yhDj+vvCY72Rtm4j3
         gbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dBiTrHReRxmuq/9ozf1YQmOmI8tYHPrT2vLjZ6Of39U=;
        b=nCjgaqkfRFC7A9FFBA4A2dLofM9LQcfxZ0Vvggztuwhfg7yNWOgKyvuegfOb+72WJZ
         J7gYS8dF+0lPXWkUbIfDfT3HaHwzE+AL8FXQGKywU5TSJ9J/0NtqLdE3YTm9qjkd83Wa
         NKHFr3vVOIWkvfcu8AH7DkrlqHxdnbSoy1v8t85k2Pw/jYCltGrg4GnRw+IEFsfO4UgW
         08JZ8dJjNNl9goy3bScHK0FXRDk1FabARUqSKqSc2/Hxm0oKHx3h/rlRF5CsKhxMt6mr
         bnz4Tmyfk8d2aPkS8FFF6Z4JI+gA+35u5U+KMuij5jRqRyPEUfYjuqvB5FtfQTOO6qrb
         5UbA==
X-Gm-Message-State: AO0yUKU3x35vFvnKvIW6mzS7BsTiDnWeGtF9h5AneqvHEwiwZzk7TdvR
        J8B92P7g9FJ+3QUl9fxpSQCN97q1x9zX0vsVkVI=
X-Google-Smtp-Source: AK7set8KADSG2RkScyCX/xeJXgMSvT40fcUuT3yuzruyy+kOj09hhcPpJjAL7+i573SJVGjwsI+aLLsK18WOaC9ZB5k=
X-Received: by 2002:ac8:1e8a:0:b0:3bd:1428:26b4 with SMTP id
 c10-20020ac81e8a000000b003bd142826b4mr616915qtm.1.1676675274354; Fri, 17 Feb
 2023 15:07:54 -0800 (PST)
MIME-Version: 1.0
References: <cover.1676042188.git.asmaa@nvidia.com> <cover.1676668853.git.asmaa@nvidia.com>
 <28f0d670407c127614b64d9c382b11c795f5077d.1676668853.git.asmaa@nvidia.com>
In-Reply-To: <28f0d670407c127614b64d9c382b11c795f5077d.1676668853.git.asmaa@nvidia.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 18 Feb 2023 01:07:18 +0200
Message-ID: <CAHp75VdeVpjzg5Y_4Y+Ke9=3wog28vUBN4Fd8zxfa8dWGrqUUA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] gpio: gpio-mlxbf3: Add gpio driver support
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
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

On Fri, Feb 17, 2023 at 11:27 PM Asmaa Mnebhi <asmaa@nvidia.com> wrote:
>
> Add support for the BlueField-3 SoC GPIO driver.
> This driver configures and handles GPIO interrupts. It also enables a user
> to manipulate certain GPIO pins via libgpiod tools or other kernel drivers.
> The usables pins are defined via the gpio-reserved-ranges property.

Probably

"gpio-reserved-ranges"

(in double quotes).

...

> +       depends on (MELLANOX_PLATFORM && ARM64 && ACPI) || (64BIT && COMPILE_TEST)

But do you really need the ACPI dependency? I don't see a single bit
of it in the driver.
(Yes, I know about IDs.)

Also, how 64BIT is needed for testing?

...

> +#include <linux/version.h>

I believe it's included automatically. Please, double check the header
inclusions to make sure you don't have some spurious ones in the list.

> +struct mlxbf3_gpio_context {
> +       struct gpio_chip gc;
> +
> +       /* YU GPIO block address */
> +       void __iomem *gpio_io;
> +
> +       /* YU GPIO cause block address */
> +       void __iomem *gpio_cause_io;
> +};

...

> +       int offset = irqd_to_hwirq(irqd);

It returns irq_hw_number_t IIRC. It's an unsigned type. Otherwise you
may have interesting effects.

...

> +       int offset = irqd_to_hwirq(irqd);

Ditto.

...

> +       raw_spin_lock_irqsave(&gs->gc.bgpio_lock, flags);
> +
> +       switch (type & IRQ_TYPE_SENSE_MASK) {
> +       case IRQ_TYPE_EDGE_BOTH:
> +               val = readl(gs->gpio_io + MLXBF_GPIO_CAUSE_FALL_EN);
> +               val |= BIT(offset);
> +               writel(val, gs->gpio_io + MLXBF_GPIO_CAUSE_FALL_EN);
> +               val = readl(gs->gpio_io + MLXBF_GPIO_CAUSE_RISE_EN);
> +               val |= BIT(offset);
> +               writel(val, gs->gpio_io + MLXBF_GPIO_CAUSE_RISE_EN);
> +               break;
> +       case IRQ_TYPE_EDGE_RISING:
> +               val = readl(gs->gpio_io + MLXBF_GPIO_CAUSE_RISE_EN);
> +               val |= BIT(offset);
> +               writel(val, gs->gpio_io + MLXBF_GPIO_CAUSE_RISE_EN);
> +               break;
> +       case IRQ_TYPE_EDGE_FALLING:
> +               val = readl(gs->gpio_io + MLXBF_GPIO_CAUSE_FALL_EN);
> +               val |= BIT(offset);
> +               writel(val, gs->gpio_io + MLXBF_GPIO_CAUSE_FALL_EN);
> +               break;
> +       default:

Dead lock starts here.

> +               return -EINVAL;
> +       }
> +
> +       raw_spin_unlock_irqrestore(&gs->gc.bgpio_lock, flags);

...

> +       irq_set_handler_locked(irqd, handle_simple_irq);

Why not using propert handler type (edge)?

...

> +static const struct irq_chip gpio_mlxbf3_irqchip = {
> +       .name = "MLNXBF33",
> +       .irq_set_type = mlxbf3_gpio_irq_set_type,
> +       .irq_enable = mlxbf3_gpio_irq_enable,
> +       .irq_disable = mlxbf3_gpio_irq_disable,
> +};

Seems missing two things (dunno if bgpio_init() helps with that):
- IMMUTABLE flag
- actual calls to enable and disable IRQs for internal GPIO library usage

See other drivers how it's done. There are even plenty of patches to
enable this thing separately.

...

> +static int
> +mlxbf3_gpio_probe(struct platform_device *pdev)

Doesn't it perfectly fit one line?

...

> +       npins = MLXBF3_GPIO_MAX_PINS_PER_BLOCK;
> +       device_property_read_u32(dev, "npins", &npins);

I don't see DT bindings for this property (being added in this
series). Is it already established one?

...

> +               girq->default_type = IRQ_TYPE_NONE;

Assigning handle_bad_irq() is missing.

-- 
With Best Regards,
Andy Shevchenko
