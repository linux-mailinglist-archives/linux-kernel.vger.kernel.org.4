Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D0164F1F2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 20:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbiLPTqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 14:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbiLPTqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 14:46:39 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D035511A26
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 11:46:37 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id bf43so5005878lfb.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 11:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4tu904MKHl4wlHKTZTyOl2mc2CnxBACoWjclSh2uBUU=;
        b=mlxkDAyQtKgDDQHCxiGBylV5M8jE6Y2EUKneYivBKiBAkYxKtUdSFMV6q4inN0WS4k
         wvRNf46MJ4V2YzvgMq/MEW8u9jAZpG06DlFa+aLLfHxR1hNT4uqpqsbl4yopwqyVUM00
         omfFYKf2iVG6NyPpk1J1g8NJfcTgxfvb4M5q7fgMNVgCxcfBk7NO6f1jpaWOIqmJzB27
         n76xsjSQVt3/2j3fAy49c0GymMaJFvBCzmmQdHrU9iHfTap16V6Q+CatNEffN7cWB6qM
         7EikkHTMsmlLei9B0FoWlb2bf8BW5SXWYHGwoklmgOuq6Ua0c6pkXZ0gjS2kJgNDaYaB
         XMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4tu904MKHl4wlHKTZTyOl2mc2CnxBACoWjclSh2uBUU=;
        b=u28F0YJ17PMQ7aBULwHgRcHD3gogsVstXS9XzexPyFHSfQsFJGQ+zr473/kSRqO42G
         gtDzt4TaIOQzzEicxSPXtoYaz3NaDTzPSBTj8ofPKYXrGNiRDZ+PLE2RNKRIVw3Iy4/6
         pb+KqME3hwtA3Aa/utg/Q79GbzKC0objwrTfW/uyKn4musmBliVe3dKZghSNBAwKXzGh
         imbrgUREMsS25BE6S6y5DFLngMG4sy6rJv8QDDzghPHzOHgFvg8ikVqL/WtdiPfRPj11
         jLuHk2nhKgqu/A8mEFAbGvG4WJKNylSbPUjUJypRFZ3+2DTTnDEiP0B9Bvdu8pCzwDQb
         VMbg==
X-Gm-Message-State: ANoB5pkbeyZB6vOS8903fW/JaneJFCl11Xj3lIXDqfdXwF+Y3vwa8G6h
        d3CYMnEM6mGJzh8DwO3YokwQEQ==
X-Google-Smtp-Source: AA0mqf5lUG97cEpxdK/0zmN3VLq6wwUkQGiOk1cz8eYzEKl6ZpaDwTMCX83ITUPLsAq/RJ9UEGt/8Q==
X-Received: by 2002:a05:6512:39c2:b0:4b4:e4a1:2fc6 with SMTP id k2-20020a05651239c200b004b4e4a12fc6mr10880035lfu.68.1671219996137;
        Fri, 16 Dec 2022 11:46:36 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id c20-20020ac25f74000000b004b6e157d326sm294500lfc.168.2022.12.16.11.46.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 11:46:35 -0800 (PST)
Message-ID: <bfa99e8c-d413-b52f-f026-000720b01307@linaro.org>
Date:   Fri, 16 Dec 2022 21:46:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v14 3/5] drm/msm/dp: parse data-lanes as property of
 dp_out endpoint
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, airlied@gmail.com
Cc:     quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1671217893-17496-1-git-send-email-quic_khsieh@quicinc.com>
 <1671217893-17496-4-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1671217893-17496-4-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/12/2022 21:11, Kuogee Hsieh wrote:
> Add capability to parser data-lanes as property of dp_out endpoint.
> Also retain the original capability to parser data-lanes as property
> of mdss_dp node to handle legacy case.
> 
> Changes in v6:
> -- first patch after split parser patch into two
> 
> Changes in v7:
> -- check "data-lanes" from endpoint first
> 
> Changes in v14:
> -- replace "parser" with "parse" at commit subject
> -- add matching brackets at dp_parser_misc()
> 
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/gpu/drm/msm/dp/dp_parser.c | 25 +++++++++++++++++--------
>   1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_parser.c b/drivers/gpu/drm/msm/dp/dp_parser.c
> index dd73221..d42987a 100644
> --- a/drivers/gpu/drm/msm/dp/dp_parser.c
> +++ b/drivers/gpu/drm/msm/dp/dp_parser.c
> @@ -94,16 +94,25 @@ static int dp_parser_ctrl_res(struct dp_parser *parser)
>   static int dp_parser_misc(struct dp_parser *parser)
>   {
>   	struct device_node *of_node = parser->pdev->dev.of_node;
> -	int len;
> -
> -	len = drm_of_get_data_lanes_count(of_node, 1, DP_MAX_NUM_DP_LANES);
> -	if (len < 0) {
> -		DRM_WARN("Invalid property \"data-lanes\", default max DP lanes = %d\n",
> -			 DP_MAX_NUM_DP_LANES);
> -		len = DP_MAX_NUM_DP_LANES;
> +	int cnt;
> +
> +	/*
> +	 * data-lanes is the property of dp_out endpoint
> +	 */
> +	cnt = drm_of_get_data_lanes_count_ep(of_node, 1, 0, 1, DP_MAX_NUM_DP_LANES);
> +	if (cnt > 0) {
> +		parser->max_dp_lanes = cnt;
> +	} else {
> +		/*
> +		 * legacy code, data-lanes is the property of mdss_dp node
> +		 */
> +		cnt = drm_of_get_data_lanes_count(of_node, 1, DP_MAX_NUM_DP_LANES);
> +		if (cnt > 0)
> +			parser->max_dp_lanes = cnt;
> +		else
> +			parser->max_dp_lanes = DP_MAX_NUM_DP_LANES; /* 4 lanes */

This bugged me for some time.

I think the following piece of code is easier to understand and handle:

cnt = drm_of_get_data_lanes_count_ep(...);

/* legacy, data-lanes property of the mdss_dp node */
if (cnt < 0)
     cnt = drm_of_get_data_lanes_count(.....);

if (cnt > 0)
     parser->max_dp_lanes = cnt;
else
     parser->max_dp_lanes = DP_MAX_NUM_DP_LANES;



>   	}
>   
> -	parser->max_dp_lanes = len;
>   	return 0;
>   }
>   

-- 
With best wishes
Dmitry

