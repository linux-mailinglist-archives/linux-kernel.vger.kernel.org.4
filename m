Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D976864F1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 12:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjBALBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 06:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbjBALBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 06:01:46 -0500
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [IPv6:2001:4b7a:2000:18::163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3727B49542
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 03:01:40 -0800 (PST)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 6362C200EB;
        Wed,  1 Feb 2023 12:01:37 +0100 (CET)
Date:   Wed, 1 Feb 2023 12:01:36 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Kalyan Thota <quic_kalyant@quicinc.com>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robdclark@chromium.org,
        dianders@chromium.org, swboyd@chromium.org,
        quic_vpolimer@quicinc.com, quic_abhinavk@quicinc.com
Subject: Re: [PATCH 0/3] Reserve dspps based on user request
Message-ID: <20230201110136.xy5xifym624ehthb@SoMainline.org>
References: <1675092092-26412-1-git-send-email-quic_kalyant@quicinc.com>
 <31661b18-8519-cadb-0c56-6a1fa34633b2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31661b18-8519-cadb-0c56-6a1fa34633b2@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-30 21:18:30, Dmitry Baryshkov wrote:
> On 30/01/2023 17:21, Kalyan Thota wrote:
> > This series will enable color features on sc7280 target which has primary panel as eDP
> > 
> > The series removes dspp allocation based on encoder type and allows the dspp reservation
> > based on user request via ctm.
> > 
> > The series will release/reserve the dpu resources when ever there is a topology change
> > to suit the new requirements.
> 
> Nit: the subject of the cover letter should include the version, if you 
> are including one into the individual patches Subject.

Indeed this makes it hard to tell the versions apart, and lore also
confusingly bundles both series in "loose matches on Subject: below".

Nit ^2: and individual patches should still have the PATCH moniker, i.e.
[PATCH v2 1/3].  git format-patch -v2 --cover-letter ... takes care of
/all this/ this for you.

And one more: as DSPP is an abbreviation, can we capitalize it?  So
DSPP / DSPPs in these titles?

> > 
> > Kalyan Thota (3):
> >    drm/msm/disp/dpu1: clear dspp reservations in rm release
> >    drm/msm/disp/dpu1: add dspps into reservation if there is a ctm
> >      request
> >    drm/msm/disp/dpu1: reserve the resources on topology change

We just discussed in the DSC series that the subsystem prefix is
drm/msm/dpu.

- Marijn

> >   drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h    |  1 +
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 54 +++++++++++++++++++++++------
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |  4 ++-
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c     |  2 +-
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c      |  6 ++--
> >   5 files changed, 50 insertions(+), 17 deletions(-)
> > 
> 
> -- 
> With best wishes
> Dmitry
> 
