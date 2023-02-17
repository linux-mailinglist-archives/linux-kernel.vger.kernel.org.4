Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803B469B673
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 00:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjBQXZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 18:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjBQXZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 18:25:34 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F832460BE;
        Fri, 17 Feb 2023 15:25:33 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id j10so2313972qvc.1;
        Fri, 17 Feb 2023 15:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TmsNLgYThqqbDqovTsshqwVzgjPETc/j5uryPGiIUH8=;
        b=OMmaWG9sgM1pg7ZuxWuqy9ItMvtfzxRYvR5FdtQOLlFJUBbt3rFNg4PpEboBl8G3n6
         ReLKa+xNMUicVHSc/QdnWcUFr/H93MGVp/mpCMcCD5LmVVIg18RsQS/psOatVkcFjir7
         qEsQ3JL2tTWCZCeP5nsxUX9a8NIr+hNpf0/WuGr2Fn2JuQ9ascIRJstzoyFL4pDq8aXD
         k/xcIuhEghv79JGrpvDZCSF6M0FMDZf34EDFN9RzIyf0+EKVkkzW7CN6qnok7peYHZno
         OyTkL5FZk8j91UBnex8oMU/KXyA6rR2zZWlEsGgNwfAejhV6PGteWiyd7JG3HxJBXH7K
         IASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TmsNLgYThqqbDqovTsshqwVzgjPETc/j5uryPGiIUH8=;
        b=wEA82bvfdx+joTBR6iGXBmRAPeNYRjnFJVsi4lAMSMZLB405ni5YSX9ZSKeHw4uRzu
         nx+e33Ge1+7K0irCl5xI3AFuG6g8M97VTYnLSclKiCRe5UTFdZ729P6K+8o6Jh9B8iz9
         ME6zRmGfgqBO0oActtH+GCLnZ5bCwoZvnB22Z3F5gQLhV1sdYEwGV0RYaw1dLfpx0iBD
         MgeuJXh+qqBtX+ODAkF5hTf4oOIkxFCKlk/EP8t/5oeXgxMLjWo20GBpTtMNynKC8jDN
         DZ/CLZ/PGNN6PEuywxQTh+laXX7c7ARIkyfB2Rmaa7jN3x14T8MrHOg1a2OSVbh8VYqZ
         G+ZA==
X-Gm-Message-State: AO0yUKXkYIN1ArtZfasjN9/u3fM2IaAId+dvXtOa55sFyqi0YdD3+/Sl
        J6vpE5S1pbffKbBGK7qYRwiiMpZkC1WfwXZSQOI=
X-Google-Smtp-Source: AK7set+ZLr+SMph4nmqoU1TWPRyuD8umUsa4KXW3qosX1xzj+NOi5sn+P3v3yCcLMEEXbtVxwI3C2cV8txFJRzDHZQg=
X-Received: by 2002:a05:6214:8c1:b0:56e:9ad3:ab9c with SMTP id
 da1-20020a05621408c100b0056e9ad3ab9cmr314922qvb.1.1676676332192; Fri, 17 Feb
 2023 15:25:32 -0800 (PST)
MIME-Version: 1.0
References: <cover.1676042188.git.asmaa@nvidia.com> <cover.1676668853.git.asmaa@nvidia.com>
 <4cda8cfc37fb15a0c3b180ab4c34a6f6f859fe3c.1676668853.git.asmaa@nvidia.com>
In-Reply-To: <4cda8cfc37fb15a0c3b180ab4c34a6f6f859fe3c.1676668853.git.asmaa@nvidia.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 18 Feb 2023 01:24:56 +0200
Message-ID: <CAHp75VeTbV7CyVZrXsrm8rqLnYdOunzTDhanqzceyJ3KyPjdwA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] pinctrl: pinctrl-mlxbf: Add pinctrl driver support
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        niyas.sait@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
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
> NVIDIA BlueField-3 SoC has a few pins that can be used as GPIOs
> or take the default hardware functionality. Add a driver for
> the pinmuxing.

pin muxing

...

> +++ b/drivers/pinctrl/pinctrl-mlxbf.c

Wondering if it would be better to match the GPIO driver naming
schema, i.e. by adding 3. In this case the additional explanation in
Kconfig help won't be necessary.

...

> +#define MLXBF_GPIO0_FW_CONTROL_SET   0
> +#define MLXBF_GPIO0_FW_CONTROL_CLEAR 0x14
> +#define MLXBF_GPIO1_FW_CONTROL_SET   0x80
> +#define MLXBF_GPIO1_FW_CONTROL_CLEAR 0x94

Unclear if these are commands or register offsets. If they are of the
same type (semantically), make them fixed width, e.g., 0x00.

...

> +enum {
> +       MLXBF_GPIO_HW_MODE,
> +       MLXBF_GPIO_SW_MODE

I would leave a comma here as it might be extended in the future.

> +};

...

> +static const char * const mlxbf_pinctrl_single_group_names[] = {
> +       "gpio0", "gpio1",  "gpio2",  "gpio3",  "gpio4",  "gpio5",  "gpio6",
> +       "gpio7", "gpio8",  "gpio9",  "gpio10", "gpio11", "gpio12", "gpio13",
> +       "gpio14", "gpio15", "gpio16", "gpio17", "gpio18", "gpio19", "gpio20",
> +       "gpio21", "gpio22", "gpio23", "gpio24", "gpio25", "gpio26", "gpio27",
> +       "gpio28", "gpio29", "gpio30", "gpio31", "gpio32", "gpio33", "gpio34",
> +       "gpio35", "gpio36", "gpio37", "gpio38", "gpio39", "gpio40", "gpio41",
> +       "gpio42", "gpio43", "gpio44", "gpio45", "gpio46", "gpio47", "gpio48",
> +       "gpio49", "gpio50", "gpio51", "gpio52", "gpio53", "gpio54", "gpio55"

Ditto.
Can you group by 8?

> +};
> +
> +/* Set of pin numbers for single-pin groups */
> +static const unsigned int mlxbf_pinctrl_single_group_pins[] = {
> +       0,  1,  2,  3,  4,  5,  6,
> +       7,  8,  9, 10, 11, 12, 13,
> +       14, 15, 16, 17, 18, 19, 20,
> +       21, 22, 23, 24, 25, 26, 27,
> +       28, 29, 30, 31, 32, 33, 34,
> +       35, 36, 37, 38, 39, 40, 41,
> +       42, 43, 44, 45, 46, 47, 48,
> +       49, 50, 51, 52, 53, 54, 55,

Group by 8 which is the more natural length of subarray per line.

Is it just 1:1 to the index? If so, why do you need this table at all?

> +};

...

> +static const struct {
> +       const char *name;
> +       const char * const *group_names;

Use this instead
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/tree/include/linux/pinctrl/pinctrl.h?h=devel#n215
and this
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/tree/include/linux/pinctrl/pinctrl.h?h=devel#n222

> +} mlxbf_pmx_funcs[] = {

> +};

...

> +{
> +       struct mlxbf_pinctrl *priv = pinctrl_dev_get_drvdata(pctldev);
> +
> +       /* disable GPIO functionality by giving control back to hardware */
> +       if (offset < MLXBF_NGPIOS_GPIO0)
> +               writel(BIT(offset), priv->base + MLXBF_GPIO0_FW_CONTROL_CLEAR);
> +       else
> +               writel(BIT(offset % MLXBF_NGPIOS_GPIO0), priv->base + MLXBF_GPIO1_FW_CONTROL_CLEAR);

> +

Redundant blank line.

> +}

...

> +static_assert(ARRAY_SIZE(mlxbf_pinctrl_single_group_names) ==
> +             ARRAY_SIZE(mlxbf_pinctrl_single_group_pins));

I would put it on a single line, but it's up to you.

...

> +       struct resource *res;

Useless?

...

> +       /* This resource is shared so use devm_ioremap */

Can you elaborate on who actually requests the region? And why is it
not _this_ driver?

> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!res)
> +               return -ENODEV;

...

> +       ret = devm_pinctrl_register_and_init(priv->dev,

Is the priv->dev different from dev?

> +                                            &mlxbf_pin_desc,
> +                                            priv,
> +                                            &priv->pctl);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "Failed to register pinctrl\n");

...

> +       pinctrl_add_gpio_range(priv->pctl, &mlxbf_pinctrl_gpio_ranges[0]);
> +       pinctrl_add_gpio_range(priv->pctl, &mlxbf_pinctrl_gpio_ranges[1]);

pinctrl_add_gpio_ranges() ?

--
With Best Regards,
Andy Shevchenko
