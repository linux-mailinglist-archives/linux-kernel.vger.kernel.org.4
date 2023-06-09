Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1701C72A21F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 20:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjFISZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 14:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjFISZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 14:25:50 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4AC35BC;
        Fri,  9 Jun 2023 11:25:49 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 359EP1ec004202;
        Fri, 9 Jun 2023 18:25:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=FDqnF98IhW5NO85AdQhmRp9CAq0W/IalEYURCFmo4Hc=;
 b=htYl/sSI7pOL8Scp5R9qzqMht+yMK/ECclHGausIK9VZFgsHbOEyeOp4Fvh8v5QfiJ8J
 L3RTG0i/wWAA8F6vd+UnJipRnwnW5DFBaHgMMKqfFv68wbhYH1iDfhoDZ7b8p6LYsu4c
 H5aPMlV1V5tJYqp2pQ6Vp23GF2XpFDotL5SMLDEXoaKZE/wkfGRgjnSC8sZXDM4nFbEF
 gOxYHNGR8Xna4DJGhyBFxUnINr/tqXW7jHUqCR6/4rB3jQhZOrRV8hP6KZQgFVXUTA9q
 5pE2IBkUd9I7cgC4toTiKrN+9/2foCm0b2iRDvqUY95KIJlAZALFzebg557Avu4A0Yq7 5g== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r45tsgkdj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 18:25:38 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 359IPbtv023685
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Jun 2023 18:25:38 GMT
Received: from akhilpo-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 9 Jun 2023 11:25:32 -0700
Date:   Fri, 9 Jun 2023 23:55:29 +0530
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Rob Clark <robdclark@chromium.org>,
        Marijn Suijten <marijn.suijten@somainline.org>
Subject: Re: [PATCH v8 08/18] drm/msm/a6xx: Remove both GBIF and RBBM GBIF
 halt on hw init
Message-ID: <eucocwnrumtpp5obno6dg3vl54wrrflge7cbt34ubfy32czl7d@b3kkk3l7ibfj>
References: <20230223-topic-gmuwrapper-v8-0-69c68206609e@linaro.org>
 <20230223-topic-gmuwrapper-v8-8-69c68206609e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230223-topic-gmuwrapper-v8-8-69c68206609e@linaro.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pDd0c0saJPQ6L-_owofx1-LRtx1gzvEd
X-Proofpoint-ORIG-GUID: pDd0c0saJPQ6L-_owofx1-LRtx1gzvEd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_14,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=828
 mlxscore=0 phishscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306090153
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 03:52:27PM +0200, Konrad Dybcio wrote:
> 
> Currently we're only deasserting REG_A6XX_RBBM_GBIF_HALT, but we also
> need REG_A6XX_GBIF_HALT to be set to 0.
> 
> This is typically done automatically on successful GX collapse, but in
> case that fails, we should take care of it.
> 
> Also, add a memory barrier to ensure it's gone through before jumping
> to further initialization.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 083ccb5bcb4e..dfde5fb65eed 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -1003,8 +1003,12 @@ static int hw_init(struct msm_gpu *gpu)
>  	a6xx_gmu_set_oob(&a6xx_gpu->gmu, GMU_OOB_GPU_SET);
>  
>  	/* Clear GBIF halt in case GX domain was not collapsed */
> -	if (a6xx_has_gbif(adreno_gpu))
> +	if (a6xx_has_gbif(adreno_gpu)) {
> +		gpu_write(gpu, REG_A6XX_GBIF_HALT, 0);
>  		gpu_write(gpu, REG_A6XX_RBBM_GBIF_HALT, 0);
> +		/* Let's make extra sure that the GPU can access the memory.. */
> +		mb();
This barrier is unnecessary because writel transactions are ordered and
we don't expect a traffic from GPU immediately after this.

-Akhil
> +	}
>  
>  	gpu_write(gpu, REG_A6XX_RBBM_SECVID_TSB_CNTL, 0);
>  
> 
> -- 
> 2.40.1
> 
