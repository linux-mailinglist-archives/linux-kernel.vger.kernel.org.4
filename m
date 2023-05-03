Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836C86F58E2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 15:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjECNUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 09:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjECNUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 09:20:15 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BB84EEB
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 06:20:13 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-55a8e9e2c53so22893687b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 06:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683120013; x=1685712013;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Opd/oR8viia5VPs8Xl5i1DyX6T1epNpYDo1zdgCBXDc=;
        b=qZvohlHzIKraglynHWZOMX5g47MxnWb+FhWRzUxSCLFQD2wSjW6fo5TzWI2pyR7Sw1
         or4b5vC2GW4KaP7s5KJu7CehqcCzaWaWH38jm90DnI69eoBBShh0ycgbS3C1YXgDRsgM
         fDSzLTVlZ2Hu1Qaosw3PB44L0l0QFqp0/ShbWaO7WYAoYpFOhq6qD41nmE/OdaL0zKTu
         hzGcIWfeuNDDhEAujBO9xAwTygjhAlz2Poh7s+rdCU6xUlPc6aetxk9isPapoHMhIS4n
         OGLySTQ82JG7RW9e4k7Uj6uvvSq7T5BgMGwwJwzq/5NcaukzaWtIrCYxwkdvE1iumvIC
         KPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683120013; x=1685712013;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Opd/oR8viia5VPs8Xl5i1DyX6T1epNpYDo1zdgCBXDc=;
        b=DMt80SgXot+WmpuSsGyLV4RvASELo64ZUYFEEDw70VcHDujoInpRJM2HGfWVPnHOBl
         YwWUoxpNvZamwghUYPFjIRS3KMv3ct5dh0kI9naHTil+0Lg1J6049W9ud1phK5FVFq0b
         6J2rocgkHMWuyD8FdvOSe6/L/PotWLkmA6Hozu8OUI7rhhkn5GHTamTVl4a1rKFyAcK5
         aiyRvDVbUCt7GFuLyKd5ZApyHaHky40wa9uQKOzMYTexEWKZpAzBYwgmGhC7ZUyuavPj
         pBXFVU24+ODaIF0dEi9rVazegBaRq673e2DdWcv2OXxnAtkAbUDC3bgOJS3TK/jbTGGC
         jZsg==
X-Gm-Message-State: AC+VfDx3oCIcGXcsNBycjfU9eQFUi3h5lzL+P6+/HscVUoGyuaZuZcvd
        DYmSBcaOwP1k6S+WQ8LIbg2awV6602+bvR1V/G7uNg==
X-Google-Smtp-Source: ACHHUZ4Tv7ns695zLV5yVmaCyxReLMj17hGLfWpc85Ikv9dUpiQwgHfUe7sINnorEy7ezExObt7EGyS/feC3gV0vhhM=
X-Received: by 2002:a0d:e347:0:b0:54f:752e:9b63 with SMTP id
 m68-20020a0de347000000b0054f752e9b63mr18897395ywe.15.1683120011594; Wed, 03
 May 2023 06:20:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230503130051.144708-1-y.oudjana@protonmail.com> <20230503130051.144708-4-y.oudjana@protonmail.com>
In-Reply-To: <20230503130051.144708-4-y.oudjana@protonmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 3 May 2023 16:20:00 +0300
Message-ID: <CAA8EJpokUqHRQz=RJnJpvFzCzz+=5TepPraQGvCvjqFL9+GX7w@mail.gmail.com>
Subject: Re: [PATCH RESEND 3/3] clk: qcom: cbf-msm8996: Add support for
 MSM8996 Pro
To:     Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 May 2023 at 16:02, Yassine Oudjana <yassine.oudjana@gmail.com> wrote:
>
> From: Yassine Oudjana <y.oudjana@protonmail.com>
>
> The CBF PLL on MSM8996 Pro has a /4 post divisor instead of /2. Handle the
> difference accordingly.
>
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  drivers/clk/qcom/clk-cbf-8996.c | 121 ++++++++++++++++++++++++++++----
>  1 file changed, 106 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/clk/qcom/clk-cbf-8996.c b/drivers/clk/qcom/clk-cbf-8996.c
> index 1bb2cd956d68..a3e96578ddd9 100644
> --- a/drivers/clk/qcom/clk-cbf-8996.c
> +++ b/drivers/clk/qcom/clk-cbf-8996.c
> @@ -65,6 +65,19 @@ static const struct alpha_pll_config cbfpll_config = {
>         .early_output_mask = BIT(3),
>  };
>
> +static const struct alpha_pll_config cbfpll_pro_config = {
> +       .l = 72,
> +       .config_ctl_val = 0x200d4828,
> +       .config_ctl_hi_val = 0x006,
> +       .test_ctl_val = 0x1c000000,
> +       .test_ctl_hi_val = 0x00004000,
> +       .pre_div_mask = BIT(12),
> +       .post_div_mask = 0x3 << 8,
> +       .post_div_val = 0x3 << 8,
> +       .main_output_mask = BIT(0),
> +       .early_output_mask = BIT(3),
> +};

Granted that the difference between this and the non-pro is just the
post_div_val, would it be easier to just patch it in the probe()?

> +
>  static struct clk_alpha_pll cbf_pll = {
>         .offset = CBF_PLL_OFFSET,
>         .regs = cbf_pll_regs,
> @@ -93,6 +106,20 @@ static struct clk_fixed_factor cbf_pll_postdiv = {
>         },
>  };
>
> +static struct clk_fixed_factor cbf_pro_pll_postdiv = {
> +       .mult = 1,
> +       .div = 4,
> +       .hw.init = &(struct clk_init_data){
> +               .name = "cbf_pll_postdiv",
> +               .parent_hws = (const struct clk_hw*[]){
> +                       &cbf_pll.clkr.hw
> +               },
> +               .num_parents = 1,
> +               .ops = &clk_fixed_factor_ops,
> +               .flags = CLK_SET_RATE_PARENT,
> +       },
> +};

Same question here.

Then we can get rid of all the duplication below.

> +
>  static const struct clk_parent_data cbf_mux_parent_data[] = {
>         { .index = DT_XO },
>         { .hw = &cbf_pll.clkr.hw },
> @@ -100,6 +127,13 @@ static const struct clk_parent_data cbf_mux_parent_data[] = {
>         { .index = DT_APCS_AUX },
>  };
>
> +static const struct clk_parent_data cbf_pro_mux_parent_data[] = {
> +       { .index = DT_XO },
> +       { .hw = &cbf_pll.clkr.hw },
> +       { .hw = &cbf_pro_pll_postdiv.hw },
> +       { .index = DT_APCS_AUX },
> +};
> +
>  struct clk_cbf_8996_mux {
>         u32 reg;
>         struct notifier_block nb;
> @@ -140,12 +174,14 @@ static int clk_cbf_8996_mux_determine_rate(struct clk_hw *hw,
>                                            struct clk_rate_request *req)
>  {
>         struct clk_hw *parent;
> +       struct clk_hw *post_div_hw = clk_hw_get_parent_by_index(hw, CBF_DIV_INDEX);
> +       struct clk_fixed_factor *post_div = to_clk_fixed_factor(post_div_hw);
>
> -       if (req->rate < (DIV_THRESHOLD / 2))
> +       if (req->rate < (DIV_THRESHOLD / post_div->div))
>                 return -EINVAL;
>
>         if (req->rate < DIV_THRESHOLD)
> -               parent = clk_hw_get_parent_by_index(hw, CBF_DIV_INDEX);
> +               parent = post_div_hw;
>         else
>                 parent = clk_hw_get_parent_by_index(hw, CBF_PLL_INDEX);
>
> @@ -177,10 +213,24 @@ static struct clk_cbf_8996_mux cbf_mux = {
>         },
>  };
>
> +static struct clk_cbf_8996_mux cbf_pro_mux = {
> +       .reg = CBF_MUX_OFFSET,
> +       .nb.notifier_call = cbf_clk_notifier_cb,
> +       .clkr.hw.init = &(struct clk_init_data) {
> +               .name = "cbf_mux",
> +               .parent_data = cbf_pro_mux_parent_data,
> +               .num_parents = ARRAY_SIZE(cbf_pro_mux_parent_data),
> +               .ops = &clk_cbf_8996_mux_ops,
> +               /* CPU clock is critical and should never be gated */
> +               .flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
> +       },
> +};
> +
>  static int cbf_clk_notifier_cb(struct notifier_block *nb, unsigned long event,
>                                void *data)
>  {
>         struct clk_notifier_data *cnd = data;
> +       struct clk_hw *hw = __clk_get_hw(cnd->clk);
>
>         switch (event) {
>         case PRE_RATE_CHANGE:
> @@ -188,19 +238,19 @@ static int cbf_clk_notifier_cb(struct notifier_block *nb, unsigned long event,
>                  * Avoid overvolting. clk_core_set_rate_nolock() walks from top
>                  * to bottom, so it will change the rate of the PLL before
>                  * chaging the parent of PMUX. This can result in pmux getting
> -                * clocked twice the expected rate.
> +                * clocked twice (or 4 times) the expected rate.
>                  *
> -                * Manually switch to PLL/2 here.
> +                * Manually switch to PLL/DIV here.
>                  */
>                 if (cnd->old_rate > DIV_THRESHOLD &&
>                     cnd->new_rate < DIV_THRESHOLD)
> -                       clk_cbf_8996_mux_set_parent(&cbf_mux.clkr.hw, CBF_DIV_INDEX);
> +                       clk_cbf_8996_mux_set_parent(hw, CBF_DIV_INDEX);
>                 break;
>         case ABORT_RATE_CHANGE:
>                 /* Revert manual change */
>                 if (cnd->new_rate < DIV_THRESHOLD &&
>                     cnd->old_rate > DIV_THRESHOLD)
> -                       clk_cbf_8996_mux_set_parent(&cbf_mux.clkr.hw, CBF_PLL_INDEX);
> +                       clk_cbf_8996_mux_set_parent(hw, CBF_PLL_INDEX);
>                 break;
>         default:
>                 break;
> @@ -213,11 +263,50 @@ static struct clk_hw *cbf_msm8996_hw_clks[] = {
>         &cbf_pll_postdiv.hw,
>  };
>
> +static struct clk_hw *cbf_msm8996pro_hw_clks[] = {
> +       &cbf_pro_pll_postdiv.hw,
> +};
> +
>  static struct clk_regmap *cbf_msm8996_clks[] = {
>         &cbf_pll.clkr,
>         &cbf_mux.clkr,
>  };
>
> +static struct clk_regmap *cbf_msm8996pro_clks[] = {
> +       &cbf_pll.clkr,
> +       &cbf_pro_mux.clkr,
> +};
> +
> +struct cbf_match_data {
> +       const struct alpha_pll_config *config;
> +       struct clk_fixed_factor *cbf_pll_postdiv;
> +       struct clk_cbf_8996_mux *cbf_mux;
> +       struct clk_hw **hw_clks;
> +       size_t nr_hw_clks;
> +       struct clk_regmap **clks;
> +       size_t nr_clks;
> +};
> +
> +static const struct cbf_match_data cbf_msm8996_match_data = {
> +       .config = &cbfpll_config,
> +       .cbf_pll_postdiv = &cbf_pll_postdiv,
> +       .cbf_mux = &cbf_mux,
> +       .hw_clks = cbf_msm8996_hw_clks,
> +       .nr_hw_clks = ARRAY_SIZE(cbf_msm8996_hw_clks),
> +       .clks = cbf_msm8996_clks,
> +       .nr_clks = ARRAY_SIZE(cbf_msm8996_clks)
> +};
> +
> +static const struct cbf_match_data cbf_msm8996pro_match_data = {
> +       .config = &cbfpll_pro_config,
> +       .cbf_pll_postdiv = &cbf_pro_pll_postdiv,
> +       .cbf_mux = &cbf_pro_mux,
> +       .hw_clks = cbf_msm8996pro_hw_clks,
> +       .nr_hw_clks = ARRAY_SIZE(cbf_msm8996pro_hw_clks),
> +       .clks = cbf_msm8996pro_clks,
> +       .nr_clks = ARRAY_SIZE(cbf_msm8996pro_clks)
> +};
> +
>  static const struct regmap_config cbf_msm8996_regmap_config = {
>         .reg_bits               = 32,
>         .reg_stride             = 4,
> @@ -274,6 +363,7 @@ static int qcom_msm8996_cbf_probe(struct platform_device *pdev)
>         void __iomem *base;
>         struct regmap *regmap;
>         struct device *dev = &pdev->dev;
> +       const struct cbf_match_data *data = of_device_get_match_data(dev);
>         int i, ret;
>
>         base = devm_platform_ioremap_resource(pdev, 0);
> @@ -295,7 +385,7 @@ static int qcom_msm8996_cbf_probe(struct platform_device *pdev)
>                            CBF_MUX_AUTO_CLK_SEL_ALWAYS_ON_MASK,
>                            CBF_MUX_AUTO_CLK_SEL_ALWAYS_ON_GPLL0_SEL);
>
> -       clk_alpha_pll_configure(&cbf_pll, regmap, &cbfpll_config);
> +       clk_alpha_pll_configure(&cbf_pll, regmap, data->config);
>
>         /* Wait for PLL(s) to lock */
>         udelay(50);
> @@ -311,27 +401,27 @@ static int qcom_msm8996_cbf_probe(struct platform_device *pdev)
>         /* Switch CBF to use the primary PLL */
>         regmap_update_bits(regmap, CBF_MUX_OFFSET, CBF_MUX_PARENT_MASK, 0x1);
>
> -       for (i = 0; i < ARRAY_SIZE(cbf_msm8996_hw_clks); i++) {
> -               ret = devm_clk_hw_register(dev, cbf_msm8996_hw_clks[i]);
> +       for (i = 0; i < data->nr_hw_clks; i++) {
> +               ret = devm_clk_hw_register(dev, data->hw_clks[i]);
>                 if (ret)
>                         return ret;
>         }
>
> -       for (i = 0; i < ARRAY_SIZE(cbf_msm8996_clks); i++) {
> -               ret = devm_clk_register_regmap(dev, cbf_msm8996_clks[i]);
> +       for (i = 0; i < data->nr_clks; i++) {
> +               ret = devm_clk_register_regmap(dev, data->clks[i]);
>                 if (ret)
>                         return ret;
>         }
>
> -       ret = devm_clk_notifier_register(dev, cbf_mux.clkr.hw.clk, &cbf_mux.nb);
> +       ret = devm_clk_notifier_register(dev, data->cbf_mux->clkr.hw.clk, &data->cbf_mux->nb);
>         if (ret)
>                 return ret;
>
> -       ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, &cbf_mux.clkr.hw);
> +       ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, &data->cbf_mux->clkr.hw);
>         if (ret)
>                 return ret;
>
> -       return qcom_msm8996_cbf_icc_register(pdev, &cbf_mux.clkr.hw);
> +       return qcom_msm8996_cbf_icc_register(pdev, &data->cbf_mux->clkr.hw);
>  }
>
>  static int qcom_msm8996_cbf_remove(struct platform_device *pdev)
> @@ -340,7 +430,8 @@ static int qcom_msm8996_cbf_remove(struct platform_device *pdev)
>  }
>
>  static const struct of_device_id qcom_msm8996_cbf_match_table[] = {
> -       { .compatible = "qcom,msm8996-cbf" },
> +       { .compatible = "qcom,msm8996-cbf", .data = &cbf_msm8996_match_data },
> +       { .compatible = "qcom,msm8996pro-cbf", .data = &cbf_msm8996pro_match_data },
>         { /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, qcom_msm8996_cbf_match_table);
> --
> 2.40.0
>


-- 
With best wishes
Dmitry
