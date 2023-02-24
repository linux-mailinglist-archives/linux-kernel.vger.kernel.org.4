Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B726A23BE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 22:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjBXVZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 16:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjBXVZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 16:25:11 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94BF6F834;
        Fri, 24 Feb 2023 13:24:58 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31OL07tI014893;
        Fri, 24 Feb 2023 21:24:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=GfHJaRhya+SDZufxKLS9nYd7RFtea+RqedrXZU9xuc0=;
 b=cwH9SBUgtF83UBgnb14z6Oc5caAEAITM1bo50KbtGeo5fMlLiXjRhsVQVliWRhF7ZXD6
 D6mY78YWqn2zZDr/4URFvxzfFEwQMUHUCjHnDHJHROQif+TaaBVFbGPEA2zVh5O1U4+C
 0tatRU7mz1r0+wml/hwTcF8kZJNLoVizzbGVa5jRAd9/p9KaXU5h9r2NNWLp9vrNTnbL
 zFpL4HS5hPGBN6p8OE3hxHeOJW6uVO1Lo4mihyUmr0CcCAV+6ZJjhw6xQ7fB1H0sarNz
 NWn/2UCENhEKkPuQZsypahV1x5dIJAbugPxSbUw9cZJJR2us4mFqa19QrruyNfla6R0k Xg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ny0q58t12-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Feb 2023 21:24:50 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31OLOntU024471
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Feb 2023 21:24:49 GMT
Received: from [10.110.89.76] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 24 Feb
 2023 13:24:48 -0800
Message-ID: <5f8621a3-1043-c68a-e305-277ade14b939@quicinc.com>
Date:   Fri, 24 Feb 2023 13:24:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [RFC PATCH 2/2] drm/msm/dsi: use new
 dpu_dsc_populate_dsc_config()
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@gmail.com>,
        <agross@kernel.org>, <andersson@kernel.org>
CC:     <marijn.suijten@somainline.org>, <quic_sbillaka@quicinc.com>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <1677267647-28672-1-git-send-email-quic_khsieh@quicinc.com>
 <1677267647-28672-3-git-send-email-quic_khsieh@quicinc.com>
 <525078f5-44be-9a75-a737-ddcc6e097700@linaro.org>
 <21623a6d-7f83-5d2c-068c-f600a1834ac9@quicinc.com>
 <54004e9c-256c-15b2-9c55-8bd88ebb0c85@linaro.org>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <54004e9c-256c-15b2-9c55-8bd88ebb0c85@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: At_9zA-2OZsT7Njrp4IM0MNe2kh_yXt_
X-Proofpoint-ORIG-GUID: At_9zA-2OZsT7Njrp4IM0MNe2kh_yXt_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_16,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 clxscore=1015
 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302240169
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/24/2023 1:14 PM, Dmitry Baryshkov wrote:
> On 24/02/2023 23:09, Abhinav Kumar wrote:
>>
>>
>> On 2/24/2023 1:04 PM, Dmitry Baryshkov wrote:
>>> On 24/02/2023 21:40, Kuogee Hsieh wrote:
>>>> use new introduced dpu_dsc_populate_dsc_config() to calculate
>>>> and populate drm_dsc_info instead of hard code value.
>>>
>>> DPU is an optional component, so DSI driver should not depend on the 
>>> DPU driver.
>>>
>>
>> Today, the implicit dependency is already there. Without the DPU DSC 
>> blocks, the DSI cannot operate in compressed mode.
> 
> It can not operate, but one will compile w/o other driver.
> 

Ack.

>>
>> But, from a SW standpoint I agree we can separate this.
>>
>> We can move this one level up to the disp/ or msm/ folder
>>
>> What do you think about that?
> 
> I think about drivers/gpu/drm/display/drm_dsc_helper.c
> 

No, that wont work because of the explanation given in the prev patch.

>> -- 
> With best wishes
> Dmitry
> 
