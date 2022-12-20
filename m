Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2A265291E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 23:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbiLTWfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 17:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiLTWfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 17:35:41 -0500
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [IPv6:2001:4b7a:2000:18::165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E780246
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 14:35:39 -0800 (PST)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 27C982020A;
        Tue, 20 Dec 2022 23:35:37 +0100 (CET)
Date:   Tue, 20 Dec 2022 23:35:35 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     phone-devel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Jani Nikula <jani.nikula@intel.com>,
        sunliming <sunliming@kylinos.cn>,
        Sam Ravnborg <sam@ravnborg.org>,
        Haowen Bai <baihaowen@meizu.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/6] drm/msm: DSC Electric Boogaloo for sm8[12]50
Message-ID: <20221220223535.gzjkr4rsflrujl4o@SoMainline.org>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        phone-devel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Jani Nikula <jani.nikula@intel.com>,
        sunliming <sunliming@kylinos.cn>, Sam Ravnborg <sam@ravnborg.org>,
        Haowen Bai <baihaowen@meizu.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20221213232207.113607-1-marijn.suijten@somainline.org>
 <154b2e08-25a0-c8b7-1dc8-2d41b8787f05@linaro.org>
 <20221214192322.vs4tvhlzjc265bva@SoMainline.org>
 <560508a2-9ff5-16b5-ac50-efe9a2afbddb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <560508a2-9ff5-16b5-ac50-efe9a2afbddb@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-15 02:52:01, Dmitry Baryshkov wrote:
> On 14/12/2022 21:23, Marijn Suijten wrote:
> > On 2022-12-14 20:40:06, Dmitry Baryshkov wrote:
> >> On 14/12/2022 01:22, Marijn Suijten wrote:
> >>> This preliminary Display Stream Compression support package for
> >>> (initially tested on) sm8[12]50 is based on comparing DSC behaviour
> >>> between downstream and mainline.  Some new callbacks are added (for
> >>> binding blocks on active CTLs), logic bugs are corrected, zeroed struct
> >>> members are now assigned proper values, and RM allocation and hw block
> >>> retrieval now hand out (or not) DSC blocks without causing null-pointer
> >>> dereferences.
> >>>
> >>> Unfortunately it is not yet enough to get rid of completely corrupted
> >>> display output on the boards I tested here:
> >>> - Sony Xperia 1 (sm8150), 1644x3840 or 1096x2560 pixels;
> >>> - Sony Xperia 5II (sm8250), 1080x2520, at 60 or 120Hz;
> >>> - (can include more Xperia boards if desired)
> >>>
> >>> Both devices use the DUALPIPE_DSCMERGE topology downstream: dual LM, PP
> >>> and DSC, but only a single INTF/encoder/DSI-link.
> >>>
> >>> Hopefully this spawns some community/upstream interest to help rootcause
> >>> our corruption issues (after we open a drm/msm report on GitLab for more
> >>> appropriate tracking).
> >>>
> >>> The Sony Xperia XZ3 (sdm845) was fully tested and validated with this
> >>> series to not cause any regressions (an one of the math fixes now allows
> >>> us to change slice_count in the panel driver, which would corrupt
> >>> previously).
> >>>
> >>> Marijn Suijten (6):
> >>>     drm/msm/dpu1: Implement DSC binding to PP block for CTL V1
> >>>     drm/msm/dpu1: Add DSC config for sm8150 and sm8250
> >>>     drm/msm/dpu1: Wire up DSC mask for active CTL configuration
> >>>     drm/msm/dsi: Use DSC slice(s) packet size to compute word count
> >>>     drm/msm/dsi: Flip greater-than check for slice_count and
> >>>       slice_per_intf
> >>>     drm/msm/dpu: Disallow unallocated (DSC) resources to be returned
> >>
> >> General comment: patches with Fixes ideally should come first. Usually
> >> they are picked into -fixes and/or stable kernels. If the Fixes patches
> >> are in the middle of the series, one can not be sure that they do not
> >> have dependencies on previous patches. If there is one, it should
> >> probably be stated clearly to ease work on backporting them.
> > 
> > Ack, I may have rushed these RFC patches straight off my branches onto
> > the lists in hopes of sparking some suggestions on what may still be
> > broken or missing to get DSC working on sm[12]50, but will keep this in
> > mind for v2 after receiving some more review.
> > 
> > That said, any suggestions?
> 
> 
>  From what I've noticed lately:

Apologies for the late reply, I wanted to double-check this but now
ended up basing my

> - set dsc_version_major/dsc_version_minor

We always set these in our panel drivers (all the way from back when our
initial panel driver changes were based on what Vinod did for Pixel 3),
both to 1.  As expected this results in 0x11 in the first byte of the
Pixel Parameter Set sent to the DrIC over DSI.

> - try using dsc params from 1.2 rater than 1.1 version spec (there is 
> small difference there)

Didn't have any effect and this is not what downstream sets/sends
regardless, all our panels (on these sm8[12]50 SoCs) are hardcoded to
DSC 1.1 downstream.

Should I test this again, but also setting the version in the
compression_mode command?

- Marijn
