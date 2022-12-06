Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD38644167
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 11:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbiLFKms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 05:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbiLFKmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 05:42:22 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413351E3D4
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 02:42:18 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id m18so3606289eji.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 02:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yGNvqrTOHM4qesBe13tVQjrIrlY8iFdqHUQbZxIpkZk=;
        b=jB3w0VKwREQFT5JmxRYC9UjWz94Zr+KlgF9v+euYtADpH9XU2OncUs0V//axQEjRpr
         MCVdkx8uci67ns3Qm1jIzlQf83eVrv2yXbUwtJn5VK6R7mGDu92k96IVsmr255vSi+Wd
         rjP3qjkg0t4qZv0KNVRs0vngD5+BaFg/kUbEERQ+ZREgWHUspoiK20OI1Y4PQ31ZWqQu
         AnvYvUmIbG+oOS+DUIWSvHInehpR4qeMVQkGWMUNQa7/2oBCCUXyhBVuP05bO0Nug3qM
         TXdQ5RGVRDwt7zwruEyFyBVtquAWcjn0NPZCF313HEdO9l3j4vc9JWURSEiCUMrylJJ3
         Aktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGNvqrTOHM4qesBe13tVQjrIrlY8iFdqHUQbZxIpkZk=;
        b=J1LV56lYbWfPFoAY9CxDEtdf1pu2Yin+2PPzz7rAAId2vk8fZze+YbdJ9gMQBVGfx5
         JPPgVrKCYjd+M1FXr8OmqzR2gwoiSoM0jZex6rwU7b+YJSamGR6HO+YpBm9AxccmM1+s
         tu2o7eRy4lbBY/fCW/egpIl1NC6jo8e1PcYZhadS1azmfIegb8T51cSRmSy4IGMWpp9H
         5OcbwqDSQ5h4bqtzKHQf88fxYV4iKZofAVTpKEpDD9oZssFTe8CKLrtdtmoZ7MHzqsEO
         zufZ435Txjced+RK0+S30cSZzNHYSsR+dVSam+4da2egiHEqWcx2RVvgRl+p16JvGYXn
         Iw4w==
X-Gm-Message-State: ANoB5pkmbDt0tpJ3FPBTZjwUdoGVwkwrqiFgdB4iiJpDRIkS02H4N/sF
        JDJKVxcvPNjvXB7idFH3eyyKLw==
X-Google-Smtp-Source: AA0mqf7A2JhngUU7ORMyFzBp08AP5pHsL0/7QbUxQnvw6mlRdqxFpD3+iVLJBHhf3k4EJbVwpJc9hA==
X-Received: by 2002:a17:907:2127:b0:7c0:ee16:3c5a with SMTP id qo7-20020a170907212700b007c0ee163c5amr8003658ejb.298.1670323336627;
        Tue, 06 Dec 2022 02:42:16 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id q18-20020a17090676d200b007c0e23b5615sm3240138ejn.34.2022.12.06.02.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 02:42:16 -0800 (PST)
Date:   Tue, 6 Dec 2022 12:42:14 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 8/9] clk: qcom: rpmh: Add support for SM8550 rpmh
 clocks
Message-ID: <Y48chhGMMRFv/6DS@linaro.org>
References: <20221130112852.2977816-1-abel.vesa@linaro.org>
 <20221130112852.2977816-9-abel.vesa@linaro.org>
 <CAA8EJppgpe_LK=2=qncHB_fpDz4AmUBzcRQ=8_kb0YrLCQNweg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJppgpe_LK=2=qncHB_fpDz4AmUBzcRQ=8_kb0YrLCQNweg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-11-30 13:45:19, Dmitry Baryshkov wrote:
> On Wed, 30 Nov 2022 at 13:30, Abel Vesa <abel.vesa@linaro.org> wrote:
> >
> > Adds the RPMH clocks present in SM8550 SoC.
> >
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > ---
> >  drivers/clk/qcom/clk-rpmh.c | 110 +++++++++++++++++++++++++++++-------
> >  1 file changed, 90 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
> > index 0471bab82464..3204df3fda86 100644
> > --- a/drivers/clk/qcom/clk-rpmh.c
> > +++ b/drivers/clk/qcom/clk-rpmh.c
> > @@ -132,6 +132,36 @@ static DEFINE_MUTEX(rpmh_clk_lock);
> >                 },                                                      \
> >         }
> >
> > +#define DEFINE_CLK_RPMH_FIXED(_platform, _name, _name_active,  \
> > +                                 _parent_name, _name_active_parent,    \
> > +                                 _div)                                 \
> > +       static struct clk_fixed_factor _platform##_##_name = {          \
> > +               .mult = 1,                                              \
> > +               .div = _div,                                            \
> > +               .hw.init = &(struct clk_init_data){                     \
> > +                       .ops = &clk_fixed_factor_ops,                   \
> > +                       .name = #_name,                                 \
> > +                       .parent_data =  &(const struct clk_parent_data){ \
> > +                                       .fw_name = #_parent_name,       \
> > +                                       .name = #_parent_name,          \
> > +                       },                                              \
> > +                       .num_parents = 1,                               \
> > +               },                                                      \
> > +       };                                                              \
> > +       static struct clk_fixed_factor _platform##_##_name_active = {   \
> > +               .mult = 1,                                              \
> > +               .div = _div,                                            \
> > +               .hw.init = &(struct clk_init_data){                     \
> > +                       .ops = &clk_fixed_factor_ops,                   \
> > +                       .name = #_name_active,                          \
> > +                       .parent_data =  &(const struct clk_parent_data){ \
> > +                                       .fw_name = #_name_active_parent,\
> > +                                       .name = #_name_active_parent,   \
> > +                       },                                              \
> > +                       .num_parents = 1,                               \
> > +               },                                                      \
> > +       }
> > +
> 
> Please use CLK_FIXED_FACTOR_FW_NAME() instead.
> 
> >  static inline struct clk_rpmh *to_clk_rpmh(struct clk_hw *_hw)
> >  {
> >         return container_of(_hw, struct clk_rpmh, hw);
> > @@ -579,6 +609,43 @@ static const struct clk_rpmh_desc clk_rpmh_sm8450 = {
> >         .num_clks = ARRAY_SIZE(sm8450_rpmh_clocks),
> >  };
> >
> > +DEFINE_CLK_RPMH_ARC(sm8550, xo_pad, xo_pad_ao, "xo.lvl", 0x03, 2);
> > +DEFINE_CLK_RPMH_FIXED(sm8550, bi_tcxo, bi_tcxo_ao, xo_pad, xo_pad_ao, 2);
> > +DEFINE_CLK_RPMH_VRM(sm8550, rf_clk1, rf_clk1_ao, "clka1", 1);
> > +DEFINE_CLK_RPMH_VRM(sm8550, rf_clk2, rf_clk2_ao, "clka2", 1);
> > +DEFINE_CLK_RPMH_VRM(sm8550, rf_clk3, rf_clk3_ao, "clka3", 1);
> > +DEFINE_CLK_RPMH_VRM(sm8550, rf_clk4, rf_clk4_ao, "clka4", 1);
> > +DEFINE_CLK_RPMH_VRM(sm8550, ln_bb_clk1, ln_bb_clk1_ao, "clka6", 2);
> > +DEFINE_CLK_RPMH_VRM(sm8550, ln_bb_clk2, ln_bb_clk2_ao, "clka7", 2);
> > +DEFINE_CLK_RPMH_VRM(sm8550, ln_bb_clk3, ln_bb_clk3_ao, "clka8", 2);
> > +
> > +static struct clk_hw *sm8550_rpmh_clocks[] = {
> > +       [RPMH_CXO_PAD_CLK]      = &sm8550_xo_pad.hw,
> > +       [RPMH_CXO_PAD_CLK_A]    = &sm8550_xo_pad_ao.hw,
> > +       [RPMH_CXO_CLK]          = &sm8550_bi_tcxo.hw,
> > +       [RPMH_CXO_CLK_A]        = &sm8550_bi_tcxo_ao.hw,
> > +       [RPMH_LN_BB_CLK1]       = &sm8550_ln_bb_clk1.hw,
> > +       [RPMH_LN_BB_CLK1_A]     = &sm8550_ln_bb_clk1_ao.hw,
> > +       [RPMH_LN_BB_CLK2]       = &sm8550_ln_bb_clk2.hw,
> > +       [RPMH_LN_BB_CLK2_A]     = &sm8550_ln_bb_clk2_ao.hw,
> > +       [RPMH_LN_BB_CLK3]       = &sm8550_ln_bb_clk3.hw,
> > +       [RPMH_LN_BB_CLK3_A]     = &sm8550_ln_bb_clk3_ao.hw,
> > +       [RPMH_RF_CLK1]          = &sm8550_rf_clk1.hw,
> > +       [RPMH_RF_CLK1_A]        = &sm8550_rf_clk1_ao.hw,
> > +       [RPMH_RF_CLK2]          = &sm8550_rf_clk2.hw,
> > +       [RPMH_RF_CLK2_A]        = &sm8550_rf_clk2_ao.hw,
> > +       [RPMH_RF_CLK3]          = &sm8550_rf_clk3.hw,
> > +       [RPMH_RF_CLK3_A]        = &sm8550_rf_clk3_ao.hw,
> > +       [RPMH_RF_CLK4]          = &sm8550_rf_clk4.hw,
> > +       [RPMH_RF_CLK4_A]        = &sm8550_rf_clk4_ao.hw,
> > +       [RPMH_IPA_CLK]          = &sdm845_ipa.hw,
> > +};
> > +
> > +static const struct clk_rpmh_desc clk_rpmh_sm8550 = {
> > +       .clks = sm8550_rpmh_clocks,
> > +       .num_clks = ARRAY_SIZE(sm8550_rpmh_clocks),
> > +};
> > +
> >  static struct clk_hw *sc7280_rpmh_clocks[] = {
> >         [RPMH_CXO_CLK]      = &sc7280_bi_tcxo.hw,
> >         [RPMH_CXO_CLK_A]    = &sc7280_bi_tcxo_ao.hw,
> > @@ -682,29 +749,31 @@ static int clk_rpmh_probe(struct platform_device *pdev)
> >
> >                 name = hw_clks[i]->init->name;
> >
> > -               rpmh_clk = to_clk_rpmh(hw_clks[i]);
> > -               res_addr = cmd_db_read_addr(rpmh_clk->res_name);
> > -               if (!res_addr) {
> > -                       dev_err(&pdev->dev, "missing RPMh resource address for %s\n",
> > -                               rpmh_clk->res_name);
> > -                       return -ENODEV;
> > -               }
> > +               if (hw_clks[i]->init->ops != &clk_fixed_factor_ops) {
> 
> This looks ugly a bit. I'd rather add something like non_cmd_clks to

Right, but this complicates the xlate function without a really good
reason. Assuming you meant multiple (different) arrays for cmd
based and for non-cmd based (in this case fixed factor only), this would
force the of_clk_rpmh_hw_get to look into different arrays, but then we
only have one set of IDs. Wouldn't that make it even uglier? At least,
right now we are being consistent after probe.

> the clk_rpmh_desc data and register them separately. Or even worse,
> you can keep the rpmh as is, with only cmd-db based clocks and add a
> fixed factor clock to the sm8550 dtsi directly. I have a slight
> preference for the former method, but the latter would also work.
> 
> > +                       rpmh_clk = to_clk_rpmh(hw_clks[i]);
> > +                       res_addr = cmd_db_read_addr(rpmh_clk->res_name);
> > +                       if (!res_addr) {
> > +                               dev_err(&pdev->dev, "missing RPMh resource address for %s\n",
> > +                                       rpmh_clk->res_name);
> > +                               return -ENODEV;
> > +                       }
> >
> > -               data = cmd_db_read_aux_data(rpmh_clk->res_name, &aux_data_len);
> > -               if (IS_ERR(data)) {
> > -                       ret = PTR_ERR(data);
> > -                       dev_err(&pdev->dev,
> > -                               "error reading RPMh aux data for %s (%d)\n",
> > -                               rpmh_clk->res_name, ret);
> > -                       return ret;
> > -               }
> > +                       data = cmd_db_read_aux_data(rpmh_clk->res_name, &aux_data_len);
> > +                       if (IS_ERR(data)) {
> > +                               ret = PTR_ERR(data);
> > +                               dev_err(&pdev->dev,
> > +                                       "error reading RPMh aux data for %s (%d)\n",
> > +                                       rpmh_clk->res_name, ret);
> > +                               return ret;
> > +                       }
> >
> > -               /* Convert unit from Khz to Hz */
> > -               if (aux_data_len == sizeof(*data))
> > -                       rpmh_clk->unit = le32_to_cpu(data->unit) * 1000ULL;
> > +                       /* Convert unit from Khz to Hz */
> > +                       if (aux_data_len == sizeof(*data))
> > +                               rpmh_clk->unit = le32_to_cpu(data->unit) * 1000ULL;
> >
> > -               rpmh_clk->res_addr += res_addr;
> > -               rpmh_clk->dev = &pdev->dev;
> > +                       rpmh_clk->res_addr += res_addr;
> > +                       rpmh_clk->dev = &pdev->dev;
> > +               }
> >
> >                 ret = devm_clk_hw_register(&pdev->dev, hw_clks[i]);
> >                 if (ret) {
> > @@ -739,6 +808,7 @@ static const struct of_device_id clk_rpmh_match_table[] = {
> >         { .compatible = "qcom,sm8250-rpmh-clk", .data = &clk_rpmh_sm8250},
> >         { .compatible = "qcom,sm8350-rpmh-clk", .data = &clk_rpmh_sm8350},
> >         { .compatible = "qcom,sm8450-rpmh-clk", .data = &clk_rpmh_sm8450},
> > +       { .compatible = "qcom,sm8550-rpmh-clk", .data = &clk_rpmh_sm8550},
> >         { .compatible = "qcom,sc7280-rpmh-clk", .data = &clk_rpmh_sc7280},
> >         { }
> >  };
> > --
> > 2.34.1
> >
> 
> 
> -- 
> With best wishes
> Dmitry
