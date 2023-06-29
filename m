Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBCD742FC5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 23:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjF2Vyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 17:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbjF2VyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 17:54:14 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A4B30F1;
        Thu, 29 Jun 2023 14:53:56 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35TLkQ42017475;
        Thu, 29 Jun 2023 21:53:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=/XdqmJgBgI4NzRL9qQX8jk2AqYtbjs3ud9Ias1hDbTU=;
 b=OzhtrvK2wIUJNu43NHUkL8DI6lSfkcUF5Q6ILcKgaPzLt2VfXIR9xB7iaZHnkgRBPhgD
 mq1Sgkw9gbvAYhKLuoC+66twsrfZsecWkN+dkMUGSEj+Rryd/f2bF0GkLQqUYZ+4vV08
 uWmcz4L17JUWDb1tEYqnnnAG+w9bc7ic7iiJKnGjx5fAnWgNSpQhFj+WELHBgdc52I2w
 73D1RLbR6dTaMOJyCp23pjVoWrpdQC4+1YGuQqmJB0+Y0LuYjCuA/Pr4EfKrzFGhxFV8
 7w5twNJMTxYR02wm/eSdgHAbVEdcDuZb+ef013XEwD4qIEyXbcVB593gvRfFZaEkK42j lA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rhgpgr5w8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 21:53:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35TLriad029585
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 21:53:44 GMT
Received: from [10.134.66.165] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.7; Thu, 29 Jun
 2023 14:53:43 -0700
Message-ID: <fa12dd5d-af9d-235d-a6c7-3dcf690dcd67@quicinc.com>
Date:   Thu, 29 Jun 2023 14:53:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/7] dt-bindings: soc: qcom: Add qcom-pbs bindings
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh@kernel.org>
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
 <2e871e21-a81d-0d7d-993b-9a9d7bd9d962@quicinc.com>
 <f274247c-f45b-8a48-92f2-cff4597aff15@linaro.org>
From:   Anjelique Melendez <quic_amelende@quicinc.com>
In-Reply-To: <f274247c-f45b-8a48-92f2-cff4597aff15@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kZcRCS-GeKOiZb2XNIZgHnfikzARb_cZ
X-Proofpoint-ORIG-GUID: kZcRCS-GeKOiZb2XNIZgHnfikzARb_cZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-29_08,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306290198
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/29/2023 1:45 AM, Dmitry Baryshkov wrote:
> On 29/06/2023 04:19, Anjelique Melendez wrote:
>>
>>
>> On 6/26/2023 6:58 AM, Rob Herring wrote:
>>> On Wed, Jun 21, 2023 at 11:59:45AM -0700, Anjelique Melendez wrote:
>>>> Add binding for the Qualcomm Programmable Boot Sequencer device.
>>>>
>>>> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
>>>> ---
>>>>   .../bindings/soc/qcom/qcom-pbs.yaml           | 41 +++++++++++++++++++
>>>>   1 file changed, 41 insertions(+)
>>>>   create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom-pbs.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom-pbs.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom-pbs.yaml
>>>> new file mode 100644
>>>> index 000000000000..0a89c334f95c
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom-pbs.yaml
>>>> @@ -0,0 +1,41 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/soc/qcom/qcom-pbs.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Qualcomm Technologies, Inc. PBS
>>>> +
>>>> +maintainers:
>>>> +  - Anjelique Melendez <quic_amelende@quicinc.com>
>>>> +
>>>> +description: |
>>>> +  Qualcomm PBS (programmable boot sequencer) supports triggering sequences
>>>> +  for clients upon request.
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: qcom,pbs
>>>> +
>>>> +  reg:
>>>> +    description: |
>>>> +      Base address of the PBS peripheral.
>>>> +    maxItems: 1
>>>> +
>>>> +required:
>>>> + - compatible
>>>> + - reg
>>>> +
>>>> +additionalProperties: false
>>>> +
>>>> +examples:
>>>> +  - |
>>>> +    pmic {
>>>> +      #address-cells = <1>;
>>>> +      #size-cells = <0>;
>>>> +
>>>> +      qcom,pbs@7400 {
>>>> +        compatible = "qcom,pbs";
>>>> +        reg = <0x7400>;
>>>> +      };
>>>
>>> Why do you need a child node for this? Is there more than 1 instance in
>>> a PMIC? Every sub-function of a PMIC doesn't have to have a DT node.
>>>
>>
>> We currently have another downstream driver (which is planned to get upstreamed)
>> which also needs a handle to a pbs device in order to properly trigger events.
> 
> Does it have to be a separate driver? Or is it a part of the LPG driver, just being artificially split away?

Sure, I just discussed with team and we are ok with removing this as a separate driver. Will have that 
for next version. 
> 
>>
>>> Rob
>>
>>
>>
> 
