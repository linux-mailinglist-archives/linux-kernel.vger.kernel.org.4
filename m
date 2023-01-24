Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D38678CC0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 01:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjAXAYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 19:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjAXAYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 19:24:11 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5A820064
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 16:24:10 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id mp20so34908403ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 16:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WkLUCuqhYI1Ui/jekNftV/AMQqAfMQqFdPq5vZC/DDY=;
        b=myCcL36oasOShSEDqZfqDGpTUP2FewXj6uRmzPrbThMRXoVkkHiovi+Y9TGtalc27L
         TPfhYlcHNhQuH3m8gCAY/pGi9TEDRSUMyYJgC5S2v6Pgr5gfbjTplyLpxsXFFfavy2dT
         OlGJq+6cbWgrGM1MwzQDU3gUUjMpOEhKikl9lwSbKVClmLrC/ZiHn0uZYGzzc5BkDdbX
         MktbDJmWEXlkU7jB15EVSA91N9Pyq8tCGSPseykM2pHSST9WqgHHfAnd4yH1I6zw8fot
         P0LoFbcHg0Ty6Mb3bU8Kh8prJ/SlCWE3KmRs7B5aPGtLWuSfj+fdBDS4WwZn61a6Z1lX
         JHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WkLUCuqhYI1Ui/jekNftV/AMQqAfMQqFdPq5vZC/DDY=;
        b=BPqEOuvsh4llVMwi1awkpkif60zWSKwPStKaknokTgUvFv3SmXr1OixB2x5hMtbseL
         2xOidZg5ptz74KXtTYqAc6P7wZezv0vp3OlGJLdU8AHHEOl4sTxSM89fLwCJ14los16e
         SoYVldctNK+ALOgFw4lKBmSptyxx8mU1BCRBOAzdd9AT3bc04m8jQp8TncK7e+TlcKpH
         PrAoZv0x59NpmLdetnjFpuKenBCMR6QfmA7fNPArRBrh4dlwaJX1ccf8Zw/TCE6/QK2o
         9lUACtkuIpyyEEsOg5BLiWvZ8F2D4C9cqDgP/al38JV4/Bwxy/B0L2Necqub4+52XAbF
         /sIA==
X-Gm-Message-State: AFqh2kq3st6ikUZ8tn+fb6xZm0Lns4tbxnQk26BKIl9B3BW9nmXYkxni
        6HVA6ulcLUSTPiu3ZUkXuamLNA==
X-Google-Smtp-Source: AMrXdXtLKkSufGF6LRjLSMVjZYGARnbbpbex7gjk9ErYfvxWDjbfgzJZda2Fs+G1sBW3kiMiVNdEwQ==
X-Received: by 2002:a17:907:d505:b0:877:8100:8bd0 with SMTP id wb5-20020a170907d50500b0087781008bd0mr21137996ejc.75.1674519849240;
        Mon, 23 Jan 2023 16:24:09 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id a8-20020a17090680c800b0084d397e0938sm114137ejx.195.2023.01.23.16.24.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 16:24:08 -0800 (PST)
Message-ID: <157a5a24-6945-fdb4-194c-a18f969e2bd9@linaro.org>
Date:   Tue, 24 Jan 2023 02:24:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH Resend v11 11/15] drm/msm/disp/dpu: get timing engine
 status from intf status register
Content-Language: en-GB
To:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, swboyd@chromium.org,
        quic_kalyant@quicinc.com, quic_khsieh@quicinc.com,
        quic_vproddut@quicinc.com, quic_bjorande@quicinc.com,
        quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com
References: <1674138393-475-1-git-send-email-quic_vpolimer@quicinc.com>
 <1674138393-475-12-git-send-email-quic_vpolimer@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1674138393-475-12-git-send-email-quic_vpolimer@quicinc.com>
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

On 19/01/2023 16:26, Vinod Polimera wrote:
> Recommended way of reading the interface timing gen status is via
> status register. Timing gen status register will give a reliable status
> of the interface especially during ON/OFF transitions. This support was
> added from DPU version 5.0.0.

5.0.0 is sm8150. I have expected to see INTF_SC7180_MASK to be changed, 
while this patch for some reason changes only INTF_SC7280_MASK. Could 
you please clarify this?

> 
> Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c |  3 ++-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h | 12 +++++++-----
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c    |  8 +++++++-
>   3 files changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> index 4375e72..0244a7b 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> @@ -80,7 +80,8 @@
>   
>   #define INTF_SC7180_MASK BIT(DPU_INTF_INPUT_CTRL) | BIT(DPU_INTF_TE)
>   
> -#define INTF_SC7280_MASK INTF_SC7180_MASK | BIT(DPU_DATA_HCTL_EN)
> +#define INTF_SC7280_MASK \
> +	(INTF_SC7180_MASK | BIT(DPU_DATA_HCTL_EN) | BIT(DPU_INTF_STATUS_SUPPORTED))
>   
>   #define IRQ_SDM845_MASK (BIT(MDP_SSPP_TOP0_INTR) | \
>   			 BIT(MDP_SSPP_TOP0_INTR2) | \
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> index 978e3bd..79c18fe 100644
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

