Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F170A7076EC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 02:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjERA3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 20:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjERA3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 20:29:20 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD2F26B6
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 17:29:19 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2ad714536cfso15302891fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 17:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684369757; x=1686961757;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pMLuQJkkWUIG735JKAhMLw4oEj/3anAW1mVncUC7mjw=;
        b=H7z5cBIXpN5FTsSanBfGOB4kpl2eaokFry+HmgUTCbqdbsMplob9BgYmIsblq6MO0e
         QycaO+g7ndT18ra6EiX+xig90XMcM8mIr5Rf1CpvcBDmXvSGhIz9byb9RS0H9xZnD+R0
         yMwe0pWpw3tJ+A+MH5V/lEIbxUoH8I9Mr5n8w43yk7mG6mUPvHQB/5NVCqhXaA6f0+UL
         H7UYywEJIb6qj56HnsJ2HGnZs39gLXk27KWQLxVKnVu0Fok1ifLmaHeprLcGTLlMqBlI
         f1gsmAlsC5ddBSKJgUXTrQHcwUaP2osfa3Q4kHKhwQMpm6BRpvEvWNy6cQQp67Dts5+B
         F+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684369757; x=1686961757;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pMLuQJkkWUIG735JKAhMLw4oEj/3anAW1mVncUC7mjw=;
        b=ebxr0k3WLK7+8nek200I1+YvMwDQepS4L2vzx3ggKAzNJlZT4jIAS79U/nglBH/MYQ
         BgQ2vMiHhfz1nXccif6Dcbk97u6elOTJCLfJmEDySTjZs3wjV/Vyu9LYBqPcqXKkawlH
         XFwqzrqsaP+auidHLMNGmfcr97KBQEXfbD1uZsASYjtVftIUCjnNPNOjpxuIYKU8YH2v
         8xr4OxFQ7A8bfLhE6DVA+rn7e3Lemmzgg+gqW637cndvDxi5n08xLOhiQp5c1+R8S8j+
         TOO8bAoAJrUSEEiFyrSlBNU0IE/Cy7E7mVu8Z6sth2BcvwWEbCYkfSe4u7k23Rc15Njc
         +YoA==
X-Gm-Message-State: AC+VfDyX7xcDOnewlEoP1hDjuNzuRYqJr0KoEfQ2YiOPINyxSKWOlv4s
        yFvWV98yxssVOTN24m4UIvbEyA==
X-Google-Smtp-Source: ACHHUZ4egjksffobtvh370QPgDyVzW0IVj9dAA8nRwiQGzhHSKt2nIOlgjpfefT1edJmhhnt1zgM5w==
X-Received: by 2002:a19:7005:0:b0:4f2:6a9d:9a31 with SMTP id h5-20020a197005000000b004f26a9d9a31mr577428lfc.51.1684369757439;
        Wed, 17 May 2023 17:29:17 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id h3-20020ac25963000000b004f2543be9dbsm64733lfp.5.2023.05.17.17.29.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 17:29:16 -0700 (PDT)
Message-ID: <4f8807d7-f16f-2a5c-c319-c7cdea56d737@linaro.org>
Date:   Thu, 18 May 2023 03:29:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v10 3/8] drm/msm/dpu: Guard PINGPONG DSC ops behind
 DPU_PINGPONG_DSC bit
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_jesszhan@quicinc.com,
        quic_sbillaka@quicinc.com, marijn.suijten@somainline.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1684360919-28458-1-git-send-email-quic_khsieh@quicinc.com>
 <1684360919-28458-4-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1684360919-28458-4-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/2023 01:01, Kuogee Hsieh wrote:
> DPU < 7.0.0 has DPU_PINGPONG_DSC feature bit set to indicate it requires
> both dpu_hw_pp_setup_dsc() and dpu_hw_pp_dsc_{enable,disable}() to be
> executed to complete DSC configuration if DSC hardware block is present.
> Hence test DPU_PINGPONG_DSC feature bit and assign DSC related functions
> to the ops of PINGPONG block accordingly if DPU_PINGPONG_DSC bit is set.
> 
> Changes in v6:
> -- split patches, this patch has function handles DPU_PINGPONG_DSC bit
> 
> Changes in v9:
> -- the original code of assigning dsc related functions to the ops of pingpong

line too long

>     block without testing the DPU_PINGPONG_DSC feature bit was restored back
>     due to rebase error which defeat the purpose of this patch. Remove those
>     error code.
> 
> Changes in v10:
> -- change commit title
> -- correct texts at changes in v9
> 
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
> index 79e4576..437d9e6 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
> @@ -291,9 +291,12 @@ static void _setup_pingpong_ops(struct dpu_hw_pingpong *c,
>   		c->ops.get_line_count = dpu_hw_pp_get_line_count;
>   		c->ops.disable_autorefresh = dpu_hw_pp_disable_autorefresh;
>   	}
> -	c->ops.setup_dsc = dpu_hw_pp_setup_dsc;
> -	c->ops.enable_dsc = dpu_hw_pp_dsc_enable;
> -	c->ops.disable_dsc = dpu_hw_pp_dsc_disable;
> +
> +	if (test_bit(DPU_PINGPONG_DSC, &features)) {
> +		c->ops.setup_dsc = dpu_hw_pp_setup_dsc;
> +		c->ops.enable_dsc = dpu_hw_pp_dsc_enable;
> +		c->ops.disable_dsc = dpu_hw_pp_dsc_disable;
> +	}
>   
>   	if (test_bit(DPU_PINGPONG_DITHER, &features))
>   		c->ops.setup_dither = dpu_hw_pp_setup_dither;

-- 
With best wishes
Dmitry

