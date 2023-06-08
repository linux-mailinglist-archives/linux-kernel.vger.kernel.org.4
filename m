Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E883727CEF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 12:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235888AbjFHKhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 06:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbjFHKg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 06:36:57 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CAEE50;
        Thu,  8 Jun 2023 03:36:56 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3589lUGL014993;
        Thu, 8 Jun 2023 10:36:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Edq7Xk9eUqj7YUleFcCYdqe/KJkToJPND49yy+TrQXc=;
 b=LRoUy8eXwKdnfSH+I4ejOibInog1/55Xv6OIRj5R1EUK6oPhOqKvhDeo3aFwit/n5tBF
 b3Z3Ts8dLiHNOHJmM4LQBxsjD1PnfFgBWJwIMjzFxtzG6M/iOoqCavAZTy1f6SXrqioZ
 47OZT+vPNqGFrieH3viu/ufLbIxQX6Dx1iSYYkYMIZL4FbOINj7cHTBQaR8fSoDrQ/Nd
 4rjYQs4I8aAYUZnEW9nFeT8tY4Qs8SHy/E8F2G5NQBhAY2ZPwgv1SSiXo9vD94bW06wT
 aFoGhZJD01G6nxDtas95mgdeY5JlgDx4z4lELvIN07gxkxfq8ChZkFa8brpePyH6ulIX rg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r39ku8fek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 10:36:51 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 358AaoE8032763
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Jun 2023 10:36:50 GMT
Received: from [10.204.67.150] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 8 Jun 2023
 03:36:46 -0700
Message-ID: <ced52be4-d5eb-2dcb-ce8a-f737fbcab1b6@quicinc.com>
Date:   Thu, 8 Jun 2023 16:06:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RESEND PATCH v1 1/2] dt-bindings: misc: fastrpc: add fastrpc
 group IDs property
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC:     <ekangupt@qti.qualcomm.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>,
        <fastrpc.upstream@qti.qualcomm.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>
References: <1686155407-20054-1-git-send-email-quic_ekangupt@quicinc.com>
 <1686155407-20054-2-git-send-email-quic_ekangupt@quicinc.com>
 <44267461-e6f9-b549-a8eb-cba76384660b@linaro.org>
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
In-Reply-To: <44267461-e6f9-b549-a8eb-cba76384660b@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gX2Llp7bCF3GsLLXyH8Dm8uUaYpRovvR
X-Proofpoint-ORIG-GUID: gX2Llp7bCF3GsLLXyH8Dm8uUaYpRovvR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_07,2023-06-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306080090
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/8/2023 12:14 AM, Krzysztof Kozlowski wrote:
> On 07/06/2023 18:30, Ekansh Gupta wrote:
>> Add "qcom,fastrpc-gids" property to the list of optional properties.
>> This property contains the list of privileged group IDs which is
>> used to offload process to remote subsystem with increased privileges.
> 
> Why or when anyone would use this property?
> 
This property can be used for the use cases which requires prioritized 
access to remote subsystem resources.
>>
>> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
>> index 1ab9588..2a2124f 100644
>> --- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
>> +++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
>> @@ -57,6 +57,11 @@ properties:
>>         Virtual machine IDs for remote processor.
>>       $ref: "/schemas/types.yaml#/definitions/uint32-array"
>>   
>> +  qcom,fastrpc-gids:
>> +    description:
>> +      Group IDs for fastrpc.
> 
> You just pasted here property name. It does not help me to understand
> what's this. Explain in description.
> 
I'll add more details here when I re-submit the patch.
>> +    $ref: "/schemas/types.yaml#/definitions/uint32-array"
> 
> Drop quotes.
> 
> missing min/maxItems.
> 
I'll update this in v2. Thanks for reviewing.
>> +
>>     "#address-cells":
>>       const: 1
>>   
>> @@ -120,6 +125,7 @@ examples:
>>               qcom,glink-channels = "fastrpcglink-apps-dsp";
>>               label = "sdsp";
>>               qcom,non-secure-domain;
>> +            qcom,fastrpc-gids = <2908>
> 
> Eh, what does 2908 stands for? Why not 3012 or 1842? How anyone can
> figure this out?
> 
There is no hard restriction for this value to be 2908, it can be 
anything. Just that the process which needs a privileged offload to any 
remote subsystem should have the same gid which is defined here, whether 
it is 2908 or anything else.

The intention of having 2908 in example is because this is used in 
Android world where any process running with 2908 gid can offload as 
privileged process to remote subsystem.
Ref: 
https://review.lineageos.org/c/LineageOS/android_device_motorola_sm7250-common/+/305612/4/config.fs

But, it can be set to anything just that the process also needs to adapt 
to this gid.

Thanks,
Ekansh
> Best regards,
> Krzysztof
> 
