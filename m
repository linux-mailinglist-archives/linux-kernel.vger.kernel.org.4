Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D61974961D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 09:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbjGFHOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 03:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjGFHOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 03:14:35 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105E8DA;
        Thu,  6 Jul 2023 00:14:31 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3666wNlu017086;
        Thu, 6 Jul 2023 07:14:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=mLX9HctXLehaygJmhaZlpYlkmBKUpfbLQBN+iDU3ijs=;
 b=H+lmghvIN2SsWxNEcWGdyj/zVCgrSTFRHhK8Cf3S6pJPSP8SNOC9iCFiBumSIccOo3B5
 wsHfXv1NogLSBjpwgdqns379uNIZVT7vb/m6arKisdcmCYhZtCkpKxLZ08ZVcODcjg8G
 hH6j0wy7pj0g7dV+xMjeChWZH94/vsgkc4zDPD/9qZJz1f+FaeGMKrZtkAs/wD8j7a/y
 jUQBN0MKR093M5Jx+5JDDZfRehg57R7TNG+asNnvEnEy0g3dlcvxLFaLClt++wns0d89
 XYE0k4KwfTYOIQA6s2SWcMtddBH5TXfMGPzzQl9715I8k23/EnACLRzFccEnHkCdeaTM Rg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rnb5a1gfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 07:14:15 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3667EEQw024648
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Jul 2023 07:14:14 GMT
Received: from [10.50.21.118] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 6 Jul
 2023 00:14:09 -0700
Message-ID: <fb36e521-3715-5819-d27d-8fcc6cf9044c@quicinc.com>
Date:   Thu, 6 Jul 2023 12:43:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V7 1/2] dt-bindings: firmware: bootstats: Add the dtschema
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Arnd Bergmann" <arnd@arndb.de>
CC:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <cover.1688533340.git.quic_schowdhu@quicinc.com>
 <b3105990e021a71039f621e6c4e70ab05fb348fa.1688533340.git.quic_schowdhu@quicinc.com>
 <d339d413-5242-0d5a-96f6-c2f670e5e5dc@linaro.org>
 <968fb5d3-6cd8-7850-47e7-682e26f9ee5f@quicinc.com>
 <a0631800-f3d5-ff13-b316-9bc027275a82@linaro.org>
 <20230705193012.GA1642540-robh@kernel.org>
 <eceb14da-a839-8475-c416-bc694ecade30@linaro.org>
Content-Language: en-US
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <eceb14da-a839-8475-c416-bc694ecade30@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bXyKctS3or0ItCMX8z74jttHtJa9znD9
X-Proofpoint-ORIG-GUID: bXyKctS3or0ItCMX8z74jttHtJa9znD9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_04,2023-07-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxscore=0 impostorscore=0 priorityscore=1501 spamscore=0 mlxlogscore=902
 malwarescore=0 lowpriorityscore=0 clxscore=1011 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307060062
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/6/2023 2:44 AM, Dmitry Baryshkov wrote:
> On 05/07/2023 22:30, Rob Herring wrote:
>> On Wed, Jul 05, 2023 at 11:34:35AM +0200, Krzysztof Kozlowski wrote:
>>> On 05/07/2023 10:33, Souradeep Chowdhury wrote:
>>>>>> +    $ref: /schemas/types.yaml#/definitions/string-array
>>>>>> +
>>>>>> +  abl-time:
>>>>>> +    description: The property to store the duration of abl in ms.
>>>>>> +    $ref: /schemas/types.yaml#/definitions/string-array
>>>>>
>>>>> I have no clue what this entire binding is about. Nothing can bind to
>>>>> it, no usage explained. Properties are not used to "store the 
>>>>> duration".
>>>>> This does not look like suitable for DT, drop entire binding.
>>>>
>>>> This binding was created as per the suggestion on version 6 of the 
>>>> patch
>>>> by Arnd. The idea was that these 2 devicetree properties will be 
>>>> used to
>>>> populate the bootstat values from the bootloader and exposed to the 
>>>> user
>>>> via /sys/firmware/devicetree/ directly.
>>>>
>>>> Details in the link below:-
>>>>
>>>> https://lore.kernel.org/lkml/7d397e67-5d56-4975-98af-1ac9746c07f4@app.fastmail.com/T/#mbdc9ad95fcbb5ad7b56c6996a3933899b42d982c
>>>>
>>>> Can you suggest any alternative way to represent this as a binding?
>>>
>>> Then you should clearly state in the binding how this is going to be
>>> used and who is going to populate it. Not only in the binding but also
>>> in commit msg which currently has 0 rationale and answers to "why". Your
>>> commit msg explained only "what", which is usually obvious and much less
>>> important. Your commit should stand on its own and should clearly
>>> explain why we need this feature at all, what problem it solves.
>>>
>>> And before you claim that there is some discussion under link or some
>>> cover letter - these do not matter. Commit and bindings matter.
>>>
>>> What's more, I don't think that Arnd's advice is correct here - DT is
>>> suppose to describe hardware or firmware. These properties are coming
>>> from firmware but they are not describing any firmware or hardware
>>> characteristics. Instead they are debugging of current boot status.
>>>
>>> I will leave the decision on that for Rob, however anyway binding is
>>> very vague and incorrect, so I would expect he will come with the same
>>> concerns regardless whether it is suitable to DT or is not.
>>
>> My main concern here is not so much having this info in DT, but whether
>> it's just the start of various properties. Either because there's already
>> more data and these are just the 2 things you care about now, or because
>> once we enable this it's an invitation to add more properties.
>>
>> Boot timing information seems like something multiple platforms might
>> want and only having 2 stages isn't extensible.
> 
> I preferred the previous implementation idea, where the Linux driver 
> will parse firmware data, instead of bootloader doing something for us.
> 
> Not to mention that that approach would allow us to get boot time stats 
> on older platforms, without waiting (indefinitely) for the platform 
> vendor to update the bootloader.
> 
>>
>> Rob

Hi Rob/Krzysztof/Arnd,

We will work on describing the bindings better but can you first give us
clarity on whether this is something that should be represented on the
devicetree and what should be the final approach we need to take for 
boot_stats?

Thanks,
Souradeep

> 
