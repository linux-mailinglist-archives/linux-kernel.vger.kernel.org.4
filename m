Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0BC70C4A3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 19:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbjEVRtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 13:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbjEVRte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 13:49:34 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DBFFF;
        Mon, 22 May 2023 10:49:28 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-96f7377c86aso680261766b.1;
        Mon, 22 May 2023 10:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684777767; x=1687369767;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D+kjlatvk2NjGA3U8kDyYLneyPBcXG2N41V5auMXm58=;
        b=mdJMTOqlqsuoRImDikLf0bi24lPQ17jTvL77MWSGm7tUyq25L2J5l2f3IpO9QOSXug
         f8qSMg7Vz5ZS8+hTdyTLYE2YYn7CtCCtb5WKH9PnZ7vEr4Hr1B8xEf+By/8SaaKm7rH8
         pbsN1ZErir6dhOnyXCqpbsB2op7Osqi3M1NpJVywCvBwa6vpF0mVr/VdPiF+MnbKw+Ab
         QJcGjfdzIHfGr5z4bkJGDCpmSzOiZDxPznGfc2KnBkEdjL3jVzUNGlv+Ym9tNdz7lj8V
         bhWRiOi6UBaqUHyuxOH4WJjjKPmou+7mZ/Jl/JDtnITnOHE5u+NrGRFt4QJaX/fUoFeU
         RxZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684777767; x=1687369767;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D+kjlatvk2NjGA3U8kDyYLneyPBcXG2N41V5auMXm58=;
        b=JnAAnrDLIUZ00PKjaVYbYRFCq3LKLrbB5H49wvHXT591mfcXHl8ht+1th85A+BMZLD
         JTfvjy8kx9vOVr2T09PQCXbM0kUNeiCMFro47NcEbVbFf5P/jXEbLK5an+LpXtqVVbN8
         vVkKSK57FQGV+lOMAFDoff260ifkCdF01WvUSIexq6GQ0rXM2zVyS699uxPGhWrog/v1
         6oEINBte7FILwD01OO6OcOs4JTnKZeWbNstM2Qd1hM8xcEHErOh1pwd3KajVf3D9DE8c
         ow/AS5ifNxBNVwVrEPU2/FxO/9QDmVIrTkbsZt0l6UqNJ9FbZB2D6GuzC8OnyEoyXQyZ
         IBYw==
X-Gm-Message-State: AC+VfDwbwspxb2imgpL8jySooU6jhKyRgzz2qRsvd+tgfPiFqT1ntmIh
        ecntLqwsaXY9GP4+qzdaOLU=
X-Google-Smtp-Source: ACHHUZ6KDOxewQBNYqyLgSR9jF0sPmqe6ySpOg32WhuD10cOOo6KQL51Y8pTkSfscKJb5Q/TdBpFQQ==
X-Received: by 2002:a17:907:968c:b0:969:e55f:cca2 with SMTP id hd12-20020a170907968c00b00969e55fcca2mr13698063ejc.38.1684777766936;
        Mon, 22 May 2023 10:49:26 -0700 (PDT)
Received: from [192.168.205.64] ([95.183.227.33])
        by smtp.gmail.com with ESMTPSA id ot38-20020a170906cce600b00961277a426dsm3333146ejb.205.2023.05.22.10.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 10:49:26 -0700 (PDT)
Date:   Mon, 22 May 2023 20:49:17 +0300
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
Subject: Re: [PATCH RESEND 3/3] clk: qcom: cbf-msm8996: Add support for
 MSM8996 Pro
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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
Message-Id: <5UM2VR.7LLGW1RDW4G2@gmail.com>
In-Reply-To: <CAA8EJpokUqHRQz=RJnJpvFzCzz+=5TepPraQGvCvjqFL9+GX7w@mail.gmail.com>
References: <20230503130051.144708-1-y.oudjana@protonmail.com>
        <20230503130051.144708-4-y.oudjana@protonmail.com>
        <CAA8EJpokUqHRQz=RJnJpvFzCzz+=5TepPraQGvCvjqFL9+GX7w@mail.gmail.com>
X-Mailer: geary/43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, May 3 2023 at 04:20:00 PM +03:00:00, Dmitry Baryshkov 
<dmitry.baryshkov@linaro.org> wrote:
> On Wed, 3 May 2023 at 16:02, Yassine Oudjana 
> <yassine.oudjana@gmail.com> wrote:
>> 
>>  From: Yassine Oudjana <y.oudjana@protonmail.com>
>> 
>>  The CBF PLL on MSM8996 Pro has a /4 post divisor instead of /2. 
>> Handle the
>>  difference accordingly.
>> 
>>  Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
>>  ---
>>   drivers/clk/qcom/clk-cbf-8996.c | 121 
>> ++++++++++++++++++++++++++++----
>>   1 file changed, 106 insertions(+), 15 deletions(-)
>> 
>>  diff --git a/drivers/clk/qcom/clk-cbf-8996.c 
>> b/drivers/clk/qcom/clk-cbf-8996.c
>>  index 1bb2cd956d68..a3e96578ddd9 100644
>>  --- a/drivers/clk/qcom/clk-cbf-8996.c
>>  +++ b/drivers/clk/qcom/clk-cbf-8996.c
>>  @@ -65,6 +65,19 @@ static const struct alpha_pll_config 
>> cbfpll_config = {
>>          .early_output_mask = BIT(3),
>>   };
>> 
>>  +static const struct alpha_pll_config cbfpll_pro_config = {
>>  +       .l = 72,
>>  +       .config_ctl_val = 0x200d4828,
>>  +       .config_ctl_hi_val = 0x006,
>>  +       .test_ctl_val = 0x1c000000,
>>  +       .test_ctl_hi_val = 0x00004000,
>>  +       .pre_div_mask = BIT(12),
>>  +       .post_div_mask = 0x3 << 8,
>>  +       .post_div_val = 0x3 << 8,
>>  +       .main_output_mask = BIT(0),
>>  +       .early_output_mask = BIT(3),
>>  +};
> 
> Granted that the difference between this and the non-pro is just the
> post_div_val, would it be easier to just patch it in the probe()?

I wasn't sure if that approach would've been accepted since it relies 
on the special case that only one instance of the CBF device will exist 
in normal conditions, but if you say it's fine then sure, I can do that.

> 
>>  +
>>   static struct clk_alpha_pll cbf_pll = {
>>          .offset = CBF_PLL_OFFSET,
>>          .regs = cbf_pll_regs,
>>  @@ -93,6 +106,20 @@ static struct clk_fixed_factor cbf_pll_postdiv 
>> = {
>>          },
>>   };
>> 
>>  +static struct clk_fixed_factor cbf_pro_pll_postdiv = {
>>  +       .mult = 1,
>>  +       .div = 4,
>>  +       .hw.init = &(struct clk_init_data){
>>  +               .name = "cbf_pll_postdiv",
>>  +               .parent_hws = (const struct clk_hw*[]){
>>  +                       &cbf_pll.clkr.hw
>>  +               },
>>  +               .num_parents = 1,
>>  +               .ops = &clk_fixed_factor_ops,
>>  +               .flags = CLK_SET_RATE_PARENT,
>>  +       },
>>  +};
> 
> Same question here.
> 
> Then we can get rid of all the duplication below.
> 
>>  +
>>   static const struct clk_parent_data cbf_mux_parent_data[] = {
>>          { .index = DT_XO },
>>          { .hw = &cbf_pll.clkr.hw },
>>  @@ -100,6 +127,13 @@ static const struct clk_parent_data 
>> cbf_mux_parent_data[] = {
>>          { .index = DT_APCS_AUX },
>>   };
>> 
>>  +static const struct clk_parent_data cbf_pro_mux_parent_data[] = {
>>  +       { .index = DT_XO },
>>  +       { .hw = &cbf_pll.clkr.hw },
>>  +       { .hw = &cbf_pro_pll_postdiv.hw },
>>  +       { .index = DT_APCS_AUX },
>>  +};
>>  +
>>   struct clk_cbf_8996_mux {
>>          u32 reg;
>>          struct notifier_block nb;
>>  @@ -140,12 +174,14 @@ static int 
>> clk_cbf_8996_mux_determine_rate(struct clk_hw *hw,
>>                                             struct clk_rate_request 
>> *req)
>>   {
>>          struct clk_hw *parent;
>>  +       struct clk_hw *post_div_hw = clk_hw_get_parent_by_index(hw, 
>> CBF_DIV_INDEX);
>>  +       struct clk_fixed_factor *post_div = 
>> to_clk_fixed_factor(post_div_hw);
>> 
>>  -       if (req->rate < (DIV_THRESHOLD / 2))
>>  +       if (req->rate < (DIV_THRESHOLD / post_div->div))
>>                  return -EINVAL;
>> 
>>          if (req->rate < DIV_THRESHOLD)
>>  -               parent = clk_hw_get_parent_by_index(hw, 
>> CBF_DIV_INDEX);
>>  +               parent = post_div_hw;
>>          else
>>                  parent = clk_hw_get_parent_by_index(hw, 
>> CBF_PLL_INDEX);
>> 
>>  @@ -177,10 +213,24 @@ static struct clk_cbf_8996_mux cbf_mux = {
>>          },
>>   };
>> 
>>  +static struct clk_cbf_8996_mux cbf_pro_mux = {
>>  +       .reg = CBF_MUX_OFFSET,
>>  +       .nb.notifier_call = cbf_clk_notifier_cb,
>>  +       .clkr.hw.init = &(struct clk_init_data) {
>>  +               .name = "cbf_mux",
>>  +               .parent_data = cbf_pro_mux_parent_data,
>>  +               .num_parents = ARRAY_SIZE(cbf_pro_mux_parent_data),
>>  +               .ops = &clk_cbf_8996_mux_ops,
>>  +               /* CPU clock is critical and should never be gated 
>> */
>>  +               .flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
>>  +       },
>>  +};
>>  +
>>   static int cbf_clk_notifier_cb(struct notifier_block *nb, unsigned 
>> long event,
>>                                 void *data)
>>   {
>>          struct clk_notifier_data *cnd = data;
>>  +       struct clk_hw *hw = __clk_get_hw(cnd->clk);
>> 
>>          switch (event) {
>>          case PRE_RATE_CHANGE:
>>  @@ -188,19 +238,19 @@ static int cbf_clk_notifier_cb(struct 
>> notifier_block *nb, unsigned long event,
>>                   * Avoid overvolting. clk_core_set_rate_nolock() 
>> walks from top
>>                   * to bottom, so it will change the rate of the PLL 
>> before
>>                   * chaging the parent of PMUX. This can result in 
>> pmux getting
>>  -                * clocked twice the expected rate.
>>  +                * clocked twice (or 4 times) the expected rate.
>>                   *
>>  -                * Manually switch to PLL/2 here.
>>  +                * Manually switch to PLL/DIV here.
>>                   */
>>                  if (cnd->old_rate > DIV_THRESHOLD &&
>>                      cnd->new_rate < DIV_THRESHOLD)
>>  -                       
>> clk_cbf_8996_mux_set_parent(&cbf_mux.clkr.hw, CBF_DIV_INDEX);
>>  +                       clk_cbf_8996_mux_set_parent(hw, 
>> CBF_DIV_INDEX);
>>                  break;
>>          case ABORT_RATE_CHANGE:
>>                  /* Revert manual change */
>>                  if (cnd->new_rate < DIV_THRESHOLD &&
>>                      cnd->old_rate > DIV_THRESHOLD)
>>  -                       
>> clk_cbf_8996_mux_set_parent(&cbf_mux.clkr.hw, CBF_PLL_INDEX);
>>  +                       clk_cbf_8996_mux_set_parent(hw, 
>> CBF_PLL_INDEX);
>>                  break;
>>          default:
>>                  break;
>>  @@ -213,11 +263,50 @@ static struct clk_hw *cbf_msm8996_hw_clks[] = 
>> {
>>          &cbf_pll_postdiv.hw,
>>   };
>> 
>>  +static struct clk_hw *cbf_msm8996pro_hw_clks[] = {
>>  +       &cbf_pro_pll_postdiv.hw,
>>  +};
>>  +
>>   static struct clk_regmap *cbf_msm8996_clks[] = {
>>          &cbf_pll.clkr,
>>          &cbf_mux.clkr,
>>   };
>> 
>>  +static struct clk_regmap *cbf_msm8996pro_clks[] = {
>>  +       &cbf_pll.clkr,
>>  +       &cbf_pro_mux.clkr,
>>  +};
>>  +
>>  +struct cbf_match_data {
>>  +       const struct alpha_pll_config *config;
>>  +       struct clk_fixed_factor *cbf_pll_postdiv;
>>  +       struct clk_cbf_8996_mux *cbf_mux;
>>  +       struct clk_hw **hw_clks;
>>  +       size_t nr_hw_clks;
>>  +       struct clk_regmap **clks;
>>  +       size_t nr_clks;
>>  +};
>>  +
>>  +static const struct cbf_match_data cbf_msm8996_match_data = {
>>  +       .config = &cbfpll_config,
>>  +       .cbf_pll_postdiv = &cbf_pll_postdiv,
>>  +       .cbf_mux = &cbf_mux,
>>  +       .hw_clks = cbf_msm8996_hw_clks,
>>  +       .nr_hw_clks = ARRAY_SIZE(cbf_msm8996_hw_clks),
>>  +       .clks = cbf_msm8996_clks,
>>  +       .nr_clks = ARRAY_SIZE(cbf_msm8996_clks)
>>  +};
>>  +
>>  +static const struct cbf_match_data cbf_msm8996pro_match_data = {
>>  +       .config = &cbfpll_pro_config,
>>  +       .cbf_pll_postdiv = &cbf_pro_pll_postdiv,
>>  +       .cbf_mux = &cbf_pro_mux,
>>  +       .hw_clks = cbf_msm8996pro_hw_clks,
>>  +       .nr_hw_clks = ARRAY_SIZE(cbf_msm8996pro_hw_clks),
>>  +       .clks = cbf_msm8996pro_clks,
>>  +       .nr_clks = ARRAY_SIZE(cbf_msm8996pro_clks)
>>  +};
>>  +
>>   static const struct regmap_config cbf_msm8996_regmap_config = {
>>          .reg_bits               = 32,
>>          .reg_stride             = 4,
>>  @@ -274,6 +363,7 @@ static int qcom_msm8996_cbf_probe(struct 
>> platform_device *pdev)
>>          void __iomem *base;
>>          struct regmap *regmap;
>>          struct device *dev = &pdev->dev;
>>  +       const struct cbf_match_data *data = 
>> of_device_get_match_data(dev);
>>          int i, ret;
>> 
>>          base = devm_platform_ioremap_resource(pdev, 0);
>>  @@ -295,7 +385,7 @@ static int qcom_msm8996_cbf_probe(struct 
>> platform_device *pdev)
>>                             CBF_MUX_AUTO_CLK_SEL_ALWAYS_ON_MASK,
>>                             
>> CBF_MUX_AUTO_CLK_SEL_ALWAYS_ON_GPLL0_SEL);
>> 
>>  -       clk_alpha_pll_configure(&cbf_pll, regmap, &cbfpll_config);
>>  +       clk_alpha_pll_configure(&cbf_pll, regmap, data->config);
>> 
>>          /* Wait for PLL(s) to lock */
>>          udelay(50);
>>  @@ -311,27 +401,27 @@ static int qcom_msm8996_cbf_probe(struct 
>> platform_device *pdev)
>>          /* Switch CBF to use the primary PLL */
>>          regmap_update_bits(regmap, CBF_MUX_OFFSET, 
>> CBF_MUX_PARENT_MASK, 0x1);
>> 
>>  -       for (i = 0; i < ARRAY_SIZE(cbf_msm8996_hw_clks); i++) {
>>  -               ret = devm_clk_hw_register(dev, 
>> cbf_msm8996_hw_clks[i]);
>>  +       for (i = 0; i < data->nr_hw_clks; i++) {
>>  +               ret = devm_clk_hw_register(dev, data->hw_clks[i]);
>>                  if (ret)
>>                          return ret;
>>          }
>> 
>>  -       for (i = 0; i < ARRAY_SIZE(cbf_msm8996_clks); i++) {
>>  -               ret = devm_clk_register_regmap(dev, 
>> cbf_msm8996_clks[i]);
>>  +       for (i = 0; i < data->nr_clks; i++) {
>>  +               ret = devm_clk_register_regmap(dev, data->clks[i]);
>>                  if (ret)
>>                          return ret;
>>          }
>> 
>>  -       ret = devm_clk_notifier_register(dev, cbf_mux.clkr.hw.clk, 
>> &cbf_mux.nb);
>>  +       ret = devm_clk_notifier_register(dev, 
>> data->cbf_mux->clkr.hw.clk, &data->cbf_mux->nb);
>>          if (ret)
>>                  return ret;
>> 
>>  -       ret = devm_of_clk_add_hw_provider(dev, 
>> of_clk_hw_simple_get, &cbf_mux.clkr.hw);
>>  +       ret = devm_of_clk_add_hw_provider(dev, 
>> of_clk_hw_simple_get, &data->cbf_mux->clkr.hw);
>>          if (ret)
>>                  return ret;
>> 
>>  -       return qcom_msm8996_cbf_icc_register(pdev, 
>> &cbf_mux.clkr.hw);
>>  +       return qcom_msm8996_cbf_icc_register(pdev, 
>> &data->cbf_mux->clkr.hw);
>>   }
>> 
>>   static int qcom_msm8996_cbf_remove(struct platform_device *pdev)
>>  @@ -340,7 +430,8 @@ static int qcom_msm8996_cbf_remove(struct 
>> platform_device *pdev)
>>   }
>> 
>>   static const struct of_device_id qcom_msm8996_cbf_match_table[] = {
>>  -       { .compatible = "qcom,msm8996-cbf" },
>>  +       { .compatible = "qcom,msm8996-cbf", .data = 
>> &cbf_msm8996_match_data },
>>  +       { .compatible = "qcom,msm8996pro-cbf", .data = 
>> &cbf_msm8996pro_match_data },
>>          { /* sentinel */ },
>>   };
>>   MODULE_DEVICE_TABLE(of, qcom_msm8996_cbf_match_table);
>>  --
>>  2.40.0
>> 
> 
> 
> --
> With best wishes
> Dmitry


