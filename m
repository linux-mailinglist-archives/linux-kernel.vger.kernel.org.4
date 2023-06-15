Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414ED7318F1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 14:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344190AbjFOM0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 08:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344738AbjFOMZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 08:25:59 -0400
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [IPv6:2001:4b7a:2000:18::166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD242D41
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 05:25:40 -0700 (PDT)
Received: from SoMainline.org (82-72-63-87.cable.dynamic.v4.ziggo.nl [82.72.63.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 4F5AF3FB06;
        Thu, 15 Jun 2023 14:25:37 +0200 (CEST)
Date:   Thu, 15 Jun 2023 14:25:35 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/6] Add DSC v1.2 Support for DSI
Message-ID: <m4q4atgpxgl765ct432bqn6apw5z2hjouplawhckxd6s2sf4y5@nkfz72etdjah>
References: <20230405-add-dsc-support-v6-0-95eab864d1b6@quicinc.com>
 <168682860387.384026.9115594076193676039.b4-ty@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168682860387.384026.9115594076193676039.b4-ty@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-15 14:31:26, Dmitry Baryshkov wrote:
> 
> On Fri, 09 Jun 2023 15:57:12 -0700, Jessica Zhang wrote:
> > This is a series of changes for DSI to enable command mode support
> > for DSC v1.2.
> > 
> > This includes:
> > 
> > 1) Rounding up `hdisplay / 3` in dsc_timing_setup()
> > 2) Adjusting pclk_rate to account for compression
> > 3) Fixing incorrect uses of slice_count in DSI DSC calculations
> > 4) Setting the DATA_COMPRESS bit when DSC is enabled
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/6] msm/drm/dsi: Round up DSC hdisplay calculation
>       https://gitlab.freedesktop.org/lumag/msm/-/commit/21bf617110ba
> [2/6] drm/msm/dsi: Reduce pclk rate for compression
>       https://gitlab.freedesktop.org/lumag/msm/-/commit/7c9e4a554d4a
> [3/6] drm/msm/dpu: Add DPU_INTF_DATA_COMPRESS feature flag for DPU >= 7.0
>       https://gitlab.freedesktop.org/lumag/msm/-/commit/22598cfc94bb
> [4/6] drm/msm/dpu: Set DATA_COMPRESS on command mode for DCE/DSC 1.2
>       https://gitlab.freedesktop.org/lumag/msm/-/commit/1642b5803473
> [5/6] drm/msm/dsi: Remove incorrect references to slice_count
>       https://gitlab.freedesktop.org/lumag/msm/-/commit/155fa3a91d64
> 
> Note, patch 6 is skipped for now

Note that we also haven't finished discussions on where the ratio in
patch 2/6 comes from and how that should be outlined in patch 6.
Related to the widebus patches which affect the ratio as well.

- Marijn
