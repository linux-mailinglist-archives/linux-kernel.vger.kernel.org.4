Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857337023F5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 07:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238677AbjEOF6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 01:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238619AbjEOF5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 01:57:48 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CA14C34;
        Sun, 14 May 2023 22:53:10 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34F4sCiS017139;
        Mon, 15 May 2023 05:52:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=EdoGL5c+TynhSxWSMv8UyHdglT4pqpHiJ4IPVScGgkc=;
 b=Gm9MjpjfHlY3H+e5uKhfBxhPADlPnjLl/cimWmV+hKIuv1X5haGNTxiJxK3tSIV0VtMm
 KRk+FcB5qg8L64SY3SKyJJjKASE1arzlk8BDoj2EgVyXhlv73LerfxfHJcl3hz2rRAq/
 WLtDp4REwZ+LmEP1rNewr5xOaTbWOvhg5+xAwDdjlT0BZ2NL4wHnVhtX6ejOtF7d3YC+
 z5IriQDk4qHukR5exsFYbEONwIZYJ6HeGnHdrWUUNyTeMPE1YLXjBSNBMRY6DkZEp0GK
 bWvTSEvWG6IxlIFyd+qIiKbKavO7TBSSgCJTjgKuAiL1kle0TwT2N5A1KmYmggFzw5oc fg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qj1jf2vnw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 05:52:51 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34F5qooE020097
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 05:52:50 GMT
Received: from [10.233.17.245] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Sun, 14 May
 2023 22:52:44 -0700
Message-ID: <44524ce9-b24e-7e2d-819c-232149e29f0e@quicinc.com>
Date:   Mon, 15 May 2023 13:52:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 2/3] dt-bindings: arm: Add Coresight Dummy Trace
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Konrad Dybcio <konradybcio@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
References: <20230505092422.32217-1-quic_hazha@quicinc.com>
 <20230505092422.32217-3-quic_hazha@quicinc.com>
 <99343862-6b6a-30ba-40e5-7f984434b1dc@linaro.org>
Content-Language: en-US
From:   Hao Zhang <quic_hazha@quicinc.com>
In-Reply-To: <99343862-6b6a-30ba-40e5-7f984434b1dc@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fskWVE785-CXPTau5EtV_gWSbtYpjo_Y
X-Proofpoint-ORIG-GUID: fskWVE785-CXPTau5EtV_gWSbtYpjo_Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_02,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 clxscore=1011 impostorscore=0 suspectscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305150051
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/7/2023 4:04 PM, Krzysztof Kozlowski wrote:
> On 05/05/2023 11:24, Hao Zhang wrote:
>> Add new coresight-dummy.yaml file describing the bindings required
>> to define coresight dummy trace in the device trees.
>>
>> Signed-off-by: Hao Zhang <quic_hazha@quicinc.com>
>> ---
>>   .../bindings/arm/arm,coresight-dummy.yaml     | 102 ++++++++++++++++++
>>   1 file changed, 102 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-dummy.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-dummy.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-dummy.yaml
>> new file mode 100644
>> index 000000000000..126518863eea
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/arm,coresight-dummy.yaml
>> @@ -0,0 +1,102 @@
>> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/arm/arm,coresight-dummy.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: ARM Coresight Dummy component
>> +
>> +description: |
>> +  Coresight Dummy Trace Module is for the specific devices that kernel
>> +  don't have permission to access or configure, e.g., CoreSight TPDMs
>> +  on Qualcomm platforms. So there need driver to register dummy devices
>> +  as Coresight devices. It may also be used to define components that
>> +  may not have any programming interfaces (e.g, static links), so that
>> +  paths can be established in the driver. Provide Coresight API for
>> +  dummy device operations, such as enabling and disabling dummy devices.
>> +  Build the Coresight path for dummy sink or dummy source for debugging.
>> +
>> +  The primary use case of the coresight dummy is to build path in kernel
>> +  side for dummy sink and dummy source.
>> +
>> +maintainers:
>> +  - Mao Jinlong <quic_jinlmao@quicinc.com>
>> +  - Tao Zhang <quic_taozha@quicinc.com>
>> +  - Hao Zhang <quic_hazha@quicinc.com>
>> +  - Yuanfang Zhang <quic_yuanfang@quicinc.com>
>> +
>> +properties:
>> +  compatible:
>> +    items:
> 
> You were asked to drop oneOf, not to replace with items. Drop items.
> Drop oneOf. It's just enum.
> 

Hi Krzysztof,

I will drop items and update it in the next version.

Thanks,
Hao

>> +      - enum:
>> +          - arm,coresight-dummy-sink
>> +          - arm,coresight-dummy-source
>> +
>> +  out-ports:
>> +    $ref: /schemas/graph.yaml#/properties/ports
>> +
>> +    properties:
>> +      port:
>> +        description: Output connection from the source to Coresight
>> +          Trace bus.
>> +        $ref: /schemas/graph.yaml#/properties/port
>> +
>> +  in-ports:
>> +    $ref: /schemas/graph.yaml#/properties/ports
>> +
>> +    properties:
>> +      port:
>> +        description: Input connection from the Coresight Trace bus to
>> +          dummy sink, such as Embedded USB debugger(EUD).
>> +        $ref: /schemas/graph.yaml#/properties/port
>> +
>> +required:
>> +  - compatible
>> +
>> +if:
>> +  # If the compatible contains the below value
>> +  properties:
>> +    compatible:
>> +      contains:
>> +        const: arm,coresight-dummy-sink
>> +
>> +then:
>> +  required:
>> +    - in-ports
>> +
>> +else:
>> +  required:
>> +    - out-ports
> 
> No improvements. Implement Rob's comments.
> 

Hi Krzysztof, Rob,

There are two comments from Rob:
1) I could imagine the OS wanting to know more information than just
'dummy'. Is data from an unknown source useful? Likewise, don't you want
to know where you are sending data too?
2) This still allows the nodes when they don't make sense. I think this
needs to be 2 schema files. The only common part is 'compatible' and
that's not even shared.


1. The necessary information for coresight is connection(ports) between 
different components. However, this information is not very intuitive. 
There would be a generic change to support coresight name in the 
further. You can refer to the below link, this solution is still under 
discussion, I think it's also helpful for our query.
https://lore.kernel.org/linux-arm-kernel/b7abee2a-99ca-26d6-5850-60ee19d9c0e9@quicinc.com/T/

2. Dummy driver is very simple, the only goal of it is to build a path 
in kernel for subsystem, so we want to handle dummy source and sink in 
one generic driver. For one same driver, shall we split the schema file?

Please feel free to comment.

Thanks,
Hao

> Best regards,
> Krzysztof
> 
