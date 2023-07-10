Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C08F74D8CF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 16:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbjGJOSz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Jul 2023 10:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbjGJOSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 10:18:45 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075ECDF;
        Mon, 10 Jul 2023 07:18:39 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5700b15c12fso55616957b3.1;
        Mon, 10 Jul 2023 07:18:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688998719; x=1691590719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HqT4bbLk0Pn2au1SGKBZn9et9L/6n+652kKaxwG9w2g=;
        b=E92vIil8mjpZ4NzMwKCUsb+Zh3PpvelXn6yPQFpqrZh3pdhENeN39PM1cr6yCycFvX
         pwkh7/pNYWcqTbR+QkAAJXant4WzVWKTDg4WeQfMCbw7WRaTbavj+uWVYOd70v3N2uIU
         /JxwSfqZpAj5ih2J7/dsqTAVOSDDjdlbOZhJ0Ys+fhB7OQsjjiNfrPpavqDJENK/Nbu+
         00QLeaJUMI6MfIX7OKKfncVF3FBuz8fxiAVlUTNWfHaq8dv0KxfR5N5Mha9qEnOr3MbD
         KZEiEbYxMqSBhu3+VYxzFJySP+aK2/P3CczfHjtuSIlc3bRg0kpGKb2V9rLsyg9NTxSK
         GYmA==
X-Gm-Message-State: ABy/qLbUokUwJop7NJg6Jy1Xe8DL8Jb7MPnNoDxGI+GBkx1PyLxwRDAH
        sPH9zghejB49Ojszw37saUe0d84Axn/oWg==
X-Google-Smtp-Source: APBJJlGRtESM/R8UHlfoGLykPDsdnD9i7zw7L7OAfWPz0Fo6cc7n4QQC2o5GEy+Zp3DVUpzliWGvLw==
X-Received: by 2002:a0d:f181:0:b0:577:3aaf:c876 with SMTP id a123-20020a0df181000000b005773aafc876mr13300206ywf.30.1688998718877;
        Mon, 10 Jul 2023 07:18:38 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id z7-20020a81c207000000b005703cfc23c1sm2986813ywc.104.2023.07.10.07.18.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 07:18:38 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-c6833e6e326so5547500276.1;
        Mon, 10 Jul 2023 07:18:38 -0700 (PDT)
X-Received: by 2002:a25:9d06:0:b0:c84:3e74:c6ed with SMTP id
 i6-20020a259d06000000b00c843e74c6edmr501779ybp.28.1688998718162; Mon, 10 Jul
 2023 07:18:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230630120433.49529-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20230630120433.49529-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230630120433.49529-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 Jul 2023 16:18:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXZwdQHnXqMsSz2Bqva4JELTWewCYLWJBMnmgotDxmayQ@mail.gmail.com>
Message-ID: <CAMuHMdXZwdQHnXqMsSz2Bqva4JELTWewCYLWJBMnmgotDxmayQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] pinctrl: renesas: pinctrl-rzg2l: Add the missing
 port pins P19 to P28
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Fri, Jun 30, 2023 at 2:05 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Add the missing port pins P19 to P28 for RZ/Five SoC. These additional pins
> provide expanded capabilities and are exclusive to the RZ/Five SoC.
> Furthermore, a new variant called r9a07g043_data has been introduced
> specifically for the RZ/Five SoC. When CONFIG_RISCV is enabled, this
> variant replaces the previous data configuration. Additionally, a new macro
> named PIN_CFG_NOGPIO has been implemented. This macro serves as an
> indicator to determine whether the port pins can be utilized as GPIO pins.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> @@ -15,6 +15,7 @@
>  #include <linux/of_irq.h>
>  #include <linux/seq_file.h>
>  #include <linux/spinlock.h>
> +#include <linux/sys_soc.h>
>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/pinctrl/pinconf-generic.h>
> @@ -53,6 +54,7 @@
>  #define PIN_CFG_FILONOFF               BIT(10)
>  #define PIN_CFG_FILNUM                 BIT(11)
>  #define PIN_CFG_FILCLKSEL              BIT(12)
> +#define PIN_CFG_NOGPIO                 BIT(13)
>
>  #define RZG2L_MPXED_PIN_FUNCS          (PIN_CFG_IOLH_A | \
>                                          PIN_CFG_SR | \
> @@ -101,6 +103,12 @@
>  #define SD_CH(n)               (0x3000 + (n) * 4)
>  #define QSPI                   (0x3008)
>
> +#define RZFIVE_P_EX(n)         (0x0000 + 0x06 + ((n) - 19))
> +#define RZFIVE_PM_EX(n)                (0x0100 + 0x0c + ((n) - 19) * 2)
> +#define RZFIVE_PMC_EX(n)       (0x0200 + 0x06 + ((n) - 19))
> +#define RZFIVE_PFC_EX(n)       (0x0400 + 0x18 + ((n) - 19) * 4)
> +#define RZFIVE_PIN_EX(n)       (0x0800 + 0x06 + ((n) - 19))
> +
>  #define PVDD_1800              1       /* I/O domain voltage <= 1.8V */
>  #define PVDD_3300              0       /* I/O domain voltage >= 3.3V */
>
> @@ -160,39 +168,53 @@ struct rzg2l_pinctrl {
>  static const unsigned int iolh_groupa_mA[] = { 2, 4, 8, 12 };
>  static const unsigned int iolh_groupb_oi[] = { 100, 66, 50, 33 };
>
> +static const struct soc_device_attribute rzfive_match[] = {
> +       { .family = "RZ/Five" },
> +       { /* sentinel */}
> +};
> +
>  static void rzg2l_pinctrl_set_pfc_mode(struct rzg2l_pinctrl *pctrl,
>                                        u8 port, u8 pin, u8 func)
>  {
> +       u32 pm_offset = PM(port);
> +       u32 pmc_offset = PMC(port);
> +       u32 pfc_offset = PFC(port);
>         unsigned long flags;
>         u32 reg;
>
> +       if (soc_device_match(rzfive_match) && port > 18) {

Please no soc_device_match() outside .probe() callbacks.

> +               pm_offset = RZFIVE_PM_EX(port);
> +               pmc_offset = RZFIVE_PMC_EX(port);
> +               pfc_offset = RZFIVE_PFC_EX(port);
> +       }
> +
>         spin_lock_irqsave(&pctrl->lock, flags);

> @@ -1050,6 +1077,38 @@ static const u64 r9a07g043_gpio_configs[] = {
>         RZG2L_GPIO_PORT_PACK(0x3f, 6, 0x22, RZG2L_MPXED_PIN_FUNCS),
>  };
>
> +static const u64 r9a07g043f_gpio_configs[] = {
> +       RZG2L_GPIO_PORT_PACK(0x0f, 4, 0x10, RZG2L_MPXED_PIN_FUNCS),
> +       RZG2L_GPIO_PORT_PACK(0x1f, 5, 0x11, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
> +       RZG2L_GPIO_PORT_PACK(0x0f, 4, 0x12, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
> +       RZG2L_GPIO_PORT_PACK(0x0f, 4, 0x13, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
> +       RZG2L_GPIO_PORT_PACK(0x3f, 6, 0x14, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
> +       RZG2L_GPIO_PORT_PACK(0x1f, 5, 0x15, RZG2L_MPXED_PIN_FUNCS),
> +       RZG2L_GPIO_PORT_PACK(0x1f, 5, 0x16, RZG2L_MPXED_PIN_FUNCS),
> +       RZG2L_GPIO_PORT_PACK(0x1f, 5, 0x17, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
> +       RZG2L_GPIO_PORT_PACK(0x1f, 5, 0x18, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
> +       RZG2L_GPIO_PORT_PACK(0x0f, 4, 0x19, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
> +       RZG2L_GPIO_PORT_PACK(0x1f, 5, 0x1a, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
> +       RZG2L_GPIO_PORT_PACK(0x0f, 4, 0x1b, RZG2L_MPXED_PIN_FUNCS),
> +       RZG2L_GPIO_PORT_PACK(0x03, 2, 0x1c, RZG2L_MPXED_PIN_FUNCS),
> +       RZG2L_GPIO_PORT_PACK(0x1f, 5, 0x1d, RZG2L_MPXED_PIN_FUNCS),
> +       RZG2L_GPIO_PORT_PACK(0x07, 3, 0x1e, RZG2L_MPXED_PIN_FUNCS),
> +       RZG2L_GPIO_PORT_PACK(0x0f, 4, 0x1f, RZG2L_MPXED_PIN_FUNCS),
> +       RZG2L_GPIO_PORT_PACK(0x03, 2, 0x20, RZG2L_MPXED_PIN_FUNCS),
> +       RZG2L_GPIO_PORT_PACK(0x0f, 4, 0x21, RZG2L_MPXED_PIN_FUNCS),
> +       RZG2L_GPIO_PORT_PACK(0x3f, 6, 0x22, RZG2L_MPXED_PIN_FUNCS),
> +       RZG2L_GPIO_PORT_PACK(0x02, 1, 0x06, RZG2L_MPXED_PIN_FUNCS | PIN_CFG_NOGPIO),

Aha, so that's where P19-P28 are hiding: in the P06-P0F registers :-(

> +       RZG2L_GPIO_PORT_PACK(0xff, 8, 0x07, RZG2L_MPXED_PIN_FUNCS | PIN_CFG_NOGPIO),
> +       RZG2L_GPIO_PORT_PACK(0x02, 1, 0x08, (PIN_CFG_IOLH_A | PIN_CFG_SR | PIN_CFG_PUPD | PIN_CFG_NOGPIO)),
> +       RZG2L_GPIO_PORT_PACK(0x0f, 4, 0x09, (PIN_CFG_IOLH_A | PIN_CFG_SR | PIN_CFG_PUPD | PIN_CFG_NOGPIO)),
> +       RZG2L_GPIO_PORT_PACK(0x3e, 5, 0x0a, (PIN_CFG_IOLH_A | PIN_CFG_SR | PIN_CFG_PUPD | PIN_CFG_NOGPIO)),
> +       RZG2L_GPIO_PORT_PACK(0x3f, 6, 0x0b, RZG2L_MPXED_PIN_FUNCS | PIN_CFG_NOGPIO),
> +       RZG2L_GPIO_PORT_PACK(0x02, 1, 0x0c, RZG2L_MPXED_PIN_FUNCS | PIN_CFG_NOGPIO),
> +       RZG2L_GPIO_PORT_PACK(0x00, 0, 0x0d, 0x0),
> +       RZG2L_GPIO_PORT_PACK(0x00, 0, 0x0e, 0x0),
> +       RZG2L_GPIO_PORT_PACK(0x3f, 6, 0x0f, RZG2L_MPXED_PIN_FUNCS | PIN_CFG_NOGPIO),
> +};
> +
>  static struct {
>         struct rzg2l_dedicated_configs common[35];
>         struct rzg2l_dedicated_configs rzg2l_pins[7];
> @@ -1534,6 +1593,16 @@ static int rzg2l_pinctrl_probe(struct platform_device *pdev)
>         return 0;
>  }
>
> +#ifdef CONFIG_RISCV
> +static struct rzg2l_pinctrl_data r9a07g043_data = {
> +       .port_pins = rzg2l_gpio_names,
> +       .port_pin_configs = r9a07g043f_gpio_configs,
> +       .n_ports = ARRAY_SIZE(r9a07g043f_gpio_configs),
> +       .dedicated_pins = rzg2l_dedicated_pins.common,
> +       .n_port_pins = ARRAY_SIZE(r9a07g043f_gpio_configs) * RZG2L_PINS_PER_PORT,
> +       .n_dedicated_pins = ARRAY_SIZE(rzg2l_dedicated_pins.common),
> +};

I can't really say I'm excited about this...

> +#else
>  static struct rzg2l_pinctrl_data r9a07g043_data = {
>         .port_pins = rzg2l_gpio_names,
>         .port_pin_configs = r9a07g043_gpio_configs,
> @@ -1542,6 +1611,7 @@ static struct rzg2l_pinctrl_data r9a07g043_data = {
>         .n_port_pins = ARRAY_SIZE(r9a07g043_gpio_configs) * RZG2L_PINS_PER_PORT,
>         .n_dedicated_pins = ARRAY_SIZE(rzg2l_dedicated_pins.common),
>  };
> +#endif
>
>  static struct rzg2l_pinctrl_data r9a07g044_data = {
>         .port_pins = rzg2l_gpio_names,

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
