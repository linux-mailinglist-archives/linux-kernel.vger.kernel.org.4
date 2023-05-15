Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADC47040C4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 00:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245680AbjEOWLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 18:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245554AbjEOWL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 18:11:27 -0400
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B5810E7E;
        Mon, 15 May 2023 15:10:55 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id B36403F360;
        Tue, 16 May 2023 00:10:31 +0200 (CEST)
Date:   Tue, 16 May 2023 00:10:30 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, dmitry.baryshkov@linaro.org,
        andersson@kernel.org, Abhinav Kumar <quic_abhinavk@quicinc.com>,
        quic_jesszhan@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/8] drm/msm/dpu: add dsc blocks to the catalog of
 MSM8998 and SC8180X
Message-ID: <mihoiwvnerusg2wkl3hpb42klopkcsom2g4lds5dwfay4zjkir@d6qz4dvl6m3u>
References: <1684185928-24195-1-git-send-email-quic_khsieh@quicinc.com>
 <1684185928-24195-2-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1684185928-24195-2-git-send-email-quic_khsieh@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once again, capitalize DSC in the title.

On 2023-05-15 14:25:21, Kuogee Hsieh wrote:
> 
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> There are some platforms has DSC blocks which have not been declared in

There are some platforms has?

How about (as suggested in earlier review): Some platforms have...

> the catalog. Complete DSC 1.1 support for all platforms by adding the
> missing blocks to MSM8998 and SC8180X.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

After fixing the grammar:

Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>

Thanks!

> ---
>  drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h |  7 +++++++
>  drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h | 11 +++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
> index c0dd477..521cfd5 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
> @@ -126,6 +126,11 @@ static const struct dpu_pingpong_cfg msm8998_pp[] = {
>  			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 15)),
>  };
>  
> +static const struct dpu_dsc_cfg msm8998_dsc[] = {
> +	DSC_BLK("dsc_0", DSC_0, 0x80000, 0),
> +	DSC_BLK("dsc_1", DSC_1, 0x80400, 0),
> +};
> +
>  static const struct dpu_dspp_cfg msm8998_dspp[] = {
>  	DSPP_BLK("dspp_0", DSPP_0, 0x54000, DSPP_MSM8998_MASK,
>  		 &msm8998_dspp_sblk),
> @@ -199,6 +204,8 @@ const struct dpu_mdss_cfg dpu_msm8998_cfg = {
>  	.dspp = msm8998_dspp,
>  	.pingpong_count = ARRAY_SIZE(msm8998_pp),
>  	.pingpong = msm8998_pp,
> +	.dsc_count = ARRAY_SIZE(msm8998_dsc),
> +	.dsc = msm8998_dsc,
>  	.intf_count = ARRAY_SIZE(msm8998_intf),
>  	.intf = msm8998_intf,
>  	.vbif_count = ARRAY_SIZE(msm8998_vbif),
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h
> index e8057a1..fec1665 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h
> @@ -142,6 +142,15 @@ static const struct dpu_merge_3d_cfg sc8180x_merge_3d[] = {
>  	MERGE_3D_BLK("merge_3d_2", MERGE_3D_2, 0x83200),
>  };
>  
> +static const struct dpu_dsc_cfg sc8180x_dsc[] = {
> +	DSC_BLK("dsc_0", DSC_0, 0x80000, BIT(DPU_DSC_OUTPUT_CTRL)),
> +	DSC_BLK("dsc_1", DSC_1, 0x80400, BIT(DPU_DSC_OUTPUT_CTRL)),
> +	DSC_BLK("dsc_2", DSC_2, 0x80800, BIT(DPU_DSC_OUTPUT_CTRL)),
> +	DSC_BLK("dsc_3", DSC_3, 0x80c00, BIT(DPU_DSC_OUTPUT_CTRL)),
> +	DSC_BLK("dsc_4", DSC_4, 0x81000, BIT(DPU_DSC_OUTPUT_CTRL)),
> +	DSC_BLK("dsc_5", DSC_5, 0x81400, BIT(DPU_DSC_OUTPUT_CTRL)),
> +};
> +
>  static const struct dpu_intf_cfg sc8180x_intf[] = {
>  	INTF_BLK("intf_0", INTF_0, 0x6a000, 0x280, INTF_DP, MSM_DP_CONTROLLER_0, 24, INTF_SC7180_MASK,
>  			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 24),
> @@ -206,6 +215,8 @@ const struct dpu_mdss_cfg dpu_sc8180x_cfg = {
>  	.mixer = sc8180x_lm,
>  	.pingpong_count = ARRAY_SIZE(sc8180x_pp),
>  	.pingpong = sc8180x_pp,
> +	.dsc_count = ARRAY_SIZE(sc8180x_dsc),
> +	.dsc = sc8180x_dsc,
>  	.merge_3d_count = ARRAY_SIZE(sc8180x_merge_3d),
>  	.merge_3d = sc8180x_merge_3d,
>  	.intf_count = ARRAY_SIZE(sc8180x_intf),
> -- 
> 2.7.4
> 
