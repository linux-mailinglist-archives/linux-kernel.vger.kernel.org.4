Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1194A7308BB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 21:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236224AbjFNTqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 15:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235844AbjFNTqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 15:46:43 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC68A2686;
        Wed, 14 Jun 2023 12:46:31 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35EJkMFb011615;
        Wed, 14 Jun 2023 19:46:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=t3YQ0lVNeSPcw8/SIHX4fEUcWgQnPAXwUgDxN/+M87E=;
 b=C6ggZHrt6lMxV41ut8t0xM3Iw3rKeQZbqmylVNz21Y311w/XLEpD7M82M6dmf8liGjzj
 WP6XUpNh0F/hmnIIRBwYqYHLgrnad06W3b5tpSCgSkA5XyEDMeRZ2enf++Na/TDZLdzz
 GPzE99/VGJQTLqHaRTr0QSbpLGvJlAiuKijuTSeXbR1LtK/mOM2/HPycFNl9QaUb+37u
 y4FRM28gg8FGXG48wQkmNi7nhnSSOaFfNgeDNVh+eghRbYt2CJWLlukgMhAD35cdVnX6
 XYlTMoYTM8UgilGavU2uXcLjQLJuG/BbIFnaIvP/zhd7i50W3SI1o8SAjSa2kGgsOSv5 9A== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r71tvtdt2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 19:46:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35EJkLt8005243
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 19:46:21 GMT
Received: from akhilpo-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 14 Jun 2023 12:46:16 -0700
Date:   Thu, 15 Jun 2023 01:16:13 +0530
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
Subject: Re: [PATCH v8 15/18] drm/msm/a6xx: Use "else if" in GPU speedbin rev
 matching
Message-ID: <tdvogj6wkvos2qxm4q7lglmiw46lhdjrdp3do5c5d2sz73k4tv@tbfr25tszvo7>
References: <20230223-topic-gmuwrapper-v8-0-69c68206609e@linaro.org>
 <20230223-topic-gmuwrapper-v8-15-69c68206609e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230223-topic-gmuwrapper-v8-15-69c68206609e@linaro.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Rbg_sa7maabxu0gu8qgiXIyZJcVJtjXm
X-Proofpoint-ORIG-GUID: Rbg_sa7maabxu0gu8qgiXIyZJcVJtjXm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_14,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxlogscore=955 bulkscore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306140173
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 03:52:34PM +0200, Konrad Dybcio wrote:
> 
> The GPU can only be one at a time. Turn a series of ifs into if +
> elseifs to save some CPU cycles.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Akhil P Oommen <quic_akhilpo@quicinc.com>

-Akhil
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 1a29e7dd9975..5faa85543428 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -2170,16 +2170,16 @@ static u32 fuse_to_supp_hw(struct device *dev, struct adreno_rev rev, u32 fuse)
>  	if (adreno_cmp_rev(ADRENO_REV(6, 1, 8, ANY_ID), rev))
>  		val = a618_get_speed_bin(fuse);
>  
> -	if (adreno_cmp_rev(ADRENO_REV(6, 1, 9, ANY_ID), rev))
> +	else if (adreno_cmp_rev(ADRENO_REV(6, 1, 9, ANY_ID), rev))
>  		val = a619_get_speed_bin(fuse);
>  
> -	if (adreno_cmp_rev(ADRENO_REV(6, 3, 5, ANY_ID), rev))
> +	else if (adreno_cmp_rev(ADRENO_REV(6, 3, 5, ANY_ID), rev))
>  		val = adreno_7c3_get_speed_bin(fuse);
>  
> -	if (adreno_cmp_rev(ADRENO_REV(6, 4, 0, ANY_ID), rev))
> +	else if (adreno_cmp_rev(ADRENO_REV(6, 4, 0, ANY_ID), rev))
>  		val = a640_get_speed_bin(fuse);
>  
> -	if (adreno_cmp_rev(ADRENO_REV(6, 5, 0, ANY_ID), rev))
> +	else if (adreno_cmp_rev(ADRENO_REV(6, 5, 0, ANY_ID), rev))
>  		val = a650_get_speed_bin(fuse);
>  
>  	if (val == UINT_MAX) {
> 
> -- 
> 2.40.1
> 
