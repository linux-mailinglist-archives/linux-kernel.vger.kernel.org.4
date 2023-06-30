Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F773743586
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 09:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbjF3HLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 03:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjF3HLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 03:11:42 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6E7199;
        Fri, 30 Jun 2023 00:11:37 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35U5QCT6014244;
        Fri, 30 Jun 2023 07:11:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=BFrv4h8arCmopr0GT3R+CcIJImDld/jIwh7rwC4ymxw=;
 b=lvLF6wj0ZXHO/InrTg76+zgs+3yQySN5tSVbhzoO5RpLq5O3MizpeGmjgnpzOpG0tSWy
 VjaYNG3P7Jo19G26VQXuh8VC4Vhd4PeFjZJhUKIhHes8WvCSrLwz6ZfaAWrvdU5aRD+z
 LnNRptFnIgpMK9OFuIxDRoK2fb+EoSNzIufs7xEC+EMRAhhg+wezCvaJh/gjC/qHeBfx
 I5AvaOSZ3RLokNWyxmQCPDIAFnQ7HCSH7xgPQVQ5qZ5y25QqKB6qhXOxBduZeOEQQewh
 ouCFR26fiwOSmBWWw8Vs7bS7itQ0pcgi1dQhyB2U8tSPi80Tn3ZixaPvFuJL/oVrELhZ vA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rhgpgs17p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 07:11:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35U7BUMI000776
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 07:11:30 GMT
Received: from [10.216.51.197] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.7; Fri, 30 Jun
 2023 00:11:22 -0700
Message-ID: <98706ea2-b722-e956-b204-08791977307b@quicinc.com>
Date:   Fri, 30 Jun 2023 12:41:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH V2 13/13] arm64: dtsi: qcom: ipq9574: Add nodes to bring
 up multipd
Content-Language: en-US
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
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
 <20230521222852.5740-14-quic_mmanikan@quicinc.com>
 <8d21467a-83a4-8478-dbf5-edd77461e6dc@linaro.org>
 <15bdbd23-9066-ee20-1e29-1d086340c133@quicinc.com>
In-Reply-To: <15bdbd23-9066-ee20-1e29-1d086340c133@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pi6zt2qimRPkeghAyfoGOw672OQCrVir
X-Proofpoint-ORIG-GUID: pi6zt2qimRPkeghAyfoGOw672OQCrVir
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_03,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=817 adultscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306300060
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/27/2023 1:14 PM, Manikanta Mylavarapu wrote:
> 
> 
> On 6/24/2023 12:31 PM, Krzysztof Kozlowski wrote:
>> On 22/05/2023 00:28, Manikanta Mylavarapu wrote:
>>> Enable nodes required for multipd remoteproc bring up.
>>>
>>> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
>>> ---
>>> Changes in V2:
>>>     - Corrected syntax like alignmnet and kept nodes in sorted order.
>>>     - Added 'firmware-name' property.
>>>
>>>   arch/arm64/boot/dts/qcom/ipq9574.dtsi | 118 ++++++++++++++++++++++++++
>>>   1 file changed, 118 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi 
>>> b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>>> index 0e04549c69a5..ff0da53ba05f 100644
>>> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>>> @@ -160,6 +160,11 @@
>>>               no-map;
>>>           };
>>>
>>> +        q6_region: wcnss@4ab00000 {
>>> +            reg = <0x0 0x4ab00000 0x0 0x2b00000>;
>>> +            no-map;
>>> +        };
>>> +
>>>           smem@4aa00000 {
>>>               compatible = "qcom,smem";
>>>               reg = <0x0 0x4aa00000 0x0 0x00100000>;
>>> @@ -697,6 +702,95 @@
>>>               };
>>>           };
>>>
>>> +        q6v5_wcss: remoteproc@cd00000 {
>>> +            compatible = "qcom,ipq9574-q6-mpd";
>>> +            reg = <0x0cd00000 0x4040>;
>>> +            firmware-name = "IPQ9574/q6_fw.mdt",
>>> +                    "IPQ9574/m3_fw.mdt";
>>
>> Here and...
>>
>>> +            interrupts-extended = <&intc GIC_SPI 325 
>>> IRQ_TYPE_EDGE_RISING>,
>>> +                          <&wcss_smp2p_in 0 0>,
>>> +                          <&wcss_smp2p_in 1 0>,
>>> +                          <&wcss_smp2p_in 2 0>,
>>> +                          <&wcss_smp2p_in 3 0>;
>>> +            interrupt-names = "wdog",
>>> +                      "fatal",
>>> +                      "ready",
>>> +                      "handover",
>>> +                      "stop-ack";
>>> +
>>> +            qcom,smem-states = <&wcss_smp2p_out 0>,
>>> +                       <&wcss_smp2p_out 1>;
>>> +            qcom,smem-state-names = "shutdown",
>>> +                        "stop";
>>> +            memory-region = <&q6_region>;
>>> +
>>> +            glink-edge {
>>> +                interrupts = <GIC_SPI 321 IRQ_TYPE_EDGE_RISING>;
>>> +                label = "rtr";
>>> +                qcom,remote-pid = <1>;
>>> +                mboxes = <&apcs_glb 8>;
>>> +            };
>>> +
>>> +            pd-1 {
>>> +                compatible = "qcom,ipq9574-wcss-ahb-mpd";
>>> +                firmware-name = "IPQ9574/q6_fw.mdt";
>>
>> ... here - why do you have firmware in both places?
>>

	In multipd model, Q6 & WCSS uses different firmware.
	I will correct the firmware-name. Thanks for catching.

>>> +                interrupts-extended = <&wcss_smp2p_in 8 0>,
>>> +                              <&wcss_smp2p_in 9 0>,
>>> +                              <&wcss_smp2p_in 12 0>,
>>> +                              <&wcss_smp2p_in 11 0>;
>>> +                interrupt-names = "fatal",
>>> +                          "ready",
>>> +                          "spawn-ack",
>>> +                          "stop-ack";
>>> +                qcom,smem-states = <&wcss_smp2p_out 8>,
>>> +                           <&wcss_smp2p_out 9>,
>>> +                           <&wcss_smp2p_out 10>;
>>> +                qcom,smem-state-names = "shutdown",
>>> +                            "stop",
>>> +                            "spawn";
>>> +            };
>>> +
>>> +            pd-2 {
>>> +                compatible = "qcom,ipq5018-wcss-pcie-mpd";
>>
>> This compatible is confusing for this device.
>>
	I will clean up all SOC specific compatibles and have
	only device specific compatibles for Q6 & WCSS radio's
	as i mentioned on other thread.

Thanks & Regards,
Manikanta.
