Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0FB6701FFE
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 23:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjENVqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 17:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjENVqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 17:46:37 -0400
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [IPv6:2001:4b7a:2000:18::167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2074710CE;
        Sun, 14 May 2023 14:46:36 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id BD73E3F295;
        Sun, 14 May 2023 23:46:33 +0200 (CEST)
Date:   Sun, 14 May 2023 23:46:32 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org, quic_abhinavk@quicinc.com,
        quic_jesszhan@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 5/8] drm/msm/dpu: add support for DSC encoder v1.2
 engine
Message-ID: <w6uswjuf7fiorrplqzhrpg3vrjbbdd3bgaxej5l6ez3pebn3d5@ytuxhim25j6q>
References: <1683914423-17612-1-git-send-email-quic_khsieh@quicinc.com>
 <1683914423-17612-6-git-send-email-quic_khsieh@quicinc.com>
 <41243dc6-eb9d-dea6-f945-cb1f6594a2a4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41243dc6-eb9d-dea6-f945-cb1f6594a2a4@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-12 21:19:19, Dmitry Baryshkov wrote:
<snip.
> > +static inline void dpu_hw_dsc_bind_pingpong_blk_1_2(struct dpu_hw_dsc *hw_dsc,
> > +						    const enum dpu_pingpong pp)
> > +{
> > +	struct dpu_hw_blk_reg_map *hw;
> > +	const struct dpu_dsc_sub_blks *sblk;
> > +	int mux_cfg = 0xf; /* Disabled */
> > +
> > +	hw = &hw_dsc->hw;
> > +
> > +	sblk = hw_dsc->caps->sblk;
> > +
> > +	if (pp)
> > +		mux_cfg = (pp - PINGPONG_0) & 0x7;
> 
> Do we need an unbind support here like we do for the DSC 1.1?
> 
> > +
> > +	DPU_REG_WRITE(hw, sblk->ctl.base + DSC_CTL, mux_cfg);
> > +}

<snip>

Friendly request to strip/snip unneeded context (as done in this reply)
to make it easier to spot the conversation, and replies to it.

- Marijn
