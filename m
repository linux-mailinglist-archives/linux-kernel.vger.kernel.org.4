Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0063A742658
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 14:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjF2M1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 08:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjF2M0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 08:26:51 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A9935A0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 05:24:56 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-5633b7e5f90so364823eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 05:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688041495; x=1690633495;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VTzq8z32fPEVUV/pb5F02c76wadt+517zWU1LP37f6I=;
        b=DdKwwRcm6kKObAvaWt9jtGNjXf7LTrmHooCR6YGQPIaorlgX0JHmP3WgVsautTT0K7
         7iRsaq6x4mmE+B+yH4zJTvNqdWjiva0uZSJQBMH5b2VLfOH7V6471whoWPSLCl7I5WSg
         +WYtWE1XJKhXB6tBK9Sv+ZXNGTPkBSbcCM2r2l6U8ngYC9+EopFcWY5IyUpWd3Xw92Bb
         3GaQDC8qUK2uAIsoGfliUlXLR4Kcu9dUkg+PODaGhZMBdXPKzOks8uQxdTVDIWoX2Ycd
         9GQfW5Vdr2s+ZZHppFXMRDRiTL50e4JLSzSdVwzik+hgY5BOHoFlPpfU2W63K4r67PVx
         DQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688041495; x=1690633495;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VTzq8z32fPEVUV/pb5F02c76wadt+517zWU1LP37f6I=;
        b=dU+X2cl5TnUzvo4NT1egrXRZJ4ZKy/sBJPIY2JzobPwQL+s30pWHpu/XYHw+PAZqB3
         YVcku9EZmfsh5oBjiikwLuRyXAiM6r6HzsyqpgYI3wD1hOH7iahYytwFDNPc50e1/Kpo
         j5EXICBqz1HlB2vsna2dqgQb+viXDCwkftz1J3tWetis2pgcELSjkpnDZEwoaflzsgEP
         exMgwKUbFGq+ofjPoGrZQDVOK7dmTP6+yVsFXUV7Gy4xK/MySIx792EfAisw/9HhKCDY
         EB5Fvl919/zBlpNxou2CqPJ551g50XUZtwXXHg/4O3hHrOx3bnQaVsvue8b0jAvu1UBp
         NpEQ==
X-Gm-Message-State: ABy/qLaKE492M3BuzJUtyj0nvSh+JGNMGDT/hlG+BQPcB8QJdyp6QpCi
        MDE3tQy9EnPTBaDdfiSK/6mqX0heicgBzpUfTgtCNQ==
X-Google-Smtp-Source: ACHHUZ7ZZiE29h6TGG7y8pc6HUcITIR7bXk1i4baG8qfwxrOlHz3QTVC9dH5i23aoiJoczTwELcymGXmbTl6fASHlpY=
X-Received: by 2002:a05:6358:1a85:b0:134:e4fe:e162 with SMTP id
 gm5-20020a0563581a8500b00134e4fee162mr2591806rwb.13.1688041495258; Thu, 29
 Jun 2023 05:24:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230627-sm6125-dpu-v2-0-03e430a2078c@somainline.org>
 <20230627-sm6125-dpu-v2-13-03e430a2078c@somainline.org> <4a267feb-5855-1427-c378-b2615eae4f84@linaro.org>
 <kisifidg4bdb4v6fb6nvgt5omsprssd4bxrn6wqehjo66l2y4a@7nfaydtafzpn>
In-Reply-To: <kisifidg4bdb4v6fb6nvgt5omsprssd4bxrn6wqehjo66l2y4a@7nfaydtafzpn>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 29 Jun 2023 15:24:43 +0300
Message-ID: <CAA8EJpr+PyjehSd4SEUVfh13+i=+-7v1esQasc+7gNaL2iqWJA@mail.gmail.com>
Subject: Re: [PATCH v2 13/15] arm64: dts: qcom: sm6125: Add dispcc node
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, Lux Aliaga <they@mint.lgbt>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2023 at 15:14, Marijn Suijten
<marijn.suijten@somainline.org> wrote:
>
> On 2023-06-29 13:56:25, Dmitry Baryshkov wrote:
> > On 27/06/2023 23:14, Marijn Suijten wrote:
> > > Enable and configure the dispcc node on SM6125 for consumption by MDSS
> > > later on.
> > >
> > > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> > > ---
> > >   arch/arm64/boot/dts/qcom/sm6125.dtsi | 25 +++++++++++++++++++++++++
> > >   1 file changed, 25 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> > > index edb03508dba3..a5cc0d43d2d9 100644
> > > --- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> > > @@ -3,6 +3,7 @@
> > >    * Copyright (c) 2021, Martin Botka <martin.botka@somainline.org>
> > >    */
> > >
> > > +#include <dt-bindings/clock/qcom,dispcc-sm6125.h>
> > >   #include <dt-bindings/clock/qcom,gcc-sm6125.h>
> > >   #include <dt-bindings/clock/qcom,rpmcc.h>
> > >   #include <dt-bindings/dma/qcom-gpi.h>
> > > @@ -1203,6 +1204,30 @@ sram@4690000 {
> > >                     reg = <0x04690000 0x10000>;
> > >             };
> > >
> > > +           dispcc: clock-controller@5f00000 {
> > > +                   compatible = "qcom,sm6125-dispcc";
> > > +                   reg = <0x05f00000 0x20000>;
> > > +                   clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
> > > +                            <0>,
> > > +                            <0>,
> > > +                            <0>,
> > > +                            <0>,
> > > +                            <0>,
> > > +                            <&gcc GCC_DISP_AHB_CLK>,
> > > +                            <&gcc GCC_DISP_GPLL0_DIV_CLK_SRC>;
> > > +                   clock-names = "bi_tcxo",
> > > +                                 "dsi0_phy_pll_out_byteclk",
> > > +                                 "dsi0_phy_pll_out_dsiclk",
> > > +                                 "dsi1_phy_pll_out_dsiclk",
> > > +                                 "dp_phy_pll_link_clk",
> > > +                                 "dp_phy_pll_vco_div_clk",
> > > +                                 "cfg_ahb_clk",
> > > +                                 "gcc_disp_gpll0_div_clk_src";
> > > +                   power-domains = <&rpmpd SM6125_VDDCX>;
> >
> > Would it be logical to specify the required-opps too?
>
> Perhaps, but barely any other SoC aside from sm8x50 sets it on dispcc.
> What should it be, rpmhpd_opp_low_svs?  IIRC we used "svs" for the DSI
> PHY despite not having a reference value downstream (it sets a range of
> NOM-TURBO_NO_CPR, and RETENTION when it's off).

Then for DSI PHY the required-opps should be rpmpd_opp_nom.

For the dispcc I think the rpmpd_opp_ret, the lowest possible vote,
should be enough.

>
> - Marijn
>
> >
> > > +                   #clock-cells = <1>;
> > > +                   #power-domain-cells = <1>;
> > > +           };
> > > +
> > >             apps_smmu: iommu@c600000 {
> > >                     compatible = "qcom,sm6125-smmu-500", "qcom,smmu-500", "arm,mmu-500";
> > >                     reg = <0x0c600000 0x80000>;
> > >
> >
> > --
> > With best wishes
> > Dmitry
> >



-- 
With best wishes
Dmitry
