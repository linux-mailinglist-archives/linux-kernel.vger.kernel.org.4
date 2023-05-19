Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090EA7091F0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 10:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjESIrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 04:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjESIrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 04:47:06 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCEFEE;
        Fri, 19 May 2023 01:47:05 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34J8Ajb0025742;
        Fri, 19 May 2023 08:46:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=nUUBkTxt0InmoI/nYitrInoeUNfxgxO33Sr7K/UDt0I=;
 b=DQZC4/iNAQpeO8Bzf94IQG2bfNMhsn/uqFBPDOCXVfSqZQaHRq+BXMgHM/0eogWWXumI
 zkZsWL54jOtjlNAPqVMu+QTLDV50IK+uBdhL3lYsKWbJ9xW8p5BAVcyVI8rM0QppVw4s
 lKtbSame3/AN3QvwkkugOReefKuOgSUcfnoqG6VdB4whLrtVqYyjzFwEAjtSw2D+/qe/
 /zLx04OofkRqam1M1rv5VPM6Ztiy7NzZoAJWdyq2XGglasRhDdfwtNfztaGt/UlRSTrt
 zLrJHrbYT1Hlu3h3hxCKJvWy3luASqBhNVYGByVFjdTXAuk6WSpfzd1eXvV0XevZQpNW lQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qnbxqkba1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 08:46:59 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34J8kwgb004719
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 08:46:58 GMT
Received: from [10.216.41.71] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 19 May
 2023 01:46:49 -0700
Message-ID: <5a1ad8f6-73fd-1daf-f4a0-ad6fc2f1b64c@quicinc.com>
Date:   Fri, 19 May 2023 14:16:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 01/11] dt-bindings: remoteproc: qcom: Add support for
 multipd model
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <jassisinghbrar@gmail.com>, <mathieu.poirier@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <quic_gurus@quicinc.com>, <loic.poulain@linaro.org>,
        <quic_eberman@quicinc.com>, <robimarko@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <quic_srichara@quicinc.com>,
        <quic_gokulsri@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_poovendh@quicinc.com>
References: <1678164097-13247-1-git-send-email-quic_mmanikan@quicinc.com>
 <1678164097-13247-2-git-send-email-quic_mmanikan@quicinc.com>
 <20230307142614.GA2742-robh@kernel.org>
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <20230307142614.GA2742-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: yuHYXKna3j1FRYxuWnhsYW2Z1yJd_rss
X-Proofpoint-GUID: yuHYXKna3j1FRYxuWnhsYW2Z1yJd_rss
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_05,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxscore=0 bulkscore=0 adultscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305190073
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/7/2023 7:56 PM, Rob Herring wrote:
> On Tue, Mar 07, 2023 at 10:11:27AM +0530, Manikanta Mylavarapu wrote:
>> Add new binding document for multipd model remoteproc.
>> IPQ5018, IPQ9574 follows multipd model.
>>
>> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
>> ---
>>   .../bindings/remoteproc/qcom,multipd-pil.yaml | 282 ++++++++++++++++++
>>   1 file changed, 282 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,multipd-pil.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,multipd-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,multipd-pil.yaml
>> new file mode 100644
>> index 000000000000..b788607f5abd
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,multipd-pil.yaml
>> @@ -0,0 +1,282 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
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
>> +  remoteproc's on the Qualcomm IPQ5018, IPQ9574 SoC.
> 
> What is PD? I don't see it defined anywhere.
> 
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,ipq5018-q6-mpd
>> +      - qcom,ipq9574-q6-mpd
>> +
>> +  '#address-cells': true
> 
> Need to define the size.
> 
>> +
>> +  '#size-cells': true
> 
> ditto
> 
>> +
>> +  'ranges': true
> 
> Don't need quotes
> 
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts-extended:
> 
> Just 'interrupts'. Both forms are always supported.
> 
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
>> +  clocks:
>> +    minItems: 25
>> +    maxItems: 25
> 
> You need to list out what the clocks are.
> 
>> +
>> +  clock-names:
>> +    minItems: 25
>> +    maxItems: 25
>> +
>> +  assigned-clocks:
> 
> You can drop this. Implicitly supported.
> 
>> +    minItems: 13
>> +    maxItems: 13
>> +
>> +  assigned-clock-rates:
>> +    minItems: 13
>> +    maxItems: 13
>> +
>> +  qcom,smem-states:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> 
> I believe this already has a type. It should be defined in a common
> schema if not already and then included in this schema.
> 
It's not defined in common schema, so i included here.

Thanks & Regards,
Manikanta.
>> +    description: States used by the AP to signal the remoteprocessor
>> +    items:
>> +      - description: Shutdown Q6
>> +      - description: Stop Q6
>> +
>> +  qcom,smem-state-names:
>> +    description:
>> +      Names of the states used by the AP to signal the remoteprocessor
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
>> +  "^remoteproc_pd1|remoteproc_pd2|remoteproc_pd3":
>> +    type: object
>> +    description:
>> +      In Multipd model, WCSS pd depends on Q6 pd i.e Q6 pd should be up before
>> +      WCSS. It can be achieved by keeping wcss pd node as subnode of Q6
>> +      device node.
>> +
>> +    properties:
>> +      compatible:
>> +        enum:
>> +          - "qcom,ipq5018-wcss-ahb-mpd"
> 
> Don't need quotes.
> 
>> +          - "qcom,ipq9574-wcss-ahb-mpd"
>> +          - "qcom,ipq5018-wcss-pcie-mpd"
>> +
>> +      interrupts-extended:
> 
> Just interrupts
> 
>> +        items:
>> +          - description: Fatal interrupt
>> +          - description: Ready interrupt
>> +          - description: Spawn acknowledge interrupt
>> +          - description: Stop acknowledge interrupt
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
>> +        description: States used by the AP to signal the remoteprocessor
>> +        items:
>> +          - description: Shutdown WCSS pd
>> +          - description: Stop WCSS pd
>> +          - description: Spawn WCSS pd
>> +
>> +      qcom,smem-state-names:
>> +        description:
>> +          Names of the states used by the AP to signal the remoteprocessor
>> +        items:
>> +          - const: shutdown
>> +          - const: stop
>> +          - const: spawn
>> +
>> +    required:
>> +      - compatible
>> +
>> +    additionalProperties: false
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts-extended
>> +  - interrupt-names
>> +  - qcom,smem-states
>> +  - qcom,smem-state-names
>> +  - memory-region
>> +
>> +additionalProperties: false
>> +
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          enum:
>> +            - qcom,ipq9574-q6-mpd
>> +    then:
>> +      properties:
>> +        assigned-clocks:
> 
> Don't need to define assigned-clocks
> 
>> +          items:
>> +            - description: Phandle, clock specifier of GCC_ANOC_WCSS_AXI_M_CLK
>> +            - description: Phandle, clock specifier of GCC_WCSS_AHB_S_CLK
>> +            - description: Phandle, clock specifier of GCC_WCSS_ECAHB_CLK
>> +            - description: Phandle, clock specifier of GCC_WCSS_ACMT_CLK
>> +            - description: Phandle, clock specifier of GCC_WCSS_AXI_M_CLK
>> +            - description: Phandle, clock specifier of GCC_Q6_AXIM_CLK
>> +            - description: Phandle, clock specifier of GCC_Q6_AXIM2_CLK
>> +            - description: Phandle, clock specifier of GCC_Q6_AHB_CLK
>> +            - description: Phandle, clock specifier of GCC_Q6_AHB_S_CLK
>> +            - description: Phandle, clock specifier of GCC_Q6SS_BOOT_CLK
>> +            - description: Phandle, clock specifier of GCC_MEM_NOC_Q6_AXI_CLK
>> +            - description: Phandle, clock specifier of GCC_WCSS_Q6_TBU_CLK
>> +            - description: Phandle, clock specifier of GCC_SYS_NOC_WCSS_AHB_CLK
>> +        assigned-clock-rates:
>> +          items:
>> +            - description: Must be 266666667 HZ
>> +            - description: Must be 133333333 HZ
>> +            - description: Must be 133333333 HZ
>> +            - description: Must be 133333333 HZ
>> +            - description: Must be 266666667 HZ
>> +            - description: Must be 533000000 HZ
>> +            - description: Must be 342857143 HZ
>> +            - description: Must be 133333333 HZ
>> +            - description: Must be 133333333 HZ
>> +            - description: Must be 342857143 HZ
>> +            - description: Must be 533000000 HZ
>> +            - description: Must be 533000000 HZ
>> +            - description: Must be 133333333 HZ
>> +
>> +examples:
>> +  - |
>> +        #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +        #include <dt-bindings/clock/qcom,gcc-ipq5018.h>
>> +        #include <dt-bindings/reset/qcom,gcc-ipq5018.h>
>> +
>> +        q6v5_wcss: remoteproc@cd00000 {
>> +                compatible = "qcom,ipq5018-q6-mpd";
>> +                #address-cells = <1>;
>> +                #size-cells = <1>;
>> +                ranges;
>> +                reg = <0x0cd00000 0x4040>;
>> +                interrupts-extended = <&intc GIC_SPI 291 IRQ_TYPE_EDGE_RISING>,
>> +                                <&wcss_smp2p_in 0 0>,
>> +                                <&wcss_smp2p_in 1 0>,
>> +                                <&wcss_smp2p_in 2 0>,
>> +                                <&wcss_smp2p_in 3 0>;
>> +                interrupt-names = "wdog",
>> +                                  "fatal",
>> +                                  "ready",
>> +                                  "handover",
>> +                                  "stop-ack";
>> +
>> +                qcom,smem-states = <&wcss_smp2p_out 0>,
>> +                                   <&wcss_smp2p_out 1>;
>> +                qcom,smem-state-names = "shutdown",
>> +                                        "stop";
>> +
>> +                memory-region = <&q6_region>;
>> +
>> +                glink-edge {
>> +                        interrupts = <GIC_SPI 179 IRQ_TYPE_EDGE_RISING>;
>> +                        label = "rtr";
>> +                        qcom,remote-pid = <1>;
>> +                        mboxes = <&apcs_glb 8>;
>> +                };
>> +
>> +                q6_wcss_pd1: remoteproc_pd1 {
>> +                        compatible = "qcom,ipq5018-wcss-ahb-mpd";
>> +                        interrupts-extended = <&wcss_smp2p_in 8 0>,
>> +                                        <&wcss_smp2p_in 9 0>,
>> +                                        <&wcss_smp2p_in 12 0>,
>> +                                        <&wcss_smp2p_in 11 0>;
>> +                        interrupt-names = "fatal",
>> +                                          "ready",
>> +                                          "spawn-ack",
>> +                                          "stop-ack";
>> +                        qcom,smem-states = <&wcss_smp2p_out 8>,
>> +                                           <&wcss_smp2p_out 9>,
>> +                                           <&wcss_smp2p_out 10>;
>> +                        qcom,smem-state-names = "shutdown",
>> +                                                "stop",
>> +                                                "spawn";
>> +                };
>> +
>> +                q6_wcss_pd2: remoteproc_pd2 {
>> +                        compatible = "qcom,ipq5018-wcss-pcie-mpd";
>> +                        interrupts-extended = <&wcss_smp2p_in 16 0>,
>> +                                        <&wcss_smp2p_in 17 0>,
>> +                                        <&wcss_smp2p_in 20 0>,
>> +                                        <&wcss_smp2p_in 19 0>;
>> +                        interrupt-names = "fatal",
>> +                                          "ready",
>> +                                          "spawn-ack",
>> +                                          "stop-ack";
>> +
>> +                        qcom,smem-states = <&wcss_smp2p_out 16>,
>> +                                           <&wcss_smp2p_out 17>,
>> +                                           <&wcss_smp2p_out 18>;
>> +                        qcom,smem-state-names = "shutdown",
>> +                                                "stop",
>> +                                                "spawn";
>> +                        status = "okay";
> 
> Don't need status in examples.
> 
>> +                };
>> +
>> +                q6_wcss_pd3: remoteproc_pd3 {
>> +                        compatible = "qcom,ipq5018-wcss-pcie-mpd";
>> +                        interrupts-extended = <&wcss_smp2p_in 24 0>,
>> +                                        <&wcss_smp2p_in 25 0>,
>> +                                        <&wcss_smp2p_in 28 0>,
>> +                                        <&wcss_smp2p_in 27 0>;
>> +                        interrupt-names = "fatal",
>> +                                          "ready",
>> +                                          "spawn-ack",
>> +                                          "stop-ack";
>> +
>> +                        qcom,smem-states = <&wcss_smp2p_out 24>,
>> +                                           <&wcss_smp2p_out 25>,
>> +                                           <&wcss_smp2p_out 26>;
>> +                        qcom,smem-state-names = "shutdown",
>> +                                                "stop",
>> +                                                "spawn";
>> +                        status = "okay";
>> +                };
>> +        };
>> -- 
>> 2.34.1
>>
