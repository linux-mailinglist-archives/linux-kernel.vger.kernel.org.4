Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF32F6F5D3F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 19:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjECRpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 13:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjECRpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 13:45:51 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F307A83;
        Wed,  3 May 2023 10:45:41 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343EpZPi023818;
        Wed, 3 May 2023 17:45:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Is8Y6+BGHnBePIXXLK0YRC8sGcEu018Q8eTRQVp6OHU=;
 b=CBv/j3lNY37ihYpQXHTgvcTarM8Cvq1a+vplth6+AJmigRDDmYMhWizLv3iNEVyme1po
 02NTdo8tJlXlq+vn5gj9KUtlpm99buRWgvQmlEr5CSEG5YUjCHQLQmxymPZnL1JDVOO1
 W5H4t3eN/gxF1VFjcmZTltX9tlyGPefKpNiJ+MNsplQ7/BC1Z4D2ziOSd+KCtDYJKnAl
 KKXI0t2em0qL66uG1uka5Ru8gnhMPtkXETbKs+5bkRDcpgCzLWxgJlWLF3iycXrbCWji
 lm7YSdb9P4WLdf17DVA8xeU/Am7R8TGoUKzBhCQxBKeNF4HkcZZp6azN5Go/ZvZ18AsL IQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qbae92c35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 May 2023 17:45:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 343HjTGd017696
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 3 May 2023 17:45:29 GMT
Received: from [10.71.110.189] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 3 May 2023
 10:45:28 -0700
Message-ID: <648e7cca-8bb1-73f0-2bbb-0a6b81df3882@quicinc.com>
Date:   Wed, 3 May 2023 10:45:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 3/7] drm/msm/dpu: add DPU_PINGPONG_DSC bits into PP_BLK
 and PP_BLK_TE marcos
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@gmail.com>,
        <agross@kernel.org>, <andersson@kernel.org>
CC:     <quic_abhinavk@quicinc.com>, <quic_sbillaka@quicinc.com>,
        <marijn.suijten@somainline.org>, <freedreno@lists.freedesktop.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1683061382-32651-1-git-send-email-quic_khsieh@quicinc.com>
 <1683061382-32651-4-git-send-email-quic_khsieh@quicinc.com>
 <4315e96f-ed29-92aa-9549-d6fc9d820de6@linaro.org>
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
In-Reply-To: <4315e96f-ed29-92aa-9549-d6fc9d820de6@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jMrv_6n3GRMqsz5lzlsFKgkPxWegoixg
X-Proofpoint-ORIG-GUID: jMrv_6n3GRMqsz5lzlsFKgkPxWegoixg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_12,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305030151
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/2/2023 3:42 PM, Dmitry Baryshkov wrote:
> On 03/05/2023 00:02, Kuogee Hsieh wrote:
>> At legacy chipsets, it required DPU_PINGPONG_DSC bit be set to indicate
>> pingpong ops functions are required to complete DSC data path setup if
>> this chipset has DSC hardware block presented. This patch add
>> DPU_PINGPONG_DSC bit to both PP_BLK and PP_BLK_TE marcos if it has DSC
>> hardware block presented.
>>
>> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
>> ---
>>   .../drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h    | 12 +++++-----
>>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h |  8 +++----
>>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h | 26 
>> ++++++++++------------
>>   .../drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h    | 24 
>> ++++++++++----------
>>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h | 26 
>> ++++++++++------------
>>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_2_sc7180.h |  4 ++--
>>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_3_sm6115.h |  2 +-
>>   .../drm/msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h    |  2 +-
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |  8 +++----
>>   9 files changed, 54 insertions(+), 58 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h 
>> b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
>> index 17f821c..b7cd746 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
>> @@ -112,16 +112,16 @@ static const struct dpu_lm_cfg msm8998_lm[] = {
>>   };
>>     static const struct dpu_pingpong_cfg msm8998_pp[] = {
>> -    PP_BLK_TE("pingpong_0", PINGPONG_0, 0x70000, 0, sdm845_pp_sblk_te,
>> -            DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
>> +    PP_BLK_TE("pingpong_0", PINGPONG_0, 0x70000, 
>> BIT(DPU_PINGPONG_DSC), 0,
>> +            sdm845_pp_sblk_te, DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
>>               DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 12)),
>> -    PP_BLK_TE("pingpong_1", PINGPONG_1, 0x70800, 0, sdm845_pp_sblk_te,
>> -            DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 9),
>> +    PP_BLK_TE("pingpong_1", PINGPONG_1, 0x70800, 
>> BIT(DPU_PINGPONG_DSC), 0,
>> +            sdm845_pp_sblk_te, DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 9),
>>               DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 13)),
>> -    PP_BLK("pingpong_2", PINGPONG_2, 0x71000, 0, sdm845_pp_sblk,
>> +    PP_BLK("pingpong_2", PINGPONG_2, 0x71000, 0, 0, sdm845_pp_sblk,
>>               DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 10),
>>               DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 14)),
>> -    PP_BLK("pingpong_3", PINGPONG_3, 0x71800, 0, sdm845_pp_sblk,
>> +    PP_BLK("pingpong_3", PINGPONG_3, 0x71800, 0, 0, sdm845_pp_sblk,
>>               DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 11),
>>               DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 15)),
>
> Just to doublecheck: why don't we have DPU_PINGPONG_DSC for PP_3/_4? 
> We do have them on sdm845. Is it because we should not use DSC with 
> thos PINGPONG blocks?
>
I think it only have two DSPP connect to pp blocks
>>   };
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h 
>> b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h
>> index ceca741..8888bd9 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h
>> @@ -110,16 +110,16 @@ static const struct dpu_lm_cfg sdm845_lm[] = {
>>   };
>>     static const struct dpu_pingpong_cfg sdm845_pp[] = {
>> -    PP_BLK_TE("pingpong_0", PINGPONG_0, 0x70000, 0, sdm845_pp_sblk_te,
>> +    PP_BLK_TE("pingpong_0", PINGPONG_0, 0x70000, 
>> BIT(DPU_PINGPONG_DSC), 0, sdm845_pp_sblk_te,
>>               DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
>>               DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 12)),
>> -    PP_BLK_TE("pingpong_1", PINGPONG_1, 0x70800, 0, sdm845_pp_sblk_te,
>> +    PP_BLK_TE("pingpong_1", PINGPONG_1, 0x70800, 
>> BIT(DPU_PINGPONG_DSC), 0, sdm845_pp_sblk_te,
>>               DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 9),
>>               DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 13)),
>> -    PP_BLK("pingpong_2", PINGPONG_2, 0x71000, 0, sdm845_pp_sblk,
>> +    PP_BLK("pingpong_2", PINGPONG_2, 0x71000, BIT(DPU_PINGPONG_DSC), 
>> 0, sdm845_pp_sblk,
>>               DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 10),
>>               DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 14)),
>> -    PP_BLK("pingpong_3", PINGPONG_3, 0x71800, 0, sdm845_pp_sblk,
>> +    PP_BLK("pingpong_3", PINGPONG_3, 0x71800, BIT(DPU_PINGPONG_DSC), 
>> 0, sdm845_pp_sblk,
>>               DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 11),
>>               DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 15)),
>>
>
> [skipped the rest, looks good to me]
>
