Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770E5678AD1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 23:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbjAWWfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 17:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjAWWfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 17:35:02 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976ED38EAE
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 14:34:59 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id hw16so34378294ejc.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 14:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YxnLY9crCokdRJwZ1cSyxopWXEnHeRFdvQXqwCq/JLg=;
        b=tlHGHNwXhG+d5/P861oREM5anvoPyhHVNbQdTZhui7wQRHSLeHzXxAzhIstobqhjLi
         rtvJ/pYgXb/cWnA8QL9zqz7qNX3uUBtEwrLXdSZM0CwL8YOyILW1I8Fkka2BFU+fjrL4
         r4SrZVpSe36iCMJZampFAbqQ98LvGdnYttfjMbOFqJNrV9DY+YQyfBnjc5xms84mFp7f
         Ob8zx1W0G+/M9br4mDKl9YriKhBdS0TGzujgoKDsr8gK7uE5uBXqlk251bWLKIVuSzec
         bE2TI55hnDDU0nY/+Fg10l1nkR0UWAyHA0oRyPdN7o11CUWS8L4HHdKCWFOW23y75G6p
         bFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YxnLY9crCokdRJwZ1cSyxopWXEnHeRFdvQXqwCq/JLg=;
        b=exPqshf4MSXbG0lKYSrCKmNN1IMQZZnEOnx6dhMg2SJ33bswxBhOpM2sgJswkPq5ri
         L1mdYXBlkjy2iWDTcZhr4Zwk0ghylN3teBIt3pOeBUF++jafhgYx6PWLDLN9NANt7p1q
         pIWh34zI6nYj/5krz7BaB/IwduXmDRqKAaiPyyIp6hYY0MnLIEFRLG7dR047O+gE5IAg
         +mraaHhskUAFjX/vCXGkAksQ4XqURj5QcbTMkyVAbjcjkcyK5OJbRJ3kNK+UHTI/XVoZ
         SHQIicwvQtBQppQDgMuCtYzL+vX5hNOg/0fZcO0tsux6b+HbRku91LPjzxjIChLw/eKy
         FSwg==
X-Gm-Message-State: AFqh2kqWCslnt/x3LSBeuNfAWdVWS42h4VN97Kst1/Iibr8BbwpNo3iS
        5OBmm/jd/SzqEOwtu8ijmnYX/Q==
X-Google-Smtp-Source: AMrXdXs/q0SN2iTlfURXLknICueUeQ2KL3YOpAmOmOXhaGSs4EPeAlgu1yjr23YTa3tVLndJjW/kEQ==
X-Received: by 2002:a17:906:5f82:b0:871:45b2:19fb with SMTP id a2-20020a1709065f8200b0087145b219fbmr26131003eju.25.1674513298028;
        Mon, 23 Jan 2023 14:34:58 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id l15-20020a170906a40f00b00877961fbaffsm46173ejz.15.2023.01.23.14.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 14:34:57 -0800 (PST)
Message-ID: <b09871f5-820b-2e1f-7b56-f31786c492bc@linaro.org>
Date:   Tue, 24 Jan 2023 00:34:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v1 03/14] drm/msm/dp: add configure mainlink_levels base
 on lane number
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1674498274-6010-1-git-send-email-quic_khsieh@quicinc.com>
 <1674498274-6010-4-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1674498274-6010-4-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/2023 20:24, Kuogee Hsieh wrote:
> Mainlink_levels determined when two actions to take place by hardware,
> a new BS sequence due to start of video and a static HW MVID is sent
> to panel. This patch add function to configure mainlink level properly
> base on lane number.
> 
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>   drivers/gpu/drm/msm/dp/dp_catalog.c | 37 ++++++++++++++++++++++++++++++++++++-
>   drivers/gpu/drm/msm/dp/dp_catalog.h |  4 +++-
>   drivers/gpu/drm/msm/dp/dp_ctrl.c    |  4 ++++
>   3 files changed, 43 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c b/drivers/gpu/drm/msm/dp/dp_catalog.c
> index 676279d..7ac37d8 100644
> --- a/drivers/gpu/drm/msm/dp/dp_catalog.c
> +++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
> @@ -1,6 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   /*
> - * Copyright (c) 2017-2020, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2017-2023, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2021. Qualcomm Innovation Center, Inc. All rights reserved
>    */
>   
>   #define pr_fmt(fmt)	"[drm-dp] %s: " fmt, __func__
> @@ -359,6 +360,40 @@ void dp_catalog_ctrl_lane_mapping(struct dp_catalog *dp_catalog)
>   			ln_mapping);
>   }
>   
> +void dp_catalog_ctrl_mainlink_levels(struct dp_catalog *dp_catalog,
> +					u8 lane_cnt)
> +{
> +	struct dp_catalog_private *catalog = container_of(dp_catalog,
> +				struct dp_catalog_private, dp_catalog);
> +
> +	u32 mainlink_levels, safe_to_exit_level = 14;
> +
> +	switch (lane_cnt) {
> +	case 1:
> +		safe_to_exit_level = 14;
> +		break;
> +	case 2:
> +		safe_to_exit_level = 8;
> +		break;
> +	case 4:
> +		safe_to_exit_level = 5;
> +		break;
> +	default:
> +		drm_dbg_dp(catalog->drm_dev, "setting the default safe_to_exit_level=%u\n",
> +				safe_to_exit_level);

So, set it here rather than somewhere at the top of the function.

> +		break;
> +	}
> +
> +	mainlink_levels = dp_read_link(catalog, REG_DP_MAINLINK_LEVELS);
> +	mainlink_levels &= 0xFE0;
> +	mainlink_levels |= safe_to_exit_level;
> +
> +	drm_dbg_dp(catalog->drm_dev, "mainlink_level=0x%x, safe_to_exit_level=0x%x\n",
> +		mainlink_levels, safe_to_exit_level);
> +
> +	dp_write_link(catalog, REG_DP_MAINLINK_LEVELS, mainlink_levels);
> +}
> +
>   void dp_catalog_ctrl_mainlink_ctrl(struct dp_catalog *dp_catalog,
>   						bool enable)
>   {
> diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.h b/drivers/gpu/drm/msm/dp/dp_catalog.h
> index 1f717f4..990c162 100644
> --- a/drivers/gpu/drm/msm/dp/dp_catalog.h
> +++ b/drivers/gpu/drm/msm/dp/dp_catalog.h
> @@ -1,6 +1,7 @@
>   /* SPDX-License-Identifier: GPL-2.0-only */
>   /*
> - * Copyright (c) 2017-2020, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2017-2023, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2021. Qualcomm Innovation Center, Inc. All rights reserved
>    */
>   
>   #ifndef _DP_CATALOG_H_
> @@ -92,6 +93,7 @@ u32 dp_catalog_aux_get_irq(struct dp_catalog *dp_catalog);
>   void dp_catalog_ctrl_state_ctrl(struct dp_catalog *dp_catalog, u32 state);
>   void dp_catalog_ctrl_config_ctrl(struct dp_catalog *dp_catalog, u32 config);
>   void dp_catalog_ctrl_lane_mapping(struct dp_catalog *dp_catalog);
> +void dp_catalog_ctrl_mainlink_levels(struct dp_catalog *dp_catalog, u8 lane_cnt);
>   void dp_catalog_ctrl_mainlink_ctrl(struct dp_catalog *dp_catalog, bool enable);
>   void dp_catalog_ctrl_config_misc(struct dp_catalog *dp_catalog, u32 cc, u32 tb);
>   void dp_catalog_ctrl_config_msa(struct dp_catalog *dp_catalog, u32 rate,
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index dd26ca6..959a78c 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -161,6 +161,8 @@ static void dp_ctrl_configure_source_params(struct dp_ctrl_private *ctrl)
>   	u32 cc, tb;
>   
>   	dp_catalog_ctrl_lane_mapping(ctrl->catalog);
> +	dp_catalog_ctrl_mainlink_levels(ctrl->catalog,
> +				ctrl->link->link_params.num_lanes);
>   	dp_catalog_ctrl_mainlink_ctrl(ctrl->catalog, true);
>   
>   	dp_ctrl_config_ctrl(ctrl);
> @@ -1296,6 +1298,8 @@ static int dp_ctrl_setup_main_link(struct dp_ctrl_private *ctrl,
>   {
>   	int ret = 0;
>   
> +	dp_catalog_ctrl_mainlink_levels(ctrl->catalog,
> +				ctrl->link->link_params.num_lanes);
>   	dp_catalog_ctrl_mainlink_ctrl(ctrl->catalog, true);
>   
>   	if (ctrl->link->sink_request & DP_TEST_LINK_PHY_TEST_PATTERN)

-- 
With best wishes
Dmitry

