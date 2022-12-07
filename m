Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6DA64622E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 21:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiLGUN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 15:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiLGUN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 15:13:27 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B770B2F387
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 12:13:25 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id cf42so24644432lfb.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 12:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wVVhjsKNZ110uihq4o15WbXBuFAJxL7HSRoRDMGRsAY=;
        b=D+O6QwDXnzj3Qj99Yu3Iwzt/hjB6AUqp0FkJde2gGViZZGJ+64qxPZsFpe/v/EqHuk
         CFY+5zz1axumiZuHQYIsPVo6Hx9qzvewkgoBSZljEUzdgiLgZg5DvzYcsziTszD/eYrm
         IfhEYjOHK7NoR0yvmyOhjHvtfQlaRoPbqlxbPrVQPZVjJEiok2m/0xZOGTjEOXCZn5K2
         vacTsOd4dI1JQ9XX+N38CXMqhNNycNLFQ7sE8cPsXS58PSZzrM2EXRvNkimexnz8GCOl
         KZu/IoGqobMloRxJCQYYlh/KaQYDV6OOaxaDOfzt9EuDeLsZpmXiKPjfSdFWIyozoKJE
         yNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wVVhjsKNZ110uihq4o15WbXBuFAJxL7HSRoRDMGRsAY=;
        b=fyqtp46wGOu44afGNsyBz8g2/kOvBl9g3BJusEaMT+uCUge/jf6We7uB4bdO0hCJ5m
         z7AfmD5bAsNeOxp43NeDTAqp2wyfII96zflOh8E1aCnquG5wJq/TJghaO5Rer+rHkdmL
         0eI3FvCxRvaLBY1i/o6ylN/x1PAKmso3AF7E0VY72KOXDmoSdkiSu2Q/ZtSwoNA8zMOE
         MQMK0CGmFB6zsgrld7Mix3f9u2I3MD/lVeKSIDaW4J5cVF+uOef5Uhj7DzpK9dltxEwo
         0Fa83ytftWBZqkn6djXO4qsvgYB3Co5qlskmiloWkyRNpsyTokYSHexzUHGQ/gImuVEt
         NbsQ==
X-Gm-Message-State: ANoB5pmF92g4cb5SDuUvvo/vQDjO1dUjafx7ztTNwFwcoXQgTzp/ydYe
        o0Sw602q0oeIBdMaeKiZEj5lWw==
X-Google-Smtp-Source: AA0mqf7JoScIJJQdmqKUzoSq0YX20EvSrl9WjrveHwsafWCUiTZfwCKztEInSYOc8oM3yv8kYBk3yg==
X-Received: by 2002:a05:6512:3e23:b0:4b5:8f93:c129 with SMTP id i35-20020a0565123e2300b004b58f93c129mr1854617lfv.188.1670444004117;
        Wed, 07 Dec 2022 12:13:24 -0800 (PST)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id o17-20020ac24e91000000b004a2550db9ddsm2993654lfr.245.2022.12.07.12.13.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 12:13:23 -0800 (PST)
Message-ID: <d17a595c-9561-1efa-b72e-15c535ef31eb@linaro.org>
Date:   Wed, 7 Dec 2022 22:13:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v10 4/5] drm/msm/dp: parser link-frequencies as property
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
References: <1670432278-30643-1-git-send-email-quic_khsieh@quicinc.com>
 <1670432278-30643-5-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1670432278-30643-5-git-send-email-quic_khsieh@quicinc.com>
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

On 07/12/2022 18:57, Kuogee Hsieh wrote:
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
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>   drivers/gpu/drm/msm/dp/dp_parser.c | 27 +++++++++++++++++++++++++++
>   drivers/gpu/drm/msm/dp/dp_parser.h |  2 ++
>   2 files changed, 29 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_parser.c b/drivers/gpu/drm/msm/dp/dp_parser.c
> index b5f7e70..9398abe 100644
> --- a/drivers/gpu/drm/msm/dp/dp_parser.c
> +++ b/drivers/gpu/drm/msm/dp/dp_parser.c
> @@ -91,6 +91,28 @@ static int dp_parser_ctrl_res(struct dp_parser *parser)
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

if (!endpoint)
   return -ENODEV; (or 0, as you have u32)

It's much easier IMO.

> +	if (endpoint)
> +		cnt = of_property_count_u64_elems(endpoint, "link-frequencies");
> +
> +	if (cnt > 0) {
> +		of_property_read_u64_index(endpoint, "link-frequencies",
> +						cnt - 1, &frequency);
> +		frequency /= 10;	/* from symbol rate to link rate */
> +		frequency /= 1000;	/* kbits */

kbytes?

> +	}
> +
> +	of_node_put(endpoint);

Even easier:

cnt = of_property_count(...);
if (cnt > 0)
     of_property_read_u64_index(...);
of_node_put(endpoint);

frequency /= 10;
frequency /= 1000;

return frequency;

> +
> +	return (u32)frequency;
> +}
> +
>   static int dp_parser_misc(struct dp_parser *parser)
>   {
>   	struct device_node *of_node = parser->pdev->dev.of_node;
> @@ -113,6 +135,11 @@ static int dp_parser_misc(struct dp_parser *parser)
>   			parser->max_dp_lanes = DP_MAX_NUM_DP_LANES; /* 4 lanes */
>   	}
>   
> +	parser->max_dp_link_rate = dp_parser_link_frequencies(of_node);
> +

Drop the empty line please. The if checks the result of the previous 
assignment. It's easier to comprehend if they visually belong to the 
same code block.

> +	if (!parser->max_dp_link_rate)
> +                parser->max_dp_link_rate = DP_LINK_RATE_HBR2; /* 540000 khz */
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

