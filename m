Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC17612B04
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 15:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiJ3OnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 10:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJ3OnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 10:43:21 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B39B7D4
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 07:43:19 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id g26so4346664vkm.12
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 07:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKyEG79uRicAmyaHbJpoMhHQzezkxEzPsdyyX+IvEXE=;
        b=YHsMmFPkPMYCHE7nbf1aj5ciNMIHkdQKToaBgPEH2KJek3E9ivdvMQsmBzCPPnAmBg
         U7qidXh50jV3fvcPnqcFdZB1trM/zrgWRQxM4VAdAnUoJOwsRiXATKEeEHvmM0F+39z/
         hItfAlmJNRtIm5cpKhf7HdlhDbxsO+LSvy7TcZehjNjhSpeQItmfsWx4LwVmzmfkAizY
         JdsHa3K5Px3yzfGGodlyp+rOMLwFvf7aZu1kuenk4fCwDAn6b3bRF/10uotMICg28Pmt
         H3rJs046vqXtaXPBmsC51X7uFPrGlY0mxYhP0cq3HUASxvIdjP7lYFdIEzsDWxTHZvwb
         v1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sKyEG79uRicAmyaHbJpoMhHQzezkxEzPsdyyX+IvEXE=;
        b=EMtTz6oc7+AiJCKeqOXp4Oghj4mcmWWKgxe4YitDDtw6Jfk53seIDt97FvOsNemGmi
         3x2ndToKf9AvK3mZKWcjJgY6pzjJbMVm6DK9G8cMpkdirwO3W9oez+bXik90xY2AJfnI
         eGtZrTTSXBlNkYjEjaD0n8iaCiAQCqkOCaB5v/RUTttqS1t7Twu/6ii9n3Jzk+jbacpP
         8fjJbXSqf0NHF0EpnKBTsU+QgW8fysuassZma7i1Bbn/x1rJhqsb9ISvrhzfrARRpSbx
         wiiV4/8jkoOglzD4Czc/UUiIT9CASIoMMXFkkEJaITUb8nKb2T66kfOfL9rTkOQXigVI
         nxpQ==
X-Gm-Message-State: ACrzQf1oT5ibDBVxv4iROUTCPxiWqU+FFVpprBSdZKmqfxqMugl2PLw4
        nBkcQBruYd4cIfvns4fK3rljj+LqqPvjOjPMMb43woahrE0=
X-Google-Smtp-Source: AMsMyM4KwiP4ZLQx9gpkhCmN89f0NhF1KEo2pJPaYpHGU9PBCyr2YUKAiYBOp82hg1t04UA4rbDQT/6mpBED/KkiV90=
X-Received: by 2002:a1f:988c:0:b0:3aa:cf0a:e0f7 with SMTP id
 a134-20020a1f988c000000b003aacf0ae0f7mr3060768vke.24.1667140998757; Sun, 30
 Oct 2022 07:43:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220912052852.1123868-1-jim.cromie@gmail.com>
 <Yy7/6oTBW2lqVSK1@kroah.com> <Y1Fyuh12g/gt3Izn@intel.com> <87a65pfsbq.fsf@intel.com>
 <c1807585-f6c8-c05d-bc20-c6a540e59814@akamai.com> <CAJfuBxxWVBxL29sXS3XoE5Es9HTbVyFUi9bQFYNupJAERffAew@mail.gmail.com>
 <Y1qqurH/lG0u+3ky@intel.com> <CAJfuBxzpG+C1ARLs3c_znXECEU7Ldg8RhruLMUXA67w+DwcrOQ@mail.gmail.com>
 <Y1rllFeOnT9/PQVA@intel.com>
In-Reply-To: <Y1rllFeOnT9/PQVA@intel.com>
From:   jim.cromie@gmail.com
Date:   Sun, 30 Oct 2022 08:42:52 -0600
Message-ID: <CAJfuBxw_YFvCtHMwVE0K0fa5GJbrZy4hTOSS9FebeDs6fxUUCA@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH v7 0/9] dyndbg: drm.debug adaptation
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     Jason Baron <jbaron@akamai.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>, daniel.vetter@ffwll.ch,
        intel-gfx@lists.freedesktop.org, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        seanpaul@chromium.org, dri-devel@lists.freedesktop.org,
        joe@perches.com, intel-gvt-dev@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 2:10 PM Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
>
> On Thu, Oct 27, 2022 at 01:55:39PM -0600, jim.cromie@gmail.com wrote:
> > On Thu, Oct 27, 2022 at 9:59 AM Ville Syrj=C3=A4l=C3=A4
> > <ville.syrjala@linux.intel.com> wrote:
> > >
> > > On Thu, Oct 27, 2022 at 09:37:52AM -0600, jim.cromie@gmail.com wrote:
> > > > On Thu, Oct 27, 2022 at 9:08 AM Jason Baron <jbaron@akamai.com> wro=
te:
> > > > >
> > > > >
> > > > >
> > > > > On 10/21/22 05:18, Jani Nikula wrote:
> > > > > > On Thu, 20 Oct 2022, Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@lin=
ux.intel.com> wrote:
> > > > > >> On Sat, Sep 24, 2022 at 03:02:34PM +0200, Greg KH wrote:
> > > > > >>> On Sun, Sep 11, 2022 at 11:28:43PM -0600, Jim Cromie wrote:
> > > > > >>>> hi Greg, Dan, Jason, DRM-folk,
> > > > > >>>>
> > > > > >>>> heres follow-up to V6:
> > > > > >>>>   rebased on driver-core/driver-core-next for -v6 applied bi=
ts (thanks)
> > > > > >>>>   rework drm_debug_enabled{_raw,_instrumented,} per Dan.
> > > > > >>>>
> > > > > >>>> It excludes:
> > > > > >>>>   nouveau parts (immature)
> > > > > >>>>   tracefs parts (I missed --to=3DSteve on v6)
> > > > > >>>>   split _ddebug_site and de-duplicate experiment (way unread=
y)
> > > > > >>>>
> > > > > >>>> IOW, its the remaining commits of V6 on which Dan gave his R=
eviewed-by.
> > > > > >>>>
> > > > > >>>> If these are good to apply, I'll rebase and repost the rest =
separately.
> > > > > >>>
> > > > > >>> All now queued up, thanks.
> > > > > >>
> > > > > >> This stuff broke i915 debugs. When I first load i915 no debug =
prints are
> > > > > >> produced. If I then go fiddle around in /sys/module/drm/parame=
ters/debug
> > > > > >> the debug prints start to suddenly work.
> > > > > >
> > > > > > Wait what? I always assumed the default behaviour would stay th=
e same,
> > > > > > which is usually how we roll. It's a regression in my books. We=
've got a
> > > > > > CI farm that's not very helpful in terms of dmesg logging right=
 now
> > > > > > because of this.
> > > > > >
> > > > > > BR,
> > > > > > Jani.
> > > > > >
> > > > > >
> > > > >
> > > > > That doesn't sound good - so you are saying that prior to this ch=
ange some
> > > > > of the drm debugs were default enabled. But now you have to manua=
lly enable
> > > > > them?
> > > > >
> > > > > Thanks,
> > > > >
> > > > > -Jason
> > > >
> > > >
> > > > Im just seeing this now.
> > > > Any new details ?
> > >
> > > No. We just disabled it as BROKEN for now. I was just today thinking
> > > about sending that patch out if no solutin is forthcoming soon since
> > > we need this working before 6.1 is released.
> > >
> > > Pretty sure you should see the problem immediately with any driver
> > > (at least if it's built as a module, didn't try builtin). Or at least
> > > can't think what would make i915 any more special.
> > >
> >
> > So, I should note -
> > 99% of my time & energy on this dyndbg + drm patchset
> > has been done using virtme,
> > so my world-view (and dev-hack-test env) has been smaller, simpler
> > maybe its been fatally simplistic.
> >
> > ive just rebuilt v6.0  (before the trouble)
> > and run it thru my virtual home box,
> > I didnt see any unfamiliar drm-debug output
> > that I might have inadvertently altered somehow
> >
> > I have some real HW I can put a reference kernel on,0
> > to look for the missing output, but its all gonna take some time,
> > esp to tighten up my dev-test-env
> >
> > in the meantime, there is:
> >
> > config DRM_USE_DYNAMIC_DEBUG
> > bool "use dynamic debug to implement drm.debug"
> > default y
> > depends on DRM
> > depends on DYNAMIC_DEBUG || DYNAMIC_DEBUG_CORE
> > depends on JUMP_LABEL
> > help
> >   Use dynamic-debug to avoid drm_debug_enabled() runtime overheads.
> >   Due to callsite counts in DRM drivers (~4k in amdgpu) and 56
> >   bytes per callsite, the .data costs can be substantial, and
> >   are therefore configurable.
> >
> > Does changing the default fix things for i915 dmesg ?
>
> I think we want to mark it BROKEN in addition to make sure no one

Ok, I get the distinction now.
youre spelling that
  depends on BROKEN

I have a notional explanation, and a conflating commit:

can you eliminate
git log -p ccc2b496324c13e917ef05f563626f4e7826bef1

as the cause ?



commit ccc2b496324c13e917ef05f563626f4e7826bef1
Author: Jim Cromie <jim.cromie@gmail.com>
Date:   Sun Sep 11 23:28:51 2022 -0600

    drm_print: prefer bare printk KERN_DEBUG on generic fn

    drm_print.c calls pr_debug() just once, from __drm_printfn_debug(),
    which is a generic/service fn.  The callsite is compile-time enabled
    by DEBUG in both DYNAMIC_DEBUG=3Dy/n builds.

    For dyndbg builds, reverting this callsite back to bare printk is
    correcting a few anti-features:

    1- callsite is generic, serves multiple drm users.
       it is soft-wired on currently by #define DEBUG
       could accidentally: #> echo -p > /proc/dynamic_debug/control

    2- optional "decorations" by dyndbg are unhelpful/misleading here,
       they describe only the generic site, not end users

    IOW, 1,2 are unhelpful at best, and possibly confusing.


This shouldnt have turned off any debug of any kind
(drm.debug nor plain pr_debug)

but that former callsite no longer does the modname:func:line prefixing
that could have been in effect and relied upon (tested for) by your CI


I do need to clarify, I dont know exactly what debug/logging output
is missing such that CI is failing

related,
Ive added DEBUG to test-dynmamic-debug,
to prove the compile-time enablement of pr_debugs.
patch forthcoming, with a couple other fixes.





> enables it by accident. We already got one bug report where I had to
> ask the reporter to rebuild their kernel since this had gotten
> enabled and we didn't get any debugs from the driver probe.
>
> > or is the problem deeper ?
> >
> > theres also this Makefile addition, which I might have oversimplified
> >
> > CFLAGS-$(CONFIG_DRM_USE_DYNAMIC_DEBUG) +=3D -DDYNAMIC_DEBUG_MODULE
>
> --
> Ville Syrj=C3=A4l=C3=A4
> Intel
