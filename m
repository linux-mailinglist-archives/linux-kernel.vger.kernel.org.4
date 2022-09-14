Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655075B8389
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 10:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiINI75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 04:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbiINI72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 04:59:28 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FBA74E28;
        Wed, 14 Sep 2022 01:58:54 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28E8UQnc022214;
        Wed, 14 Sep 2022 08:58:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0kaGHzaSpcyFnmwKJ+2+XawG8PyLKkjlKHKy/F9Qbos=;
 b=K7vivhzfY5iRhWr27a1J+7gFQHpQEYTQvDiMfTyM4ZgfknqDyETwhw06W0jtlqkiSrBH
 Ap5zhaYkw7VkKCoIl7JgAk3LqygjHPwlCQT/kyQdXoyQoCp06/mTzA6tX1Fa5PyeRsTB
 zE4M8AZVcftOL7jOfb3LX7aJOGD+3xiTYA7nepYcsmcJwNuAHfOZ7uNPTRJgbEH3z62g
 aracHrf0F2gNtZUvBNGSh/uYdPedt6mvz6mQjx3/+RQES55pC2zz3Uln8BFveu05kZRM
 eoyyeu0NiPJ4KWl289TqaIV4lEVocLNG5zM/XSFKHzvotjQ5Pv5K6cLL9acN/bKDknyv Yw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jjy0e1vm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 08:58:36 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28E8wYPi028705
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 08:58:34 GMT
Received: from [10.79.43.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 14 Sep
 2022 01:58:30 -0700
Subject: Re: [PATCH v6 1/8] dt-bindings: remoteproc: qcom: Add SC7280 ADSP
 support
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        <linux-remoteproc@vger.kernel.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, <devicetree@vger.kernel.org>
References: <1662643422-14909-1-git-send-email-quic_srivasam@quicinc.com>
 <1662643422-14909-2-git-send-email-quic_srivasam@quicinc.com>
From:   Sibi Sankar <quic_sibis@quicinc.com>
Message-ID: <3d79125c-74c4-315e-cfd2-2263d3714716@quicinc.com>
Date:   Wed, 14 Sep 2022 14:28:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1662643422-14909-2-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mdGY0hU0cp5o-1DVSe4OO1sPGuUzOFXU
X-Proofpoint-GUID: mdGY0hU0cp5o-1DVSe4OO1sPGuUzOFXU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_03,2022-09-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1011
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209140043
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Srinivas,
Thanks for the patch series.

On 9/8/22 6:53 PM, Srinivasa Rao Mandadapu wrote:
> Add ADSP PIL loading support for SC7280 SoCs.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes since V5:
> 	-- Remove qcom,adsp-memory-regions property.
> Changes since V4:
> 	-- Update halt registers description in dt bindings.
> 
>   .../bindings/remoteproc/qcom,sc7280-adsp-pil.yaml  | 175 +++++++++++++++++++++
>   1 file changed, 175 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml
> new file mode 100644
> index 0000000..1428522
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml
> @@ -0,0 +1,175 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/remoteproc/qcom,sc7280-adsp-pil.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SC7280 ADSP Peripheral Image Loader
> +
> +maintainers:
> +  - Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> +
> +description:
> +  This document defines the binding for a component that loads and boots firmware

s/defines the binding/describes the hardware.

> +  on the Qualcomm Technology Inc. ADSP.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,sc7280-adsp-pil
> +
> +  reg:
> +    minItems: 1
> +    items:
> +      - description: qdsp6ss register
> +      - description: efuse q6ss register
> +
> +  interrupts:
> +    items:
> +      - description: Watchdog interrupt
> +      - description: Fatal interrupt
> +      - description: Ready interrupt
> +      - description: Handover interrupt
> +      - description: Stop acknowledge interrupt
> +      - description: Shutdown acknowledge interrupt
> +
> +  interrupt-names:
> +    items:
> +      - const: wdog
> +      - const: fatal
> +      - const: ready
> +      - const: handover
> +      - const: stop-ack
> +      - const: shutdown-ack
> +
> +  clocks:
> +    items:
> +      - description: XO clock
> +      - description: GCC CFG NOC LPASS clock
> +      - description: LPASS AHBS AON clock
> +      - description: LPASS AHBM AON clock
> +      - description: QDSP XO clock
> +      - description: Q6SP6SS SLEEP clock
> +      - description: Q6SP6SS CORE clock
> +
> +  clock-names:
> +    items:
> +      - const: xo
> +      - const: gcc_cfg_noc_lpass
> +      - const: lpass_ahbs_aon_cbcr
> +      - const: lpass_ahbm_aon_cbcr
> +      - const: qdsp6ss_xo
> +      - const: qdsp6ss_sleep
> +      - const: qdsp6ss_core
> +
> +  power-domains:
> +    items:
> +      - description: LCX power domain

Doesn't it need the LMX pd as well?


> +
> +  resets:
> +    items:
> +      - description: PDC AUDIO SYNC RESET
> +      - description: CC LPASS restart
> +
> +  reset-names:
> +    items:
> +      - const: pdc_sync
> +      - const: cc_lpass
> +
> +  memory-region:
> +    maxItems: 1
> +    description: Reference to the reserved-memory for the Hexagon core
> +
> +  qcom,halt-regs:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description:
> +      Phandle reference to a syscon representing TCSR followed by the
> +      four offsets within syscon for q6, CE, AXI and qv6 halt registers.
> +    items:
> +      items:
> +        - description: phandle to TCSR MUTEX
> +        - description: offset to q6 halt registers
> +        - description: offset to CE halt registers
> +        - description: offset to AXI halt registers
> +        - description: offset to qv6 halt registers
> +
> +  qcom,smem-states:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: States used by the AP to signal the Hexagon core
> +    items:
> +      - description: Stop the modem
> +
> +  qcom,smem-state-names:
> +    $ref: /schemas/types.yaml#/definitions/string

You can skip ref and items.

> +    description: The names of the state bits used for SMP2P output
> +    items:
> +      - const: stop
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-names
> +  - clocks
> +  - clock-names
> +  - power-domains
> +  - resets
> +  - reset-names
> +  - qcom,halt-regs
> +  - memory-region
> +  - qcom,smem-states
> +  - qcom,smem-state-names

You probably also need to mention qcom,qmp as a required property.
Not sure why you choose to skip glink-edge as well.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/qcom,rpmh.h>
> +    #include <dt-bindings/clock/qcom,gcc-sc7280.h>
> +    #include <dt-bindings/clock/qcom,lpass-sc7280.h>
> +    #include <dt-bindings/reset/qcom,sdm845-aoss.h>
> +    #include <dt-bindings/reset/qcom,sdm845-pdc.h>
> +    #include <dt-bindings/power/qcom-rpmpd.h>
> +
> +    remoteproc@3000000 {
> +        compatible = "qcom,sc7280-adsp-pil";
> +        reg = <0x03000000 0x5000>,
> +              <0x0355b000 0x10>;
> +
> +        interrupts-extended = <&pdc 162 IRQ_TYPE_EDGE_RISING>,
> +                <&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> +                <&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
> +                <&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
> +                <&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>,
> +                <&adsp_smp2p_in 7 IRQ_TYPE_EDGE_RISING>;
> +
> +        interrupt-names = "wdog", "fatal", "ready",
> +                "handover", "stop-ack", "shutdown-ack";
> +
> +        clocks = <&rpmhcc RPMH_CXO_CLK>,
> +                 <&gcc GCC_CFG_NOC_LPASS_CLK>,
> +                 <&lpasscc LPASS_Q6SS_AHBM_CLK>,
> +                 <&lpasscc LPASS_Q6SS_AHBS_CLK>,
> +                 <&lpasscc LPASS_QDSP6SS_XO_CLK>,
> +                 <&lpasscc LPASS_QDSP6SS_SLEEP_CLK>,
> +                 <&lpasscc LPASS_QDSP6SS_CORE_CLK>;
> +        clock-names = "xo", "gcc_cfg_noc_lpass",
> +                "lpass_ahbs_aon_cbcr",
> +                "lpass_ahbm_aon_cbcr", "qdsp6ss_xo",
> +                "qdsp6ss_sleep", "qdsp6ss_core";
> +
> +        power-domains = <&rpmhpd SC7280_LCX>;
> +
> +        resets = <&pdc_reset PDC_AUDIO_SYNC_RESET>,
> +                 <&aoss_reset AOSS_CC_LPASS_RESTART>;
> +        reset-names = "pdc_sync", "cc_lpass";
> +
> +        qcom,halt-regs = <&tcsr_mutex 0x23000 0x25000 0x28000 0x33000>;
> +
> +        memory-region = <&adsp_mem>;
> +
> +        qcom,smem-states = <&adsp_smp2p_out 0>;
> +        qcom,smem-state-names = "stop";
> +
> +    };
> 
