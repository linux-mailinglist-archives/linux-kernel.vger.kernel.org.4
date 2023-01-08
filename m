Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABB4661A86
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 23:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbjAHWmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 17:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbjAHWmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 17:42:24 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A6CF584
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 14:42:23 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id cf42so10397342lfb.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 14:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U+gHbx+gCIi2HWumnpJEZuh617XPeArEnKugXGoN56U=;
        b=Mbs1M7eoVfi549MvP93DkyztZl9K0GGdAor+b7LWFpAM9FiQ2jCmOMLEJIY41jlrsF
         gVeO4HWLnnIz7G+J7NsfCpaAJWaqOtG3/btPP4HJzh5ltsArFV+DEMjGt/vsaDRymOb2
         WMqeBzKBwbCk1kus/Eq5Qf7FIMnvlRa/tmi8jW07XJcaO0nJlrVu70epNCU2siF5PFiS
         rJXHmLzUMLGM/HcYGO8gvOIZFvXZRzgUEtXhX+raFvB0eDng8LEcoIUX+OVy1I67eeQo
         6kJ43JaQLc2IPxHqJlvhZ99plDtHWIWB5BwENRGzAkNB8g/oUw1rHdhH8SubJ4+4TtPy
         l2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U+gHbx+gCIi2HWumnpJEZuh617XPeArEnKugXGoN56U=;
        b=RlJ6eCdhlKgZve14JumyI57dZFkwTb+W414Mov2A0u0zER7rDohcVZvm59FB5F1/dV
         PLm9S019FwKojmRSuXTveoTCPVcnG5Df02TZV4Yk589dus7rrMKNqNq7K0mGeKgEAHJ6
         hFtCpjVaUKQMVMTnPQXRSc4bAI0CKHW13aTtdUPz3TubM/sQ/REVogokXMN2OPwnXtWW
         csl08scWVVJZriENWtohBlOwEDm0k46ptTzV+juO4/tJXIw9Ipk9Dwn7GnHFO29sYtPO
         9Q2JZXkQOHWB40P35+POUYMRRPE+61jVy59lgCTlx5k2XMbEoYCWdOVdw3dRL4UKmc9w
         GhUg==
X-Gm-Message-State: AFqh2kqWPgRb3/AQq4J1K7/h1cSfVgTiNEbPL9259tCPhZCiPokv3JpN
        IZQXPw44Jmy6zR/98fUVEMrhTA==
X-Google-Smtp-Source: AMrXdXsHFuuepdYa8vE9EqOF0qwKtR2eM1Dh7AEetug97Bc7kHio1DKYCB8SLj2r6PKpBI5rSoW9zA==
X-Received: by 2002:a05:6512:130c:b0:4cb:e53:d54b with SMTP id x12-20020a056512130c00b004cb0e53d54bmr13981866lfu.25.1673217741957;
        Sun, 08 Jan 2023 14:42:21 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id bu31-20020a056512169f00b004b54ca56cf9sm1266258lfb.303.2023.01.08.14.42.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Jan 2023 14:42:21 -0800 (PST)
Message-ID: <9f10957e-3c77-d5e5-107e-12fdb63c9a04@linaro.org>
Date:   Mon, 9 Jan 2023 00:42:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] drm/msm/dsi: Add missing check for
 alloc_ordered_workqueue
Content-Language: en-GB
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, robdclark@gmail.com,
        quic_abhinavk@quicinc.com, sean@poorly.run, airlied@gmail.com,
        daniel@ffwll.ch, marijn.suijten@somainline.org, vkoul@kernel.org,
        dianders@chromium.org, marex@denx.de, vladimir.lypak@gmail.com
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230106025609.29499-1-jiasheng@iscas.ac.cn>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230106025609.29499-1-jiasheng@iscas.ac.cn>
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

On 06/01/2023 04:56, Jiasheng Jiang wrote:
> Add check for the return value of alloc_ordered_workqueue as it may return
> NULL pointer and cause NULL pointer dereference.
> Moreover, change the "return ret" into "goto fail" in order to be
> consistent with the others.
> 
> Fixes: a689554ba6ed ("drm/msm: Initial add DSI connector support")
> Fixes: 32d3e0feccfe ("drm/msm: dsi: Use OPP API to set clk/perf state")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>   drivers/gpu/drm/msm/dsi/dsi_host.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index 89aadd3b3202..12239f628d5a 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -1944,19 +1944,19 @@ int msm_dsi_host_init(struct msm_dsi *msm_dsi)
>   
>   	ret = devm_pm_opp_set_clkname(&pdev->dev, "byte");
>   	if (ret)
> -		return ret;
> +		goto fail;

fail: is just 'return ret', so these changes are not required. Instead 
the fail label can be dropped.

>   	/* OPP table is optional */
>   	ret = devm_pm_opp_of_add_table(&pdev->dev);
>   	if (ret && ret != -ENODEV) {
>   		dev_err(&pdev->dev, "invalid OPP table in device tree\n");
> -		return ret;
> +		goto fail;
>   	}
>   
>   	msm_host->irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
>   	if (msm_host->irq < 0) {
>   		ret = msm_host->irq;
>   		dev_err(&pdev->dev, "failed to get irq: %d\n", ret);
> -		return ret;
> +		goto fail;
>   	}
>   
>   	/* do not autoenable, will be enabled later */
> @@ -1966,7 +1966,7 @@ int msm_dsi_host_init(struct msm_dsi *msm_dsi)
>   	if (ret < 0) {
>   		dev_err(&pdev->dev, "failed to request IRQ%u: %d\n",
>   				msm_host->irq, ret);
> -		return ret;
> +		goto fail;
>   	}
>   
>   	init_completion(&msm_host->dma_comp);
> @@ -1977,6 +1977,11 @@ int msm_dsi_host_init(struct msm_dsi *msm_dsi)
>   
>   	/* setup workqueue */
>   	msm_host->workqueue = alloc_ordered_workqueue("dsi_drm_work", 0);
> +	if (!msm_host->workqueue) {
> +		ret = -ENOMEM;
> +		goto fail;
> +	}
> +
>   	INIT_WORK(&msm_host->err_work, dsi_err_worker);
>   
>   	msm_dsi->id = msm_host->id;

-- 
With best wishes
Dmitry

