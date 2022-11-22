Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F08633DB5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 14:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbiKVNbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 08:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233693AbiKVNa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 08:30:58 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32F3654E9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 05:30:57 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id l14so5839729wrw.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 05:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xhgnmz4JLDUPDYg0/c7gyskX635DP4dIpgODub0/uF8=;
        b=OM9OQ2TBhf3NxrCHvoWSxShWPqD1EdyIGGwF7PJWunmq7Mv07qfDBafDxpoJRynjUI
         1X4gNAdpBIc5ytXNO3DrQKB865+WxgacCriOfSetuxCiPtSJuQoZDXn8ikub5XzDNQjH
         WruXwk8h/wRExl9c/+NGagnUjk1aNGEAVh1T8Bxx4rk8NCHWp2neMc3NKNR2ijEpGQft
         6P/765XjcU64My5cpOl3+pBBQSd0bYPGpfAVpN5wnBYX/S84Jl3r4q2Vvw8qUt1bwdAS
         MpNoI//eBxDy8GSq59mfD4Qr56b/wiArz/xGZw0zhWIkkCfoxpFMAiFLzNJETu4Z5kf2
         LrhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xhgnmz4JLDUPDYg0/c7gyskX635DP4dIpgODub0/uF8=;
        b=EHM/pLclzm/mlPAiX18WUIRWnKaGccN07ZND1XJmpHulH8QkpvWMZKgLTtPF+hiITt
         G+tMTtMmWQspEeKu1ST/3w7pE9dDMMb0rCTlUS+763aR5Av1G01XEiESwN+EAXwuulbj
         twv4NxHKoOJT2VuN7JvgRWUsW9BcqJWfXwhi7fUwLz2CSG429nBonXoVH173SnT3KOTy
         40fyAUBfQR0dqE9R70YRa29wmOyJWPaq3p9ppxvv10TTeFom4tAZ8A9kQE8WSFsLEZwA
         SdgI/PJN23siExdlnA96r8w7C8RzhDc5WZ67EUpp+92pCJGC8DrJDgNLg5L4TESM5SIm
         0sKQ==
X-Gm-Message-State: ANoB5pmZsCjji+kiQFRyPaeyUNh7JkIRmPU0g0C/FmYNOVr8/ITlyj8N
        FfZuRy2ZKBr72Rz4DR2142W7qoZCWyTOXw==
X-Google-Smtp-Source: AA0mqf58OErkZHDD/XuKjIhLRpoeRyi4CqIQe6iwouFVrBa7sR1mJ0lkF3quWd1sJitqDrVjlMl4fw==
X-Received: by 2002:adf:a546:0:b0:234:d3ce:6b32 with SMTP id j6-20020adfa546000000b00234d3ce6b32mr14120323wrb.718.1669123856120;
        Tue, 22 Nov 2022 05:30:56 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id m17-20020adfdc51000000b0023677e1157fsm13967450wrj.56.2022.11.22.05.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 05:30:55 -0800 (PST)
Date:   Tue, 22 Nov 2022 15:30:54 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sm8550: Add PCIe PHYs and
 controllers nodes
Message-ID: <Y3zPDkIAVvoS9MvB@linaro.org>
References: <20221116130430.2812173-1-abel.vesa@linaro.org>
 <20221116130430.2812173-2-abel.vesa@linaro.org>
 <Y3TnoIqXSSimqySN@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3TnoIqXSSimqySN@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-11-16 14:37:36, Johan Hovold wrote:
> On Wed, Nov 16, 2022 at 03:04:29PM +0200, Abel Vesa wrote:
> > Add PCIe controllers and PHY nodes.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sm8550.dtsi | 245 +++++++++++++++++++++++++++
> >  1 file changed, 245 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> > index 07ba709ca35f..5c274d0372ad 100644
> > --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
>  				 <&ufs_phy_rx_symbol_1_clk>,
> > @@ -1372,6 +1376,247 @@ mmss_noc: interconnect@1780000 {
> >  			qcom,bcm-voters = <&apps_bcm_voter>;
> >  		};
> >  
> > +		pcie0: pci@1c00000 {
> > +			compatible = "qcom,pcie-sm8550-pcie0";
> > +			reg = <0 0x01c00000 0 0x3000>,
> > +			      <0 0x60000000 0 0xf1d>,
> > +			      <0 0x60000f20 0 0xa8>,
> > +			      <0 0x60001000 0 0x1000>,
> > +			      <0 0x60100000 0 0x100000>;
> > +			reg-names = "parf", "dbi", "elbi", "atu", "config";
> > +			device_type = "pci";
> > +			linux,pci-domain = <0>;
> > +			bus-range = <0x00 0xff>;
> > +			num-lanes = <2>;
> > +
> > +			#address-cells = <3>;
> > +			#size-cells = <2>;
> > +
> > +			ranges = <0x01000000 0x0 0x60200000 0 0x60200000 0x0 0x100000>,
> > +				 <0x02000000 0x0 0x60300000 0 0x60300000 0x0 0x3d00000>;
> > +
> > +			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
> > +			interrupt-names = "msi";
> > +			#interrupt-cells = <1>;
> > +			interrupt-map-mask = <0 0 0 0x7>;
> > +			interrupt-map = <0 0 0 1 &intc 0 0 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
> > +					<0 0 0 2 &intc 0 0 0 150 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
> > +					<0 0 0 3 &intc 0 0 0 151 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
> > +					<0 0 0 4 &intc 0 0 0 152 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
> > +
> > +			interconnect-names = "icc_path";
> > +			interconnects = <&pcie_noc MASTER_PCIE_0 0 &mc_virt SLAVE_EBI1 0>;
> > +
> > +			clocks = <&gcc GCC_PCIE_0_PIPE_CLK>,
> > +				 <&gcc GCC_PCIE_0_PIPE_CLK_SRC>,
> > +				 <&pcie0_lane>,
> > +				 <&rpmhcc RPMH_CXO_CLK>,
> 
> As I mentioned in my comment to the binding, the above three clocks
> should not be here but rather be handled by the clock driver.

Sure, will do.

> 
> > +				 <&gcc GCC_PCIE_0_AUX_CLK>,
> > +				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
> > +				 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
> > +				 <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
> > +				 <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>,
> > +				 <&gcc GCC_DDRSS_PCIE_SF_QTB_CLK>,
> > +				 <&gcc GCC_AGGRE_NOC_PCIE_AXI_CLK>;
> > +			clock-names = "pipe",
> > +					"pipe_mux",
> > +					"phy_pipe",
> > +					"ref",
> > +					"aux",
> > +					"cfg",
> > +					"bus_master",
> > +					"bus_slave",
> > +					"slave_q2a",
> > +					"ddrss_sf_tbu",
> > +					"aggre0";
> > +
> > +			iommus = <&apps_smmu 0x1400 0x7f>;
> > +			iommu-map = <0x0   &apps_smmu 0x1400 0x1>,
> > +				    <0x100 &apps_smmu 0x1401 0x1>;
> > +
> > +			resets = <&gcc GCC_PCIE_0_BCR>;
> > +			reset-names = "pci";
> > +
> > +			power-domains = <&gcc PCIE_0_GDSC>;
> > +			power-domain-names = "gdsc";
> > +
> > +			phys = <&pcie0_lane>;
> > +			phy-names = "pciephy";
> > +
> > +			perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
> > +			wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
> > +
> > +			pinctrl-names = "default";
> > +			pinctrl-0 = <&pcie0_default_state>;
> > +
> > +			status = "disabled";
> > +		};
> > +
> > +		pcie0_phy: phy@1c06000 {
> > +			compatible = "qcom,sm8550-qmp-gen3x2-pcie-phy";
> 
> Where's the corresponding binding update?
> 

Here:
https://lore.kernel.org/all/20221116120157.2706810-7-abel.vesa@linaro.org/

> > +			reg = <0 0x01c06000 0 0x200>;
> > +			#address-cells = <2>;
> > +			#size-cells = <2>;
> > +			ranges;
> > +			clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
> > +				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
> > +				 <&tcsr TCSR_PCIE_0_CLKREF_EN>,
> > +				 <&gcc GCC_PCIE_0_PHY_RCHNG_CLK>;
> > +			clock-names = "aux", "cfg_ahb", "ref", "refgen";
> > +
> > +			resets = <&gcc GCC_PCIE_0_PHY_BCR>;
> > +			reset-names = "phy";
> > +
> > +			assigned-clocks = <&gcc GCC_PCIE_0_PHY_RCHNG_CLK>;
> > +			assigned-clock-rates = <100000000>;
> > +
> > +			power-domains = <&gcc PCIE_0_PHY_GDSC>;
> > +			power-domain-names = "gdsc";
> > +
> > +			status = "disabled";
> > +
> > +			pcie0_lane: phy@1c06200 {
> > +				reg = <0 0x1c06e00 0 0x200>, /* tx0 */
> > +				      <0 0x1c07000 0 0x200>, /* rx0 */
> > +				      <0 0x1c06200 0 0x200>, /* pcs */
> > +				      <0 0x1c07600 0 0x200>, /* tx1 */
> > +				      <0 0x1c07800 0 0x200>, /* rx1 */
> > +				      <0 0x1c06600 0 0x200>; /* pcs_pcie */
> > +				clocks = <&gcc GCC_PCIE_0_PIPE_CLK>;
> > +				clock-names = "pipe0";
> > +
> > +				#clock-cells = <0>;
> > +				#phy-cells = <0>;
> > +				clock-output-names = "pcie_0_pipe_clk";
> > +			};
> 
> These PHY nodes should also be updated to the new binding scheme which
> drops the child node and individual register descriptions (cf.
> sc8280xp).

Sure, will do.

> 
> Johan
