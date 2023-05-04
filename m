Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB496F76D3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 22:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjEDUS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 16:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbjEDUSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 16:18:30 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655C720743;
        Thu,  4 May 2023 13:04:29 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344Jj7Vf025862;
        Thu, 4 May 2023 20:03:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=faCqG69qLyLkXNye9eJMNdCtp6uyP6oT4gzqngATrec=;
 b=eq1yNutC0JmmZKW0YoVrypbffkMclIMUN7xMUkKZg5zN/4Qsy44ibp9K7OoAe4I/GdKY
 CNXlUX1NnoIQtNTS3xlQqxdU9/k8V8+LfEC5lAB6o6f9s2CHfJ5nnVloWDkeG/chskEs
 Tcm2YYWgvY+20ooOXLPCbCyXOT5vtB/+b0ffmEWMTo7CMWbi0jk9Gh0+eezDCIsqy4Bj
 UKUzetmJicGbIKinARjKd9ZmA+hZeHCAYf11ooUqhFxfZUXFoG0+PB0CQNrly101tA83
 Z/9ympe2YsyHo7qfzwAhurarhW6ZWZN6H34pDIfyY3o4DbRKovYbCKy57+3kxwlVkbIj Yg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qc652j1fb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 May 2023 20:03:03 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 344K32qA004827
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 4 May 2023 20:03:02 GMT
Received: from [10.134.70.142] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 4 May 2023
 13:03:01 -0700
Message-ID: <85397bfb-a2d8-856d-c747-f303b8e1d598@quicinc.com>
Date:   Thu, 4 May 2023 13:03:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v5 3/7] drm/msm/dpu: add DPU_PINGPONG_DSC bits into PP_BLK
 and PP_BLK_TE marcos
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>
CC:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@gmail.com>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <quic_sbillaka@quicinc.com>, <freedreno@lists.freedesktop.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1683218805-23419-1-git-send-email-quic_khsieh@quicinc.com>
 <1683218805-23419-4-git-send-email-quic_khsieh@quicinc.com>
 <ljt5mp4ew5lcrrrdd7xyof3jv3friafbmr3im35ddwxjc42ekh@toez7xfdreg2>
 <CAA8EJpreM9i3DUp+93K7p14f_tNMy-m+C-WdyN5_drmmkGV66g@mail.gmail.com>
 <u7hlzltevx675gfg4w6emmeceo6nj76taqeecsor6iqsi3hmki@lg43y65m6chz>
 <11ef769a-5089-57d4-db87-4c5766d98206@quicinc.com>
 <6qg25ffuq6xcfz3vuqm5lguspihjospctjclxmwyu2ifau4p7b@txywjmir7lg5>
 <9011a078-9962-b3de-6427-b9114fcd0cf4@quicinc.com>
 <06864435-3db9-a91c-2e99-69829d8296b1@linaro.org>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <06864435-3db9-a91c-2e99-69829d8296b1@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pw0kleZpK45N4rfOhAvW4dqBBZydbELg
X-Proofpoint-ORIG-GUID: pw0kleZpK45N4rfOhAvW4dqBBZydbELg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_13,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 clxscore=1015 spamscore=0
 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305040162
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/4/2023 12:59 PM, Dmitry Baryshkov wrote:
> On 04/05/2023 22:50, Abhinav Kumar wrote:
>>
>>
>> On 5/4/2023 12:36 PM, Marijn Suijten wrote:
>>> On 2023-05-04 11:25:44, Abhinav Kumar wrote:
>>> <snip>
>>>>> Sure, if you really prefer a split I'd go for two patches:
>>>>> 1. Add the flag to the enum and catalog;
>>>>> 2. Add the ops guard (functional change).
>>>>>
>>>>> Then don't forget to reword the commit message, following the 
>>>>> guidelines
>>>>> below and the suggestion for 2/7.
>>>>>
>>>>> - Marijn
>>>>
>>>> Plan sounds good to me.
>>>>
>>>> Marijn, we will wait for a couple of days to post the next rev but 
>>>> would
>>>> be hard more than that as we need to pick up other things which are
>>>> pending on top of this. Hence would appreciate if you can finish 
>>>> reviews
>>>> by then.
>>>
>>> It depends on how many more revisions are needed after that, and not all
>>> patches in this series have an r-b just yet.  Given the amount of review
>>> comments that are still trickling in (also on patches that already have
>>> maintainer r-b) I don't think we're quite there to start thinging about
>>> picking this up in drm-msm just yet.  I doubt anyone wants a repeat of
>>> the original DSC series, which went through many review rounds yet still
>>> required multiple series of bugfixes (some of which were pointed out and
>>> ignored in review) to be brought to a working state.  But the split
>>> across topics per series already makes this a lot less likely, many
>>> thanks for that.
>>>
>>
>> I think the outstanding comments shouldnt last more than 1-2 revs more 
>> on this one as its mostly due to multiple patches on the list touching 
>> catalog at the same time. I have been monitoring the comments closely 
>> even though I dont respond to all of them.
>>
>> One of the major reasons of the number of issues with DSC 1.1 was QC 
>> didn't really have the devices or panels to support it. Thats why I 
>> changed that this time around to take more control of validation of 
>> DSC 1.2 and ofcourse decided to break up of series into the least 
>> amount of functionality needed to keep the DPU driver intact.
>>
>> All that being said, we still value your comments and would gladly 
>> wait for a couple of days like I already wrote. But there are more 
>> incremental series on top of this:
>>
>> -> DSI changes for DSC 1.2
>> -> proper teardown for DSC
>> -> DSC pair allocation support
>> -> DSC 1.2 over DP
>>
>> We will be posting all of these within next couple of weeks on top of 
>> this.
> 
> I'd say, it's fine to post them now, as we have more or less agreed on 
> the helper series. The interface between the series should be stable then.
> 
> The RM series is probably the one having bigger dependencies/conflicts 
> on other pending patches (include virtual wide planes)
> 

1 is already posted, will keep fixing review comments
2 will be posted pretty soon

DSC1.2 over DSI will be complete with this set.

I will finish up virtual planes review by early next week. Already 
underway ...

3 & 4 will be posted soon after that.

>>
>>> In other words, let's take it slow and do things properly this time. And
>>> who knows, perhaps the rest of these patches are more straightforward.
>>>
>>
>> Ack. the intent is always to do things right the first time.
>>
>>> - Marijn
>>>
>>> <snip>
> 
