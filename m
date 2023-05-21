Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEB570ABCF
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 02:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjEUAdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 20:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjEUAdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 20:33:01 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6712D11F
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 17:32:59 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so5450765e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 17:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684629177; x=1687221177;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G3uuYxIoPYNrOC1RBCXLMlGdrVKTR3wnYntMo8NNIZM=;
        b=BfTFlPe2xV3aji16iKRh7WC2D3dbWE6lhlw79qTmX0vyZM5eIE2iBVTK+rTwNl2XGf
         CW7sZt5KaaA2J4poM+vCyG4xeWVE2YXbllr7r44JmUDvIsCbvMUjRcY+tKasUHknue10
         T6H01w0D+5KluHD8vMYwHMpPK+aHILHQP7wmwBEIbD7JFt7VmdjAV67DS5jy5MKO8QKj
         f77sl6HDhi5/RU9LqJ43ndSX/018q1VSaHcpkDRroWK0sohQlwFuch1Q6RVLwdGa51Zn
         AJL09GmmVMkI3Tty0YVwpG1ezaiKL+C87FrOo8TkBSr41TOxjD3edkGwmImwv7h6l7AG
         s3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684629177; x=1687221177;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G3uuYxIoPYNrOC1RBCXLMlGdrVKTR3wnYntMo8NNIZM=;
        b=YYWGIbtD3m4JDxzUUZkCnKPS1lWS3VAxOm5qTAY0O1NP5mDFNioDhnGQYZFWNWfa4P
         yBwyRL+VKoLFyry6zFI6LmYDU0rZMOPbWhwVYXJtWtZ+gJCSS7wvD6y33ClTOCbiefl8
         7dkdabLsv3p+lPeZmyOSyOqsqYiKNVtaxSbEQAhyMF+G4Qbqa353NMuclfiZzoPwmQHs
         KAy/UGkWe2eWEfdDl2JApOuS/tSLlqsqOqA0uMxZuvJdnIh13p7sMzJKsh9GLIJruOOx
         DTaepP6oB0GTXaeUIAOc/fC7VVaCa8ZOD0hxJ7kFR8+d0urfsySqajVSz6deBiS/MJj5
         X/Yg==
X-Gm-Message-State: AC+VfDylHerfRdhKT5tVfLyAQEEepKOIi3yM42c3AlV7+YvEP0uHj/sh
        /ugY7j9Kdn+QHKMqBNGmVMtn/Q==
X-Google-Smtp-Source: ACHHUZ5SSdnUNDaNEjwE1peJA2i4C4sRCQuop8shpgIeWclGYJj50GbLZxA75Gj1dxFXnjdRdqSrmQ==
X-Received: by 2002:ac2:5d24:0:b0:4eb:104b:bf61 with SMTP id i4-20020ac25d24000000b004eb104bbf61mr2035554lfb.58.1684629177669;
        Sat, 20 May 2023 17:32:57 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id j1-20020a19f501000000b004e83fbba141sm423743lfb.164.2023.05.20.17.32.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 May 2023 17:32:56 -0700 (PDT)
Message-ID: <1e77e954-570f-e995-ce79-99560fde8d34@linaro.org>
Date:   Sun, 21 May 2023 03:32:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 5/5] drm/msm/dsi: Remove incorrect references to
 slice_count
Content-Language: en-GB
To:     Jessica Zhang <quic_jesszhan@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230405-add-dsc-support-v3-0-6e1d35a206b3@quicinc.com>
 <20230405-add-dsc-support-v3-5-6e1d35a206b3@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230405-add-dsc-support-v3-5-6e1d35a206b3@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/2023 00:17, Jessica Zhang wrote:
> Currently, slice_count is being used to calculate word count and
> pkt_per_line. In downstream, these values are calculated using slice per
> packet, which is not the same as slice_count.

I'd say the reference to downstream is not correct. We have seen cases 
where the vendor kernel contained errors. So it should be something like 
"Instead these values should be calculated using ...."

> 
> Slice count represents the number of soft slices per interface, and its
> value will not always match that of slice per packet. For example, it is
> possible to have cases where there are multiple soft slices per interface
> but the panel specifies only one slice per packet.
> 
> Thus, use the default value of one slice per packet and remove slice_count
> from the aforementioned calculations.
> 
> Fixes: 08802f515c3c ("drm/msm/dsi: Add support for DSC configuration")
> Fixes: bc6b6ff8135c ("drm/msm/dsi: Use DSC slice(s) packet size to compute word count")
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>   drivers/gpu/drm/msm/dsi/dsi_host.c | 24 ++++++++++++++----------
>   1 file changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index d04f8bbd707d..8c8858ee59ec 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -866,18 +866,15 @@ static void dsi_update_dsc_timing(struct msm_dsi_host *msm_host, bool is_cmd_mod
>   	 */
>   	slice_per_intf = msm_dsc_get_slices_per_intf(dsc, hdisplay);
>   
> -	/*
> -	 * If slice_count is greater than slice_per_intf
> -	 * then default to 1. This can happen during partial
> -	 * update.
> -	 */
> -	if (dsc->slice_count > slice_per_intf)
> -		dsc->slice_count = 1;
> -
>   	total_bytes_per_intf = dsc->slice_chunk_size * slice_per_intf;
>   
>   	eol_byte_num = total_bytes_per_intf % 3;
> -	pkt_per_line = slice_per_intf / dsc->slice_count;
> +
> +	/*
> +	 * Default to 1 slice_per_pkt, so pkt_per_line will be equal to
> +	 * slice per intf.
> +	 */
> +	pkt_per_line = slice_per_intf;
>   
>   	if (is_cmd_mode) /* packet data type */
>   		reg = DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM0_DATATYPE(MIPI_DSI_DCS_LONG_WRITE);
> @@ -1001,7 +998,14 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>   		if (!msm_host->dsc)
>   			wc = hdisplay * dsi_get_bpp(msm_host->format) / 8 + 1;
>   		else
> -			wc = msm_host->dsc->slice_chunk_size * msm_host->dsc->slice_count + 1;
> +			/*
> +			 * When DSC is enabled, WC = slice_chunk_size * slice_per_packet + 1.
> +			 * Currently, the driver only supports default value of slice_per_packet = 1
> +			 *
> +			 * TODO: Expand mipi_dsi_device struct to hold slice_per_packet info
> +			 *       and adjust DSC math to account for slice_per_packet.
> +			 */
> +			wc = msm_host->dsc->slice_chunk_size + 1;
>   
>   		dsi_write(msm_host, REG_DSI_CMD_MDP_STREAM0_CTRL,
>   			DSI_CMD_MDP_STREAM0_CTRL_WORD_COUNT(wc) |
> 

-- 
With best wishes
Dmitry

