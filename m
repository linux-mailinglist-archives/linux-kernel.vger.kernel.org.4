Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7166BBFD0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 23:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjCOWcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 18:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjCOWcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 18:32:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B9711177;
        Wed, 15 Mar 2023 15:32:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2F1161E91;
        Wed, 15 Mar 2023 22:32:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A21EC433EF;
        Wed, 15 Mar 2023 22:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678919563;
        bh=s4mFT5cQaZYw16F9Jn8Da59Et71foMkrNhJeBAo9828=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XXL6hCk0EAuR+bjsya37oWGnLpx07VfOBDXwYAVXLpD1GpD/Db+toqRf1gIebYq5y
         29mR0ac2ndIUWq77hARKwfp+/8i+PdYia7KUboavMuSvlyEebS83Gv1S2jwUm+dSnn
         dSWR8/4qYjl5b0ZgSOprHk61hlyf3YlwuNutbG90B/GfJtS6NUHEuoFp1mpeisDNh7
         VxSwQqfHTM91nAZ6qnikz/irYD66Rbr2hgc24UBP26ffYRjPBcf9/4GTdpRyAede+5
         g715Gr1IDOITTSVc4DbsjsGm8Scqb3VDDZcMi4crxT8N7Pkn5fXbp2wy6zcp/ExnYI
         MCk2RmClISO5Q==
Date:   Wed, 15 Mar 2023 15:36:04 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: Add base qrb4210-rb2 board dts
Message-ID: <20230315223604.ofy7vm3bpccf5aul@ripper>
References: <20230315210145.2221116-1-bhupesh.sharma@linaro.org>
 <20230315210145.2221116-3-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315210145.2221116-3-bhupesh.sharma@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 02:31:45AM +0530, Bhupesh Sharma wrote:
> Add DTS for Qualcomm qrb4210-rb2 board which uses SM4250 SoC.
> 
> This adds debug uart, emmc, uSD and tlmm support along with
> regulators found on this board.
> 
> Also defines the 'xo_board' and 'sleep_clk' frequencies for
> this board.
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/Makefile        |   1 +
>  arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 224 +++++++++++++++++++++++
>  2 files changed, 225 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 89e23a74bc7f..101ac733422c 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -69,6 +69,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-xiaomi-sagit.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-1000.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qdu1000-idp.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= qrb4210-rb2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qrb5165-rb5.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qrb5165-rb5-vision-mezzanine.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qru1000-idp.dtb
> diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> new file mode 100644
> index 000000000000..c70c532ba721
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> @@ -0,0 +1,224 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2023, Linaro Limited
> + */
> +
> +/dts-v1/;
> +
> +#include "sm4250.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. QRB4210 RB2";
> +	compatible = "qcom,qrb4210-rb2", "qcom,qrb4210", "qcom,sm4250";
> +
> +	aliases {
> +		serial0 = &uart4;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
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
> +	};
> +};
> +
> +&qupv3_id_0 {
> +	status = "okay";
> +};
> +
> +&rpm_requests {
> +	regulators {
> +		compatible = "qcom,rpm-pm6125-regulators";
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
> +		vdd-l1-l7-l17-l18-supply = <&vreg_s6a_1p352>;
> +		vdd-l2-l3-l4-supply = <&vreg_s6a_1p352>;
> +		vdd-l5-l15-l19-l20-l21-l22-supply = <&vph_pwr>;
> +		vdd-l6-l8-supply = <&vreg_s5a_0p848>;
> +		vdd-l9-l11-supply = <&vreg_s7a_2p04>;
> +		vdd-l10-l13-l14-supply = <&vreg_s7a_2p04>;
> +		vdd-l12-l16-supply = <&vreg_s7a_2p04>;
> +		vdd-l23-l24-supply = <&vph_pwr>;
> +
> +		vreg_s5a_0p848: s5 {
> +			regulator-min-microvolt = <920000>;
> +			regulator-max-microvolt = <1128000>;
> +		};
> +
> +		vreg_s6a_1p352: s6 {
> +			regulator-min-microvolt = <304000>;
> +			regulator-max-microvolt = <1456000>;
> +		};
> +
> +		vreg_s7a_2p04: s7 {
> +			regulator-min-microvolt = <1280000>;
> +			regulator-max-microvolt = <2080000>;
> +		};
> +
> +		vreg_l1a_1p0: l1 {
> +			regulator-min-microvolt = <952000>;
> +			regulator-max-microvolt = <1152000>;
> +		};
> +
> +		vreg_l4a_0p9: l4 {
> +			regulator-min-microvolt = <488000>;
> +			regulator-max-microvolt = <1000000>;
> +		};
> +
> +		vreg_l5a_2p96: l5 {
> +			regulator-min-microvolt = <1648000>;
> +			regulator-max-microvolt = <3056000>;
> +		};
> +
> +		vreg_l6a_0p6: l6 {
> +			regulator-min-microvolt = <576000>;
> +			regulator-max-microvolt = <656000>;
> +		};
> +
> +		vreg_l7a_1p256: l7 {
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1304000>;
> +		};
> +
> +		vreg_l8a_0p664: l8 {
> +			regulator-min-microvolt = <400000>;
> +			regulator-max-microvolt = <728000>;
> +		};
> +
> +		vreg_l9a_1p8: l9 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <2000000>;
> +		};
> +
> +		vreg_l10a_1p8: l10 {
> +			regulator-min-microvolt = <1704000>;
> +			regulator-max-microvolt = <1904000>;
> +		};
> +
> +		vreg_l11a_1p8: l11 {
> +			regulator-min-microvolt = <1704000>;
> +			regulator-max-microvolt = <1952000>;
> +		};
> +
> +		vreg_l12a_1p8: l12 {
> +			regulator-min-microvolt = <1624000>;
> +			regulator-max-microvolt = <1984000>;
> +		};
> +
> +		vreg_l13a_1p8: l13 {
> +			regulator-min-microvolt = <1504000>;
> +			regulator-max-microvolt = <1952000>;
> +		};
> +
> +		vreg_l14a_1p8: l14 {
> +			regulator-min-microvolt = <1704000>;
> +			regulator-max-microvolt = <1904000>;
> +		};
> +
> +		vreg_l15a_3p128: l15 {
> +			regulator-min-microvolt = <2920000>;
> +			regulator-max-microvolt = <3232000>;
> +		};
> +
> +		vreg_l16a_1p3: l16 {
> +			regulator-min-microvolt = <1704000>;
> +			regulator-max-microvolt = <1904000>;
> +		};
> +
> +		vreg_l17a_1p3: l17 {
> +			regulator-min-microvolt = <1152000>;
> +			regulator-max-microvolt = <1384000>;
> +		};
> +
> +		vreg_l18a_1p232: l18 {
> +			regulator-min-microvolt = <1104000>;
> +			regulator-max-microvolt = <1312000>;
> +		};
> +
> +		vreg_l19a_1p8: l19 {
> +			regulator-min-microvolt = <1624000>;
> +			regulator-max-microvolt = <3304000>;
> +		};
> +
> +		vreg_l20a_1p8: l20 {
> +			regulator-min-microvolt = <2504000>;
> +			regulator-max-microvolt = <2960000>;
> +		};
> +
> +		vreg_l21a_2p704: l21 {
> +			regulator-min-microvolt = <2504000>;
> +			regulator-max-microvolt = <2960000>;
> +		};
> +
> +		vreg_l22a_2p96: l22 {
> +			regulator-min-microvolt = <2504000>;
> +			regulator-max-microvolt = <2960000>;
> +		};
> +
> +		vreg_l23a_3p3: l23 {
> +			regulator-min-microvolt = <2504000>;
> +			regulator-max-microvolt = <2960000>;
> +		};
> +
> +		vreg_l24a_2p96: l24 {
> +			regulator-min-microvolt = <2504000>;
> +			regulator-max-microvolt = <2960000>;
> +		};
> +	};
> +};
> +
> +&sdhc_1 {
> +	status = "okay";

Please keep status as the last property.

> +
> +	vmmc-supply = <&vreg_l24a_2p96>;

Is there any reason why this platform doesn't require the vmmc supply to
be driven to HPM? This has traditionally been coming back biting us
through some stability issues later.

Regards,
Bjorn

> +	vqmmc-supply = <&vreg_l11a_1p8>;
> +	no-sdio;
> +	non-removable;
> +};
> +
> +&sdhc_2 {
> +	status = "okay";
> +
> +	cd-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>; /* card detect gpio */
> +	vmmc-supply = <&vreg_l22a_2p96>;
> +	vqmmc-supply = <&vreg_l5a_2p96>;
> +	no-sdio;
> +};
> +
> +&sleep_clk {
> +	clock-frequency = <32000>;
> +};
> +
> +&tlmm {
> +	gpio-reserved-ranges = <37 5>, <43 2>, <47 1>,
> +			       <49 1>, <52 1>, <54 1>,
> +			       <56 3>, <61 2>, <64 1>,
> +			       <68 1>, <72 8>, <96 1>;
> +};
> +
> +&uart4 {
> +	status = "okay";
> +};
> +
> +&xo_board {
> +	clock-frequency = <19200000>;
> +};
> -- 
> 2.38.1
> 
