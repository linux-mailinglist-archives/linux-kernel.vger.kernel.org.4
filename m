Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9EA6DAED9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 16:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240681AbjDGOYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 10:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240676AbjDGOYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 10:24:38 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BF28684;
        Fri,  7 Apr 2023 07:24:36 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 337EHprv025877;
        Fri, 7 Apr 2023 14:24:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=pDBRtfN61eebLkevBxYbcgdlo7g9vEuAmSMYWFyq7gI=;
 b=YKUne6wz5iM2/ahC5QuhZIwK3kpgJ0XsrBleyPZiql8g+fqXcgTQaqKEjLD3TcU6Gm7N
 2OdsC4Qz3j81PWW9utjqD7Jex7DN48GKgDrnVJ7G/QvrIcE+XMCioioBdM0t2emvPs8f
 jP/KH66U04Y/vUlHHTXu9IKTEIiZKBfNDzAUESqyLBFPocvPjfyP/UukjsgEHy/9JScX
 CBtK5+i1/cgeTl7W4BGZtM9dGeCItjdDHgksLM3wFvW3SHzQv3BsGf+x2y/oIlhDbcik
 qpmmunu2ng4co0eWvIJgeEE/yZj2vw0WVs0fTg7nJa5NNesbG35jBJpeB70ur1gkRxWO Rg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3psv4dk86c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 14:24:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 337EOVVs017126
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Apr 2023 14:24:31 GMT
Received: from [10.216.18.47] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 7 Apr 2023
 07:24:25 -0700
Message-ID: <1ffee0eb-84cc-98b1-77d3-84c6509b0a1a@quicinc.com>
Date:   Fri, 7 Apr 2023 19:54:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V3 5/5] arm64: dts: qcom: ipq9574: Add cpufreq support
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_ipkumar@quicinc.com>
References: <20230406070032.22243-1-quic_devipriy@quicinc.com>
 <20230406070032.22243-6-quic_devipriy@quicinc.com>
 <18eb5708-bf51-26c3-51a0-70a5069ffdbe@linaro.org>
 <c1d916f0-514e-5ad8-d474-4d6fa9842364@quicinc.com>
 <de8d228f-36b9-e35e-2f08-880c96a39267@linaro.org>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <de8d228f-36b9-e35e-2f08-880c96a39267@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Uc5XgD6b0jt1pI68Fdk5cZnf_OOsdnfJ
X-Proofpoint-ORIG-GUID: Uc5XgD6b0jt1pI68Fdk5cZnf_OOsdnfJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_09,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 mlxlogscore=926 phishscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304070131
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/7/2023 5:29 PM, Konrad Dybcio wrote:
> 
> 
> On 7.04.2023 06:53, Devi Priya wrote:
>>
>>
>> On 4/7/2023 1:21 AM, Konrad Dybcio wrote:
>>>
>>>
>>> On 6.04.2023 09:00, Devi Priya wrote:
>>>> Add cpu freq nodes in the device tree to bump cpu frequency above 800MHz.
>>>>
>>>> Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>>>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>>>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>>>> ---
>>>>    Changes in V3:
>>>>      - No change
>>>>
>>>>    arch/arm64/boot/dts/qcom/ipq9574.dtsi | 58 +++++++++++++++++++++++++++
>>>>    1 file changed, 58 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>>>> index 1f9b7529e7ed..cfef87b5fd22 100644
>>>> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>>>> @@ -6,6 +6,7 @@
>>>>     * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
>>>>     */
>>>>    +#include <dt-bindings/clock/qcom,apss-ipq.h>
>>>>    #include <dt-bindings/clock/qcom,ipq9574-gcc.h>
>>>>    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>>>    #include <dt-bindings/reset/qcom,ipq9574-gcc.h>
>>>> @@ -37,6 +38,10 @@
>>>>                reg = <0x0>;
>>>>                enable-method = "psci";
>>>>                next-level-cache = <&L2_0>;
>>>> +            clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
>>>> +            clock-names = "cpu";
>>>> +            operating-points-v2 = <&cpu_opp_table>;
>>>> +            cpu-supply = <&ipq9574_s1>;
>>>>            };
>>>>              CPU1: cpu@1 {
>>>> @@ -45,6 +50,10 @@
>>>>                reg = <0x1>;
>>>>                enable-method = "psci";
>>>>                next-level-cache = <&L2_0>;
>>>> +            clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
>>>> +            clock-names = "cpu";
>>>> +            operating-points-v2 = <&cpu_opp_table>;
>>>> +            cpu-supply = <&ipq9574_s1>;
>>>>            };
>>>>              CPU2: cpu@2 {
>>>> @@ -53,6 +62,10 @@
>>>>                reg = <0x2>;
>>>>                enable-method = "psci";
>>>>                next-level-cache = <&L2_0>;
>>>> +            clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
>>>> +            clock-names = "cpu";
>>>> +            operating-points-v2 = <&cpu_opp_table>;
>>>> +            cpu-supply = <&ipq9574_s1>;
>>>>            };
>>>>              CPU3: cpu@3 {
>>>> @@ -61,6 +74,10 @@
>>>>                reg = <0x3>;
>>>>                enable-method = "psci";
>>>>                next-level-cache = <&L2_0>;
>>>> +            clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
>>>> +            clock-names = "cpu";
>>>> +            operating-points-v2 = <&cpu_opp_table>;
>>>> +            cpu-supply = <&ipq9574_s1>;
>>>>            };
>>>>              L2_0: l2-cache {
>>>> @@ -75,6 +92,47 @@
>>>>            reg = <0x0 0x40000000 0x0 0x0>;
>>>>        };
>>>>    +    cpu_opp_table: opp-table-cpu {
>>> This is not sorted properly. It should probably come
>>> after memory alphabetically ('o' > 'm')
>>>
>> Yes, But I see that opp-table-cpu node is already placed after
>> memory@40000000
> 
> Oh you're right, the diff doesn't really show that very
> well and I didn't notice..
> 
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Sure, thank you!
> 
> Konrad
>>> Konrad
>>>> +        compatible = "operating-points-v2";
>>>> +        opp-shared;
>>>> +
>>>> +        opp-936000000 {
>>>> +            opp-hz = /bits/ 64 <936000000>;
>>>> +            opp-microvolt = <725000>;
>>>> +            clock-latency-ns = <200000>;
>>>> +        };
>>>> +
>>>> +        opp-1104000000 {
>>>> +            opp-hz = /bits/ 64 <1104000000>;
>>>> +            opp-microvolt = <787500>;
>>>> +            clock-latency-ns = <200000>;
>>>> +        };
>>>> +
>>>> +        opp-1416000000 {
>>>> +            opp-hz = /bits/ 64 <1416000000>;
>>>> +            opp-microvolt = <862500>;
>>>> +            clock-latency-ns = <200000>;
>>>> +        };
>>>> +
>>>> +        opp-1488000000 {
>>>> +            opp-hz = /bits/ 64 <1488000000>;
>>>> +            opp-microvolt = <925000>;
>>>> +            clock-latency-ns = <200000>;
>>>> +        };
>>>> +
>>>> +        opp-1800000000 {
>>>> +            opp-hz = /bits/ 64 <1800000000>;
>>>> +            opp-microvolt = <987500>;
>>>> +            clock-latency-ns = <200000>;
>>>> +        };
>>>> +
>>>> +        opp-2208000000 {
>>>> +            opp-hz = /bits/ 64 <2208000000>;
>>>> +            opp-microvolt = <1062500>;
>>>> +            clock-latency-ns = <200000>;
>>>> +        };
>>>> +    };
>>>> +
>>>>        firmware {
>>>>            scm {
>>>>                compatible = "qcom,scm-ipq9574", "qcom,scm";
>> Best Regards,
>> Devi Priya
