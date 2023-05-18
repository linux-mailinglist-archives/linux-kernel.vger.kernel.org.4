Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21593708AA1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 23:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjERVgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 17:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjERVgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 17:36:17 -0400
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [IPv6:2001:4b7a:2000:18::164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DC0A8
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 14:36:14 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 2A2DC203B0;
        Thu, 18 May 2023 23:36:13 +0200 (CEST)
Date:   Thu, 18 May 2023 23:36:11 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, quic_jesszhan@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] drm/msm/dpu: drop DSPP_MSM8998_MASK from hw
 catalog
Message-ID: <dexkdzb3wo3jjveys4i2ujh22fbyti5kugie7nl23s7lv63pky@ryycjghsifva>
References: <20230428223646.23595-1-quic_abhinavk@quicinc.com>
 <20230428223646.23595-4-quic_abhinavk@quicinc.com>
 <kap4lpzbv5qihf2k7fdznmx72hrhpx4acjgcng45kxnshxo6ge@gzke6ruy3x6u>
 <2c688487-a5b1-155c-f73a-69358d03e478@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c688487-a5b1-155c-f73a-69358d03e478@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-19 00:26:33, Dmitry Baryshkov wrote:
> On 18/05/2023 22:41, Marijn Suijten wrote:
> > On 2023-04-28 15:36:46, Abhinav Kumar wrote:
> >> Since GC and IGC masks have now been dropped DSPP_MSM8998_MASK
> >> is same as DSPP_SC7180_MASK. Since DSPP_SC7180_MASK is used more
> > 
> > is *the* same
> 
> And, I think, a comma is missing before DSPP_MSM8998_MASK.

Possible, but not needed I think; both would work.

> Note: since the English language is not native for most of the 
> developers, I usually don't nitpick on these issues provided we can 
> understand the message without too much trouble (and the mistake doesn't 
> stand out aloud, begging for it to be fixed).

I hope you don't mind me pointing them out when they make the reader go
"huh, a word is missing here", breaking my sentence-parser.

- Marijn

> I will fix missing articles when applying, if I don't forget.

<snip>
