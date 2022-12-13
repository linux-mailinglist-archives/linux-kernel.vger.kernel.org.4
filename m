Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9628464B031
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 08:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbiLMHH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 02:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234310AbiLMHHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 02:07:22 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C6A186D9;
        Mon, 12 Dec 2022 23:07:21 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BD6HboH008632;
        Tue, 13 Dec 2022 07:07:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=loXd4sKnl9c27l7Xp+zJ+XQQW0vTj4Ys4XUUdw9ZWr0=;
 b=QyKpBrynFPn3drqpLF1bdUUsybWxacFv6iC3jafdfpi2kxAbpo0OvqeiWDFL6Fsnq1Uk
 NVFkoOtlLDUHjOGlt3ftx11RDGC55X8d1EU7+TuCECndhQCp5pumHIyE2ucKhYxh5weW
 9vze7v8fOnM5Pw7WLLq5O1sSwkO5+7LOori7NrSZ6Kh/z6zZYcKNn+fwgHFGWjkDyKca
 PYiFDrffdfCKYrdCY14N1M3Glm8ha8l/wnk8UerNsisK2xirwkd8dURGEIP2qtS1gnaZ
 KiZcLq5L++qNX9CaLixWlSzgjPOhDv//irFxrCpkjpuj3jfMhA8rxuy3hLRNc1vWJBh3 Rw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3me83sj29y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 07:07:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BD778Bj019000
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 07:07:08 GMT
Received: from [10.216.17.160] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 12 Dec
 2022 23:07:03 -0800
Message-ID: <3c017429-15c6-11d0-9aef-c718a39d87aa@quicinc.com>
Date:   Tue, 13 Dec 2022 12:36:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 3/7] drm/msm/a6xx: Add support for A640 speed binning
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <andersson@kernel.org>,
        <agross@kernel.org>, <krzysztof.kozlowski@linaro.org>
CC:     <marijn.suijten@somainline.org>, Rob Clark <robdclark@gmail.com>,
        "Abhinav Kumar" <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Chia-I Wu <olvaffe@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20221213002423.259039-1-konrad.dybcio@linaro.org>
 <20221213002423.259039-4-konrad.dybcio@linaro.org>
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
In-Reply-To: <20221213002423.259039-4-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MrJ4nlK9qg5HEWa8kw7rAuhUmlOxUr6O
X-Proofpoint-ORIG-GUID: MrJ4nlK9qg5HEWa8kw7rAuhUmlOxUr6O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 clxscore=1011 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212130064
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/2022 5:54 AM, Konrad Dybcio wrote:
> Add support for matching QFPROM fuse values to get the correct speed bin
> on A640 (SM8150) GPUs.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 36c8fb699b56..2c1630f0c04c 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -1877,6 +1877,16 @@ static u32 a619_get_speed_bin(u32 fuse)
>  	return UINT_MAX;
>  }
>  
> +static u32 a640_get_speed_bin(u32 fuse)
> +{
> +	if (fuse == 0)
> +		return 0;
> +	else if (fuse == 1)
> +		return 1;
> +
> +	return UINT_MAX;
> +}
> +
>  static u32 adreno_7c3_get_speed_bin(u32 fuse)
>  {
>  	if (fuse == 0)
> @@ -1902,6 +1912,9 @@ static u32 fuse_to_supp_hw(struct device *dev, struct adreno_rev rev, u32 fuse)
>  	if (adreno_cmp_rev(ADRENO_REV(6, 3, 5, ANY_ID), rev))
>  		val = adreno_7c3_get_speed_bin(fuse);
>  
> +	if (adreno_cmp_rev(ADRENO_REV(6, 4, 0, ANY_ID), rev))
> +		val = a640_get_speed_bin(fuse);
> +
>  	if (val == UINT_MAX) {
>  		DRM_DEV_ERROR(dev,
>  			"missing support for speed-bin: %u. Some OPPs may not be supported by hardware\n",

Reviewed-by: Akhil P Oommen <quic_akhilpo@quicinc.com>


-Akhil.
