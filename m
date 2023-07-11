Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9BD74EA72
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 11:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjGKJ1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 05:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbjGKJ1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:27:16 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4804358A;
        Tue, 11 Jul 2023 02:24:57 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36B6VOsf013796;
        Tue, 11 Jul 2023 09:24:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=V5+HNEaa10lBytqCxWCDT4npbHtAD8PAf9KdIhNAyGQ=;
 b=Ltdy2EojcDv7xNJ4mkqtWg6DLRJk9IVgJ/CrQABKlvdAzo/1pKz3BR1h/kLZs4P0EXcY
 YD7Lh0yD2C4Jhc8elT8qPozK9LlSMchPCPzDB0Jh+t5EhPiCzs8VxInRwKTWKDbwP2z+
 7MsIMqsc5OL0G/HbDFxJNRsNoLRLk72sDcc3XSa8ARk8jGVh0cbo1zJMxTe2HhRs19Zn
 L8Hqxhz9LFhNZC+iXi0wEFdBP9XJSHPE1balyQCoabrITFIgOEcvMEv1QvNixDRZuTiI
 TltVWygb984fxsmP0ciFMsYWuYbti28DHseE2FKtsjFvSVPjBzcLWcfk3Nypv1yusG8x bQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rs1mnrcgm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 09:24:44 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36B9OhO5030819
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 09:24:43 GMT
Received: from [10.201.3.91] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 11 Jul
 2023 02:24:37 -0700
Message-ID: <d614f142-7da2-50bf-36a1-11939c2c8189@quicinc.com>
Date:   Tue, 11 Jul 2023 14:54:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/6] dt-bindings: thermal: tsens: Add ipq5332 compatible
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <amitk@kernel.org>,
        <thara.gopinath@gmail.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_varada@quicinc.com>
References: <20230710103735.1375847-1-quic_ipkumar@quicinc.com>
 <20230710103735.1375847-4-quic_ipkumar@quicinc.com>
 <5f65d487-4692-0e94-a79a-82c663317ec7@linaro.org>
From:   Praveenkumar I <quic_ipkumar@quicinc.com>
In-Reply-To: <5f65d487-4692-0e94-a79a-82c663317ec7@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: AvZsd98ROINbctcSMqjEiRdMsMislNMp
X-Proofpoint-GUID: AvZsd98ROINbctcSMqjEiRdMsMislNMp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_04,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 adultscore=0 spamscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110083
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/11/2023 1:36 AM, Krzysztof Kozlowski wrote:
> On 10/07/2023 12:37, Praveenkumar I wrote:
>> IPQ5332 uses TSENS v2.3.3 with combined interrupt. RPM is not
>> available in the SoC, hence adding new compatible to have the
>> sensor enablement and calibration function.>
>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>> index 8b7863c3989e..ee57713f6131 100644
>> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>> @@ -68,8 +68,10 @@ properties:
>>             - const: qcom,tsens-v2
>>   
>>         - description: v2 of TSENS with combined interrupt
>> -        enum:
>> -          - qcom,ipq8074-tsens
>> +        items:
> Drop items, you do not have multiple items.
Sure, will drop items.
>
>
>> +          - enum:
>> +              - qcom,ipq8074-tsens
>> +              - qcom,ipq5332-tsens
> Keep the order.
>>   
>>         - description: v2 of TSENS with combined interrupt
>>           items:
>> @@ -289,6 +291,7 @@ allOf:
>>             contains:
>>               enum:
>>                 - qcom,ipq8074-tsens
>> +              - qcom,ipq5332-tsens
> And here
>
>>       then:
>>         properties:
>>           interrupts:
>> @@ -304,6 +307,7 @@ allOf:
>>             contains:
>>               enum:
>>                 - qcom,ipq8074-tsens
>> +              - qcom,ipq5332-tsens
> And here.

Sure, will keep the order.

--
Thanks,
Praveenkumar
>
>>                 - qcom,tsens-v0_1
>>                 - qcom,tsens-v1
>>                 - qcom,tsens-v2
> Best regards,
> Krzysztof
>
