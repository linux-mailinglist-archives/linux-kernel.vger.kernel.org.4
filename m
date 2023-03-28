Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93956CBDB5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 13:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjC1LbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 07:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbjC1Law (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:30:52 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CD39740;
        Tue, 28 Mar 2023 04:30:27 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32SA2Otf019896;
        Tue, 28 Mar 2023 11:29:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=5zZ18TmtiiLWaBta4lPXKr6kpJlJfrZeU+Pd0N9Scok=;
 b=CPbekvgpt5HmUR+Nn6LJNp8UlWIjXjLyI6emMApq7165MNaCKoVXM5P1BdzIifIrOlh7
 8YR39H9Okjp0ys6jmUvfWJ1AHiXhL4U8gltl+hPWXnLyhvj0jQX1g7U2CtCQIhvbaNaz
 utywWC0rMRPInMto2gmyI5+WqirDtjbfwg2HcHNR743LCguW92SQxLLPqXCXrCdaian7
 WlV3a6sopFnHVW8D6fR1pQ0m89Ts2zShjyiHy/uqxHY0phC6S1fxXPb0JSLx+3WMCBF9
 b29Mr7Pw9Ejk3XqHk8JGQmNtdawX4UuZunZAKsycbSVHkfN08mhS19ZAPYjwZYqLeMjv Lg== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pkx4t8622-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 11:29:59 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32SBTvNc013609
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 11:29:57 GMT
Received: from [10.233.17.245] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Mar
 2023 04:29:51 -0700
Message-ID: <3f0fcf17-f073-298f-7876-547e780ac600@quicinc.com>
Date:   Tue, 28 Mar 2023 19:29:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: Add Coresight Dummy Trace YAML
 schema
Content-Language: en-US
To:     Mike Leach <mike.leach@linaro.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>, Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        <linux-doc@vger.kernel.org>
References: <20230324061608.33609-1-quic_hazha@quicinc.com>
 <20230324061608.33609-3-quic_hazha@quicinc.com>
 <e51c200e-6de0-d516-3f32-28367b2f5a95@linaro.org>
 <e6b0a542-17d9-290e-7c84-8356a38d6802@quicinc.com>
 <CAJ9a7VjC+1m8odyotBoG3EPAL=Cn90fCCY1xPGFyg8uKEar7nQ@mail.gmail.com>
From:   Hao Zhang <quic_hazha@quicinc.com>
In-Reply-To: <CAJ9a7VjC+1m8odyotBoG3EPAL=Cn90fCCY1xPGFyg8uKEar7nQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: v29eqGLnjieDoF_fbJP-7Ek1pKYggo-R
X-Proofpoint-ORIG-GUID: v29eqGLnjieDoF_fbJP-7Ek1pKYggo-R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-28_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303280094
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On 3/28/2023 6:12 PM, Mike Leach wrote:
> Hi,
> 
> As per my comments in the previous patch in this set....
> 
> On Mon, 27 Mar 2023 at 08:38, Hao Zhang <quic_hazha@quicinc.com> wrote:
>>
>> Hi Krzysztof,
>>
>> On 3/25/2023 7:49 PM, Krzysztof Kozlowski wrote:
>>> On 24/03/2023 07:16, Hao Zhang wrote:
>>>> Add new coresight-dummy.yaml file describing the bindings required
>>>> to define coresight dummy trace in the device trees.
>>>>
>>>
>>> Subject: drop second/last, redundant "YAML schema". The "dt-bindings"
>>> prefix is already stating that these are bindings and all new must be DT
>>> schema. You cannot add anything else, so this is redundant.
>>>
>> I will take your advice to drop redundant part of title in the next
>> version of patch.
>>>
>>>> Signed-off-by: Hao Zhang <quic_hazha@quicinc.com>
>>>> ---
>>>>    .../bindings/arm/qcom,coresight-dummy.yaml    | 118 ++++++++++++++++++
>>>>    1 file changed, 118 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/arm/qcom,coresight-dummy.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-dummy.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-dummy.yaml
>>>> new file mode 100644
>>>> index 000000000000..7b719b084d72
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/arm/qcom,coresight-dummy.yaml
>>>> @@ -0,0 +1,118 @@
>>>> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
>>>> +# Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/arm/qcom,coresight-dummy.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: QCOM Coresight Dummy component
>>>> +
>>>> +description: |
>>>> +  The Coresight Dummy component is for the specific devices that HLOS don't have
>>>> +  permission to access or configure. Such as Coresight sink EUD, some TPDMs etc.
>>>> +  So there need driver to register dummy devices as Coresight devices. Provide
>>>> +  Coresight API for dummy device operations, such as enabling and disabling
>>>> +  dummy devices. Build the Coresight path for dummy sink or dummy source for
>>>> +  debugging.
>>>> +
>>>> +  The primary use case of the coresight dummy is to build path for dummy sink or
>>>> +  dummy source.
>>>> +
>>>> +maintainers:
>>>> +  - Mao Jinlong <quic_jinlmao@quicinc.com>
>>>> +  - Tao Zhang <quic_taozha@quicinc.com>
>>>> +  - Hao Zhang <quic_hazha@quicinc.com>
>>>> +
>>>> +select:
>>>> +  properties:
>>>> +    compatible:
>>>> +      contains:
>>>> +        enum:
>>>> +          - qcom,coresight-dummy
> 
> Can we have coresight-dummy-source and coresight-dummy-sink?

Sure, I will take your advice in the next version of patch.

> 
>>>> +  required:
>>>> +    - compatible
>>>
>>> Why do you need the select?
>>>
>> This is a mistake, will remove it in the next version of patch.
>>>> +
>>>> +properties:
>>>> +  $nodename:
>>>> +    pattern: "^dummy_.*(sink|source)_[0-9]+.*$"
>>>
>>> We do not enforce node names in individual bindings. Why do you need it?
>>> Plus underscore is not even proper character...
>>>
>> I will remove this node.
>>
>>>> +  compatible:
>>>> +    items:
>>>
>>> Drop items. You have only one item, so no need for list.
>>
>> I will take your advice and update it in the next version of patch.
>>
>>>> +      - const: qcom,coresight-dummy
>>>> +
>>>> +  qcom,dummy-sink:
>>>> +    type: boolean
>>>> +    description:
>>>> +      Indicates that the type of this coresight node is dummy sink.
>>>
>>> You just duplicated property name. Write something useful.
>>>
>>>> +
>>>> +  qcom,dummy-source:
>>>> +    type: boolean
>>>> +    description:
>>>> +      Indicates that the type of this coresight node is dummy source.
>>>
>>> You just duplicated property name. Write something useful.
>>>
>>
> 
> These properties not required if the compatible name is more specific
> 

I will update it in the next version of patch.

>> Sure, I will add more details for it.
>>
>>>> +
>>>> +  out-ports:
>>>> +    description: |
>>>
>>> No need for |
>>>
>>>> +      Output connections from the dummy source to Coresight Trace bus.
>>>> +    $ref: /schemas/graph.yaml#/properties/ports
>>>> +
>>>> +    properties:
>>>> +      port:
>>>> +        description: Output connection from the dummy source to Coresight
>>>> +            Trace bus.
>>>> +        $ref: /schemas/graph.yaml#/properties/port
>>>> +
>>>> +  in-ports:
>>>> +    description: |
>>>
>>> Ditto
>>>
>> I will remove it in the next version of patch.
>>
>>>> +      Input connections from the CoreSight Trace bus to dummy sink.
>>>> +    $ref: /schemas/graph.yaml#/properties/ports
>>>> +
>>>> +    properties:
>>>> +      port:
>>>> +        description: Input connection from the Coresight Trace bus to
>>>> +            dummy sink.
>>>> +        $ref: /schemas/graph.yaml#/properties/port
>>>> +
>>>> +required:
>>>> +  - compatible
>>>> +
> 
> The binding should constrain out ports to dummy-source only, and in
> ports to dummy sink only.
> 
> Regards
> 
> Mike
> 

I will update it according to your advice in the next version of patch.

Thanks,
Hao

>>>> +additionalProperties: false
>>>> +
>>>> +oneOf:
>>>> +  - required:
>>>> +      - qcom,dummy-sink
>>>> +  - required:
>>>> +      - qcom,dummy-source
>>>> +
>>>> +examples:
>>>> +  # minimum dummy sink definition. dummy sink connect to coresight replicator.
>>>> +  - |
>>>> +    dummy_sink_1 {
>>>
>>> Node names should be generic, so "sink"
>>> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
>>>
>>>> +      compatible = "qcom,coresight-dummy";
>>>> +      qcom,dummy-sink;
>>>> +
>>>> +      in-ports {
>>>> +        port {
>>>> +          eud_in_replicator_swao: endpoint {
>>>> +            remote-endpoint =
>>>> +              <&replicator_swao_out_eud>;
>>>
>>> Why line break after =?
>>>
>>
>>>> +          };
>>>> +        };
>>>> +      };
>>>> +    };
>>>> +
>>>> +  # minimum dummy source definition. dummy source connect to coresight funnel.
>>>
>>> If you use sentences, then start with capital letter.
>>>
>>
>> I will update it according to your advice in the next version of patch.
>>
>>>> +  - |
>>>> +    dummy_source_1 {
>>>> +      compatible = "qcom,coresight-dummy";
>>>> +      qcom,dummy-source;
>>>> +
>>>> +      out-ports {
>>>> +        port {
>>>> +          dummy_riscv_out_funnel_swao: endpoint {
>>>> +            remote-endpoint =
>>>> +              <&funnel_swao_in_dummy_riscv>;
>>>
>>> Why line break?
>>
>> I copy it from device tree and keep the original format, will correct
>> the format in the next version of patch.
>>
>> Thanks,
>> Hao
>>
>>>> +          };
>>>> +        };
>>>> +      };
>>>> +    };
>>>> +
>>>> +...
>>>
>>> Best regards,
>>> Krzysztof
>>>
> 
> 
> 
