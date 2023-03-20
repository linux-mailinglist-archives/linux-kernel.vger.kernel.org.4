Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6786C1335
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 14:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjCTNZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 09:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbjCTNZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 09:25:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7475320D1F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 06:25:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FE5D61243
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 13:25:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09307C433D2;
        Mon, 20 Mar 2023 13:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679318730;
        bh=H0NNaSf2aleeUQrTzlbWqjSgmnuWJBP1VUcXFVwmCH8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LtXXIGuY9ZcgE0fMRsBWzHwp5esxJBtG2NJm5yL0jEdyPLvMpeProAjc2tn5Wh6Kf
         hSSzGL9HNuGIcOsv7RV0L7blZA4h12uCJM5qaDF7DHufNbGVhe+cplbKq3vtfuaHR5
         Z3IjDrQnFt9nOgSbn7A4r4cKD3fAeK7vrWuPMNk1+4WdafOwsjmaBX/OXUELOnZ5lJ
         3TYudyQU7+JXfizLt0/6X3DEH7IGRtr5VlMwmS7rYrFIZch1vozsPuYBgWjjY5E9FC
         PYgZLiIgMCj9Y0bWSXkTb6auycZY7oFUqCcPUXZ8nJ2lbOABdubwf/ZFHut/q+bPHv
         pDDWkGGNUX2PQ==
Date:   Mon, 20 Mar 2023 13:25:24 +0000
From:   Lee Jones <lee@kernel.org>
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        dri-devel@lists.freedesktop.org, Leo Li <sunpeng.li@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
        Jasdeep Dhillon <jdhillon@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Mustapha Ghaddar <mghaddar@amd.com>
Subject: Re: [PATCH 28/37] drm/amd/display/dc/core/dc_stat: Convert a couple
 of doc headers to kerneldoc format
Message-ID: <20230320132524.GA2673958@google.com>
References: <20230317081718.2650744-1-lee@kernel.org>
 <20230317081718.2650744-29-lee@kernel.org>
 <CADnq5_O0mQWy5z-SeWryyVeBhhsDX_yrsiuHTUbDBBAscB6b=w@mail.gmail.com>
 <20230320081951.GI9667@google.com>
 <fa3bcadf-3ee9-86d7-d6ad-5408081766bf@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa3bcadf-3ee9-86d7-d6ad-5408081766bf@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Mar 2023, Harry Wentland wrote:

>
>
> On 3/20/23 04:19, Lee Jones wrote:
> > On Fri, 17 Mar 2023, Alex Deucher wrote:
> >
> >> On Fri, Mar 17, 2023 at 4:23 AM Lee Jones <lee@kernel.org> wrote:
> >>>
> >>> Fixes the following W=1 kernel build warning(s):
> >>>
> >>>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stat.c:38: warning: Cannot understand  *****************************************************************************
> >>>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stat.c:76: warning: Cannot understand  *****************************************************************************
> >>>
> >>> Cc: Harry Wentland <harry.wentland@amd.com>
> >>> Cc: Leo Li <sunpeng.li@amd.com>
> >>> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> >>> Cc: Alex Deucher <alexander.deucher@amd.com>
> >>> Cc: "Christian König" <christian.koenig@amd.com>
> >>> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> >>> Cc: David Airlie <airlied@gmail.com>
> >>> Cc: Daniel Vetter <daniel@ffwll.ch>
> >>> Cc: Mustapha Ghaddar <mghaddar@amd.com>
> >>> Cc: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
> >>> Cc: Jasdeep Dhillon <jdhillon@amd.com>
> >>> Cc: amd-gfx@lists.freedesktop.org
> >>> Cc: dri-devel@lists.freedesktop.org
> >>> Signed-off-by: Lee Jones <lee@kernel.org>
> >>> ---
> >>>  drivers/gpu/drm/amd/display/dc/core/dc_stat.c | 28 +++++++------------
> >>>  1 file changed, 10 insertions(+), 18 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stat.c b/drivers/gpu/drm/amd/display/dc/core/dc_stat.c
> >>> index 6c06587dd88c2..5f6392ae31a66 100644
> >>> --- a/drivers/gpu/drm/amd/display/dc/core/dc_stat.c
> >>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_stat.c
> >>> @@ -35,19 +35,15 @@
> >>>   */
> >>>
> >>>  /**
> >>
> >> This looks like it follows some other documentation scheme.  Would
> >> probably be better to just remove the extra * and make it not kernel
> >> doc.  @Wentland, Harry @Siqueira, Rodrigo ?
> >
> > Happy to wait for further input.
> >
> > Either demoting from or converting to kerneldoc would be fine.
> >
>
> There's no reason they are formatted the way they are. Converting them to
> kerneldoc is fine.
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Thanks for confirming Harry.

--
Lee Jones [李琼斯]
