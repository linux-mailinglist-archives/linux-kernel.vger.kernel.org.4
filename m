Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36CB66479A7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 00:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiLHXRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 18:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiLHXRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 18:17:17 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F6E9D88D
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 15:17:16 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id c1so4385903lfi.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 15:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oCsKRmRYTaUN175iSQ+8CzQ2o2D9diPnWoiAzSTDmos=;
        b=BYb25JT1/vslYb1DVLQqLM2ML3g0LWdH5/ndWyCIwBRipkTd9axxTKxTKlNbz2vQMy
         DrqG+oxmI+U6ZL6iDFVGaNypyQ4WimpRF9/nGRaIM85Iaezq9GLkBZqmVrGhXGvxQOm8
         xAcDOs9HLWTaIS5TLAj0oIYXKmP/pY+Bn5mQ87Embw9cX0dHZF6XkN6eZ4fgdJfIy17+
         2IJhGmjRLLg1JijE1FBp7PenToFQMj/cI42N2sUl2N+fKF+CStWxgUflSYe5qyUYnZ9H
         01AplyEft30KlGoXeuIldop66n0dfONjmGWX0uc8N8EpvE+8MkNbJ8dqrcAK6o2ph2Cl
         Bxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oCsKRmRYTaUN175iSQ+8CzQ2o2D9diPnWoiAzSTDmos=;
        b=QtUK96yeYy/4dRoVPqGBC1eIoXADySoLBGrnLuoGboOyMQOnupQt+BEVtN3CqWiyZb
         vf3Coy8k7RHAINFG6PXJLHfq//FGJ4HVB7XQHXQUlKo7UoI8RjQzuXFoJXgABS5Giyvm
         HgUJ+qLm1IJe/o3Vl5J/2dv0qsAJUUlzxNyJ/ssAnZFy3M5hT25c/EdIqapfpf+bG6c2
         fTv+kqW23zqGD7Zt1tHPTlXmGnUVdPIs5i2vr5p/P45z2b6lKPFSlUWEzT69solBMEcg
         4UWtmGi8B+k6jJHXzMU5sTkMxCQojr/yZp4i1AMH6Zg9st+JLduPDS3TltKHBOzjK1qw
         FAYQ==
X-Gm-Message-State: ANoB5pko+jODgcu3JBAntKRs+1ja9Xpg4Jj+XllDbi9yc7j8A4iHzi7A
        VvIQu4Ib8ZwvM/Wdd8x83vhoYw==
X-Google-Smtp-Source: AA0mqf64HHvBQnvh8Ga6+ZAmOSUnUf2eZ3LsaDK2t12dZu2v75LfbBkHvla/5YT+ih76Hp88Yyg7aA==
X-Received: by 2002:a05:6512:2a9a:b0:4a4:68b9:6091 with SMTP id dt26-20020a0565122a9a00b004a468b96091mr883514lfb.28.1670541434323;
        Thu, 08 Dec 2022 15:17:14 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id v4-20020a056512348400b004b097f2c73dsm3521105lfr.253.2022.12.08.15.17.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 15:17:13 -0800 (PST)
Message-ID: <e12f53ca-6934-fc9d-c99c-6859628238a1@linaro.org>
Date:   Fri, 9 Dec 2022 01:17:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v11 4/5] drm/msm/dp: parser link-frequencies as property
 of dp_out endpoint
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        airlied@gmail.com
Cc:     quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1670539015-11808-1-git-send-email-quic_khsieh@quicinc.com>
 <1670539015-11808-5-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1670539015-11808-5-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2022 00:36, Kuogee Hsieh wrote:
> Add capability to parser and retrieve max DP link supported rate from
> link-frequencies property of dp_out endpoint.
> 
> Changes in v6:
> -- second patch after split parser patch into two patches
> 
> Changes in v7:
> -- without checking cnt against DP_MAX_NUM_DP_LANES to retrieve link rate
> 
> Changes in v9:
> -- separate parser link-frequencies out of data-lanes
> 
> Changes in v10:
> -- add dp_parser_link_frequencies()
> 
> Changes in v11:
> -- return 0 if(!endpoint)
> 
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>   drivers/gpu/drm/msm/dp/dp_parser.c | 27 +++++++++++++++++++++++++++
>   drivers/gpu/drm/msm/dp/dp_parser.h |  2 ++
>   2 files changed, 29 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_parser.c b/drivers/gpu/drm/msm/dp/dp_parser.c
> index b5f7e70..9a7dcd4 100644
> --- a/drivers/gpu/drm/msm/dp/dp_parser.c
> +++ b/drivers/gpu/drm/msm/dp/dp_parser.c
> @@ -91,6 +91,29 @@ static int dp_parser_ctrl_res(struct dp_parser *parser)
>   	return 0;
>   }
>   
> +static u32 dp_parser_link_frequencies(struct device_node *of_node)
> +{
> +	struct device_node *endpoint;
> +	u64 frequency = 0;
> +	int cnt = 0;
> +
> +	endpoint = of_graph_get_endpoint_by_regs(of_node, 1, 0); /* port@1 */
> +	if (!endpoint)
> +		return 0;
> +
> +	cnt = of_property_count_u64_elems(endpoint, "link-frequencies");
> +
> +	if (cnt > 0)
> +		of_property_read_u64_index(endpoint, "link-frequencies",
> +						cnt - 1, &frequency);
> +	of_node_put(endpoint);
> +
> +	frequency /= 10;	/* from symbol rate to link rate */
> +	frequency /= 1000;	/* kbytes */
> +
> +	return frequency;
> +}
> +
>   static int dp_parser_misc(struct dp_parser *parser)
>   {
>   	struct device_node *of_node = parser->pdev->dev.of_node;
> @@ -113,6 +136,10 @@ static int dp_parser_misc(struct dp_parser *parser)
>   			parser->max_dp_lanes = DP_MAX_NUM_DP_LANES; /* 4 lanes */
>   	}
>   
> +	parser->max_dp_link_rate = dp_parser_link_frequencies(of_node);
> +	if (!parser->max_dp_link_rate)
> +                parser->max_dp_link_rate = DP_LINK_RATE_HBR2; /* 540000 khz */

Drop the comment please. One can jump to the defined value to see what 
is it equal to. So it adds no information.

> +
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/msm/dp/dp_parser.h b/drivers/gpu/drm/msm/dp/dp_parser.h
> index 866c1a8..6b10c3e 100644
> --- a/drivers/gpu/drm/msm/dp/dp_parser.h
> +++ b/drivers/gpu/drm/msm/dp/dp_parser.h
> @@ -15,6 +15,7 @@
>   #define DP_LABEL "MDSS DP DISPLAY"
>   #define DP_MAX_PIXEL_CLK_KHZ	675000
>   #define DP_MAX_NUM_DP_LANES	4
> +#define DP_LINK_RATE_HBR2	540000 /* khz */

kbytes, not kHz. Otherwise it would have been 5400000.

>   
>   enum dp_pm_type {
>   	DP_CORE_PM,
> @@ -119,6 +120,7 @@ struct dp_parser {
>   	struct dp_io io;
>   	struct dp_display_data disp_data;
>   	u32 max_dp_lanes;
> +	u32 max_dp_link_rate;
>   	struct drm_bridge *next_bridge;
>   
>   	int (*parse)(struct dp_parser *parser);

-- 
With best wishes
Dmitry

