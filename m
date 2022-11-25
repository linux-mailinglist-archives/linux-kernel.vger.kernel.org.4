Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A8A6383F4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 07:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiKYGVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 01:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKYGVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 01:21:49 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BCA240B1;
        Thu, 24 Nov 2022 22:21:48 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AP5KSJY007979;
        Fri, 25 Nov 2022 06:21:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=7X2cAV8D+5tN4VerwY+Cmy51FaJdiqC/SHu8MMSG/CE=;
 b=RlzGebGH2snuiXO4Jy5qlbLiAqvwAhY9D8qmoTigq1w3IRCWEfgkc9+ek6ShQHTCmK30
 xHNwjbDAu7pEPLezH1xTN+qegeqmTnFOzROAfkcf9E3H9QNxxMf1SkTmHTcAQWdwGlvr
 ic515ooUrsPixia1I29NiOXDmNiPFvxPoaZYe3uofIcAlpeEnenw37EShWUnVWmhaNCh
 rHy7wtmBr1/GLx/5mkDFKnIOoz1zp/r99aITAscXIzkheQyCDbFTrQ4xGw/qD3A29FRT
 7gq3cvz+VLmb2m7O66iCRsEqwlaLz1iwU+CRvAyh3PoOz/Zh2Tb9DsC6U+TEEcP7Rp2n rw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m2buv9gfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Nov 2022 06:21:34 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AP6LW9b013426
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Nov 2022 06:21:32 GMT
Received: from [10.216.38.33] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 24 Nov
 2022 22:21:26 -0800
Message-ID: <cb4347b0-b885-1a00-6ab1-03566191e1ec@quicinc.com>
Date:   Thu, 24 Nov 2022 22:21:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] drm/msm/dpu: Print interrupt index in addition to the
 mask
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        <phone-devel@vger.kernel.org>
CC:     <~postmarketos/upstreaming@lists.sr.ht>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Sean Paul" <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <swboyd@chromium.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20221121222456.437815-1-marijn.suijten@somainline.org>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20221121222456.437815-1-marijn.suijten@somainline.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pp-FMCIr_c_5Iu05Tb_m__SLWc8ZnweR
X-Proofpoint-ORIG-GUID: pp-FMCIr_c_5Iu05Tb_m__SLWc8ZnweR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-25_02,2022-11-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1011 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211250051
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/21/2022 2:24 PM, Marijn Suijten wrote:
> The mask only describes the `irq_idx % 32` part, making it generally
> impossible to deduce what interrupt is being enabled/disabled.  Since
> `debug/core_irq` in debugfs (and other prints) also include the full
> `DPU_IRQ_IDX()` value, print the same full value here for easier
> correlation instead of only adding the `irq_idx / 32` part.
> 
> Furthermore, make the dbgstr messages more consistent.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
> index cf1b6d84c18a..64589a9c2c51 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
> @@ -252,9 +252,9 @@ static int dpu_hw_intr_enable_irq_locked(struct dpu_hw_intr *intr, int irq_idx)
>   
>   	cache_irq_mask = intr->cache_irq_mask[reg_idx];
>   	if (cache_irq_mask & DPU_IRQ_MASK(irq_idx)) {
> -		dbgstr = "DPU IRQ already set:";
> +		dbgstr = "already ";
>   	} else {
> -		dbgstr = "DPU IRQ enabled:";
> +		dbgstr = "";
>   
>   		cache_irq_mask |= DPU_IRQ_MASK(irq_idx);
>   		/* Cleaning any pending interrupt */
> @@ -268,7 +268,7 @@ static int dpu_hw_intr_enable_irq_locked(struct dpu_hw_intr *intr, int irq_idx)
>   		intr->cache_irq_mask[reg_idx] = cache_irq_mask;
>   	}
>   
> -	pr_debug("%s MASK:0x%.8lx, CACHE-MASK:0x%.8x\n", dbgstr,
> +	pr_debug("DPU IRQ %d %senabled: MASK:0x%.8lx, CACHE-MASK:0x%.8x\n", irq_idx, dbgstr,
>   			DPU_IRQ_MASK(irq_idx), cache_irq_mask);
>   
>   	return 0;
> @@ -301,9 +301,9 @@ static int dpu_hw_intr_disable_irq_locked(struct dpu_hw_intr *intr, int irq_idx)
>   
>   	cache_irq_mask = intr->cache_irq_mask[reg_idx];
>   	if ((cache_irq_mask & DPU_IRQ_MASK(irq_idx)) == 0) {
> -		dbgstr = "DPU IRQ is already cleared:";
> +		dbgstr = "already ";
>   	} else {
> -		dbgstr = "DPU IRQ mask disable:";
> +		dbgstr = "";
>   
>   		cache_irq_mask &= ~DPU_IRQ_MASK(irq_idx);
>   		/* Disable interrupts based on the new mask */
> @@ -317,7 +317,7 @@ static int dpu_hw_intr_disable_irq_locked(struct dpu_hw_intr *intr, int irq_idx)
>   		intr->cache_irq_mask[reg_idx] = cache_irq_mask;
>   	}
>   
> -	pr_debug("%s MASK:0x%.8lx, CACHE-MASK:0x%.8x\n", dbgstr,
> +	pr_debug("DPU IRQ %d %sdisabled: MASK:0x%.8lx, CACHE-MASK:0x%.8x\n", irq_idx, dbgstr,
>   			DPU_IRQ_MASK(irq_idx), cache_irq_mask);
>   
>   	return 0;
