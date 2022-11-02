Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B027615E06
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 09:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiKBIkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 04:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbiKBIkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 04:40:06 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B2E24F29
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 01:40:05 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id t25so43377661ejb.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 01:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e/jtuwgULBOycwGalh+zkT6mjLdV0jwG/bWZgUJxcW8=;
        b=nRkmXPJgWNcU1eAeVmyDwZ7wmOLf3UxyJf1p03PwhRq4lDa78pIsXQ7Ty2cPuTcml1
         kQLUesRT+qIw/TivDkTLF036tENc5gqUbdjzprZpng7t7mdSibHC9FYXQJyQf7G+XH3j
         4DQF23XKCH9RBhhtDPxB25r0gVixcFJMGqC5nZpWLtNaYpj4R4R9lTIjW8pXNHFkkLWD
         O8CtSRyKfIMvXoEmfTcRhTPeJ9J4trnoA+SrfkhmV6pS87l8tJ7odb8vIdXkYdXeF6GD
         QAOwhs3h7FktPZwb1UOohta1jWsQAx4IO9lVoD5sJgpOq8OLGz9t4btkQV/n4Beu75he
         48vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e/jtuwgULBOycwGalh+zkT6mjLdV0jwG/bWZgUJxcW8=;
        b=KbyKfNNoDzhvr/NkED8MQuQTWOXel42j+f8GFq6OPm/j3W2OljuCTPrrWf/0h+5EMz
         Vwkkz9UYd5Kvr0+HkTKYw3wINt9cwZ6aHzrKfFiNKFjGZWISLOGNroKl3YnDfSwVu6Qi
         LVmrJY6x6O79evVhSDN2+rEJPmyFESFzN5cnjS02/IwEjP/alhSBacDnrrUYiULRB0HF
         9SmTNFqXYHJI7rmHAwPdegTH+c9C/mRHaIImM3rFWv4Re0HzclsI9fi02XV1lS99GLw9
         kJmtEqDwwTBy5De5Fey3/zt/TJpZ9XF50KxtoK1eOvMMuTKnp/cdimjToT0QeaWfgHUo
         H32A==
X-Gm-Message-State: ACrzQf3c9qDQsR0HsPSSYM/FjrDuRIX0qcDfurIp5nz0+9nOkxXhJ28F
        izr4PJqU2xbxaStV+zu7sVvUeVIpdp+rnyOtC7bGUw==
X-Google-Smtp-Source: AMsMyM5nzVcTT98Fh7PeXoFIpuR2xOrxd1QJPqjmAIoiBUnWh103tbbpfY8bXpvrDyFZz1aE+VvCY/S3/al36AN61Ik=
X-Received: by 2002:a17:907:72cb:b0:7ad:7e95:63f5 with SMTP id
 du11-20020a17090772cb00b007ad7e9563f5mr22321018ejc.383.1667378403649; Wed, 02
 Nov 2022 01:40:03 -0700 (PDT)
MIME-Version: 1.0
References: <20221027123432.1818530-1-robert.foss@linaro.org>
 <20221027123432.1818530-4-robert.foss@linaro.org> <e32be4c0-56ea-6999-92e6-3b51792a5255@linaro.org>
In-Reply-To: <e32be4c0-56ea-6999-92e6-3b51792a5255@linaro.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Wed, 2 Nov 2022 09:39:52 +0100
Message-ID: <CAG3jFyuvdTOisdP6qexaY3M+JQOHbRomqk4cCKRwS=L=ev6CWA@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] clk: qcom: dispcc-sm8250: Add missing EDP clocks
 for sm8350
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Oct 2022 at 14:42, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On 27/10/2022 15:34, Robert Foss wrote:
> > SM8350 supports embedded displayport, but the clocks for this
> > were previously not enabled.
>
> I'd say 'not accounted for' instead. Bjorn has added eDP clocks, but
> they were following the 8150 (no div_clk_src) and the offsets were not
> updated.

Ack.

>
> >
> > Signed-off-by: Robert Foss <robert.foss@linaro.org>
> > ---
> >   drivers/clk/qcom/dispcc-sm8250.c | 22 +++++++++++++++++++++-
> >   1 file changed, 21 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/clk/qcom/dispcc-sm8250.c b/drivers/clk/qcom/dispcc-sm8250.c
> > index a7606580cf22..d2aaa44ed3d4 100644
> > --- a/drivers/clk/qcom/dispcc-sm8250.c
> > +++ b/drivers/clk/qcom/dispcc-sm8250.c
> > @@ -462,6 +462,20 @@ static struct clk_branch disp_cc_mdss_edp_link_clk = {
> >       },
> >   };
> >
> > +static struct clk_regmap_div disp_cc_mdss_edp_link_div_clk_src = {
> > +     .reg = 0x2288,
> > +     .shift = 0,
> > +     .width = 2,
> > +     .clkr.hw.init = &(struct clk_init_data) {
> > +             .name = "disp_cc_mdss_edp_link_div_clk_src",
> > +             .parent_hws = (const struct clk_hw*[]){
> > +                     &disp_cc_mdss_edp_link_clk_src.clkr.hw,
> > +             },
> > +             .num_parents = 1,
> > +             .ops = &clk_regmap_div_ro_ops,
> > +     },
> > +};
> > +
> >   static struct clk_branch disp_cc_mdss_edp_link_intf_clk = {
> >       .halt_reg = 0x2074,
> >       .halt_check = BRANCH_HALT,
> > @@ -471,7 +485,7 @@ static struct clk_branch disp_cc_mdss_edp_link_intf_clk = {
> >               .hw.init = &(struct clk_init_data){
> >                       .name = "disp_cc_mdss_edp_link_intf_clk",
> >                       .parent_hws = (const struct clk_hw*[]){
> > -                             &disp_cc_mdss_edp_link_clk_src.clkr.hw,
> > +                             &disp_cc_mdss_edp_link_div_clk_src.clkr.hw,
> >                       },
> >                       .num_parents = 1,
> >                       .flags = CLK_GET_RATE_NOCACHE,
> > @@ -1175,6 +1189,7 @@ static struct clk_regmap *disp_cc_sm8250_clocks[] = {
> >       [DISP_CC_MDSS_EDP_GTC_CLK_SRC] = &disp_cc_mdss_edp_gtc_clk_src.clkr,
> >       [DISP_CC_MDSS_EDP_LINK_CLK] = &disp_cc_mdss_edp_link_clk.clkr,
> >       [DISP_CC_MDSS_EDP_LINK_CLK_SRC] = &disp_cc_mdss_edp_link_clk_src.clkr,
> > +     [DISP_CC_MDSS_EDP_LINK_DIV_CLK_SRC] = &disp_cc_mdss_edp_link_div_clk_src.clkr,
> >       [DISP_CC_MDSS_EDP_LINK_INTF_CLK] = &disp_cc_mdss_edp_link_intf_clk.clkr,
> >       [DISP_CC_MDSS_EDP_PIXEL_CLK] = &disp_cc_mdss_edp_pixel_clk.clkr,
> >       [DISP_CC_MDSS_EDP_PIXEL_CLK_SRC] = &disp_cc_mdss_edp_pixel_clk_src.clkr,
> > @@ -1285,7 +1300,11 @@ static int disp_cc_sm8250_probe(struct platform_device *pdev)
> >                       &disp_cc_mdss_dp_pixel1_clk_src,
> >                       &disp_cc_mdss_dp_pixel2_clk_src,
> >                       &disp_cc_mdss_dp_pixel_clk_src,
> > +                     &disp_cc_mdss_edp_aux_clk_src,
> > +                     &disp_cc_mdss_edp_link_clk_src,
> > +                     &disp_cc_mdss_edp_pixel_clk_src,
> >                       &disp_cc_mdss_esc0_clk_src,
> > +                     &disp_cc_mdss_esc1_clk_src,
> >                       &disp_cc_mdss_mdp_clk_src,
> >                       &disp_cc_mdss_pclk0_clk_src,
> >                       &disp_cc_mdss_pclk1_clk_src,
> > @@ -1297,6 +1316,7 @@ static int disp_cc_sm8250_probe(struct platform_device *pdev)
> >                       &disp_cc_mdss_byte1_div_clk_src,
> >                       &disp_cc_mdss_dp_link1_div_clk_src,
> >                       &disp_cc_mdss_dp_link_div_clk_src,
> > +                     &disp_cc_mdss_edp_link_div_clk_src,
> >               };
> >               unsigned int i;
> >               static bool offset_applied;
>
> --
> With best wishes
> Dmitry
>
