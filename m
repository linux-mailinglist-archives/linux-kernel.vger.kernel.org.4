Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6605E6C85
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 22:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiIVUAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 16:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbiIVT7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 15:59:37 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131D8110B1A;
        Thu, 22 Sep 2022 12:58:57 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28MJuB6S019797;
        Thu, 22 Sep 2022 19:58:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=NkEh91jlWbl+wAZPUzvDUb7z/Or52lv3BjB3tJmIBUA=;
 b=nZwPAwVOabc+pQGgBdyldQ3bBHq18vz7dT0GJUXhA2viJc4/KKuYhq89ChxlJaV9xTZs
 ijPwgynujwGYm1/lbvzB+XtrWWv6uZTPzZMc+8lRiR5DNAeDtKV/49V6vfNDnWfGqbi+
 KddZgMVbMITos47ZDyHIK4TSsGhJTlCNoaSTfByVwwDkapyB2naE1Fyfmy+32GmTjY/w
 VUVHcyz7TneU8VpIIx4abFxyzBXF4veq6xLWDzh+MW/112yV2j0MfdGXkg884RghY2bH
 pNw4yJqFxkNZBD+WLHE1BzYCViNDZRC/jMrsXnhkN25OtEscyHLut1558xm8BN1e2zcB EQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jr85v3egv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Sep 2022 19:58:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28MJwPcs000527
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Sep 2022 19:58:25 GMT
Received: from [10.110.101.161] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 22 Sep
 2022 12:58:23 -0700
Message-ID: <5cd4c767-c2e6-6325-5e13-06748295b3f3@quicinc.com>
Date:   Thu, 22 Sep 2022 12:58:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [Freedreno] [PATCH v2 10/10] drm/msm/dsi: drop modeset sanity
 checks
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Rob Clark" <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
CC:     <dri-devel@lists.freedesktop.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonas Karlman <jonas@kwiboo.se>,
        <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Sean Paul <sean@poorly.run>,
        "Steev Klimaszewski" <steev@kali.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
References: <20220913085320.8577-1-johan+linaro@kernel.org>
 <20220913085320.8577-11-johan+linaro@kernel.org>
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
In-Reply-To: <20220913085320.8577-11-johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _eK-m_UMhWG69NYm6OAx3pPxNN55XKp6
X-Proofpoint-GUID: _eK-m_UMhWG69NYm6OAx3pPxNN55XKp6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-22_14,2022-09-22_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209220129
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/13/2022 1:53 AM, Johan Hovold wrote:
> Drop the overly defensive modeset sanity checks of function parameters
> which have already been checked or used by the callers.
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
Reviewed-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>   drivers/gpu/drm/msm/dsi/dsi.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dsi/dsi.c b/drivers/gpu/drm/msm/dsi/dsi.c
> index 8a95c744972a..31fdee2052be 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi.c
> @@ -211,14 +211,9 @@ void __exit msm_dsi_unregister(void)
>   int msm_dsi_modeset_init(struct msm_dsi *msm_dsi, struct drm_device *dev,
>   			 struct drm_encoder *encoder)
>   {
> -	struct msm_drm_private *priv;
> +	struct msm_drm_private *priv = dev->dev_private;
>   	int ret;
>   
> -	if (WARN_ON(!encoder) || WARN_ON(!msm_dsi) || WARN_ON(!dev))
> -		return -EINVAL;
> -
> -	priv = dev->dev_private;
> -
>   	if (priv->num_bridges == ARRAY_SIZE(priv->bridges)) {
>   		DRM_DEV_ERROR(dev->dev, "too many bridges\n");
>   		return -ENOSPC;
