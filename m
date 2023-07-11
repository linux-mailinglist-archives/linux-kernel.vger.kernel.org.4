Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E7374E26C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 02:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjGKAEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 20:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjGKAEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 20:04:05 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D021A8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 17:04:03 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b69f958ef3so80767851fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 17:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689033842; x=1691625842;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V/dX5K/ss3x0ciVNd3aGlR4JXcHpqL/PpCCOLWFx+LU=;
        b=bff2RHeCIczRdsZbNq2tUaXQiFpucPzuUmWWOXPGQ4SAr6olSBCt7WL2nUpZzrF1gt
         gSZ5+lUbOASJpXJ7IOfH4AFidBOgj6GWWYBt11VauuiijYUhlF5WfrY7wSo/OxxeDNc6
         xRVL5RXhcVFwIlByLXbXlxUmm92OXePSiiOIzo0nWCKvww3YXP09N1ZkyvNCI3s99k+3
         /iqXTuI7JeiDVN9e2Rm3Y9BqzR9g1BEeGNtqi/XqjG2y4FYwQ5WxL7Mz5lw931ZCyU0+
         qkrWyozbhuySBBMS+nsM3Ok7XruduIOm5IOquzTEVTlFWfgtVtMKTxf0GbIrdCeaw08k
         nfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689033842; x=1691625842;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V/dX5K/ss3x0ciVNd3aGlR4JXcHpqL/PpCCOLWFx+LU=;
        b=Ja0AsVAece8YqDANDkn7ROPozF2Ym/EIVzy8V1tunk5dNiUzK14/w3MWHnWUYKbMo2
         yTmu3II8VT8djHjQt9hsSYXcLVfXYlwlKVvnmPDCP5/e8WH61jIqZSagvNIpQLjQEvPt
         zO0Hr+fTfLltmeWLkvQ7bM4aCuoBD1IBpSqgSihYmKM/SeedqsfZy8UQuNa7Bs9fYqV3
         +xqVhhpvNDvltxmClsxVc4O6te0xHc8Y3CH4RqHr26WQdjbweL0Njl6ZNBQoaV/NWftA
         jBeUtCqc0sXzuW3wnL/SJSJxXaCiXaZj6INj9qes82DF7DqfuFC6kagQV+dUmKVFBWCl
         5taA==
X-Gm-Message-State: ABy/qLb48np88Znpu4tbROktiovOl5FsnPleCVv5Q7cjXerMTCJ3wMmE
        N2i1ERAu9FbwZPb79CbqjnZZh1yXqOrp8CuYGk4=
X-Google-Smtp-Source: APBJJlEuKphZX/mQW/8zaQsAfg/oLoPfdo42uJwdfWTi2a1CBy9Un701xs1VX++nJ0yk9il+OIo1vw==
X-Received: by 2002:a2e:8eca:0:b0:2b6:a827:164f with SMTP id e10-20020a2e8eca000000b002b6a827164fmr11447647ljl.10.1689033841931;
        Mon, 10 Jul 2023 17:04:01 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id n24-20020a2e86d8000000b002b6cde9f325sm173232ljj.105.2023.07.10.17.04.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 17:04:01 -0700 (PDT)
Message-ID: <25c12da7-e79d-af19-fbc9-47ebf7041406@linaro.org>
Date:   Tue, 11 Jul 2023 03:04:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] drm/msm/dsi: Enable BURST_MODE for command mode for
 DSI 6G v1.3+
Content-Language: en-GB
To:     Jessica Zhang <quic_jesszhan@quicinc.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     quic_abhinavk@quicinc.com, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230608-b4-add-burst-mode-v2-1-2ff468457d46@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230608-b4-add-burst-mode-v2-1-2ff468457d46@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/06/2023 23:31, Jessica Zhang wrote:
> During a frame transfer in command mode, there could be frequent
> LP11 <-> HS transitions when multiple DCS commands are sent mid-frame or
> if the DSI controller is running on slow clock and is throttled. To
> minimize frame latency due to these transitions, it is recommended to
> send the frame in a single burst.
> 
> This feature is supported for DSI 6G 1.3 and above, thus enable burst
> mode if supported.
> 
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
> Changes in v2:
> - Moved MDP_CTRL2 register setting to dsi_ctrl_config() (Dmitry/Marijn)
> - Read previous value of MDP_CTRL2 register before writing to it
>    (Dmitry)
> - Link to v1: https://lore.kernel.org/r/20230608-b4-add-burst-mode-v1-1-55dfbcfada55@quicinc.com
> ---
>   drivers/gpu/drm/msm/dsi/dsi_host.c | 7 +++++++
>   1 file changed, 7 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index 3f6dfb4f9d5a..cdb404885f3c 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -752,6 +752,13 @@ static void dsi_ctrl_enable(struct msm_dsi_host *msm_host,
>   		/* Always insert DCS command */
>   		data |= DSI_CMD_CFG1_INSERT_DCS_COMMAND;
>   		dsi_write(msm_host, REG_DSI_CMD_CFG1, data);
> +
> +		if (msm_host->cfg_hnd->major == MSM_DSI_VER_MAJOR_6G &&
> +				msm_host->cfg_hnd->minor >= MSM_DSI_6G_VER_MINOR_V1_3) {

Nit: please intent in future to the same level (vim: "set cino=(0").

> +			data = dsi_read(msm_host, REG_DSI_CMD_MODE_MDP_CTRL2);
> +			data |= DSI_CMD_MODE_MDP_CTRL2_BURST_MODE;
> +			dsi_write(msm_host, REG_DSI_CMD_MODE_MDP_CTRL2, data);
> +		}
>   	}
>   
>   	dsi_write(msm_host, REG_DSI_CMD_DMA_CTRL,
> 
> ---
> base-commit: a0364260213c96f6817f7e85cdce293cb743460f
> change-id: 20230608-b4-add-burst-mode-a5bb144069fa
> 
> Best regards,

-- 
With best wishes
Dmitry

