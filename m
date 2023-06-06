Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0686F723408
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 02:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbjFFAZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 20:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbjFFAZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 20:25:49 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EFBFD
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 17:25:47 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b1b86146afso39792111fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 17:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686011146; x=1688603146;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6pVDecfV/BYz9QMaz3qiB/Z106nCFvvqH4oCFzszVqo=;
        b=N7ZEF6Wkj+bZNrM2qtv7sDbfsw+hmChjhFwjUJba2Qo9s8RmpUwOOxnJ7c8vHpf+A8
         NA7O4tiebw8A1rK3EF05AbxtJ1YkvtAhVPtBpXGTcZTg8bO/TbP1OjkLxCddOGzjVLqJ
         5KMoXqzaFUUNy7NeXPjrG/Lez5PfbuJsFC5devTBTcoIQgBwfp79EjMGmmx4AqS6/sAH
         QvDxyYLG99A2QRwz/d6wVIHxvApnz8jHf+zLz/g91zXC5M4s/rHFCOXwgO9kxBJpHDjP
         1VUG/Ph3dEBnbAzZeZBybtvT+t6DCsH4tTCQKAXfgO4Wck8eGnnOg03ChGSCaPIaw/l/
         BUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686011146; x=1688603146;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6pVDecfV/BYz9QMaz3qiB/Z106nCFvvqH4oCFzszVqo=;
        b=Wxa7oQnOXWG1xFxzDAqUwioTMCH55bc5cLBLhKMlCVHoqAeiP7uh4XDRuNSux/VIM4
         LruHKCtbhQ3cQvtdzC2MkbyR9uqd6WizeVbp+/Wcc3LamiXCMSg/o/SiFHHpusI6G9Yz
         mBqSaCSbugIn9ZQb9KgmjHCGrK6XABN3nwsNAsMn7jHbTfCCd4/fDfMWPvPm3FTanjmx
         cShfd0qVDa9Ok1U3iYIhDjqzG7VOS41irXFqJn1rHxuymzAXORdDz/paDn+XvY87cA10
         zM0oxjyzOYqp6aqZaSRDZZpuqiXMA3BplWdJ8HyIu7KiyZTgxjJofildHSUypuu5FiEr
         FRpQ==
X-Gm-Message-State: AC+VfDw/BOPeIaJ2NM/IOa4qAQRB/ZD4PdbMyEmpWHwnffuOBq4yXOmd
        qrkO1oewiElz6XPVjPnguODf6A==
X-Google-Smtp-Source: ACHHUZ5scGBZR1QRRrZKXR6QfQndX4wHi2oXhUk7wNlJ2XP7wmi6Ugo/J8fNXMTFBRqRHTlIFpGjgg==
X-Received: by 2002:ac2:53bc:0:b0:4f6:13f1:38a4 with SMTP id j28-20020ac253bc000000b004f613f138a4mr239027lfh.41.1686011145891;
        Mon, 05 Jun 2023 17:25:45 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id u16-20020a056512095000b004f38260f196sm1271670lft.218.2023.06.05.17.25.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 17:25:45 -0700 (PDT)
Message-ID: <6be601ab-b5a4-3967-ea45-9965827e9f66@linaro.org>
Date:   Tue, 6 Jun 2023 03:25:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v15] drm/msm/dpu: add DSC blocks to the catalog of MSM8998
 and SC8180X
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org,
        marijn.suijten@somainline.org
Cc:     quic_abhinavk@quicinc.com, quic_jesszhan@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1686009494-25127-1-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1686009494-25127-1-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/2023 02:58, Kuogee Hsieh wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> Some platforms have DSC blocks which have not been declared in the catalog.
> Complete DSC 1.1 support for all platforms by adding the missing blocks to
> MSM8998 and SC8180X.
> 
> Changes in v9:
> -- add MSM8998 and SC8180x to commit title
> 
> Changes in v10:
> -- fix grammar at commit text
> 
> Changes in v12:
> -- fix "titil" with "title" at changes in v9
> 
> Changes in v14:
> -- "dsc" tp "DSC" at commit title
> 
> Changes in v15:
> -- fix merge conflicts at dpu_5_1_sc8180x.h
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h | 7 +++++++
>   drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h | 2 ++
>   2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
> index 3c732a0..7d0d0e7 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
> @@ -126,6 +126,11 @@ static const struct dpu_pingpong_cfg msm8998_pp[] = {
>   			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 15)),
>   };
>   
> +static const struct dpu_dsc_cfg msm8998_dsc[] = {
> +	DSC_BLK("dsc_0", DSC_0, 0x80000, 0),
> +	DSC_BLK("dsc_1", DSC_1, 0x80400, 0),
> +};
> +
>   static const struct dpu_dspp_cfg msm8998_dspp[] = {
>   	DSPP_BLK("dspp_0", DSPP_0, 0x54000, DSPP_SC7180_MASK,
>   		 &msm8998_dspp_sblk),
> @@ -199,6 +204,8 @@ const struct dpu_mdss_cfg dpu_msm8998_cfg = {
>   	.dspp = msm8998_dspp,
>   	.pingpong_count = ARRAY_SIZE(msm8998_pp),
>   	.pingpong = msm8998_pp,
> +	.dsc_count = ARRAY_SIZE(msm8998_dsc),
> +	.dsc = msm8998_dsc,
>   	.intf_count = ARRAY_SIZE(msm8998_intf),
>   	.intf = msm8998_intf,
>   	.vbif_count = ARRAY_SIZE(msm8998_vbif),
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h
> index 8ed2b263..b5c575c 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h
> @@ -230,6 +230,8 @@ const struct dpu_mdss_cfg dpu_sc8180x_cfg = {
>   	.dsc = sc8180x_dsc,
>   	.pingpong_count = ARRAY_SIZE(sc8180x_pp),
>   	.pingpong = sc8180x_pp,
> +	.dsc_count = ARRAY_SIZE(sc8180x_dsc),
> +	.dsc = sc8180x_dsc,

If you take a glance three lines above, you'll see .dsc assignment.

>   	.merge_3d_count = ARRAY_SIZE(sc8180x_merge_3d),
>   	.merge_3d = sc8180x_merge_3d,
>   	.intf_count = ARRAY_SIZE(sc8180x_intf),

-- 
With best wishes
Dmitry

