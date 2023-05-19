Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C8C708F95
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 07:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjESFuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 01:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjESFuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 01:50:06 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3DAD2;
        Thu, 18 May 2023 22:50:05 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34J4e5h8031565;
        Fri, 19 May 2023 05:50:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=5AvLj4D1+tD+hdLGiemWVn/up+Q8oiKbAxawwPwxxrE=;
 b=fAV6JiTZs+zZVgSiSamiu04+U6pfhzmYnBhwsjuM3hy2dCLX3r8AMygbiCiUw85MZFbf
 t3zcXMxAiJCKS3FLC2pYNaL1+OIU07ob2mlYwSp2vdikro3qXuwu2Ryu4Bc5OY5yYMXG
 C4p7LovpdAaLtNFOUZaS+3V2bKWZyT71qXtHAm7VfcjRmzx2y19XmMo9Qm83JS0PcjmR
 2QLwaVl5vvamI6S6ylXh8NUCU2ELtr6f9WTvQ+6w9eBQ2ePU8Cfx8+K8SpeeizoA5v0T
 iU1cP1Ri22Dxo039/7NJtawmGBnalpULO1KlFMChqisWJweJK9sg4poNVeJ1PWuhrpk8 ZA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qnbxqjy21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 05:50:00 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34J5nx9B001340
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 05:50:00 GMT
Received: from [10.216.41.71] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 18 May
 2023 22:49:52 -0700
Message-ID: <7d831dd2-8be3-2061-e566-7d1d4e95c10d@quicinc.com>
Date:   Fri, 19 May 2023 11:19:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 09/11] arm64: dtsi: qcom: ipq5018: enable nodes required
 for multipd
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <jassisinghbrar@gmail.com>,
        <mathieu.poirier@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <quic_gurus@quicinc.com>,
        <loic.poulain@linaro.org>, <quic_eberman@quicinc.com>,
        <robimarko@gmail.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>
References: <1678164097-13247-1-git-send-email-quic_mmanikan@quicinc.com>
 <1678164097-13247-10-git-send-email-quic_mmanikan@quicinc.com>
 <2fe8e4fe-c4ba-188c-60eb-71e05be82cb8@linaro.org>
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <2fe8e4fe-c4ba-188c-60eb-71e05be82cb8@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YmiydQyBpj41NGndg-hBq07ds0aDzUlO
X-Proofpoint-GUID: YmiydQyBpj41NGndg-hBq07ds0aDzUlO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_02,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxscore=0 bulkscore=0 adultscore=0
 phishscore=0 suspectscore=0 mlxlogscore=984 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305190050
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/7/2023 9:11 PM, Krzysztof Kozlowski wrote:
> On 07/03/2023 05:41, Manikanta Mylavarapu wrote:
>> Enable nodes required for multipd remoteproc bring up
>>
>> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/ipq5018.dtsi | 130 ++++++++++++++++++++++++++
>>   1 file changed, 130 insertions(+)
>>   	soc: soc@0 {
>>   		#address-cells = <1>;
>>   		#size-cells = <1>;
>> @@ -217,5 +259,93 @@ frame@b128000 {
>>   				status = "disabled";
>>   			};
>>   		};
>> +
>> +		tcsr_mutex: hwlock@1905000 {
> 
> This does not look like in correct order. Don't stuff things to the end
> of lists.
> 
Sure. I will keep nodes as per order.

>> +			compatible = "qcom,tcsr-mutex";
>> +			reg = <0x01905000 0x8000>;
>> +			#hwlock-cells = <1>;
>> +		};
>> +
>> +		apcs_glb: mailbox@b111000 {
>> +			compatible = "qcom,ipq5018-apcs-apps-global";
>> +			reg = <0x0b111000 0x1000>;
>> +			#clock-cells = <1>;
>> +			#mbox-cells = <1>;
>> +		};
>> +
>> +		q6v5_wcss: remoteproc@cd00000 {
>> +			compatible = "qcom,ipq5018-q6-mpd";
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			ranges;
>> +			reg = <0x0cd00000 0x4040>;
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
>> +			q6_wcss_pd1: remoteproc_pd1 {
> 
> No underscores in node names, generic node names. Actually I don't get
> why do you need empty node at all.
> 
I removed underscores, now name should be pd-1/pd-2/pd-3. Yeah, it 
should not be empty node. I will correct it.

Thanks & Regards,
Manikanta.
>> +				compatible = "qcom,ipq5018-wcss-ahb-mpd";
>> +			};
>> +
>> +			q6_wcss_pd2: remoteproc_pd2 {
>> +				compatible = "qcom,ipq5018-wcss-pcie-mpd";
>> +				interrupts-extended = <&wcss_smp2p_in 16 0>,
>> +					<&wcss_smp2p_in 17 0>,
>> +					<&wcss_smp2p_in 20 0>,
>> +					<&wcss_smp2p_in 19 0>;
> 
> 
> Best regards,
> Krzysztof
> 
