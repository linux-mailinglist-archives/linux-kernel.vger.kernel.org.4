Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1526822C8
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 04:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjAaDYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 22:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjAaDYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 22:24:44 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BB6210D;
        Mon, 30 Jan 2023 19:24:43 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30V2LA4X016345;
        Tue, 31 Jan 2023 03:24:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=5Ly9k2vbaRfxNYTkMAZxUzQjFn6BER4QVrRQ2fK++34=;
 b=JVr98NlFWJJynZI4nlRGsds0N0I/DSMnClZJpID478d8kdNKyJ/evFi0GnUuqPujUrI8
 3kI1eNiOkcPSnT2b8hE6napZse7KydDXgyolXcHUg9TW+2iJDEDYraLpxDbr+abJfKfj
 3CSznaR0M+c94RXkCAThJC6Xy71teg88HhbxngnEZ7yPMyCqzMaWe8s1TFvXh8yyPkRJ
 wfbJ5Ul2Ue1hJiTpS4pVSeshkasZHGCMEu5dw5Egk9+M9OgvH4quX9XaxDk4eQH49CF3
 0EKDfvhSxpik0rYQhkhotFddUcJxXK60X8hVz7i6pqRHgOBhO2RVUwRMHD7Liocfoou1 QA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncut2nkba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 03:24:28 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30V3ORTl003028
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 03:24:27 GMT
Received: from [10.253.75.6] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 30 Jan
 2023 19:24:21 -0800
Message-ID: <058241be-ffa8-6fc6-7262-705ec41e849c@quicinc.com>
Date:   Tue, 31 Jan 2023 11:23:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 1/9] dt-bindings: arm: Add support for DSB element
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <bjorn.andersson@linaro.org>,
        Tao Zhang <taozha@qti.qualcomm.com>
References: <1674114105-16651-1-git-send-email-quic_taozha@quicinc.com>
 <1674114105-16651-2-git-send-email-quic_taozha@quicinc.com>
 <cd7a2eac-5d70-6dcd-ddbd-317e1cbd7d23@linaro.org>
Content-Language: en-US
From:   Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <cd7a2eac-5d70-6dcd-ddbd-317e1cbd7d23@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wkRiWcp08z695MHa2FB5N0gTQcoQdeFB
X-Proofpoint-ORIG-GUID: wkRiWcp08z695MHa2FB5N0gTQcoQdeFB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_19,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxlogscore=951 impostorscore=0 priorityscore=1501
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310029
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 1/19/2023 6:44 PM, Krzysztof Kozlowski wrote:
> On 19/01/2023 08:41, Tao Zhang wrote:
>> Add property "qcom,dsb-elem-size" to support DSB(Discrete Single
>> Bit) element for TPDA. Specifies the DSB element size supported
>> by each monitor connected to the aggregator on each port. Should
>> be specified in pairs (port, dsb element size).
>>
>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> Signed-off-by: Tao Zhang <taozha@qti.qualcomm.com>
> You are the same person and it is still the same organization
> (Qualcomm), right? Only one SoB.
I will change and update this in the next patch series.
>
>> ---
>>   .../bindings/arm/qcom,coresight-tpda.yaml          | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
>> index 2ec9b5b..298db7f 100644
>> --- a/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
>> +++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
>> @@ -58,6 +58,26 @@ properties:
>>       minItems: 1
>>       maxItems: 2
>>   
>> +  qcom,dsb-element-size:
>> +    description: |
>> +      Specifies the DSB(Discrete Single Bit) element size supported by
>> +      each monitor connected to the aggregator on each port. Should be
>> +      specified in pairs <port, dsb element size>.
> s/port/port number/

It should be "port number" here.

I will change "<port, dsb element size>" to "<port number, DSB element 
size>" in the next patch series.

>> +
>> +      Note: The maximum value of the port number depends on how many
>> +      input ports the current TPDA has. DSB element size currently only
>> +      supports 32-bit and 64-bit.
>> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
>> +    items:
> Are some reasonable maxItems known?

This is related to hardware design, depending on how many input ports 
the TPDA has.

We cannot limit it to a reasonable maximum value from the software.

According to the existing hardware design, TPDA with the most input 
ports has about 30 input ports.

But there may be TPDA with more input ports.

>
>> +      items:
>> +        - description: |
>> +            "port" indicates TPDA input port number
> What is "port"? You quoted it like it was some name of variable or
> property. Where is then?

The "port" here refers to the port number of other Coresight devices 
connected to the TPDA input port.

I will change and update it in the next patch series.

>> +          minimum: 0
>> +        - description: |
>> +            "dsb element size" indicates dsb element size
> "A" indicates A. This sentence does not make sense.
>
> Also missing units.
>
> s/dsb/DSB/
"DSB element size" indicate the size of the element in DSB. DSB(Discrete 
Single

Bit) is a data collection unit.

I will change and update it in the next patch series.

>
>> +          minimum: 0
>> +          maximum: 64
>> +
>>     clocks:
>>       maxItems: 1
>>   
>> @@ -100,6 +120,8 @@ examples:
>>          compatible = "qcom,coresight-tpda", "arm,primecell";
>>          reg = <0x6004000 0x1000>;
>>   
>> +       qcom,dsb-element-size = <0 32>;
>> +
>>          clocks = <&aoss_qmp>;
>>          clock-names = "apb_pclk";
>>   
> Best regards,
> Krzysztof

Best,

Tao

