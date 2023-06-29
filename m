Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38845742580
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 14:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbjF2MOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 08:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbjF2MOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 08:14:17 -0400
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [IPv6:2001:4b7a:2000:18::167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C97B35AB;
        Thu, 29 Jun 2023 05:14:14 -0700 (PDT)
Received: from SoMainline.org (82-72-63-87.cable.dynamic.v4.ziggo.nl [82.72.63.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 911C73ED7C;
        Thu, 29 Jun 2023 14:14:05 +0200 (CEST)
Date:   Thu, 29 Jun 2023 14:14:04 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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
Subject: Re: [PATCH v2 13/15] arm64: dts: qcom: sm6125: Add dispcc node
Message-ID: <kisifidg4bdb4v6fb6nvgt5omsprssd4bxrn6wqehjo66l2y4a@7nfaydtafzpn>
References: <20230627-sm6125-dpu-v2-0-03e430a2078c@somainline.org>
 <20230627-sm6125-dpu-v2-13-03e430a2078c@somainline.org>
 <4a267feb-5855-1427-c378-b2615eae4f84@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a267feb-5855-1427-c378-b2615eae4f84@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-29 13:56:25, Dmitry Baryshkov wrote:
> On 27/06/2023 23:14, Marijn Suijten wrote:
> > Enable and configure the dispcc node on SM6125 for consumption by MDSS
> > later on.
> > 
> > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> > ---
> >   arch/arm64/boot/dts/qcom/sm6125.dtsi | 25 +++++++++++++++++++++++++
> >   1 file changed, 25 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> > index edb03508dba3..a5cc0d43d2d9 100644
> > --- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> > @@ -3,6 +3,7 @@
> >    * Copyright (c) 2021, Martin Botka <martin.botka@somainline.org>
> >    */
> >   
> > +#include <dt-bindings/clock/qcom,dispcc-sm6125.h>
> >   #include <dt-bindings/clock/qcom,gcc-sm6125.h>
> >   #include <dt-bindings/clock/qcom,rpmcc.h>
> >   #include <dt-bindings/dma/qcom-gpi.h>
> > @@ -1203,6 +1204,30 @@ sram@4690000 {
> >   			reg = <0x04690000 0x10000>;
> >   		};
> >   
> > +		dispcc: clock-controller@5f00000 {
> > +			compatible = "qcom,sm6125-dispcc";
> > +			reg = <0x05f00000 0x20000>;
> > +			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
> > +				 <0>,
> > +				 <0>,
> > +				 <0>,
> > +				 <0>,
> > +				 <0>,
> > +				 <&gcc GCC_DISP_AHB_CLK>,
> > +				 <&gcc GCC_DISP_GPLL0_DIV_CLK_SRC>;
> > +			clock-names = "bi_tcxo",
> > +				      "dsi0_phy_pll_out_byteclk",
> > +				      "dsi0_phy_pll_out_dsiclk",
> > +				      "dsi1_phy_pll_out_dsiclk",
> > +				      "dp_phy_pll_link_clk",
> > +				      "dp_phy_pll_vco_div_clk",
> > +				      "cfg_ahb_clk",
> > +				      "gcc_disp_gpll0_div_clk_src";
> > +			power-domains = <&rpmpd SM6125_VDDCX>;
> 
> Would it be logical to specify the required-opps too?

Perhaps, but barely any other SoC aside from sm8x50 sets it on dispcc.
What should it be, rpmhpd_opp_low_svs?  IIRC we used "svs" for the DSI
PHY despite not having a reference value downstream (it sets a range of
NOM-TURBO_NO_CPR, and RETENTION when it's off).

- Marijn

> 
> > +			#clock-cells = <1>;
> > +			#power-domain-cells = <1>;
> > +		};
> > +
> >   		apps_smmu: iommu@c600000 {
> >   			compatible = "qcom,sm6125-smmu-500", "qcom,smmu-500", "arm,mmu-500";
> >   			reg = <0x0c600000 0x80000>;
> > 
> 
> -- 
> With best wishes
> Dmitry
> 
