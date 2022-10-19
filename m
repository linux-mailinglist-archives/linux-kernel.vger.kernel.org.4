Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7A86039A2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 08:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiJSGO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 02:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiJSGOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 02:14:52 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E242AC4C;
        Tue, 18 Oct 2022 23:14:48 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29J3ZQvu013169;
        Wed, 19 Oct 2022 06:14:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=HZGCd51g7jqRcgVQSQP5FkQhvHWeGjO8TyvdKeQhDAc=;
 b=lbGYMPYBMG1Q3cBigXQxmsZk7nywvS32hhlVbsRZ2kW7Vn8eQky1OBLdpB+tIkrh2Lv6
 0/pmoBzc7oQRXsIMRwSX9O7fXskNMz49c7T5EBmvnTxZm79PoyyWZQSWhezmx/LpK8o9
 TptfiFZIgbMkDG4g3UAbhhGjjb9j+q4Q2LJRf2xxaVxnNXL4itArZqCQFxyNxjw/zreo
 91CnRYHO/FjNtOpUN5LQUTFBVf/ZIJYKrWW20b7HT61K+KQSBL7JsZuNr1++JDj54VJA
 E9F9QQNMfkO9wa5wefXC/MWqzXfYWaOGIF+AmRzGZ87Y+CoaiKnXsRg4ktxiywVMjIaW rw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ka5emgtjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 06:14:39 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29J6EXHY019572
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 06:14:38 GMT
Received: from [10.79.43.230] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 18 Oct
 2022 23:14:30 -0700
Subject: Re: [PATCH V3 1/2] dt-bindings: firmware: qcom-scm: Add optional
 interrupt
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>
CC:     <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <konrad.dybcio@somainline.org>, <robimarko@gmail.com>,
        <quic_gurus@quicinc.com>, <quic_rjendra@quicinc.com>
References: <1666086406-5452-1-git-send-email-quic_sibis@quicinc.com>
 <1666086406-5452-2-git-send-email-quic_sibis@quicinc.com>
 <12d79669-6e8c-6cf8-2e32-d4e0e2e42f3d@linaro.org>
From:   Sibi Sankar <quic_sibis@quicinc.com>
Message-ID: <2464d90f-64e9-5e3c-404b-10394c3bc302@quicinc.com>
Date:   Wed, 19 Oct 2022 11:44:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <12d79669-6e8c-6cf8-2e32-d4e0e2e42f3d@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dPXnPkqHIYutBVpFKx656VxTrZ69Niiq
X-Proofpoint-GUID: dPXnPkqHIYutBVpFKx656VxTrZ69Niiq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_02,2022-10-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 malwarescore=0 clxscore=1015 phishscore=0 mlxscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2210190034
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Krzysztof,
Thanks for taking time to review the series.

On 10/18/22 10:41 PM, Krzysztof Kozlowski wrote:
> On 18/10/2022 05:46, Sibi Sankar wrote:
>> From: Guru Das Srinagesh <quic_gurus@quicinc.com>
>>
>> Add an interrupt specification to the bindings to support the wait-queue
>> feature.
>>
>> Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> ---
>>
>> The interrupt property for scm firmware from a binding perspective is
>> completely optional i.e. not all tz fw running in the wild on sm8450
>> devices support this feature. The bootloader does the interrupt property
>> addition on sm8450 devices with wait-queue support.
>>
>>   Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>> index c5b76c9f7ad0..6483d76b2371 100644
>> --- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>> +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>> @@ -71,6 +71,11 @@ properties:
>>     '#reset-cells':
>>       const: 1
>>   
>> +  interrupts:
>> +    description:
>> +      The wait-queue interrupt that firmware raises as part of handshake
>> +      protocol to handle sleeping SCM calls.
> 
> You still miss here constraints... nothing improved. Just look at other
> properties in this file.
> 
> maxItems:1
> 

Ack. Missed adding it in the re-spin.

-Sibi

> Best regards,
> Krzysztof
> 
