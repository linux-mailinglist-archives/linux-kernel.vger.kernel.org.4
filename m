Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D99472B423
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 23:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbjFKVUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 17:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjFKVUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 17:20:02 -0400
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [5.144.164.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6991AB
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 14:19:59 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 41E6C1F55F;
        Sun, 11 Jun 2023 23:19:56 +0200 (CEST)
Date:   Sun, 11 Jun 2023 23:19:54 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Jessica Zhang <quic_jesszhan@quicinc.com>,
        freedreno@lists.freedesktop.org, Sean Paul <sean@poorly.run>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        David Airlie <airlied@gmail.com>
Subject: Re: [Freedreno] [PATCH v5 2/5] drm/msm/dsi: Adjust pclk rate for
 compression
Message-ID: <44xp3xrw2fo2pszoxtleurk6rk26nrp2envvxizmosidubnqis@turyqhwmvjxi>
References: <20230405-add-dsc-support-v5-0-028c10850491@quicinc.com>
 <20230405-add-dsc-support-v5-2-028c10850491@quicinc.com>
 <js3mcglahq53mcyxa6deltjlu4xpc2pnafwz2rbk3dl4ovws2o@5xw2wzvfaj2v>
 <f63435ca-933a-52be-d879-1d9cc9441107@quicinc.com>
 <f11fc3c1-4b19-3186-9c56-b1bac221cf83@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f11fc3c1-4b19-3186-9c56-b1bac221cf83@quicinc.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-08 18:09:57, Abhinav Kumar wrote:
<snip>
> >> As discussed before we realized that this change is more-or-less a hack,
> >> since downstream calculates pclk quite differently - at least for
> >> command-mode panels.  Do you still intend to land this patch this way,
> >> or go the proper route by introducing the right math from the get-go?
> >> Or is the math at least correct for video-mode panels?
> > 
> > Sorry but can you please clarify what exactly is incorrect or different 
> > about this math when compared to downstream? And, if you think that this 
> > math is incorrect, what exactly has to be changed to make it the "right 
> > math"?
> > 
> 
> Agree with Jessica, just calling the math a hack without explaining why 
> you think it is so is not justified especially when a great detail of 
> explanation was given on the bug. Sorry but its a bit harsh on the 
> developers.

We discussed this in detail so I'm not quite sure why that suddenly
needs to be reiterated again?

- Marijn
