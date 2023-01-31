Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015B8682CE0
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 13:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjAaMpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 07:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbjAaMpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 07:45:19 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D029D4B885
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 04:45:16 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id hx15so21690681ejc.11
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 04:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8xbu9OSYb70xb94Yeo31t8Oaxtx3TEHDRghlLnFGwEE=;
        b=HOQM9HVcHNtPQArB9zdGc+O47H5Vo84d9V9VhhhQrU/5yzCLU+SMlVuEXnZEe41pPW
         xCHkVMP0gyrDWj5XBdMUjyi6KNx3SI0bCDzcCw//4Q4eJ0BFD31xHLDO1LwVeNj/HU1n
         pn7Yrhd9FC4tgM74wBgvGOolUVNYG7r6SnbaOrdBKMg+Kqu4XwGbYpdeBgJZXgB+tx5W
         JS6wjUKIIWY0euwy/bDqjwp8YBzxeaXhNr7BKPX0CRbvGRHsHRdviH54iPCU6xATZPhd
         0DvpWRLxxdpNcx2zvS58RGKJzBNRgo8/NV9p6BdhTEQOR3YIKSVo0LTqoThKIYQUrkVI
         7IZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8xbu9OSYb70xb94Yeo31t8Oaxtx3TEHDRghlLnFGwEE=;
        b=3yTm6gCWUeKcd2ZdgcG02uwOceaaPBIt7Lx/adFZ52Ww+a9dKMaLltFJ4JpS6CSdr9
         vWhFqS1wM3yBnRpdALgodN1ZmD3A2gSnFLBC82V771LkD3SkPWmB4dJ12xLhz4b5C6hS
         FExzzRYlqrko401Z8NeQC0ifTjU1iYA+IYu0hLxPmb+gBxEv8jvfcfK8969fV1SmA9Om
         VYp6qVqx4tUhYvQbyFwdjPYQu3LaxOYa5+fQN55KxSVqlLXpCVj/6XhyapkGnhF4zsdx
         ocdZ9m00O3PZqSxiotVDN3RKxAQ+uT68nYiKmpBgylTDsffTOrSdXEVMiq+vuYbCnNYr
         g4UQ==
X-Gm-Message-State: AO0yUKXTPuRU3sMF5/WASoXmE8APmSi2zwP+ZlhEbFNItKth5CSawqee
        ckDvOMe+FgrUvrIfPpU/aLJfhA==
X-Google-Smtp-Source: AK7set+xEX/0VUfgwRIBFa8ZDHADe1V6jD0Mhcsk+kdmw3nw7+rNAJsp1S6XWKh5HOt4IleZY/zvCw==
X-Received: by 2002:a17:907:a0d2:b0:878:7f6e:38a7 with SMTP id hw18-20020a170907a0d200b008787f6e38a7mr3298474ejc.44.1675169115144;
        Tue, 31 Jan 2023 04:45:15 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id hq15-20020a1709073f0f00b00877ff0c2bb0sm8411192ejc.166.2023.01.31.04.45.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 04:45:14 -0800 (PST)
Message-ID: <7b90ce05-29ac-da1c-ca3c-c52577d131ea@linaro.org>
Date:   Tue, 31 Jan 2023 14:45:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v12 02/14] drm/msm/disp/dpu: get timing engine status from
 intf status register
Content-Language: en-GB
To:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, swboyd@chromium.org,
        quic_kalyant@quicinc.com, quic_khsieh@quicinc.com,
        quic_vproddut@quicinc.com, quic_bjorande@quicinc.com,
        quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com
References: <1675091494-13988-1-git-send-email-quic_vpolimer@quicinc.com>
 <1675091494-13988-3-git-send-email-quic_vpolimer@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1675091494-13988-3-git-send-email-quic_vpolimer@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/01/2023 17:11, Vinod Polimera wrote:
> Recommended way of reading the interface timing gen status is via
> status register. Timing gen status register will give a reliable status
> of the interface especially during ON/OFF transitions. This support was
> added from DPU version 5.0.0.
> 
> Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c |  6 ++++--
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h | 12 +++++++-----
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c    |  8 +++++++-
>   3 files changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> index cf053e8..ce6e9e6 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> @@ -78,9 +78,11 @@
>   
>   #define INTF_SDM845_MASK (0)
>   
> -#define INTF_SC7180_MASK BIT(DPU_INTF_INPUT_CTRL) | BIT(DPU_INTF_TE)
> +#define INTF_SC7180_MASK \
> +	(BIT(DPU_INTF_INPUT_CTRL) | BIT(DPU_INTF_TE) | BIT(DPU_INTF_STATUS_SUPPORTED))
>   
> -#define INTF_SC7280_MASK INTF_SC7180_MASK | BIT(DPU_DATA_HCTL_EN)
> +#define INTF_SC7280_MASK \
> +	(INTF_SC7180_MASK | BIT(DPU_DATA_HCTL_EN))

Not necessary anymore.

With that fixed:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

>   
>   #define IRQ_SDM845_MASK (BIT(MDP_SSPP_TOP0_INTR) | \
>   			 BIT(MDP_SSPP_TOP0_INTR2) | \
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> index ddab9ca..08cd1a1 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> @@ -213,17 +213,19 @@ enum {
>   
>   /**
>    * INTF sub-blocks
> - * @DPU_INTF_INPUT_CTRL         Supports the setting of pp block from which
> - *                              pixel data arrives to this INTF
> - * @DPU_INTF_TE                 INTF block has TE configuration support
> - * @DPU_DATA_HCTL_EN            Allows data to be transferred at different rate
> -                                than video timing
> + * @DPU_INTF_INPUT_CTRL             Supports the setting of pp block from which
> + *                                  pixel data arrives to this INTF
> + * @DPU_INTF_TE                     INTF block has TE configuration support
> + * @DPU_DATA_HCTL_EN                Allows data to be transferred at different rate
> + *                                  than video timing
> + * @DPU_INTF_STATUS_SUPPORTED       INTF block has INTF_STATUS register
>    * @DPU_INTF_MAX
>    */
>   enum {
>   	DPU_INTF_INPUT_CTRL = 0x1,
>   	DPU_INTF_TE,
>   	DPU_DATA_HCTL_EN,
> +	DPU_INTF_STATUS_SUPPORTED,
>   	DPU_INTF_MAX
>   };
>   
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> index 7ce66bf..84ee2ef 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> @@ -62,6 +62,7 @@
>   #define   INTF_LINE_COUNT               0x0B0
>   
>   #define   INTF_MUX                      0x25C
> +#define   INTF_STATUS                   0x26C
>   
>   #define INTF_CFG_ACTIVE_H_EN	BIT(29)
>   #define INTF_CFG_ACTIVE_V_EN	BIT(30)
> @@ -297,8 +298,13 @@ static void dpu_hw_intf_get_status(
>   		struct intf_status *s)
>   {
>   	struct dpu_hw_blk_reg_map *c = &intf->hw;
> +	unsigned long cap = intf->cap->features;
> +
> +	if (cap & BIT(DPU_INTF_STATUS_SUPPORTED))
> +		s->is_en = DPU_REG_READ(c, INTF_STATUS) & BIT(0);
> +	else
> +		s->is_en = DPU_REG_READ(c, INTF_TIMING_ENGINE_EN);
>   
> -	s->is_en = DPU_REG_READ(c, INTF_TIMING_ENGINE_EN);
>   	s->is_prog_fetch_en = !!(DPU_REG_READ(c, INTF_CONFIG) & BIT(31));
>   	if (s->is_en) {
>   		s->frame_count = DPU_REG_READ(c, INTF_FRAME_COUNT);

-- 
With best wishes
Dmitry

