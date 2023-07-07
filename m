Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E97C74B85F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 22:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjGGUtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 16:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjGGUtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 16:49:47 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14C11FEB;
        Fri,  7 Jul 2023 13:49:45 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367JoMLO020795;
        Fri, 7 Jul 2023 20:49:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=VsMEyiopGF1s8z/uSSx+s6O0JMpIfYNGYZY2ht5P2MI=;
 b=GP/6RrHbX5zsludgi+sOZYtUuhUOct+z/t3yd17ah5uEvdRcnVMUqPrqa6KFq0GFajj1
 7RoczTud2X5+VsWFkBZKzfYPGmot163j+6yIoHQ5DifrD2s01aNuw1o5+jUSxOaLedvV
 xAL4AwWgYoSr1wDmXl4MJFHwaiNUXgH7hydTDeEVRDCuAk3VXZHqU2k+EryvA6cQdAIy
 OA57Ax6brkXWWLhvqAhS38Bqb7ZLX3wMhJkJOtPBvaZvr5+kdx4QRA9h2fByFMGNxVkg
 gT7WDYF4L+t5OMO8Z128wpMBI0tWy0oFofCdKbJsbCv5ReJj+qpgOE7FNULBz8cfAsJG Yw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rp96vteqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 20:49:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 367KnF50013462
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Jul 2023 20:49:15 GMT
Received: from [10.71.108.78] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 7 Jul
 2023 13:49:14 -0700
Message-ID: <ee853769-d1ba-5189-1afd-62731c62966c@quicinc.com>
Date:   Fri, 7 Jul 2023 13:49:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 6/6] drm/msm/dpu: Update dev core dump to dump
 registers of sub-blocks
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        "David Airlie" <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
CC:     Rob Clark <robdclark@chromium.org>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <quic_jesszhan@quicinc.com>
References: <20230622-devcoredump_patch-v4-0-e304ddbe9648@quicinc.com>
 <20230622-devcoredump_patch-v4-6-e304ddbe9648@quicinc.com>
 <0493c891-9cde-8284-a988-b6e95135db85@linaro.org>
From:   Ryan McCann <quic_rmccann@quicinc.com>
In-Reply-To: <0493c891-9cde-8284-a988-b6e95135db85@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SbXiWfXw_2A7AJZsGZhmCjIqhcDxhsBu
X-Proofpoint-GUID: SbXiWfXw_2A7AJZsGZhmCjIqhcDxhsBu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_14,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307070192
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My apologies for the private email, I hit reply instead of reply all by 
accident.

On 7/6/2023 5:24 PM, Dmitry Baryshkov wrote:
> On 06/07/2023 23:48, Ryan McCann wrote:
>> Currently, the device core dump mechanism does not dump registers of
>> sub-blocks within the DSPP, SSPP, DSC, and PINGPONG blocks. Edit
>> dpu_kms_mdp_snapshot function to account for sub-blocks.
>>
>> Signed-off-by: Ryan McCann <quic_rmccann@quicinc.com>
>> ---
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 66 
>> ++++++++++++++++++++++++++++++---
>>   1 file changed, 60 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c 
>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
>> index 70dbb1204e6c..afc45d597d65 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
>> @@ -903,25 +903,58 @@ static void dpu_kms_mdp_snapshot(struct 
>> msm_disp_state *disp_state, struct msm_k
>>                           cat->ctl[i].base, cat->ctl[i].name);
>>       /* dump DSPP sub-blocks HW regs info */
>> -    for (i = 0; i < cat->dspp_count; i++)
>> +    for (i = 0; i < cat->dspp_count; i++) {
>>           msm_disp_snapshot_add_block(disp_state, cat->dspp[i].len, 
>> dpu_kms->mmio +
>>                           cat->dspp[i].base, cat->dspp[i].name);
>> +        if (cat->dspp[i].sblk && cat->dspp[i].sblk->pcc.len > 0)
>> +            msm_disp_snapshot_add_block(disp_state, 
>> cat->dspp[i].sblk->pcc.len,
>> +                            dpu_kms->mmio + cat->dspp[i].base +
>> +                            cat->dspp[i].sblk->pcc.base, "%s_%s",
> 
> This might look simpler in the following form. Could you please consider 
> it?
> 
> 
> void *base =  dpu_kms + cat->dspp[i].base;
> 
> msm_disp_snapshot_add_block(..., base, cat->dspp[i].name)
> 
> if (!cat->dspp[i].sblk)
>      continue;
> 
> if (cat->dspp[i].sblk->pcc.len)
>      msm_disp_snapshot_add_block(..., base + 
> cat->dspp[i].sblk->pcc.base, ...);

Regarding what we discussed in the private email, is what I had for base 
in v2

(https://patchwork.freedesktop.org/patch/545690/?series=120249&rev=1)

essentially what you have in mind?

> 
>> +                            cat->dspp[i].name,
>> +                            cat->dspp[i].sblk->pcc.name);
>> +    }
>> +
>>       /* dump INTF sub-blocks HW regs info */
>>       for (i = 0; i < cat->intf_count; i++)
>>           msm_disp_snapshot_add_block(disp_state, cat->intf[i].len, 
>> dpu_kms->mmio +
>>                           cat->intf[i].base, cat->intf[i].name);
>>       /* dump PP sub-blocks HW regs info */
>> -    for (i = 0; i < cat->pingpong_count; i++)
>> +    for (i = 0; i < cat->pingpong_count; i++) {
>>           msm_disp_snapshot_add_block(disp_state, 
>> cat->pingpong[i].len, dpu_kms->mmio +
>>                           cat->pingpong[i].base, cat->pingpong[i].name);
>> +        /* TE2 block has length of 0, so will not print it */
>> +
>> +        if (cat->pingpong[i].sblk && 
>> cat->pingpong[i].sblk->dither.len > 0)
>> +            msm_disp_snapshot_add_block(disp_state, 
>> cat->pingpong[i].sblk->dither.len,
>> +                            dpu_kms->mmio + cat->pingpong[i].base +
>> +                            cat->pingpong[i].sblk->dither.base, "%s_%s",
>> +                            cat->pingpong[i].name,
>> +                            cat->pingpong[i].sblk->dither.name);
>> +    }
>> +
>>       /* dump SSPP sub-blocks HW regs info */
>> -    for (i = 0; i < cat->sspp_count; i++)
>> +    for (i = 0; i < cat->sspp_count; i++) {
>>           msm_disp_snapshot_add_block(disp_state, cat->sspp[i].len, 
>> dpu_kms->mmio +
>>                           cat->sspp[i].base, cat->sspp[i].name);
>> +        if (cat->sspp[i].sblk && cat->sspp[i].sblk->scaler_blk.len > 0)
>> +            msm_disp_snapshot_add_block(disp_state, 
>> cat->sspp[i].sblk->scaler_blk.len,
>> +                            dpu_kms->mmio + cat->sspp[i].base +
>> +                            cat->sspp[i].sblk->scaler_blk.base, "%s_%s",
>> +                            cat->sspp[i].name,
>> +                            cat->sspp[i].sblk->scaler_blk.name);
>> +
>> +        if (cat->sspp[i].sblk && cat->sspp[i].sblk->csc_blk.len > 0)
>> +            msm_disp_snapshot_add_block(disp_state, 
>> cat->sspp[i].sblk->csc_blk.len,
>> +                            dpu_kms->mmio + cat->sspp[i].base +
>> +                            cat->sspp[i].sblk->csc_blk.base, "%s_%s",
>> +                            cat->sspp[i].name,
>> +                            cat->sspp[i].sblk->csc_blk.name);
>> +    }
>> +
>>       /* dump LM sub-blocks HW regs info */
>>       for (i = 0; i < cat->mixer_count; i++)
>>           msm_disp_snapshot_add_block(disp_state, cat->mixer[i].len, 
>> dpu_kms->mmio +
>> @@ -943,9 +976,30 @@ static void dpu_kms_mdp_snapshot(struct 
>> msm_disp_state *disp_state, struct msm_k
>>       }
>>       /* dump DSC sub-blocks HW regs info */
>> -    for (i = 0; i < cat->dsc_count; i++)
>> -        msm_disp_snapshot_add_block(disp_state, cat->dsc[i].len, 
>> dpu_kms->mmio +
>> -                        cat->dsc[i].base, cat->dsc[i].name);
>> +    for (i = 0; i < cat->dsc_count; i++) {
>> +        if (cat->dsc[i].features & BIT(DPU_DSC_HW_REV_1_2)) {
>> +            struct dpu_dsc_blk enc = cat->dsc[i].sblk->enc;
>> +            struct dpu_dsc_blk ctl = cat->dsc[i].sblk->ctl;
>> +
>> +            /* For now, pass in a length of 0 because the DSC_BLK 
>> register space
>> +             * overlaps with the sblks' register space.
>> +             *
>> +             * TODO: Pass in a length of 0 to DSC_BLK_1_2 in the HW 
>> catalog where
>> +             * applicable.
> 
> Please assume that https://patchwork.freedesktop.org/series/119776/ and 
> rebase your code on top of it.

Roger.

> 
>> +             */
>> +            msm_disp_snapshot_add_block(disp_state, 0, dpu_kms->mmio +
>> +                            cat->dsc[i].base, cat->dsc[i].name);
>> +            msm_disp_snapshot_add_block(disp_state, enc.len, 
>> dpu_kms->mmio +
>> +                            cat->dsc[i].base + enc.base, "%s_%s",
>> +                            cat->dsc[i].name, enc.name);
>> +            msm_disp_snapshot_add_block(disp_state, ctl.len, 
>> dpu_kms->mmio +
>> +                            cat->dsc[i].base + ctl.base, "%s_%s",
>> +                            cat->dsc[i].name, ctl.name);
>> +        } else {
>> +            msm_disp_snapshot_add_block(disp_state, cat->dsc[i].len, 
>> dpu_kms->mmio +
>> +                            cat->dsc[i].base, cat->dsc[i].name);
>> +        }
>> +    }
>>       pm_runtime_put_sync(&dpu_kms->pdev->dev);
>>   }
>>
> 
