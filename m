Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6A06B83CA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 22:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjCMVME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 17:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjCMVLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 17:11:53 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE816702A;
        Mon, 13 Mar 2023 14:11:20 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32DIuwqq022258;
        Mon, 13 Mar 2023 21:11:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=62F7J3FGGZ7335EJ2Bu5TrYRz57B6QhvXXBJxlgtONI=;
 b=H1ER386Aot9/hfnauJ407y1NeicV4Yb0g2SlQcfmqDCl8zC85btZMk35GtPlhuCTaEdb
 LVI8daE6vOxe9sN7C9Ak6K/fLd0xg7bD847bOUKq7+t5DbnwaQ6riIEOE7ls3UZfD3/w
 FDUD2x5gvyEwYV3LVDAQC/RhhDew7rQRFYcGqcXeC8he5mBf+jgRB4ed4NMvSIkXb6mw
 0csZNdbM8YTGX4uO5rH/heNTkWjDFjH95ks43AJ0UTEAXDb7qak0X+WbL/Ok0vKX+5AV
 xo/I7/KdYNrDgaNMun4gLTzJnWNmlxqQ1EQhcHnIecYGPjxylvFlWA7kh9CKUIuh3W4R ow== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pa3ptsagx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 21:11:15 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32DLBEaA025605
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 21:11:14 GMT
Received: from [10.110.77.0] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 13 Mar
 2023 14:11:13 -0700
Message-ID: <5053388b-df74-b0a0-253f-9bf9145d8059@quicinc.com>
Date:   Mon, 13 Mar 2023 14:11:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 3/7] dt-bindings: remoteproc: mpss: Document
 QDU1000/QRU1000 mpss devices
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>
CC:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>
References: <20230306231202.12223-1-quic_molvera@quicinc.com>
 <20230306231202.12223-4-quic_molvera@quicinc.com>
 <ea1c0579-1b37-77de-3c47-e5b9772cff70@linaro.org>
Content-Language: en-US
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <ea1c0579-1b37-77de-3c47-e5b9772cff70@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KYKDEDGvkLTMRe70Y-97mbx_UuDiN980
X-Proofpoint-ORIG-GUID: KYKDEDGvkLTMRe70Y-97mbx_UuDiN980
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_11,2023-03-13_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 clxscore=1015 phishscore=0
 impostorscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303130166
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/9/2023 12:33 AM, Krzysztof Kozlowski wrote:
> On 07/03/2023 00:11, Melody Olvera wrote:
>> This documents the compatible for the component used to boot the
> Do not use "This commit/patch".
> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

Ok.

>
>> MPSS on the QDU1000 and QRU1000 SoCs.
>>
>> The QDU1000 and QRU1000 mpss boot process now requires the specification
>> of an RMB register space to complete the handshake needed to start or
>> attach the mpss.
>>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
>>  .../remoteproc/qcom,qdu1000-mpss-pas.yaml     | 130 ++++++++++++++++++
>>  1 file changed, 130 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,qdu1000-mpss-pas.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,qdu1000-mpss-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,qdu1000-mpss-pas.yaml
>> new file mode 100644
>> index 000000000000..9cb4296c1fa6
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,qdu1000-mpss-pas.yaml
>> @@ -0,0 +1,130 @@
>> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/remoteproc/qcom,qdu1000-mpss-pas.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm QDU1000 Modem Peripheral Authentication Service
>> +
>> +maintainers:
>> +  - Melody Olvera <quic_molvera@quicinc.com>
>> +
>> +description:
>> +  Qualcomm QDU1000 SoC Peripheral Authentication Service loads and boots firmware
>> +  on the Qualcomm DSP Hexagon core.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,qdu1000-mpss-pas
>> +
>> +  reg:
>> +    maxItems: 2
> You need to list the items instead (just like for clocks).

Will do.

>
>> +
>> +  clocks:
>> +    items:
>> +      - description: XO clock
>> +
>> +  clock-names:
>> +    items:
>> +      - const: xo
>> +
>> +  qcom,qmp:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description: Reference to the AOSS side-channel message RAM.
>> +
>> +  smd-edge: false
>> +
>> +  firmware-name:
>> +    $ref: /schemas/types.yaml#/definitions/string-array
> You can now drop the $ref.

Ok will drop.

>
>> +    items:
>> +      - description: Firmware name of the Hexagon core
>> +      - description: Firmware name of the Hexagon Devicetree
>> +
>> +  memory-region:
>> +    items:
>> +      - description: Memory region for main Firmware authentication
>> +      - description: Memory region for Devicetree Firmware authentication
>> +      - description: DSM Memory region
>> +
>> +  interrupts:
>> +    minItems: 6
>> +
>> +  interrupt-names:
>> +    minItems: 6
>> +
>> +  interconnects:
>> +    minItems: 1
> maxItems instead

Last comments said to drop this since it's redundant from qcom,pas-common.yaml. Will drop per
our discussion on https://lore.kernel.org/all/aba45ae9-8558-50c1-e5ad-dd910dacdbb3@linaro.org/.

>
>> +
>> +  power-domains:
>> +    items:
>> +      - description: CX power domain
>> +      - description: MSS power domain
>> +
>> +  power-domain-names:
>> +    items:
>> +      - const: cx
>> +      - const: mss
>> +
>> +required:
>> +  - compatible
>> +  - reg
> memory-region
>
> (I fixed other bindings)

Ah sounds good. Will add here.

>
>> +
>> +allOf:
>> +  - $ref: /schemas/remoteproc/qcom,pas-common.yaml#
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/qcom,rpmh.h>
>> +    #include <dt-bindings/interconnect/qcom,qdu1000-rpmh.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +    #include <dt-bindings/mailbox/qcom-ipcc.h>
>> +    #include <dt-bindings/power/qcom-rpmpd.h>
>> +
>> +    remoteproc@4080000 {
>> +        compatible = "qcom,qdu1000-mpss-pas";
>> +        reg = <0x4080000 0x4040>,
>> +              <0x4180000 0x1000>;
>> +
>> +        clocks = <&rpmhcc RPMH_CXO_CLK>;
>> +        clock-names = "xo";
>> +
>> +        interrupts-extended = <&intc GIC_SPI 264 IRQ_TYPE_EDGE_RISING>,
>> +                              <&smp2p_modem_in 0 IRQ_TYPE_EDGE_RISING>,
>> +                              <&smp2p_modem_in 1 IRQ_TYPE_EDGE_RISING>,
>> +                              <&smp2p_modem_in 2 IRQ_TYPE_EDGE_RISING>,
>> +                              <&smp2p_modem_in 3 IRQ_TYPE_EDGE_RISING>,
>> +                              <&smp2p_modem_in 7 IRQ_TYPE_EDGE_RISING>;
>> +        interrupt-names = "wdog", "fatal", "ready", "handover",
>> +                          "stop-ack", "shutdown-ack";
>> +
>> +        memory-region = <&mpss_mem>, <&dtb_mpss_mem>, <&mpss_dsm_mem>;
>> +
>> +        firmware-name = "qcom/qdu1000/modem.mbn",
>> +                        "qcom/qdu1000/modem_dtb.mbn";
>> +
>> +        power-domains = <&rpmhpd QDU1000_CX>,
>> +                        <&rpmhpd QDU1000_MSS>;
>> +        power-domain-names = "cx", "mss";
>> +
>> +        interconnects = <&mc_virt MASTER_LLCC &mc_virt SLAVE_EBI1>;
>> +
>> +        qcom,qmp = <&aoss_qmp>;
>> +
>> +        qcom,smem-states = <&smp2p_adsp_out 0>;
>> +        qcom,smem-state-names = "stop";
>> +
>> +        glink-edge {
>> +            interrupts-extended = <&ipcc IPCC_CLIENT_MPSS
>> +                                         IPCC_MPROC_SIGNAL_GLINK_QMP
>> +                                         IRQ_TYPE_EDGE_RISING>;
>> +            mboxes = <&ipcc IPCC_CLIENT_MPSS IPCC_MPROC_SIGNAL_GLINK_QMP>;
>> +
>> +            label = "modem";
>> +            qcom,remote-pid = <2>;
>> +
> Drop stray blank line

Got it. Also per https://lore.kernel.org/all/aba45ae9-8558-50c1-e5ad-dd910dacdbb3@linaro.org/.

Apologies for missing some comments.

Thanks,
Melody
>> +        };
>> +    };
> Best regards,
> Krzysztof
>

