Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32DB724DEA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 22:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238436AbjFFUVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 16:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239090AbjFFUVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 16:21:15 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD3B1736
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 13:21:12 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f624daccd1so3887807e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 13:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686082871; x=1688674871;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z7aI3e/R1O29v1D02LZIiBc9hZVVp0JRWx1yMJ/ew1Y=;
        b=dM9X2neFZucJ440IZwGtOLm4EaZ8R98GE+eyoZd+dGi9i3s4WN66/JAsuGp5ZKjS4+
         YhG02aC3v1vgjIx86y6YlPfmacATUMhvSiuRB5SLf2aExjIuvNDapFRUGSAzO57RJKIS
         WcJah/+svu+hHOhk2KerOVU0ynJST0jNR4xBEisC9jqOi+RNpfXE3XzUr2JSZYsj1dLU
         Ful9EiBv2dzWa54Q39GhnvsqnmVQtpveYFgwc9akRX1Jqd4xACOHAQobIFa9G4gEusTC
         PNyL7F6nd9hGRFK+hs0CWsazU1/sWxjHE9dctrDlwV+vgnGLA7sunGswcnj/r2YlXcn9
         SC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686082871; x=1688674871;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z7aI3e/R1O29v1D02LZIiBc9hZVVp0JRWx1yMJ/ew1Y=;
        b=NaeMQOaMOSuu8LGaDJjClxpnqwTx4y33OrHC0kN6DFLQkGbk+d37GVvupYWrhXt+tK
         xy2Gr4wH+BUJLJ83DUe/n+P9HDTfe+0/AmIjPidEcZ+YaIqpaN2H9jhRLGl5umlPLiTa
         ciR0IQ/ULQydlY3Q4KIWQetUGuTtlPuhm4UHetA+bZS9oVOLwWS461uSh806mYoGV8Xz
         l57ejJbNoOkr1wlcpbzoy7PjrfcC+zPUoJFPS2byAwoSg7rYxPzQvga1yWxd8Tc+o9CE
         yAyz8ipXZfJLp/x+WzXL3APTqZG/Y8jsYsx4M8HDKalZ6gIycLRbdsTMTsX63GP7iag0
         T4rw==
X-Gm-Message-State: AC+VfDy1tLwDPuw8DxyreW4L43qWUs0J1GoS+5PqCjPopCBjLkeZ7ODQ
        8nqM18SeJ7GRIPLHOzc3c6FlWw==
X-Google-Smtp-Source: ACHHUZ797lKZs89F6iTSzUbEpqIWHymwHU7hMvjz3R1+cm+nh3btf9vOTCkedVYrJStMjK+bfnMrFQ==
X-Received: by 2002:ac2:51b1:0:b0:4f3:a69e:1d80 with SMTP id f17-20020ac251b1000000b004f3a69e1d80mr1328935lfk.0.1686082870734;
        Tue, 06 Jun 2023 13:21:10 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id x12-20020ac25dcc000000b004f0049433adsm1553579lfq.307.2023.06.06.13.21.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 13:21:09 -0700 (PDT)
Message-ID: <a5e25f3e-1b66-8a66-7e16-9d5c22a53e66@linaro.org>
Date:   Tue, 6 Jun 2023 23:21:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v17] drm/msm/dpu: add DSC blocks to the catalog of MSM8998
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
References: <1686082272-22191-1-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1686082272-22191-1-git-send-email-quic_khsieh@quicinc.com>
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

On 06/06/2023 23:11, Kuogee Hsieh wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> Some platforms have DSC blocks which have not been declared in the catalog.
> Complete DSC 1.1 support for all platforms by adding the missing blocks to
> MSM8998.

'Some platforms' doesn't make sense if we are talking about a single 
poor msm8998.

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
> Changes in v17
> -- remove sc8180x from both commit title and text
> -- remove Reviewed-by
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
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

