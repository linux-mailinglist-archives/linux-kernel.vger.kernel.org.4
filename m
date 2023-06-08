Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A26C7280C2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 15:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236280AbjFHNAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 09:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233645AbjFHM7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 08:59:51 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DE01FE9;
        Thu,  8 Jun 2023 05:59:49 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 358CbCVt012832;
        Thu, 8 Jun 2023 12:59:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=f3h8BzpwGazJwyUWGHdCeGvpHlv6O5UncmboEbGhuCM=;
 b=bluh1gT0LGIGdoJKVfsvoqEoGGQFAL6CHxUT3Xn3SjDUMLxFsahXOhOWyVRUQffa0O0R
 TmVK/zZUqVgfAKfH8vHjsYroDvIxxcdruleGP0c680N9RJs3GUMeRV1Xv8lOYV8wjZk9
 PTwOeYocFjURo6Ar57CbgQOpcyefDRt4vDYPBBeHC/5VbOYREmS12D2G52u5uMyT+cvU
 D3stZivBXwu6VaJ7u+RR6N0T8p/GAs2LEMXiZ51vgPykwshcKWA9hNqTLy3U+hxcQNyq
 oB3mJ0AkmMhv6hvxZxl6zhfXbUySzU5jF8c4qKZkVhiiNYgHKtpdIzJP3mwlEvhWizdu bw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r33uyh7mj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 12:59:44 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 358CxH2S019571
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Jun 2023 12:59:17 GMT
Received: from [10.216.21.154] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 8 Jun 2023
 05:59:08 -0700
Message-ID: <b3c4684c-77e4-861b-9196-48a014c49c18@quicinc.com>
Date:   Thu, 8 Jun 2023 18:29:05 +0530
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
X-Proofpoint-GUID: w0B2WFx4cEZNuxXZFDofYTR-Uki5ImYy
X-Proofpoint-ORIG-GUID: w0B2WFx4cEZNuxXZFDofYTR-Uki5ImYy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_09,2023-06-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306080113
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
I will remove names from bindings and use firmware path as per
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/ath11k/IPQ5018/hw1.0

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
I will drop.

Thanks & Regards,
Manikanta.

>> +
>> +unevaluatedProperties: false
> 
> This changed... why?
> 
> 
> Best regards,
> Krzysztof
> 
