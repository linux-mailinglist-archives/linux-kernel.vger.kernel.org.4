Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF446633D1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 23:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237718AbjAIWSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 17:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237753AbjAIWSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 17:18:22 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787171208E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 14:18:20 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id q141so2115228vkb.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 14:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2KmFF4MIYR1i1tDn7HkCXsIkV2zq/DOASpD61PD2PiQ=;
        b=o9O4iMagnefvuL39/DCHp9NN7X7dAfd5489k94RQaSeNu3Qe9PpX1LHn7PZ/LN+PbQ
         RVsgiQvejr/XomlyXBf1cUFSzBxzGYdacyaOzd7SMmecWNm9U614/aPFL5AcKuzHIbmu
         dvR8umH3QOBwYCCAxQURO8baXqc1BXRLsrD+jb+n9r/LK6hnJvxs0UvVGgWiNjiCZPWM
         AI5eDEMtsueo+BwAXqiMBJ/S0LncsC+rkUqYn7kr+LbcTe0u9O2o+jIxC8s7Y8CjqKgS
         5pwXk2CUXPWNQ4b6/KCTNTHCdqfaawCe3iZSXqvfUyCGnYfkUId34ZLl/akgrplN2Jho
         x1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2KmFF4MIYR1i1tDn7HkCXsIkV2zq/DOASpD61PD2PiQ=;
        b=U8lKOBT8r+2sKCk0vOXSTr0hZ8ae+h9DR3vkX1vEnwtSU7p1teXJeKcgmo6nZAQZy+
         vTvwede2419OPbNcGxTKUFfWqgFj/CMADgST5p1Pajs1RBZQze+ep1ZRHQ2oI45Bdn5Z
         Rnr3wSOQomiQRXfTkz9Ns/EOy3it9nQzq7xNpj7gQCYh9KR07cRRdCojCmkSkw00EdFn
         aZM0Aj03TlxeqXfSFidCuEnaICW/JFBvo95LtZCV78H7kanrcKU8uzjhGPiW/00Avlr/
         LzBelbkgRSIYFGL2QWYcwrhUaPV7enw4x2uhsJD6DCw89z3AkcTpM/lrpJLoAnUoZE9P
         N5dw==
X-Gm-Message-State: AFqh2kpaZr31WQk5pENkJTpfXr+R7w6NYh1JiPQYdglHuy8xbEeh1dno
        4aaqZxfDmAYkd8D9rCF1hHjV2FGB2NoAIqH5nk8=
X-Google-Smtp-Source: AMrXdXvv7mF9XZiIt7npgmZEq2JiEakZJUiZv6jkCpyOs0AGEHA8TcqpOYnAIxhbZwkFgHo27x1dr29c97ldfYsMuy8=
X-Received: by 2002:a1f:5f90:0:b0:3d5:e6da:6d53 with SMTP id
 t138-20020a1f5f90000000b003d5e6da6d53mr3409574vkb.36.1673302699525; Mon, 09
 Jan 2023 14:18:19 -0800 (PST)
MIME-Version: 1.0
References: <20221205161005.222274-1-jim.cromie@gmail.com> <20221205161005.222274-3-jim.cromie@gmail.com>
 <Y7bGiLRanR3Y7tXM@phenom.ffwll.local>
In-Reply-To: <Y7bGiLRanR3Y7tXM@phenom.ffwll.local>
From:   jim.cromie@gmail.com
Date:   Mon, 9 Jan 2023 15:17:52 -0700
Message-ID: <CAJfuBxz=JQkXOYRRdbrcsZ+EjzjcSAMrd4P_NrbUAxCqYy2TMw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm_print: fix stale macro-name in comment
To:     Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com
Cc:     daniel.vetter@ffwll.ch
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

On Thu, Jan 5, 2023 at 5:46 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Mon, Dec 05, 2022 at 09:10:05AM -0700, Jim Cromie wrote:
> > Cited commit uses stale macro name, fix this, and explain better.
> >
> > When DRM_USE_DYNAMIC_DEBUG=y, DYNDBG_CLASSMAP_DEFINE() maps DRM_UT_*
> > onto BITs in drm.debug.  This still uses enum drm_debug_category, but
> > it is somewhat indirect, with the ordered set of DRM_UT_* enum-vals.
> > This requires that the macro args: DRM_UT_* list must be kept in sync
> > and in order.
> >
> > Fixes: f158936b60a7 ("drm: POC drm on dyndbg - use in core, 2 helpers, 3 drivers.")
> > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
>
> What's the status of this series?
>

dead - superseded by
https://patchwork.freedesktop.org/series/111652/
which is still WIP, but improved since that post.
I'll resubmit soon, with same title so patchwork calls it rev 2

> Greg, you landed the original entire pile that wasn't quite ready yet? Or
> should I apply these two?
> -Daniel
>
> > ---
> > . emphasize ABI non-change despite enum val change - Jani Nikula
> > . reorder to back of patchset to follow API name changes.
> > ---
> >  include/drm/drm_print.h | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
> > index a44fb7ef257f..e4c0c7e6d49d 100644
> > --- a/include/drm/drm_print.h
> > +++ b/include/drm/drm_print.h
> > @@ -276,7 +276,10 @@ static inline struct drm_printer drm_err_printer(const char *prefix)
> >   *
> >   */
> >  enum drm_debug_category {
> > -     /* These names must match those in DYNAMIC_DEBUG_CLASSBITS */
> > +     /*
> > +      * Keep DYNDBG_CLASSMAP_DEFINE args in sync with changes here,
> > +      * the enum-values define BIT()s in drm.debug, so are ABI.
> > +      */
> >       /**
> >        * @DRM_UT_CORE: Used in the generic drm code: drm_ioctl.c, drm_mm.c,
> >        * drm_memory.c, ...
> > --
> > 2.38.1
> >
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
