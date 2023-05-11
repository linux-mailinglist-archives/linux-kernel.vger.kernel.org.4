Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C566FEAC8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 06:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236731AbjEKEih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 00:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEKEie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 00:38:34 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F2B44B8;
        Wed, 10 May 2023 21:38:33 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34B48r60026430;
        Thu, 11 May 2023 04:38:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=kmyzR9/pCuKiBXEkNSt3Wpkwdf0YHBcrmnucUAJVQFU=;
 b=Ud6Qr4duA0s1jclb1+08B/KZRhp1JuPIWHKLrjNykPUpTU1UGTOkkdQD2u1iFC0fruKH
 ejLyRPyEJzG/vocIqFWf5aRibIMxx7zdrB/6IcbsFe5zBXIRNEwMJBcKeZKJ4eCgk1AS
 7RrbETUeElzbsj3hh3yrNkWIovH8EnslfGO6aSCKBBp0kUr2dXw3SFrhkfv0git4fbdD
 /ElpJBbnxRBWPlE/dVgD2DnjxMMT7Ijw9D/+a4DlMX2ByLUWC+8vT6u2XG8Y/QrEw+ME
 O0f2lFFbcCiGP9eiOOfn0v5Iy2NhhALHDnPBCQBvYwkvzgf2rIAYvU1nM7loNMP908rE bQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qg79ct6k2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 May 2023 04:38:23 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34B4cLmU020629
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 May 2023 04:38:21 GMT
Received: from [10.110.82.209] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 10 May
 2023 21:38:20 -0700
Message-ID: <1a6109ae-7c83-c04e-60c9-dfca6b83d662@quicinc.com>
Date:   Wed, 10 May 2023 21:38:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v6 2/8] drm/msm/dpu: add DPU_PINGPONG_DSC feature bit for
 DPU < 7.0.0
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@gmail.com>,
        <agross@kernel.org>, <andersson@kernel.org>
CC:     <quic_jesszhan@quicinc.com>, <quic_sbillaka@quicinc.com>,
        <marijn.suijten@somainline.org>, <freedreno@lists.freedesktop.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1683756453-22050-1-git-send-email-quic_khsieh@quicinc.com>
 <1683756453-22050-3-git-send-email-quic_khsieh@quicinc.com>
 <b4438422-f24b-7fc1-18cf-3cebdd777530@linaro.org>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <b4438422-f24b-7fc1-18cf-3cebdd777530@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rFFFP__dUEzwIEK5vlI8wxfpwS8KT_sQ
X-Proofpoint-ORIG-GUID: rFFFP__dUEzwIEK5vlI8wxfpwS8KT_sQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 mlxlogscore=786 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305110037
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/10/2023 9:29 PM, Dmitry Baryshkov wrote:
> On 11/05/2023 01:07, Kuogee Hsieh wrote:
>> DPU < 7.0.0 requires the PINGPONG block to be involved during
>> DSC setting up. Since DPU >= 7.0.0, enabling and starting the DSC
>> encoder engine moved to INTF with the help of the flush mechanism.
> 
> Nit: was moved.
> 
>> Add a DPU_PINGPONG_DSC feature bit to restrict the availability of
>> dpu_hw_pp_setup_dsc() and dpu_hw_pp_dsc_{enable,disable}() on the
>> PINGPONG block to DPU < 7.0.0 hardware, as the registers are not
>> available [in the PINGPONG block] on DPU 7.0.0 and higher anymore.
> 
> this looks good
> 
>> Existing call-sites to these callbacks already skip calling into
>> them if the function pointer is NULL.
> 
> This is more relevant for patch 3 commit message.
> 
>> Add DPU_PINGPONG_DSC feature
>> bit to all chipset with DPU < 7.0.0.
> 
> This is incorrect, as we do not change the catalog in this patch.
> 

Sorry but why not? The changes done to dpu_hw_catalog.c do exactly that.

>>
>> changes in v6:
>> -- split patches and rearrange to keep catalog related files at this 
>> patch
>>
>> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
>> ---
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 6 +++---
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h | 4 +++-
>>   2 files changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c 
>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
>> index 82b58c6..78e4bf6 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
>> @@ -76,13 +76,13 @@
>>       (BIT(DPU_DIM_LAYER) | BIT(DPU_MIXER_COMBINED_ALPHA))
>>   #define PINGPONG_SDM845_MASK \
>> -    (BIT(DPU_PINGPONG_DITHER) | BIT(DPU_PINGPONG_TE))
>> +    (BIT(DPU_PINGPONG_DITHER) | BIT(DPU_PINGPONG_TE) | 
>> BIT(DPU_PINGPONG_DSC))
>>   #define PINGPONG_SDM845_TE2_MASK \
>> -    (PINGPONG_SDM845_MASK | BIT(DPU_PINGPONG_TE2))
>> +    (PINGPONG_SDM845_MASK | BIT(DPU_PINGPONG_TE2) | 
>> BIT(DPU_PINGPONG_DSC))
>>   #define PINGPONG_SM8150_MASK \
>> -    (BIT(DPU_PINGPONG_DITHER))
>> +    (BIT(DPU_PINGPONG_DITHER) | BIT(DPU_PINGPONG_DSC))
>>   #define CTL_SC7280_MASK \
>>       (BIT(DPU_CTL_ACTIVE_CFG) | \
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h 
>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
>> index 6ee48f0..dc0a4da 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
>> @@ -144,7 +144,8 @@ enum {
>>    * @DPU_PINGPONG_TE2        Additional tear check block for split pipes
>>    * @DPU_PINGPONG_SPLIT      PP block supports split fifo
>>    * @DPU_PINGPONG_SLAVE      PP block is a suitable slave for split fifo
>> - * @DPU_PINGPONG_DITHER,    Dither blocks
>> + * @DPU_PINGPONG_DITHER     Dither blocks
>> + * @DPU_PINGPONG_DSC        PP ops functions required for DSC
>>    * @DPU_PINGPONG_MAX
>>    */
>>   enum {
>> @@ -153,6 +154,7 @@ enum {
>>       DPU_PINGPONG_SPLIT,
>>       DPU_PINGPONG_SLAVE,
>>       DPU_PINGPONG_DITHER,
>> +    DPU_PINGPONG_DSC,
>>       DPU_PINGPONG_MAX
>>   };
> 
