Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6DC36C4C2B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 14:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjCVNrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 09:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCVNrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 09:47:05 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C753574D5;
        Wed, 22 Mar 2023 06:47:04 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32M6O5xd018155;
        Wed, 22 Mar 2023 13:46:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=FR+44d4jP821EvAKO/qXlqfD1vyoOuDuFhxiH8bSo3c=;
 b=YriyVRplDF7kOZD+FH8GNWIsxylNuMxim3qtQdJIhRrQzYH6MdRIhYaIzqTtspB6O2V1
 SDVwd99ZGtqu5KT/tfj+AEAIWJMcFyXAkjkzCEUvTpIUKkTxMZdhDB+heKJ/fZfaBwca
 YqGXj4M2cyKyjdPfAjekDxfFW/eJ6gve083iUtzDpvRqAQM5Ab7/uwKauRXpFKHJUA+l
 fQWhZUIinfskSberuFO5DlHWgR1FmNIYCHOljrh5GlwYaYJtPriQwgGfqiH5t0MtfSPd
 jC7Xf2IQgVaVScdu/YXeKRrrN3NvqTZepRJlZAkLesK1ggGGTjpEari/VTxAsjlZ1Q/p Pw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pfbjybjbk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 13:46:54 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32MDkrC1029190
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 13:46:53 GMT
Received: from [10.50.8.113] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 22 Mar
 2023 06:46:50 -0700
Message-ID: <e88d9482-4858-7042-7148-142ed9ebb6ad@quicinc.com>
Date:   Wed, 22 Mar 2023 19:16:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V1 2/4] dt-bindings: soc: qcom,mpm-sleep-counter: Add the
 dtschema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <cover.1679403696.git.quic_schowdhu@quicinc.com>
 <576e53a1d0ef218536da976102b4cc207436ec1d.1679403696.git.quic_schowdhu@quicinc.com>
 <fc46c48d-2de0-ba3a-08b0-a09526bd9e26@linaro.org>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <fc46c48d-2de0-ba3a-08b0-a09526bd9e26@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: o_J6v8kthHVy3OnCoy1tmptE5EPNtjBh
X-Proofpoint-ORIG-GUID: o_J6v8kthHVy3OnCoy1tmptE5EPNtjBh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_11,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303220101
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/21/2023 11:03 PM, Krzysztof Kozlowski wrote:
> On 21/03/2023 14:51, Souradeep Chowdhury wrote:
>> Add the device tree bindings for the module power manager sleep
>> counter.
>>
>> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> ---
>>   .../bindings/soc/qcom/qcom,mpm-sleep-counter.yaml  | 40 ++++++++++++++++++++++
>>   1 file changed, 40 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,mpm-sleep-counter.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,mpm-sleep-counter.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,mpm-sleep-counter.yaml
>> new file mode 100644
>> index 0000000..f9f46b7
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,mpm-sleep-counter.yaml
>> @@ -0,0 +1,40 @@
>> +# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/soc/qcom/qcom,mpm-sleep-counter.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: MPM Sleep Counter
>> +
>> +maintainers:
>> +  - Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> +
>> +description: |
>> +    MPM(Module Power Manager) has a sleep counter which is used to track
> 
> Missing space:
> MPM (Module
> 

Ack
>> +    various stages of the boot process in Qualcomm.
> 
> in Qualcomm SoC. Because you do not track it in the company...
> 

Ack
>> +
>> +properties:
>> +  compatible:
>> +    items:
> 
> Drop items.
> 

Ack
>> +      - const: qcom,mpm2-sleep-counter
> 
> SoC specific compatible.
> 

This is a generic Module Power Manager Sleep Counter which is present in 
all Qcom Socs, so SoC specific compatible is not given here.

>> +
>> +  reg:
>> +    items:
>> +      - description: MPM Sleep Counter Base
> 
> just maxItems: 1
> 

Ack
>> +
>> +  clock-frequency:
>> +    description: Frequency for the sleep counter
> 
> Since this does not have clocks, what frequency you are setting here?

Module Power Manager(MPM) Sleep Counter is a clock that starts ticking 
from Primary Boot Loader(PBL) Stage. This is usually a 32 Khz clock and 
the frequency for the same is stored here.

> 
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    mpm2-sleep-counter@c221000{
> 
> Node names should be generic.
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Ack
> 
>> +       compatible = "qcom,mpm2-sleep-counter";
>> +       reg = <0xc221000 0x1000>;
>> +       clock-frequency = <32768>;
>> +    };
> 
> Best regards,
> Krzysztof
> 
