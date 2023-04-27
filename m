Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14976F0D16
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 22:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344199AbjD0UZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 16:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344254AbjD0UY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 16:24:56 -0400
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [5.144.164.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405471BEE
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 13:24:55 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 6054C1F637;
        Thu, 27 Apr 2023 22:24:53 +0200 (CEST)
Date:   Thu, 27 Apr 2023 22:24:52 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, quic_jesszhan@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] drm/msm/dpu: drop DSPP_MSM8998_MASK from hw
 catalog
Message-ID: <ypbvme4nuc7sid65wrpbpnsianwnq2dd6iozbhg7k47gio3f3e@75bb5efa43ri>
References: <20230426192246.5517-1-quic_abhinavk@quicinc.com>
 <20230426192246.5517-4-quic_abhinavk@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426192246.5517-4-quic_abhinavk@quicinc.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-26 12:22:46, Abhinav Kumar wrote:
> Since GC and IGC masks have now been dropped DSPP_MSM8998_MASK
> is same as DSPP_SC7180_MASK. Since DSPP_SC7180_MASK is used more
> than DSPP_MSM8998_MASK, lets drop the latter.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

Fair enough, I'd use the oldest SoC but that'd require many more
unnecessary rename changes (or even better: we inline these flags at
some point, and drop .id fields from those already present in sblk).

Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>

> ---
>  drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h | 4 ++--
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c          | 2 --
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
> index 2b3ae84057df..5f6e4715aa04 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
> @@ -127,9 +127,9 @@ static const struct dpu_pingpong_cfg msm8998_pp[] = {
>  };
>  
>  static const struct dpu_dspp_cfg msm8998_dspp[] = {
> -	DSPP_BLK("dspp_0", DSPP_0, 0x54000, DSPP_MSM8998_MASK,
> +	DSPP_BLK("dspp_0", DSPP_0, 0x54000, DSPP_SC7180_MASK,
>  		 &msm8998_dspp_sblk),
> -	DSPP_BLK("dspp_1", DSPP_1, 0x56000, DSPP_MSM8998_MASK,
> +	DSPP_BLK("dspp_1", DSPP_1, 0x56000, DSPP_SC7180_MASK,
>  		 &msm8998_dspp_sblk),
>  };
>  
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> index badfc3680485..2cabba0bb513 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> @@ -91,8 +91,6 @@
>  
>  #define MERGE_3D_SM8150_MASK (0)
>  
> -#define DSPP_MSM8998_MASK BIT(DPU_DSPP_PCC)
> -
>  #define DSPP_SC7180_MASK BIT(DPU_DSPP_PCC)
>  
>  #define INTF_SDM845_MASK (0)
> -- 
> 2.40.1
> 
