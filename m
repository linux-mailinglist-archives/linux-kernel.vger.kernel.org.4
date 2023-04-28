Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAA56F1222
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 09:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345280AbjD1HLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 03:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjD1HLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 03:11:06 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4671FC6;
        Fri, 28 Apr 2023 00:11:02 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33S6eC60017888;
        Fri, 28 Apr 2023 07:09:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=r4S9H1vwWoK1+kiA09br/m7C1/tdA0ux38+UdY8IJC8=;
 b=TRgDOuAiuEa7voWD8LojLP65cAU+eYPwSaHvdK8MyLjAWhoKHKVjVex0r8j+e6P6NBP8
 A3ckaa63DGxZrxEQVe3dsuVAhpsUloRGI5SvHgnx8yFZmzJgN9JispzTuwEIZFSG1Vi2
 5eIYT+CBb95fCbyHFrCyZcxT6Nhko+nw/AS1oj3l0mspDNjiOFGxAkWmGEPsIdR8Bprw
 N54eM/U5n29mxQAbexncaXDiPBO0Kd+FuelWQqrnCKhZwTs5hsoSyuWdcLAPSGerrxp/
 g/RiwBtmVgjjuH43HPbJSqUpUYM6Hcv4KQRXVilx6YLej+qiYdW9tMR/2JgRTD1LRNt/ Ow== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q7wq89b8t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 07:09:52 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33S79pGx032698
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 07:09:51 GMT
Received: from [10.253.9.121] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 28 Apr
 2023 00:09:45 -0700
Message-ID: <336ce7b0-45f6-85e1-14a3-9e8c94a2f6fd@quicinc.com>
Date:   Fri, 28 Apr 2023 15:09:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 2/3] dt-bindings: arm: Add Coresight Dummy Trace
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
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
References: <20230422073714.38844-1-quic_hazha@quicinc.com>
 <20230422073714.38844-3-quic_hazha@quicinc.com>
 <20230425184654.GA2063541-robh@kernel.org>
From:   Hao Zhang <quic_hazha@quicinc.com>
In-Reply-To: <20230425184654.GA2063541-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: iS1NqngkcR_LxwoJA8zQZjsldTzjbUq6
X-Proofpoint-ORIG-GUID: iS1NqngkcR_LxwoJA8zQZjsldTzjbUq6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-28_02,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=935
 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304280057
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 4/26/2023 2:46 AM, Rob Herring wrote:
> On Sat, Apr 22, 2023 at 03:37:13PM +0800, Hao Zhang wrote:
>> Add new coresight-dummy.yaml file describing the bindings required
>> to define coresight dummy trace in the device trees.
>>
>> Signed-off-by: Hao Zhang <quic_hazha@quicinc.com>
>> ---
>>   .../bindings/arm/arm,coresight-dummy.yaml     | 101 ++++++++++++++++++
>>   1 file changed, 101 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-dummy.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-dummy.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-dummy.yaml
>> new file mode 100644
>> index 000000000000..48d864aefaaa
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/arm,coresight-dummy.yaml
>> @@ -0,0 +1,101 @@
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
> 
> I could imagine the OS wanting to know more information than just
> 'dummy'. Is data from an unknown source useful? Likewise, don't you want
> to know where you are sending data too?
> 
The necessary information for Coresight is connection between different 
components, so there is in-port for dummy sink and out-port for dummy 
source. We can get the whole path from the source to sink in device tree.

>> +
>> +maintainers:
>> +  - Mao Jinlong <quic_jinlmao@quicinc.com>
>> +  - Tao Zhang <quic_taozha@quicinc.com>
>> +  - Hao Zhang <quic_hazha@quicinc.com>
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - enum:
> 
> Don't need oneOf as there is only one entry.
> 
OK, I will remove it in the next version of patch.
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
> This still allows the nodes when they don't make sense. I think this
> needs to be 2 schema files. The only common part is 'compatible' and
> that's not even shared.
>  > Rob
Dummy driver is very simple, the only goal of it is to build a path in 
kernel for subsystem, so we want to handle dummy source and sink in a 
generic framework.

Thanks,
Hao
