Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BFB708F7A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 07:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjESFel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 01:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjESFej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 01:34:39 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19F410C3;
        Thu, 18 May 2023 22:34:37 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34J3ksaF021889;
        Fri, 19 May 2023 05:34:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Ve89u6dCj1VnELc5YfDEQGyWeZzzFw0y02fInwa/dq8=;
 b=cZDn4qRSQbHtXXLnnVbSw+FDwcBWPklOexiqTiH9MefD8LlZcl5N7X8mkyjKtJI09FTs
 jk6ZOmKVVUP8mVbdVMHn8WRscu22RYiSe0NpLznjG8CugorpLdkrvPbBbmz87syTVsrA
 2oUcStakAzrc+73CgywOXrjx2RjBz5nbiLBCjARj0RdCESpzUXr6+fr1XwJEzqx2PL2Q
 ZeSmbixsXO6VRCRX9HcJCPWfqGgRrID67T9QrHStc9Gq5ElUcYk7mYW0/RY8kJqNY5eK
 jFibFSOJ+Qlqmi/zwqib5XKtjjt+Cu5y3I7ybL+PvPLcmpsQ8zcG8TVP1YW0IpcHIMPQ Ag== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qncbhtvpm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 05:34:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34J5YVbU011961
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 05:34:31 GMT
Received: from [10.216.41.71] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 18 May
 2023 22:34:23 -0700
Message-ID: <4ca12678-bc20-419e-ebcd-17da17214a7c@quicinc.com>
Date:   Fri, 19 May 2023 11:04:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 09/11] arm64: dtsi: qcom: ipq5018: enable nodes required
 for multipd
Content-Language: en-US
To:     Kathiravan T <quic_kathirav@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <jassisinghbrar@gmail.com>, <mathieu.poirier@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <quic_gurus@quicinc.com>, <loic.poulain@linaro.org>,
        <quic_eberman@quicinc.com>, <robimarko@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_poovendh@quicinc.com>
References: <1678164097-13247-1-git-send-email-quic_mmanikan@quicinc.com>
 <1678164097-13247-10-git-send-email-quic_mmanikan@quicinc.com>
 <aec18281-f3c4-8631-acd8-337a0aa04316@quicinc.com>
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <aec18281-f3c4-8631-acd8-337a0aa04316@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jX6tZanQW-EzjBE4Q-GwatyecggMBbXO
X-Proofpoint-ORIG-GUID: jX6tZanQW-EzjBE4Q-GwatyecggMBbXO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_02,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 impostorscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=958 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305190047
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/7/2023 7:52 PM, Kathiravan T wrote:
> 
> On 3/7/2023 10:11 AM, Manikanta Mylavarapu wrote:
>> Enable nodes required for multipd remoteproc bring up
>>
>> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/ipq5018.dtsi | 130 ++++++++++++++++++++++++++
>>   1 file changed, 130 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi 
>> b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>> index 084fb7b30dfd..4fa0990ab543 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>> @@ -95,6 +95,24 @@ tz: tz@4ac00000 {
>>               reg = <0x0 0x4ac00000 0x0 0x00400000>;
>>               no-map;
>>           };
>> +
>> +        q6_region: wcnss@4b000000 {
>> +            no-map;
>> +            reg = <0x0 0x4b000000 0x0 0x01700000>;
> 
> 
> move the no-map after reg property to keep it consistent with other 
> nodes. Also no need to pad the size in reg property
> 
> 
Sure. I will do it.
>> +        };
>> +
>> +        smem@4ab00000 {
>> +            compatible = "qcom,smem";
>> +            reg = <0x0 0x4ab00000 0x0 0x00100000>;
>> +            hwlocks = <&tcsr_mutex 0>;
>> +            no-map;
>> +        };
>> +    };
>> +
>> +    firmware {
> 
> 
> nodes should be in sorted order, please take care of this throughout the 
> changes.
> 
> 
Sure. I will do it.
>> +        scm {
>> +            compatible = "qcom,scm-ipq5018", "qcom,scm";
>> +        };
>>       };
>>       timer {
>> @@ -105,6 +123,30 @@ timer {
>>                    <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(4) | 
>> IRQ_TYPE_LEVEL_LOW)>;
>>       };
>> +    wcss: wcss-smp2p {
>> +        compatible = "qcom,smp2p";
>> +        qcom,smem = <435>, <428>;
>> +
>> +        interrupt-parent = <&intc>;
>> +        interrupts = <GIC_SPI 177 IRQ_TYPE_EDGE_RISING>;
>> +
>> +        mboxes = <&apcs_glb 9>;
>> +
>> +        qcom,local-pid = <0>;
>> +        qcom,remote-pid = <1>;
>> +
>> +        wcss_smp2p_out: master-kernel {
>> +            qcom,entry-name = "master-kernel";
>> +            #qcom,smem-state-cells = <1>;
>> +        };
>> +
>> +        wcss_smp2p_in: slave-kernel {
>> +            qcom,entry-name = "slave-kernel";
>> +            interrupt-controller;
>> +            #interrupt-cells = <2>;
>> +        };
>> +    };
>> +
>>       soc: soc@0 {
>>           #address-cells = <1>;
>>           #size-cells = <1>;
>> @@ -217,5 +259,93 @@ frame@b128000 {
>>                   status = "disabled";
>>               };
>>           };
>> +
>> +        tcsr_mutex: hwlock@1905000 {
>> +            compatible = "qcom,tcsr-mutex";
>> +            reg = <0x01905000 0x8000>;
> 
> 
> Please cover the entire region of size 128KB
> 
> 
Sure. I will do it.
>> +            #hwlock-cells = <1>;
>> +        };
>> +
>> +        apcs_glb: mailbox@b111000 {
>> +            compatible = "qcom,ipq5018-apcs-apps-global";
>> +            reg = <0x0b111000 0x1000>;
>> +            #clock-cells = <1>;
>> +            #mbox-cells = <1>;
>> +        };
>> +
>> +        q6v5_wcss: remoteproc@cd00000 {
>> +            compatible = "qcom,ipq5018-q6-mpd";
>> +            #address-cells = <1>;
>> +            #size-cells = <1>;
>> +            ranges;
>> +            reg = <0x0cd00000 0x4040>;
> 
> 
> reg can be moved after compatible
> 
> 
Sure. I will do it.
>> +            interrupts-extended = <&intc GIC_SPI 291 
>> IRQ_TYPE_EDGE_RISING>,
>> +                          <&wcss_smp2p_in 0 0>,
>> +                          <&wcss_smp2p_in 1 0>,
>> +                          <&wcss_smp2p_in 2 0>,
>> +                          <&wcss_smp2p_in 3 0>;
>> +            interrupt-names = "wdog",
>> +                      "fatal",
>> +                      "ready",
>> +                      "handover",
>> +                      "stop-ack";
>> +
>> +            qcom,smem-states = <&wcss_smp2p_out 0>,
>> +                       <&wcss_smp2p_out 1>;
>> +            qcom,smem-state-names = "shutdown",
>> +                        "stop";
>> +            memory-region = <&q6_region>;
>> +
>> +            glink-edge {
>> +                interrupts = <GIC_SPI 179 IRQ_TYPE_EDGE_RISING>;
>> +                label = "rtr";
>> +                qcom,remote-pid = <1>;
>> +                mboxes = <&apcs_glb 8>;
>> +            };
>> +
>> +            q6_wcss_pd1: remoteproc_pd1 {
>> +                compatible = "qcom,ipq5018-wcss-ahb-mpd";
>> +            };
>> +
>> +            q6_wcss_pd2: remoteproc_pd2 {
>> +                compatible = "qcom,ipq5018-wcss-pcie-mpd";
>> +                interrupts-extended = <&wcss_smp2p_in 16 0>,
>> +                    <&wcss_smp2p_in 17 0>,
> 
> 
> Please take care of the alignment
> 
> 
Sure. I will do it.

Thanks & Regards,
Manikanta.
>> +                    <&wcss_smp2p_in 20 0>,
>> +                    <&wcss_smp2p_in 19 0>;
>> +                interrupt-names = "fatal",
>> +                    "ready",
>> +                    "spawn-ack",
>> +                    "stop-ack";
>> +
>> +                qcom,smem-states = <&wcss_smp2p_out 16>,
>> +                        <&wcss_smp2p_out 17>,
>> +                        <&wcss_smp2p_out 18>;
>> +                qcom,smem-state-names = "shutdown",
>> +                            "stop",
>> +                            "spawn";
>> +                status = "disabled";
>> +            };
>> +
>> +            q6_wcss_pd3: remoteproc_pd3 {
>> +                compatible = "qcom,ipq5018-wcss-pcie-mpd";
>> +                interrupts-extended = <&wcss_smp2p_in 24 0>,
>> +                            <&wcss_smp2p_in 25 0>,
>> +                            <&wcss_smp2p_in 28 0>,
>> +                            <&wcss_smp2p_in 27 0>;
>> +                interrupt-names = "fatal",
>> +                        "ready",
>> +                        "spawn-ack",
>> +                        "stop-ack";
>> +
>> +                qcom,smem-states = <&wcss_smp2p_out 24>,
>> +                        <&wcss_smp2p_out 25>,
>> +                        <&wcss_smp2p_out 26>;
>> +                qcom,smem-state-names = "shutdown",
>> +                            "stop",
>> +                            "spawn";
>> +                status = "disabled";
>> +            };
>> +        };
>>       };
>>   };
