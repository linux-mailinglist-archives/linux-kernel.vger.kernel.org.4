Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C456C6E3E7F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 06:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjDQEf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 00:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDQEfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 00:35:53 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857B82125;
        Sun, 16 Apr 2023 21:35:52 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33H3kAH2020693;
        Mon, 17 Apr 2023 04:35:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=PzBJs2aRNTtp8SH7nF5qTvm6X9WqpNVDmBYZxO25dHg=;
 b=JSgoXwACmToGEXCrfY29LBf/idCp1UQjWV36ZFCyvIhuauH9bCKPmrH6pa+2SesDivnP
 Gc45QJYa76/X5LJKVaNfoQoLASBXOKrvywU57sPfbWUg9l0GatrtlI/wH11PWpqlNoJ3
 DTZpz03pI3IpH7+UyifhYgn0K6dYsAjdvcs+IFr3G+eUd5VU3lo8qIZBb9Q8RYhwlgTC
 lVH3xlZQBFVgikReU/1onOhyLHBO3BlGmEl2PTta5lnyMwfasmj0mSS9pYOYYNEE0HLe
 Fl/mSNjfByXaBFq0XejI/bxlBLex5ltY8pcVuijrXT+51WjvA7aEfxvmgfz4WyCRljWx 0g== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pymp4ajyn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 04:35:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33H4ZgZF019047
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 04:35:42 GMT
Received: from [10.217.216.152] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Sun, 16 Apr
 2023 21:35:37 -0700
Message-ID: <cdc74099-2ebc-34c6-884f-06756fe63841@quicinc.com>
Date:   Mon, 17 Apr 2023 10:05:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/3] dt-bindings: clock: qcom: Add bindings for videocc on
 SM8450
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_skakitap@quicinc.com>, <quic_jkona@quicinc.com>
References: <20230316083049.29979-1-quic_tdas@quicinc.com>
 <20230316083049.29979-2-quic_tdas@quicinc.com>
 <7424bab4-6a92-7d71-b110-454819101678@linaro.org>
From:   Taniya Das <quic_tdas@quicinc.com>
In-Reply-To: <7424bab4-6a92-7d71-b110-454819101678@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UjTDlSigSMoM_bIAWILKq6iXSA0x0hsW
X-Proofpoint-ORIG-GUID: UjTDlSigSMoM_bIAWILKq6iXSA0x0hsW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_01,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 impostorscore=0 spamscore=0 mlxlogscore=935 lowpriorityscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304170039
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Krzysztof,

Thank you for the review.

On 3/17/2023 1:04 AM, Krzysztof Kozlowski wrote:
> On 16/03/2023 09:30, Taniya Das wrote:
>> Add device tree bindings for the video clock controller on Qualcomm
>> SM8450 platform.
> 
> Subject: drop second/last, redundant "bindings for". The "dt-bindings"
> prefix is already stating that these are bindings.
> 

sure, will update it in the next patch.

>>
>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>> ---
>>   .../bindings/clock/qcom,sm8450-videocc.yaml   | 84 +++++++++++++++++++
>>   .../dt-bindings/clock/qcom,videocc-sm8450.h   | 38 +++++++++
>>   2 files changed, 122 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
>>   create mode 100644 include/dt-bindings/clock/qcom,videocc-sm8450.h
>>
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
>> new file mode 100644
>> index 000000000000..909da704c123
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
>> @@ -0,0 +1,84 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/qcom,sm8450-videocc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Video Clock & Reset Controller on SM8450
>> +
>> +maintainers:
>> +  - Taniya Das <quic_tdas@quicinc.com>
>> +
>> +description: |
>> +  Qualcomm video clock control module provides the clocks, resets and power
>> +  domains on SM8450.
>> +
>> +  See also:: include/dt-bindings/clock/qcom,videocc-sm8450.h
>> +
>> +properties:
>> +  compatible:
>> +    const: qcom,sm8450-videocc
>> +
>> +  clocks:
>> +    items:
>> +      - description: Video AHB clock from GCC
>> +      - description: Board XO source
>> +
>> +  clock-names:
>> +    items:
>> +      - const: iface
>> +      - const: bi_tcxo
>> +
>> +  power-domains:
>> +    maxItems: 1
>> +    description:
>> +      A phandle and PM domain specifier for the MMCX power domain.
> 
> Drop "A phandle and PM domain specifier for the"
>

Done.

>> +
>> +  required-opps:
>> +    maxItems: 1
>> +    description:
>> +      A phandle to an OPP node describing required MMCX performance point.
>> +
>> +  '#clock-cells':
>> +    const: 1
>> +
>> +  '#reset-cells':
>> +    const: 1
>> +
>> +  '#power-domain-cells':
>> +    const: 1
>> +
>> +  reg:
>> +    maxItems: 1
> 
> That's a unusual ordering. Either order elements by name or use some
> custom order... but then reg is always second property.
> 

Will fix in the next patch set.

>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +  - power-domains
>> +  - required-opps
>> +  - '#clock-cells'
>> +  - '#reset-cells'
>> +  - '#power-domain-cells'
> 
> And keep same order in required.
> 

Done.

>> +
>> +additionalProperties: false
> 
> 
> Best regards,
> Krzysztof
> 

-- 
Thanks & Regards,
Taniya Das.
