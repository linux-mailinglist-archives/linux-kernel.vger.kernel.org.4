Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC0462E897
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 23:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240074AbiKQWlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 17:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbiKQWlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 17:41:18 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D838DA51
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 14:41:17 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id n186so3512670oih.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 14:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=csDjA7Lmaoy5t254PbIdwoXPbMVcPqUkx2VOtdueRJA=;
        b=WcCYDu+PsGUNad1cIgVVLDXXKK+7SMRon35QDWLYdzHMC2Nfe+AJjlPyeQ+mTu9p2M
         lnKp7TE209DHIBwCFIwt13H+B1gwnE1I0xbUsPntNC8IsWiqDD38owDU1nhRRAZpyBwm
         SGDeAQTKLvoCYiUoaCCUxckQCxRFp0KH1FV3cKhOpYZum13wN3Iu0WOuavrbQJtQF/oi
         7j9uJvvZnZZRt6uur28wzC7JOs9XzeHpBLrm2bhuoorZiEOW4yVDFK1d476Yi1NFe+rG
         VJVvrFemSmwvxuLJtWUO7wb2U58Y8ysRNo2iTDRkkZHHb417wB7LhB+tsf5/d+r+KnsI
         zwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=csDjA7Lmaoy5t254PbIdwoXPbMVcPqUkx2VOtdueRJA=;
        b=Nkure9tcL59balXSe2z8msk9xjhWpcq+JY1QOUG5OEO/E4FMCKfk7PBrndbeX7y3ya
         jEUEXScAIllQj1k7cgSVcXP09Ae/yWngjQ4bKZAdZZbZEI8ygKENThdOcKfys4h+NSy6
         hO5tgLTkXQ7lNTqBsQJ/iQWkWQYlzE4RMgyL6lPnhE/zTM/COFiZyub7ZUu4lMB72x0f
         QZ4ANpZ5NhttQPPd9CYCTnYR6PKaJMkUSkpI3TUrx+HBM+leePE/gNWRQntWrBVxKCEm
         MYZlpZG3a0NJyjlgg4Pu0f+CJFlgN+fwOMuYznLzAeMdXGMK9+TAtINTilmvi8XFB/DZ
         Jhkw==
X-Gm-Message-State: ANoB5pkV/SAGLhSoUWfEk7fVZhiSDFPmpwGPFmefmAR15OXxuAlaZugP
        paZyOAP5EsifRg6pXa5OTEV0KKhatIDzwWLJZFM=
X-Google-Smtp-Source: AA0mqf5J6WVBYllKAiTJyVqHtz6V+lyUbEN/ZA10bz48P3xq84tSQvKqSf2PuVmJs4C/a56qA04o7ofJp3BIpIYXmV4=
X-Received: by 2002:a05:6808:9b8:b0:34f:97ea:14d with SMTP id
 e24-20020a05680809b800b0034f97ea014dmr2306901oig.96.1668724876652; Thu, 17
 Nov 2022 14:41:16 -0800 (PST)
MIME-Version: 1.0
References: <20221117172009.28207-1-rdunlap@infradead.org> <28960f0b-97b9-7a41-9da3-188be25dd886@amd.com>
In-Reply-To: <28960f0b-97b9-7a41-9da3-188be25dd886@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 17 Nov 2022 17:41:04 -0500
Message-ID: <CADnq5_P5SLbamNkRYOhjvicnyHzKaBp8=V5g8hNtyz+TD5-UZA@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/display: fix kernel-doc issues in dc.h
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Thu, Nov 17, 2022 at 2:39 PM Harry Wentland <harry.wentland@amd.com> wrote:
>
>
>
> On 11/17/22 12:20, Randy Dunlap wrote:
> > Fix these kernel-doc complaints:
> >
> > drivers/gpu/drm/amd/display/dc/dc.h:505: warning: cannot understand function prototype: 'struct dc_clocks '
> > dc.h:472: warning: Enum value 'MPC_SPLIT_AVOID' not described in enum 'pipe_split_policy'
> > dc.h:472: warning: Enum value 'MPC_SPLIT_AVOID_MULT_DISP' not described in enum 'pipe_split_policy'
> > dc.h:532: warning: Incorrect use of kernel-doc format:          * @fw_based_mclk_switching
> >
> > Fixes: ea76895ffab1 ("drm/amd/display: Document pipe split policy")
> > Fixes: 1682bd1a6b5f ("drm/amd/display: Expand kernel doc for DC")
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Harry Wentland <harry.wentland@amd.com>
> > Cc: Leo Li <sunpeng.li@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: dri-devel@lists.freedesktop.org
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >  drivers/gpu/drm/amd/display/dc/dc.h |   12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff -- a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
> > --- a/drivers/gpu/drm/amd/display/dc/dc.h
> > +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> > @@ -458,15 +458,15 @@ enum pipe_split_policy {
> >       MPC_SPLIT_DYNAMIC = 0,
> >
> >       /**
> > -      * @MPC_SPLIT_DYNAMIC: Avoid pipe split, which means that DC will not
> > +      * @MPC_SPLIT_AVOID: Avoid pipe split, which means that DC will not
> >        * try any sort of split optimization.
> >        */
> >       MPC_SPLIT_AVOID = 1,
> >
> >       /**
> > -      * @MPC_SPLIT_DYNAMIC: With this option, DC will only try to optimize
> > -      * the pipe utilization when using a single display; if the user
> > -      * connects to a second display, DC will avoid pipe split.
> > +      * @MPC_SPLIT_AVOID_MULT_DISP: With this option, DC will only try to
> > +      * optimize the pipe utilization when using a single display; if the
> > +      * user connects to a second display, DC will avoid pipe split.
> >        */
> >       MPC_SPLIT_AVOID_MULT_DISP = 2,
> >  };
> > @@ -497,7 +497,7 @@ enum dcn_zstate_support_state {
> >  };
> >
> >  /**
> > - * dc_clocks - DC pipe clocks
> > + * struct dc_clocks - DC pipe clocks
> >   *
> >   * For any clocks that may differ per pipe only the max is stored in this
> >   * structure
> > @@ -528,7 +528,7 @@ struct dc_clocks {
> >       bool fclk_prev_p_state_change_support;
> >       int num_ways;
> >
> > -     /**
> > +     /*
> >        * @fw_based_mclk_switching
> >        *
> >        * DC has a mechanism that leverage the variable refresh rate to switch
>
