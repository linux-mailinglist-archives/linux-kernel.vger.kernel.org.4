Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C185860575C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 08:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiJTGdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 02:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiJTGdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 02:33:36 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAB215B303;
        Wed, 19 Oct 2022 23:33:34 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29K5oH7Z009106;
        Thu, 20 Oct 2022 06:33:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0UYnmYoL+d89Orz6iaNY/DjHRjYVyMl063fYMgg13s8=;
 b=fsIaTrsH3vzcn1Zowyt/TwOq4hYJYTTHafg/yS9Ai0l/tJ/wCGSaMKVMT/KSRO4k9vCw
 Yg1CgIqwQpM1+WmXI7eYj2KAbgwoO5NFxCZ0mojOm15Q6z+FrTOloqy4hFbi+/eZjwTy
 kvSfBMPqWCYHrcD7ydKDCcDrN+1Ok28pRU+zXKeNS32saij0t1AnBgNI9jprb6HTKuLk
 SzFFDW4hTXIZDowsBXGiW9CL9XDqp9aTSjX5D7R17L79CDw77A/yUjkk9HCKrxum0YJh
 rdx458Guk/7/6aeT3Rp3fmoGuVfSVnGtjmtGyxSA0yXvQP3tkwC6nCdjYNECXSpEPOWx iA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ka6brukhj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 06:33:24 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29K6XMR2011139
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 06:33:22 GMT
Received: from [10.239.155.106] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 19 Oct
 2022 23:33:19 -0700
Message-ID: <f1ae1f37-ab94-d0ae-289f-08d8b1cae772@quicinc.com>
Date:   Thu, 20 Oct 2022 14:33:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v3 2/2] dt-bindings: add bindings for QCOM flash LED
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Konrad Dybcio" <konrad.dybcio@somainline.org>,
        Pavel Machek <pavel@ucw.cz>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>
References: <20221018014024.948731-1-quic_fenglinw@quicinc.com>
 <20221018014024.948731-3-quic_fenglinw@quicinc.com>
 <b335e842-0dd9-851a-9876-8ee4711609c0@linaro.org>
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
In-Reply-To: <b335e842-0dd9-851a-9876-8ee4711609c0@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5_GkBqJhkKvSeCvFarFHW0Z2lzvFH2rt
X-Proofpoint-GUID: 5_GkBqJhkKvSeCvFarFHW0Z2lzvFH2rt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_01,2022-10-19_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0
 suspectscore=0 clxscore=1015 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210200037
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/10/19 21:36, Krzysztof Kozlowski wrote:
> On 17/10/2022 21:40, Fenglin Wu wrote:
>> Add binding document for flash LED module inside Qualcomm Technologies,
>> Inc. PMICs.
> 
> Use subject prefixes matching the subsystem (git log --oneline -- ...).
> 
> This means:
> 1. you miss subsystem prefix
> 2. drop redundant second "bindings"
> 
>>
>> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
>> ---
>>   .../bindings/leds/qcom,spmi-flash-led.yaml    | 116 ++++++++++++++++++
>>   1 file changed, 116 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml b/Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml
>> new file mode 100644
>> index 000000000000..d8efde02db72
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml
>> @@ -0,0 +1,116 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/leds/qcom,spmi-flash-led.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Flash LED device inside Qualcomm Technologies, Inc. PMICs
>> +
>> +maintainers:
>> +  - Fenglin Wu <quic_fenglinw@quicinc.com>
>> +
>> +description: |
>> +  Flash LED controller is present inside some Qualcomm Technologies, Inc. PMICs.
>> +  The flash LED module can have different number of LED channels supported
>> +  e.g. 3 or 4. There are some different registers between them but they can
>> +  both support maximum current up to 1.5 A per channel and they can also support
>> +  ganging 2 channels together to supply maximum current up to 2 A. The current
>> +  will be split symmetrically on each channel and they will be enabled and
>> +  disabled at the same time.
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - qcom,pm8150c-flash-led
>> +          - qcom,pm8150l-flash-led
>> +          - qcom,pm8350c-flash-led
>> +      - const: qcom,spmi-flash-led
> 
> Blank line
> 
>> +  reg:
>> +    description: address offset of the flash LED controller
> 
> Drop description, it's obvious.
> 
>> +    maxItems: 1
>> +
>> +patternProperties:
>> +  "^led-[0-3]$":
>> +    type: object
>> +    $ref: common.yaml#
>> +    unevaluatedProperties: false
>> +    description: |
> 
> No need for |
> 
>> +      Represents the physical LED components which are connected to the
>> +      flash LED channels' output.
>> +
>> +    properties:
>> +      led-sources:
>> +        description: |
> 
> No need for |
> 
> Rest looks good:
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof
> 
Thanks you Krzysztof! I will address them when pushing next patch.
