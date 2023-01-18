Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14B9671A2F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 12:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjARLN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 06:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjARLM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 06:12:57 -0500
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [5.144.164.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8139A47089;
        Wed, 18 Jan 2023 02:22:06 -0800 (PST)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 17F9720123;
        Wed, 18 Jan 2023 11:22:04 +0100 (CET)
Date:   Wed, 18 Jan 2023 11:22:02 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run, airlied@gmail.com,
        daniel@ffwll.ch, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH v2] drm/msm/dpu: Remove some unused variables
Message-ID: <20230118102202.3oaiv74oo2pi6uuu@SoMainline.org>
References: <20230118091833.87708-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118091833.87708-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-18 17:18:33, Jiapeng Chong wrote:
> Variables 'sc8280xp_regdma' and 'sm8350_regdma' are defined in the
> dpu_hw_catalog.c file, but not used elsewhere, so remove these unused
> variables.
> 
> drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c:2029:37: warning: unused
> variable 'sc8280xp_regdma'.
> drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c:2053:37: warning: unused
> variable 'sm8350_regdma'.
> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3722
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Does this need a Fixes tag?

> ---
> Changes in v2:
>   -Adding the regdma entries to .dma_cfg of these chipsets.

Don't forget to change the title of this patch; now you're not removing
unused variables anymore.

- Marijn

>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> index 0f3da480b066..3318e1d18a0e 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> @@ -2677,6 +2677,8 @@ static const struct dpu_mdss_cfg sc8280xp_dpu_cfg = {
>  	.intf = sc8280xp_intf,
>  	.vbif_count = ARRAY_SIZE(sdm845_vbif),
>  	.vbif = sdm845_vbif,
> +	.reg_dma_count = 1,
> +	.dma_cfg = &sc8280xp_regdma,
>  	.perf = &sc8280xp_perf_data,
>  	.mdss_irqs = IRQ_SC8280XP_MASK,
>  };
> @@ -2732,7 +2734,7 @@ static const struct dpu_mdss_cfg sm8350_dpu_cfg = {
>  	.vbif_count = ARRAY_SIZE(sdm845_vbif),
>  	.vbif = sdm845_vbif,
>  	.reg_dma_count = 1,
> -	.dma_cfg = &sm8250_regdma,
> +	.dma_cfg = &sm8350_regdma,
>  	.perf = &sm8350_perf_data,
>  	.mdss_irqs = IRQ_SM8350_MASK,
>  };
> -- 
> 2.20.1.7.g153144c
> 
