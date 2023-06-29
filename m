Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C9E741D97
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 03:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjF2BTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 21:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjF2BTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 21:19:43 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B5626AD;
        Wed, 28 Jun 2023 18:19:42 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35T1EvEf031451;
        Thu, 29 Jun 2023 01:19:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=oO3Cd6/0cmdN9gn+GWK3iWlbDsuo17nygEG2aeXxfaQ=;
 b=is0FlJ6EUnBeAeCD4pXg9d++NoO8z6Db/Ga+Zz7k0B1YmiBS0psPZWbhDswTwQnWDvLv
 A1xp7R/ymt/4Kc37n8GcTUqZMCb15SYbLGu/s+5nNNU1wUpFs5/2PwQfS/MgWF21b1w4
 9by4xF64zb+S1/+6qeysb4WNGOQIAUOY6DHtA2U1e3Lov33eSzAXtc9j0aUcObmJ7M+y
 zMtYKpRMj4916Aj9i/EZ/pAUiei5jX54qXn7cYnPv9h6XpRyPFoEfPVhY22KTk+2iikN
 koqKCDeGvDwVU4d3/rSKnlZYkubDJ0paekAkmQRA31W187Yau/FKYHbuWTemOldXbiNQ pQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rgnxr97n7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 01:19:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35T1JTXH029246
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 01:19:29 GMT
Received: from [10.110.20.95] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.7; Wed, 28 Jun
 2023 18:19:28 -0700
Message-ID: <2e871e21-a81d-0d7d-993b-9a9d7bd9d962@quicinc.com>
Date:   Wed, 28 Jun 2023 18:19:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/7] dt-bindings: soc: qcom: Add qcom-pbs bindings
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <pavel@ucw.cz>, <lee@kernel.org>, <thierry.reding@gmail.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <u.kleine-koenig@pengutronix.de>,
        <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
References: <20230621185949.2068-1-quic_amelende@quicinc.com>
 <20230621185949.2068-2-quic_amelende@quicinc.com>
 <20230626135857.GA3118929-robh@kernel.org>
From:   Anjelique Melendez <quic_amelende@quicinc.com>
In-Reply-To: <20230626135857.GA3118929-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6Efzwhmw1uFevjBrwBdPfibktLtBEN3w
X-Proofpoint-GUID: 6Efzwhmw1uFevjBrwBdPfibktLtBEN3w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_14,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 impostorscore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306290010
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/26/2023 6:58 AM, Rob Herring wrote:
> On Wed, Jun 21, 2023 at 11:59:45AM -0700, Anjelique Melendez wrote:
>> Add binding for the Qualcomm Programmable Boot Sequencer device.
>>
>> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
>> ---
>>  .../bindings/soc/qcom/qcom-pbs.yaml           | 41 +++++++++++++++++++
>>  1 file changed, 41 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom-pbs.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom-pbs.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom-pbs.yaml
>> new file mode 100644
>> index 000000000000..0a89c334f95c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom-pbs.yaml
>> @@ -0,0 +1,41 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/soc/qcom/qcom-pbs.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Technologies, Inc. PBS
>> +
>> +maintainers:
>> +  - Anjelique Melendez <quic_amelende@quicinc.com>
>> +
>> +description: |
>> +  Qualcomm PBS (programmable boot sequencer) supports triggering sequences
>> +  for clients upon request.
>> +
>> +properties:
>> +  compatible:
>> +    const: qcom,pbs
>> +
>> +  reg:
>> +    description: |
>> +      Base address of the PBS peripheral.
>> +    maxItems: 1
>> +
>> +required:
>> + - compatible
>> + - reg
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    pmic {
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +
>> +      qcom,pbs@7400 {
>> +        compatible = "qcom,pbs";
>> +        reg = <0x7400>;
>> +      };
> 
> Why do you need a child node for this? Is there more than 1 instance in 
> a PMIC? Every sub-function of a PMIC doesn't have to have a DT node.
>

We currently have another downstream driver (which is planned to get upstreamed)
which also needs a handle to a pbs device in order to properly trigger events. 

> Rob



