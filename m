Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6BC6F5370
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 10:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjECIgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 04:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjECIgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 04:36:12 -0400
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [5.144.164.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E11759D6
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 01:35:05 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id B5F043F34A;
        Wed,  3 May 2023 10:35:02 +0200 (CEST)
Date:   Wed, 3 May 2023 10:35:01 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, dmitry.baryshkov@linaro.org,
        andersson@kernel.org, quic_abhinavk@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7]  add DSC 1.2 dpu supports
Message-ID: <iu4mpb4qfyh6b4dwsnzmojgovwg7mcq76z3sfknfmzqcwfyex4@ypz4bmfo4vft>
References: <1683061382-32651-1-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1683061382-32651-1-git-send-email-quic_khsieh@quicinc.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nit: drop leading space, use singular support*.

On 2023-05-02 14:02:55, Kuogee Hsieh wrote:
> This series adds the DPU side changes to support DSC 1.2 encoder. This
> was validated with both DSI DSC 1.2 panel and DP DSC 1.2 monitor.
> The DSI and DP parts will be pushed later on top of this change.
> This seriel is rebase on [1], [2] and catalog fixes from [3].

rebased*
> 
> [1]: https://patchwork.freedesktop.org/series/116851/
> [2]: https://patchwork.freedesktop.org/series/116615/
> [3]: https://patchwork.freedesktop.org/series/112332/

Was it only rebased on the catalog fixes from my INTF TE [3] support
series?  I cannot get patch 2/7 of this series to apply cleanly on top
of the entire INTF TE series because of a conflict with INTF TE patch
14/22 [4].

Patch 3/7 ("add DPU_PINGPONG_DSC bits into PP_BLK and PP_BLK_TE marcos")
doesn't apply either, probably because I removed PP_BLK_TE entirely in
that same ([4]) patch.

[4]: https://lore.kernel.org/linux-arm-msm/20230411-dpu-intf-te-v4-14-27ce1a5ab5c6@somainline.org/

We should discuss in what order the series are going to be picked, so
that it is all compatible.

- Marijn

> Abhinav Kumar (2):
>   drm/msm/dpu: add dsc blocks for remaining chipsets in catalog
>   drm/msm/dpu: add DSC 1.2 hw blocks for relevant chipsets
> 
> Kuogee Hsieh (5):
>   drm/msm/dpu: add DPU_PINGPONG_DSC feature bit
>   drm/msm/dpu: add DPU_PINGPONG_DSC bits into PP_BLK and PP_BLK_TE
>     marcos
>   drm/msm/dpu: add PINGPONG_NONE to disconnect DSC from PINGPONG
>   drm/msm/dpu: add support for DSC encoder v1.2 engine
>   drm/msm/dpu: separate DSC flush update out of interface
> 
>  drivers/gpu/drm/msm/Makefile                       |   1 +
>  .../drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h    |  19 +-
>  .../gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h |   8 +-
>  .../gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h |  26 +-
>  .../drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h    |  35 +-
>  .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h |  26 +-
>  .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_2_sc7180.h |   4 +-
>  .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_3_sm6115.h |   2 +-
>  .../drm/msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h    |   2 +-
>  .../gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h |  14 +
>  .../gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h |   7 +
>  .../drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h   |  16 +
>  .../gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h |  14 +
>  .../gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h |  14 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |  16 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |  35 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |  36 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c         |  22 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h         |  10 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c         |   7 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h         |  15 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc_1_2.c     | 383 +++++++++++++++++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h        |   3 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c    |   9 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c             |   7 +-
>  25 files changed, 649 insertions(+), 82 deletions(-)
>  create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc_1_2.c
> 
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
