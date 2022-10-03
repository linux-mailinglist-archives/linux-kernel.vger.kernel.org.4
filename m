Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F71B5F35D3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 20:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiJCSrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 14:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiJCSr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 14:47:28 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410D2422D4;
        Mon,  3 Oct 2022 11:47:25 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 293F1DXZ013162;
        Mon, 3 Oct 2022 18:47:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=gektquLvudXA4maK2/RJ1dwQS3uDgfOeQx425Jb1f5s=;
 b=aUmfIlP/q/F8p5iJwEBNwtcHt5wg8bXyE8UUW7TRUX4LROjBCYb99eXEu8WM2NixggfU
 IwYrb6DbIw0MHvgaBycTdJF9a0qfnFVzT8a4YSuBR5/EpYBKnDAJjECoQ5q9rVCfhJb+
 qYX1DolNGQSoX41b6eTG5x8kuEgnOGGxxHF3VaITenbn/4WHswoNmfXePKU1TkNQXJuD
 9KTb8L+SXGkcP9FOidSGSkUdRbAL6M9PbFKgbQqATeusljaJkfCPrD4AlTlvk50tlGYk
 y4Mn1Sr7brmD32EthVZY7Zz8a6u7OHnfsU4YmaG8zTy6BRPWQRA8Ta0S4Vr+sXoJ27AT WQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jxawu4j67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Oct 2022 18:47:08 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 293Il7hW031283
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 3 Oct 2022 18:47:07 GMT
Received: from [10.110.93.213] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 3 Oct 2022
 11:47:05 -0700
Message-ID: <bb241d46-6f90-8604-e79d-30a1f3527ce4@quicinc.com>
Date:   Mon, 3 Oct 2022 13:47:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/5] dt-bindings: clock: Add QDU1000 and QRU1000 GCC clock
 bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221001030403.27659-1-quic_molvera@quicinc.com>
 <20221001030403.27659-2-quic_molvera@quicinc.com>
 <37926f0f-e176-929e-939a-cd43a031e224@linaro.org>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <37926f0f-e176-929e-939a-cd43a031e224@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xfMCvX5q60oCKiMGzugQKRSsdKD40Brv
X-Proofpoint-ORIG-GUID: xfMCvX5q60oCKiMGzugQKRSsdKD40Brv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-03_02,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 clxscore=1011 malwarescore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210030112
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/1/2022 4:24 AM, Krzysztof Kozlowski wrote:
> On 01/10/2022 05:03, Melody Olvera wrote:
>> Add device tree bindings for global clock controller on QDU1000 and
>> QRU1000 SoCs.
>>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
>>  .../bindings/clock/qcom,gcc-qdru1000.yaml     |  74 ++++++++
>>  include/dt-bindings/clock/qcom,gcc-qdru1000.h | 170 ++++++++++++++++++
>>  2 files changed, 244 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-qdru1000.yaml
>>  create mode 100644 include/dt-bindings/clock/qcom,gcc-qdru1000.h
>>
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-qdru1000.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-qdru1000.yaml
>> new file mode 100644
>> index 000000000000..d92f558d547c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-qdru1000.yaml
>> @@ -0,0 +1,74 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/qcom,gcc-qdru.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Global Clock & Reset Controller Binding for QDU1000 and QRU1000
> Drop "Binding"

Will do in v2.

>
>> +
>> +maintainers:
>> +  - Melody Olvera <quic_molvera@quicinc.com>
>> +
>> +description: |
>> +  Qualcomm global clock control module which supports the clocks, resets and
>> +  power domains on QDU1000 and QRU1000
>> +
>> +  See also:
>> +  - dt-bindings/clock/qcom,gcc-qdru1000.h
> Full path
Understood.
>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,gcc-qdu1000
>> +      - qcom,gcc-qru1000
>> +
>> +  clocks:
>> +    items:
>> +      - description: Board XO source
>> +      - description: Sleep clock source
>> +      - description: PCIE 0 Pipe clock source (Optional clock)
> Skip "Optional clock"
>
>> +      - description: PCIE 0 Phy Auxiliary clock source (Optional clock)
>> +      - description: USB3 Phy wrapper pipe clock source (Optional clock)
>> +    minItems: 2
>> +
>> +  clock-names:
>> +    items:
>> +      - const: bi_tcxo
>> +      - const: sleep_clk
>> +      - const: pcie_0_pipe_clk # Optional clock
> Skip "Optional clock"

Will remove all optional clock instances.

>
>> +      - const: pcie_0_phy_aux_clk # Optional clock
>> +      - const: usb3_phy_wrapper_gcc_usb30_pipe_clk # Optional clock
>> +    minItems: 2
>> +
>> +  '#clock-cells':
>> +    const: 1
>> +
>> +  '#reset-cells':
>> +    const: 1
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +  - '#clock-cells'
>> +  - '#reset-cells'
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/qcom,rpmh.h>
>> +    clock-controller@100000 {
>> +      compatible = "qcom,gcc-qdu1000";
>> +      reg = <0x00100000 0x001f4200>;
>> +      clocks = <&rpmhcc RPMH_CXO_CLK>, <&sleep_clk>;
>> +      clock-names = "bi_tcxo", "sleep_clk";
>> +      #clock-cells = <1>;
>> +      #reset-cells = <1>;
>> +    };
>> +
>> +...
>> diff --git a/include/dt-bindings/clock/qcom,gcc-qdru1000.h b/include/dt-bindings/clock/qcom,gcc-qdru1000.h
>> new file mode 100644
>> index 000000000000..cdc5d1a6a007
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/qcom,gcc-qdru1000.h
>> @@ -0,0 +1,170 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
> Dual license.
Good catch; will remove.
>
>
> Best regards,
> Krzysztof

Thanks,

Melody

