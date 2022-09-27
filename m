Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92F45EC44C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 15:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbiI0NWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 09:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbiI0NU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:20:29 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4067D1B0523;
        Tue, 27 Sep 2022 06:18:25 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28RCJ4IE027643;
        Tue, 27 Sep 2022 13:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=2ugG1wqh0mcPHt0D5iUYUmWqFQHrAwQwMveAg8lQ6Yo=;
 b=enucRki3c+6aYJ82BUUbw8RiYAea7BGk2yp5c6Fmy5ZVofe9QEoiOY9hMJVyYqd3r1UJ
 lbxjIJK86jlhmrLg2trf+CANfVb7fHNDvMPiOuohzbo5T+bGUfbacV4qT7xeOhQzLPe3
 ezCPrWhFuL+BAY8Q/dH0YrYkiDPT/xf8P+qvu1mxuSXnVvj8OjIoSoF2cCn9wqc1pWLg
 bh3jZJ44yYxmgphtqs++H5vEt48A5k8RiZv10i1aYJAnwcljADfq7oPqTTV5LERHkZYS
 oxRCn4qzumJK/9doMo1hZbtnri9y2bnmUrdMnernPQJG/Hx/myYDYO1l+fs3Gdf0vJ+5 4A== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3juw51gsnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 13:17:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28RDHdS0031144
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 13:17:39 GMT
Received: from [10.216.22.231] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 27 Sep
 2022 06:17:34 -0700
Message-ID: <de6dd293-b6c8-afd9-f93b-46a70c2f01ef@quicinc.com>
Date:   Tue, 27 Sep 2022 18:47:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 1/7] dt-bindings: remoteproc: qcom: Add SC7280 ADSP
 support
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, <devicetree@vger.kernel.org>
References: <1663938340-24345-1-git-send-email-quic_srivasam@quicinc.com>
 <1663938340-24345-2-git-send-email-quic_srivasam@quicinc.com>
 <7d001153-e1f2-7ae6-2821-4b3547ccf034@linaro.org>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <7d001153-e1f2-7ae6-2821-4b3547ccf034@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: O9ChhlkF6bRIFxfImIymolDJnp4oyvqp
X-Proofpoint-GUID: O9ChhlkF6bRIFxfImIymolDJnp4oyvqp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-27_05,2022-09-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 phishscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2209270081
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/23/2022 10:53 PM, Krzysztof Kozlowski wrote:
Thanks for Your time Krzyszto!!!
> On 23/09/2022 15:05, Srinivasa Rao Mandadapu wrote:
>> Add ADSP PIL loading support for SC7280 SoCs.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
>> ---
>> Changes since V7:
>> 	-- Remove redundant clocks in dt bindings.
>> 	-- Fix dt compilation error in dt bindings.
>> Changes since V6:
>> 	-- Update glink-edge property.
>> 	-- Add qcom,qmp property.
>> Changes since V5:
>> 	-- Remove qcom,adsp-memory-regions property.
>> Changes since V4:
>> 	-- Update halt registers description in dt bindings.
>>
>>   .../bindings/remoteproc/qcom,sc7280-adsp-pil.yaml  | 207 +++++++++++++++++++++
>>   1 file changed, 207 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml
>> new file mode 100644
>> index 0000000..79ef3c0
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml
>> @@ -0,0 +1,207 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/remoteproc/qcom,sc7280-adsp-pil.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm SC7280 ADSP Peripheral Image Loader
>> +
>> +maintainers:
>> +  - Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> +
>> +description:
>> +  This document describes the hardware for a component that loads and boots firmware
>> +  on the Qualcomm Technology Inc. ADSP.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,sc7280-adsp-pil
>> +
>> +  reg:
>> +    minItems: 1
>> +    items:
>> +      - description: qdsp6ss register
>> +      - description: efuse q6ss register
> Why second IO address space is optional?
Yeah, both are required for SC7280. will remove minItems.
>
>> +
>> +  interrupts:
>> +    items:
>> +      - description: Watchdog interrupt
>> +      - description: Fatal interrupt
>> +      - description: Ready interrupt
>> +      - description: Handover interrupt
>> +      - description: Stop acknowledge interrupt
>> +      - description: Shutdown acknowledge interrupt
>> +
>> +  interrupt-names:
>> +    items:
>> +      - const: wdog
>> +      - const: fatal
>> +      - const: ready
>> +      - const: handover
>> +      - const: stop-ack
>> +      - const: shutdown-ack
>> +
>> +  clocks:
>> +    items:
>> +      - description: XO clock
>> +      - description: GCC CFG NOC LPASS clock
>> +
>> +  clock-names:
>> +    items:
>> +      - const: xo
>> +      - const: gcc_cfg_noc_lpass
>> +
>> +  power-domains:
>> +    items:
>> +      - description: LCX power domain
>> +
>> +  resets:
>> +    items:
>> +      - description: PDC AUDIO SYNC RESET
>> +      - description: CC LPASS restart
>> +
>> +  reset-names:
>> +    items:
>> +      - const: pdc_sync
>> +      - const: cc_lpass
>> +
>> +  memory-region:
>> +    maxItems: 1
>> +    description: Reference to the reserved-memory for the Hexagon core
>> +
>> +  qcom,halt-regs:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    description:
>> +      Phandle reference to a syscon representing TCSR followed by the
>> +      four offsets within syscon for q6, CE, AXI and qv6 halt registers.
>> +    items:
>> +      items:
> This has to be strictly defined, IOW, the second items must be already
> an item of previous list. Look at the other mss-pil.
Okay. Will modify as per mss-pil.
>
>> +        - description: phandle to TCSR MUTEX
>> +        - description: offset to q6 halt registers
>> +        - description: offset to CE halt registers
>> +        - description: offset to AXI halt registers
>> +        - description: offset to qv6 halt registers
>> +
>> +  qcom,smem-states:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    description: States used by the AP to signal the Hexagon core
>> +    items:
>> +      - description: Stop the modem
>> +
>> +  qcom,smem-state-names:
>> +    description: The names of the state bits used for SMP2P output
>> +    const: stop
>> +
>> +  qcom,qmp:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description: Reference to the AOSS side-channel message RAM.
>> +
>> +  glink-edge:
>> +    type: object
> Missing ref to glink-edge and unevaluatedProperties:false. Please take a
> look at recent
> Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml
Okay. Will add reference to glink-edge.
>
>> +    description: |
>> +      Qualcomm G-Link subnode which represents communication edge, channels
>> +      and devices related to the ADSP.
>> +
>> +    properties:
>> +      interrupts:
>> +        items:
>> +          - description: IRQ from ADSP to GLINK
> Skip interrupts and mboxes - both are coming from glink-edge.
Okay. Will remove it. But Same is followed in mss-pil
>
>> +
>> +      mboxes:
>> +        items:
>> +          - description: Mailbox for communication between APPS and ADSP
>> +
>> +      label:
>> +        description: The names of the state bits used for SMP2P output
> Skip description
Okay.
>
>> +        items:
>> +          - const: lpass
> No items, just const: lpass
Okay.
>
>> +
>> +      qcom,remote-pid:
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        description: ID of the shared memory used by GLINK for communication with ADSP
> This can be dropped.
Okay. Will remove qcom,remote-pid.
>
>> +
>> +      gpr: true
>> +      apr: false
>> +      fastrpc: false
>
> BTW, all these three do not make sense without ref to glink-edge. After
> adding ref, these seem reasonable.
Okay. will add glink-edge reference.
>
>> +
>> +    required:
>> +      - interrupts
>> +      - mboxes
>> +      - label
>> +      - qcom,remote-pid
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - interrupt-names
>> +  - clocks
>> +  - clock-names
>> +  - power-domains
>> +  - resets
>> +  - reset-names
>> +  - qcom,halt-regs
>> +  - memory-region
>> +  - qcom,smem-states
>> +  - qcom,smem-state-names
>> +  - qcom,qmp
>> +
>> +additionalProperties: false
> Best regards,
> Krzysztof
>
