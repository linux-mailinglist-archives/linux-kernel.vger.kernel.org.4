Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093AC6F0D0F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 22:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344223AbjD0UXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 16:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343615AbjD0UX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 16:23:28 -0400
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [5.144.164.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35808421E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 13:23:17 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 4DBC120139;
        Thu, 27 Apr 2023 22:23:16 +0200 (CEST)
Date:   Thu, 27 Apr 2023 22:23:15 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, quic_jesszhan@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] drm/msm/dpu: remove DPU_DSPP_IGC handling in dspp
 flush
Message-ID: <ermqajlmrau5tyxowrkpglcqrbgly7b3j7chquh24wufmonpz7@wttboyajb4f7>
References: <20230426192246.5517-1-quic_abhinavk@quicinc.com>
 <20230426192246.5517-2-quic_abhinavk@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426192246.5517-2-quic_abhinavk@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DSPP*

On 2023-04-26 12:22:44, Abhinav Kumar wrote:
> Inverse gamma correction blocks (IGC) are not used today so lets
> remove the usage of DPU_DSPP_IGC in the dspp flush to make it easier

DSPP*

> to remove IGC from the catalog.
> 
> We can add this back when IGC is properly supported in DPU with
> one of the standard DRM properties.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>

> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> index 57adaebab563..b2a1f83ac72c 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> @@ -330,9 +330,6 @@ static void dpu_hw_ctl_update_pending_flush_dspp_sub_blocks(
>  		return;
>  
>  	switch (dspp_sub_blk) {
> -	case DPU_DSPP_IGC:
> -		ctx->pending_dspp_flush_mask[dspp - DSPP_0] |= BIT(2);
> -		break;
>  	case DPU_DSPP_PCC:
>  		ctx->pending_dspp_flush_mask[dspp - DSPP_0] |= BIT(4);
>  		break;
> -- 
> 2.40.1
> 
