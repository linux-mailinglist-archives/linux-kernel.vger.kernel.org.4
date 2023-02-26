Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3AD86A34BF
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 23:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjBZWeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 17:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjBZWeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 17:34:11 -0500
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [5.144.164.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1580DBDF4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 14:34:09 -0800 (PST)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id DC2B71F898;
        Sun, 26 Feb 2023 23:34:04 +0100 (CET)
Date:   Sun, 26 Feb 2023 23:34:03 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, dmitry.baryshkov@linaro.org,
        andersson@kernel.org, quic_abhinavk@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] add V1.1 dsc_helper fucntion
Message-ID: <20230226223403.itm26leqkdlcm6a3@SoMainline.org>
References: <1677265287-7765-1-git-send-email-quic_khsieh@quicinc.com>
 <51ad9ff8-dbfa-7476-b208-f47e8d54fc20@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51ad9ff8-dbfa-7476-b208-f47e8d54fc20@quicinc.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-24 11:18:51, Kuogee Hsieh wrote:
> Please ignore this series
> 
> I am going to re post it as RFC.

Thank you for this, in particular including me in the CC on the RFC
after being part of the review on your original series.  I'll catch up
to the current discussion and test the new series on a DSC 1.1
device/panel (Sony XZ3 based on SDM845) as soon as possible.

- Marijn

> kuogee
> 
> On 2/24/2023 11:01 AM, Kuogee Hsieh wrote:
> > Add V1.1 dsc function and have dsi use it instead of hardcode value
> >
> > Kuogee Hsieh (2):
> >    drm/msm/dpu: add dsc helper functions
> >    drm/msm/dsi: use new dpu_dsc_populate_dsc_config()
> >
> >   drivers/gpu/drm/msm/Makefile                   |   1 +
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_dsc_helper.c | 209 +++++++++++++++++++++++++
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_dsc_helper.h |  28 ++++
> >   drivers/gpu/drm/msm/dsi/dsi_host.c             |  78 ++-------
> >   drivers/gpu/drm/msm/msm_drv.h                  |   7 +
> >   5 files changed, 257 insertions(+), 66 deletions(-)
> >   create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_dsc_helper.c
> >   create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_dsc_helper.h
> >
