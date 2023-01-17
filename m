Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8729A670E73
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 01:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjARAMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 19:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjARAMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 19:12:14 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2B158651;
        Tue, 17 Jan 2023 15:28:48 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30HNA99f020899;
        Tue, 17 Jan 2023 23:28:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Q+bGzy/bpjnZHbKLCwdyOhG2zG9LQH4Betp8bptyByI=;
 b=PPcL81pC0M/Ik9DTywv4tvSTuIcHacuX5NyK6uz5OdpjIGWcyuYaA/Dhr4uaQrzLWhnt
 GlHqXc0nJl1WdKqlcJo9PlDe193PP9BjIziirx/G8EXIcLWSg5Z1SYV9cKxiPiVhE/0g
 zwjdSF+AJ6PFSutEXM43uButyqsTWtvOJsCFcx86Q9zZPipYTaJCWhNLeYoKFeQku210
 7v1nE2X2T0KjiRTXXoa9Nk2T+UcnCXo/pvE+boRJ/ravUC+SfX5BCuc+40wTpoCUg5/v
 YgrYjSL7LbvMj5SPg0+fKF/t0n+Jeh9DBsnQczHlFHpChHFeFARvQl6pdEnL3RSsbWQK dQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n5nkqa0ya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 23:28:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30HNSeuS003574
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 23:28:40 GMT
Received: from [10.110.108.90] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 17 Jan
 2023 15:28:39 -0800
Message-ID: <982748a3-25d2-0d27-f6bd-d38e0a89796d@quicinc.com>
Date:   Tue, 17 Jan 2023 15:28:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] drm/msm/dpu: Remove some unused variables
Content-Language: en-US
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        <robdclark@gmail.com>
CC:     <dmitry.baryshkov@linaro.org>, <sean@poorly.run>,
        <airlied@gmail.com>, <daniel@ffwll.ch>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20230112033823.24901-1-jiapeng.chong@linux.alibaba.com>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20230112033823.24901-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: V7nQ25PECL1WMN6KHUqMTVBs_syTmRGg
X-Proofpoint-ORIG-GUID: V7nQ25PECL1WMN6KHUqMTVBs_syTmRGg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_10,2023-01-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301170187
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/11/2023 7:38 PM, Jiapeng Chong wrote:
> Variables 'sc8280xp_regdma' and 'sm8350_regdma' are defined in the
> dpu_hw_catalog.c file, but not used elsewhere, so remove these unused
> variables.
> 
> drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c:2029:37: warning: unused variable 'sc8280xp_regdma'.
> drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c:2053:37: warning: unused variable 'sm8350_regdma'.
> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3722
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

We should be adding the regdma entries to .dma_cfg of these chipsets.

> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 16 ----------------
>   1 file changed, 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> index 0f3da480b066..79bbef93948f 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> @@ -2026,14 +2026,6 @@ static const struct dpu_vbif_cfg sdm845_vbif[] = {
>   	},
>   };
>   
> -static const struct dpu_reg_dma_cfg sc8280xp_regdma = {
> -	.base = 0x0,
> -	.version = 0x00020000,
> -	.trigger_sel_off = 0x119c,
> -	.xin_id = 7,
> -	.clk_ctrl = DPU_CLK_CTRL_REG_DMA,
> -};
> -
>   static const struct dpu_reg_dma_cfg sdm845_regdma = {
>   	.base = 0x0, .version = 0x1, .trigger_sel_off = 0x119c
>   };
> @@ -2050,14 +2042,6 @@ static const struct dpu_reg_dma_cfg sm8250_regdma = {
>   	.clk_ctrl = DPU_CLK_CTRL_REG_DMA,
>   };
>   
> -static const struct dpu_reg_dma_cfg sm8350_regdma = {
> -	.base = 0x400,
> -	.version = 0x00020000,
> -	.trigger_sel_off = 0x119c,
> -	.xin_id = 7,
> -	.clk_ctrl = DPU_CLK_CTRL_REG_DMA,
> -};
> -
>   static const struct dpu_reg_dma_cfg sm8450_regdma = {
>   	.base = 0x0,
>   	.version = 0x00020000,
