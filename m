Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5828E6DDE6A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjDKOrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjDKOrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:47:16 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F393F46A4;
        Tue, 11 Apr 2023 07:47:11 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33BE2Iik009257;
        Tue, 11 Apr 2023 14:47:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=DjAxUSREyJj7mk7FGGKTrCPCCgnd97HR7lLcbjUckpo=;
 b=LZzc4wiapBQQdCZoe/ZBtQsP177sFaRWOuLe6Kj1rYt9U+CMUF/mMA6+TJJJe7s78/VH
 njYsVops/ImRtLklpSUrWcxYez2GEKB/IIavuWbu6k83M3RddqT266/eAfmyDmMqIYPD
 03suRouFHewtUJCUdDeJGVH1Mofc7jzFcmAXPHVja+WNE81SWgzLqDdzlHmXAI8k/Uzz
 Gwsf4WFvc6mBLCyLshK4Aj8WlMU2qLZXexhwh5WHbKELrw5Annk1r0+7k/okhAo4a3Vs
 YPY5CI2EDdgJC3Wq/vB9KB6dTYIT6a67MaFeUWQxQcZZiRUDhetgaJEisXaHyClaapKN fA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pw6kegc96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 14:46:28 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33BEkRU4003342
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 14:46:27 GMT
Received: from [10.110.88.83] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 11 Apr
 2023 07:46:26 -0700
Message-ID: <c5eb5f78-00a7-58d5-4b09-7b6aaf929b56@quicinc.com>
Date:   Tue, 11 Apr 2023 07:46:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 1/2] dt-bindings: firmware: arm,scmi: support parameter
 passing in smc/hvc
Content-Language: en-US
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     <cristian.marussi@arm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lkp@intel.com>
References: <20230409181918.29270-1-quic_nkela@quicinc.com>
 <20230410182058.8949-1-quic_nkela@quicinc.com>
 <20230410182058.8949-2-quic_nkela@quicinc.com>
 <20230411125420.lymhjf5chxdr7if7@bogus>
From:   Nikunj Kela <quic_nkela@quicinc.com>
In-Reply-To: <20230411125420.lymhjf5chxdr7if7@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aVZyz1pkZwFVnEggZncuKbx4cTUhOMWt
X-Proofpoint-ORIG-GUID: aVZyz1pkZwFVnEggZncuKbx4cTUhOMWt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_10,2023-04-11_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304110135
X-Spam-Status: No, score=-3.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/11/2023 5:54 AM, Sudeep Holla wrote:
> On Mon, Apr 10, 2023 at 11:20:57AM -0700, Nikunj Kela wrote:
>> Currently, smc/hvc calls are made with smc-id only. The parameters are
>> all set to zeros. This patch defines two optional device tree bindings,
>> that can be used to pass parameters in smc/hvc calls.
>>
> Why 2 values ?

I can do with one property if you prefer that. Its just I wanted to 
ensure that whosoever is setting

the parameter list, is mindful of 32bit vs 64bit convention. If we use 
one property, do you propose to add a new property like width to specify 
if the  parameter list is for 32bit vs 64bit?

>> This is useful when multiple scmi instances are used with common smc-id.
>>
> I really would like to avoid this binding. Because of lack of standard
> SMC/HVC FID for SCMI we had to add this binding. Extending for newer use
> case like this in a vendor specific way is something I would like to avoid.
If you have a solution to get rid of FID from DTB node, I will follow 
the same however until that happens, my view is that we put the 
parameters in dtb.
>
>> Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
>> ---
>>   .../devicetree/bindings/firmware/arm,scmi.yaml | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
>> index 5824c43e9893..ecf76b763c8c 100644
>> --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
>> +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
>> @@ -115,6 +115,23 @@ properties:
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
>> +      An optional parameter list passed in smc64 or hvc64 calls.
>> +      This is valid only on ARM64 machines.
>> +    default: 0
>> +    minItems: 1
>> +    maxItems: 6
>> +
> Even if we end up adding(which I would very much like to avoid), I don't see
> the need for 32 and 64 bit params like this. There must be ways to avoid that
> used by some property in some other binding(I will look for one if we choose
> this path)
>
