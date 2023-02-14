Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741B1696F45
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 22:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbjBNVXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 16:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjBNVXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 16:23:35 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C92A5255;
        Tue, 14 Feb 2023 13:23:34 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31EIohie023146;
        Tue, 14 Feb 2023 21:23:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=EGZv5zrdXRiG7KPid3Aat8kxgLpYUGVrYG9J+QSE4Ws=;
 b=ZWufoJ3d+X8HoeV6nUwm5mTpif0YTDdprB96YindstOPKnAq5Dr7NVCjgDHaK3iYVpqw
 ihnRoAz2oXgtYF6uMXDxxc6Rhsmpjvk8qGWR/cx0kDDDvT5ZZCBv0xE+ZjbexRJC0XCh
 e8kguuYyWZ/CQ45GsblOYvNvnpQ0OlNY3YjKLF5XL2qTTnBiyFxpzO49W9b7EfWgxvrG
 aie6SZ+Uui8/lrTPQswurMdpEjnAlYGnMfMKMDu537lMMwEqIFf02gIWnsDPFYp7ttBy
 reiRg1RuKlbutqIyO99a/NUq5d00cB5H42RQm9++vuHxNAnbCg/rzEf195LdQrkPJLqy 3A== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nr6qkhxea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 21:23:30 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31ELNTmu024657
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 21:23:29 GMT
Received: from [10.134.66.255] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 14 Feb
 2023 13:23:29 -0800
Message-ID: <0cb9dcb8-130e-7ad2-1f58-3d2f1bb48a49@quicinc.com>
Date:   Tue, 14 Feb 2023 13:23:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 5/9] dt-bindings: remoteproc: mpss: Document
 QDU1000/QRU1000 mpss devices
Content-Language: en-US
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
References: <20230213185218.166520-1-quic_molvera@quicinc.com>
 <20230213185218.166520-6-quic_molvera@quicinc.com>
 <aba45ae9-8558-50c1-e5ad-dd910dacdbb3@linaro.org>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <aba45ae9-8558-50c1-e5ad-dd910dacdbb3@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OTWd0M9XXKq53Q16rsGBcqtSCSMMO6DU
X-Proofpoint-ORIG-GUID: OTWd0M9XXKq53Q16rsGBcqtSCSMMO6DU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_15,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 mlxlogscore=917 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140183
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/14/2023 12:28 AM, Krzysztof Kozlowski wrote:
> On 13/02/2023 19:52, Melody Olvera wrote:
>> This documents the compatible for the component used to boot the
>> MPSS on the QDU1000 and QRU1000 SoCs.
>>
>> The QDU1000 and QRU1000 mpss boot process now requires the specification
>> of an RMB register space to complete the handshake needed to start or
>> attach the mpss.
>>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
>>  .../bindings/remoteproc/qcom,qdu1000-pas.yaml | 127 ++++++++++++++++++
>>  1 file changed, 127 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,qdu1000-pas.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,qdu1000-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,qdu1000-pas.yaml
>> new file mode 100644
>> index 000000000000..eb6ade984778
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,qdu1000-pas.yaml
>> @@ -0,0 +1,127 @@
>> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/remoteproc/qcom,qdu1000-pas.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm QDU1000 Peripheral Authentication Service
>> +
>> +maintainers:
>> +  - Melody Olvera <quic_molvera@quicinc.com>
>> +
>> +description:
>> +  Qualcomm QDU1000 SoC Peripheral Authentication Service loads and boots firmware
>> +  on the Qualcomm DSP Hexagon cores.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,qdu1000-mpss-pas
> What about other remote processors? The subject prefix suggests it is
> only for mpss, but filename is different.

Yeah so QDU1000 and QRU1000 only have mpss; there are no other remote processors.
However, it uses the same PAS driver as the other remote processors on other SoCs.
I can rename to Modem Peripheral Authentication Service.

>
>> +
>> +  reg:
>> +    maxItems: 2
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
> You can drop the property. It's coming from qcom,pas-common.yaml

Got it.

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
>> +
>> +allOf:
>> +  - $ref: /schemas/remoteproc/qcom,pas-common.yaml#
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/qcom,rpmh.h>
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +    #include <dt-bindings/mailbox/qcom-ipcc.h>
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
>> +                              <&smp2p_modem_in 3 IRQ_TYPE_EDGE_RISING>
>> +                              <&smp2p_modem_in 7 IRQ_TYPE_EDGE_RISING>;
>> +        interrupt-names = "wdog", "fatal", "ready", "handover",
>> +                          "stop-ack", "shutdown-ack";
>> +
>> +        memory-region = <&mpss_mem>, <&dtb_mpss_mem>, <&mpss_dsm_mem>;
>> +
>> +        firmware-name = "modem.mdt",
>> +                        "modem_dtb.mdt";
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
> Drop blank line

Ok.

Thanks,
Melody
>
>> +        };
>> +    };
> Best regards,
> Krzysztof
>

