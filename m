Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96286EB580
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 01:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbjDUXFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 19:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjDUXFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 19:05:09 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99689199C;
        Fri, 21 Apr 2023 16:04:27 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33LIRNIs004938;
        Fri, 21 Apr 2023 22:34:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=jeGlkw5gJxY8LeFKFsrGNoaeLUZFgmLH/75tUIN35v8=;
 b=NUOm2oSS2d0mTF/xBmeqoJavwLmr58hghptaP+PMUmSDztvudlkL/XX+uf/gt3h2NjKF
 DX5ddPxvQ9vAA8G/eRnMElvySewBNkvz4eNDd8Az9m+EIopPbIkVKBMq2QtYw4lfMq54
 qrilwhTe4fPgcjwQ35bnwfaiLE+gL35vyCq1QvznGbKNR0FIbxroNRUgEW2+j/Uk/eSh
 lrmDyQoQQEqDBmp3IpxM0rkJWf5OVqHmGD8iiWVm7pGY/N5IbD4zyBG+gkqGJhqVBSJb
 A1qUJ64Oq+G9aahg7FUtMhsC+rDphXNrGFpZcrk+ZomZ520zLpPHHNPW7zs9dYPnrkVw YQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q3tmqs8tr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Apr 2023 22:34:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33LMYeIa009963
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Apr 2023 22:34:40 GMT
Received: from [10.110.74.190] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 21 Apr
 2023 15:34:39 -0700
Message-ID: <b6d56e50-fb5b-1d59-7b39-a3ca2a0a8d83@quicinc.com>
Date:   Fri, 21 Apr 2023 15:34:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 0/2] DPU1 GC1.8 wiring-up
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>
CC:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20230420-topic-dpu_gc-v1-0-d9d1a5e40917@linaro.org>
 <5b133c55-e4f5-bfd2-b542-a7d44313c038@linaro.org>
 <c0e0a55a-cc37-fe8a-8d8a-5fe257f99b9a@linaro.org>
 <3f3b3637-ed85-09a1-22b7-3ccd4bc929bb@quicinc.com>
 <2dff9d62-cffe-c66f-9e50-3ecd64e44d37@linaro.org>
 <6a335df7-ff0b-098a-feec-45714159df04@linaro.org>
 <b134d09c-55fa-7879-80ff-900e39c20c3d@quicinc.com>
 <0f469b3c-5f0f-e027-8a9f-d1233169c04a@linaro.org>
 <57pxyxwluu33z4lpij5gx7biwfo5pbhdalhhxflw7esi5n3vts@qhjb7ldnz3wb>
 <0bba90c1-01be-a76e-df12-2328b84f7298@linaro.org>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <0bba90c1-01be-a76e-df12-2328b84f7298@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: diuQiLKSbCDqRmbpEeI7qcM-43Q9AjrE
X-Proofpoint-ORIG-GUID: diuQiLKSbCDqRmbpEeI7qcM-43Q9AjrE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-21_08,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=945 spamscore=0 adultscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304210197
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/20/2023 3:52 PM, Dmitry Baryshkov wrote:
> On 20/04/2023 22:56, Marijn Suijten wrote:
>> On 2023-04-20 22:51:22, Dmitry Baryshkov wrote:
>>> On 20/04/2023 22:47, Abhinav Kumar wrote:
>>>>
>>>>
>>>> On 4/20/2023 11:01 AM, Dmitry Baryshkov wrote:
>>>>> On 20/04/2023 04:36, Konrad Dybcio wrote:
>>>>>>
>>>>>>
>>>>>> On 20.04.2023 03:28, Abhinav Kumar wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 4/19/2023 6:26 PM, Konrad Dybcio wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 20.04.2023 03:25, Dmitry Baryshkov wrote:
>>>>>>>>> On 20/04/2023 04:14, Konrad Dybcio wrote:
>>>>>>>>>> Almost all SoCs from SDM845 to SM8550 inclusive feature a GC1.8
>>>>>>>>>> dspp sub-block in addition to PCCv4. The other block differ a bit
>>>>>>>>>> more, but none of them are supported upstream.
>>>>>>>>>>
>>>>>>>>>> This series adds configures the GCv1.8 on all the relevant SoCs.
>>>>>>>>>
>>>>>>>>> Does this mean that we will see gamma_lut support soon?
>>>>>>>> No promises, my plate is not even full, it's beyond overflowing! :P
>>>>>>>>
>>>>>>>> Konrad
>>>>>>>
>>>>>>> So I think I wrote about this before during the catalog rework/fixes
>>>>>>> that the gc registers are not written to / programmed.
>>>>>>>
>>>>>>> If thats not done, is there any benefit to this series?
>>>>>> Completeness and preparation for the code itself, if nothing else?
>>>>>
>>>>> The usual problem is that if something is not put to use, it quickly
>>>>> rots or becomes misused for newer platforms. We have seen this with
>>>>> the some of DPU features.
>>>>>
>>>>> In case of GC (and the freshly defined DPU_DSPP_IGC, but not used) we
>>>>> have three options:
>>>>> - drop the unused GC from msm8998_sblk.
>>>>> - keep things as is, single unused GC entry
>>>>> - fill all the sblk with the correct information in hope that it stays
>>>>> correct
>>>>>
>>>>> Each of these options has its own drawbacks. I have slight bias
>>>>> towards the last option, to have the information in place (as long as
>>>>> it is accurate).
>>>>>
>>>>
>>>> My vote is for (1) . Today, GC is unused and from the discussion here,
>>>> there is no concrete plan to add it. If we keep extending an unused
>>>> bitmask for all the chipsets including the ones which will get added in
>>>> the future in the hope that someday the feature comes, it doesnt sound
>>>> like a good idea.
>>>>
>>>> I would rather do (1), if someone has time.
>>>
>>> Agree, this was the second item on my preference list. Could you please
>>> send this oneliner?
>>
>> Nit (to make sure we're on the same thought here): I think it's a
>> 3-liner: remove it from DSPP_MSM8998_MASK as well as msm8998_dspp_sblk.
>>
>>>> OR lets stay at (2) till
>>>> someone does (1).
>>
>> I'm personally okay leaving it in place too, with an eye on implementing
>> this, IGC, and other blocks at some point if there's a use for it via
>> standard DRM properties.
> 
> I took a quick glance. I think it is possible, but not straightforward. 
> But I must admit here, I don't have a full picture regarding different 
> color encodings, ranges and the rest of gamma/degamma API and usage.
> 

I think its easier to remove this now and then add it when we add the 
support. As discussed, will post this shortly.

Otherwise, whenever any new chipset gets added, we will run into the 
same question of whether to add GC or not.

>>
>>>> When someone implements GC, we can re-use this patch and that time keep
>>>> konrad's author rights or co-developed by.
>>
>> Good to at least know all these SoCs have the same offset and revision.
>>
>> - Marijn
> 
