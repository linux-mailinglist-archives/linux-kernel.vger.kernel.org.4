Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3EB68FFD8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 06:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjBIFUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 00:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjBIFUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 00:20:49 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0EE2DE7C;
        Wed,  8 Feb 2023 21:20:46 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31949Kx0030005;
        Thu, 9 Feb 2023 05:20:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Qi01A4DARysTADEqiJHBihKXJUpLwxjlAn34mXKmldc=;
 b=NhT1YVbMzr9TdxYQwid6J53k1TQC/tPCZEfcSh54k7mPzi5sCkI1/QKTRZKL1hpo9U8I
 TspzPshhpnlXLtYVBOItyGALSeuUcwYrvJ72+3g38tijAMDGVc3WYurfh+FspfnDgHk3
 Z9cjwofYv2SFi2mCf5oF7Q/DeagW2uwnyIK2RS4R6exsI++5EUchcg37ECJeu3kFK2Bt
 QcuknbCHlwOB4lrEDLX9nU9uF5VNzReU5247xlGlIT/eWaN3divkg4Upi8vL15+8KWat
 oLNtfdaZTUXjeu8vq1XFFtvmg3lOipCjOWLpwUfQE/3C7bK6nrFRqajKa1CPFiqA77gX PQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nm86mtnyq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 05:20:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3195KeTQ010936
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Feb 2023 05:20:40 GMT
Received: from [10.201.2.96] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 8 Feb 2023
 21:20:36 -0800
Message-ID: <e40b3122-30e6-4619-57db-085d480deef1@quicinc.com>
Date:   Thu, 9 Feb 2023 10:50:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH V2 5/5] arm64: dts: qcom: ipq5332: enable the CPUFreq
 support
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <quic_varada@quicinc.com>, <quic_srichara@quicinc.com>
References: <20230208042850.1687-1-quic_kathirav@quicinc.com>
 <20230208042850.1687-6-quic_kathirav@quicinc.com>
 <61ca391d-05d4-d02b-f57e-5dd0297feceb@linaro.org>
Content-Language: en-US
From:   Kathiravan T <quic_kathirav@quicinc.com>
In-Reply-To: <61ca391d-05d4-d02b-f57e-5dd0297feceb@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Vd3Oo-h3ibUXmvFWTMj3sSMw-h0tc5Pe
X-Proofpoint-ORIG-GUID: Vd3Oo-h3ibUXmvFWTMj3sSMw-h0tc5Pe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-09_02,2023-02-08_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302090048
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/8/2023 2:11 PM, Konrad Dybcio wrote:
>
> On 8.02.2023 05:28, Kathiravan T wrote:
>> Add the APCS, A53 PLL, cpu-opp-table nodes to bump the CPU frequency
>> above 800MHz.
>>
>> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
>> ---
>> Changes in V2:
>> 	- No changes
>>
>>   arch/arm64/boot/dts/qcom/ipq5332.dtsi | 37 +++++++++++++++++++++++++++
>>   1 file changed, 37 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> index bdf33ef30e10..cec2828c51f8 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> @@ -5,6 +5,7 @@
>>    * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
>>    */
>>   
>> +#include <dt-bindings/clock/qcom,apss-ipq.h>
>>   #include <dt-bindings/clock/qcom,ipq5332-gcc.h>
>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>>   
>> @@ -35,6 +36,8 @@
>>   			reg = <0x0>;
>>   			enable-method = "psci";
>>   			next-level-cache = <&L2_0>;
>> +			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
>> +			operating-points-v2 = <&cpu_opp_table>;
>>   		};
>>   
>>   		CPU1: cpu@1 {
>> @@ -43,6 +46,8 @@
>>   			reg = <0x1>;
>>   			enable-method = "psci";
>>   			next-level-cache = <&L2_0>;
>> +			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
>> +			operating-points-v2 = <&cpu_opp_table>;
>>   		};
>>   
>>   		CPU2: cpu@2 {
>> @@ -51,6 +56,8 @@
>>   			reg = <0x2>;
>>   			enable-method = "psci";
>>   			next-level-cache = <&L2_0>;
>> +			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
>> +			operating-points-v2 = <&cpu_opp_table>;
>>   		};
>>   
>>   		CPU3: cpu@3 {
>> @@ -59,6 +66,8 @@
>>   			reg = <0x3>;
>>   			enable-method = "psci";
>>   			next-level-cache = <&L2_0>;
>> +			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
>> +			operating-points-v2 = <&cpu_opp_table>;
>>   		};
>>   
>>   		L2_0: l2-cache {
>> @@ -67,6 +76,16 @@
>>   		};
>>   	};
>>   
>> +	cpu_opp_table: opp-table-cpu{
> opp-table-cpu {
> + sort this properly (by node name, not label), please


ahh, missed this. Will fix it in next spin.


>
>> +		compatible = "operating-points-v2";
>> +		opp-shared;
>> +
>> +		opp-1488000000 {
> Why only one (presumably FMAX) target? This sounds
> very destructive to power consumption, and by extension
> heat output.


SKU is designed to operate on 1.48GHz only.


>
> The other changes generally look good fwiw.
>
> Konrad
>> +			opp-hz = /bits/ 64 <1488000000>;
>> +			clock-latency-ns = <200000>;
>> +		};
>> +	};
>> +
>>   	firmware {
>>   		scm {
>>   			compatible = "qcom,scm-ipq5332", "qcom,scm";
>> @@ -199,6 +218,24 @@
>>   			};
>>   		};
>>   
>> +		apcs_glb: mailbox@b111000 {
>> +			compatible = "qcom,ipq5332-apcs-apps-global",
>> +				     "qcom,ipq6018-apcs-apps-global";
>> +			reg = <0x0b111000 0x1000>;
>> +			#clock-cells = <1>;
>> +			clocks = <&a53pll>, <&xo_board>;
>> +			clock-names = "pll", "xo";
>> +			#mbox-cells = <1>;
>> +		};
>> +
>> +		a53pll: clock@b116000 {
>> +			compatible = "qcom,ipq5332-a53pll";
>> +			reg = <0x0b116000 0x40>;
>> +			#clock-cells = <0>;
>> +			clocks = <&xo_board>;
>> +			clock-names = "xo";
>> +		};
>> +
>>   		timer@b120000 {
>>   			compatible = "arm,armv7-timer-mem";
>>   			reg = <0x0b120000 0x1000>;
