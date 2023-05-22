Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB6670C196
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 16:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbjEVO5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 10:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233883AbjEVO5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 10:57:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43124BB;
        Mon, 22 May 2023 07:57:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C169961AFE;
        Mon, 22 May 2023 14:57:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514ADC433D2;
        Mon, 22 May 2023 14:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684767431;
        bh=ThXECPaDh9Oj7V7+VzqTXFJWN8ADA2MjHyWE9rB8dPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pIpKE/DgQZtCWf7SiEQ+irFRq6pTLepH9Tg10WqNGBz7VesKSG/uV9y3p5g3bfcsl
         FQE2Nao9jS3bgj8oJasHdsqWDLmHAMJQ84p7Dxak2W8M7eVpGJYwom3Ey/sg8GM+Ei
         P/K13ZTA6wBGlLTaGwRkgGL4rzfl/RhpI8hR7BamUDmxtnwjcw4quYf2PaXH1TIHuI
         fczfPBWI1gjAEkpYhsWDI74z50as3+CLy/A45h8FX1GCjUzkdywtRixdvkq+gKNQoQ
         /zVx6QajqY7afz7EaR4d5o4QUSVE8h1gaRD2902iU+IKrenHGqPA/4zQMr1Ae37D0W
         XYga9WMhrEU+g==
Date:   Mon, 22 May 2023 08:01:05 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Komal Bajaj <quic_kbajaj@quicinc.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 2/4] arm: dts: qcom: qdu1000: Add SDHCI node
Message-ID: <20230522150105.3i7zeucna7kh5waz@ripper>
References: <20230522093620.3568-1-quic_kbajaj@quicinc.com>
 <20230522093620.3568-3-quic_kbajaj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522093620.3568-3-quic_kbajaj@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 03:06:18PM +0530, Komal Bajaj wrote:

Path says arch/arm64/, so $subject should start "arm64: dts: qcom: ..."

> Add sdhc node for eMMC on QDU1000 and QRU1000 SoCs.
> 
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qdu1000.dtsi | 51 +++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
> index 734438113bba..38ee7115a35f 100644
> --- a/arch/arm64/boot/dts/qcom/qdu1000.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
> @@ -19,6 +19,10 @@
>  
>  	chosen: chosen { };
>  
> +	aliases {
> +		mmc0 = &sdhc_1; /* eMMC */

Don't we just have a single SDC instance on this platform? If so you
don't need aliases.

> +	};
> +
>  	cpus {
>  		#address-cells = <2>;
>  		#size-cells = <0>;
> @@ -842,6 +846,53 @@
>  			#hwlock-cells = <1>;
>  		};
>  
> +		sdhc_1: mmc@8804000 {

And you can skip the "_1" suffix...

Regards,
Bjorn

> +			compatible = "qcom,qdu1000-sdhci", "qcom,sdhci-msm-v5";
> +			reg = <0x0 0x08804000 0x0 0x1000>,
> +			      <0x0 0x08805000 0x0 0x1000>;
> +			reg-names = "hc", "cqhci";
> +
> +			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "hc_irq", "pwr_irq";
> +
> +			clocks = <&gcc GCC_SDCC5_AHB_CLK>,
> +				 <&gcc GCC_SDCC5_APPS_CLK>,
> +				 <&rpmhcc RPMH_CXO_CLK>;
> +			clock-names = "iface",
> +				      "core",
> +				      "xo";
> +
> +			resets = <&gcc GCC_SDCC5_BCR>;
> +
> +			interconnects = <&system_noc MASTER_SDCC_1 0 &mc_virt SLAVE_EBI1 0>,
> +					<&gem_noc MASTER_APPSS_PROC 0 &system_noc SLAVE_SDCC_2 0>;
> +			interconnect-names = "sdhc-ddr", "cpu-sdhc";
> +			power-domains = <&rpmhpd QDU1000_CX>;
> +			operating-points-v2 = <&sdhc1_opp_table>;
> +
> +			iommus = <&apps_smmu 0x80 0x0>;
> +			dma-coherent;
> +
> +			bus-width = <8>;
> +
> +			qcom,dll-config = <0x0007642c>;
> +			qcom,ddr-config = <0x80040868>;
> +
> +			status = "disabled";
> +
> +			sdhc1_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-384000000 {
> +					opp-hz = /bits/ 64 <384000000>;
> +					required-opps = <&rpmhpd_opp_nom>;
> +					opp-peak-kBps = <6528000 1652800>;
> +					opp-avg-kBps = <400000 0>;
> +				};
> +			};
> +		};
> +
>  		pdc: interrupt-controller@b220000 {
>  			compatible = "qcom,qdu1000-pdc", "qcom,pdc";
>  			reg = <0x0 0xb220000 0x0 0x30000>, <0x0 0x174000f0 0x0 0x64>;
> -- 
> 2.17.1
> 
