Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88806DCA0A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 19:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjDJReG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 13:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjDJReE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 13:34:04 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E6A1BF3;
        Mon, 10 Apr 2023 10:34:03 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33AFqbZn017675;
        Mon, 10 Apr 2023 17:33:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=sb6jpc0KNTLDv897qIhEwyKHMSgx7o9THMFXo2oD9bU=;
 b=dxGZsF62iaLppBkOy6SOUJELTdCvaPly5rVhisdckfB3Gc/dwgAJ8zGLulvP0Prbn6fM
 l5O1rm9zkhlXMekbQpqwNDji8IdPGrumaHaCyEovpwwkJcttosz4uujfLvtTpEI9Gehr
 moixAK/Sq5rY7ab9635XOZyzGa0F5Hhgig6NvGfjobGGKMH1wgWZdCSFfTikio/LQNXV
 /yvMeTSw/ifdNyy52SXD35v73R+exi9farghvxMx+jAxwF7kFTAKSapMAnWQIjHBcZnr
 EZM+FO/4stKpzUL36nYbEFYpkjOAiXIcpqHvEGh+60/kT/0BvKOWx3OJg9ykfUWOPSDG Dg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pvmnagd0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 17:33:54 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33AHXrs1030256
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 17:33:53 GMT
Received: from [10.110.88.83] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 10 Apr
 2023 10:33:53 -0700
Message-ID: <74551421-56df-73d3-3f4d-1708768e207a@quicinc.com>
Date:   Mon, 10 Apr 2023 10:33:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/2] dt-bindings: firmware: arm,scmi: support parameter
 passing in smc/hvc
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <sudeep.holla@arm.com>
CC:     <cristian.marussi@arm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230409181918.29270-1-quic_nkela@quicinc.com>
 <20230409181918.29270-2-quic_nkela@quicinc.com>
 <5d264f46-b9e8-62ec-9bce-9d666fd1eaa8@linaro.org>
From:   Nikunj Kela <quic_nkela@quicinc.com>
In-Reply-To: <5d264f46-b9e8-62ec-9bce-9d666fd1eaa8@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Yz9HcfcsfpGN7L2DzyzCAtch_uGvDWY1
X-Proofpoint-GUID: Yz9HcfcsfpGN7L2DzyzCAtch_uGvDWY1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-10_12,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=984
 impostorscore=0 adultscore=0 phishscore=0 clxscore=1011 lowpriorityscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304100151
X-Spam-Status: No, score=-4.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/10/2023 10:20 AM, Krzysztof Kozlowski wrote:
> On 09/04/2023 20:19, Nikunj Kela wrote:
>> Currently, smc/hvc calls are made with smc-id only. The parameters are
>> all set to zeros. This patch defines two optional device tree bindings,
>> that can be used to pass parameters in smc/hvc calls.
>>
>> This is useful when multiple scmi instances are used with common smc-id.
>>
>> Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
>> ---
>>   .../devicetree/bindings/firmware/arm,scmi.yaml   | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
>> index 5824c43e9893..08c331a79b80 100644
>> --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
>> +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
>> @@ -115,6 +115,22 @@ properties:
>>       description:
>>         SMC id required when using smc or hvc transports
>>   
>> +  arm,smc32-params:
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    description:
>> +      An optional parameter list passed in smc32 or hvc32 calls
>> +    default: 0
>> +    minItems: 1
>> +    maxItems: 6
>> +
>> +  arm,smc64-params:
>> +    $ref: /schemas/types.yaml#/definitions/uint64-array
>> +    description:
>> +      An optional parameter list passed in smc64 or hvc64 calls
>> +    default: 0
>> +    minItems: 1
>> +    maxItems: 6
> These do not look like hardware properties and the fact that you need
> two properties for the same also points that you tied it to specific SW
> interface.

This is certainly not the H/W property but then smc-id is also not H/W 
property either

but that gets passed via DTB. I could use the same property for both 
however I wasn't sure

which datatype should be used, uint32-array/uint64-array. Moreover, I 
thought if users are

passing parameters, they better know which SMC convention they are using 
hence used two

explicit properties.

> Why this should be board-specific? Actually better question - why this
> should be fixed per board? Doesn't my software want to have different
> parameters, depending on some other condition?

Not sure I follow, I didn't say this is board specific. People can use 
the parameters to pass

whatever their S/W demands. SMC/HVC calls are made by passing parameters 
which is what this patch is enabling.

>
> You also did not provide any DTS user for this, so difficult to judge
> usefulness.

The work is still on going and we will push the dts in few months, 
however that shouldn't stop

making changes in advance.

> Best regards,
> Krzysztof
>
