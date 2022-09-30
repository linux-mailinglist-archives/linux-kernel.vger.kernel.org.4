Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DFD5F0223
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 03:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiI3BLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 21:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiI3BLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 21:11:18 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2E2E99B4;
        Thu, 29 Sep 2022 18:11:15 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28U0taLj028099;
        Fri, 30 Sep 2022 01:10:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=kTNksO62vMSkvld80APJwrcbQRnwBH/bdjxyGRtbZlE=;
 b=cdT2hri+ZaRXkmC/7xg7ifk+clNDiWAMD5e+Tjz/pES+z3QojCFFZBRR+lyyjLDvgeJV
 4zoEAt6nz5ffwvComs8gA9WsojEuc7RvCLDJdLNX4NGr2YyCD3/7Z5/h4zf9rlfVspSk
 zCJs90VH2yGE01hHdda9jx7NX1EZjXk1wo8zRwEgbmCiCM25VU8Ihc4d7i75WmgGL4Gm
 tzipZfUbBbshlwncmiae1dNO4ExzHbVDErfW32HSLM3SY8JR9WWPNBPvBwMHzJ5LMQki
 oRJaqXJkEkkfNm4H1AcMwvJs8Iifohngw61ToQ3pyaCmB+W04AkYD4XBeYuBiqlXFs6G HQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jwehw92ny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 01:10:35 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28U1AYuG024539
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 01:10:34 GMT
Received: from [10.239.155.106] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 29 Sep
 2022 18:10:31 -0700
Message-ID: <385ad635-ddea-b3c7-7e4d-2ad18c72e145@quicinc.com>
Date:   Fri, 30 Sep 2022 09:10:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 2/2] dt-bindings: add bindings for QCOM flash LED
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <collinsd@codeaurora.org>, <subbaram@codeaurora.org>
References: <20220929121544.1064279-1-quic_fenglinw@quicinc.com>
 <20220929121544.1064279-3-quic_fenglinw@quicinc.com>
 <5445adda-80e6-41d0-9786-c26d253631c9@linaro.org>
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
In-Reply-To: <5445adda-80e6-41d0-9786-c26d253631c9@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cOq1iLM9_n1_wf7MTGSBqaNjBLuFIQAe
X-Proofpoint-GUID: cOq1iLM9_n1_wf7MTGSBqaNjBLuFIQAe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-29_14,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=645 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2209300005
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/9/29 20:40, Krzysztof Kozlowski wrote:
> On 29/09/2022 14:15, Fenglin Wu wrote:
>> Add binding document for flash LED module inside Qualcomm Technologies,
>> Inc. PMICs.
>>
>> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> 
> Thank you for your patch. There is something to discuss/improve.
> 
>> +  reg:
>> +    description: address offset of the flash LED controller
>> +    maxItems: 1
>> +
>> +patternProperties:
>> +  "^led[0-3]$":
> 
> In such case: ^led-[0-9]$"
Sure, I will update in next patchset
> 
>> +    type: object
>> +    $ref: common.yaml#
>> +    unevaluatedProperties: false
>> +    description: |
>> +      Represents the physical LED components which are connected to the
>> +      flash LED channels' output.
>> +
>> +    properties:
>> +      led-sources:
>> +        description: |
>> +          The HW indices of the flash LED channels that connect to the
>> +          physical LED
>> +        allOf:
>> +          - minItems: 1
>> +            maxItems: 2
>> +            items:
>> +              enum: [1, 2, 3, 4]
>> +
>> +      led-max-microamp:
>> +        description: |
>> +          The maximum current value when LED is not operating in flash mode (i.e. torch mode)
>> +          Valid values when an LED is connected to one flash LED channel:
>> +            5000 - 500000, step by 5000
>> +          Valid values when an LED is connected to two flash LED channels:
>> +            10000 - 1000000, step by 10000
>> +        minimum: 5000
>> +        maximum: 1000000
>> +
>> +      flash-max-microamp:
>> +        description: |
>> +          The maximum current value when LED is operating in flash mode.
>> +          Valid values when an LED is connected to one flash LED channel:
>> +            12500 - 1500000, step by 12500
>> +          Valid values when an LED is connected to two flash LED channels:
>> +            25000 - 2000000, step by 12500
>> +        minimum: 12500
>> +        maximum: 2000000
>> +
>> +      flash-max-timeout-us:
>> +        description: |
>> +          The maximum timeout value when LED is operating in flash mode.
>> +          Valid values: 10000 - 1280000, step by 10000
>> +        minimum: 10000
>> +        maximum: 1280000
>> +
>> +    required:
>> +      - led-sources
>> +      - led-max-microamp
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/leds/common.h>
>> +    spmi_bus {
> 
> No underscores in node names, so just "bus"
Sure, I will update in next patchset
> 
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
> 
> Best regards,
> Krzysztof
> 
