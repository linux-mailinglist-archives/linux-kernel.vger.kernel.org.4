Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B75970BED9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 14:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbjEVM4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 08:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233823AbjEVM4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 08:56:47 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D4CCF;
        Mon, 22 May 2023 05:56:38 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2af28a07be9so35113191fa.2;
        Mon, 22 May 2023 05:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684760197; x=1687352197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+GYlLF8M5ndZd2+dRVCSZH+svFwNkdCSphj2du53i8=;
        b=n0EYyZBaW8m3nfbhLA+mIrRrtFPGcrVmDBwB9bVtl4rRjuMi4Hb4GOvRgPXmL4G2z9
         c3wOteL7VhBLKGT3EUPrtOjKD3s84QjZAx72279PcxNwPSSu6kkEw7K+kJXdqx35CYa8
         fxOska5CtYhNLvH2EsIaZk4f6n24jozv3twyQbcaNKGz8rlFSSKF+GOu/0NyG3rzagW9
         u5V7vvhnEsQ2bCXY0R5i3VH+a7zteecrYb5JAJRk4GgeBsGTR5DstFj5GHqf4y5OlPXo
         4GPgEBmY/nayOvnhFUg1ZpgBsgdj4D602gnq/X7aTUP+2H9JV+Nz6YEOtHE4E2Wqb7kr
         0IMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684760197; x=1687352197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+GYlLF8M5ndZd2+dRVCSZH+svFwNkdCSphj2du53i8=;
        b=kjontuKqULMVXYDI0O9Mi6sqaEwRZj5v1qVoq7oLbAjGQq0sPJAXpOkCRB5g9LV2TG
         0U8aVXskKRVgjirrU6j/t+oWr1SIkqvDVHCoTerBsStW5+GFsqkBOZRtuN8P41An2Mih
         pnOauiCNEqwBL8sKLHAX3myXOs8E6aN4sn6xntuTFrfVx+vIMIGDG4bNi3iK4MPGuVMU
         sW9WJCWXeyE5Y8oyUzyFTzPvwkHIvCb4AbVlrPm5RWPsP1877L0Lcs1agCgVcrhkKFYS
         eOcGdom84NHeNYGY9tRW9G/RkR44syz2bJSSrn2w8lXJ6DnIjmsKubs6WEdAWs8v3MeZ
         QJpg==
X-Gm-Message-State: AC+VfDw9gOW8y3dmiJ8rW19/XFNAWq9jBPSXbnnRW64XBWMIs6YvWEWo
        dideSKBKHL3Xnz/Ac2XmiEApdViKoz4c+WL4u9M=
X-Google-Smtp-Source: ACHHUZ5r0BpnptaykOrD89cm4no6z5gijv+42UzxdyPw9VjB0u6KjtNWl1mpwxBlGLvrGWOvBfrkTvZAp3gJ8kasqiw=
X-Received: by 2002:a2e:9949:0:b0:2a8:e515:5770 with SMTP id
 r9-20020a2e9949000000b002a8e5155770mr4251112ljj.31.1684760196626; Mon, 22 May
 2023 05:56:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230521143202.155399-1-tmaimon77@gmail.com> <20230521143202.155399-2-tmaimon77@gmail.com>
 <0e72c35f-5d9d-45a7-5f85-3971b8029106@wanadoo.fr>
In-Reply-To: <0e72c35f-5d9d-45a7-5f85-3971b8029106@wanadoo.fr>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Mon, 22 May 2023 15:56:25 +0300
Message-ID: <CAP6Zq1jOSKpzFvto1LMs=JftLK0fxrrg+73Sh34GunuLfcAfEA@mail.gmail.com>
Subject: Re: [PATCH v16 1/1] clk: npcm8xx: add clock controller
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com,
        openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

Thanks for your comments

On Sun, 21 May 2023 at 20:21, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 21/05/2023 =C3=A0 16:32, Tomer Maimon a =C3=A9crit :
> > Nuvoton Arbel BMC NPCM8XX contains an integrated clock controller which
> > generates and supplies clocks to all modules within the BMC.
> >
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
>
> Hi,
>
> should there be a v17, below a few nits and questions.
Let's wait for Stephen and see if he has other comments.
>
> Jusrt my 2c,
>
> > ---
> >   drivers/clk/Kconfig       |   8 +
> >   drivers/clk/Makefile      |   1 +
> >   drivers/clk/clk-npcm8xx.c | 566 +++++++++++++++++++++++++++++++++++++=
+
> >   3 files changed, 575 insertions(+)
> >   create mode 100644 drivers/clk/clk-npcm8xx.c
> >
> > diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> > index 016814e15536..2249de28a46a 100644
> > --- a/drivers/clk/Kconfig
> > +++ b/drivers/clk/Kconfig
> > @@ -325,6 +325,14 @@ config COMMON_CLK_LOCHNAGAR
> >         This driver supports the clocking features of the Cirrus Logic
> >         Lochnagar audio development board.
> >
> > +config COMMON_CLK_NPCM8XX
> > +     tristate "Clock driver for the NPCM8XX SoC Family"
> > +     depends on ARCH_NPCM || COMPILE_TEST
> > +     help
> > +       This driver supports the clocks on the Nuvoton BMC NPCM8XX SoC =
Family,
> > +       all the clocks are initialized by the bootloader, so this drive=
r
> > +       allows only reading of current settings directly from the hardw=
are.
> > +
> >   config COMMON_CLK_LOONGSON2
> >       bool "Clock driver for Loongson-2 SoC"
> >       depends on LOONGARCH || COMPILE_TEST
> > diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> > index 0aebef17edc6..88713cbfbab5 100644
> > --- a/drivers/clk/Makefile
> > +++ b/drivers/clk/Makefile
> > @@ -51,6 +51,7 @@ obj-$(CONFIG_ARCH_MILBEAUT_M10V)    +=3D clk-milbeaut=
.o
> >   obj-$(CONFIG_ARCH_MOXART)           +=3D clk-moxart.o
> >   obj-$(CONFIG_ARCH_NOMADIK)          +=3D clk-nomadik.o
> >   obj-$(CONFIG_ARCH_NPCM7XX)          +=3D clk-npcm7xx.o
> > +obj-$(CONFIG_COMMON_CLK_NPCM8XX)     +=3D clk-npcm8xx.o
> >   obj-$(CONFIG_ARCH_NSPIRE)           +=3D clk-nspire.o
> >   obj-$(CONFIG_COMMON_CLK_OXNAS)              +=3D clk-oxnas.o
> >   obj-$(CONFIG_COMMON_CLK_PALMAS)             +=3D clk-palmas.o
> > diff --git a/drivers/clk/clk-npcm8xx.c b/drivers/clk/clk-npcm8xx.c
> > new file mode 100644
> > index 000000000000..9e6ed073d124
> > --- /dev/null
> > +++ b/drivers/clk/clk-npcm8xx.c
> > @@ -0,0 +1,566 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Nuvoton NPCM8xx Clock Generator
> > + * All the clocks are initialized by the bootloader, so this driver al=
low only
>
> nit: allows (as in Kconfig)
will modify in V17
>
> [...]
>
> > +/* npcm8xx clock registers*/
> > +#define NPCM8XX_CLKSEL          (0x04)
> > +#define NPCM8XX_CLKDIV1         (0x08)
> > +#define NPCM8XX_CLKDIV2         (0x2C)
> > +#define NPCM8XX_CLKDIV3         (0x58)
> > +#define NPCM8XX_CLKDIV4         (0x7C)
> > +#define NPCM8XX_PLLCON0         (0x0C)
> > +#define NPCM8XX_PLLCON1         (0x10)
> > +#define NPCM8XX_PLLCON2         (0x54)
> > +#define NPCM8XX_PLLCONG         (0x60)
> > +#define NPCM8XX_THRTL_CNT       (0xC0)
>
> nit: () around this values looks superfluous.
I am not sure, it can work both ways.
>
> > +
> > +#define PLLCON_LOKI  BIT(31)
> > +#define PLLCON_LOKS  BIT(30)
>
> [...]
>
> > +static struct clk_hw *
> > +npcm8xx_clk_register_pll(struct device *dev, void __iomem *pllcon,
> > +                      const char *name, const struct clk_parent_data *=
parent,
> > +                      unsigned long flags)
> > +{
> > +     struct npcm8xx_clk_pll *pll;
> > +     struct clk_init_data init =3D {};
> > +     int ret;
> > +
> > +     pll =3D kzalloc(sizeof(*pll), GFP_KERNEL);
>
> Everything looks devm_()'ed in this driver, except this kzalloc.
> Except the one below, there is no kfree to free this memory, and no
> .remove() function.
Also  clk_hw_register_divider_parent_data doesn't use devm_
about free the pll, we use it, return at the end of the function.
about adding remove, we had a dissection about it in V4, since the
clock is a service driver it shouldn't be removed.
https://patchwork.kernel.org/project/linux-watchdog/patch/20220621131424.16=
2355-7-tmaimon77@gmail.com/
>
> Is it on purpose?
>
> > +     if (!pll)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     init.name =3D name;
> > +     init.ops =3D &npcm8xx_clk_pll_ops;
> > +     init.parent_data =3D parent;
> > +     init.num_parents =3D 1;
> > +     init.flags =3D flags;
> > +
> > +     pll->pllcon =3D pllcon;
> > +     pll->hw.init =3D &init;
> > +
> > +     ret =3D devm_clk_hw_register(dev, &pll->hw);
> > +     if (ret) {
> > +             kfree(pll);
> > +             return ERR_PTR(ret);
> > +     }
> > +
> > +     return &pll->hw;
> > +}
> > +
> > +static DEFINE_SPINLOCK(npcm8xx_clk_lock);
> > +
> > +static int npcm8xx_clk_probe(struct platform_device *pdev)
> > +{
> > +     struct clk_hw_onecell_data *npcm8xx_clk_data;
> > +     struct device *dev =3D &pdev->dev;
> > +     void __iomem *clk_base;
> > +     struct resource *res;
> > +     struct clk_hw *hw;
> > +     unsigned int i;
> > +     int err;
> > +
> > +     npcm8xx_clk_data =3D devm_kzalloc(dev, struct_size(npcm8xx_clk_da=
ta, hws,
> > +                                                      NPCM8XX_NUM_CLOC=
KS),
> > +                                     GFP_KERNEL);
> > +     if (!npcm8xx_clk_data)
> > +             return -ENOMEM;
> > +
> > +     res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +     clk_base =3D devm_ioremap(dev, res->start, resource_size(res));
> > +     if (!clk_base) {
> > +             dev_err(&pdev->dev, "Failed to remap I/O memory\n");
>
> Here and below: mostly a matter of taste, but usually return
> dev_err_probe() saves a few LoC and keep the error code in the error
> message.
Thanks, but  I prefer the shorter way :-)
>
> > +             return -ENOMEM;
> > +     }
> > +
> > +     npcm8xx_clk_data->num =3D NPCM8XX_NUM_CLOCKS;
> > +
> > +     for (i =3D 0; i < NPCM8XX_NUM_CLOCKS; i++)
> > +             npcm8xx_clk_data->hws[i] =3D ERR_PTR(-EPROBE_DEFER);
> > +
> > +     /* Register plls */
> > +     for (i =3D 0; i < ARRAY_SIZE(npcm8xx_pll_clks); i++) {
> > +             struct npcm8xx_pll_data *pll_clk =3D &npcm8xx_pll_clks[i]=
;
> > +
> > +             hw =3D npcm8xx_clk_register_pll(dev, clk_base + pll_clk->=
reg,
> > +                                           pll_clk->name, &pll_clk->pa=
rent,
> > +                                           pll_clk->flags);
> > +             if (IS_ERR(hw)) {
> > +                     dev_err(dev, "npcm8xx_clk: Can't register pll\n")=
;
> > +                     return PTR_ERR(hw);
> > +             }
> > +             pll_clk->hw =3D *hw;
> > +     }
> > +
> > +     /* Register fixed dividers */
> > +     hw =3D devm_clk_hw_register_fixed_factor(dev, NPCM8XX_CLK_S_PLL1_=
DIV2,
> > +                                            NPCM8XX_CLK_S_PLL1, 0, 1, =
2);
> > +     if (IS_ERR(hw)) {
> > +             dev_err(dev, "npcm8xx_clk: Can't register fixed div\n");
> > +             return PTR_ERR(hw);
> > +     }
> > +     hw_pll1_div2 =3D *hw;
> > +
> > +     hw =3D devm_clk_hw_register_fixed_factor(dev, NPCM8XX_CLK_S_PLL2_=
DIV2,
> > +                                            NPCM8XX_CLK_S_PLL2, 0, 1, =
2);
> > +     if (IS_ERR(hw)) {
> > +             dev_err(dev, "npcm8xx_clk: Can't register pll2 div2\n");
> > +             return PTR_ERR(hw);
> > +     }
> > +     hw_pll2_div2 =3D *hw;
> > +
> > +     hw =3D devm_clk_hw_register_fixed_factor(dev, NPCM8XX_CLK_S_PLL_G=
FX_DIV2,
> > +                                            NPCM8XX_CLK_S_PLL_GFX, 0, =
1, 2);
> > +     if (IS_ERR(hw)) {
> > +             dev_err(dev, "npcm8xx_clk: Can't register gfx div2\n");
> > +             return PTR_ERR(hw);
> > +     }
> > +     hw_gfx_div2 =3D *hw;
> > +
> > +     /* Register muxes */
> > +     for (i =3D 0; i < ARRAY_SIZE(npcm8xx_muxes); i++) {
> > +             struct npcm8xx_clk_mux_data *mux_data =3D &npcm8xx_muxes[=
i];
> > +
> > +             hw =3D devm_clk_hw_register_mux_parent_data_table(dev,
> > +                                                             mux_data-=
>name,
> > +                                                             mux_data-=
>parent_data,
> > +                                                             mux_data-=
>num_parents,
> > +                                                             mux_data-=
>flags,
> > +                                                             clk_base =
+ NPCM8XX_CLKSEL,
> > +                                                             mux_data-=
>shift,
> > +                                                             mux_data-=
>mask,
> > +                                                             0,
> > +                                                             mux_data-=
>table,
> > +                                                             &npcm8xx_=
clk_lock);
> > +             if (IS_ERR(hw)) {
> > +                     dev_err(dev, "npcm8xx_clk: Can't register mux\n")=
;
> > +                     return PTR_ERR(hw);
> > +             }
> > +             mux_data->hw =3D *hw;
> > +     }
> > +
> > +     hw =3D devm_clk_hw_register_fixed_factor(dev, NPCM8XX_CLK_S_PRE_C=
LK,
> > +                                            NPCM8XX_CLK_S_CPU_MUX, 0, =
1, 2);
> > +     if (IS_ERR(hw)) {
> > +             dev_err(dev, "npcm8xx_clk: Can't register ckclk div2\n");
>
> ckclk or just clk?
will modify in V17
>
> Based on naming only, this div2 (here and below) looks strange.
> Is it on purpose, on just a cut'n'paste  from the previous message?
>
> > +             return PTR_ERR(hw);
> > +     }
> > +     hw_pre_clk =3D *hw;
> > +
> > +     hw =3D devm_clk_hw_register_fixed_factor(dev, NPCM8XX_CLK_S_AXI,
> > +                                            NPCM8XX_CLK_S_TH, 0, 1, 2)=
;
> > +     if (IS_ERR(hw)) {
> > +             dev_err(dev, "npcm8xx_clk: Can't register axi div2\n");
> > +             return PTR_ERR(hw);
> > +     }
> > +     npcm8xx_clk_data->hws[NPCM8XX_CLK_AXI] =3D hw;
> > +
> > +     hw =3D devm_clk_hw_register_fixed_factor(dev, NPCM8XX_CLK_S_ATB,
> > +                                            NPCM8XX_CLK_S_AXI, 0, 1, 2=
);
> > +     if (IS_ERR(hw)) {
> > +             dev_err(dev, "npcm8xx_clk: Can't register atb div2\n");
> > +             return PTR_ERR(hw);
> > +     }
> > +     npcm8xx_clk_data->hws[NPCM8XX_CLK_ATB] =3D hw;
> > +
> > +     /* Register clock dividers specified in npcm8xx_divs */
> > +     for (i =3D 0; i < ARRAY_SIZE(npcm8xx_divs); i++) {
> > +             const struct npcm8xx_clk_div_data *div_data =3D &npcm8xx_=
divs[i];
> > +
> > +             hw =3D clk_hw_register_divider_parent_data(dev, div_data-=
>name,
> > +                                                      &div_data->paren=
t_data,
> > +                                                      div_data->flags,
> > +                                                      clk_base + div_d=
ata->reg,
> > +                                                      div_data->shift,
> > +                                                      div_data->width,
> > +                                                      div_data->clk_di=
vider_flags,
> > +                                                      &npcm8xx_clk_loc=
k);
> > +             if (IS_ERR(hw)) {
> > +                     dev_err(dev, "npcm8xx_clk: Can't register div tab=
le\n");
> > +                     goto err_div_clk;
> > +             }
> > +
> > +             if (div_data->onecell_idx >=3D 0)
> > +                     npcm8xx_clk_data->hws[div_data->onecell_idx] =3D =
hw;
> > +     }
> > +
> > +     err =3D devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
> > +                                       npcm8xx_clk_data);
> > +     if (err) {
> > +             dev_err(dev, "unable to add clk provider\n");
> > +             hw =3D ERR_PTR(err);
> > +             goto err_div_clk;
> > +     }
> > +
> > +     return err;
> > +
> > +err_div_clk:
> > +     while (i--) {
> > +             if (npcm8xx_divs[i].onecell_idx >=3D 0)
> > +                     clk_hw_unregister_divider(npcm8xx_clk_data->hws[n=
pcm8xx_divs[i].onecell_idx]);
> > +     }
>
> There is an error handling path in the probe, but no .remove() function.
> Should there be one?
The same answer as above (V4)
>
> CJ
>
> [...]

Best regards,

Tomer
