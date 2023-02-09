Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0786905BB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 11:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjBIKy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 05:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjBIKyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 05:54:22 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B5B21950
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 02:54:02 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-52bf225460cso19960867b3.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 02:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V2A+JSNtnZSZNxHkgAOi3qNQTktXDyh9ngmNgvIu/CA=;
        b=JAWbIuTo+YkqigV5WYJR8dXCehyFtGE5Z6eBV4/3O5rPNRRJxklnyx1YXE4REYv1r1
         qr0I6uTYrR65jiGBDAoNhT5WwtxblEjfXfyGQvdrewghc3oXR/l48xp3mc3mlEdrDnBi
         y9XDt1ef8HWfvHW/q3ZmLRMQcI2ZM5AglT3YW5UNybOFASe3zJ1y9pqQejDDh/Nnv5q4
         MKVGU+Diqxq7BQ7bPWSM+Z1davVQkHSQXVtekQG7k1UXHqTiHTdc5Am/daBI8W1g2m7S
         3epkVeJvgDyvPUgglq7wVAeAdXYecPLIbgZ0w5EbUt+As6syQHHXLOJo6Ly6Jek3o0tM
         /Zng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V2A+JSNtnZSZNxHkgAOi3qNQTktXDyh9ngmNgvIu/CA=;
        b=UnDyW5TxKG4F2GTrsbuzcUp7NWZQRi+0xL6UifiB4T2ok8UyW+dbYkaA5N81o58Yyq
         U6HBZMZIa5IB0vZkG7D3HIX5UdVOWC9wNBRfwP9gqOL7+i302VRK5zyqjodE+DgOX916
         Rrf3wXOuwmW2+5OcudYqlMZwu9tTmQFQ0t6zKf3A4joLEATpUEnd8+l/kPKoiHOwJuYc
         bQi9PZexBf5UF/lwSeQSZcNlCQ78syT7TmmQGPRz+uv3M/2XoHvZcfvHQPRKRvcysoKg
         b77us/By4ncoynG5I6xQ2AcEz4ueiGVn/JrUQmD5Vf0K1iWGrK11NjQKtwAms5L0+1dz
         yvMA==
X-Gm-Message-State: AO0yUKW7MrfRcmudG5ZFshmSH3UyYT0vwvV+uOBmX6cKQHOROO0irqj8
        wFoSD2RvZvRZsBcHf+CqL3excIK6BRENI1lQbBIb5Q==
X-Google-Smtp-Source: AK7set8a+8zMOjcx8bvOYohd2EDEaCiGDR5OYPFXEWBbxF+7BLoX87v2W+Q6qpXP28L/htQNP3zulYOvtTR2C7vW020=
X-Received: by 2002:a0d:ca01:0:b0:52a:ac51:c6d1 with SMTP id
 m1-20020a0dca01000000b0052aac51c6d1mr906560ywd.477.1675940041566; Thu, 09 Feb
 2023 02:54:01 -0800 (PST)
MIME-Version: 1.0
References: <20230208185714.27313-1-asmaa@nvidia.com> <20230208185714.27313-2-asmaa@nvidia.com>
In-Reply-To: <20230208185714.27313-2-asmaa@nvidia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 9 Feb 2023 11:53:50 +0100
Message-ID: <CACRpkdZ_sPCa+Q6MWUKj1ytCe5AxTp--bMmbRTUfsNO0kZTMpQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Support NVIDIA BlueField-3 GPIO controller
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com, bgolaszewski@baylibre.com,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Asmaa,

thanks for your patch!

On Wed, Feb 8, 2023 at 7:57 PM Asmaa Mnebhi <asmaa@nvidia.com> wrote:

> This patch adds support for the BlueField-3 SoC GPIO driver
> which allows:
> - setting certain GPIOs as interrupts from other dependent drivers
> - ability to manipulate certain GPIO pins via libgpiod tools for instance
>
> BlueField-3 has 56 GPIOs but the user is only allowed to change some
> of them into GPIO mode. Use valid_mask to make it impossible to alter
> the rest of the GPIOs.
>
> Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>

(...)

> +struct mlxbf3_gpio_context {
> +       struct gpio_chip gc;
> +       struct irq_chip irq_chip;
> +
> +       /* YU GPIO block address */
> +       void __iomem *gpio_io;
> +
> +       /* YU GPIO cause block address */
> +       void __iomem *gpio_cause_io;

I especially like that you use the word "cause" (as in cause-and-effect)
over the imprecise and overused word "reason" (brrrr)

> +static int mlxbf3_gpio_direction_input(struct gpio_chip *chip,
> +                                      unsigned int offset)
> +{
> +       struct mlxbf3_gpio_context *gs = gpiochip_get_data(chip);
> +       unsigned long flags;
> +
> +       raw_spin_lock_irqsave(&gs->gc.bgpio_lock, flags);
> +
> +       writel(BIT(offset), gs->gpio_io + MLXBF_GPIO_FW_OUTPUT_ENABLE_CLEAR);
> +
> +       raw_spin_unlock_irqrestore(&gs->gc.bgpio_lock, flags);
> +
> +       return 0;
> +}
> +
> +static int mlxbf3_gpio_direction_output(struct gpio_chip *chip,
> +                                       unsigned int offset,
> +                                       int value)
> +{
> +       struct mlxbf3_gpio_context *gs = gpiochip_get_data(chip);
> +       unsigned long flags;
> +
> +       raw_spin_lock_irqsave(&gs->gc.bgpio_lock, flags);
> +
> +       writel(BIT(offset), gs->gpio_io + MLXBF_GPIO_FW_OUTPUT_ENABLE_SET);
> +
> +       if (value)
> +               writel(BIT(offset), gs->gpio_io + MLXBF_GPIO_FW_DATA_OUT_SET);
> +       else
> +               writel(BIT(offset), gs->gpio_io + MLXBF_GPIO_FW_DATA_OUT_CLEAR);
> +
> +       raw_spin_unlock_irqrestore(&gs->gc.bgpio_lock, flags);
> +
> +       return 0;
> +}

GPIO_GENERIC / bgpio should be able to handle these too.

> +       ret = bgpio_init(gc, dev, 4,
> +                       gs->gpio_io + MLXBF_GPIO_READ_DATA_IN,
> +                       gs->gpio_io + MLXBF_GPIO_FW_DATA_OUT_SET,
> +                       gs->gpio_io + MLXBF_GPIO_FW_DATA_OUT_CLEAR,
> +                       NULL, NULL, 0);

Instead of NULL, NULL, 0

use

gs->gpio_io + MLXBF_GPIO_FW_OUTPUT_ENABLE_SET,
gs->gpio_io + MLXBF_GPIO_FW_OUTPUT_ENABLE_CLEAR,
0);

The generic library will make sure to also set the output value when
changing direction to output.

Yours,
Linus Walleij
