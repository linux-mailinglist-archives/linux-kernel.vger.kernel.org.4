Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA41870CBB1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 22:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbjEVU4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 16:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbjEVU4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 16:56:00 -0400
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [IPv6:2001:4b7a:2000:18::167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D8CFA
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 13:55:54 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 0ED253EED9;
        Mon, 22 May 2023 22:55:53 +0200 (CEST)
Date:   Mon, 22 May 2023 22:55:51 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Jessica Zhang <quic_jesszhan@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/5] msm/drm/dsi: Round up DSC hdisplay calculation
Message-ID: <gdh5p33gkoqccyrp6ljpnfmzbartpzptins7vowe5bphpcac2y@4ngkfujtp3dy>
References: <20230405-add-dsc-support-v4-0-15daf84f8dcb@quicinc.com>
 <20230405-add-dsc-support-v4-1-15daf84f8dcb@quicinc.com>
 <eo7chb7m4cowvb53hnebi3bjtotm7x5ea5iv6ulmmfkr2hdt32@2nkoa5rco3qb>
 <ecf22436-44f3-8809-1232-e9ae30f3864b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecf22436-44f3-8809-1232-e9ae30f3864b@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-22 22:52:40, Konrad Dybcio wrote:
> 
> 
> On 22.05.2023 22:44, Marijn Suijten wrote:
> > On 2023-05-22 13:30:20, Jessica Zhang wrote:
> >> Currently, when compression is enabled, hdisplay is reduced via integer
> >> division. This causes issues for modes where the original hdisplay is
> >> not a multiple of 3.
> >>
> >> To fix this, use DIV_ROUND_UP to divide hdisplay.
> >>
> >> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
> >> Suggested-by: Marijn Suijten <marijn.suijten@somainline.org>
> > 
> > Nit: probably these should go in the opposite order.  And if they're
> > all supposed to be chronological, I think it is:
> > 
> >     Suggested-by:
> >     Fixes:
> >     Signed-off-by:
> >     Reviewed-by:
> > 
> > But unsure if that's a hard requirement, or even correct at all.
> > 
> > - Marijn
> Or you can rely on b4 to pick that up if it comes from others

The problem is that somewhat stupidly, b4 (trailers -u) puts them in the
wrong (not chronological) order, so it's pretty much useless for this.

Unless there's a required ordering specified somewhere in the docs, that
is *not* chronological, and that b4 is abiding by?  (that is my question
above)

- Marijn

> 
> Konrad
<snip>
