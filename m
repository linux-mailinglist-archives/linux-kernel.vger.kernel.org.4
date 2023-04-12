Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9716DF837
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 16:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjDLOS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 10:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjDLOS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:18:56 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB058449C;
        Wed, 12 Apr 2023 07:18:55 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33CA9KF5016590;
        Wed, 12 Apr 2023 14:18:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=A3rtY/+rMuLAW7o8CwDLtu8ApOMjjqatmbeuFdqpedY=;
 b=AKYnLl7YDsF9l68dMWFqfYcVbsRkE/6XdHlCzLp61Xm3bf+/97sFZ2cj0/iZNK8Vd9Iy
 bdLELIPqnfZpZ17QkbzIMwHpjAiuYw4EwhiQ17QOFIKHDikEYLfOIGyPdtKMWujR4Qai
 5k+HupWAcqCwVUjf/Gal/jcm0b5Oz6apFn+1d+9OghslRpgN8FWJDz6nCpPpnwomqBkG
 idx40wNf4hCq/Grul1+QZujN2R4WIml/MPyj5LyIdy+ClSB+WSzNVJ8MfpP7a9BYVFEP
 8HW1/QrD2sgR9MLPLZFlxwavEiEbJ2NgmtT6gdTEceU17KEdNu2wfY7U4t4qdCSolbxE Uw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pwchbt7m2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 14:18:44 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33CEIhUH010999
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 14:18:43 GMT
Received: from [10.50.1.100] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 12 Apr
 2023 07:18:38 -0700
Message-ID: <d53b793a-5e9d-071e-8842-d8c0845e22c1@quicinc.com>
Date:   Wed, 12 Apr 2023 19:47:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V2 1/3] dt-bindings: sram: qcom,imem: Add Boot Stat region
 within IMEM
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <cover.1680874520.git.quic_schowdhu@quicinc.com>
 <96601c1f9e433ef8fbc608d5ca09365b9c0d8132.1680874520.git.quic_schowdhu@quicinc.com>
 <e1f83f5f-c139-c1b2-5e42-00fce804e548@linaro.org>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <e1f83f5f-c139-c1b2-5e42-00fce804e548@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KSQ3ilWMLl3KT8oZJfN20uVn6w4_lnDb
X-Proofpoint-GUID: KSQ3ilWMLl3KT8oZJfN20uVn6w4_lnDb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_06,2023-04-12_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304120126
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/12/2023 1:45 PM, Krzysztof Kozlowski wrote:
> On 07/04/2023 16:04, Souradeep Chowdhury wrote:
>> All Qualcomm bootloaders log useful timestamp information related
>> to bootloader stats in the IMEM region. Add the child node within
>> IMEM for the boot stat region containing register address and
>> compatible string.
>>
>> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> ---
>>   .../devicetree/bindings/sram/qcom,imem.yaml         | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/sram/qcom,imem.yaml b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
>> index 665c06e..9998d65 100644
>> --- a/Documentation/devicetree/bindings/sram/qcom,imem.yaml
>> +++ b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
>> @@ -26,6 +26,7 @@ properties:
>>             - qcom,sdm845-imem
>>             - qcom,sdx55-imem
>>             - qcom,sdx65-imem
>> +          - qcom,sm8450-imem
>>         - const: syscon
>>         - const: simple-mfd
>>   
>> @@ -48,6 +49,26 @@ patternProperties:
>>       $ref: /schemas/remoteproc/qcom,pil-info.yaml#
>>       description: Peripheral image loader relocation region
>>   
>> +  "^boot-stat@[0-9a-f]+$":
> 
> Konrad,
> Just like for RPM Master stats, didn't we want to call these just "stats"?
> 
> https://lore.kernel.org/linux-arm-msm/20230405-topic-master_stats-v2-1-51c304ecb610@linaro.org
> 
>> +    type: object
>> +    description:
>> +      Imem region dedicated for storing timestamps related
>> +      information regarding bootstats.
> 
> Description is okay, but you ignored the rest.
> 
> This is a friendly reminder during the review process.
> 
> It seems my previous comments were not fully addressed. Maybe my
> feedback got lost between the quotes, maybe you just forgot to apply it.
> Please go back to the previous discussion and either implement all
> requested changes or keep discussing them.
> 
> Thank you.

Ack. Will be implemented in the next version.
> 
> 
> Best regards,
> Krzysztof
> 
