Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3746E511C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 21:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjDQTlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 15:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjDQTlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 15:41:19 -0400
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [IPv6:2001:4b7a:2000:18::164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996482135
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 12:41:13 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 7B9701F637;
        Mon, 17 Apr 2023 21:41:09 +0200 (CEST)
Date:   Mon, 17 Apr 2023 21:41:07 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        phone-devel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <swboyd@chromium.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Adam Skladowski <a39.skl@gmail.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 5/7] drm/msm/dpu: Document and enable TEAR interrupts
 on DSI interfaces
Message-ID: <5tjwn4p3nkpjuczudipkrvhy63kfzos6x7o7aufwdei7auujcz@oba37opujh5r>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>, 
        Abhinav Kumar <quic_abhinavk@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
        Jessica Zhang <quic_jesszhan@quicinc.com>, phone-devel@vger.kernel.org, 
        Neil Armstrong <neil.armstrong@linaro.org>, ~postmarketos/upstreaming@lists.sr.ht, 
        AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
        Martin Botka <martin.botka@somainline.org>, Jami Kettunen <jami.kettunen@somainline.org>, 
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>, 
        Daniel Vetter <daniel@ffwll.ch>, Stephen Boyd <swboyd@chromium.org>, 
        Vinod Koul <vkoul@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
        Kuogee Hsieh <quic_khsieh@quicinc.com>, Konrad Dybcio <konrad.dybcio@somainline.org>, 
        Loic Poulain <loic.poulain@linaro.org>, Vinod Polimera <quic_vpolimer@quicinc.com>, 
        Adam Skladowski <a39.skl@gmail.com>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20221231215006.211860-1-marijn.suijten@somainline.org>
 <20221231215006.211860-6-marijn.suijten@somainline.org>
 <773cd72b-a766-1764-e25f-0af1174f0e51@quicinc.com>
 <1051d6bd-eb3c-6293-0bd2-3f4ea28fa3f8@linaro.org>
 <df059f88-6ff6-5906-58f1-4f6c752c4214@quicinc.com>
 <20230214130636.ldckqgcq6ajph372@SoMainline.org>
 <d514591a-2891-8c2d-2cd4-5af8283748f5@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d514591a-2891-8c2d-2cd4-5af8283748f5@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-14 09:54:57, Abhinav Kumar wrote:
[..]
> >>>> Just wondering, how were the lengths calculated for the INTF blocks?
> >>>> The values in general seem a little off to me.
> > 
> > These (for MSM8998) have been taken from downstream specifically; my
> > series starts using INTF_STATUS at 0x26C which conveniently is the
> > register right after 0x268, matching the fact that INTF TE and these
> > registers weren't supported/available yet on MSM8998.
> > 
> >>>> For example, I'm looking downstream and it seems to me that the length
> >>>> for the INTF_0 on MSM8998 should be 0x280. Similarly for SC7280, I'm
> >>>> seeing that length for INTF + tearcheck should be 0x2c4.
> > 
> > There are many different downstream sources and tags with seemingly
> > conflicting/confusing information.  For v2 [2] I've picked the highest
> > register used by the driver which is INTF_TEAR_AUTOREFRESH_CONFIG at
> > 0x2B4 (but there might always be more registers that don't need to be
> > poked at by the driver, but contain magic debug information and the
> > like... those would be useful to capture in the dump going forward).
> > 
> > [2]: https://github.com/SoMainline/linux/commit/2bbc609dd28aa0bd0a2dede20163e521912d0072
> > 
> 
> Not entirely correct.TEAR_AUTOREFRESH_STATUS is at 0x2c0 for sm8350 and 
> sm8450 as well so 0x2b4 is a bit short. DPU code uses autorefresh status 
> today.Esp after your changes it will use the autorefresh status from 
> intf te which is at offset 0x2c0

Revisiting this, I don't see current DPU code nor downstream 5.4 / 5.10
SDE techpack on some of my checkouts use this register, only
INTF_TEAR_AUTOREFRESH_CONFIG at 0x2b4..0x2b7.  Am I missing something
critical here?

> >>> We have discussed INTF lengths in [1]. The current understanding of the
> >>> block lengths can be found at [2]. Please comment there if any of the
> >>> fixed lengths sounds incorrect to you.
> >>>
> >>> [1] https://patchwork.freedesktop.org/patch/522187/
> >>> [2] https://patchwork.freedesktop.org/patch/522227/
> >>>
> >>> [skipped the rest]
> >>>
> >>
> >> Please correct my understanding here, it was agreed to fix intf blocks
> >> to 0x2c4 here https://patchwork.freedesktop.org/patch/522227/ but I dont
> >> see this was merged?
> >>
> >> It was agreed to first land INTF_TE and then add the higher addresses
> > 
> > Seems like it, at least if I interpret [3] correctly.  My series adds a
> > new define that will hardcode _len to 0x2B8 for now, and Dmitry/Konrad
> > can later extend it to whatever is stated by the correct downstream
> > source.
> > 
> 
> Like mentioned above it should be 0x2c0 for intf block.
> 
> If you face any conflicting information in downstream code, you can 
> always check with me on IRC.

Ack, it looks like others landed these changes for me now via the
catalog rework, so I have just rebased and kept the lengths in.

- Marijn
