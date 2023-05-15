Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E709703E46
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 22:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245269AbjEOULi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 16:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245246AbjEOUL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 16:11:28 -0400
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [IPv6:2001:4b7a:2000:18::163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240FA11D9B
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 13:11:06 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 1D5C01F9B2;
        Mon, 15 May 2023 22:11:03 +0200 (CEST)
Date:   Mon, 15 May 2023 22:11:01 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org, quic_abhinavk@quicinc.com,
        quic_jesszhan@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 5/8] drm/msm/dpu: add support for DSC encoder v1.2
 engine
Message-ID: <pialfld7v3azuochoynb37wqp3mroewa64c7rhcpnii277te5q@pso5q7dhyfqk>
References: <1683914423-17612-1-git-send-email-quic_khsieh@quicinc.com>
 <1683914423-17612-6-git-send-email-quic_khsieh@quicinc.com>
 <41243dc6-eb9d-dea6-f945-cb1f6594a2a4@linaro.org>
 <w6uswjuf7fiorrplqzhrpg3vrjbbdd3bgaxej5l6ez3pebn3d5@ytuxhim25j6q>
 <1fd8fd48-9a0a-774c-1366-ea4c893f3b25@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fd8fd48-9a0a-774c-1366-ea4c893f3b25@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-15 10:46:48, Kuogee Hsieh wrote:
<snip>
> > Friendly request to strip/snip unneeded context (as done in this reply)
> > to make it easier to spot the conversation, and replies to it.
> >
> > - Marijn
> 
> Thanks for suggestion.
> 
> How can I do that?
> 
> just manually delete unneeded context?
> 
> Or are they other way (tricks) to do it automatically?

Fortunately, no: it is up to you to decide what context is relevant,
which is typically the text (and/or diff snippets) you are replying to.

- Marijn
