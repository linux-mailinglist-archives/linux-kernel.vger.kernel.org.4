Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A506F532B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 10:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjECIdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 04:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjECIdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 04:33:20 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A28D49F1
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 01:33:19 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2ac70c975fcso5959831fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 01:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683102797; x=1685694797;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dbV4Q4B3dhOAP3AwRTAGuOAV9YZ9rp87vA7n2p2FyUI=;
        b=Fd/D75Fki7x/u0oVTyoPqv/3gp1gAlzCO8im9+l7wx9iJ4CJ4eLFsK/+QjdWvxEmw8
         ID48odi4GVfVbXfNpQSWmkzMc+kMMuf78RxDTRZFkTtDMHoGzqu1BHsBy3SB5QSZwfGp
         rPq2JWoAeBSK+kp3F3LH2+aiI4QkcERS2IvCgNFA+f0IJHRIDMgI8786EjQyHqS22WT3
         fyR69BjWT3LXUB8LfLgXXKLBSCaJUjRp76W8fZLUe+STxrh3omMG6zGt8otzJdbBOXbB
         HomO3Q07tq9hdEXveN/n+YerdYz+aZtm+j7veLfB0EyefU1KpFnpeuHHz7vm3giZqK8y
         TjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683102797; x=1685694797;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dbV4Q4B3dhOAP3AwRTAGuOAV9YZ9rp87vA7n2p2FyUI=;
        b=EkRlpJIVBYmAbmhUG5CODGJRQF9ZXaMJHb7xx8baj/TnRMD0WqoRULCgcJt6CHKnB5
         TyTJa3NbYGUagQ6fmHi6v3hfiJg3+sr5vPCnkFT1I1rJgrXJICOWKmZjwAT75c3HddBH
         xb7xNN3uMDSbBA807dKhsrmIGAzcrpQe5o/RZvBLmS4SypzXJDkc03z4hu4ps7krlpJk
         lv1Xw/Yf6mg0iTf5LjoTVaVPX0huNyPJkGrqyD4LYX8pp/fKKd2xGZbIU5U9LSiboDgF
         Iy9qSQmqdd5LWD3aI0FHZuWJg47A2P0G3Ml6g1g36XBL0MD448NtiOZaumXbgrqi4Ac3
         oBFQ==
X-Gm-Message-State: AC+VfDzOARlNxJHZ0c3UJBuLAH3m12WxVZVHbeD/Q6HPGWg3ldgALNV3
        G24FHaNdLJ+ZjX4331bZus4Ppg==
X-Google-Smtp-Source: ACHHUZ43zaDbHh1HVQgUiEHs/9cXcbqHTLt7G053WYxAtaTS4qoGpMPXYxZErznSRzkva83oa+K5ig==
X-Received: by 2002:a2e:3814:0:b0:2a8:ea1e:bde1 with SMTP id f20-20020a2e3814000000b002a8ea1ebde1mr4749911lja.50.1683102797519;
        Wed, 03 May 2023 01:33:17 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id d20-20020a2e3614000000b002a8d2c6300bsm5846704lja.48.2023.05.03.01.33.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 01:33:16 -0700 (PDT)
Message-ID: <dc926d1c-2637-34a7-df82-c6bd119bfadd@linaro.org>
Date:   Wed, 3 May 2023 11:33:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/4] drm/msm/dsi: Adjust pclk rate for compression
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
References: <20230405-add-dsc-support-v1-0-6bc6f03ae735@quicinc.com>
 <20230405-add-dsc-support-v1-1-6bc6f03ae735@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230405-add-dsc-support-v1-1-6bc6f03ae735@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2023 04:19, Jessica Zhang wrote:
> Divide the pclk rate by the compression ratio when DSC is enabled
> 
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>   drivers/gpu/drm/msm/dsi/dsi_host.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index 43a5ec33eee8..35c69dbe5f6f 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -561,7 +561,8 @@ void dsi_link_clk_disable_v2(struct msm_dsi_host *msm_host)
>   	clk_disable_unprepare(msm_host->byte_clk);
>   }
>   
> -static unsigned long dsi_get_pclk_rate(const struct drm_display_mode *mode, bool is_bonded_dsi)
> +static unsigned long dsi_get_pclk_rate(const struct drm_display_mode *mode,
> +		struct drm_dsc_config *dsc, bool is_bonded_dsi)
>   {
>   	unsigned long pclk_rate;
>   
> @@ -576,6 +577,11 @@ static unsigned long dsi_get_pclk_rate(const struct drm_display_mode *mode, bool
>   	if (is_bonded_dsi)
>   		pclk_rate /= 2;
>   
> +	/* If DSC is enabled, divide pclk by compression ratio */
> +	if (dsc)
> +		pclk_rate = DIV_ROUND_UP(pclk_rate,
> +				dsc->bits_per_component * 3 / msm_dsc_get_bpp_int(dsc));
> +

Don't we loose precision here?
Would DIV_ROUND_UP(pclk_rate * bpp, dsc->bpc * 3) be better?

>   	return pclk_rate;
>   }
>   
> @@ -585,7 +591,7 @@ unsigned long dsi_byte_clk_get_rate(struct mipi_dsi_host *host, bool is_bonded_d
>   	struct msm_dsi_host *msm_host = to_msm_dsi_host(host);
>   	u8 lanes = msm_host->lanes;
>   	u32 bpp = dsi_get_bpp(msm_host->format);
> -	unsigned long pclk_rate = dsi_get_pclk_rate(mode, is_bonded_dsi);
> +	unsigned long pclk_rate = dsi_get_pclk_rate(mode, msm_host->dsc, is_bonded_dsi);
>   	u64 pclk_bpp = (u64)pclk_rate * bpp;
>   
>   	if (lanes == 0) {
> @@ -604,7 +610,7 @@ unsigned long dsi_byte_clk_get_rate(struct mipi_dsi_host *host, bool is_bonded_d
>   
>   static void dsi_calc_pclk(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>   {
> -	msm_host->pixel_clk_rate = dsi_get_pclk_rate(msm_host->mode, is_bonded_dsi);
> +	msm_host->pixel_clk_rate = dsi_get_pclk_rate(msm_host->mode, msm_host->dsc, is_bonded_dsi);
>   	msm_host->byte_clk_rate = dsi_byte_clk_get_rate(&msm_host->base, is_bonded_dsi,
>   							msm_host->mode);
>   
> @@ -634,7 +640,7 @@ int dsi_calc_clk_rate_v2(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>   
>   	dsi_calc_pclk(msm_host, is_bonded_dsi);
>   
> -	pclk_bpp = (u64)dsi_get_pclk_rate(msm_host->mode, is_bonded_dsi) * bpp;
> +	pclk_bpp = (u64)dsi_get_pclk_rate(msm_host->mode, msm_host->dsc, is_bonded_dsi) * bpp;
>   	do_div(pclk_bpp, 8);
>   	msm_host->src_clk_rate = pclk_bpp;
>   
> 

-- 
With best wishes
Dmitry

