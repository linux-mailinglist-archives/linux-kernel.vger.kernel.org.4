Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4864969313F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 14:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjBKN1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 08:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjBKN06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 08:26:58 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB3E2367E
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 05:26:57 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id hx15so22006700ejc.11
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 05:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iOO5VT9qxtfT0anvEtJcfLGe9BZbxbhWePqPLX+Vj2c=;
        b=Hurr6LqRk3PQsrfj3J10pydSByhinAUlX9iGKE7LgtXayFvkCe4e85Av1gMW/vVwnz
         U8Sc+HkLjA11NcRrFDezYYH98nKLIWxRTkUgbVIr5c/tV9SKYcR+fr2h/D/cnSyVfMEq
         XfgRrbUxgbeAiBQP4AmrhfGeG7J2CChvPPP/8lh7FD0exDLHr8eoXeHfLwN4MzZdH0cx
         bPmY5uwu4csT506HKzDhC9Y97HjX7k1ygaqw8ENd1CesRE1hehomDSSI0AIO7yUlHRQA
         YJToce72qb1ZWhl5dOrpkPj05bB6KqAi/vw9l2R60MZOv7Nnn52jPhxDoUMMf2cvX91p
         OJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iOO5VT9qxtfT0anvEtJcfLGe9BZbxbhWePqPLX+Vj2c=;
        b=S9ISNFBnwvtuanyOE2nAqBt9+5zwAjNULlKuSni3DyRh2+B/+PcBqa4fBdJwW4S8ss
         twz05z/P3kM8iX0dGp8lE/RYTC/11aRFMBSAxLpFfWVENW/IiouY9V0J4iyCUIl0+GVi
         gwoMRM/vRcAaLrjCL9J9j7uj3JP4SGDUl9eKukLEGGQ/CvGmSk2cg3//vLh6gtypALX9
         y3Vg8MvQYt1QecGjkGQLbvibc5BX+SXvrL4hdCTvZfbCFrZM+Vq2gWWF39b9lTqFBc/e
         XeKuwivFU0db15a3Xi66jhLXYbYa8BDN4gt9uhykIn20emyWyJKAGsFKJbPMGrgpwtdT
         aFkA==
X-Gm-Message-State: AO0yUKVKE3UwbyxngDx2lmXcPrtuVAO42CLardX+DQYMjxG8g4lFrmML
        JEhwgwaCg4zlUO92O8NwTk7J/w==
X-Google-Smtp-Source: AK7set95nB9W+dsHhMUkQqipXux6Wldjks5K60baLEAsG6Wzd8CBQdL5fDSQ/uDhw/ntcg9OENvLFQ==
X-Received: by 2002:a17:906:7c91:b0:88c:b4c5:4006 with SMTP id w17-20020a1709067c9100b0088cb4c54006mr23317350ejo.45.1676122016333;
        Sat, 11 Feb 2023 05:26:56 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id bo13-20020a170906d04d00b008874c903ec5sm3847224ejb.43.2023.02.11.05.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Feb 2023 05:26:55 -0800 (PST)
Message-ID: <94882ab1-1eb0-b9f1-af70-dc070c96fd11@linaro.org>
Date:   Sat, 11 Feb 2023 15:26:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 04/10] drm/msm/dsi: dsi_host: Fix DSI index detection when
 version clash occurs
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Archit Taneja <architt@codeaurora.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230211115110.1462920-1-konrad.dybcio@linaro.org>
 <20230211115110.1462920-5-konrad.dybcio@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230211115110.1462920-5-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/2023 13:51, Konrad Dybcio wrote:
> Now that msm_dsi_config is ready to accept multiple sets of registers
> (where array[n][idx] holds the base registers of DSI(idx) for the nth
> entry), loop through all available configs to resolve hw version
> clashes.
> 
> Fixes: 32280d66fd44 ("drm/msm/dsi: Don't get DSI index from DT")

Do we really want to backport this patch (and other patches from this 
series to older kernels?)

> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/gpu/drm/msm/dsi/dsi_cfg.h  |  1 +
>   drivers/gpu/drm/msm/dsi/dsi_host.c | 12 +++++++-----
>   2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.h b/drivers/gpu/drm/msm/dsi/dsi_cfg.h
> index 03493cc6b772..4a47705234bd 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_cfg.h
> +++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.h
> @@ -43,6 +43,7 @@ struct msm_dsi_config {
>   	const int num_bus_clks;
>   	/* Allow + 1 entry for the zero-terminator */
>   	const resource_size_t io_start[VARIANTS_MAX][DSI_MAX + 1];
> +	const int num_variants;
>   };
>   
>   struct msm_dsi_host_cfg_ops {
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index f5092b4d0757..8dfa69bcff77 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -1862,16 +1862,18 @@ static int dsi_host_get_id(struct msm_dsi_host *msm_host)
>   	struct platform_device *pdev = msm_host->pdev;
>   	const struct msm_dsi_config *cfg = msm_host->cfg_hnd->cfg;
>   	struct resource *res;
> -	int i;
> +	int i, j, num_variants;
>   
>   	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dsi_ctrl");
>   	if (!res)
>   		return -EINVAL;
>   
> -	for (i = 0; cfg->io_start[0][i]; i++) {
> -		if (cfg->io_start[0][i] == res->start)
> -			return i;
> -	}
> +	num_variants = cfg->num_variants ? cfg->num_variants : 1;
> +
> +	for (i = 0; i < num_variants; i++)
> +		for (j = 0; cfg->io_start[i][j]; j++)
> +			if (cfg->io_start[i][j] == res->start)
> +				return j;
>   
>   	return -EINVAL;
>   }

Please squash this together with the patch 'drm/msm/dsi: Turn 
msm_dsi_config::io_start into a 2d array'.

-- 
With best wishes
Dmitry

