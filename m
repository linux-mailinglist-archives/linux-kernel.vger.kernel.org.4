Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2E164CFD2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 19:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238989AbiLNS72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 13:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238281AbiLNS71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 13:59:27 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D632A72B;
        Wed, 14 Dec 2022 10:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1671044365; x=1702580365;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6TLku4upn9kyFT4tqBgDWCMlIo5v38F/ZBr95IQi7qk=;
  b=rfW4n8Pw3FSilogSbK/TNL3o7oCyUIhUKm99mvVuZOkKy7hoqfaUBmj8
   LlAtjSgbnf6tolTwdCy04aGaEcOFRisMGoZACVJlW1vJMLsQ7bZ5RZ2Ro
   5zcqeHDuO/ZIyBPt4ViPUu29gI2YcoZYEzdwVCT1Yr/kUTUUgdMpigOLi
   8=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 14 Dec 2022 10:59:24 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 10:59:24 -0800
Received: from [10.110.84.96] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 14 Dec
 2022 10:59:23 -0800
Message-ID: <9e4e6149-bc24-b727-fff7-3fb7038fc066@quicinc.com>
Date:   Wed, 14 Dec 2022 10:59:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4 2/2] arm64: dts: qcom: Add base QDU1000/QRU1000 IDP DTs
To:     Bjorn Andersson <andersson@kernel.org>
CC:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221118192241.29384-1-quic_molvera@quicinc.com>
 <20221118192241.29384-3-quic_molvera@quicinc.com>
 <20221202033721.4slwz2utw5u6rv7b@builder.lan>
Content-Language: en-US
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <20221202033721.4slwz2utw5u6rv7b@builder.lan>
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



On 12/1/2022 7:37 PM, Bjorn Andersson wrote:
> On Fri, Nov 18, 2022 at 11:22:41AM -0800, Melody Olvera wrote:
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
>> +
>> +	aliases {
>> +		serial0 = &uart7;
>> +	};
>> +
>> +	clocks {
>> +		xo_board: xo-board {
> Please add a -clk suffix to the node name.

Sure thing.

>
>> +			compatible = "fixed-clock";
>> +			clock-frequency = <19200000>;
>> +			clock-output-names = "xo_board";
> Nothing should rely on this name, so please don't specify it.

Ok; will remove clk names.

>
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
> Afaict these clocks are not referenced anywhere, so please skip them.

Yes, so I included them to be consistent with the bindings. They will be needed later;
should I still remove?

>
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
> "ch" < "cl", so please move this up.

My bad; will do.

Thanks,
Melody

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
> Seems like this is supposed to match -regulators$, so how about
> pm8150-regulators?
>
> Regards,
> Bjorn
>
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
>> -- 
>> 2.38.1
>>

