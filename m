Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4509B681B31
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 21:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjA3URE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 15:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjA3URC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 15:17:02 -0500
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [5.144.164.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9476B34016
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 12:17:00 -0800 (PST)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 1546A1F6D9;
        Mon, 30 Jan 2023 21:16:56 +0100 (CET)
Date:   Mon, 30 Jan 2023 21:16:54 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, dmitry.baryshkov@linaro.org,
        andersson@kernel.org, quic_abhinavk@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 10/14] drm/msm/disp/dpu: add supports of DSC encoder
 v1.2 engine
Message-ID: <20230130201654.vlr7p7id3a7vxc2b@SoMainline.org>
References: <1674498274-6010-1-git-send-email-quic_khsieh@quicinc.com>
 <1674498274-6010-11-git-send-email-quic_khsieh@quicinc.com>
 <20230123201133.zzt2zbyaw3pfkzi6@SoMainline.org>
 <926021c1-d9d1-4449-f01b-f405b48f326a@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <926021c1-d9d1-4449-f01b-f405b48f326a@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-24 15:52:46, Kuogee Hsieh wrote:

<snip>

If only replying to a small chunk somewhere in the middle of a diff
and/or large review, please cut out unnecessary bits to make your reply
easier to find :)

> >> +	data = (dsc->flatness_min_qp & 0x1f);
> >> +	data |= (dsc->flatness_max_qp & 0x1f) << 5;
> >> +	data |= (dsc_info->det_thresh_flatness & 0xff) << 10;
> > dpu_hw_dsc.c computes this on the fly.  After removing that, and
> > using initial_lines from the function parameters, only
> > dsc_info->num_active_ss_per_enc remains.  Do you really need that
> > msm_display_dsc_info struct here, do you need it at all?
> 
> I ported these code from our down stream code base.
> 
> I make it work first, then clean it up will follow.
> 
> I submit it for review since it looks like you guy like to have code sooner.

Correct, I was looking forward to these patches albeit complete with the
promised DSI support from Jessica, which still seems to be pending.

When sending patches to that extent, with the intent of getting quick
turnaround but knowing that they are not ready for prime time yet (or
were they, based on your "submit it for review" mention? Don't you mean
testing?), please annotate the series with an RFC tag accompanied with a
description what still needs to be done and why.  That would have saved
a great deal of comments and review.

> yes, eliminate msm_display_dsc_info is my next target and hope it can be 
> done.

Thank you.  Again, if that was the intent from the get-go, that's
perfect material to put in an RFC series' cover letter.

- Marijn
