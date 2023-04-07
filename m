Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB966DA8E3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 08:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238302AbjDGGYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 02:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjDGGYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 02:24:49 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BB2AD3A;
        Thu,  6 Apr 2023 23:24:34 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3374KJOV027393;
        Fri, 7 Apr 2023 06:23:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0OJ/jSYziRv5Ytnzvca+2yIZwCushE9cQrL2Pin+XQU=;
 b=Zh8as3vpQiD56/z4ChZMlF/auZtxhlE3CpJu26/RXzfkDd7nCLBofca9HY+YOmU0VhFs
 oOxo/BgQ8bLXQipPw0P+vdU0SrLwVeGr/7ocWeH+0YtfGakTcYr6R4QVnkm99gLoVwFW
 EhlesBFc+iJhaHHe3oJPPN7OxWdNnfbnd3fbN7hcynrrhXZ++VQkugDB1D86UnqfqeyG
 MNG/MxeDojO3EKOb9DK3TqLo1lyAqSfEC8eg+i3SHwVfmWYZBvgPUi3BKYLbP8OeE7/4
 4s66+UzpherJKTeFx4kuw7XTBfrmPAHuhrh1ZiRzDB3vxptselIdZrYpf2XUN7bMzD/F GQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pt8t58h65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 06:23:50 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3376NnVQ012007
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Apr 2023 06:23:49 GMT
Received: from [10.233.17.245] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 6 Apr 2023
 23:23:43 -0700
Message-ID: <d24c14e4-46f2-dbea-96ca-5b665effcea3@quicinc.com>
Date:   Fri, 7 Apr 2023 14:23:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From:   Hao Zhang <quic_hazha@quicinc.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: Add Coresight Dummy Trace YAML
 schema
To:     Rob Herring <robh@kernel.org>
CC:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>, Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        "Yuanfang Zhang" <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        <linux-doc@vger.kernel.org>
References: <20230324061608.33609-1-quic_hazha@quicinc.com>
 <20230324061608.33609-3-quic_hazha@quicinc.com>
 <20230331184700.GA1920623-robh@kernel.org>
Content-Language: en-US
In-Reply-To: <20230331184700.GA1920623-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Iwvvw_971ySGM9DcoK2VmBdsrh4fD1kw
X-Proofpoint-GUID: Iwvvw_971ySGM9DcoK2VmBdsrh4fD1kw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_03,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 suspectscore=0 malwarescore=0 mlxscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304070058
X-Spam-Status: No, score=-3.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 4/1/2023 2:47 AM, Rob Herring wrote:
> On Fri, Mar 24, 2023 at 02:16:07PM +0800, Hao Zhang wrote:
>> Add new coresight-dummy.yaml file describing the bindings required
>> to define coresight dummy trace in the device trees.
> 
> The diff tells me all this. Please explain why this is needed and needs
> to be in DT here.
> 
Sure, will add more details to describe it.
>>
>> Signed-off-by: Hao Zhang <quic_hazha@quicinc.com>
>> ---
>>   .../bindings/arm/qcom,coresight-dummy.yaml    | 118 ++++++++++++++++++
>>   1 file changed, 118 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/arm/qcom,coresight-dummy.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-dummy.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-dummy.yaml
>> new file mode 100644
>> index 000000000000..7b719b084d72
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/qcom,coresight-dummy.yaml
>> @@ -0,0 +1,118 @@
>> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
>> +# Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/arm/qcom,coresight-dummy.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: QCOM Coresight Dummy component
>> +
>> +description: |
>> +  The Coresight Dummy component is for the specific devices that HLOS don't have
>> +  permission to access or configure. Such as Coresight sink EUD, some TPDMs etc.
> 
> EUD? TPDM?

The term EUD stand for Embedded USB debugger, it will be connected to 
coresight replicator component to receive and store coresight data. It 
would be configured by NON-HLOS, and need HLOS(Kernel) to configure the 
last coresight components. So we will use dummy sink to replace it in 
kernel side for building the whole path(from source to sink).

The TPDM is Trace Profiling and Diagnostics Monitor, it is a coresight 
trace source which could get hardware events from the IP subsystem.

> 
> I don't really love 'dummy' used here. Maybe the OS still wants/needs to
> know where the sink goes to even if not configurable.
> 
> You *can* have multiple compatibles for a single generic driver if those
> compatibles might be useful some day.
> 

Yes, we want to take it as a generic framework for coresight dummy sink 
and source. I think we could add one more compatible to indicate the 
type of it.

>> +  So there need driver to register dummy devices as Coresight devices. Provide
>> +  Coresight API for dummy device operations, such as enabling and disabling
>> +  dummy devices. Build the Coresight path for dummy sink or dummy source for
>> +  debugging.
>> +
>> +  The primary use case of the coresight dummy is to build path for dummy sink or
>> +  dummy source.
>> +
>> +maintainers:
>> +  - Mao Jinlong <quic_jinlmao@quicinc.com>
>> +  - Tao Zhang <quic_taozha@quicinc.com>
>> +  - Hao Zhang <quic_hazha@quicinc.com>
>> +
>> +select:
>> +  properties:
>> +    compatible:
>> +      contains:
>> +        enum:
>> +          - qcom,coresight-dummy
>> +  required:
>> +    - compatible
>> +
>> +properties:
>> +  $nodename:
>> +    pattern: "^dummy_.*(sink|source)_[0-9]+.*$"
> 
> Don't use '_' in node names.
> 
> Convention for multiple instances without 'reg' is '-[0-9]+' on the end,
> but you are allowing anything after that.
> 

OK, I will update it in the next version of patch.

>> +  compatible:
>> +    items:
>> +      - const: qcom,coresight-dummy
>> +
>> +  qcom,dummy-sink:
>> +    type: boolean
>> +    description:
>> +      Indicates that the type of this coresight node is dummy sink.
>> +
>> +  qcom,dummy-source:
> 
> Incorporate source or sink into the compatible strings.
> 

OK, I will update it in the next version of patch.

> It's also somewhat redundant with 'in-ports' vs. 'out-ports'.

I think I could add more details to describe it.

> 
>> +    type: boolean
>> +    description:
>> +      Indicates that the type of this coresight node is dummy source.
>> +
>> +  out-ports:
>> +    description: |
> 
> Don't need '|' unless you need to preserve formatting.

I will remove it.

Thanks for your comments, I will take your advice and update it in the 
next version of patch.

Thanks,
Hao

> 
>> +      Output connections from the dummy source to Coresight Trace bus.
>> +    $ref: /schemas/graph.yaml#/properties/ports
>> +
>> +    properties:
>> +      port:
>> +        description: Output connection from the dummy source to Coresight
>> +            Trace bus.
>> +        $ref: /schemas/graph.yaml#/properties/port
>> +
>> +  in-ports:
>> +    description: |
>> +      Input connections from the CoreSight Trace bus to dummy sink.
>> +    $ref: /schemas/graph.yaml#/properties/ports
>> +
>> +    properties:
>> +      port:
>> +        description: Input connection from the Coresight Trace bus to
>> +            dummy sink.
>> +        $ref: /schemas/graph.yaml#/properties/port
>> +
>> +required:
>> +  - compatible
>> +
>> +additionalProperties: false
>> +
>> +oneOf:
>> +  - required:
>> +      - qcom,dummy-sink
>> +  - required:
>> +      - qcom,dummy-source
>> +
>> +examples:
>> +  # minimum dummy sink definition. dummy sink connect to coresight replicator.
>> +  - |
>> +    dummy_sink_1 {
>> +      compatible = "qcom,coresight-dummy";
>> +      qcom,dummy-sink;
>> +
>> +      in-ports {
>> +        port {
>> +          eud_in_replicator_swao: endpoint {
>> +            remote-endpoint =
>> +              <&replicator_swao_out_eud>;
>> +          };
>> +        };
>> +      };
>> +    };
>> +
>> +  # minimum dummy source definition. dummy source connect to coresight funnel.
>> +  - |
>> +    dummy_source_1 {
>> +      compatible = "qcom,coresight-dummy";
>> +      qcom,dummy-source;
>> +
>> +      out-ports {
>> +        port {
>> +          dummy_riscv_out_funnel_swao: endpoint {
>> +            remote-endpoint =
>> +              <&funnel_swao_in_dummy_riscv>;
>> +          };
>> +        };
>> +      };
>> +    };
>> +
>> +...
>> -- 
>> 2.17.1
>>
