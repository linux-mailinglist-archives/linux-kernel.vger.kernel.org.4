Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A6A6E846F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 00:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjDSWPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 18:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDSWPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 18:15:08 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F683595
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:15:06 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id a10so650088ljr.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681942505; x=1684534505;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ytCeCLRrAM5jc6M/DBn6k6KhfCt7gZVNX4R7z0khTGc=;
        b=OnRB/l3vwD/hi/TsQlTfTlBEMz9NLvwqfNSo1CP2j66Bj8pW7wLDYKHzoOQBGs55qN
         s9j/cT59DrxIjL9I5wsOYYPGSC1u3zmTVaq2KUnjo/lbADYVAd+g802TYcZo1j5IaBMP
         yS3SxHVHSDLWF6MjQmNWcXX58EOsLjareyulU/wybmMlz3/sTfv5PMnEDruajOfKowCK
         el6MMeWgUgUETby0ukQA6Awhae2Ouba6KcHUwVWpbOHAx1o1Dw+KA9HUVIYVPc5fp15c
         V1g+nSYgTufzn7oIdm5zDI09zsn+6SI/OdYR4Gw/7LkOnSoWzh/1BnRQFZBD4NhrhTHb
         p2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681942505; x=1684534505;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ytCeCLRrAM5jc6M/DBn6k6KhfCt7gZVNX4R7z0khTGc=;
        b=Rpu/vCBXcxF+L7jSroOpOpSL+4pOXqFlNOI2qXVm5H7xWfqZk1kv+Si0BV8dG861q/
         wjmozCojdbAWny4+p66EFa2KsxPAl+Rlht69iBRCU7AZx7v+Xna9sv9DaPCMvjNS96hI
         /uqyn4tT3rPYFPnzRwz8ED3INGRj0FmD1ntgyUEQLmaQJKHqBFccsW4uEyU2eXQoOQSG
         DkwzzEzmRN+hFXxoJiH6n+Fi0YWvjxMI+O5HBvWTcoSAiLyWytKUO9/4CwRdFt+XCcVC
         PCqrrttdimQFsGA2UIyp+nIIlc7otxARDnEKYWfjWplIU0wjaHyBJKF1njuVkQFCleH9
         iRxQ==
X-Gm-Message-State: AAQBX9fPDyrcthrf7LobuFQmjHFUHS8UAB6CbNzXGPJMiRHdt3tNhWby
        c1DhwC9MPXzgKEtJHyQGgfl2CA==
X-Google-Smtp-Source: AKy350ZFutfn0RXVZ/ykfD/OVNTS1p2iLO9nhoF8y7NgvPMPbsszamU9msWN/8x7CYFEeoCAj2bInQ==
X-Received: by 2002:a2e:954b:0:b0:2a8:d242:4df with SMTP id t11-20020a2e954b000000b002a8d24204dfmr2518118ljh.35.1681942504921;
        Wed, 19 Apr 2023 15:15:04 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id u16-20020a2e91d0000000b002934fe524d2sm3067789ljg.83.2023.04.19.15.15.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 15:15:04 -0700 (PDT)
Message-ID: <71fe636f-ba8b-643c-9b5f-02f712bc0674@linaro.org>
Date:   Thu, 20 Apr 2023 01:15:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 01/11] drm/msm/dpu: tweak msm8998 hw catalog values
To:     Arnaud Vrac <avrac@freebox.fr>, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230419-dpu-tweaks-v1-0-d1bac46db075@freebox.fr>
 <20230419-dpu-tweaks-v1-1-d1bac46db075@freebox.fr>
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230419-dpu-tweaks-v1-1-d1bac46db075@freebox.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2023 17:41, Arnaud Vrac wrote:
> Match the values found in the downstream msm-4.4 kernel sde driver.
> 
> Signed-off-by: Arnaud Vrac <avrac@freebox.fr>

Fixes: 94391a14fc27 ("drm/msm/dpu1: Add MSM8998 to hw catalog")

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h |  8 ++++----
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c          | 15 +++++----------
>   2 files changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
> index 2b3ae84057dfe..b07e8a9941f79 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
> @@ -134,10 +134,10 @@ static const struct dpu_dspp_cfg msm8998_dspp[] = {
>   };
>   
>   static const struct dpu_intf_cfg msm8998_intf[] = {
> -	INTF_BLK("intf_0", INTF_0, 0x6a000, 0x280, INTF_DP, 0, 25, INTF_SDM845_MASK, MDP_SSPP_TOP0_INTR, 24, 25),
> -	INTF_BLK("intf_1", INTF_1, 0x6a800, 0x280, INTF_DSI, 0, 25, INTF_SDM845_MASK, MDP_SSPP_TOP0_INTR, 26, 27),
> -	INTF_BLK("intf_2", INTF_2, 0x6b000, 0x280, INTF_DSI, 1, 25, INTF_SDM845_MASK, MDP_SSPP_TOP0_INTR, 28, 29),
> -	INTF_BLK("intf_3", INTF_3, 0x6b800, 0x280, INTF_HDMI, 0, 25, INTF_SDM845_MASK, MDP_SSPP_TOP0_INTR, 30, 31),
> +	INTF_BLK("intf_0", INTF_0, 0x6a000, 0x280, INTF_DP, 0, 21, INTF_SDM845_MASK, MDP_SSPP_TOP0_INTR, 24, 25),
> +	INTF_BLK("intf_1", INTF_1, 0x6a800, 0x280, INTF_DSI, 0, 21, INTF_SDM845_MASK, MDP_SSPP_TOP0_INTR, 26, 27),
> +	INTF_BLK("intf_2", INTF_2, 0x6b000, 0x280, INTF_DSI, 1, 21, INTF_SDM845_MASK, MDP_SSPP_TOP0_INTR, 28, 29),
> +	INTF_BLK("intf_3", INTF_3, 0x6b800, 0x280, INTF_HDMI, 0, 21, INTF_SDM845_MASK, MDP_SSPP_TOP0_INTR, 30, 31),
>   };
>   
>   static const struct dpu_perf_cfg msm8998_perf_data = {
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> index 03f162af1a50b..8d5d782a43398 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> @@ -587,12 +587,12 @@ static const u32 sdm845_nrt_pri_lvl[] = {3, 3, 3, 3, 3, 3, 3, 3};
>   
>   static const struct dpu_vbif_dynamic_ot_cfg msm8998_ot_rdwr_cfg[] = {
>   	{
> -		.pps = 1088 * 1920 * 30,
> +		.pps = 1920 * 1080 * 30,
>   		.ot_limit = 2,
>   	},
>   	{
> -		.pps = 1088 * 1920 * 60,
> -		.ot_limit = 6,
> +		.pps = 1920 * 1080 * 60,
> +		.ot_limit = 4,
>   	},
>   	{
>   		.pps = 3840 * 2160 * 30,
> @@ -705,10 +705,7 @@ static const struct dpu_qos_lut_entry msm8998_qos_linear[] = {
>   	{.fl = 10, .lut = 0x1555b},
>   	{.fl = 11, .lut = 0x5555b},
>   	{.fl = 12, .lut = 0x15555b},
> -	{.fl = 13, .lut = 0x55555b},
> -	{.fl = 14, .lut = 0},
> -	{.fl = 1,  .lut = 0x1b},
> -	{.fl = 0,  .lut = 0}
> +	{.fl = 0,  .lut = 0x55555b}
>   };
>   
>   static const struct dpu_qos_lut_entry sdm845_qos_linear[] = {
> @@ -730,9 +727,7 @@ static const struct dpu_qos_lut_entry msm8998_qos_macrotile[] = {
>   	{.fl = 10, .lut = 0x1aaff},
>   	{.fl = 11, .lut = 0x5aaff},
>   	{.fl = 12, .lut = 0x15aaff},
> -	{.fl = 13, .lut = 0x55aaff},
> -	{.fl = 1,  .lut = 0x1aaff},
> -	{.fl = 0,  .lut = 0},
> +	{.fl = 0,  .lut = 0x55aaff},
>   };
>   
>   static const struct dpu_qos_lut_entry sc7180_qos_linear[] = {
> 

-- 
With best wishes
Dmitry

