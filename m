Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7EA4714917
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 14:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjE2MIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 08:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjE2MIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 08:08:30 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77F9E3
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 05:08:22 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2af2602848aso32717761fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 05:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685362101; x=1687954101;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6N4laHrxcBKrO6d+ex168wZrn7XIXcKY1PLtyo+eeeQ=;
        b=xl3LGI/KATO58nyEhF3efLAVdsd5fzMsg1ndnuSLwdETkQ3cHu1BKl8OrD3SPizH1e
         bZADKGAGzDBUPcuZQ53occ59IYE1bJhzCvVjcpLiNHRE1Pl1FpEU/duiZvsxfFTIZkbz
         PWxigzhQWgHwEJw3mWH7w6IOb6wE+dts2wD2Z57Anys6jEPGDC4Wl4hf3KO1eWZxo9fe
         saFbCRGovkVEBRjm7zh8zG0GZ9pzSDybfj4YKVYg/CSmR0FFJtLdZjy8Ui2y0Uu7UXfM
         Re55DAT6xmg6Sa8pP7Rw9S65VuKR8y9AIdPJKCnRUkstrp4/O/YsEe+U0dduw1pNpTYo
         vACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685362101; x=1687954101;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6N4laHrxcBKrO6d+ex168wZrn7XIXcKY1PLtyo+eeeQ=;
        b=ajVRaIJkqnLdPS3gHx91wHoQNa+jbztnDRPEVEiPiKGy8Kqf3Os9LAtmzse+R8l5NF
         53I2DCxYkVgSzoryHC4NXpZXvReFeTDEW0hplStSWKNe5rYIyFOBmMvm89zeSYS4PpgM
         b9jipddX+lI9XN7U2Ued5AslaJv15rqhKdNCYUOOV9UHSv6KOgBJDermNE0V1aR7b1Bl
         C0mI3z3MDNY7ocZVZzKzz6Xm8KzZspqGA7rIb/Skrf/CtKgdSsy7MRwoYxXKXOXqHXN7
         198vOATn1TlHkFU+MpCl1exKPdTyewcZ/dImPjWHxCJElgLhPNgDrC3wa4cbhq8YZ6kp
         NfhQ==
X-Gm-Message-State: AC+VfDzA16HfvGlDADL4lbMLlJcaBxvcPSMX9wC40Qp1sTQaZrzi4XnS
        Zvln5OYDxJRYVIvOm+3fvntpmg==
X-Google-Smtp-Source: ACHHUZ4uum7Tu0iR7zATFyLuJQq5xux61yqQsRwmNNMm9BV9bTZ7ZRrezf4Gx3jdtD/dOpMWekhgsg==
X-Received: by 2002:a19:f60e:0:b0:4f4:b3eb:80f7 with SMTP id x14-20020a19f60e000000b004f4b3eb80f7mr3332241lfe.6.1685362100879;
        Mon, 29 May 2023 05:08:20 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id q9-20020ac25109000000b004f252003071sm1946136lfb.37.2023.05.29.05.08.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 05:08:20 -0700 (PDT)
Message-ID: <c75fd8fa-65ba-db7a-5a38-776d19fe197d@linaro.org>
Date:   Mon, 29 May 2023 14:08:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 5/7] drm/msm/dsi: Add configuration for MSM8226
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230308-msm8226-mdp-v1-0-679f335d3d5b@z3ntu.xyz>
 <20230308-msm8226-mdp-v1-5-679f335d3d5b@z3ntu.xyz>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230308-msm8226-mdp-v1-5-679f335d3d5b@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29.05.2023 11:44, Luca Weiss wrote:
> Add the config for the v1.0.2 DSI found on MSM8226. We can reuse
> existing bits from other revisions that are identical for v1.0.2.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/gpu/drm/msm/dsi/dsi_cfg.c | 2 ++
>  drivers/gpu/drm/msm/dsi/dsi_cfg.h | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.c b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> index 29ccd755cc2e..8a5fb6df7210 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> @@ -245,6 +245,8 @@ static const struct msm_dsi_cfg_handler dsi_cfg_handlers[] = {
>  		&apq8064_dsi_cfg, &msm_dsi_v2_host_ops},
>  	{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V1_0,
>  		&msm8974_apq8084_dsi_cfg, &msm_dsi_6g_host_ops},
> +	{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V1_0_2,
> +		&msm8974_apq8084_dsi_cfg, &msm_dsi_6g_host_ops},
>  	{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V1_1,
>  		&msm8974_apq8084_dsi_cfg, &msm_dsi_6g_host_ops},
>  	{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V1_1_1,
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.h b/drivers/gpu/drm/msm/dsi/dsi_cfg.h
> index 91bdaf50bb1a..43f0dd74edb6 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_cfg.h
> +++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.h
> @@ -11,6 +11,7 @@
>  #define MSM_DSI_VER_MAJOR_V2	0x02
>  #define MSM_DSI_VER_MAJOR_6G	0x03
>  #define MSM_DSI_6G_VER_MINOR_V1_0	0x10000000
> +#define MSM_DSI_6G_VER_MINOR_V1_0_2	0x10000002
>  #define MSM_DSI_6G_VER_MINOR_V1_1	0x10010000
>  #define MSM_DSI_6G_VER_MINOR_V1_1_1	0x10010001
>  #define MSM_DSI_6G_VER_MINOR_V1_2	0x10020000
> 
