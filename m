Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52E763FF21
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 04:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbiLBDjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 22:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbiLBDjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 22:39:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01C660B52;
        Thu,  1 Dec 2022 19:37:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39126B82032;
        Fri,  2 Dec 2022 03:37:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A91DC433C1;
        Fri,  2 Dec 2022 03:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669952244;
        bh=UgNxOKtzxKAExmbF27EWF+5/WT0/mqMnXQRBYfafEiU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AobHDbYHd6/m/AZf++A0aVoHKyPUrF4h8f/t1AQlFmGp/tLJuq4zOOX4hwgUsVu+O
         3cO4IzXYpTU52iWgU3YjXyInwbjfZFBcpvpzNp3i7HF5IhcFImVX/QDujmGMA8NSmm
         62nRW4OnjKL6UGQUwuggkIk4FYX6yz7OGSup2SoeCRIipCwHH26dEMugVMUHFsgKnn
         VNxE1OOsHqPPDMvhBuQiIC7ZWG1kpv7iJiYmoG7DSknfmO7je+Dsvl3Se+fUTZZ/0s
         FtYX6TQEfg8t6OjwefmPUUspY9iYDtGE3qW8vRwjDh5KutsXKBN806qfleDUo3deDr
         ts5jPGJUBJxDA==
Date:   Thu, 1 Dec 2022 21:37:21 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Melody Olvera <quic_molvera@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] arm64: dts: qcom: Add base QDU1000/QRU1000 IDP DTs
Message-ID: <20221202033721.4slwz2utw5u6rv7b@builder.lan>
References: <20221118192241.29384-1-quic_molvera@quicinc.com>
 <20221118192241.29384-3-quic_molvera@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118192241.29384-3-quic_molvera@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 11:22:41AM -0800, Melody Olvera wrote:
> Add DTs for Qualcomm IDP platforms using the QDU1000 and QRU1000
> SoCs.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile        |   2 +
>  arch/arm64/boot/dts/qcom/qdu1000-idp.dts | 266 +++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/qru1000-idp.dts | 266 +++++++++++++++++++++++
>  3 files changed, 534 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/qru1000-idp.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index afe496a93f94..da66d4a0a884 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -53,7 +53,9 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-sony-xperia-yoshino-maple.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-sony-xperia-yoshino-poplar.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-1000.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= qdu1000-idp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qrb5165-rb5.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= qru1000-idp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sa8155p-adp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sa8295p-adp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-idp.dtb
> diff --git a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
> new file mode 100644
> index 000000000000..5aed483201fa
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
> @@ -0,0 +1,266 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +#include "qdu1000.dtsi"
> +#include "pm8150.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. QDU1000 IDP";
> +	compatible = "qcom,qdu1000-idp", "qcom,qdu1000";
> +
> +	aliases {
> +		serial0 = &uart7;
> +	};
> +
> +	clocks {
> +		xo_board: xo-board {

Please add a -clk suffix to the node name.

> +			compatible = "fixed-clock";
> +			clock-frequency = <19200000>;
> +			clock-output-names = "xo_board";

Nothing should rely on this name, so please don't specify it.

> +			#clock-cells = <0>;
> +		};
> +
> +		sleep_clk: sleep-clk {
> +			compatible = "fixed-clock";
> +			clock-frequency = <32000>;
> +			#clock-cells = <0>;
> +		};
> +
> +		pcie_0_pipe_clk: pcie-0-pipe-clk {

Afaict these clocks are not referenced anywhere, so please skip them.

> +			compatible = "fixed-clock";
> +			clock-frequency = <1000>;
> +			clock-output-names = "pcie_0_pipe_clk";
> +			#clock-cells = <0>;
> +		};
> +
> +		pcie_0_phy_aux_clk: pcie-0-phy-aux-clk {
> +			compatible = "fixed-clock";
> +			clock-frequency = <1000>;
> +			clock-output-names = "pcie_0_phy_aux_clk";
> +			#clock-cells = <0>;
> +		};
> +
> +		usb3_phy_wrapper_pipe_clk: usb3-phy-wrapper-pipe-clk {
> +			compatible = "fixed-clock";
> +			clock-frequency = <1000>;
> +			clock-output-names = "usb3_phy_wrapper_pipe_clk";
> +			#clock-cells = <0>;
> +		};
> +	};
> +
> +	chosen {

"ch" < "cl", so please move this up.

> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	ppvar_sys: ppvar-sys-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "ppvar_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vph_pwr: vph-pwr-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vph_pwr";
> +		regulator-min-microvolt = <3700000>;
> +		regulator-max-microvolt = <3700000>;
> +
> +		regulator-always-on;
> +		regulator-boot-on;
> +
> +		vin-supply = <&ppvar_sys>;
> +	};
> +};
> +
> +&apps_rsc {
> +	regulators {

Seems like this is supposed to match -regulators$, so how about
pm8150-regulators?

Regards,
Bjorn

> +		compatible = "qcom,pm8150-rpmh-regulators";
> +		qcom,pmic-id = "a";
> +
> +		vdd-s1-supply = <&vph_pwr>;
> +		vdd-s2-supply = <&vph_pwr>;
> +		vdd-s3-supply = <&vph_pwr>;
> +		vdd-s4-supply = <&vph_pwr>;
> +		vdd-s5-supply = <&vph_pwr>;
> +		vdd-s6-supply = <&vph_pwr>;
> +		vdd-s7-supply = <&vph_pwr>;
> +		vdd-s8-supply = <&vph_pwr>;
> +		vdd-s9-supply = <&vph_pwr>;
> +		vdd-s10-supply = <&vph_pwr>;
> +
> +		vdd-l1-l8-l11-supply = <&vreg_s6a_0p9>;
> +		vdd-l2-l10-supply = <&vph_pwr>;
> +		vdd-l3-l4-l5-l18-supply = <&vreg_s5a_2p0>;
> +		vdd-l6-l9-supply = <&vreg_s6a_0p9>;
> +		vdd-l7-l12-l14-l15-supply = <&vreg_s4a_1p8>;
> +		vdd-l13-l16-l17-supply = <&vph_pwr>;
> +
> +		vreg_s2a_0p5: smps2 {
> +			regulator-name = "vreg_s2a_0p5";
> +			regulator-min-microvolt = <320000>;
> +			regulator-max-microvolt = <570000>;
> +		};
> +
> +		vreg_s3a_1p05: smps3 {
> +			regulator-name = "vreg_s3a_1p05";
> +			regulator-min-microvolt = <950000>;
> +			regulator-max-microvolt = <1170000>;
> +		};
> +
> +		vreg_s4a_1p8: smps4 {
> +			regulator-name = "vreg_s4a_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +		};
> +
> +		vreg_s5a_2p0: smps5 {
> +			regulator-name = "vreg_s5a_2p0";
> +			regulator-min-microvolt = <1904000>;
> +			regulator-max-microvolt = <2000000>;
> +		};
> +
> +		vreg_s6a_0p9: smps6 {
> +			regulator-name = "vreg_s6a_0p9";
> +			regulator-min-microvolt = <920000>;
> +			regulator-max-microvolt = <1128000>;
> +		};
> +
> +		vreg_s7a_1p2: smps7 {
> +			regulator-name = "vreg_s7a_1p2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +		};
> +
> +		vreg_s8a_1p3: smps8 {
> +			regulator-name = "vreg_s8a_1p3";
> +			regulator-min-microvolt = <1352000>;
> +			regulator-max-microvolt = <1352000>;
> +		};
> +
> +		vreg_l1a_0p91: ldo1 {
> +			regulator-name = "vreg_l1a_0p91";
> +			regulator-min-microvolt = <312000>;
> +			regulator-max-microvolt = <1304000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l2a_2p3: ldo2 {
> +			regulator-name = "vreg_l2a_2p3";
> +			regulator-min-microvolt = <2970000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l3a_1p2: ldo3 {
> +			regulator-name = "vreg_l3a_1p2";
> +			regulator-min-microvolt = <920000>;
> +			regulator-max-microvolt = <1260000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l5a_0p8: ldo5 {
> +			regulator-name = "vreg_l5a_0p8";
> +			regulator-min-microvolt = <312000>;
> +			regulator-max-microvolt = <1304000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l6a_0p91: ldo6 {
> +			regulator-name = "vreg_l6a_0p91";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <950000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l7a_1p8: ldo7 {
> +			regulator-name = "vreg_l7a_1p8";
> +			regulator-min-microvolt = <1650000>;
> +			regulator-max-microvolt = <2000000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +
> +		};
> +
> +		vreg_l8a_0p91: ldo8 {
> +			regulator-name = "vreg_l8a_0p91";
> +			regulator-min-microvolt = <888000>;
> +			regulator-max-microvolt = <925000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l9a_0p91: ldo9 {
> +			regulator-name = "vreg_l8a_0p91";
> +			regulator-min-microvolt = <312000>;
> +			regulator-max-microvolt = <1304000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l10a_2p95: ldo10 {
> +			regulator-name = "vreg_l10a_2p95";
> +			regulator-min-microvolt = <2700000>;
> +			regulator-max-microvolt = <3544000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l11a_0p91: ldo11 {
> +			regulator-name = "vreg_l11a_0p91";
> +			regulator-min-microvolt = <800000>;
> +			regulator-max-microvolt = <1000000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l12a_1p8: ldo12 {
> +			regulator-name = "vreg_l12a_1p8";
> +			regulator-min-microvolt = <1504000>;
> +			regulator-max-microvolt = <1504000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l14a_1p8: ldo14 {
> +			regulator-name = "vreg_l14a_1p8";
> +			regulator-min-microvolt = <1650000>;
> +			regulator-max-microvolt = <1950000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l15a_1p8: ldo15 {
> +			regulator-name = "vreg_l15a_1p8";
> +			regulator-min-microvolt = <1504000>;
> +			regulator-max-microvolt = <2000000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l16a_1p8: ldo16 {
> +			regulator-name = "vreg_l16a_1p8";
> +			regulator-min-microvolt = <1710000>;
> +			regulator-max-microvolt = <1890000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l17a_3p3: ldo17 {
> +			regulator-name = "vreg_l17a_3p3";
> +			regulator-min-microvolt = <3000000>;
> +			regulator-max-microvolt = <3544000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l18a_1p2: ldo18 {
> +			regulator-name = "vreg_l18a_1p2";
> +			regulator-min-microvolt = <312000>;
> +			regulator-max-microvolt = <1304000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +	};
> +};
> +
> +&qupv3_id_0 {
> +	status = "okay";
> +};
> +
> +&uart7 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/qru1000-idp.dts b/arch/arm64/boot/dts/qcom/qru1000-idp.dts
> new file mode 100644
> index 000000000000..42eb0c33e7ba
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/qru1000-idp.dts
> @@ -0,0 +1,266 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +#include "qru1000.dtsi"
> +#include "pm8150.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. QRU1000 IDP";
> +	compatible = "qcom,qru1000-idp", "qcom,qru1000";
> +
> +	aliases {
> +		serial0 = &uart7;
> +	};
> +
> +	clocks {
> +		xo_board: xo-board {
> +			compatible = "fixed-clock";
> +			clock-frequency = <19200000>;
> +			clock-output-names = "xo_board";
> +			#clock-cells = <0>;
> +		};
> +
> +		sleep_clk: sleep-clk {
> +			compatible = "fixed-clock";
> +			clock-frequency = <32000>;
> +			#clock-cells = <0>;
> +		};
> +
> +		pcie_0_pipe_clk: pcie-0-pipe-clk {
> +			compatible = "fixed-clock";
> +			clock-frequency = <1000>;
> +			clock-output-names = "pcie_0_pipe_clk";
> +			#clock-cells = <0>;
> +		};
> +
> +		pcie_0_phy_aux_clk: pcie-0-phy-aux-clk {
> +			compatible = "fixed-clock";
> +			clock-frequency = <1000>;
> +			clock-output-names = "pcie_0_phy_aux_clk";
> +			#clock-cells = <0>;
> +		};
> +
> +		usb3_phy_wrapper_pipe_clk: usb3-phy-wrapper-pipe-clk {
> +			compatible = "fixed-clock";
> +			clock-frequency = <1000>;
> +			clock-output-names = "usb3_phy_wrapper_pipe_clk";
> +			#clock-cells = <0>;
> +		};
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	ppvar_sys: ppvar-sys-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "ppvar_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vph_pwr: vph-pwr-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vph_pwr";
> +		regulator-min-microvolt = <3700000>;
> +		regulator-max-microvolt = <3700000>;
> +
> +		regulator-always-on;
> +		regulator-boot-on;
> +
> +		vin-supply = <&ppvar_sys>;
> +	};
> +};
> +
> +&apps_rsc {
> +	regulators {
> +		compatible = "qcom,pm8150-rpmh-regulators";
> +		qcom,pmic-id = "a";
> +
> +		vdd-s1-supply = <&vph_pwr>;
> +		vdd-s2-supply = <&vph_pwr>;
> +		vdd-s3-supply = <&vph_pwr>;
> +		vdd-s4-supply = <&vph_pwr>;
> +		vdd-s5-supply = <&vph_pwr>;
> +		vdd-s6-supply = <&vph_pwr>;
> +		vdd-s7-supply = <&vph_pwr>;
> +		vdd-s8-supply = <&vph_pwr>;
> +		vdd-s9-supply = <&vph_pwr>;
> +		vdd-s10-supply = <&vph_pwr>;
> +
> +		vdd-l1-l8-l11-supply = <&vreg_s6a_0p9>;
> +		vdd-l2-l10-supply = <&vph_pwr>;
> +		vdd-l3-l4-l5-l18-supply = <&vreg_s5a_2p0>;
> +		vdd-l6-l9-supply = <&vreg_s6a_0p9>;
> +		vdd-l7-l12-l14-l15-supply = <&vreg_s4a_1p8>;
> +		vdd-l13-l16-l17-supply = <&vph_pwr>;
> +
> +		vreg_s2a_0p5: smps2 {
> +			regulator-name = "vreg_s2a_0p5";
> +			regulator-min-microvolt = <320000>;
> +			regulator-max-microvolt = <570000>;
> +		};
> +
> +		vreg_s3a_1p05: smps3 {
> +			regulator-name = "vreg_s3a_1p05";
> +			regulator-min-microvolt = <950000>;
> +			regulator-max-microvolt = <1170000>;
> +		};
> +
> +		vreg_s4a_1p8: smps4 {
> +			regulator-name = "vreg_s4a_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +		};
> +
> +		vreg_s5a_2p0: smps5 {
> +			regulator-name = "vreg_s5a_2p0";
> +			regulator-min-microvolt = <1904000>;
> +			regulator-max-microvolt = <2000000>;
> +		};
> +
> +		vreg_s6a_0p9: smps6 {
> +			regulator-name = "vreg_s6a_0p9";
> +			regulator-min-microvolt = <920000>;
> +			regulator-max-microvolt = <1128000>;
> +		};
> +
> +		vreg_s7a_1p2: smps7 {
> +			regulator-name = "vreg_s7a_1p2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +		};
> +
> +		vreg_s8a_1p3: smps8 {
> +			regulator-name = "vreg_s8a_1p3";
> +			regulator-min-microvolt = <1352000>;
> +			regulator-max-microvolt = <1352000>;
> +		};
> +
> +		vreg_l1a_0p91: ldo1 {
> +			regulator-name = "vreg_l1a_0p91";
> +			regulator-min-microvolt = <312000>;
> +			regulator-max-microvolt = <1304000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l2a_2p3: ldo2 {
> +			regulator-name = "vreg_l2a_2p3";
> +			regulator-min-microvolt = <2970000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l3a_1p2: ldo3 {
> +			regulator-name = "vreg_l3a_1p2";
> +			regulator-min-microvolt = <920000>;
> +			regulator-max-microvolt = <1260000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l5a_0p8: ldo5 {
> +			regulator-name = "vreg_l5a_0p8";
> +			regulator-min-microvolt = <312000>;
> +			regulator-max-microvolt = <1304000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l6a_0p91: ldo6 {
> +			regulator-name = "vreg_l6a_0p91";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <950000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l7a_1p8: ldo7 {
> +			regulator-name = "vreg_l7a_1p8";
> +			regulator-min-microvolt = <1650000>;
> +			regulator-max-microvolt = <2000000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +
> +		};
> +
> +		vreg_l8a_0p91: ldo8 {
> +			regulator-name = "vreg_l8a_0p91";
> +			regulator-min-microvolt = <888000>;
> +			regulator-max-microvolt = <925000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l9a_0p91: ldo9 {
> +			regulator-name = "vreg_l8a_0p91";
> +			regulator-min-microvolt = <312000>;
> +			regulator-max-microvolt = <1304000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l10a_2p95: ldo10 {
> +			regulator-name = "vreg_l10a_2p95";
> +			regulator-min-microvolt = <2700000>;
> +			regulator-max-microvolt = <3544000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l11a_0p91: ldo11 {
> +			regulator-name = "vreg_l11a_0p91";
> +			regulator-min-microvolt = <800000>;
> +			regulator-max-microvolt = <1000000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l12a_1p8: ldo12 {
> +			regulator-name = "vreg_l12a_1p8";
> +			regulator-min-microvolt = <1504000>;
> +			regulator-max-microvolt = <1504000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l14a_1p8: ldo14 {
> +			regulator-name = "vreg_l14a_1p8";
> +			regulator-min-microvolt = <1650000>;
> +			regulator-max-microvolt = <1950000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l15a_1p8: ldo15 {
> +			regulator-name = "vreg_l15a_1p8";
> +			regulator-min-microvolt = <1504000>;
> +			regulator-max-microvolt = <2000000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l16a_1p8: ldo16 {
> +			regulator-name = "vreg_l16a_1p8";
> +			regulator-min-microvolt = <1710000>;
> +			regulator-max-microvolt = <1890000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l17a_3p3: ldo17 {
> +			regulator-name = "vreg_l17a_3p3";
> +			regulator-min-microvolt = <3000000>;
> +			regulator-max-microvolt = <3544000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l18a_1p2: ldo18 {
> +			regulator-name = "vreg_l18a_1p2";
> +			regulator-min-microvolt = <312000>;
> +			regulator-max-microvolt = <1304000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +	};
> +};
> +
> +&qupv3_id_0 {
> +	status = "okay";
> +};
> +
> +&uart7 {
> +	status = "okay";
> +};
> -- 
> 2.38.1
> 
