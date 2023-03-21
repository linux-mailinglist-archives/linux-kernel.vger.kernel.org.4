Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3566C2F97
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 11:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjCUKwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 06:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjCUKwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 06:52:31 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBAB23679;
        Tue, 21 Mar 2023 03:52:21 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id x3so57833310edb.10;
        Tue, 21 Mar 2023 03:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679395939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79k0rjOUg5AROK7F+BzYkZ+CS/tNIsvG9Cv0ySa7GXU=;
        b=IufGnfAKRBBz5dXJfoCwwvSupZW2WN4iTI+YrmloOqe8RBN48SP7WeKaLLW6I2tPd2
         F3mNDpbHOhhWAw7qqhIDWmampmeU3A189JD7SZwNh+qNFE2ARd87O/ZDcFnJvW2LZvTn
         mxnbJqLHOUaz10izTZaPcw0kzc3+AKcqUek4zwEDN9QcSAF3R6KudR0mqS3Nmk8SXpcj
         ctsflwg5AiYa9W5TLiHkbt1h1/VPT34H7i6/IxzrAiKJXl5Qi7auFf7AFhcAHBbvxz+T
         enZusKN9pQik8g7wplpmQZAuc3BD6zpycuU0C3oi91a6A+3D9qRcEIpcNQaZkzGkV8MH
         q87Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679395939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=79k0rjOUg5AROK7F+BzYkZ+CS/tNIsvG9Cv0ySa7GXU=;
        b=JD5ZkPdCeBYwwr/ZVheC67/qKCTMNK+FuzrA/0kgDfQoG32fs+2/HxSV7WLctDWfi/
         GhWdWk2rJ4ZdBzKHVSO/i+M6bNspmF+dhvqj87GBOr9GHMfeZ4Y0IAm8LlUZEuYz8QQ1
         eeYKepSupHV2CuzZ6DiQlJWiZbzTdKDp1/qiXWELySTofU+jwRBW5o2kFmqD+IU5tGVu
         Pgw/y++sKBr0dlt4dX8fv5kqfYWzShs/I30orj1vA+x2FkneN8Q7Q5qOzzxW8oZlMnyV
         cvEtrZNZDYauCpob+FlWgBlG33Vc8Cdl1/IZqiAvn3ByOBARvSaSHR0QDOjfZN1c5b+i
         2buQ==
X-Gm-Message-State: AO0yUKXdUPerWiXSTw8c79TxuacHyuYMJIDn3cc80DKjpS9pqEeWsdLh
        kIOaixsu8JjEoPfqcHvU3hmiiJLylozCAoRMBVo=
X-Google-Smtp-Source: AK7set8brurMpbW6M4MzRD+p8ZEThueZwTdDyctayMgkY2/X4GfXqNwLMmeJXhNLKnKDc0etNz0tkRzvvnnNgqHI63U=
X-Received: by 2002:a50:bb2d:0:b0:501:d3a2:b4b3 with SMTP id
 y42-20020a50bb2d000000b00501d3a2b4b3mr1410018ede.0.1679395939338; Tue, 21 Mar
 2023 03:52:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230316104707.236034-1-keguang.zhang@gmail.com>
 <20230316104707.236034-4-keguang.zhang@gmail.com> <21872a93cb09d6c0d9aa3593c0ec489e.sboyd@kernel.org>
In-Reply-To: <21872a93cb09d6c0d9aa3593c0ec489e.sboyd@kernel.org>
From:   Keguang Zhang <keguang.zhang@gmail.com>
Date:   Tue, 21 Mar 2023 18:52:03 +0800
Message-ID: <CAJhJPsUkC8zWxeaOhnvnDFyyDqbTF074Q3mNK_8GAWUCo9ZyKw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] clk: loongson1: Re-implement the clock driver
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 4:06=E2=80=AFAM Stephen Boyd <sboyd@kernel.org> wro=
te:
>
> Quoting Keguang Zhang (2023-03-16 03:47:06)
> > diff --git a/drivers/clk/clk-loongson1.c b/drivers/clk/clk-loongson1.c
> > new file mode 100644
> > index 000000000000..4fda55c67d8d
> > --- /dev/null
> > +++ b/drivers/clk/clk-loongson1.c
> > @@ -0,0 +1,301 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Clock driver for Loongson-1 SoC
> > + *
> > + * Copyright (C) 2012-2023 Keguang Zhang <keguang.zhang@gmail.com>
> > + */
> > +
> > +#include <linux/clk-provider.h>
> > +#include <linux/of_address.h>
> > +#include <linux/slab.h>
>
> Need some more includes here, for container_of() and GENMASK(), readl(),
> etc.
>
Will do.

> > +
> > +#include <dt-bindings/clock/loongson,ls1x-clk.h>
> > +
> > +/* Loongson 1 Clock Register Definitions */
> > +#define CLK_PLL_FREQ           0x0
> > +#define CLK_PLL_DIV            0x4
> > +
> > +static DEFINE_SPINLOCK(ls1x_clk_div_lock);
> > +
>
> Needs include.
>
Will do.

> > +struct ls1x_clk_pll_data {
> > +       u32 fixed;
> > +       u8 shift;
> > +       u8 int_shift;
> > +       u8 int_width;
> > +       u8 frac_shift;
> > +       u8 frac_width;
> > +};
> > +
> > +struct ls1x_clk_div_data {
> > +       u8 shift;
> > +       u8 width;
> > +       unsigned long flags;
> > +       const struct clk_div_table *table;
> > +       u8 bypass_shift;
> > +       u8 bypass_inv;
> > +       spinlock_t *lock;       /* protect access to DIV registers */
> > +};
> > +
> > +struct ls1x_clk {
> > +       void __iomem *reg;
> > +       unsigned int offset;
> > +       struct clk_hw hw;
> > +       void *data;
> > +};
> > +
> > +#define to_ls1x_clk(_hw) container_of(_hw, struct ls1x_clk, hw)
> > +
> > +static inline unsigned long ls1x_pll_rate_part(unsigned int val,
>
> return a u32?
>
Yes.

> > +                                              unsigned int shift,
> > +                                              unsigned int width)
> > +{
> > +       return (val & GENMASK(shift + width, shift)) >> shift;
> > +}
> > +
> > +static unsigned long ls1x_pll_recalc_rate(struct clk_hw *hw,
> > +                                         unsigned long parent_rate)
> > +{
> > +       struct ls1x_clk *ls1x_clk =3D to_ls1x_clk(hw);
> > +       const struct ls1x_clk_pll_data *d =3D ls1x_clk->data;
> > +       u32 val, rate;
> > +
> > +       val =3D readl(ls1x_clk->reg);
> > +       rate =3D d->fixed;
> > +       rate +=3D ls1x_pll_rate_part(val, d->int_shift, d->int_width);
> > +       if (d->frac_width)
> > +               rate +=3D ls1x_pll_rate_part(val, d->frac_shift, d->fra=
c_width);
> > +       rate *=3D parent_rate;
> > +       rate >>=3D d->shift;
> > +
> > +       return rate;
> > +}
> > +
> > +static const struct clk_ops ls1x_pll_clk_ops =3D {
> > +       .recalc_rate =3D ls1x_pll_recalc_rate,
> > +};
> > +
> > +static unsigned long ls1x_divider_recalc_rate(struct clk_hw *hw,
> > +                                             unsigned long parent_rate=
)
> > +{
> > +       struct ls1x_clk *ls1x_clk =3D to_ls1x_clk(hw);
> > +       const struct ls1x_clk_div_data *d =3D ls1x_clk->data;
> > +       unsigned int val;
> > +
> > +       val =3D readl(ls1x_clk->reg) >> d->shift;
> > +       val &=3D clk_div_mask(d->width);
> > +
> > +       return divider_recalc_rate(hw, parent_rate, val, d->table,
> > +                                  d->flags, d->width);
> > +}
> > +
> > +static long ls1x_divider_round_rate(struct clk_hw *hw, unsigned long r=
ate,
> > +                                   unsigned long *prate)
> > +{
> > +       struct ls1x_clk *ls1x_clk =3D to_ls1x_clk(hw);
> > +       const struct ls1x_clk_div_data *d =3D ls1x_clk->data;
> > +
> > +       return divider_round_rate(hw, rate, prate, d->table,
> > +                                 d->width, d->flags);
> > +}
> > +
> > +static int ls1x_divider_set_rate(struct clk_hw *hw, unsigned long rate=
,
> > +                                unsigned long parent_rate)
> > +{
> > +       struct ls1x_clk *ls1x_clk =3D to_ls1x_clk(hw);
> > +       const struct ls1x_clk_div_data *d =3D ls1x_clk->data;
> > +       int val, div_val;
> > +       unsigned long flags =3D 0;
> > +
> > +       div_val =3D divider_get_val(rate, parent_rate, d->table,
> > +                                 d->width, d->flags);
> > +       if (div_val < 0)
> > +               return div_val;
> > +
> > +       if (d->lock)
> > +               spin_lock_irqsave(d->lock, flags);
> > +       else
> > +               __acquire(d->lock);
> > +
> > +       /* Bypass the clock */
> > +       val =3D readl(ls1x_clk->reg);
> > +       if (d->bypass_inv)
> > +               val &=3D ~BIT(d->bypass_shift);
> > +       else
> > +               val |=3D BIT(d->bypass_shift);
> > +       writel(val, ls1x_clk->reg);
> > +
> > +       val =3D readl(ls1x_clk->reg);
> > +       val &=3D ~(clk_div_mask(d->width) << d->shift);
> > +       val |=3D (u32)div_val << d->shift;
> > +       writel(val, ls1x_clk->reg);
> > +
> > +       /* Restore the clock */
> > +       val =3D readl(ls1x_clk->reg);
> > +       if (d->bypass_inv)
> > +               val |=3D BIT(d->bypass_shift);
> > +       else
> > +               val &=3D ~BIT(d->bypass_shift);
> > +       writel(val, ls1x_clk->reg);
> > +
> > +       if (d->lock)
> > +               spin_unlock_irqrestore(d->lock, flags);
> > +       else
> > +               __release(d->lock);
>
> Is there a case where there isn't a lock? It would be easier to read if
> this always had a lock and it wasn't optional.
>
Indeed. The lock always exists in this driver.
Will remove the unnecessary __acquire()/__release().

> > +
> > +       return 0;
> > +}
> > +
> > +static const struct clk_ops ls1x_clk_divider_ops =3D {
> > +       .recalc_rate =3D ls1x_divider_recalc_rate,
> > +       .round_rate =3D ls1x_divider_round_rate,
> > +       .set_rate =3D ls1x_divider_set_rate,
> > +};
> > +
> > +#define LS1X_CLK_PLL(_name, _offset, _fixed, _shift,                  =
 \
> > +                    f_shift, f_width, i_shift, i_width)               =
 \
> > +struct ls1x_clk _name =3D {                                           =
   \
> > +       .offset =3D (_offset),                                         =
   \
> > +       .data =3D &(struct ls1x_clk_pll_data) {                        =
   \
> > +               .fixed =3D (_fixed),                                   =
   \
> > +               .shift =3D (_shift),                                   =
   \
> > +               .int_shift =3D (i_shift),                              =
   \
> > +               .int_width =3D (i_width),                              =
   \
> > +               .frac_shift =3D (f_shift),                             =
   \
> > +               .frac_width =3D (f_width),                             =
   \
> > +       },                                                             =
 \
> > +       .hw.init =3D &(struct clk_init_data) {                         =
   \
> > +               .name =3D #_name,                                      =
   \
> > +               .ops =3D &ls1x_pll_clk_ops,                            =
   \
> > +               .parent_data =3D &(const struct clk_parent_data) {     =
   \
> > +                       .fw_name =3D "xtal",                           =
   \
> > +                       .name =3D "xtal",                              =
   \
> > +                       .index =3D -1,                                 =
   \
> > +               },                                                     =
 \
> > +               .num_parents =3D 1,                                    =
   \
> > +       },                                                             =
 \
> > +}
> > +
> > +#define LS1X_CLK_DIV(_name, _pname, _offset, _shift, _width,          =
 \
> > +                    _table, _bypass_shift, _bypass_inv, _flags)       =
 \
> > +struct ls1x_clk _name =3D {                                           =
   \
> > +       .offset =3D (_offset),                                         =
   \
> > +       .data =3D &(struct ls1x_clk_div_data){                         =
   \
> > +               .shift =3D (_shift),                                   =
   \
> > +               .width =3D (_width),                                   =
   \
> > +               .table =3D (_table),                                   =
   \
> > +               .flags =3D (_flags),                                   =
   \
> > +               .bypass_shift =3D (_bypass_shift),                     =
   \
> > +               .bypass_inv =3D (_bypass_inv),                         =
   \
> > +               .lock =3D &ls1x_clk_div_lock,                          =
   \
> > +       },                                                             =
 \
> > +       .hw.init =3D &(struct clk_init_data) {                         =
   \
>
> Can be const.
>
Will do.

> > +               .name =3D #_name,                                      =
   \
> > +               .ops =3D &ls1x_clk_divider_ops,                        =
   \
> > +               .parent_hws =3D (const struct clk_hw *[]) { _pname },  =
   \
> > +               .num_parents =3D 1,                                    =
   \
> > +               .flags =3D CLK_GET_RATE_NOCACHE,                       =
   \
> > +       },                                                             =
 \
> > +}
> > +
> > +static LS1X_CLK_PLL(ls1b_clk_pll, CLK_PLL_FREQ, 12, 1, 0, 5, 0, 0);
> > +static LS1X_CLK_DIV(ls1b_clk_cpu, &ls1b_clk_pll.hw, CLK_PLL_DIV,
> > +                   20, 4, NULL, 8, 0,
> > +                   CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ROUND_CLOSEST);
> > +static LS1X_CLK_DIV(ls1b_clk_dc, &ls1b_clk_pll.hw, CLK_PLL_DIV,
> > +                   26, 4, NULL, 12, 0, CLK_DIVIDER_ONE_BASED);
> > +static LS1X_CLK_DIV(ls1b_clk_ahb, &ls1b_clk_pll.hw, CLK_PLL_DIV,
> > +                   14, 4, NULL, 10, 0, CLK_DIVIDER_ONE_BASED);
> > +static CLK_FIXED_FACTOR(ls1b_clk_apb, "ls1b_clk_apb", "ls1b_clk_ahb", =
2, 1,
> > +                       CLK_SET_RATE_PARENT);
> > +
> > +static struct clk_hw_onecell_data ls1b_clk_hw_data =3D {
> > +       .hws =3D {
> > +               [LS1X_CLKID_PLL] =3D &ls1b_clk_pll.hw,
> > +               [LS1X_CLKID_CPU] =3D &ls1b_clk_cpu.hw,
> > +               [LS1X_CLKID_DC] =3D &ls1b_clk_dc.hw,
> > +               [LS1X_CLKID_AHB] =3D &ls1b_clk_ahb.hw,
> > +               [LS1X_CLKID_APB] =3D &ls1b_clk_apb.hw,
> > +               [CLK_NR_CLKS] =3D NULL,
>
> Do you need a CLK_NR_CLKS sentinel entry?
>
Not necessary.
Will remove.

> > +       },
> > +       .num =3D CLK_NR_CLKS,
> > +};
> > +
> > +static const struct clk_div_table ls1c_ahb_div_table[] =3D {
> > +       [0] =3D { .val =3D 0, .div =3D 2 },
> > +       [1] =3D { .val =3D 1, .div =3D 4 },
> > +       [2] =3D { .val =3D 2, .div =3D 3 },
> > +       [3] =3D { .val =3D 3, .div =3D 3 },
> > +       [4] =3D { /* sentinel */ }
> > +};
> > +
> > +static LS1X_CLK_PLL(ls1c_clk_pll, CLK_PLL_FREQ, 0, 2, 8, 8, 16, 8);
> > +static LS1X_CLK_DIV(ls1c_clk_cpu, &ls1c_clk_pll.hw, CLK_PLL_DIV,
> > +                   8, 7, NULL, 0, 1,
> > +                   CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ROUND_CLOSEST);
> > +static LS1X_CLK_DIV(ls1c_clk_dc, &ls1c_clk_pll.hw, CLK_PLL_DIV,
> > +                   24, 7, NULL, 4, 1, CLK_DIVIDER_ONE_BASED);
> > +static LS1X_CLK_DIV(ls1c_clk_ahb, &ls1c_clk_cpu.hw, CLK_PLL_FREQ,
> > +                   0, 2, ls1c_ahb_div_table, 0, 0, CLK_DIVIDER_ALLOW_Z=
ERO);
> > +static CLK_FIXED_FACTOR(ls1c_clk_apb, "ls1c_clk_apb", "ls1c_clk_ahb", =
1, 1,
> > +                       CLK_SET_RATE_PARENT);
> > +
> > +static struct clk_hw_onecell_data ls1c_clk_hw_data =3D {
> > +       .hws =3D {
> > +               [LS1X_CLKID_PLL] =3D &ls1c_clk_pll.hw,
> > +               [LS1X_CLKID_CPU] =3D &ls1c_clk_cpu.hw,
> > +               [LS1X_CLKID_DC] =3D &ls1c_clk_dc.hw,
> > +               [LS1X_CLKID_AHB] =3D &ls1c_clk_ahb.hw,
> > +               [LS1X_CLKID_APB] =3D &ls1c_clk_apb.hw,
> > +               [CLK_NR_CLKS] =3D NULL,
> > +       },
> > +       .num =3D CLK_NR_CLKS,
> > +};
> > +
> > +static void __init ls1x_clk_init(struct device_node *np,
> > +                                struct clk_hw_onecell_data *hw_data)
> > +{
> > +       struct ls1x_clk *ls1x_clk;
> > +       void __iomem *reg;
> > +       int i, ret;
> > +
> > +       reg =3D of_iomap(np, 0);
> > +       if (!reg) {
> > +               pr_err("Unable to map base for %pOF\n", np);
>
> Needs include.
>
Will do.

> > +               return;
> > +       }
> > +
> > +       for (i =3D 0; i < CLK_NR_CLKS; i++) {
> > +               /* array might be sparse */
> > +               if (!hw_data->hws[i])
> > +                       continue;
> > +
> > +               if (i !=3D LS1X_CLKID_APB) {
> > +                       ls1x_clk =3D to_ls1x_clk(hw_data->hws[i]);
> > +                       ls1x_clk->reg =3D reg + ls1x_clk->offset;
> > +               }
> > +
> > +               ret =3D of_clk_hw_register(np, hw_data->hws[i]);
> > +               if (ret)
> > +                       return;
>
> unmap memory on failure? and unregister clks?
>
Will add the error handling.

> > +       }
> > +
> > +       ret =3D of_clk_add_hw_provider(np, of_clk_hw_onecell_get, hw_da=
ta);
> > +       if (ret)
> > +               pr_err("Failed to register %pOF\n", np);
>
> unmap memory on failure? And unregister clks?
>
Will add the error handling.

> > +}
> > +
> > +static void __init ls1b_clk_init(struct device_node *np)
> > +{
> > +       return ls1x_clk_init(np, &ls1b_clk_hw_data);
> > +}
> > +
> > +static void __init ls1c_clk_init(struct device_node *np)
> > +{
> > +       return ls1x_clk_init(np, &ls1c_clk_hw_data);
> > +}
> > +
> > +CLK_OF_DECLARE(ls1b_clk, "loongson,ls1b-clk", ls1b_clk_init);
> > +CLK_OF_DECLARE(ls1c_clk, "loongson,ls1c-clk", ls1c_clk_init);
>
> Any reason these can't be platform device drivers?
>
The Loongson1 system uses performance counter as the default clocksource.
Then, mips_hpt_frequency should be figured out when doing plat_time_init(),
just before calling mips_clockevent_init() and init_mips_clocksource().
And mips_hpt_frequency depends on CPU clock.
So these clocks should be initialized as early as possible.
It's too late for being a platform device driver.

> > +
> > +MODULE_AUTHOR("Keguang Zhang <keguang.zhang@gmail.com>");
> > +MODULE_DESCRIPTION("Loongson1 clock driver");
>
> It's not a module. So these are useless macros. Drop them?

Yes. I realized these macros will never be called.
Will drop.


--
Best regards,

Keguang Zhang
