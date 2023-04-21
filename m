Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92276EA98B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 13:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbjDULpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 07:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjDULpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 07:45:43 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21114C3;
        Fri, 21 Apr 2023 04:45:42 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-b8f557b241fso672366276.0;
        Fri, 21 Apr 2023 04:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682077541; x=1684669541;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cpExu34liiyV+GAi+/eT3EAKnCiqG6Ffpw4DRQDPAno=;
        b=X357dpjFwt18aofQ0wDrq5xS25zQymH1kkZ7nx1QoezkPpsctPIFFhRm7lHDtLaWU/
         leznEkIpKE+UutrPj+vIDvHUvepfMSVv2O/FhGzpxfyxrGyc2Se+g0FTJt15uLyo1l5m
         hQ8VnTH7tb9c4cu9NcS0tiw6kxJvV/6MWP0Dwm2Pg0gQ1bM6gi0DQUUOmITt/jBRS0UH
         cJVNYj7C2D/uCIZrngQ/8ubwO/63Va8rs4mpyr1W+aQBfPIAmvZP8lZlqxM7GqjAWTJX
         e1yqWbDs2olaaSsMgp2AL3mmpHPl2LbdU/oqkTz0pkbm2Y/x+13Bm4DQ5j3P9Nsxe5bU
         Z+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682077541; x=1684669541;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cpExu34liiyV+GAi+/eT3EAKnCiqG6Ffpw4DRQDPAno=;
        b=F1SH8Giyl1ZB0KOYj2DWMSFLxDcK2VEST7gDImjsnHFCef2xlIEF0OXPvq5BtX6cqs
         jXl5yvyj3UFmlJXXpHxSWqfIhVrmnqCR1Sx0gEdE38luHws8H9AjmCjkUpQuyw+dFTeT
         vU+rRefoWavbTTRkzlIlxfuZBULwHKoHnrp/K0SxIvWRiVY0yfWr4UzlL3Kt4NMA+0F/
         ZQ1NOw3s3e66x1GipEN1qbdaB8/E2/OA/vhpmE9IJ7xQwNdi/71m6ElvlGjz7Ga+KKAG
         NElfKaLuKcbf/u7SdmNpp2zbGFmbAU4cSizxUEdi2EhPSMrra+fa4pKuwkLkymmnbW8J
         Tf6Q==
X-Gm-Message-State: AAQBX9coDexaH4tuKPSg43ccxQdO5O6tdYQJO9QeSUat2RJ0Nnb6HSus
        meZy516r93aKRD/pLt2j84sGRcYw7heF29iDg94=
X-Google-Smtp-Source: AKy350ZkJiVpvUcieuU2kqFOJ/OAdnKq40E+PLmCvtqId/JFLpKucdeMo2ppNwRWJvVclimQAVg9DPEL78KBn1eVLpE=
X-Received: by 2002:a25:d7d1:0:b0:b92:5a0e:d5e9 with SMTP id
 o200-20020a25d7d1000000b00b925a0ed5e9mr1999465ybg.28.1682077541278; Fri, 21
 Apr 2023 04:45:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230412224311.23511-1-robdclark@gmail.com> <20230412224311.23511-6-robdclark@gmail.com>
 <CACvgo525ogS4LSZDUyaqjSqjJWj=qLRkphji5469=3obFXoMrQ@mail.gmail.com> <f2a423c2-302a-024a-cf65-199f4be6caec@linux.intel.com>
In-Reply-To: <f2a423c2-302a-024a-cf65-199f4be6caec@linux.intel.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Fri, 21 Apr 2023 12:45:29 +0100
Message-ID: <CACvgo53dP03r1BuxntyyoYjua5k6XPvVhu4iTGqXJq31UMUgxg@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] drm: Add fdinfo memory stats
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Christopher Healy <healych@amazon.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Apr 2023 at 12:23, Tvrtko Ursulin
<tvrtko.ursulin@linux.intel.com> wrote:

> On 21/04/2023 11:26, Emil Velikov wrote:
> > On Wed, 12 Apr 2023 at 23:43, Rob Clark <robdclark@gmail.com> wrote:
> >
> >> +/**
> >> + * enum drm_gem_object_status - bitmask of object state for fdinfo reporting
> >> + * @DRM_GEM_OBJECT_RESIDENT: object is resident in memory (ie. not unpinned)
> >> + * @DRM_GEM_OBJECT_PURGEABLE: object marked as purgeable by userspace
> >> + *
> >> + * Bitmask of status used for fdinfo memory stats, see &drm_gem_object_funcs.status
> >> + * and drm_show_fdinfo().  Note that an object can DRM_GEM_OBJECT_PURGEABLE if
> >> + * it still active or not resident, in which case drm_show_fdinfo() will not
> >
> > nit: s/can/can be/;s/if it still/if it is still/
> >
> >> + * account for it as purgeable.  So drivers do not need to check if the buffer
> >> + * is idle and resident to return this bit.  (Ie. userspace can mark a buffer
> >> + * as purgeable even while it is still busy on the GPU.. it does not _actually_
> >> + * become puregeable until it becomes idle.  The status gem object func does
> >
> > nit: s/puregeable/purgeable/
> >
> >
> > I think we want a similar note in the drm-usage-stats.rst file.
> >
> > With the above the whole series is:
> > Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
>
> Have you maybe noticed my slightly alternative proposal? (*) I am not a
> fan of putting this flavour of accounting into the core with no way to
> opt out. I think it leaves no option but to add more keys in the future
> for any driver which will not be happy with the core accounting.
>
> *) https://patchwork.freedesktop.org/series/116581/
>

Indeed I saw it. Not a fan of it, I'm afraid.

> > Fwiw: Keeping the i915 patch as part of this series would be great.
> > Sure i915_drm_client->id becomes dead code, but it's a piece one can
> > live with for a release or two. Then again it's not my call to make.
>
> Rob can take the i915 patch from my RFC too.
>

Indeed.

-Emil
