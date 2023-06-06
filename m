Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3721F724C89
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 21:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239423AbjFFTIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 15:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239394AbjFFTHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 15:07:23 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6032105
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 12:05:13 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4effb818c37so7963609e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 12:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686078292; x=1688670292;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gtFgxYwjpUt68r3YPqakTIdPhlEwVeuW3nCboOazwYw=;
        b=hC5RWVnOExAfo1+RCwZD04IMwg7WZ8kKQK6HVJCvLuu5xXsnFGnn1bPKZA6UCn90Cs
         /kGaLoAvXe6lD6gqi9YHIsWSvBfuQIavrLXsBRFUdb0GRsQfduxItmUIqFnIYNRZOLMb
         3JNaaugZQCcdU7NIQ02HLzjOxmv/PMCH+vCzuvZv4/qwDorzdSNTxEqSKjcfIYIWxxDT
         uevZ3i2n1xw1iaKTIZqs0AXnw9+fBltRRAH7Ucjte3sCiuFAkRWmbfX1r08SNhRn+8xW
         +XZQxOUhxIjF554m09kK08wbe/xUqHgX7YQcBLxz2XmD7VV9L6pwkXdncvy6pUZDbAjh
         z6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686078292; x=1688670292;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gtFgxYwjpUt68r3YPqakTIdPhlEwVeuW3nCboOazwYw=;
        b=cA9ys+IsHFHX2t7MW5s/6tsW6TTY8daIf+arnv8JIcM37Y1WgdbJzPgWR2gopzWPoq
         34eKHoSARAaskzdd0+F9LvVlbyngvSfCUDixKArqGg2K3b3GaNUJQp0QXWn60Nd/VDot
         R9Ubt8aUULbk46/V+XWbqi74KoXfkFF/wYAkw/lA9GFKllqL4wh9BfTIQYuIAmNH7LRi
         Q8Kp9pUwFKQQw31IqIlQYP8xgg1a5jnFfhECiaF+FtAUhfnC9/lQ6ctZXoGu/3aeFw5O
         Q8tj6CjqJgY1+BZ8wJm+Eqi52fRpqcKVr/z6jNgFFXT7FhqNNTpRKAbBovVwTz8OcBFL
         Q9JA==
X-Gm-Message-State: AC+VfDxFnGV7lHm2MkqT+u+CoYrzfYpjZfsQ+Ks0ed5dbI03MdVX+vhy
        XHVpljvqzzlDpDQj8UAm/lt26g==
X-Google-Smtp-Source: ACHHUZ6bgt/R2v8mJhbothbqAYtjCEQJuoHpVxJyzRnUW3hd73sKHWap/htT50fIsZIcT2Nm54StGw==
X-Received: by 2002:ac2:43b3:0:b0:4f3:b32d:f744 with SMTP id t19-20020ac243b3000000b004f3b32df744mr1289528lfl.11.1686078292036;
        Tue, 06 Jun 2023 12:04:52 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id f2-20020ac25322000000b004cb14fa604csm1537514lfh.262.2023.06.06.12.04.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 12:04:51 -0700 (PDT)
Message-ID: <0ab30652-4ee5-e4e8-9802-d8211dfb8d67@linaro.org>
Date:   Tue, 6 Jun 2023 22:04:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v16] drm/msm/dpu: add DSC blocks to the catalog of MSM8998
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
References: <1686076299-11504-1-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1686076299-11504-1-git-send-email-quic_khsieh@quicinc.com>
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

On 06/06/2023 21:31, Kuogee Hsieh wrote:
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
> Changes in v16
> -- fix cherry-pick error by deleting both redundant .dsc and .dsc_count
>     assignment from dpu_5_1_sc8180x.h
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>

The patch was changed significantly. Thus the review-by's do not apply 
anymore. Please take care to drop reviewed-by and acked-by tags when you 
change the patch was changed in a sensible manner. Otherwise it would be 
impossible to understand if the patch was really reviewed or not.

> ---
>   drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h | 7 +++++++
>   1 file changed, 7 insertions(+)
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

-- 
With best wishes
Dmitry

