Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4294B728FB9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 08:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237095AbjFIGQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 02:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjFIGQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 02:16:47 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF911FE6;
        Thu,  8 Jun 2023 23:16:46 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3595OXsu025494;
        Fri, 9 Jun 2023 06:16:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0NNL8p570P0R9lfym8qfsuEoZQdVGNgJ+2pCYiXHF1E=;
 b=p7a74TLFFy/3EN9dzr30PoYVT21nEmM41gxwkuTS7W8PlKhWRhKRRInFyWNNbdk7QhXc
 HINpPjbFRw07Hj54WkwUbgwHvydPxqc9k9GcF23Tcovjs3IdchjydHbhGpDz+Mqcl/bu
 e62I8Xg3+eO6449QXLJJCD+U26Epyjh5H9xtWuCVJoYs7S8CYbkJcVzC3qlpwCu6Rfk2
 sb7TAs/wbMKFu5La5gj/Tvm6bK1BWCESE160FxIan8g8diE6XCu+SPunTqSEFyxRZu3R
 H996WkKMQe5oKDhKOk7GFwILplQCcXfPmTfgfMfClaFju5A+An8OPTGS0hM8Vy7kzcrm eQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r3w7dr5ff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 06:16:38 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3596GbIP009276
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Jun 2023 06:16:37 GMT
Received: from [10.216.61.155] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 8 Jun 2023
 23:16:30 -0700
Message-ID: <e18284a4-fb80-9d79-dfe4-bfdfb3ced7e0@quicinc.com>
Date:   Fri, 9 Jun 2023 11:46:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v3 5/5] arm64: dts: qcom: Add SDX75 platform and IDP board
 support
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <tglx@linutronix.de>, <maz@kernel.org>, <mani@kernel.org>,
        <robimarko@gmail.com>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <1686138469-1464-1-git-send-email-quic_rohiagar@quicinc.com>
 <1686138469-1464-6-git-send-email-quic_rohiagar@quicinc.com>
 <e45d3d3b-a31d-5ad0-b43f-7193add4ee66@linaro.org>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <e45d3d3b-a31d-5ad0-b43f-7193add4ee66@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NkiC9T4jtkayDcTNClO2E3hO5fVrZIq9
X-Proofpoint-ORIG-GUID: NkiC9T4jtkayDcTNClO2E3hO5fVrZIq9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_03,2023-06-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 impostorscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306090054
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/7/2023 5:43 PM, Krzysztof Kozlowski wrote:
> On 07/06/2023 13:47, Rohit Agarwal wrote:
>> Add basic devicetree support for SDX75 platform and IDP board from
>> Qualcomm. The SDX75 platform features an ARM Cortex A55 CPU which forms
>> the Application Processor Sub System (APSS) along with standard Qualcomm
>> peripherals like GCC, TLMM, UART, QPIC, and BAM etc... Also, there
>> exists the networking parts such as IPA, MHI, PCIE-EP, EMAC, and Modem
>> etc..
>>
>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/Makefile      |   1 +
>>   arch/arm64/boot/dts/qcom/sdx75-idp.dts |  33 ++
>>   arch/arm64/boot/dts/qcom/sdx75.dtsi    | 660 +++++++++++++++++++++++++++++++++
>>   3 files changed, 694 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/qcom/sdx75-idp.dts
>>   create mode 100644 arch/arm64/boot/dts/qcom/sdx75.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>> index d42c595..4fd5a18 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -173,6 +173,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-xiaomi-polaris.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-shift-axolotl.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-lenovo-yoga-c630.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-samsung-w737.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)	+= sdx75-idp.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= sm4250-oneplus-billie2.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= sm6115p-lenovo-j606f.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-sony-xperia-seine-pdx201.dtb
>> diff --git a/arch/arm64/boot/dts/qcom/sdx75-idp.dts b/arch/arm64/boot/dts/qcom/sdx75-idp.dts
>> new file mode 100644
>> index 0000000..cbe5cdf
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/sdx75-idp.dts
>> @@ -0,0 +1,33 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "sdx75.dtsi"
>> +
>> +/ {
>> +	model = "Qualcomm Technologies, Inc. SDX75 IDP";
>> +	compatible = "qcom,sdx75-idp", "qcom,sdx75";
>> +
>> +	aliases {
>> +		serial0 = &uart1;
>> +	};
>> +};
>> +
>> +&chosen {
>> +	stdout-path = "serial0:115200n8";
>> +};
>> +
>> +&qupv3_id_0 {
>> +	status = "okay";
>> +};
>> +
>> +&tlmm {
>> +	gpio-reserved-ranges = <110 6>;
>> +};
>> +
>> +&uart1 {
>> +	status = "okay";
>> +};
>> diff --git a/arch/arm64/boot/dts/qcom/sdx75.dtsi b/arch/arm64/boot/dts/qcom/sdx75.dtsi
>> new file mode 100644
>> index 0000000..40fa579
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/sdx75.dtsi
>> @@ -0,0 +1,660 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * SDX75 SoC device tree source
>> + *
>> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
>> + *
>> + */
>> +
>> +#include <dt-bindings/clock/qcom,rpmh.h>
>> +#include <dt-bindings/clock/qcom,sdx75-gcc.h>
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/soc/qcom,rpmh-rsc.h>
>> +
>> +/ {
>> +	#address-cells = <2>;
>> +	#size-cells = <2>;
>> +	interrupt-parent = <&intc>;
>> +
>> +	chosen: chosen { };
>> +
>> +	clocks {
>> +		xo_board: xo-board {
>> +			compatible = "fixed-clock";
>> +			clock-frequency = <76800000>;
>> +			#clock-cells = <0>;
>> +		};
>> +
>> +		sleep_clk: sleep-clk {
>> +			compatible = "fixed-clock";
>> +			clock-frequency = <32000>;
>> +			#clock-cells = <0>;
>> +		};
>> +	};
>> +
>> +	cpus {
>> +		#address-cells = <2>;
>> +		#size-cells = <0>;
>> +
>> +		CPU0: cpu@0 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a55";
>> +			reg = <0x0 0x0>;
>> +			clocks = <&cpufreq_hw 0>;
>> +			enable-method = "psci";
>> +			power-domains = <&CPU_PD0>;
>> +			power-domain-names = "psci";
>> +			qcom,freq-domain = <&cpufreq_hw 0>;
>> +			capacity-dmips-mhz = <1024>;
>> +			dynamic-power-coefficient = <100>;
>> +			next-level-cache = <&L2_0>;
>> +
>> +			L2_0: l2-cache {
>> +				compatible = "cache";
>> +				next-level-cache = <&L3_0>;
> You miss properties like level and unified. Maybye you tested it with
> some old (half year ago) dtschema?
>
> It does not look like you tested the DTS against bindings. Please run
> `make dtbs_check` (see
> Documentation/devicetree/bindings/writing-schema.rst for instructions).
Let me check the latest bindings and update.

Thanks,
Rohit.
>
> Best regards,
> Krzysztof
>
