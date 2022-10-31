Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E09613DA2
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 19:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiJaSqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 14:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiJaSq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 14:46:26 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7637213E28
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 11:46:19 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id l8so6898920ljh.13
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 11:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S11pSJe+3m2UZvWKILOfbSaBNiczaTBDXuv2aL1IhrU=;
        b=Hv7Gt7yt1ZrenkBrV/xTf8N345bQcji16EmWnFa8k+bSW6LnFpsJAZsZlm+NEpNEBx
         SZ9lY9tZ5dR9KGxRJ3Ya9Gl+D7Rr3GkTDpjk7DLX0Vng9fIhKgCmvjclE5HjnwMTQlgp
         +V1ZXsBjO2bueOR08NYmrsm4Wi6uAkx38Us6M8dss4j+yXsNe0XGqhxUNpBELMT2LeO3
         QfaIAXINetaOQiOlHX/Oqt6yCEir/6w1zgZghKvkMO3jb3/aeqvOcfzSNJYvKVbew5Ax
         iEF98VaLdwSvJUW5SWx6AW8Nk7Vr4w9+fWiQMpyQTZN32CCfOssqygyfo7xxuDt0khvg
         1fcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S11pSJe+3m2UZvWKILOfbSaBNiczaTBDXuv2aL1IhrU=;
        b=Ub1TGi8NHBTDnpa4T8kVqzuMA/LUy+5tYtemXAwC+i3jl70gcJf9c3xIpWr1uR5fbg
         z9awQ79SceFP5qGXHwpXbfLzht+Wa1HsxKWKEL5/45fOY9UOoat9zEopvJTIPO0MHZ22
         IwNItv+SYaVxrwsF0OMVqWJVRaXLe7k74zc11Wt+prPD9JjiYHWDHnq3rciDEcpNTQjh
         NU3g4vggImK/tp8LD8EKRiQ193qLldAW1/KmRuOgGvF75p0L05aorH9wtlKoLoaezdqu
         Vf8W5UldLfv7uRACylOFz/y/JlYAe92jgJQ/yyz2ze3kWzwI3lskjXjknzEmK5d5CDq1
         V53w==
X-Gm-Message-State: ACrzQf29DM35+9NQw5VXfbZcWJnwKOJd2/HG1ClLXed4rxtIPBarJ6RJ
        puRwZEbPSz9M8Ma5LEzC624nXA==
X-Google-Smtp-Source: AMsMyM6BASxniPfNeXTgSwyK8JDlvyz9PL/6j9II+ZUjwQkNjuL0WuoM6HN06stv0Fz/4hUFu7NW/g==
X-Received: by 2002:a05:651c:1073:b0:277:35ca:5eef with SMTP id y19-20020a05651c107300b0027735ca5eefmr5940508ljm.150.1667241977777;
        Mon, 31 Oct 2022 11:46:17 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id p10-20020a2ea4ca000000b0026daf4fc0f7sm1457506ljm.92.2022.10.31.11.46.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 11:46:17 -0700 (PDT)
Message-ID: <94b507e8-5b94-12ae-4c81-95f5d36279d5@linaro.org>
Date:   Mon, 31 Oct 2022 21:46:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] drm/msm/dp: remove limitation of link rate at 5.4G to
 support HBR3
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        agross@kernel.org, bjorn.andersson@linaro.org
Cc:     quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1667237245-24988-1-git-send-email-quic_khsieh@quicinc.com>
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1667237245-24988-1-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/2022 20:27, Kuogee Hsieh wrote:
> An HBR3-capable device shall also support TPS4. Since TPS4 feature
> had been implemented already, it is not necessary to limit link
> rate at HBR2 (5.4G). This patch remove this limitation to support
> HBR3 (8.1G) link rate.

The DP driver supports several platforms including sdm845 and can 
support, if I'm not mistaken, platforms up to msm8998/sdm630/660. Could 
you please confirm that all these SoCs have support for HBR3?

With that fact being confirmed:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


> 
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>   drivers/gpu/drm/msm/dp/dp_panel.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
> index 5149ceb..3344f5a 100644
> --- a/drivers/gpu/drm/msm/dp/dp_panel.c
> +++ b/drivers/gpu/drm/msm/dp/dp_panel.c
> @@ -78,10 +78,6 @@ static int dp_panel_read_dpcd(struct dp_panel *dp_panel)
>   	if (link_info->num_lanes > dp_panel->max_dp_lanes)
>   		link_info->num_lanes = dp_panel->max_dp_lanes;
>   
> -	/* Limit support upto HBR2 until HBR3 support is added */
> -	if (link_info->rate >= (drm_dp_bw_code_to_link_rate(DP_LINK_BW_5_4)))
> -		link_info->rate = drm_dp_bw_code_to_link_rate(DP_LINK_BW_5_4);
> -
>   	drm_dbg_dp(panel->drm_dev, "version: %d.%d\n", major, minor);
>   	drm_dbg_dp(panel->drm_dev, "link_rate=%d\n", link_info->rate);
>   	drm_dbg_dp(panel->drm_dev, "lane_count=%d\n", link_info->num_lanes);

-- 
With best wishes
Dmitry

