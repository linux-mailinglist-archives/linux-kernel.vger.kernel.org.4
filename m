Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F1D74EC32
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 13:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjGKLDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 07:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjGKLDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 07:03:25 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EEB97;
        Tue, 11 Jul 2023 04:03:25 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36BANSos006280;
        Tue, 11 Jul 2023 11:03:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=PjPkM5kjONLRkuqPYqLMNd9aEU9tenoe4s6lO9Yqbgc=;
 b=lgckSqvY/6Jl67N/hRsaS4stiQ8bK+sL3t+mbaSGurTQDCYFAXL7MS2sLiY5xkKP6/lj
 D41j5gHbf0HIKdqPUFo0F5IPnLpHpz81AyRCnlY8Y6o1xQo9UiivepNCDpM7qYJFde3v
 SetAW8LpJwXJRKQvWuCCXqlIypOvQVxJMONUWCw7v6UfUWV79yuiPuCvfgidMnbRdyC4
 IEnSSXcTkLdqCkIjZII5uGiQHdK+XZ6J7P40NyoEsWRaMEJgeMsWTfQe1IFR/qgCIX4i
 +4ygzqFO2f3HJ39+Q4rGEiLOhkhAg7kTj7m4rUhEUsDdqwarCw2Zy0XfDPlOPn95xC2W uA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rs5918221-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 11:03:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36BB3JMI012148
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 11:03:19 GMT
Received: from [10.201.2.96] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 11 Jul
 2023 04:02:44 -0700
Message-ID: <a3262be5-be66-661c-1feb-d663a057c2b2@quicinc.com>
Date:   Tue, 11 Jul 2023 16:32:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom,ids: drop the IPQ5019 SoC ID
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_saahtoma@quicinc.com>
References: <20230710105419.1228966-1-quic_kathirav@quicinc.com>
 <20230710105419.1228966-2-quic_kathirav@quicinc.com>
 <d752e5e0-3c34-02ad-6768-42eb2c66e582@linaro.org>
 <55e55042-5189-15cb-5b0f-4c7f321a4f61@linaro.org>
Content-Language: en-US
From:   Kathiravan T <quic_kathirav@quicinc.com>
In-Reply-To: <55e55042-5189-15cb-5b0f-4c7f321a4f61@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nz0umd8xe7o8q-MpPKcFCc5smIOijV6-
X-Proofpoint-ORIG-GUID: nz0umd8xe7o8q-MpPKcFCc5smIOijV6-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_05,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=659
 bulkscore=0 adultscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307110099
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/10/2023 5:40 PM, Konrad Dybcio wrote:
> On 10.07.2023 13:37, Krzysztof Kozlowski wrote:
>> On 10/07/2023 12:54, Kathiravan T wrote:
>>> IPQ5019 SoC is not available in production. Lets drop it.
>>>
>>> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
>>> ---
>>>   include/dt-bindings/arm/qcom,ids.h | 1 -
>>>   1 file changed, 1 deletion(-)
>>>
>>> diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
>>> index bcbe9ee2cdaf..179dd56b2d95 100644
>>> --- a/include/dt-bindings/arm/qcom,ids.h
>>> +++ b/include/dt-bindings/arm/qcom,ids.h
>>> @@ -250,7 +250,6 @@
>>>   #define QCOM_ID_QRU1000			539
>>>   #define QCOM_ID_QDU1000			545
>>>   #define QCOM_ID_QDU1010			587
>>> -#define QCOM_ID_IPQ5019			569
>> What about users of this binding? What's the impact on them? When did
>> the SoC become obsolete and unsupported by Qualcomm? Remember that
>> ceasing a production does not mean that magically all users of a product
>> disappear...
> This + from my experience, SOCID entries are set in stone and freed
> indices are never reclaimed


This SKU is planned but never productized. That's why I removed it.

May be I should be more precise in the commit title. Should I leave it 
as it is / remove it?


Thanks, Kathiravan T.

>
> Konrad
>>
>> Best regards,
>> Krzysztof
>>
