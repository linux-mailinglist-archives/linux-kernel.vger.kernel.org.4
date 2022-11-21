Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01EF632F9E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 23:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbiKUWPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 17:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiKUWPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 17:15:08 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931BCD92EE;
        Mon, 21 Nov 2022 14:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1669068906; x=1700604906;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kz5q7FX3t9X15cCohomDQRjyh2zCjIP9X4kXhv8xP9o=;
  b=Mdea3+vJDVXivkhe6V+nCOQ0l9DjvqalaIqQ1gU0tgq1GgSVmsBunX8J
   lTAihNjUS3nhuD+8gNx58d/RU+S95LD+Wz05ffrlZ7zThF+FGrLb6atBP
   /Dyk5Mo/4eY8dKD7/F860/KbZ4ILBpDdwslb0AuM1b6nkrKFWQNhDdBfy
   c=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 21 Nov 2022 14:15:06 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 14:15:05 -0800
Received: from [10.110.33.239] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 21 Nov
 2022 14:15:04 -0800
Message-ID: <85b7060c-4f52-b8bf-cb19-29068a0a9083@quicinc.com>
Date:   Mon, 21 Nov 2022 16:15:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4 2/2] arm64: dts: qcom: Add base QDU1000/QRU1000 IDP DTs
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221118192241.29384-1-quic_molvera@quicinc.com>
 <20221118192241.29384-3-quic_molvera@quicinc.com>
 <fed1d538-d133-6987-12d4-3f1516d519e5@linaro.org>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <fed1d538-d133-6987-12d4-3f1516d519e5@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/21/2022 5:07 AM, Konrad Dybcio wrote:
>
> On 18.11.2022 20:22, Melody Olvera wrote:
>> Add DTs for Qualcomm IDP platforms using the QDU1000 and QRU1000
>> SoCs.
>>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
>>  arch/arm64/boot/dts/qcom/Makefile        |   2 +
>>  arch/arm64/boot/dts/qcom/qdu1000-idp.dts | 266 +++++++++++++++++++++++
>>  arch/arm64/boot/dts/qcom/qru1000-idp.dts | 266 +++++++++++++++++++++++
>>  3 files changed, 534 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>>  create mode 100644 arch/arm64/boot/dts/qcom/qru1000-idp.dts
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>> index afe496a93f94..da66d4a0a884 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -53,7 +53,9 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-sony-xperia-yoshino-maple.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-sony-xperia-yoshino-poplar.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-1000.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)	+= qdu1000-idp.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= qrb5165-rb5.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)	+= qru1000-idp.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= sa8155p-adp.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= sa8295p-adp.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-idp.dtb
>> diff --git a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>> new file mode 100644
>> index 000000000000..5aed483201fa
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>> @@ -0,0 +1,266 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>> +#include "qdu1000.dtsi"
>> +#include "pm8150.dtsi"
>> +
>> +/ {
>> +	model = "Qualcomm Technologies, Inc. QDU1000 IDP";
>> +	compatible = "qcom,qdu1000-idp", "qcom,qdu1000";
> Missing chassis-type

Sorry, not sure what you mean here... Do you mean like QRD, HDK, MTP, etc.?
If so, then IDP is the chassis type.

>
>> +
>> +	aliases {
>> +		serial0 = &uart7;
>> +	};
>> +
>> +	clocks {
>> +		xo_board: xo-board {
>> +			compatible = "fixed-clock";
>> +			clock-frequency = <19200000>;
>> +			clock-output-names = "xo_board";
>> +			#clock-cells = <0>;
>> +		};
>> +
>> +		sleep_clk: sleep-clk {
>> +			compatible = "fixed-clock";
>> +			clock-frequency = <32000>;
>> +			#clock-cells = <0>;
>> +		};
>> +
>> +		pcie_0_pipe_clk: pcie-0-pipe-clk {
>> +			compatible = "fixed-clock";
>> +			clock-frequency = <1000>;
>> +			clock-output-names = "pcie_0_pipe_clk";
>> +			#clock-cells = <0>;
>> +		};
>> +
>> +		pcie_0_phy_aux_clk: pcie-0-phy-aux-clk {
>> +			compatible = "fixed-clock";
>> +			clock-frequency = <1000>;
>> +			clock-output-names = "pcie_0_phy_aux_clk";
>> +			#clock-cells = <0>;
>> +		};
>> +
>> +		usb3_phy_wrapper_pipe_clk: usb3-phy-wrapper-pipe-clk {
>> +			compatible = "fixed-clock";
>> +			clock-frequency = <1000>;
>> +			clock-output-names = "usb3_phy_wrapper_pipe_clk";
>> +			#clock-cells = <0>;
>> +		};
> Do these pipe clocks not come from QMPPHY?

Yes they do; I just don't have those phys ready yet. I can put a TODO here to
move them if necessary.

>
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial0:115200n8";
>> +	};
>> +
>> +	ppvar_sys: ppvar-sys-regulator {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "ppvar_sys";
> Any chance you could add the voltage of this regulator here,
> so the DT can better represent the hardware?

Sure.

Thanks,
Melody
> Konrad
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +	};
>> +
>> +	vph_pwr: vph-pwr-regulator {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vph_pwr";
>> +		regulator-min-microvolt = <3700000>;
>> +		regulator-max-microvolt = <3700000>;
>> +
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +
>> +		vin-supply = <&ppvar_sys>;
>> +	};
>> +};
>> +
>> +&apps_rsc {
>> +	regulators {
>> +		compatible = "qcom,pm8150-rpmh-regulators";
>> +		qcom,pmic-id = "a";
>> +
>> +		vdd-s1-supply = <&vph_pwr>;
>> +		vdd-s2-supply = <&vph_pwr>;
>> +		vdd-s3-supply = <&vph_pwr>;
>> +		vdd-s4-supply = <&vph_pwr>;
>> +		vdd-s5-supply = <&vph_pwr>;
>> +		vdd-s6-supply = <&vph_pwr>;
>> +		vdd-s7-supply = <&vph_pwr>;
>> +		vdd-s8-supply = <&vph_pwr>;
>> +		vdd-s9-supply = <&vph_pwr>;
>> +		vdd-s10-supply = <&vph_pwr>;
>> +
>> +		vdd-l1-l8-l11-supply = <&vreg_s6a_0p9>;
>> +		vdd-l2-l10-supply = <&vph_pwr>;
>> +		vdd-l3-l4-l5-l18-supply = <&vreg_s5a_2p0>;
>> +		vdd-l6-l9-supply = <&vreg_s6a_0p9>;
>> +		vdd-l7-l12-l14-l15-supply = <&vreg_s4a_1p8>;
>> +		vdd-l13-l16-l17-supply = <&vph_pwr>;
>> +
>> +		vreg_s2a_0p5: smps2 {
>> +			regulator-name = "vreg_s2a_0p5";
>> +			regulator-min-microvolt = <320000>;
>> +			regulator-max-microvolt = <570000>;
>> +		};
>> +
>> +		vreg_s3a_1p05: smps3 {
>> +			regulator-name = "vreg_s3a_1p05";
>> +			regulator-min-microvolt = <950000>;
>> +			regulator-max-microvolt = <1170000>;
>> +		};
>> +
>> +		vreg_s4a_1p8: smps4 {
>> +			regulator-name = "vreg_s4a_1p8";
>> +			regulator-min-microvolt = <1800000>;
>> +			regulator-max-microvolt = <1800000>;
>> +		};
>> +
>> +		vreg_s5a_2p0: smps5 {
>> +			regulator-name = "vreg_s5a_2p0";
>> +			regulator-min-microvolt = <1904000>;
>> +			regulator-max-microvolt = <2000000>;
>> +		};
>> +
>> +		vreg_s6a_0p9: smps6 {
>> +			regulator-name = "vreg_s6a_0p9";
>> +			regulator-min-microvolt = <920000>;
>> +			regulator-max-microvolt = <1128000>;
>> +		};
>> +
>> +		vreg_s7a_1p2: smps7 {
>> +			regulator-name = "vreg_s7a_1p2";
>> +			regulator-min-microvolt = <1200000>;
>> +			regulator-max-microvolt = <1200000>;
>> +		};
>> +
>> +		vreg_s8a_1p3: smps8 {
>> +			regulator-name = "vreg_s8a_1p3";
>> +			regulator-min-microvolt = <1352000>;
>> +			regulator-max-microvolt = <1352000>;
>> +		};
>> +
>> +		vreg_l1a_0p91: ldo1 {
>> +			regulator-name = "vreg_l1a_0p91";
>> +			regulator-min-microvolt = <312000>;
>> +			regulator-max-microvolt = <1304000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
>> +		};
>> +
>> +		vreg_l2a_2p3: ldo2 {
>> +			regulator-name = "vreg_l2a_2p3";
>> +			regulator-min-microvolt = <2970000>;
>> +			regulator-max-microvolt = <3300000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
>> +		};
>> +
>> +		vreg_l3a_1p2: ldo3 {
>> +			regulator-name = "vreg_l3a_1p2";
>> +			regulator-min-microvolt = <920000>;
>> +			regulator-max-microvolt = <1260000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
>> +		};
>> +
>> +		vreg_l5a_0p8: ldo5 {
>> +			regulator-name = "vreg_l5a_0p8";
>> +			regulator-min-microvolt = <312000>;
>> +			regulator-max-microvolt = <1304000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
>> +		};
>> +
>> +		vreg_l6a_0p91: ldo6 {
>> +			regulator-name = "vreg_l6a_0p91";
>> +			regulator-min-microvolt = <880000>;
>> +			regulator-max-microvolt = <950000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
>> +		};
>> +
>> +		vreg_l7a_1p8: ldo7 {
>> +			regulator-name = "vreg_l7a_1p8";
>> +			regulator-min-microvolt = <1650000>;
>> +			regulator-max-microvolt = <2000000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
>> +
>> +		};
>> +
>> +		vreg_l8a_0p91: ldo8 {
>> +			regulator-name = "vreg_l8a_0p91";
>> +			regulator-min-microvolt = <888000>;
>> +			regulator-max-microvolt = <925000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
>> +		};
>> +
>> +		vreg_l9a_0p91: ldo9 {
>> +			regulator-name = "vreg_l8a_0p91";
>> +			regulator-min-microvolt = <312000>;
>> +			regulator-max-microvolt = <1304000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
>> +		};
>> +
>> +		vreg_l10a_2p95: ldo10 {
>> +			regulator-name = "vreg_l10a_2p95";
>> +			regulator-min-microvolt = <2700000>;
>> +			regulator-max-microvolt = <3544000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
>> +		};
>> +
>> +		vreg_l11a_0p91: ldo11 {
>> +			regulator-name = "vreg_l11a_0p91";
>> +			regulator-min-microvolt = <800000>;
>> +			regulator-max-microvolt = <1000000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
>> +		};
>> +
>> +		vreg_l12a_1p8: ldo12 {
>> +			regulator-name = "vreg_l12a_1p8";
>> +			regulator-min-microvolt = <1504000>;
>> +			regulator-max-microvolt = <1504000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
>> +		};
>> +
>> +		vreg_l14a_1p8: ldo14 {
>> +			regulator-name = "vreg_l14a_1p8";
>> +			regulator-min-microvolt = <1650000>;
>> +			regulator-max-microvolt = <1950000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
>> +		};
>> +
>> +		vreg_l15a_1p8: ldo15 {
>> +			regulator-name = "vreg_l15a_1p8";
>> +			regulator-min-microvolt = <1504000>;
>> +			regulator-max-microvolt = <2000000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
>> +		};
>> +
>> +		vreg_l16a_1p8: ldo16 {
>> +			regulator-name = "vreg_l16a_1p8";
>> +			regulator-min-microvolt = <1710000>;
>> +			regulator-max-microvolt = <1890000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
>> +		};
>> +
>> +		vreg_l17a_3p3: ldo17 {
>> +			regulator-name = "vreg_l17a_3p3";
>> +			regulator-min-microvolt = <3000000>;
>> +			regulator-max-microvolt = <3544000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
>> +		};
>> +
>> +		vreg_l18a_1p2: ldo18 {
>> +			regulator-name = "vreg_l18a_1p2";
>> +			regulator-min-microvolt = <312000>;
>> +			regulator-max-microvolt = <1304000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
>> +		};
>> +	};
>> +};
>> +
>> +&qupv3_id_0 {
>> +	status = "okay";
>> +};
>> +
>> +&uart7 {
>> +	status = "okay";
>> +};
>> diff --git a/arch/arm64/boot/dts/qcom/qru1000-idp.dts b/arch/arm64/boot/dts/qcom/qru1000-idp.dts
>> new file mode 100644
>> index 000000000000..42eb0c33e7ba
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/qru1000-idp.dts
>> @@ -0,0 +1,266 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>> +#include "qru1000.dtsi"
>> +#include "pm8150.dtsi"
>> +
>> +/ {
>> +	model = "Qualcomm Technologies, Inc. QRU1000 IDP";
>> +	compatible = "qcom,qru1000-idp", "qcom,qru1000";
>> +
>> +	aliases {
>> +		serial0 = &uart7;
>> +	};
>> +
>> +	clocks {
>> +		xo_board: xo-board {
>> +			compatible = "fixed-clock";
>> +			clock-frequency = <19200000>;
>> +			clock-output-names = "xo_board";
>> +			#clock-cells = <0>;
>> +		};
>> +
>> +		sleep_clk: sleep-clk {
>> +			compatible = "fixed-clock";
>> +			clock-frequency = <32000>;
>> +			#clock-cells = <0>;
>> +		};
>> +
>> +		pcie_0_pipe_clk: pcie-0-pipe-clk {
>> +			compatible = "fixed-clock";
>> +			clock-frequency = <1000>;
>> +			clock-output-names = "pcie_0_pipe_clk";
>> +			#clock-cells = <0>;
>> +		};
>> +
>> +		pcie_0_phy_aux_clk: pcie-0-phy-aux-clk {
>> +			compatible = "fixed-clock";
>> +			clock-frequency = <1000>;
>> +			clock-output-names = "pcie_0_phy_aux_clk";
>> +			#clock-cells = <0>;
>> +		};
>> +
>> +		usb3_phy_wrapper_pipe_clk: usb3-phy-wrapper-pipe-clk {
>> +			compatible = "fixed-clock";
>> +			clock-frequency = <1000>;
>> +			clock-output-names = "usb3_phy_wrapper_pipe_clk";
>> +			#clock-cells = <0>;
>> +		};
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial0:115200n8";
>> +	};
>> +
>> +	ppvar_sys: ppvar-sys-regulator {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "ppvar_sys";
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +	};
>> +
>> +	vph_pwr: vph-pwr-regulator {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vph_pwr";
>> +		regulator-min-microvolt = <3700000>;
>> +		regulator-max-microvolt = <3700000>;
>> +
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +
>> +		vin-supply = <&ppvar_sys>;
>> +	};
>> +};
>> +
>> +&apps_rsc {
>> +	regulators {
>> +		compatible = "qcom,pm8150-rpmh-regulators";
>> +		qcom,pmic-id = "a";
>> +
>> +		vdd-s1-supply = <&vph_pwr>;
>> +		vdd-s2-supply = <&vph_pwr>;
>> +		vdd-s3-supply = <&vph_pwr>;
>> +		vdd-s4-supply = <&vph_pwr>;
>> +		vdd-s5-supply = <&vph_pwr>;
>> +		vdd-s6-supply = <&vph_pwr>;
>> +		vdd-s7-supply = <&vph_pwr>;
>> +		vdd-s8-supply = <&vph_pwr>;
>> +		vdd-s9-supply = <&vph_pwr>;
>> +		vdd-s10-supply = <&vph_pwr>;
>> +
>> +		vdd-l1-l8-l11-supply = <&vreg_s6a_0p9>;
>> +		vdd-l2-l10-supply = <&vph_pwr>;
>> +		vdd-l3-l4-l5-l18-supply = <&vreg_s5a_2p0>;
>> +		vdd-l6-l9-supply = <&vreg_s6a_0p9>;
>> +		vdd-l7-l12-l14-l15-supply = <&vreg_s4a_1p8>;
>> +		vdd-l13-l16-l17-supply = <&vph_pwr>;
>> +
>> +		vreg_s2a_0p5: smps2 {
>> +			regulator-name = "vreg_s2a_0p5";
>> +			regulator-min-microvolt = <320000>;
>> +			regulator-max-microvolt = <570000>;
>> +		};
>> +
>> +		vreg_s3a_1p05: smps3 {
>> +			regulator-name = "vreg_s3a_1p05";
>> +			regulator-min-microvolt = <950000>;
>> +			regulator-max-microvolt = <1170000>;
>> +		};
>> +
>> +		vreg_s4a_1p8: smps4 {
>> +			regulator-name = "vreg_s4a_1p8";
>> +			regulator-min-microvolt = <1800000>;
>> +			regulator-max-microvolt = <1800000>;
>> +		};
>> +
>> +		vreg_s5a_2p0: smps5 {
>> +			regulator-name = "vreg_s5a_2p0";
>> +			regulator-min-microvolt = <1904000>;
>> +			regulator-max-microvolt = <2000000>;
>> +		};
>> +
>> +		vreg_s6a_0p9: smps6 {
>> +			regulator-name = "vreg_s6a_0p9";
>> +			regulator-min-microvolt = <920000>;
>> +			regulator-max-microvolt = <1128000>;
>> +		};
>> +
>> +		vreg_s7a_1p2: smps7 {
>> +			regulator-name = "vreg_s7a_1p2";
>> +			regulator-min-microvolt = <1200000>;
>> +			regulator-max-microvolt = <1200000>;
>> +		};
>> +
>> +		vreg_s8a_1p3: smps8 {
>> +			regulator-name = "vreg_s8a_1p3";
>> +			regulator-min-microvolt = <1352000>;
>> +			regulator-max-microvolt = <1352000>;
>> +		};
>> +
>> +		vreg_l1a_0p91: ldo1 {
>> +			regulator-name = "vreg_l1a_0p91";
>> +			regulator-min-microvolt = <312000>;
>> +			regulator-max-microvolt = <1304000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
>> +		};
>> +
>> +		vreg_l2a_2p3: ldo2 {
>> +			regulator-name = "vreg_l2a_2p3";
>> +			regulator-min-microvolt = <2970000>;
>> +			regulator-max-microvolt = <3300000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
>> +		};
>> +
>> +		vreg_l3a_1p2: ldo3 {
>> +			regulator-name = "vreg_l3a_1p2";
>> +			regulator-min-microvolt = <920000>;
>> +			regulator-max-microvolt = <1260000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
>> +		};
>> +
>> +		vreg_l5a_0p8: ldo5 {
>> +			regulator-name = "vreg_l5a_0p8";
>> +			regulator-min-microvolt = <312000>;
>> +			regulator-max-microvolt = <1304000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
>> +		};
>> +
>> +		vreg_l6a_0p91: ldo6 {
>> +			regulator-name = "vreg_l6a_0p91";
>> +			regulator-min-microvolt = <880000>;
>> +			regulator-max-microvolt = <950000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
>> +		};
>> +
>> +		vreg_l7a_1p8: ldo7 {
>> +			regulator-name = "vreg_l7a_1p8";
>> +			regulator-min-microvolt = <1650000>;
>> +			regulator-max-microvolt = <2000000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
>> +
>> +		};
>> +
>> +		vreg_l8a_0p91: ldo8 {
>> +			regulator-name = "vreg_l8a_0p91";
>> +			regulator-min-microvolt = <888000>;
>> +			regulator-max-microvolt = <925000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
>> +		};
>> +
>> +		vreg_l9a_0p91: ldo9 {
>> +			regulator-name = "vreg_l8a_0p91";
>> +			regulator-min-microvolt = <312000>;
>> +			regulator-max-microvolt = <1304000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
>> +		};
>> +
>> +		vreg_l10a_2p95: ldo10 {
>> +			regulator-name = "vreg_l10a_2p95";
>> +			regulator-min-microvolt = <2700000>;
>> +			regulator-max-microvolt = <3544000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
>> +		};
>> +
>> +		vreg_l11a_0p91: ldo11 {
>> +			regulator-name = "vreg_l11a_0p91";
>> +			regulator-min-microvolt = <800000>;
>> +			regulator-max-microvolt = <1000000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
>> +		};
>> +
>> +		vreg_l12a_1p8: ldo12 {
>> +			regulator-name = "vreg_l12a_1p8";
>> +			regulator-min-microvolt = <1504000>;
>> +			regulator-max-microvolt = <1504000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
>> +		};
>> +
>> +		vreg_l14a_1p8: ldo14 {
>> +			regulator-name = "vreg_l14a_1p8";
>> +			regulator-min-microvolt = <1650000>;
>> +			regulator-max-microvolt = <1950000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
>> +		};
>> +
>> +		vreg_l15a_1p8: ldo15 {
>> +			regulator-name = "vreg_l15a_1p8";
>> +			regulator-min-microvolt = <1504000>;
>> +			regulator-max-microvolt = <2000000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
>> +		};
>> +
>> +		vreg_l16a_1p8: ldo16 {
>> +			regulator-name = "vreg_l16a_1p8";
>> +			regulator-min-microvolt = <1710000>;
>> +			regulator-max-microvolt = <1890000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
>> +		};
>> +
>> +		vreg_l17a_3p3: ldo17 {
>> +			regulator-name = "vreg_l17a_3p3";
>> +			regulator-min-microvolt = <3000000>;
>> +			regulator-max-microvolt = <3544000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
>> +		};
>> +
>> +		vreg_l18a_1p2: ldo18 {
>> +			regulator-name = "vreg_l18a_1p2";
>> +			regulator-min-microvolt = <312000>;
>> +			regulator-max-microvolt = <1304000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
>> +		};
>> +	};
>> +};
>> +
>> +&qupv3_id_0 {
>> +	status = "okay";
>> +};
>> +
>> +&uart7 {
>> +	status = "okay";
>> +};

