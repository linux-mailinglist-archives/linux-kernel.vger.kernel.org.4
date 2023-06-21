Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D920D738FB8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 21:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjFUTMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 15:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjFUTMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 15:12:38 -0400
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [5.144.164.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BD61726;
        Wed, 21 Jun 2023 12:12:37 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 1E6B2200E2;
        Wed, 21 Jun 2023 21:12:35 +0200 (CEST)
Date:   Wed, 21 Jun 2023 21:12:33 +0200
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
Subject: Re: [PATCH v4 0/2] retrieve DSI DSC through priv-dsi[0]
Message-ID: <kyu4ho6mf4jkccqxevlcd65aqxz2zwvze24f3qm7cbq4idk6ua@oownvgek6hwp>
References: <1687364298-29430-1-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1687364298-29430-1-git-send-email-quic_khsieh@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-21 09:18:16, Kuogee Hsieh wrote:
> moving retrieving struct drm_dsc_cofnig from setup_display to
> atomic_enable() and delete struct drm_dsc_config from
> struct msm_display_info.

Abhinav suggested to reword this for clarity in v3, but none of that
seems to have made it through?

- Marijn

> Kuogee Hsieh (2):
>   drm/msm/dpu: retrieve DSI DSC struct through priv->dsi[0]
>   drm/msm/dpu: remove struct drm_dsc_config from struct msm_display_info
> 
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 32 +++++++++++++++++++++++------
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |  2 --
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c     |  2 --
>  3 files changed, 26 insertions(+), 10 deletions(-)
> 
> -- 
> 2.7.4
> 
