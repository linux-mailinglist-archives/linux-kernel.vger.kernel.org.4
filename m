Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3A4644195
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 11:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbiLFKw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 05:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiLFKwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 05:52:25 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA6564CE
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 02:52:24 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id vv4so5254162ejc.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 02:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fkld1YTjBZQbiVlABTivpm7yE0ABi+qWnMTJBt+zNt4=;
        b=hsBTGePNUoSTwRGUi1FtySpPoaX/qu5Dcin8TYngB/vD1D4r40JEKvOT5uAnNPeuHo
         CqpuNVe6c2awF+TquLCO/ifY6hbkfSlIploxZWD1MDaSolnx4b7jRCjC+4pafC7aZ4Zh
         9h9gJq1XTxmy54bz0S2bx/IS2/naIHVELj22cCtGjXRL3zCzfCEgp0EEZ3b+TmhFnwFo
         U4pGNPcLk/wdEhJhK9ytOweih0G5/9QzE8K3pANJMV7DZvSffQjHZNU4uMayhExtBvWD
         l5rK7EATYJP5fHcHu/k7k9uxUi9usMM3TX2Vwe4TpNZI2+vhfH6dXChpbJQOgBxz768u
         Q1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fkld1YTjBZQbiVlABTivpm7yE0ABi+qWnMTJBt+zNt4=;
        b=p0blyeWWRcg3mYO4JJlZLY6VobxVPA/VIh8RqKnsL7KJ+os628MUixkD05z9abXPAt
         10sqHwaNWySuZ/ktQvCjrzesjzkyarHOBH0SlwshQ/i5IwF7172gPfUymG5NlHH+Zbpz
         LmT1zJBoSigpL682QaS50tyjQXmGO8ESEyq0iV1yRtL4VAkRKhffQ0aypYgfCC1jnpeF
         H4TpP6kjQawRq5LwCDyrGbIBTfxu3fgnVsgOHj1m/6Q2o+XOUShfIrQ79CPJDSMokSPm
         qJ5fVagMtPgGI7u+VtXxIaaSU14sCqEiELwp8i9MuQYr2cTJFLAsb3/OjvdfrVQfW2lW
         W4+A==
X-Gm-Message-State: ANoB5plarnVRh9AFbDUpf6q3PLb36jXjjd/xeWSnUQ5VKL0zsv1a9t52
        zwSM9p1bLAXl8BhNtiUILwc/Gg==
X-Google-Smtp-Source: AA0mqf53cSC8NGoH1VuFJO3pbOsz57KByEubiVPxg2fE7nRRltUUOu5hW1zrt6Il80tdNx4juRkD4g==
X-Received: by 2002:a17:906:a0c6:b0:7bd:3a5c:4dea with SMTP id bh6-20020a170906a0c600b007bd3a5c4deamr4085569ejb.190.1670323942713;
        Tue, 06 Dec 2022 02:52:22 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id ky20-20020a170907779400b007c0ac4e6b6esm6413333ejc.143.2022.12.06.02.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 02:52:22 -0800 (PST)
Date:   Tue, 6 Dec 2022 12:52:21 +0200
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
Message-ID: <Y48e5bcy/dGLWYUX@linaro.org>
References: <20221130112852.2977816-1-abel.vesa@linaro.org>
 <20221130112852.2977816-9-abel.vesa@linaro.org>
 <CAA8EJppgpe_LK=2=qncHB_fpDz4AmUBzcRQ=8_kb0YrLCQNweg@mail.gmail.com>
 <CAA8EJpqgzc01756fVMU6QbRrObZY4bSwQajVzdinZKC2n92h4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpqgzc01756fVMU6QbRrObZY4bSwQajVzdinZKC2n92h4g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-11-30 13:59:00, Dmitry Baryshkov wrote:
> On Wed, 30 Nov 2022 at 13:45, Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Wed, 30 Nov 2022 at 13:30, Abel Vesa <abel.vesa@linaro.org> wrote:
> > >
> > > Adds the RPMH clocks present in SM8550 SoC.
> > >
> > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > > ---
> > >  drivers/clk/qcom/clk-rpmh.c | 110 +++++++++++++++++++++++++++++-------
> > >  1 file changed, 90 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
> > > index 0471bab82464..3204df3fda86 100644
> > > --- a/drivers/clk/qcom/clk-rpmh.c
> > > +++ b/drivers/clk/qcom/clk-rpmh.c
> > > @@ -132,6 +132,36 @@ static DEFINE_MUTEX(rpmh_clk_lock);
> > >                 },                                                      \
> > >         }
> > >
> > > +#define DEFINE_CLK_RPMH_FIXED(_platform, _name, _name_active,  \
> > > +                                 _parent_name, _name_active_parent,    \
> > > +                                 _div)                                 \
> > > +       static struct clk_fixed_factor _platform##_##_name = {          \
> > > +               .mult = 1,                                              \
> > > +               .div = _div,                                            \
> > > +               .hw.init = &(struct clk_init_data){                     \
> > > +                       .ops = &clk_fixed_factor_ops,                   \
> > > +                       .name = #_name,                                 \
> > > +                       .parent_data =  &(const struct clk_parent_data){ \
> > > +                                       .fw_name = #_parent_name,       \
> > > +                                       .name = #_parent_name,          \
> > > +                       },                                              \
> > > +                       .num_parents = 1,                               \
> > > +               },                                                      \
> > > +       };                                                              \
> > > +       static struct clk_fixed_factor _platform##_##_name_active = {   \
> > > +               .mult = 1,                                              \
> > > +               .div = _div,                                            \
> > > +               .hw.init = &(struct clk_init_data){                     \
> > > +                       .ops = &clk_fixed_factor_ops,                   \
> > > +                       .name = #_name_active,                          \
> > > +                       .parent_data =  &(const struct clk_parent_data){ \
> > > +                                       .fw_name = #_name_active_parent,\
> > > +                                       .name = #_name_active_parent,   \
> > > +                       },                                              \
> > > +                       .num_parents = 1,                               \
> > > +               },                                                      \
> > > +       }
> > > +
> >
> > Please use CLK_FIXED_FACTOR_FW_NAME() instead.
> 
> Or even better CLK_FIXED_FACTOR_HW(). It fits better here.

I think DEFINE_CLK_FIXED_FACTOR would be even a better fit. No _HW since we
are not defining just the clk_hw. Also we should keep the DEFINE_ prefix to
be consistent with the others.

> 
> >
> > >  static inline struct clk_rpmh *to_clk_rpmh(struct clk_hw *_hw)
> > >  {
> > >         return container_of(_hw, struct clk_rpmh, hw);
> > > @@ -579,6 +609,43 @@ static const struct clk_rpmh_desc clk_rpmh_sm8450 = {
> > >         .num_clks = ARRAY_SIZE(sm8450_rpmh_clocks),
> > >  };
> > >
> > > +DEFINE_CLK_RPMH_ARC(sm8550, xo_pad, xo_pad_ao, "xo.lvl", 0x03, 2);
> > > +DEFINE_CLK_RPMH_FIXED(sm8550, bi_tcxo, bi_tcxo_ao, xo_pad, xo_pad_ao, 2);
> > > +DEFINE_CLK_RPMH_VRM(sm8550, rf_clk1, rf_clk1_ao, "clka1", 1);
> > > +DEFINE_CLK_RPMH_VRM(sm8550, rf_clk2, rf_clk2_ao, "clka2", 1);
> > > +DEFINE_CLK_RPMH_VRM(sm8550, rf_clk3, rf_clk3_ao, "clka3", 1);
> > > +DEFINE_CLK_RPMH_VRM(sm8550, rf_clk4, rf_clk4_ao, "clka4", 1);
> > > +DEFINE_CLK_RPMH_VRM(sm8550, ln_bb_clk1, ln_bb_clk1_ao, "clka6", 2);
> > > +DEFINE_CLK_RPMH_VRM(sm8550, ln_bb_clk2, ln_bb_clk2_ao, "clka7", 2);
> > > +DEFINE_CLK_RPMH_VRM(sm8550, ln_bb_clk3, ln_bb_clk3_ao, "clka8", 2);
> > > +
> > > +static struct clk_hw *sm8550_rpmh_clocks[] = {
> > > +       [RPMH_CXO_PAD_CLK]      = &sm8550_xo_pad.hw,
> > > +       [RPMH_CXO_PAD_CLK_A]    = &sm8550_xo_pad_ao.hw,
> > > +       [RPMH_CXO_CLK]          = &sm8550_bi_tcxo.hw,
> > > +       [RPMH_CXO_CLK_A]        = &sm8550_bi_tcxo_ao.hw,
> > > +       [RPMH_LN_BB_CLK1]       = &sm8550_ln_bb_clk1.hw,
> > > +       [RPMH_LN_BB_CLK1_A]     = &sm8550_ln_bb_clk1_ao.hw,
> > > +       [RPMH_LN_BB_CLK2]       = &sm8550_ln_bb_clk2.hw,
> > > +       [RPMH_LN_BB_CLK2_A]     = &sm8550_ln_bb_clk2_ao.hw,
> > > +       [RPMH_LN_BB_CLK3]       = &sm8550_ln_bb_clk3.hw,
> > > +       [RPMH_LN_BB_CLK3_A]     = &sm8550_ln_bb_clk3_ao.hw,
> > > +       [RPMH_RF_CLK1]          = &sm8550_rf_clk1.hw,
> > > +       [RPMH_RF_CLK1_A]        = &sm8550_rf_clk1_ao.hw,
> > > +       [RPMH_RF_CLK2]          = &sm8550_rf_clk2.hw,
> > > +       [RPMH_RF_CLK2_A]        = &sm8550_rf_clk2_ao.hw,
> > > +       [RPMH_RF_CLK3]          = &sm8550_rf_clk3.hw,
> > > +       [RPMH_RF_CLK3_A]        = &sm8550_rf_clk3_ao.hw,
> > > +       [RPMH_RF_CLK4]          = &sm8550_rf_clk4.hw,
> > > +       [RPMH_RF_CLK4_A]        = &sm8550_rf_clk4_ao.hw,
> > > +       [RPMH_IPA_CLK]          = &sdm845_ipa.hw,
> > > +};
> > > +
> > > +static const struct clk_rpmh_desc clk_rpmh_sm8550 = {
> > > +       .clks = sm8550_rpmh_clocks,
> > > +       .num_clks = ARRAY_SIZE(sm8550_rpmh_clocks),
> > > +};
> > > +
> > >  static struct clk_hw *sc7280_rpmh_clocks[] = {
> > >         [RPMH_CXO_CLK]      = &sc7280_bi_tcxo.hw,
> > >         [RPMH_CXO_CLK_A]    = &sc7280_bi_tcxo_ao.hw,
> > > @@ -682,29 +749,31 @@ static int clk_rpmh_probe(struct platform_device *pdev)
> > >
> > >                 name = hw_clks[i]->init->name;
> > >
> > > -               rpmh_clk = to_clk_rpmh(hw_clks[i]);
> > > -               res_addr = cmd_db_read_addr(rpmh_clk->res_name);
> > > -               if (!res_addr) {
> > > -                       dev_err(&pdev->dev, "missing RPMh resource address for %s\n",
> > > -                               rpmh_clk->res_name);
> > > -                       return -ENODEV;
> > > -               }
> > > +               if (hw_clks[i]->init->ops != &clk_fixed_factor_ops) {
> >
> > This looks ugly a bit. I'd rather add something like non_cmd_clks to
> > the clk_rpmh_desc data and register them separately. Or even worse,
> > you can keep the rpmh as is, with only cmd-db based clocks and add a
> > fixed factor clock to the sm8550 dtsi directly. I have a slight
> > preference for the former method, but the latter would also work.
> 
> After a second thought, I'd withdraw the second method. Just add a
> separate array with non-cmd-db clocks.
> 
> >
> > > +                       rpmh_clk = to_clk_rpmh(hw_clks[i]);
> > > +                       res_addr = cmd_db_read_addr(rpmh_clk->res_name);
> > > +                       if (!res_addr) {
> > > +                               dev_err(&pdev->dev, "missing RPMh resource address for %s\n",
> > > +                                       rpmh_clk->res_name);
> > > +                               return -ENODEV;
> > > +                       }
> > >
> > > -               data = cmd_db_read_aux_data(rpmh_clk->res_name, &aux_data_len);
> > > -               if (IS_ERR(data)) {
> > > -                       ret = PTR_ERR(data);
> > > -                       dev_err(&pdev->dev,
> > > -                               "error reading RPMh aux data for %s (%d)\n",
> > > -                               rpmh_clk->res_name, ret);
> > > -                       return ret;
> > > -               }
> > > +                       data = cmd_db_read_aux_data(rpmh_clk->res_name, &aux_data_len);
> > > +                       if (IS_ERR(data)) {
> > > +                               ret = PTR_ERR(data);
> > > +                               dev_err(&pdev->dev,
> > > +                                       "error reading RPMh aux data for %s (%d)\n",
> > > +                                       rpmh_clk->res_name, ret);
> > > +                               return ret;
> > > +                       }
> > >
> > > -               /* Convert unit from Khz to Hz */
> > > -               if (aux_data_len == sizeof(*data))
> > > -                       rpmh_clk->unit = le32_to_cpu(data->unit) * 1000ULL;
> > > +                       /* Convert unit from Khz to Hz */
> > > +                       if (aux_data_len == sizeof(*data))
> > > +                               rpmh_clk->unit = le32_to_cpu(data->unit) * 1000ULL;
> > >
> > > -               rpmh_clk->res_addr += res_addr;
> > > -               rpmh_clk->dev = &pdev->dev;
> > > +                       rpmh_clk->res_addr += res_addr;
> > > +                       rpmh_clk->dev = &pdev->dev;
> > > +               }
> > >
> > >                 ret = devm_clk_hw_register(&pdev->dev, hw_clks[i]);
> > >                 if (ret) {
> > > @@ -739,6 +808,7 @@ static const struct of_device_id clk_rpmh_match_table[] = {
> > >         { .compatible = "qcom,sm8250-rpmh-clk", .data = &clk_rpmh_sm8250},
> > >         { .compatible = "qcom,sm8350-rpmh-clk", .data = &clk_rpmh_sm8350},
> > >         { .compatible = "qcom,sm8450-rpmh-clk", .data = &clk_rpmh_sm8450},
> > > +       { .compatible = "qcom,sm8550-rpmh-clk", .data = &clk_rpmh_sm8550},
> > >         { .compatible = "qcom,sc7280-rpmh-clk", .data = &clk_rpmh_sc7280},
> > >         { }
> > >  };
> > > --
> > > 2.34.1
> > >
> >
> >
> > --
> > With best wishes
> > Dmitry
> 
> 
> 
> -- 
> With best wishes
> Dmitry
