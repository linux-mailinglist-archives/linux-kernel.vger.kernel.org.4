Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B1963E5E1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 00:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiK3X6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 18:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiK3X6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 18:58:16 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503C14A9E2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 15:58:15 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id h10so59530ljk.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 15:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jO8nXDV58mXkso9ZU1/d1ihgDXy7YP60Vhf2BkvzF7w=;
        b=XxxJfDWdCxAhpELeMOamNXvu9KcKqStzqg/qwaA1hN8IvqgHqv6LfFB1ANWrVfkZU+
         bRFhHHnHGqc/bD99ukBp2WxIa87RaF4EWP38sIjoZu9ZbU0ZM8ld4q46YYTW8jZ6PDWz
         9oUwMicFBQ5/bm1DREbqHZonoxek7/iGwjI2AwV7aNT0RmC6QIgbypD1lZINNG5LToY8
         EfrHZNlPVmawBXC5txAtMzRBFcQzntYSRrcdR68Bxg6AXMDYUEUff9Ya2GuL/0HA8ftc
         UPwWLI55uGjeuJCsb4t2B5g56ztxZHsuXz9gEJFpbeEYRE++k6RLSFEfI7iwSEZgXjzv
         qXCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jO8nXDV58mXkso9ZU1/d1ihgDXy7YP60Vhf2BkvzF7w=;
        b=0ZoxKrvWGXaGPnJyqcIdDMD72Z1hAVTPDqsE5oHPaBpTxq3NTdd/dL37UGZKe/tXQd
         Q64gIex8L6j/YC0AZYPaYJ1X33nOI+PzyejaVmdcRRgeY41SASfNaOPcxZJyesMUSBuB
         ev4liEskbz+4H7JD0caAbESZl3QTnliZSX6PQnuJRptgxb1VJbO9b6cq2v4eVl2T25PN
         6jHD5ldyWeOI24ISf+Op7KsYWVksn75x06kV3m7QaV8MiBp7C0IkICCWl5HcKZXxalnH
         NQSnHTLFF7vdoJIZTttwM3p2hLijqK5c8sNkAhE0FFFjHO3uekiEFuduQR71suwhd6/Z
         wc+A==
X-Gm-Message-State: ANoB5pnfPcAmBCzXxfEw6/y18PEg1qJ3AEMGz/l3RWL3JotEE3nA3TSA
        jKHk1PXm+5Zq9gTrgOHGTTNHVQ==
X-Google-Smtp-Source: AA0mqf4CRsX1JYhgTQ1nD8I3uKIXrcY4b5xxYBCLdMzNHNgsIkpPn1zxR/eMXR0GKObqz2JgnTgh0Q==
X-Received: by 2002:a2e:a375:0:b0:277:7c00:e130 with SMTP id i21-20020a2ea375000000b002777c00e130mr13190727ljn.268.1669852693637;
        Wed, 30 Nov 2022 15:58:13 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id f33-20020a0565123b2100b00494643db68fsm423005lfv.81.2022.11.30.15.58.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 15:58:13 -0800 (PST)
Message-ID: <50405292-d6c1-d9ee-20fe-46f4feee6d9c@linaro.org>
Date:   Thu, 1 Dec 2022 01:58:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v6 2/4] drm/msm/dp: parser data-lanes as property of
 dp_out endpoint
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        agross@kernel.org, bjorn.andersson@linaro.org
Cc:     quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1669852310-22360-1-git-send-email-quic_khsieh@quicinc.com>
 <1669852310-22360-3-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1669852310-22360-3-git-send-email-quic_khsieh@quicinc.com>
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

On 01/12/2022 01:51, Kuogee Hsieh wrote:
> Add capability to parser data-lanes as property of dp_out endpoint.
> Also retain the original capability to parser data-lanes as property
> of mdss_dp node to handle legacy case.
> 
> Changes in v6:
> -- first patch after split parser patch into two
> 
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>   drivers/gpu/drm/msm/dp/dp_parser.c | 30 +++++++++++++++++++++++-------
>   1 file changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_parser.c b/drivers/gpu/drm/msm/dp/dp_parser.c
> index dd73221..b06ff60 100644
> --- a/drivers/gpu/drm/msm/dp/dp_parser.c
> +++ b/drivers/gpu/drm/msm/dp/dp_parser.c
> @@ -94,16 +94,32 @@ static int dp_parser_ctrl_res(struct dp_parser *parser)
>   static int dp_parser_misc(struct dp_parser *parser)
>   {
>   	struct device_node *of_node = parser->pdev->dev.of_node;
> -	int len;
> +	struct device_node *endpoint;
> +	int cnt;
> +
> +	/*
> +	 * legacy code, data-lanes is the property of mdss_dp node
> +	 */
> +	cnt = drm_of_get_data_lanes_count(of_node, 1, DP_MAX_NUM_DP_LANES);
> +	if (cnt > 0) {
> +		parser->max_dp_lanes = cnt;
> +		return 0;
> +	}
>   
> -	len = drm_of_get_data_lanes_count(of_node, 1, DP_MAX_NUM_DP_LANES);
> -	if (len < 0) {
> -		DRM_WARN("Invalid property \"data-lanes\", default max DP lanes = %d\n",
> -			 DP_MAX_NUM_DP_LANES);
> -		len = DP_MAX_NUM_DP_LANES;
> +	/*
> +	 * data-lanes is the property of dp_out endpoint
> +	 */
> +	endpoint = of_graph_get_endpoint_by_regs(of_node, 1, 0); /* port@1 */
> +	if (endpoint) {
> +		cnt = of_property_count_u32_elems(endpoint, "data-lanes");

drm_of_get_data_lanes_count(), or better drm_of_get_data_lanes_count_ep().

Also please check new property first, then check the legacy one.

So it would be:

cnt = drm_of_get_data_lanes_count_ep();
if (cnt < 0)
     cnt = drm_of_get_data_lanes_count();
if (cnt < 0) {
     DRM_WARN(...);
     cnt = DP_MAX_NUM_DP_LANES;
}


> +		if (cnt < 0)
> +			parser->max_dp_lanes = DP_MAX_NUM_DP_LANES; /* 4 lanes */
> +		else
> +			parser->max_dp_lanes = cnt;
> +	} else {
> +		parser->max_dp_lanes = DP_MAX_NUM_DP_LANES; /* 4 lanes */
>   	}
>   
> -	parser->max_dp_lanes = len;
>   	return 0;
>   }
>   

-- 
With best wishes
Dmitry

