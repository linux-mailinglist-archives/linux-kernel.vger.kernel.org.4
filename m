Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12853669854
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241794AbjAMNUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241875AbjAMNTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:19:38 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1E3103;
        Fri, 13 Jan 2023 05:09:51 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DBlBka032516;
        Fri, 13 Jan 2023 13:09:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Pcu7qTXYqJaD0IKb069b6gojgn9RycIXtUdyV8gwfqs=;
 b=jbXxzjDLc8UvPo+TzSLsh5rg/bOG0nvPXi2cuVYXa8dvwMt3vzSol4VuHC5jpNqS5gbY
 zqzc99QbpkaHoHIaZBLD7a5+J6ywFAzRHUr6og18+gyp/mG1JN0dbG8g0uaM+hf+WZ5u
 tcc/V5wdkHwhnPTGRqTbaOSYoYQx0ZALZRmWCYyi/dkBm+qGDxoEtjv6VRJz59QJqRf9
 d5qs4V9K6GujwQWtMG9zaEwyv/A2rUpv4nHzgaWuWVGhi7yAC/Zj++qGPOKOV/1+R5Zi
 RgN0CEHqh3mZaW9AlindClvymxg/xft6T78eatQ72rjoddFu8xrm6qKWwJdEG6VfgABI qQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n32wu90wj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 13:09:00 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30DD8uvv007975
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 13:08:56 GMT
Received: from [10.50.57.3] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 13 Jan
 2023 05:08:48 -0800
Message-ID: <bd52102b-6b01-2659-09ec-238463b0eb82@quicinc.com>
Date:   Fri, 13 Jan 2023 18:38:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/7] dt-bindings: arm64: ipq9574: Add binding descriptions
 for clock and reset
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linus.walleij@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>, <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <dmitry.baryshkov@linaro.org>,
        <nfraprado@collabora.com>, <broonie@kernel.org>,
        <tdas@codeaurora.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>
References: <20230110121316.24892-1-quic_devipriy@quicinc.com>
 <20230110121316.24892-2-quic_devipriy@quicinc.com>
 <603f9c39-3e36-bb44-2305-1d37fe033dd5@linaro.org>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <603f9c39-3e36-bb44-2305-1d37fe033dd5@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3qn-0KVstC7QwFw_lMeGphGaiX0YT-GO
X-Proofpoint-ORIG-GUID: 3qn-0KVstC7QwFw_lMeGphGaiX0YT-GO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_06,2023-01-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 spamscore=0 clxscore=1011 lowpriorityscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301130088
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/11/2023 3:06 PM, Krzysztof Kozlowski wrote:
> On 10/01/2023 13:13, devi priya wrote:
>> Adding support for the global clock controller found on
>> IPQ9574 based devices
> 
> Subject: drop second/last, redundant "bindings descriptions for". The
> "dt-bindings" prefix is already stating that these are bindings.
Sure, will do
> 
>>
>> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
>> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
>> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
>> ---
>>   .../bindings/clock/qcom,gcc-other.yaml        |   4 +
>>   .../devicetree/bindings/clock/qcom,gcc.yaml   |   9 +-
>>   include/dt-bindings/clock/qcom,gcc-ipq9574.h  | 226 ++++++++++++++++++
>>   include/dt-bindings/reset/qcom,gcc-ipq9574.h  | 164 +++++++++++++
>>   4 files changed, 402 insertions(+), 1 deletion(-)
>>   create mode 100644 include/dt-bindings/clock/qcom,gcc-ipq9574.h
>>   create mode 100644 include/dt-bindings/reset/qcom,gcc-ipq9574.h
>>
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
>> index 2e8acca64af1..cc563d640336 100644
>> --- a/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
>> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
>> @@ -18,6 +18,8 @@ description: |
>>       include/dt-bindings/clock/qcom,gcc-ipq4019.h
>>       include/dt-bindings/clock/qcom,gcc-ipq6018.h
>>       include/dt-bindings/reset/qcom,gcc-ipq6018.h
>> +    include/dt-bindings/clock/qcom,gcc-ipq9574.h
>> +    include/dt-bindings/reset/qcom,gcc-ipq9574.h
>>       include/dt-bindings/clock/qcom,gcc-msm8953.h
>>       include/dt-bindings/clock/qcom,gcc-mdm9607.h
>>       include/dt-bindings/clock/qcom,gcc-mdm9615.h
>> @@ -34,6 +36,8 @@ properties:
>>         - qcom,gcc-mdm9607
>>         - qcom,gcc-msm8953
>>         - qcom,gcc-mdm9615
>> +      - qcom,gcc-ipq9574
> 
> Incorrect order but anyway let's switch to new naming style just like
> SM8550 and SA8775p.
okay
> 
>> +
> 
> Not related change.
> 
Understood, will remove
>>   
>>   required:
>>     - compatible
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
>> index 7129fbcf2b6c..5a71268538e6 100644
>> --- a/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
>> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
>> @@ -24,6 +24,14 @@ properties:
>>     '#power-domain-cells':
>>       const: 1
>>   
>> +  clocks:
>> +    minItems: 1
>> +    maxItems: 8
>> +
>> +  clock-names:
>> +    minItems: 1
>> +    maxItems: 8
> 
> This does not look correct, neither related.
Okay
>> +
>>     reg:
>>       maxItems: 1
>>   
>> @@ -35,7 +43,6 @@ required:
>>     - reg
>>     - '#clock-cells'
>>     - '#reset-cells'
>> -  - '#power-domain-cells'
> 
> Eee? Why? What's this?
Sure, will address it accordingly
> 
> 
> 
> 
> Best regards,
> Krzysztof
> 

Best regards,
Devi Priya
