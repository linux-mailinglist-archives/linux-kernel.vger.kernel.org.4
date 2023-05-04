Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977046F7847
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 23:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjEDVjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 17:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjEDVjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 17:39:47 -0400
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [5.144.164.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA1A13869
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 14:39:45 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 935F3212FE;
        Thu,  4 May 2023 23:39:43 +0200 (CEST)
Date:   Thu, 4 May 2023 23:39:42 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/7] drm/msm/dpu: add DPU_PINGPONG_DSC bits into
 PP_BLK and PP_BLK_TE marcos
Message-ID: <55aa25pdeaqbuc2x2v3xkmcatlzmn2c5pn2py5qnqz7bnrp6s4@3vkwwnn4uasi>
References: <1683218805-23419-1-git-send-email-quic_khsieh@quicinc.com>
 <1683218805-23419-4-git-send-email-quic_khsieh@quicinc.com>
 <ljt5mp4ew5lcrrrdd7xyof3jv3friafbmr3im35ddwxjc42ekh@toez7xfdreg2>
 <CAA8EJpreM9i3DUp+93K7p14f_tNMy-m+C-WdyN5_drmmkGV66g@mail.gmail.com>
 <u7hlzltevx675gfg4w6emmeceo6nj76taqeecsor6iqsi3hmki@lg43y65m6chz>
 <11ef769a-5089-57d4-db87-4c5766d98206@quicinc.com>
 <6qg25ffuq6xcfz3vuqm5lguspihjospctjclxmwyu2ifau4p7b@txywjmir7lg5>
 <9011a078-9962-b3de-6427-b9114fcd0cf4@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9011a078-9962-b3de-6427-b9114fcd0cf4@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-04 12:50:57, Abhinav Kumar wrote:
> 
> 
> On 5/4/2023 12:36 PM, Marijn Suijten wrote:
> > On 2023-05-04 11:25:44, Abhinav Kumar wrote:
> > <snip>
> >>> Sure, if you really prefer a split I'd go for two patches:
> >>> 1. Add the flag to the enum and catalog;
> >>> 2. Add the ops guard (functional change).
> >>>
> >>> Then don't forget to reword the commit message, following the guidelines
> >>> below and the suggestion for 2/7.
> >>>
> >>> - Marijn
> >>
> >> Plan sounds good to me.
> >>
> >> Marijn, we will wait for a couple of days to post the next rev but would
> >> be hard more than that as we need to pick up other things which are
> >> pending on top of this. Hence would appreciate if you can finish reviews
> >> by then.
> > 
> > It depends on how many more revisions are needed after that, and not all
> > patches in this series have an r-b just yet.  Given the amount of review
> > comments that are still trickling in (also on patches that already have
> > maintainer r-b) I don't think we're quite there to start thinging about
> > picking this up in drm-msm just yet.  I doubt anyone wants a repeat of
> > the original DSC series, which went through many review rounds yet still
> > required multiple series of bugfixes (some of which were pointed out and
> > ignored in review) to be brought to a working state.  But the split
> > across topics per series already makes this a lot less likely, many
> > thanks for that.
> > 
> 
> I think the outstanding comments shouldnt last more than 1-2 revs more 
> on this one as its mostly due to multiple patches on the list touching 
> catalog at the same time. I have been monitoring the comments closely 
> even though I dont respond to all of them.
> 
> One of the major reasons of the number of issues with DSC 1.1 was QC 
> didn't really have the devices or panels to support it. Thats why I 
> changed that this time around to take more control of validation of DSC 
> 1.2 and ofcourse decided to break up of series into the least amount of 
> functionality needed to keep the DPU driver intact.

Really glad that you are able to test and validate it now, that goes a
long way.  Does that also mean you can post the panel patches quickly,
so that everyone has a point of reference?  As you said that is one of
the main points where DSC 1.1 "went wrong" (a misunderstanding of
drm_dsc_config).

> All that being said, we still value your comments and would gladly wait 
> for a couple of days like I already wrote. But there are more 
> incremental series on top of this:
> 
> -> DSI changes for DSC 1.2
> -> proper teardown for DSC
> -> DSC pair allocation support
> -> DSC 1.2 over DP

Yeah, I'm familiar with the concept of having many dependent series, and
now DSC series are even rebasing on DPU (catalog) cleanups to preempt
conflicts, which is really hard to follow.
Dmitry just pushed v5 of "drm/i915/dsc: change DSC param tables to
follow the DSC model" [1] and seems to have dropped some patches that
some of these series are depending on, resulting in compilation
failures.  Other series don't seem to fully mention all their
dependencies.

[1]: https://lore.kernel.org/linux-arm-msm/20230504153511.4007320-1-dmitry.baryshkov@linaro.org/T/#u

So, for this to go as convenient as possible, do you have a list of
series, in a desired order that they should be reviewed and tested?
That way I can direct my priorities and help achieve the goal of picking
base dependencies as early as possible.

For example, one of the many series regresses DSC on the Xperia XZ3
(SDM845), but I have yet to bisect and understand which patch it is.
Will let you know as soon as I get my tree in order.

- Marijn
