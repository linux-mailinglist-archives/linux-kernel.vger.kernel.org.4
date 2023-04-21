Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9376EAD70
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 16:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbjDUOuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 10:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjDUOuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 10:50:37 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB161AB;
        Fri, 21 Apr 2023 07:50:35 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-547299bf5d8so1300691eaf.3;
        Fri, 21 Apr 2023 07:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682088635; x=1684680635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRjexQPiKz+B2BoQne8GUJoVgOLR1S5xgnBzy2+vwS4=;
        b=S7tpiJ76bxam24ay+dcwU+lkgG2ZoXHiFLIxoeyfj0+byI5iBcx2l450tz/2E9W8Wv
         b2h1L2cKiG0giw0hS0j98+cO3L366V7krcddHCwHkASJvfLpeM1FNBX29DeFzKVh3G34
         a7b/LCvTbz5lb1xvsNRe1aDyrIZsxnCXKJpbsDu6xDE9mCJT3BNOINWuQIRouVYItqSR
         kFKqhN1jMPp49WdARMC+fHrYBKjrrzAV2Ur6+K8MVn5ogGN8b/LAW60v9wpnfwGVi2ch
         BDETaur+SB248K1SD7jdeJlFEBGJj7fplxuO+978tWeU85YbmzhZcOSHTvnuH1lmYFI5
         6H7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682088635; x=1684680635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uRjexQPiKz+B2BoQne8GUJoVgOLR1S5xgnBzy2+vwS4=;
        b=DpzCDc+dPQlpOl8U2fgfMG5fi5BoJWTnD3ZGXE22Of6jBsJR7tDyFa8atkGAP8lIcO
         FLfzVJG86vk9lQp7ydJl7A3VYJ++VBV+VSI4jPxoqKO59AcreqNLyc+rGfH5lT/RHkYU
         uZ2Isnb5SFM/iI4eogJp5aVLu4iG4ckBGaxV+5mwCLCC/X/lHowvi5V1BI9xPOr2O6YP
         jZjdXSexHnNv2RJD7N2iXn9yrYmKlEW1HhO22+LaRjY3d3gDisa3KH5ADxLOBBOzqio5
         X3nJvMtSaEhnAr2XsLPz2jMSWrrEp8Vh9WutYtcRwa9nr19QkO/UzJ3p/7G7yKXJ6nTW
         sp1g==
X-Gm-Message-State: AAQBX9fdAJwQs0zcAn7yb1b2tUlUs/EFfDlcANpFR0ghVGF2c1XNoujB
        Oe0Cio3E5wRZrDECoQ+MLZvbaIGfKwFB8ta/ubE=
X-Google-Smtp-Source: AKy350bmODRxJ669T9aGlnSwZYMJcgHKiq97d08P1iIzkniXSqIQpuU4ytOyTsxnikkTRNNNv7oGLN7hwliarNBmLVQ=
X-Received: by 2002:a05:6808:f03:b0:38d:ef77:d720 with SMTP id
 m3-20020a0568080f0300b0038def77d720mr3059404oiw.52.1682088635133; Fri, 21 Apr
 2023 07:50:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230412224311.23511-1-robdclark@gmail.com> <20230412224311.23511-6-robdclark@gmail.com>
 <CACvgo525ogS4LSZDUyaqjSqjJWj=qLRkphji5469=3obFXoMrQ@mail.gmail.com>
 <f2a423c2-302a-024a-cf65-199f4be6caec@linux.intel.com> <CACvgo53dP03r1BuxntyyoYjua5k6XPvVhu4iTGqXJq31UMUgxg@mail.gmail.com>
 <e16dc626-30bf-be19-8668-bdc14dfd051a@linux.intel.com>
In-Reply-To: <e16dc626-30bf-be19-8668-bdc14dfd051a@linux.intel.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Fri, 21 Apr 2023 07:50:24 -0700
Message-ID: <CAF6AEGv1B3gzM5sazA5kaPbU29aP-njygx-nOnsVjip1ZwERLg@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] drm: Add fdinfo memory stats
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Emil Velikov <emil.l.velikov@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 4:59=E2=80=AFAM Tvrtko Ursulin
<tvrtko.ursulin@linux.intel.com> wrote:
>
>
> On 21/04/2023 12:45, Emil Velikov wrote:
> > On Fri, 21 Apr 2023 at 12:23, Tvrtko Ursulin
> > <tvrtko.ursulin@linux.intel.com> wrote:
> >
> >> On 21/04/2023 11:26, Emil Velikov wrote:
> >>> On Wed, 12 Apr 2023 at 23:43, Rob Clark <robdclark@gmail.com> wrote:
> >>>
> >>>> +/**
> >>>> + * enum drm_gem_object_status - bitmask of object state for fdinfo =
reporting
> >>>> + * @DRM_GEM_OBJECT_RESIDENT: object is resident in memory (ie. not =
unpinned)
> >>>> + * @DRM_GEM_OBJECT_PURGEABLE: object marked as purgeable by userspa=
ce
> >>>> + *
> >>>> + * Bitmask of status used for fdinfo memory stats, see &drm_gem_obj=
ect_funcs.status
> >>>> + * and drm_show_fdinfo().  Note that an object can DRM_GEM_OBJECT_P=
URGEABLE if
> >>>> + * it still active or not resident, in which case drm_show_fdinfo()=
 will not
> >>>
> >>> nit: s/can/can be/;s/if it still/if it is still/
> >>>
> >>>> + * account for it as purgeable.  So drivers do not need to check if=
 the buffer
> >>>> + * is idle and resident to return this bit.  (Ie. userspace can mar=
k a buffer
> >>>> + * as purgeable even while it is still busy on the GPU.. it does no=
t _actually_
> >>>> + * become puregeable until it becomes idle.  The status gem object =
func does
> >>>
> >>> nit: s/puregeable/purgeable/
> >>>
> >>>
> >>> I think we want a similar note in the drm-usage-stats.rst file.
> >>>
> >>> With the above the whole series is:
> >>> Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
> >>
> >> Have you maybe noticed my slightly alternative proposal? (*) I am not =
a
> >> fan of putting this flavour of accounting into the core with no way to
> >> opt out. I think it leaves no option but to add more keys in the futur=
e
> >> for any driver which will not be happy with the core accounting.
> >>
> >> *) https://patchwork.freedesktop.org/series/116581/
> >>
> >
> > Indeed I saw it. Not a fan of it, I'm afraid.
>
> Hard to guess the reasons. :)
>
> Anyway, at a minimum I suggest that if the no opt out version has to go
> in, it is clearly documented drm-*-memory-* is *not* about the full
> memory use of the client, but about memory belonging to user visible
> buffer objects *only*. Possibly going as far as naming the keys as
> drm-user-bo-memory-... That way there is a way to implement proper
> drm-*-memory- in the future.

I'll go back to the helper approach, just been distracted by a few
other balls in the air.. should hopefully get to it in the next couple
days

BR,
-R

> Regards,
>
> Tvrtko
>
> >>> Fwiw: Keeping the i915 patch as part of this series would be great.
> >>> Sure i915_drm_client->id becomes dead code, but it's a piece one can
> >>> live with for a release or two. Then again it's not my call to make.
> >>
> >> Rob can take the i915 patch from my RFC too.
> >>
> >
> > Indeed.
> >
> > -Emil
