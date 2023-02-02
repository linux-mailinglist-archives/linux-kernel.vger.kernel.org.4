Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C28A68798A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 10:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjBBJzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 04:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbjBBJyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 04:54:37 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D979020;
        Thu,  2 Feb 2023 01:54:35 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3127wW2G031383;
        Thu, 2 Feb 2023 09:54:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6rXl8dSJnZs0jESUNgI+UiBKW8vkiOT2FSKcrPymees=;
 b=SZWB3HbzxpT0a1707Fy5e+S882ZchJyJH8RCN0oNI8lyFTmwGmKDQIE5CBEqZRd5Sx5t
 a70lHpmYdvY/5efWOWxv8xEAxka0BjrUTib/BcLcbic5RqZMUFmvSnQkJ/GTUADI+WDe
 hYKwsCubYy7Xta/vbP2ml3v9l7eSQSybgpAYUJXcqRWekIkMb476FTJQwVV9vR0aQKME
 bmTdz7uqgNriqSUzaJneeYoV1jXM9oOxYLXvo7eiq67BxUt603xttagC7J4l/0NGbd34
 GNirG4GOcj9wVnlzk/ZtNkiAxN1wwHry4oQbMRUoXfgJLm5rJrFTZfQBOm0ixttB7kQJ tA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nfkj4at3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 09:54:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3129sU7C028437
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Feb 2023 09:54:30 GMT
Received: from [10.50.17.72] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 2 Feb 2023
 01:54:24 -0800
Message-ID: <3a215439-3ecf-4384-9df6-72a22e6e3457@quicinc.com>
Date:   Thu, 2 Feb 2023 15:24:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 5/6] arm64: dts: qcom: ipq9574: Add cpufreq & RPM related
 nodes
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>
References: <20230113150310.29709-1-quic_devipriy@quicinc.com>
 <20230113150310.29709-6-quic_devipriy@quicinc.com>
 <4114bf50-67bf-e11c-5304-f2c6dcc0063d@linaro.org>
Content-Language: en-US
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <4114bf50-67bf-e11c-5304-f2c6dcc0063d@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: g5Xe3rX2vtqdbiLss6g5rm-xYuNwzaTt
X-Proofpoint-ORIG-GUID: g5Xe3rX2vtqdbiLss6g5rm-xYuNwzaTt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_02,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 impostorscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302020092
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks konrad for taking time to review the patch!

On 1/13/2023 9:02 PM, Konrad Dybcio wrote:
> 
> 
> On 13.01.2023 16:03, devi priya wrote:
>> Add CPU Freq and RPM related nodes in the device tree
> These two are wildly different things, barely related to one
> another and can very well be introduced in separate patches.
> Please do so.
> 
>>
>> Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/ipq9574.dtsi | 80 +++++++++++++++++++++++++++
>>   1 file changed, 80 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> index 5a2244b437ed..79fa5d91882c 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> @@ -9,6 +9,7 @@
>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>>   #include <dt-bindings/clock/qcom,gcc-ipq9574.h>
>>   #include <dt-bindings/reset/qcom,gcc-ipq9574.h>
>> +#include <dt-bindings/clock/qcom,apss-ipq.h>
> Please sort the includes alphabetically.
Sure, okay
> 
>>   
>>   / {
>>   	interrupt-parent = <&intc>;
>> @@ -75,6 +76,10 @@
>>   			reg = <0x0>;
>>   			enable-method = "psci";
>>   			next-level-cache = <&L2_0>;
>> +			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
>> +			clock-names = "cpu";
>> +			operating-points-v2 = <&cpu_opp_table>;
>> +			cpu0-supply = <&ipq9574_s1>;
> Why is this cpu0-supply and the rest are cpu-supply? Neither of them
> seem particularly documented, by the way..
Sure, will check and update this in V2
> 
> 
>>   		};
>>   
>>   		CPU1: cpu@1 {
>> @@ -83,6 +88,10 @@
>>   			reg = <0x1>;
>>   			enable-method = "psci";
>>   			next-level-cache = <&L2_0>;
>> +			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
>> +			clock-names = "cpu";
>> +			operating-points-v2 = <&cpu_opp_table>;
>> +			cpu-supply = <&ipq9574_s1>;
>>   		};
>>   
>>   		CPU2: cpu@2 {
>> @@ -91,6 +100,10 @@
>>   			reg = <0x2>;
>>   			enable-method = "psci";
>>   			next-level-cache = <&L2_0>;
>> +			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
>> +			clock-names = "cpu";
>> +			operating-points-v2 = <&cpu_opp_table>;
>> +			cpu-supply = <&ipq9574_s1>;
>>   		};
>>   
>>   		CPU3: cpu@3 {
>> @@ -99,6 +112,10 @@
>>   			reg = <0x3>;
>>   			enable-method = "psci";
>>   			next-level-cache = <&L2_0>;
>> +			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
>> +			clock-names = "cpu";
>> +			operating-points-v2 = <&cpu_opp_table>;
>> +			cpu-supply = <&ipq9574_s1>;
>>   		};
>>   
>>   		L2_0: l2-cache {
>> @@ -107,6 +124,42 @@
>>   		};
>>   	};
>>   
>> +	cpu_opp_table: opp-table-cpu {
> Alphabetically this goes after memory
Okay
> 
>> +		compatible = "operating-points-v2";
>> +		opp-shared;
>> +
>> +		opp-936000000 {
>> +			opp-hz = /bits/ 64 <936000000>;
>> +			opp-microvolt = <725000>;
>> +			clock-latency-ns = <200000>;
>> +		};
> Please add a newline between each subnode.
Okay
> 
>> +		opp-1104000000 {
>> +			opp-hz = /bits/ 64 <1104000000>;
>> +			opp-microvolt = <787500>;
>> +			clock-latency-ns = <200000>;
>> +		};
>> +		opp-1416000000 {
>> +			opp-hz = /bits/ 64 <1416000000>;
>> +			opp-microvolt = <862500>;
>> +			clock-latency-ns = <200000>;
>> +		};
>> +		opp-1488000000 {
>> +			opp-hz = /bits/ 64 <1488000000>;
>> +			opp-microvolt = <925000>;
>> +			clock-latency-ns = <200000>;
>> +		};
>> +		opp-1800000000 {
>> +			opp-hz = /bits/ 64 <1800000000>;
>> +			opp-microvolt = <987500>;
>> +			clock-latency-ns = <200000>;
>> +		};
>> +		opp-2208000000 {
>> +			opp-hz = /bits/ 64 <2208000000>;
>> +			opp-microvolt = <1062500>;
>> +			clock-latency-ns = <200000>;
>> +		};
>> +	};
>> +
>>   	memory@40000000 {
>>   		device_type = "memory";
>>   		/* We expect the bootloader to fill in the size */
>> @@ -128,6 +181,11 @@
>>   		#size-cells = <2>;
>>   		ranges;
>>   
>> +		rpm_msg_ram: memory@60000 {
>> +			reg = <0x0 0x00060000 0x0 0x6000>;
>> +			no-map;
>> +		};
>> +
>>   		tz_region: memory@4a600000 {
>>   			reg = <0x0 0x4a600000 0x0 0x400000>;
>>   			no-map;
>> @@ -324,6 +382,28 @@
>>   		};
>>   	};
>>   
>> +	rpm-glink {
>> +		compatible = "qcom,glink-rpm";
>> +		interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
>> +		qcom,rpm-msg-ram = <&rpm_msg_ram>;
>> +		mboxes = <&apcs_glb 0>;
>> +
>> +		rpm_requests: glink-channel {
>> +			compatible = "qcom,rpm-ipq9574";
>> +			qcom,glink-channels = "rpm_requests";
>> +
>> +			regulators {
>> +				compatible = "qcom,rpm-ipq9574-mp5496-regulators";
> The regulators are board-specific and should not be included in the
> SoC DTSI. If this is a very common configuration, you may split that
> into ipq9574-mp5496.dtsi, for example. Or ipq9574-pmics.dtsi if it's
> coupled with more PMICs.
Got it. Will move this to the board DT
> 
>> +
>> +				ipq9574_s1: s1 {
>> +					regulator-min-microvolt = <587500>;
>> +					regulator-max-microvolt = <1075000>;
>> +					regulator-always-on;
> Won't this break CPU retention?
> 
> You're holding a vote on it from the CPU devices, so it should be
> always enabled when the CPUs are oneline (as far as Linux is
> concerned).
> 
> 
> Or maybe Linux will think it's enabled and RPM will quietly park
> it when it decides it's good to do so.. but will it with an active
> request.. not sure, really.. just something to consider..
> 
Sure, will check this and update accordingly in V2
> Konrad
>> +				};
>> +			};
>> +		};
>> +	};
>> +
>>   	timer {
>>   		compatible = "arm,armv8-timer";
>>   		interrupts = <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
Best Regards,
Devi Priya
