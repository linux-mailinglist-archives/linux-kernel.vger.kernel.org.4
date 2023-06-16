Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8F6733B6C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 23:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbjFPVNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 17:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjFPVNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 17:13:47 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E91269E;
        Fri, 16 Jun 2023 14:13:46 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35GKfvks016757;
        Fri, 16 Jun 2023 21:13:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=uR+SNAkJbj1QDZwzjPgC/E/tG38NohmJjBkeQBo3GiM=;
 b=KLdtJ9HRGNAP9Xg7YKROFpZBIbS1noZuo0pZqmCfE3uKUF82KIJoUn6ulYvB9hF483mT
 IpvS7qVzTZrZ1fniqANSZoABHN5U7HqpF9msLNsOrmQv9ZbN7nmkN6fyTkCk1NxtPiKG
 CSvRhfOJll/7DdJeVIzS2RZ1qJy0xAQa+LjfnWrGte/if9IhthubE1ZPGlYFlK8N9wQh
 ilQVx+E+8zA7do/dA/XgG8aFufAiurCuQaubW87zmueTUvhT79+LDoGxB8oXHi0EJyY+
 UGfwgRMS2JMpJvkzVoposTb73QEjXH3LMx8pvCz9JAHpnjGyqo4jbhLNU+y/zOGE531g Uw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r8g2ya329-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jun 2023 21:13:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35GLDf2Y012031
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jun 2023 21:13:41 GMT
Received: from [10.110.47.14] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 16 Jun
 2023 14:13:24 -0700
Message-ID: <72963004-cda9-c5e1-68f9-622cb70fff9b@quicinc.com>
Date:   Fri, 16 Jun 2023 14:13:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Freedreno] [PATCH 1/3] drm/msm/dpu: Add DPU_INTF_DATABUS_WIDEN
 feature flag for DPU >= 5.0
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>
CC:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <freedreno@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        "Jessica Zhang" <quic_jesszhan@quicinc.com>,
        Sean Paul <sean@poorly.run>
References: <20230525-add-widebus-support-v1-0-c7069f2efca1@quicinc.com>
 <20230525-add-widebus-support-v1-1-c7069f2efca1@quicinc.com>
 <wpjxrnhbcanbc5iatxnff25yrrdfrtmgb24sgwyo457dz2oyjz@e2docpcb6337>
 <f4fb042c-1458-6077-3c49-8cc02638b27c@linaro.org>
 <ycgei43x4kfmjk7g7gbeglehtiiinfbqmrjbdzcy56frxbtd2z@yk2f5kgrkbrt>
 <e23de804-060d-3278-5045-1ed03f0de80d@quicinc.com>
 <c5cfc132-effb-8269-ac5d-ed8c988d1a16@quicinc.com>
 <08b6aaf4-6edd-4f41-5d98-11ffc27e766e@quicinc.com>
 <udz5ij7g74zgnnwqw2q65idzzmiszhnvfieerw7izikgvotnkp@5tboohkd4t6t>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <udz5ij7g74zgnnwqw2q65idzzmiszhnvfieerw7izikgvotnkp@5tboohkd4t6t>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: FnuZhgLcYF2L1SvxlpCPnXW7TbFmJNlD
X-Proofpoint-GUID: FnuZhgLcYF2L1SvxlpCPnXW7TbFmJNlD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-16_14,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 phishscore=0 clxscore=1015 mlxscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306160192
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/14/2023 2:41 PM, Marijn Suijten wrote:
> On 2023-06-14 13:39:57, Abhinav Kumar wrote:
>> On 6/14/2023 12:54 PM, Abhinav Kumar wrote:
>>> On 6/14/2023 12:35 PM, Abhinav Kumar wrote:
>>>> On 6/14/2023 5:23 AM, Marijn Suijten wrote:
>>>>> On 2023-06-14 15:01:59, Dmitry Baryshkov wrote:
>>>>>> On 14/06/2023 14:42, Marijn Suijten wrote:
>>>>>>> On 2023-06-13 18:57:11, Jessica Zhang wrote:
>>>>>>>> DPU 5.x+ supports a databus widen mode that allows more data to be
>>>>>>>> sent
>>>>>>>> per pclk. Enable this feature flag on all relevant chipsets.
>>>>>>>>
>>>>>>>> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
>>>>>>>> ---
>>>>>>>>     drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 3 ++-
>>>>>>>>     drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h | 2 ++
>>>>>>>>     2 files changed, 4 insertions(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
>>>>>>>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
>>>>>>>> index 36ba3f58dcdf..0be7bf0bfc41 100644
>>>>>>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
>>>>>>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
>>>>>>>> @@ -103,7 +103,8 @@
>>>>>>>>         (BIT(DPU_INTF_INPUT_CTRL) | \
>>>>>>>>          BIT(DPU_INTF_TE) | \
>>>>>>>>          BIT(DPU_INTF_STATUS_SUPPORTED) | \
>>>>>>>> -     BIT(DPU_DATA_HCTL_EN))
>>>>>>>> +     BIT(DPU_DATA_HCTL_EN) | \
>>>>>>>> +     BIT(DPU_INTF_DATABUS_WIDEN))
>>>>>>>
>>>>>>> This doesn't work.  DPU 5.0.0 is SM8150, which has DSI 6G 2.3.  In the
>>>>>>> last patch for DSI you state and enable widebus for DSI 6G 2.5+ only,
>>>>>>> meaning DPU and DSI are now desynced, and the output is completely
>>>>>>> corrupted.
>>>>>
>>
>> I looked at the internal docs and also this change. This change is
>> incorrect because this will try to enable widebus for DPU >= 5.0 and DSI
>>   >= 2.5
>>
>> That was not the intended right condition as thats not what the docs say.
>>
>> We should enable for DPU >= 7.0 and DSI >= 2.5
> 
> That makes more sense, DSI 2.5 is SM8350 which has DPU 7.0.
> 
>> Is there any combination where this compatibility is broken? That would
>> be the strange thing for me ( not DPU 5.0 and DSI 2.5 as that was incorrect)
> 
> No clue if there are any interim SoCs...
> 
>> Part of this confusion is because of catalog macro re-use again.
> 
> Somewhat agreed.  SC7180 is a DPU 6.2 SoC, and for this mask to be used
> across DPU 5.x and above it should have been renamed to SM8150 and as
> suggested by Dmitry, have DPU_5_x_` as suffix.
> 
> As I've asked many times before, we should inline these masks (not just
> the macros) (disclaimer: haven't reviewed if Dmitry's series actually
> does so!).
> 

Yes it does inline it. I am halfway through that rework got stuck in one 
of the patches.

>> This series is a good candidate and infact I think we should only do
>> core_revision based check on DPU and DSI to avoid bringing the catalog
>> mess into this.
>>
>>>>> Tested this on SM8350 which actually has DSI 2.5, and it is also
>>>>> corrupted with this series so something else on this series might be
>>>>> broken.
>>>>>
>>>
>>> Missed this response. That seems strange.
> 
> No worries.  But don't forget to look at the comments on patch 2/3
> either.  Some of it is a continuation of pclk scaling factor for DSC
> which discussion seems to have ceased on.
> 
>>> This series was tested on SM8350 HDK with a command mode panel.
>>>
>>> We will fix the DPU-DSI handshake and post a v2 but your issue needs
>>> investigation in parallel.
>>>
>>> So another bug to track that would be great.
> 
> Will see if I can set that up for you!
> 

Now, it seems this is resolved so bug is not needed?

>>>>>>> Is the bound in dsi_host wrong, or do DPU and DSI need to communicate
>>>>>>> when widebus will be enabled, based on DPU && DSI supporting it?
>>>>>>
>>>>>> I'd prefer to follow the second approach, as we did for DP. DPU asks
>>>>>> the
>>>>>> actual video output driver if widebus is to be enabled.
>>>>>
>>>>
>>>> I was afraid of this. This series was made on an assumption that the
>>>> DPU version of widebus and DSI version of widebus would be compatible
>>>> but looks like already SM8150 is an outlier.
> 
> Fwiw SM8250 would have been an outlier as well :)
> 
>>>> Yes, I think we have to go with second approach.
>>>>
>>>> DPU queries DSI if it supports widebus and enables it.
>>>>
>>>> Thanks for your responses. We will post a v2.
> 
> No hurry, btw.  As alluded to above, let's also look at the comments on
> patch 2/3 and discuss how this affects pclk.
> 
>>>>> Doesn't it seem very strange that DPU 5.x+ comes with a widebus feature,
>>>>> but the DSI does not until two revisions later?  Or is this available on
>>>>> every interface, but only for a different (probably DP) encoder block?
>>>>>
>>>>
>>>> Yes its strange.
>>>>
>>
>> I have clarified this above. Its not strange but appeared strange
>> because we were checking wrong conditions.
> 
> Hehe :)
> 
> - Marijn
