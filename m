Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC0A721D8C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 07:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbjFEFfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 01:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjFEFfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 01:35:34 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E064CD3;
        Sun,  4 Jun 2023 22:35:32 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3555A2WF024475;
        Mon, 5 Jun 2023 05:35:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=5lG2OHQEMFnwr9Y2gijh9dg9xw17BzE7ddECxdA4NdU=;
 b=dT0eZgXpaBy84+z0LNugV+9MRw1E/D6Kl4RzWWy7HFaIFtKjROqKJvODPZvXrlU27LiC
 epCyAWRhTyHYQyDKfmym0+fIR31goyC9GecVKuh8bEN8DACpiC3gmvSSRHmGxu7gkZV2
 jNy5Z+PhK9FVLV+TmDkmfufEAk0TRaWEHOTER/gj+UI+H2McKRm0b908A/SRVZeeSFkd
 olhRm7TqeXoDJYs6FwIO35GL/AI2Hp8i7B8vpOBCbBCwnN3OtDSfczcpCJ/+fNVEK/Am
 IKs2Cy/jIYls9xEL/LwFSBES46VQyoxSBstdOkJhwulu5OHrGtQtqJ1CHU1kTvvLvIyA PA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qywr8tn32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jun 2023 05:35:27 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3555ZQQv014749
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 5 Jun 2023 05:35:26 GMT
Received: from [10.201.206.238] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Sun, 4 Jun 2023
 22:35:18 -0700
Message-ID: <adb4716f-9fa8-9b37-0a06-5c5e19307925@quicinc.com>
Date:   Mon, 5 Jun 2023 11:05:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH V2 11/13] arm64: dtsi: qcom: ipq5018: enable nodes
 required for multipd
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <jassisinghbrar@gmail.com>, <mathieu.poirier@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <quic_eberman@quicinc.com>, <quic_mojha@quicinc.com>,
        <kvalo@kernel.org>, <loic.poulain@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>, <quic_varada@quicinc.com>,
        <quic_devipriy@quicinc.com>
References: <20230521222852.5740-1-quic_mmanikan@quicinc.com>
 <20230521222852.5740-12-quic_mmanikan@quicinc.com>
 <a33363d2-a0a8-f8c1-fbc0-f7a5422d07a9@linaro.org>
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <a33363d2-a0a8-f8c1-fbc0-f7a5422d07a9@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: s9sUgWFAkX96Nlo7LpD5dEHFCgYG1QxC
X-Proofpoint-GUID: s9sUgWFAkX96Nlo7LpD5dEHFCgYG1QxC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-03_08,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=857 suspectscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 mlxscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306050049
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/30/2023 4:35 PM, Krzysztof Kozlowski wrote:
> On 22/05/2023 00:28, Manikanta Mylavarapu wrote:
>> Enable nodes required for multipd remoteproc bring up
> 
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching.
> 
> It is "dts". Not "dtsi".
> 
Sure, I will update to 'dtsi'.

>>
>> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
>> ---
>> Changes in V2:
>> 	- Corrected syntax like alignmnet and kept nodes in sorted order.
>> 	- Covered entire TCSR region.
>> 	- Added 'firmware-name' property.
>>
>>   arch/arm64/boot/dts/qcom/ipq5018.dtsi | 140 ++++++++++++++++++++++++++
>>   1 file changed, 140 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>> index 9f13d2dcdfd5..3772d54d89e4 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>> @@ -85,6 +85,18 @@
>>   			reg = <0x0 0x4ac00000 0x0 0x200000>;
>>   			no-map;
>>   		};
>> +
>> +		q6_region: wcnss@4b000000 {
>> +			reg = <0x0 0x4b000000 0x0 0x1700000>;
>> +			no-map;
>> +		};
>> +
>> +		smem@4ab00000 {
>> +			compatible = "qcom,smem";
>> +			reg = <0x0 0x4ab00000 0x0 0x100000>;
>> +			hwlocks = <&tcsr_mutex 0>;
>> +			no-map;
>> +		};
>>   	};
>>
>>   	soc: soc@0 {
>> @@ -128,6 +140,12 @@
>>   			#power-domain-cells = <1>;
>>   		};
>>
>> +		tcsr_mutex: hwlock@1905000 {
>> +			compatible = "qcom,tcsr-mutex";
>> +			reg = <0x01905000 0x20000>;
>> +			#hwlock-cells = <1>;
>> +		};
>> +
>>   		sdhc_1: mmc@7804000 {
>>   			compatible = "qcom,ipq5018-sdhci", "qcom,sdhci-msm-v5";
>>   			reg = <0x7804000 0x1000>;
>> @@ -181,6 +199,14 @@
>>   			};
>>   		};
>>
>> +		apcs_glb: mailbox@b111000 {
>> +			compatible = "qcom,ipq5018-apcs-apps-global",
>> +				     "qcom,ipq6018-apcs-apps-global";
>> +			reg = <0x0b111000 0x1000>;
>> +			#clock-cells = <1>;
>> +			#mbox-cells = <1>;
>> +		};
>> +
>>   		timer@b120000 {
>>   			compatible = "arm,armv7-timer-mem";
>>   			reg = <0x0b120000 0x1000>;
>> @@ -238,6 +264,96 @@
>>   				status = "disabled";
>>   			};
>>   		};
>> +
>> +		q6v5_wcss: remoteproc@cd00000 {
>> +			compatible = "qcom,ipq5018-q6-mpd";
>> +			reg = <0x0cd00000 0x4040>;
>> +			firmware-name = "IPQ5018/q6_fw.mdt",
>> +					"IPQ5018/m3_fw.mdt",
>> +					"qcn6122/m3_fw.mdt";
>> +			interrupts-extended = <&intc GIC_SPI 291 IRQ_TYPE_EDGE_RISING>,
>> +					      <&wcss_smp2p_in 0 0>,
>> +					      <&wcss_smp2p_in 1 0>,
>> +					      <&wcss_smp2p_in 2 0>,
>> +					      <&wcss_smp2p_in 3 0>;
>> +			interrupt-names = "wdog",
>> +					  "fatal",
>> +					  "ready",
>> +					  "handover",
>> +					  "stop-ack";
>> +
>> +			qcom,smem-states = <&wcss_smp2p_out 0>,
>> +					   <&wcss_smp2p_out 1>;
>> +			qcom,smem-state-names = "shutdown",
>> +						"stop";
>> +			memory-region = <&q6_region>;
>> +
>> +			glink-edge {
>> +				interrupts = <GIC_SPI 179 IRQ_TYPE_EDGE_RISING>;
>> +				label = "rtr";
>> +				qcom,remote-pid = <1>;
>> +				mboxes = <&apcs_glb 8>;
>> +			};
>> +
>> +			pd-1 {
>> +				compatible = "qcom,ipq5018-wcss-ahb-mpd";
>> +				firmware-name = "IPQ5018/q6_fw.mdt";
>> +				interrupts-extended = <&wcss_smp2p_in 8 0>,
>> +						      <&wcss_smp2p_in 9 0>,
>> +						      <&wcss_smp2p_in 12 0>,
>> +						      <&wcss_smp2p_in 11 0>;
> 
> What "0" stands for?
> 
0 means IRQ_NONE. These are software interrupts (register write),
so we have configured to 0. I will replace 0 with IRQ_NONE.

Thanks & Regards,
Manikanta.

>> +				interrupt-names = "fatal",
>> +						  "ready",
> Best regards,
> Krzysztof
> 
