Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C278A71040E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbjEYEYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbjEYEXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:23:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847FB1A4;
        Wed, 24 May 2023 21:23:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D99164292;
        Thu, 25 May 2023 04:23:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8B4C433D2;
        Thu, 25 May 2023 04:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684988599;
        bh=ToeWW3ZgoTCQO0LdvxeiuHZQHmafEqitwRCapGbXRXM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oLYAcYlS6oEISnvDvoyAwg4R4DDv9d3s3Mtu9Biz/Jko+oGF6Nxh2xu3IAlQrpTtn
         gbefovXS+LjRPDD480HJ+9bx5/AkUkCoivkWYERCRr8ay/RWjiAiv51Cqo3p6Pf44X
         KyLYPVWa8ou84QcesLlZmaUvwDkY4o5aozmFwdH7I0MEs4z7/CA1d8QJdvNOPm6RA9
         lFz2RjvWpvjkVNjp0H8CbFrF17yi32C9hLMPCWcZ+e2fGr9pPbj/Gvb6OG8FxQGP8/
         w4YMO3ye8qMCHpuvfvonuRTE8pZcq6Aqt0hyuARuKqKG53UsjC7zrZnK9cx2yxMVhC
         GdMk9WUhZD36g==
Date:   Wed, 24 May 2023 21:27:09 -0700
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
Subject: Re: [PATCH v3 2/4] arm: dts: qcom: qdu1000: Add SDHCI node
Message-ID: <20230525042709.czmuxdbshsneskrs@ripper>
References: <20230523135733.3852-1-quic_kbajaj@quicinc.com>
 <20230523135733.3852-3-quic_kbajaj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523135733.3852-3-quic_kbajaj@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 07:27:31PM +0530, Komal Bajaj wrote:
> Add sdhc node for eMMC on QDU1000 and QRU1000 SoCs.
> 

Please fix your $subject prefix, it should say arm64

Regards,
Bjorn

> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qdu1000.dtsi | 47 +++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
> index 734438113bba..6df07334f1d3 100644
> --- a/arch/arm64/boot/dts/qcom/qdu1000.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
> @@ -842,6 +842,53 @@
>  			#hwlock-cells = <1>;
>  		};
> 
> +		sdhc: mmc@8804000 {
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
