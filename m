Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09308678505
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 19:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbjAWSfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 13:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbjAWSez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 13:34:55 -0500
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57430BB9E;
        Mon, 23 Jan 2023 10:34:54 -0800 (PST)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id AFD1C4053B;
        Mon, 23 Jan 2023 19:34:51 +0100 (CET)
Date:   Mon, 23 Jan 2023 19:34:49 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, dmitry.baryshkov@linaro.org,
        andersson@kernel.org, quic_abhinavk@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 00/14] add display port DSC feature
Message-ID: <20230123183449.qxjd22z3dpip5rqp@SoMainline.org>
References: <1674498274-6010-1-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1674498274-6010-1-git-send-email-quic_khsieh@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DisplayPort is a name, and I think you should spell it as such in both
the cover letter title and individual patch descriptions (capital D and
P, no space in between).

On 2023-01-23 10:24:20, Kuogee Hsieh wrote:
> This patch add DSC related supporting functions into to both dp controller and dpu enccoder
> 
> Kuogee Hsieh (14):
>   drm/msm/dp: add dpcd read of both dsc and fec capability
>   drm/msm/dp: add dsc factor into calculation of supported bpp
>   drm/msm/dp: add configure mainlink_levels base on lane number
>   drm/msm/dp: correct configure Colorimetry Indicator Field at MISC0
>   drm/msm/dp: upgrade tu calculation base on newest algorithm
>   drm/msm/dp: add display compression related struct
>   drm/msm/dp: add dsc helper functions
>   drm/msm/dp: add dsc supporting functions to DP controller
>   drm/msm/dsi: export struct msm_compression_info to dpu encoder
>   drm/msm/disp/dpu: add supports of DSC encoder v1.2 engine
>   drm/msm/disp/dpu1: add supports of new flush mechanism
>   drm/msm/disp/dpu1: revise timing engine programming to work for DSC
>   drm/msm/disp/dpu1: add dsc supporting functions to dpu encoder
>   drm/msm/disp/dpu1: add sc7280 dsc block and sub block

For DSC, capitalize it everywhere instead of the current free-form lower
and uppercase mixup in patch titles.

Still asking around for the subsystem tag, I've seen:

    drm/msm/dpu
    drm/msm/dpu1
    drm/msm/disp/dpu
    drm/msm/disp/dpu1

And you're already mixing two of them.

Aside that, thanks for sending this series!  Been looking forward to DSC
1.2 for a while, but for DSI!

- Marijn

>  drivers/gpu/drm/msm/Makefile                       |   2 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_dsc_helper.c     | 537 +++++++++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_dsc_helper.h     |  25 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        | 341 +++++++--
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h        |   4 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h   |   7 +-
>  .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c   |  43 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |  50 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |  74 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c         |  43 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h         |  21 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c         |  23 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h         |  23 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc_1_2.c     | 371 +++++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c        | 132 ++--
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h        |  10 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h    |   3 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.h         |   6 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |  10 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c             |  10 +-
>  drivers/gpu/drm/msm/dp/dp_catalog.c                | 176 ++++-
>  drivers/gpu/drm/msm/dp/dp_catalog.h                |  97 ++-
>  drivers/gpu/drm/msm/dp/dp_ctrl.c                   | 839 ++++++++++++++-------
>  drivers/gpu/drm/msm/dp/dp_display.c                |  61 +-
>  drivers/gpu/drm/msm/dp/dp_link.c                   |  29 +-
>  drivers/gpu/drm/msm/dp/dp_panel.c                  | 749 +++++++++++++++++-
>  drivers/gpu/drm/msm/dp/dp_panel.h                  |  67 +-
>  drivers/gpu/drm/msm/dp/dp_reg.h                    |  40 +-
>  drivers/gpu/drm/msm/dsi/dsi.c                      |   3 +-
>  drivers/gpu/drm/msm/dsi/dsi.h                      |   3 +-
>  drivers/gpu/drm/msm/dsi/dsi_host.c                 |  14 +-
>  drivers/gpu/drm/msm/msm_drv.h                      | 113 ++-
>  32 files changed, 3429 insertions(+), 497 deletions(-)
>  create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_dsc_helper.c
>  create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_dsc_helper.h
>  create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc_1_2.c
> 
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
