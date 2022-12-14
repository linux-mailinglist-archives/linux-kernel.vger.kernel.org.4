Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C52A64C0FF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 01:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236318AbiLNACZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 19:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235771AbiLNACV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 19:02:21 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF21E22B18
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 16:02:19 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id y25so7695866lfa.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 16:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F4wzLNz6dwbsx5heN6y8ApOHwBgCymyPsBRS4COOYFM=;
        b=cz6w9iekOtz1phgLx4mKtqjxhJ5PKY8yopabUl8Vl8TR8IfUTFb1WeZ/L9L6vt30wV
         bbDs6rV5b9mkcsN3I6ndGH+zrjdGdYMSBxtI0XeuO1yOBOIuKodL2cA3wihjs1eUCADn
         9XNmnQlcqiKmpcJ3dmLNz8axo2Qiz8zgFSLKCKSGfpnVE7gK9iz9emddeREw1pX1G5zr
         f0Wu2tsrSLrn9Mx2f9qmlO0KgakSX1ZY35ZIApdiFLC2YRYj2tlzfMaSUj0xqxEQ4wu7
         4Cltns0mpYlYlXejav8yiWL/maxSPolVjgPeJWK0LTI7sytbYE8EzjdKIPoWHgks1XSJ
         I+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F4wzLNz6dwbsx5heN6y8ApOHwBgCymyPsBRS4COOYFM=;
        b=flZg3b7cV4ucYSCDnwDFoRfmorJcWIvZ8l8YMc6GVTKSLjMnaBtpdO15Bq1+pGt4zx
         Df7nRIT0tQjAZz8cvCEJsSdk2EFrDT5Y1tgbsQkEx4DHif2fdeB3es9vJA7rh4ybK2qk
         pFFFt8QDgWFo+NCiSFDa30YUaA2/ydcsD3VCslPCXX9unplyqUKeMOOR1ddG7/FWKP0V
         yaTIKNHveUx0T6vnvAEFMkMnRnJYJBLUbOFZ807myZfVZ5t9OuI9MB6nf+ur0u+yG4zS
         hdGVlL0+HvcF1SJ1UZBZ1lMzTAHzV6Wv/CJ/rhsh0K7ELVJSMFz9IQibBzkRY7er0wlb
         +itw==
X-Gm-Message-State: ANoB5pm3c0qFtlb9C3h2IBKD0WOFViX2n0Y+5wVbV/p/uK64CQHK6TtI
        A/MrzycKmKA0TJKyaOONaOzM/Q==
X-Google-Smtp-Source: AA0mqf4OPQ41A6YQWwi4U9K/lp0Wdyo5nPJOWKYHo+40cNenTg2e7rXr3g3txA7AaybzmQI7F4YIJw==
X-Received: by 2002:a05:6512:15a6:b0:4b4:b5bf:3ce6 with SMTP id bp38-20020a05651215a600b004b4b5bf3ce6mr9902578lfb.38.1670976137948;
        Tue, 13 Dec 2022 16:02:17 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id p17-20020ac246d1000000b0049e9122bd0esm558261lfo.114.2022.12.13.16.02.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 16:02:17 -0800 (PST)
Message-ID: <c5e33d9f-0dc4-fdd2-244a-3d463be1c4e8@linaro.org>
Date:   Wed, 14 Dec 2022 01:02:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [RFC PATCH 5/6] drm/msm/dsi: Flip greater-than check for
 slice_count and slice_per_intf
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Jani Nikula <jani.nikula@intel.com>,
        sunliming <sunliming@kylinos.cn>,
        Sam Ravnborg <sam@ravnborg.org>,
        Haowen Bai <baihaowen@meizu.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20221213232207.113607-1-marijn.suijten@somainline.org>
 <20221213232207.113607-6-marijn.suijten@somainline.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221213232207.113607-6-marijn.suijten@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14.12.2022 00:22, Marijn Suijten wrote:
> According to downstream /and the comment copied from it/ this comparison
> should be the other way around.  In other words, when the panel driver
> requests to use more slices per packet than what could be sent over this
> interface, it is bumped down to only use a single slice per packet (and
> strangely not the number of slices that could fit on the interface).
> 
> Fixes: 08802f515c3c ("drm/msm/dsi: Add support for DSC configuration")
> ---
Missing s-o-b

>  drivers/gpu/drm/msm/dsi/dsi_host.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index 0686c35a6fd4..9bdfa0864cdf 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -855,11 +855,11 @@ static void dsi_update_dsc_timing(struct msm_dsi_host *msm_host, bool is_cmd_mod
>  	 */
>  	slice_per_intf = DIV_ROUND_UP(hdisplay, dsc->slice_width);
>  
> -	/* If slice_per_pkt is greater than slice_per_intf
> +	/* If slice_count is greater than slice_per_intf
>  	 * then default to 1. This can happen during partial
>  	 * update.
>  	 */
> -	if (slice_per_intf > dsc->slice_count)
> +	if (dsc->slice_count > slice_per_intf)
>  		dsc->slice_count = 1;
>  
>  	total_bytes_per_intf = dsc->slice_chunk_size * slice_per_intf;
