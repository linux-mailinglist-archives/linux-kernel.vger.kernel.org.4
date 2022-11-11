Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868236262AA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 21:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbiKKUQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 15:16:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233752AbiKKUQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 15:16:32 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4389B845F3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 12:16:31 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id c15-20020a17090a1d0f00b0021365864446so5587445pjd.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 12:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I9wKcCSxee3fGRXsHP7+5SA+IgN1I4iGmJtWyDFL56E=;
        b=UGGcoq5EqTZDBEOroTloMC/2p7lbC2mv10mi4sSO0LQrlP9xWkhOQFArogjX/OkBKZ
         cFqpYVFtS4q0BU3j+718z5Pl9ZeT27aRjcpchJxdDChgNR4uF6P+SQBjamzmJJ5fk5Ub
         88LwUbzwRg13X1b1Zav0YTgARnV90jIR6I/nQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I9wKcCSxee3fGRXsHP7+5SA+IgN1I4iGmJtWyDFL56E=;
        b=yGUxTLedwGu6au3JisZO+yTcZgLcyhPgg7+9q2kfJAFlpTueo5Wv/J356jFDWHShzh
         u3eMqX3bZ7LywewQut2U4ek62NzKNkfdYck8ePrHXmqX3xhrybzXKSwqkA8zLgJxzH1V
         +DCFIRc6cZvTIGlJXGgRUj0cq97ctITJf3cn8dMLG37UxUHGcQbAVRYi2HPnRQuxaRjr
         JooPBilpF0OMx2l45oImxCS7cPN/En7+jJhrjl72MDsgfGkTiplv6PYLSQOsaPV88ar4
         MlMuurB8Fp7fll49I3D0fGlBF323+MiXvSVm39muXphoAFmq4yjV5SvzdsfQ48/xWrqP
         +Y+A==
X-Gm-Message-State: ANoB5pmpJN3AwMnFVOyFcmTXr4w9Mn1vc+Og5zg7hbUhuIKFmWSc6/xb
        ZmPy4zsyIZL5CSkxTaxrXirK+g==
X-Google-Smtp-Source: AA0mqf4jt8C/RYYwBmrF+x8RmkjnEH0N0TDFuZ+EYwSxeV7yub85W/7zaVPeZs99zPYzESHhKKNLbA==
X-Received: by 2002:a17:90b:3951:b0:217:cdc4:afef with SMTP id oe17-20020a17090b395100b00217cdc4afefmr3658282pjb.115.1668197790709;
        Fri, 11 Nov 2022 12:16:30 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q24-20020a63e958000000b0047048c201e3sm1708532pgj.33.2022.11.11.12.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 12:16:30 -0800 (PST)
Date:   Fri, 11 Nov 2022 12:16:29 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Karol Herbst <kherbst@redhat.com>
Cc:     Jani Nikula <jani.nikula@intel.com>, Lyude Paul <lyude@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, Ilia Mirkin <imirkin@alum.mit.edu>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@gmail.com>,
        "Nathan E. Egge" <unlord@xiph.org>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        Dave Airlie <airlied@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: Coverity: nouveau_dp_irq(): Null pointer dereferences
Message-ID: <202211111215.1F421B7E@keescook>
References: <202211100850.7A8DD75@keescook>
 <87iljl6ehe.fsf@intel.com>
 <202211111110.11B554B@keescook>
 <CACO55tt5KOgDYMEw=spDeoMaYuj2GQOuHU+BEgadr1nQiFOGhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACO55tt5KOgDYMEw=spDeoMaYuj2GQOuHU+BEgadr1nQiFOGhw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 09:06:54PM +0100, Karol Herbst wrote:
> On Fri, Nov 11, 2022 at 8:21 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Fri, Nov 11, 2022 at 11:13:17AM +0200, Jani Nikula wrote:
> > > On Thu, 10 Nov 2022, coverity-bot <keescook@chromium.org> wrote:
> > > > Hello!
> > > >
> > > > This is an experimental semi-automated report about issues detected by
> > > > Coverity from a scan of next-20221110 as part of the linux-next scan project:
> > > > https://scan.coverity.com/projects/linux-next-weekly-scan
> > > >
> > > > You're getting this email because you were associated with the identified
> > > > lines of code (noted below) that were touched by commits:
> > > >
> > > >   Mon Aug 31 19:10:08 2020 -0400
> > > >     a0922278f83e ("drm/nouveau/kms/nv50-: Refactor and cleanup DP HPD handling")
> > >
> > > Hi Kees, this looks like a good idea, but maybe double check the Cc list
> > > generation? I was Cc'd on four mails today that I thought were
> > > irrelevant to me.
> >
> > Hi!
> >
> > Heh, I was recently asked to _expand_ the CC list. :)
> >
> > For these last pass of reports, I added a get_maintainers.pl run to the
> > identified commit. In this instance, the commit touched:
> >
> >  drivers/gpu/drm/nouveau/dispnv04/disp.c     |    6 +
> >  drivers/gpu/drm/nouveau/dispnv50/disp.c     |  192 ++++++++++++++++++++++--------------------------
> >  drivers/gpu/drm/nouveau/nouveau_connector.c |   14 ---
> >  drivers/gpu/drm/nouveau/nouveau_display.c   |    2
> >  drivers/gpu/drm/nouveau/nouveau_display.h   |    2
> >  drivers/gpu/drm/nouveau/nouveau_dp.c        |  132 ++++++++++++++++++++++++++++-----
> >  drivers/gpu/drm/nouveau/nouveau_encoder.h   |   33 +++++++-
> >  7 files changed, 244 insertions(+), 137 deletions(-)
> >
> > And the get_maintainers.pl rationale was:
> >
> > Ben Skeggs <bskeggs@redhat.com> (supporter:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS,commit_signer:1/1=100%,commit_signer:6/16=38%,authored:4/16=25%,added_lines:23/124=19%,removed_lines:36/152=24%)
> > Karol Herbst <kherbst@redhat.com> (supporter:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS,commit_signer:2/1=100%)
> > Lyude Paul <lyude@redhat.com> (supporter:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS,commit_signer:9/16=56%,authored:6/16=38%,added_lines:92/124=74%,removed_lines:107/152=70%)
> > David Airlie <airlied@gmail.com> (maintainer:DRM DRIVERS)
> > Daniel Vetter <daniel@ffwll.ch> (maintainer:DRM DRIVERS)
> > Ilia Mirkin <imirkin@alum.mit.edu> (commit_signer:1/1=100%,authored:1/1=100%,added_lines:2/2=100%,removed_lines:2/2=100%)
> > "Nathan E. Egge" <unlord@xiph.org> (commit_signer:1/1=100%)
> > Jani Nikula <jani.nikula@intel.com> (commit_signer:6/16=38%)
> > Dave Airlie <airlied@redhat.com> (commit_signer:5/16=31%)
> > Thomas Zimmermann <tzimmermann@suse.de> (commit_signer:4/16=25%,authored:4/16=25%)
> > dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS)
> > nouveau@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS)
> >
> 
> I'd say it's good enough to message supporters and the mailing lists
> for at least Nouveau code, maybe even all drm drivers.

i.e. leave out the commit_signer hits?

> Not sure what to do about actual maintainers, but I doubt Dave and
> Daniel want to be CCed on every Coverity report here either.

I updated the CC logic based on this feedback:
https://lore.kernel.org/linux-hardening/87h6zgfub4.fsf@kernel.org/

So maybe just mailing lists?

-- 
Kees Cook
