Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E4C62BC81
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbiKPLul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238853AbiKPLt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:49:56 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E822D12094;
        Wed, 16 Nov 2022 03:37:43 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AGBFuUn019569;
        Wed, 16 Nov 2022 11:37:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=mYWyqR0JxIsWxTN/dLRBhftkgrfE7nEPqDROuKX2JFc=;
 b=hBdyAQ6dnjo8Zl+K64QGFAFnAZYNUqp94/AWYghy62X3zJ+odz7CEnbD2SgirMJkaWV5
 jkEimyOOC0uSDsdwRaadmutn9EhTwqQXE7PhVWUwU0R8UJRIEYrNMRBk6CGeseJJSkGT
 WI0cmBZsicKvuhgKxpRrNZd1ua4V9qKthe7p9ukLdAjdKASMt74QVybCIE+5SMbcxy/8
 MhwkP8i+avFPqHiaYK3RW7os5L7UYJQp82ohskeUTNK1BGvLpFgWdroPJ6m5k8RODrlL
 Av9c28P/HSb41PNFmkXBD2V6gLHDdCMYCaGkk3nbgB7EwK3YmgRoaEUbjiBX8XxED6dZ 7Q== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kvwwg84sd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 11:37:35 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AGBbYr8025278
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 11:37:34 GMT
Received: from [10.216.25.63] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 16 Nov
 2022 03:37:28 -0800
Message-ID: <4f872825-e646-8a8c-dbd0-112328b9b5f2@quicinc.com>
Date:   Wed, 16 Nov 2022 03:37:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] drm/msm/dpu1: Remove INTF4 IRQ from SDM845 IRQ mask
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <andersson@kernel.org>,
        <agross@kernel.org>
CC:     <patches@linaro.org>, Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        "AngeloGioacchino Del Regno" 
        <angelogioacchino.delregno@somainline.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20221107103739.8993-1-konrad.dybcio@linaro.org>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20221107103739.8993-1-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pn3OuoK3orfG4eeic5NRvt8rfaiM8CS_
X-Proofpoint-ORIG-GUID: pn3OuoK3orfG4eeic5NRvt8rfaiM8CS_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-16_03,2022-11-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 impostorscore=0 clxscore=1011 adultscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211160082
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/7/2022 2:37 AM, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@somainline.org>
> 
> SDM845 only has INTF0-3 and has no business caring about the INTF4 irq.
> 
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

It is true that SDM845 doesnt have INTF4. I was a bit concerned whether 
this would impact SM8150 as that re-uses the IRQ_SDM845_MASK but even 
SM8150 doesnt have INTF4.

A minor nit, the subject convention in this file seems to be drm/msm/dpu 
and not drm/msm/dpu1.

Other than that,

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>


> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> index 27f029fdc682..06897a497eb7 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> @@ -86,7 +86,6 @@
>   			 BIT(MDP_INTF1_INTR) | \
>   			 BIT(MDP_INTF2_INTR) | \
>   			 BIT(MDP_INTF3_INTR) | \
> -			 BIT(MDP_INTF4_INTR) | \
>   			 BIT(MDP_AD4_0_INTR) | \
>   			 BIT(MDP_AD4_1_INTR))
>   
