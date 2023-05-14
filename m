Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDE1701FE0
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 23:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjENVbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 17:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjENVbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 17:31:48 -0400
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [5.144.164.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2772A10CE
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 14:31:47 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id CE6F23F250;
        Sun, 14 May 2023 23:31:44 +0200 (CEST)
Date:   Sun, 14 May 2023 23:31:43 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, dmitry.baryshkov@linaro.org,
        andersson@kernel.org, quic_abhinavk@quicinc.com,
        quic_jesszhan@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/8] add DSC 1.2 dpu supports
Message-ID: <h6vc4delvatto3vyyho5io3ebs2yhmgrchnxcprca56my6fflb@4fcb334sdmpn>
References: <1683914423-17612-1-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1683914423-17612-1-git-send-email-quic_khsieh@quicinc.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Asked this before: change the title to "DPU support" (capital "DPU",
singular "support") if this series keeps being resent.

On 2023-05-12 11:00:15, Kuogee Hsieh wrote:
> 
> This series adds the DPU side changes to support DSC 1.2 encoder. This
> was validated with both DSI DSC 1.2 panel and DP DSC 1.2 monitor.
> The DSI and DP parts will be pushed later on top of this change.
> This seriel is rebase on [1], [2] and catalog fixes from rev-4 of [3].

series*

rebased*

Also I think it's not just the catalog fixes but everything now, because
we were both touching HW block implementations?

- Marijn

> [1]: https://patchwork.freedesktop.org/series/116851/
> [2]: https://patchwork.freedesktop.org/series/116615/
> [3]: https://patchwork.freedesktop.org/series/112332/
> 
> Abhinav Kumar (2):
>   drm/msm/dpu: add dsc blocks for remaining chipsets in catalog
>   drm/msm/dpu: add DSC 1.2 hw blocks for relevant chipsets
> 
> Kuogee Hsieh (6):
>   drm/msm/dpu: add DPU_PINGPONG_DSC feature bit for DPU < 7.0.0
>   drm/msm/dpu: test DPU_PINGPONG_DSC bit before assign DSC ops to
>     PINGPONG
>   drm/msm/dpu: Introduce PINGPONG_NONE to disconnect DSC from PINGPONG
>   drm/msm/dpu: add support for DSC encoder v1.2 engine
>   drm/msm/dpu: separate DSC flush update out of interface
>   drm/msm/dpu: tear down DSC data path when DSC disabled
> 
>  drivers/gpu/drm/msm/Makefile                       |   1 +
>  .../drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h    |   7 +
>  .../drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h    |  11 +
>  .../gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h |  14 +
>  .../gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h |   7 +
>  .../drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h   |  16 +
>  .../gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h |  14 +
>  .../gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h |  14 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |  59 +++-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |  31 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |  36 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c         |  29 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h         |  10 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c         |  14 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h         |  15 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc_1_2.c     | 382 +++++++++++++++++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h        |   3 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c    |   6 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c             |   7 +-
>  19 files changed, 649 insertions(+), 27 deletions(-)
>  create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc_1_2.c
> 
> -- 
> 2.7.4%%
> 
