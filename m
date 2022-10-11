Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154F45FBA4F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 20:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiJKSYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 14:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiJKSXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 14:23:08 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F5A3FD4E;
        Tue, 11 Oct 2022 11:23:06 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29BEEAOW001294;
        Tue, 11 Oct 2022 18:22:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=5g9GT870wC6bsMlXPYU6yqXas8XCUf7x816AFSIcs1k=;
 b=fpwxi0uugEwttKHBgjmSZMCR8ZYrzL1WYBrZI2QE/PluzR9te776t/FDAvk8FPKjbZxd
 DJC1ezkb8opE0rDy+BWx3cy/j4xerxF77I0QSGBYI7b2OxunNA9AwxQRWIZhpgtdtXfQ
 8cQQWYWPEGO6TczLBRnocKlCIfNhxHeST+NVLXgWP5QJdJXnjbNHvF+CRvbX1SXt4yfx
 hS+2ie+Ky4UIMrb8yXReMS2n4BoFBTGsfkEe9tugHkuAYRku45oNB0AdQMHnclPAWgV9
 Gw53vANO+v+2fFYaJ68SPOIssCVTzByEzZgZirokFPkLJVHCcZ9/sXHoH9ABKtfqH+kZ 6g== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k4rxa31gu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 18:22:56 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29BIMtg0023500
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 18:22:55 GMT
Received: from [10.110.3.66] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 11 Oct
 2022 11:22:55 -0700
Message-ID: <2aabbad7-5e36-56d0-04a6-297a8373d57b@quicinc.com>
Date:   Tue, 11 Oct 2022 11:22:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 01/19] arm64: dts: qcom: Add base QDU1000/QRU1000 DTSIs
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221001030656.29365-1-quic_molvera@quicinc.com>
 <20221001030656.29365-2-quic_molvera@quicinc.com>
 <a40d7e71-f7c7-0410-7a92-0718f45de2d2@linaro.org>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <a40d7e71-f7c7-0410-7a92-0718f45de2d2@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _fVpys6ZlGIPY0JKJW4-WSBuEW56pO-c
X-Proofpoint-GUID: _fVpys6ZlGIPY0JKJW4-WSBuEW56pO-c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-11_08,2022-10-11_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 mlxscore=0 clxscore=1015 adultscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2210110107
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/1/2022 2:12 AM, Krzysztof Kozlowski wrote:
> On 01/10/2022 05:06, Melody Olvera wrote:
>> Add the base DTSI files for QDU1000 and QRU1000 SoCs, including base
>> descriptions of CPUs, GCC, RPMHCC, UART, and interrupt-controller to
>> boot to shell with console on these SoCs.
>>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
>>  arch/arm64/boot/dts/qcom/qdru1000.dtsi | 370 +++++++++++++++++++++++++
>>  arch/arm64/boot/dts/qcom/qdu1000.dtsi  |  10 +
>>  arch/arm64/boot/dts/qcom/qru1000.dtsi  |  10 +
>>  3 files changed, 390 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/qcom/qdru1000.dtsi
>>  create mode 100644 arch/arm64/boot/dts/qcom/qdu1000.dtsi
>>  create mode 100644 arch/arm64/boot/dts/qcom/qru1000.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qdru1000.dtsi b/arch/arm64/boot/dts/qcom/qdru1000.dtsi
>> new file mode 100644
>> index 000000000000..3610f94bef35
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/qdru1000.dtsi
>> @@ -0,0 +1,370 @@
>> +// SPDX-License-Identifier: BSD-3-Clause-Clear
>> +/*
>> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/clock/qcom,gcc-qdru1000.h>
>> +#include <dt-bindings/clock/qcom,rpmh.h>
>> +#include <dt-bindings/soc/qcom,rpmh-rsc.h>
>> +
>> +/ {
>> +	interrupt-parent = <&intc>;
>> +
>> +	#address-cells = <2>;
>> +	#size-cells = <2>;
>> +
>> +	chosen: chosen { };
>> +
>> +
> No need for double blank line.
Ack.
>
>> +	clocks {
>> +		xo_board: xo_board {
>> +			compatible = "fixed-clock";
>> +			clock-frequency = <19200000>;
>> +			clock-output-names = "xo_board";
>> +			#clock-cells = <0>;
>> +		};
>> +
>> +		sleep_clk: sleep_clk {
>> +			compatible = "fixed-clock";
>> +			clock-frequency = <32000>;
>> +			#clock-cells = <0>;
>> +		};
>> +	};
>> +
> (...)
>
>> +		CPU_PD3: cpu-pd3 {
>> +			#power-domain-cells = <0>;
>> +			power-domains = <&CLUSTER_PD>;
>> +			domain-idle-states = <&SILVER_OFF>;
>> +		};
>> +
>> +		CLUSTER_PD: cluster-pd {
>> +			#power-domain-cells = <0>;
>> +			domain-idle-states = <&CLUSTER_PWR_DN &APSS_OFF>;
>> +		};
>> +	};
>> +
>> +	soc: soc@0 {
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges = <0 0 0 0 0x10 0>;
>> +		dma-ranges = <0 0 0 0 0x10 0>;
>> +		compatible = "simple-bus";
>> +
>> +		gcc: clock-controller@80000 {
>> +			compatible = "qcom,gcc-qdu1000", "qcom,gcc-qru1000", "syscon";
> Did you document the compatibles?
Yes; see the clocks patch set.
>
>> +			reg = <0x0 0x80000 0x0 0x1f4200>;
>> +			#clock-cells = <1>;
>> +			#reset-cells = <1>;
>> +			#power-domain-cells = <1>;
>> +			clocks = <&rpmhcc RPMH_CXO_CLK>, <&sleep_clk>;
>> +			clock-names = "bi_tcxo", "sleep_clk";
>> +		};
>> +
>> +		qupv3_id_0: geniqup@9c0000 {
>> +			compatible = "qcom,geni-se-qup";
>> +			reg = <0x0 0x9c0000 0x0 0x2000>;
>> +			clock-names = "m-ahb", "s-ahb";
>> +			clocks = <&gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
>> +				<&gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
>> +			#address-cells = <2>;
>> +			#size-cells = <2>;
>> +			ranges;
>> +			status = "disabled";
>> +
>> +			uart7: serial@99c000 {
>> +				compatible = "qcom,geni-debug-uart";
>> +				reg = <0x0 0x99c000 0x0 0x4000>;
>> +				clock-names = "se";
>> +				clocks = <&gcc GCC_QUPV3_WRAP0_S7_CLK>;
>> +				interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				status = "disabled";
>> +			};
>> +		};
>> +
> (...)
>
>> +		arch_timer: timer {
>> +			compatible = "arm,armv8-timer";
>> +			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>> +				     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>> +				     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>> +				     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>> +				     <GIC_PPI 12 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
>> +			clock-frequency = <19200000>;
>> +		};
>> +	};
>> +};
>> diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
>> new file mode 100644
>> index 000000000000..ba195e7ffc38
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
>> @@ -0,0 +1,10 @@
>> +// SPDX-License-Identifier: BSD-3-Clause-Clear
>> +/*
>> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#include "qdru1000.dtsi"
>> +
>> +/ {
>> +	qcom,msm-id = <545 0x10000>, <587 0x10000>;
> NAK.
Will remove.
>
>> +};
>> diff --git a/arch/arm64/boot/dts/qcom/qru1000.dtsi b/arch/arm64/boot/dts/qcom/qru1000.dtsi
>> new file mode 100644
>> index 000000000000..1639a4b3c1fb
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/qru1000.dtsi
>> @@ -0,0 +1,10 @@
>> +// SPDX-License-Identifier: BSD-3-Clause-Clear
>> +/*
>> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#include "qdru1000.dtsi"
>> +
>> +/ {
>> +	qcom,msm-id = <539 0x10000>, <588 0x10000>, <589 0x10000>, <590 0x10000>;
> Nope, property is not documented and not accepted. Efforts in
> documenting this property were apparently also not accepted, therefore I
> am not agreeing in bringing DTS with these.
Will remove.
>
>> +};
> Best regards,
> Krzysztof
>
Thanks,
Melody
