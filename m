Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7FF6051D5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 23:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiJSVQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 17:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiJSVQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 17:16:50 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CC91E72E;
        Wed, 19 Oct 2022 14:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1666214207; x=1697750207;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HQXjUjwNMAtwDtQJV+XF+GQEJrSX2ZGkBjnn2MFBYH0=;
  b=Z9qA/Vi/CRicRS1EsS2ThIchNviaK3kTinHUpD6vjtz4BJ2ZSVcZvrky
   EVTXxOv7ep+gfzgFrRb4556Npp8kJMoFaywp6uFy6RljQAEABI+FYN35w
   1ZiovBnDSAfl5IayjI1/g+cNarArwrpxFlLh0zKMrdJIs5aLYHFxpnDwl
   g=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 19 Oct 2022 14:16:47 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 14:16:47 -0700
Received: from [10.134.66.255] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 19 Oct
 2022 14:16:46 -0700
Message-ID: <65f95226-f464-2e14-1f89-930ed26e0f38@quicinc.com>
Date:   Wed, 19 Oct 2022 14:16:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: Add base QDU1000/QRU1000 IDP DTs
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221014221138.7552-1-quic_molvera@quicinc.com>
 <20221014221138.7552-4-quic_molvera@quicinc.com>
 <e94d9029-e0aa-574f-62d2-632e2c5d70d2@linaro.org>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <e94d9029-e0aa-574f-62d2-632e2c5d70d2@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/15/2022 6:29 AM, Krzysztof Kozlowski wrote:
> On 14/10/2022 18:11, Melody Olvera wrote:
>> Add DTs for Qualcomm IDP platforms using the QDU1000 and QRU1000
>> SoCs.
>>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
>>  arch/arm64/boot/dts/qcom/Makefile        |   2 +
>>  arch/arm64/boot/dts/qcom/qdu1000-idp.dts | 230 +++++++++++++++++++++++
>>  arch/arm64/boot/dts/qcom/qru1000-idp.dts | 230 +++++++++++++++++++++++
>>  3 files changed, 462 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>>  create mode 100644 arch/arm64/boot/dts/qcom/qru1000-idp.dts
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>> index d7669a7cee9f..8417295adfeb 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -51,7 +51,9 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-sony-xperia-yoshino-maple.dtb
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
>> index 000000000000..47a8eaf4fda2
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>> @@ -0,0 +1,230 @@
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
>> +	pm8150-regulators {
> regulators
Just 'regulators' as the node name isn't compliant with the bindings for rpmh-rsc devices.
Do the bindings need to be updated or should I leave this as is?
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
>> index 000000000000..54770c697db8
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/qru1000-idp.dts
>> @@ -0,0 +1,230 @@
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
>> +	pm8150-regulators {
> regulators
Same as above.
>
>
> Best regards,
> Krzysztof
>
Thanks,
Melody
