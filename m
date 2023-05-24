Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D3870ED59
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 07:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239520AbjEXFu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 01:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239524AbjEXFuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 01:50:54 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72DA13E;
        Tue, 23 May 2023 22:50:52 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34O3q8aI022701;
        Wed, 24 May 2023 05:50:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=n4JO77A+9YTPPexD3vFKCA3ei5urNWozkAcvOrurlmo=;
 b=lT+dSifyB/cYwoXod4NQVieJ4ju+UzLxi878ae4x4eJNfV2C9qUCVm+mKXlEnv4E2uwX
 uewDkKTxoskuzspaWQF/Pb3llwLzpo6nfqq3CppT/Xzo0dmi5X35A6xDYZ+/dg0Jb2XG
 ClPETGfQqIgJjPQikBXlXwiwcW74x776i7ZT2omAlHfhIt3YFnX0OBI7HxiQVhxgOiMR
 +UrG0XFLJdaPhB2cMFmRBnuf/twjn+99PIyy35EJ9LaxVUhpS41Ub5wwadmNTodfo16m
 5rDc0bw8f+jPW0ZB2ByYpb8FEcjdT7oNdg1fq6GpsfvbO7PgA/FjKcXvIEMn9tOwoQj3 /w== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qs42urw1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 05:50:44 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34O5oAC9020169
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 05:50:10 GMT
Received: from [10.216.26.46] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 23 May
 2023 22:50:03 -0700
Message-ID: <02767039-39c2-76c7-e539-7ec7272c61ca@quicinc.com>
Date:   Wed, 24 May 2023 11:19:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V2 1/2] dt-bindings: phy: qcom,qmp-pcie: Add ipq9574
 bindings
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_ipkumar@quicinc.com>
References: <20230519085723.15601-1-quic_devipriy@quicinc.com>
 <20230519085723.15601-2-quic_devipriy@quicinc.com>
 <874a328c-bbfb-00cb-4b2e-69132605cb2d@linaro.org>
Content-Language: en-US
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <874a328c-bbfb-00cb-4b2e-69132605cb2d@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wQgtOg2kKNP1rlW9ALb8ENFSvTdobLpb
X-Proofpoint-GUID: wQgtOg2kKNP1rlW9ALb8ENFSvTdobLpb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_02,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305240049
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/22/2023 2:27 AM, Dmitry Baryshkov wrote:
> On 19/05/2023 11:57, Devi Priya wrote:
>> Add bindings for the PCIe QMP PHYs found on IPQ9574.
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>> ---
>>   Changes in V2:
>>     - Picked up the R-b tag
>>     - Did not convert the clock IDs to numerical values as the clock
>>       header (dependent patch) is merged in latest rc1.
>>
>>   .../phy/qcom,ipq9574-qmp-pcie-phy.yaml        | 90 +++++++++++++++++++
>>   1 file changed, 90 insertions(+)
>>   create mode 100644 
>> Documentation/devicetree/bindings/phy/qcom,ipq9574-qmp-pcie-phy.yaml
>>
>> diff --git 
>> a/Documentation/devicetree/bindings/phy/qcom,ipq9574-qmp-pcie-phy.yaml 
>> b/Documentation/devicetree/bindings/phy/qcom,ipq9574-qmp-pcie-phy.yaml
>> new file mode 100644
>> index 000000000000..7c8012647051
>> --- /dev/null
>> +++ 
>> b/Documentation/devicetree/bindings/phy/qcom,ipq9574-qmp-pcie-phy.yaml
>> @@ -0,0 +1,90 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/phy/qcom,ipq9574-qmp-pcie-phy.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm QMP PHY controller (PCIe, IPQ9574)
>> +
>> +maintainers:
>> +  - Vinod Koul <vkoul@kernel.org>
>> +
>> +description:
>> +  The QMP PHY controller supports physical layer functionality for a 
>> number of
>> +  controllers on Qualcomm chipsets, such as, PCIe, UFS, and USB.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,ipq9574-qmp-gen3x1-pcie-phy
>> +      - qcom,ipq9574-qmp-gen3x2-pcie-phy
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 5
>> +
>> +  clock-names:
>> +    items:
>> +      - const: aux
>> +      - const: cfg_ahb
>> +      - const: anoc_lane
>> +      - const: snoc_lane
>> +      - const: pipe
> 
> Could you please reorder the clocks in the following way:
> - aux
> - cfg_ahb
> - pipe
> - .. the rest
> 
> This will allow us to use this schema for other IPQ QMP PCIe PHYs.
Sure, will update.

Thanks,
Devi Priya
> 
>> +
>> +  resets:
>> +    maxItems: 2
>> +
>> +  reset-names:
>> +    items:
>> +      - const: phy
>> +      - const: common
>> +
>> +  "#clock-cells":
>> +    const: 0
>> +
>> +  clock-output-names:
>> +    maxItems: 1
>> +
>> +  "#phy-cells":
>> +    const: 0
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +  - resets
>> +  - reset-names
>> +  - "#clock-cells"
>> +  - clock-output-names
>> +  - "#phy-cells"
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/qcom,ipq9574-gcc.h>
>> +    #include <dt-bindings/reset/qcom,ipq9574-gcc.h>
>> +
>> +    pcie0_phy: phy@84000 {
>> +      compatible = "qcom,ipq9574-qmp-gen3x1-pcie-phy";
>> +      reg = <0x00084000 0x1000>;
>> +
>> +      clocks = <&gcc GCC_PCIE0_AUX_CLK>,
>> +               <&gcc GCC_PCIE0_AHB_CLK>,
>> +               <&gcc GCC_ANOC_PCIE0_1LANE_M_CLK>,
>> +               <&gcc GCC_SNOC_PCIE0_1LANE_S_CLK>,
>> +               <&gcc GCC_PCIE0_PIPE_CLK>;
>> +      clock-names = "aux", "cfg_ahb", "anoc_lane", "snoc_lane", "pipe";
>> +
>> +      resets = <&gcc GCC_PCIE0_PHY_BCR>,
>> +               <&gcc GCC_PCIE0PHY_PHY_BCR>;
>> +      reset-names = "phy", "common";
>> +
>> +      #clock-cells = <0>;
>> +      clock-output-names = "gcc_pcie0_pipe_clk_src";
>> +
>> +      #phy-cells = <0>;
>> +    };
> 
