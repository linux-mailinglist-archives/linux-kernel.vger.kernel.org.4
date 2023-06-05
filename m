Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02DB672252C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 14:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbjFEMDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 08:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbjFEMC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 08:02:59 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FFBDF;
        Mon,  5 Jun 2023 05:02:56 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3559jTUm026134;
        Mon, 5 Jun 2023 12:02:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=mZfe5FQcWlb56RoDNN21ZxDbACheFBsa3VFQ5v1lJGI=;
 b=ML7Nwctr07aio08VMf895YZunB0LAQ3Q3Av1mAEIBKEk5Cdu1zb3TCwyaGCbEJMUWlb+
 NsjopXadHw3jXv0O85YDFG5U6NKKrtYdrg67iNyyMXtJJ/RQYLsnQTPcazMvrxpNXacj
 fWML1mqMpfZEm17uOIqv9KTBcbV+z9y/6QCt87rYCejI5SahXJfYYYh+cMvXNEFM4bpT
 V1YOCf+jtYIwy/yL0LXxUBxRIj81+Gdd+0broaKYtzGJmBoHySj6/8iDkB8u+0tct2gm
 6sUawhioYSiwFNc06OlodCyA6DPSonmHmD1uPHOn5CZfXhr5vzzYldUBBV5hEXGrsCfB iQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r1db987hk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jun 2023 12:02:47 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 355C2lTx001132
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 5 Jun 2023 12:02:47 GMT
Received: from [10.201.206.238] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 5 Jun 2023
 05:02:38 -0700
Message-ID: <a1456f62-d0a7-d5ec-b379-db1b6035c89c@quicinc.com>
Date:   Mon, 5 Jun 2023 17:32:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH V2 01/13] dt-bindings: remoteproc: qcom: Add support for
 multipd model
Content-Language: en-US
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
 <20230521222852.5740-2-quic_mmanikan@quicinc.com>
 <7940c743-815f-f864-d015-43d7e916ecfa@linaro.org>
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <7940c743-815f-f864-d015-43d7e916ecfa@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rbhJyJ0Pjesy9dcOPEJ1HkcCGd3_V5gN
X-Proofpoint-GUID: rbhJyJ0Pjesy9dcOPEJ1HkcCGd3_V5gN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-03_08,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 phishscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306050107
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/30/2023 4:28 PM, Krzysztof Kozlowski wrote:
> On 22/05/2023 00:28, Manikanta Mylavarapu wrote:
>> Add new binding document for multipd model remoteproc.
>> IPQ5018, IPQ9574 follows multipd model.
>>
>> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
>> ---
>> Changes in V2:
>> 	- Fixed all comments and rebased for TOT.
>> 	- Changed to BSD-3-Clause based on internal open source team
>>            suggestion.
>> 	- Added firmware-name.
>>
>>   .../bindings/remoteproc/qcom,multipd-pil.yaml | 265 ++++++++++++++++++
>>   1 file changed, 265 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,multipd-pil.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,multipd-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,multipd-pil.yaml
>> new file mode 100644
>> index 000000000000..3257f27dc569
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,multipd-pil.yaml
>> @@ -0,0 +1,265 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/remoteproc/qcom,multipd-pil.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Multipd Secure Peripheral Image Loader
>> +
>> +maintainers:
>> +  - Bjorn Andersson <andersson@kernel.org>
>> +  - Mathieu Poirier <mathieu.poirier@linaro.org>
>> +
>> +description:
>> +  Multipd Peripheral Image Loader loads firmware and boots Q6 pd, WCSS pd
> 
> ... boots Q6 Protection Domain (PD), WCSS PD ...
> 
>> +  remoteproc's on the Qualcomm IPQ5018, IPQ9574 SoC.
> 
>> Pd means protection
>> +  domain.
> 
> so you can skip this sentence as it is explained already.
> 
>> It's similar to process in Linux. Here QDSP6 processor runs each
>> +  wifi radio functionality on a separate process. One process can't access
>> +  other process resources, so this is termed as PD i.e protection domain.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,ipq5018-q6-mpd
>> +      - qcom,ipq9574-q6-mpd
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  firmware-name:
>> +    $ref: /schemas/types.yaml#/definitions/string-array
>> +    description: Firmware name of the Hexagon core
> 
> No need for ref and description. Instead maxItems.
> 
>> +
>> +  interrupts-extended:
>> +    items:
>> +      - description: Watchdog interrupt
>> +      - description: Fatal interrupt
>> +      - description: Ready interrupt
>> +      - description: Handover interrupt
>> +      - description: Stop acknowledge interrupt
>> +
>> +  interrupt-names:
>> +    items:
>> +      - const: wdog
>> +      - const: fatal
>> +      - const: ready
>> +      - const: handover
>> +      - const: stop-ack
>> +
>> +  qcom,smem-states:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    description: States used by the AP to signal the remote processor
>> +    items:
>> +      - description: Shutdown Q6
>> +      - description: Stop Q6
>> +
>> +  qcom,smem-state-names:
>> +    description:
>> +      Names of the states used by the AP to signal the remote processor
>> +    items:
>> +      - const: shutdown
>> +      - const: stop
>> +
>> +  memory-region:
>> +    items:
>> +      - description: Q6 pd reserved region
>> +
>> +  glink-edge:
>> +    $ref: /schemas/remoteproc/qcom,glink-edge.yaml#
>> +    description:
>> +      Qualcomm G-Link subnode which represents communication edge, channels
>> +      and devices related to the Modem.
>> +
>> +patternProperties:
>> +  "^pd-1|pd-2|pd-3":
>> +    type: object
>> +    description:
>> +      In Multipd model, WCSS pd depends on Q6 pd i.e Q6 pd should be up before
>> +      WCSS. It can be achieved by keeping wcss pd node as subnode of Q6
>> +      device node.
> 
> That's not enough. Your description does not say what is this, why you
> have two protection domains for same compatible. What's more, it a bit
> deviates from hardware description.
>
WCSS means 'wireless connectivity sub system', in simple words it's a
wifi radio block.

IPQ5018 SOC has both internal (AHB) wifi radio/WCSS and external (PCIE)
wifi radio/WCSS. In Q6, Root protection domain will provide services to
both internal (AHB) and external (PCIE) wifi radio's protection domain.
So we have two protection domains for IPQ5018, one is for internal(AHB) 
and other is for external(PCIE) wifi radio.

>> +
>> +    properties:
>> +      compatible:
>> +        enum:
>> +          - qcom,ipq5018-wcss-ahb-mpd
>> +          - qcom,ipq9574-wcss-ahb-mpd
>> +          - qcom,ipq5018-wcss-pcie-mpd
> 
> Keep rather alphabetical order (so both 5018 together).
> 
> I also do not understand these at all. Why adding bus type to
> compatible? This rarely is allowed (unless it is PCIe controller within
> soc).
> 
IPQ5018 SOC has in-built PCIE controller. Here QDSP6 will bring up
external(PCIE) and internal (AHB) wifi radio's. To separate AHB, PCIE 
radio's properties, i have added bus type to compatible.

>> +
>> +      firmware-name:
>> +        $ref: /schemas/types.yaml#/definitions/string-array
>> +        items:
>> +          - description: Firmware name of the Hexagon core
> 
> same comments
> 
>> +
>> +      interrupts-extended:
>> +        items:
>> +          - description: Fatal interrupt
>> +          - description: Ready interrupt
>> +          - description: Spawn acknowledge interrupt
>> +          - description: Stop acknowledge interrupt
> 
> ditto
> 
>> +
>> +      interrupt-names:
>> +        items:
>> +          - const: fatal
>> +          - const: ready
>> +          - const: spawn-ack
>> +          - const: stop-ack
>> +
>> +      qcom,smem-states:
>> +        $ref: /schemas/types.yaml#/definitions/phandle-array
>> +        description: States used by the AP to signal the remote processor
>> +        items:
>> +          - description: Shutdown WCSS pd
>> +          - description: Stop WCSS pd
>> +          - description: Spawn WCSS pd
>> +
>> +      qcom,smem-state-names:
>> +        description:
>> +          Names of the states used by the AP to signal the remote processor
>> +        items:
>> +          - const: shutdown
>> +          - const: stop
>> +          - const: spawn
>> +
>> +    required:
>> +      - compatible
>> +      - firmware-name
>> +      - interrupts-extended
>> +      - interrupt-names
>> +      - qcom,smem-states
>> +      - qcom,smem-state-names
>> +
>> +    unevaluatedProperties: false
>> +
>> +required:
>> +  - compatible
>> +  - firmware-name
>> +  - reg
>> +  - interrupts-extended
>> +  - interrupt-names
>> +  - qcom,smem-states
>> +  - qcom,smem-state-names
>> +  - memory-region
>> +
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - qcom,ipq5018-q6-mpd
>> +    then:
>> +      properties:
>> +        firmware-name:
>> +          items:
>> +            - const: IPQ5018/q6_fw.mdt
>> +            - const: IPQ5018/m3_fw.mdt
>> +            - const: qcn6122/m3_fw.mdt
> 
> No, names are not part of bindings. Also paths do not look correct. Open
> linux-firmware package and verify these are good...
> 
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - qcom,ipq9574-q6-mpd
>> +    then:
>> +      properties:
>> +        firmware-name:
>> +          items:
>> +            - const: IPQ9574/q6_fw.mdt
>> +            - const: IPQ9574/m3_fw.mdt
> 
> Drop.
> 
>> +
>> +unevaluatedProperties: false
> 
> This changed... why?
> 
> 
'unevaluatedProperties' is similar to 'additionalProperties' except
that it recognize properties declared in subschemas as well.

Thanks & Regards,
Manikanta.

> Best regards,
> Krzysztof
> 
