Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71CCA72007D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 13:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235132AbjFBLgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 07:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbjFBLgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 07:36:51 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77313194;
        Fri,  2 Jun 2023 04:36:44 -0700 (PDT)
Received: from pendragon.ideasonboard.com (om126156168104.26.openmobile.ne.jp [126.156.168.104])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 443CE6E0;
        Fri,  2 Jun 2023 13:36:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1685705780;
        bh=P6UK7gokiOdLMcgnQqxLjRe/2stcZX5OnfxLzLL/M8Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZXkiKfg3l/3Zn5Hs1rF1UqizLbyGjOovKGO5nYDa5CsXVzIhgdO0OuBQ8YgdHm38X
         Bxyh7d0X1/u80DgGvAuskxBTqQBbfDqWu2lEb7bY4nexWJTb+xXsdfxHTwRxJXd7mU
         s+9jbaqSxFpevXaFdQHCREWYp9j9SBrCMzFprxoM=
Date:   Fri, 2 Jun 2023 14:36:40 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Tomi Valkeinen <tomba@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] drm: Remove references to removed transitional
 helpers
Message-ID: <20230602113640.GG26944@pendragon.ideasonboard.com>
References: <cover.1685696114.git.geert+renesas@glider.be>
 <14e091fc522aa63a3e33bda1016e5fa946d47d18.1685696114.git.geert+renesas@glider.be>
 <20230602110459.GC26944@pendragon.ideasonboard.com>
 <CAMuHMdXR79TTSAcKb=DA2mRVDgaxBERts5PQLMf+mXpZDQJu=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdXR79TTSAcKb=DA2mRVDgaxBERts5PQLMf+mXpZDQJu=Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Fri, Jun 02, 2023 at 01:17:58PM +0200, Geert Uytterhoeven wrote:
> On Fri, Jun 2, 2023 at 1:05 PM Laurent Pinchart wrote:
> > On Fri, Jun 02, 2023 at 11:11:35AM +0200, Geert Uytterhoeven wrote:
> > > The transitional helpers were removed a long time ago, but some
> > > references stuck.  Remove them.
> > >
> > > Fixes: 21ebe615c16994f3 ("drm: Remove transitional helpers")
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> > > --- a/drivers/gpu/drm/drm_plane_helper.c
> > > +++ b/drivers/gpu/drm/drm_plane_helper.c
> > > @@ -51,14 +51,6 @@
> > >   * planes, and newly merged drivers must not rely upon these transitional
> > >   * helpers.
> > >   *
> >
> > The first paragraph starts with "This helper library has two parts.". As
> > you're dropping the mention of the second part, I think you should
> > rework the first paragraph too.
> 
> That was my initial thought, too.
> However, the code still has a second part, not related to the topic of
> the first part (primary plane support).

How about mentioning that in the comment then ?

> > > - * The second part also implements transitional helpers which allow drivers to
> > > - * gradually switch to the atomic helper infrastructure for plane updates. Once
> > > - * that switch is complete drivers shouldn't use these any longer, instead using
> > > - * the proper legacy implementations for update and disable plane hooks provided
> > > - * by the atomic helpers.
> > > - *
> > > - * Again drivers are strongly urged to switch to the new interfaces.
> > > - *
> > >   * The plane helpers share the function table structures with other helpers,
> > >   * specifically also the atomic helpers. See &struct drm_plane_helper_funcs for
> > >   * the details.

-- 
Regards,

Laurent Pinchart
