Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974EE6C0C0F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 09:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjCTIUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 04:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjCTIUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 04:20:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE47549E3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 01:19:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56F0961276
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 08:19:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235EEC4339B;
        Mon, 20 Mar 2023 08:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679300397;
        bh=QpAVKqeubJthGIFfzcG7IrxW0rOZ+Vhr+iwkoRDofsw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FFZN1EqsUQoijVrA3D5Fx3IRVmy5UZQwaNQowjxlcI1PUvmO+q1l3PCO0OrEwHHJ9
         4y0X+YN50WzeAzMy5I6pO0s+0uzu8fDTns8Ub//f8u1eJT0NB+aGVr2AxT1uMw2+pH
         oQVR56yeDBULokyYbs7J9ZgvFmYQMcY7Z5RJkXFBM2v7B0Xh9XEYwRM3lTqvOnXARD
         Y6BG2OV6blc4Aj9wH7BgFQg1LPIdG5+lVQmiJ3F8WLjrrWWTNU9DUAa1KoMw17uzEn
         d76VrlM04pUdTq8OBGXKbELJ1IzMDYG2dBZlp9naz/A1WCvyCzBUF6bvIrFplI7w2T
         rg2BdxYDGt8zQ==
Date:   Mon, 20 Mar 2023 08:19:51 +0000
From:   Lee Jones <lee@kernel.org>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     "Wentland, Harry" <Harry.Wentland@amd.com>,
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
Message-ID: <20230320081951.GI9667@google.com>
References: <20230317081718.2650744-1-lee@kernel.org>
 <20230317081718.2650744-29-lee@kernel.org>
 <CADnq5_O0mQWy5z-SeWryyVeBhhsDX_yrsiuHTUbDBBAscB6b=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_O0mQWy5z-SeWryyVeBhhsDX_yrsiuHTUbDBBAscB6b=w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Mar 2023, Alex Deucher wrote:

> On Fri, Mar 17, 2023 at 4:23 AM Lee Jones <lee@kernel.org> wrote:
> >
> > Fixes the following W=1 kernel build warning(s):
> >
> >  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stat.c:38: warning: Cannot understand  *****************************************************************************
> >  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stat.c:76: warning: Cannot understand  *****************************************************************************
> >
> > Cc: Harry Wentland <harry.wentland@amd.com>
> > Cc: Leo Li <sunpeng.li@amd.com>
> > Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: "Christian König" <christian.koenig@amd.com>
> > Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Mustapha Ghaddar <mghaddar@amd.com>
> > Cc: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
> > Cc: Jasdeep Dhillon <jdhillon@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: Lee Jones <lee@kernel.org>
> > ---
> >  drivers/gpu/drm/amd/display/dc/core/dc_stat.c | 28 +++++++------------
> >  1 file changed, 10 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stat.c b/drivers/gpu/drm/amd/display/dc/core/dc_stat.c
> > index 6c06587dd88c2..5f6392ae31a66 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc_stat.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc_stat.c
> > @@ -35,19 +35,15 @@
> >   */
> >
> >  /**
>
> This looks like it follows some other documentation scheme.  Would
> probably be better to just remove the extra * and make it not kernel
> doc.  @Wentland, Harry @Siqueira, Rodrigo ?

Happy to wait for further input.

Either demoting from or converting to kerneldoc would be fine.

> > - *****************************************************************************
> > - *  Function: dc_stat_get_dmub_notification
> > + *  dc_stat_get_dmub_notification
> >   *
> > - *  @brief
> > - *             Calls dmub layer to retrieve dmub notification
> > + * Calls dmub layer to retrieve dmub notification
> >   *
> > - *  @param
> > - *             [in] dc: dc structure
> > - *             [in] notify: dmub notification structure
> > + * @dc: dc structure
> > + * @notify: dmub notification structure
> >   *
> > - *  @return
> > + * Returns
> >   *     None
> > - *****************************************************************************
> >   */
> >  void dc_stat_get_dmub_notification(const struct dc *dc, struct dmub_notification *notify)
> >  {
> > @@ -73,19 +69,15 @@ void dc_stat_get_dmub_notification(const struct dc *dc, struct dmub_notification
> >  }
> >
> >  /**
> > - *****************************************************************************
> > - *  Function: dc_stat_get_dmub_dataout
> > + * dc_stat_get_dmub_dataout
> >   *
> > - *  @brief
> > - *             Calls dmub layer to retrieve dmub gpint dataout
> > + * Calls dmub layer to retrieve dmub gpint dataout
> >   *
> > - *  @param
> > - *             [in] dc: dc structure
> > - *             [in] dataout: dmub gpint dataout
> > + * @dc: dc structure
> > + * @dataout: dmub gpint dataout
> >   *
> > - *  @return
> > + * Returns
> >   *     None
> > - *****************************************************************************
> >   */
> >  void dc_stat_get_dmub_dataout(const struct dc *dc, uint32_t *dataout)
> >  {
> > --
> > 2.40.0.rc1.284.g88254d51c5-goog
> >

--
Lee Jones [李琼斯]
