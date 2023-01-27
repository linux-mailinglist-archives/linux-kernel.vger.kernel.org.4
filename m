Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B753467E4C0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 13:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbjA0MLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 07:11:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233665AbjA0MLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:11:38 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4FE80166
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 04:05:49 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id v6so13134207ejg.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 04:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bTM0gFp5KxvcXFhrslPw+2Glr7b468eMGXFy1OhWB+c=;
        b=q06hgvOj+Xtn4s9r6mKV94U0o/76CmKN2XFV44pfrJXqydcWHnGkl9+zZBVstEWD5j
         uIgSSUMLUDY9xHtF41eTajQov9fIYDlhpXmxN10ksuBh1HbT/GyKJ1jttPoEWkciOGdb
         QSilNDacy2NVZ62EcC5PAVLpwSc0+uLOACXLhIFAt7EC6Dwg+CGEIP9dNm5hAxHy0q5E
         iwOXVcoRghCmVcVgil96Cie0MecNKK2pPPvCdoVWlZ+sMidKdzTvSnFc9VQTPKGvhGYY
         dNJocB9NZvp0kkDdavHRZWnkJnFlWEugi+9YD86YLxZ6JPWf6jAzeWzVVgK53GIYLJg9
         Bj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTM0gFp5KxvcXFhrslPw+2Glr7b468eMGXFy1OhWB+c=;
        b=57YXdZQva8Lr/QX0KGDoM2HWnFkIKI3MacIuWBphxHsLGRZcWqkDyku0E3IoBw4idq
         6RC++VaRNnZ/a52JkNtrkrE3TTEpQkUgJ+nxC0o2rR1XC98Jc0tB2OQaIzF61J1yC90O
         PLoQWVxkH04jTvoHZnStAL01U7LpoJeth4u0NJP6VjeNKRphN+fvcnziNfGMKtP0b6xU
         feN1+d8zAAgCYWIcVHjYc6EiXG79Jo6gO735jeONvAQI1co7H1yvddqWw+lPNSVynBEB
         MYl9yTF9XEZDMP5cGHzlwuvuPWHHlBqGQVwosZSU+nk3XKPVjXQY6I8JkEngp7Zte3Nc
         aH6w==
X-Gm-Message-State: AO0yUKXQlMwbtUR7HWVtXRa8SJcMZsQMxoqh9uHg4eRS4uvUHEeMtaeU
        2BMKE3edowSML9ChS2RLnDRMP3er2in0HaOJ
X-Google-Smtp-Source: AMrXdXs5wVjJyw/spbdn3FgvnpaB52FILs+zVilUoFZzcqbG4OecsUQD3ZOFRjBOJvhGJ9LJ26nDxg==
X-Received: by 2002:a05:600c:1906:b0:3da:1d51:ef9d with SMTP id j6-20020a05600c190600b003da1d51ef9dmr40163633wmq.15.1674820491790;
        Fri, 27 Jan 2023 03:54:51 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id g12-20020a05600c310c00b003db012d49b7sm15012012wmo.2.2023.01.27.03.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 03:54:51 -0800 (PST)
Date:   Fri, 27 Jan 2023 13:54:49 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v2 7/8] arm64: dts: qcom: sm8550: Add USB PHYs and
 controller nodes
Message-ID: <Y9O7iVXN1AgsRQKi@linaro.org>
References: <20230126124651.1362533-1-abel.vesa@linaro.org>
 <20230126124651.1362533-8-abel.vesa@linaro.org>
 <2d368c6f-5240-8aec-ef27-a86b2a361856@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d368c6f-5240-8aec-ef27-a86b2a361856@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-01-27 12:51:05, Krzysztof Kozlowski wrote:
> On 26/01/2023 13:46, Abel Vesa wrote:
> > Add USB host controller and PHY nodes.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> > 
> > NOTE: This patch has been already merged. It is here only to provide
> > context for the rest of the patchset. There is a change with respect to the
> > clocks, but that will be sent as a separate/individual fix patch.
> > 
> >  arch/arm64/boot/dts/qcom/sm8550.dtsi | 92 +++++++++++++++++++++++++++-
> >  1 file changed, 91 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> > index 4daf1f03d79f..6801454bbe10 100644
> > --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> > @@ -13,6 +13,7 @@
> >  #include <dt-bindings/mailbox/qcom-ipcc.h>
> >  #include <dt-bindings/power/qcom-rpmpd.h>
> >  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> > +#include <dt-bindings/phy/phy-qcom-qmp.h>
> >  #include <dt-bindings/thermal/thermal.h>
> >  
> >  / {
> > @@ -652,7 +653,7 @@ gcc: clock-controller@100000 {
> >  				 <&ufs_mem_phy 0>,
> >  				 <&ufs_mem_phy 1>,
> >  				 <&ufs_mem_phy 2>,
> > -				 <0>;
> > +				 <&usb_dp_qmpphy QMP_USB43DP_USB3_PIPE_CLK>;
> >  		};
> >  
> >  		ipcc: mailbox@408000 {
> > @@ -1924,6 +1925,95 @@ opp-202000000 {
> >  			};
> >  		};
> >  
> > +		usb_1_hsphy: phy@88e3000 {
> > +			compatible = "qcom,sm8550-snps-eusb2-phy";
> > +			reg = <0x0 0x088e3000 0x0 0x154>;
> > +			#phy-cells = <0>;
> > +
> > +			clocks = <&tcsr TCSR_USB2_CLKREF_EN>;
> > +			clock-names = "ref";
> > +
> > +			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
> > +
> > +			status = "disabled";
> > +		};
> > +
> > +		usb_dp_qmpphy: phy@88e8000 {
> > +			compatible = "qcom,sm8550-qmp-usb3-dp-phy";
> > +			reg = <0x0 0x088e8000 0x0 0x3000>;
> > +
> > +			clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
> > +				 <&rpmhcc RPMH_CXO_CLK>,
> > +				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>,
> > +				 <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
> > +			clock-names = "aux", "ref", "com_aux", "usb3_pipe";
> > +
> > +			power-domains = <&gcc USB3_PHY_GDSC>;
> > +
> > +			resets = <&gcc GCC_USB3_DP_PHY_PRIM_BCR>,
> > +				 <&gcc GCC_USB3_PHY_PRIM_BCR>;
> > +			reset-names = "phy", "common";
> > +
> > +			#clock-cells = <1>;
> > +			#phy-cells = <1>;
> > +
> > +			status = "disabled";
> > +		};
> > +
> > +		usb_1: usb@a6f8800 {
> > +			compatible = "qcom,sm8550-dwc3", "qcom,dwc3";
> > +			reg = <0x0 0x0a6f8800 0x0 0x400>;
> > +			#address-cells = <2>;
> > +			#size-cells = <2>;
> > +			ranges;
> > +
> > +			clocks = <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
> > +				 <&gcc GCC_USB30_PRIM_MASTER_CLK>,
> > +				 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
> > +				 <&gcc GCC_USB30_PRIM_SLEEP_CLK>,
> > +				 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
> > +				 <&rpmhcc TCSR_USB3_CLKREF_EN>;
> > +			clock-names = "cfg_noc",
> > +				      "core",
> > +				      "iface",
> > +				      "sleep",
> > +				      "mock_utmi",
> > +				      "xo";
> > +
> > +			assigned-clocks = <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
> > +					  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
> > +			assigned-clock-rates = <19200000>, <200000000>;
> > +
> > +			interrupts-extended = <&intc GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
> > +					      <&pdc 17 IRQ_TYPE_LEVEL_HIGH>,
> > +					      <&pdc 15 IRQ_TYPE_EDGE_RISING>,
> > +					      <&pdc 14 IRQ_TYPE_EDGE_RISING>;
> > +			interrupt-names = "hs_phy_irq",
> > +					  "ss_phy_irq",
> > +					  "dm_hs_phy_irq",
> > +					  "dp_hs_phy_irq";
> > +
> > +			power-domains = <&gcc USB30_PRIM_GDSC>;
> > +			required-opps = <&rpmhpd_opp_nom>;
> 
> This part was merged but it is not correct without [1]. Are we going to
> revive [1] or should we drop it?

Well, but this one has been merged as well for sc8280xp:
https://lore.kernel.org/all/20230112135117.3836655-1-quic_bjorande@quicinc.com/

> 
> [1] https://lore.kernel.org/all/YXcBK7zqny0s4gd4@ripper/
> 
> Best regards,
> Krzysztof
> 
