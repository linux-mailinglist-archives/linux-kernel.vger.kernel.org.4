Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F024873E209
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 16:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbjFZOYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 10:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjFZOXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 10:23:46 -0400
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [IPv6:2001:4b7a:2000:18::168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C7A170D;
        Mon, 26 Jun 2023 07:23:05 -0700 (PDT)
Received: from SoMainline.org (82-72-63-87.cable.dynamic.v4.ziggo.nl [82.72.63.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id A80873F7B3;
        Mon, 26 Jun 2023 16:17:44 +0200 (CEST)
Date:   Mon, 26 Jun 2023 16:17:42 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, Lux Aliaga <they@mint.lgbt>
Subject: Re: [PATCH 00/15] drm/msm: Add SM6125 MDSS/DPU hardware and enable
 Sony Xperia 10 II panel
Message-ID: <jllpsyveqvxco3ihclqypwnfhac2g3gdm6ukd3x3fjsr6z54xy@2xwh5fixpprh>
References: <20230624-sm6125-dpu-v1-0-1d5a638cebf2@somainline.org>
 <035ffdd2-27e3-99bc-f8a4-41e66685db09@linaro.org>
 <i5xxzhfhlwzoxlnezzgg42hzwzwfcgxv5gopqhb6vd3udz252b@wpznuvoleeta>
 <701916b3-388e-8216-f7ae-1837d5895d87@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <701916b3-388e-8216-f7ae-1837d5895d87@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-26 11:41:39, Konrad Dybcio wrote:
> On 25.06.2023 21:18, Marijn Suijten wrote:
> > On 2023-06-24 03:42:46, Konrad Dybcio wrote:
> >> On 24.06.2023 02:40, Marijn Suijten wrote:
> >>> Bring up the SM6125 DPU now that all preliminary series (such as INTF
> >>> TE) have been merged (for me to test the hardware properly)
> >> We should not repeat the same mistake in the future.. Finding a
> >> balance between releasing early and releasing what we can declare
> >> working and tested code is hard, but we waaaaaaaay overstayed on
> >> this one..
> > 
> > I don't understand what you mean by "mistake" at all.  Yes the DPU
> > catalog portion of this series sat in my local branch for a very long
> > time.  Yes it had to be rebased on top of conflicts many many times.
> > 
> > However, that time has also been used to fix and extend DPU where
> > necessary, instead of submitting a half-broken or half-incomplete
> > catalog entry...
> > 
> > Re "we overstayed": you could have asked to clean up and send my patch,
> > so I don't take this as a mistake on my part as you are completely aware
> > of my time schedule ;)
> I didn't mean to pick on you. I just wanted to emphasize that a more
> upstream-forward approach would have saved us quite some time on the
> rebasing and cleaning-up front.

That is how it comes across ;) - our dream is all about upstream-first
but as you know this becomes a mess really quickly when things are
blocked on dependencies and you're working on 5 different features and
testing across ±8 different Sony platforms on ±14 different devices at
once... all in a limited portion of free time.

Fwiw cleaning-up would have had to happen either way, and would have
taken the same amount of time regardless of whether this series is
submitted now or two months ago.

> >> Konrad
> >> , and most
> > 
> > Also here, don't forget to re-quote my message if you break half-way in
> > the line.
> Ugh. All the time I've been doing this I thought thunderfox was smart
> enough to do it for me. Apparently not and you're the 1st one to point
> that out.

You're welcome!
(Though I thought it should be visible in Thunderburd, unless you're not
 in plaintext mode?  Does it still show the "this is quoted" line in
 front of the broken sentence?)

 - Marijn
