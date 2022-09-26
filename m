Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175D65EAFB3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 20:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiIZSY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 14:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiIZSXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 14:23:47 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C6D36DF9;
        Mon, 26 Sep 2022 11:21:59 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28QDjHlP009234;
        Mon, 26 Sep 2022 18:21:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=qn94E33SwY/Mocg6UgreHW/i+02z72heJi9+onaUFpI=;
 b=OW7qErTzszl2Rm0NnSF8uUOj4+inq9HUs8BsqloTgOz8PXmM61JzbscsiCyIlzfOZL3v
 Puuaku/noarBUkwDsFfr2njxkU8ZyTv6OjmtKRNwN4SyaHDk6E0IWFTjMAoLlq+3/atB
 rSqHuJ4EzyvZGvsn9yhm3d5ujvm7Dh91IcKYQ4WJjBpHFExaYzZYmzjhfkcBXPj/zrDA
 nwrUH6ovZH8Qoxj2Ae8lMZz3HEDh1HzuuwnbfEHcD+XWuBvABVLlcdMHd9N9qYJcAy4p
 aXqZeV/zI8Ig4Zo32cHD4iAm+sWtCqWYAvayLXLz1ls5H7T9hePs2cdd28XRl1FGel1r HQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jua2usg85-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 18:21:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28QILie5004650
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 18:21:44 GMT
Received: from [10.111.163.216] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 26 Sep
 2022 11:21:40 -0700
Message-ID: <dc33f8c9-761a-deec-d1e5-ea30c4120729@quicinc.com>
Date:   Mon, 26 Sep 2022 11:21:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [Freedreno] [PATCH v2 10/10] drm/msm/dsi: drop modeset sanity
 checks
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Rob Clark" <robdclark@gmail.com>
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
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Steev Klimaszewski <steev@kali.org>,
        "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>
References: <20220913085320.8577-1-johan+linaro@kernel.org>
 <20220913085320.8577-11-johan+linaro@kernel.org>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20220913085320.8577-11-johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jdPTqfilly7jXArlsXNB_glGgxY0wKGY
X-Proofpoint-ORIG-GUID: jdPTqfilly7jXArlsXNB_glGgxY0wKGY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_09,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 malwarescore=0 phishscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 mlxscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209260114
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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

The change LGTM, hence

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

I think we can use below fixes tag so that we can pick up this entire 
series for the fixes cycle.

Fixes: 3f0689e66352 ("drm/msm/dsi: check msm_dsi and dsi pointers before
use")

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
