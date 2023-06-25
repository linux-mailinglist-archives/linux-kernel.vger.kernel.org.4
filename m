Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C0F73D324
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 21:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjFYTLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 15:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjFYTLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 15:11:03 -0400
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [5.144.164.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E71C1AD
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 12:11:00 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 1CF463EEB8;
        Sun, 25 Jun 2023 21:10:56 +0200 (CEST)
Date:   Sun, 25 Jun 2023 21:10:54 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, Lux Aliaga <they@mint.lgbt>
Subject: Re: [PATCH 01/15] arm64: dts: qcom: sm6125: Sort spmi_bus node
 numerically by reg
Message-ID: <yjc63sxypg3zwju3vudyogexxnng6sgjxxf4fhibid6ifunexc@k2ieeqh23ncm>
References: <20230624-sm6125-dpu-v1-0-1d5a638cebf2@somainline.org>
 <20230624-sm6125-dpu-v1-1-1d5a638cebf2@somainline.org>
 <a2a79b58-c7a9-9099-028c-5ca79cf8f711@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2a79b58-c7a9-9099-028c-5ca79cf8f711@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-24 03:43:21, Konrad Dybcio wrote:
> On 24.06.2023 02:40, Marijn Suijten wrote:
> > This node has always resided in the wrong spot, making it somewhat
> > harder to contribute new node entries while maintaining proper sorting
> > around it.  Move the node up to sit after hsusb_phy1 where it maintains
> > proper numerial
> numerical

Thanks.

> sorting on the (first of its many) reg address property.

Why was this continuation of the line not re-quoted?  Makes your reply
super-hard to read.

- Marijn

> > 
> > Fixes: cff4bbaf2a2d ("arm64: dts: qcom: Add support for SM6125")
> > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> > ---
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> Konrad
> >  arch/arm64/boot/dts/qcom/sm6125.dtsi | 38 ++++++++++++++++++------------------
> >  1 file changed, 19 insertions(+), 19 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> > index a596baa6ce3e..722dde560bec 100644
> > --- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> > @@ -679,6 +679,24 @@ hsusb_phy1: phy@1613000 {
> >  			status = "disabled";
> >  		};
> >  
> > +		spmi_bus: spmi@1c40000 {
> > +			compatible = "qcom,spmi-pmic-arb";
> > +			reg = <0x01c40000 0x1100>,
> > +			      <0x01e00000 0x2000000>,
> > +			      <0x03e00000 0x100000>,
> > +			      <0x03f00000 0xa0000>,
> > +			      <0x01c0a000 0x26000>;
> > +			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
> > +			interrupt-names = "periph_irq";
> > +			interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
> > +			qcom,ee = <0>;
> > +			qcom,channel = <0>;
> > +			#address-cells = <2>;
> > +			#size-cells = <0>;
> > +			interrupt-controller;
> > +			#interrupt-cells = <4>;
> > +		};
> > +
> >  		rpm_msg_ram: sram@45f0000 {
> >  			compatible = "qcom,rpm-msg-ram";
> >  			reg = <0x045f0000 0x7000>;
> > @@ -1184,27 +1202,9 @@ sram@4690000 {
> >  			reg = <0x04690000 0x10000>;
> >  		};
> >  
> > -		spmi_bus: spmi@1c40000 {
> > -			compatible = "qcom,spmi-pmic-arb";
> > -			reg = <0x01c40000 0x1100>,
> > -			      <0x01e00000 0x2000000>,
> > -			      <0x03e00000 0x100000>,
> > -			      <0x03f00000 0xa0000>,
> > -			      <0x01c0a000 0x26000>;
> > -			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
> > -			interrupt-names = "periph_irq";
> > -			interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
> > -			qcom,ee = <0>;
> > -			qcom,channel = <0>;
> > -			#address-cells = <2>;
> > -			#size-cells = <0>;
> > -			interrupt-controller;
> > -			#interrupt-cells = <4>;
> > -		};
> > -
> >  		apps_smmu: iommu@c600000 {
> >  			compatible = "qcom,sm6125-smmu-500", "qcom,smmu-500", "arm,mmu-500";
> > -			reg = <0xc600000 0x80000>;
> > +			reg = <0x0c600000 0x80000>;
> >  			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>,
> >  				     <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
> >  				     <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>,
> > 
