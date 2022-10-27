Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0AC60FC24
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 17:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236213AbiJ0PiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 11:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236168AbiJ0PiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 11:38:21 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91ED31911C1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 08:38:20 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id v81so978014vkv.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 08:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PLDisoEn34t2ZQnupF6SPJfGt8WPObAPZmKjBnvrJkI=;
        b=KZlvNl+eE9ORZM1EzwJdyzvp+Q/jcpXNKLscME0LoHcazeOhqVbzssT+F2exO/aAL+
         mkrOUb36JE9hSWUrYu24I8UfxNEIS1WpsafbDbFC5ao3dsJ0upSRq6zez5rpMNok5JR1
         KWL1DdMOD4DkPHgl3XVQOK42seb3DoHMSYmd+dVIwhK3R6Pi5s6g5+KxbxGea2/GfUQT
         3ZnPsSKybtRGH59IvR0NQX2BRCGYYksTSlW/J9TioVI+1KVmNbpPtj5GjzAszZ4Kv2GI
         XUEjlia8f2qfJMBxKIDfYzxiK4kgng+HoUfMm/kbQX60Td+HmDfK3qSL9JnP4OQjh6L1
         pbuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PLDisoEn34t2ZQnupF6SPJfGt8WPObAPZmKjBnvrJkI=;
        b=glz2M+Fctaw2sFOvD/RbUilPf7IWovGzRXacFHpufTIcpW8zUSEFcoK9S/QkrT8gQj
         W+azjnfp5Acy4fyHpAMvawJkiCfuGZEGX7hkm7vycVu3QQSGuIHZlDiSubJ8IIthTAeq
         eyNK8kZuk7fi2FPhMSu3mpVJoMjtDOkb8vSLd12BQps0N90HCg5t4pAhK/mkYuEUR2jM
         U/yjSssdfZkO+lzE3gRUUojEA8BbvMQmJE9Oj52Fn29nzd9odAahZOy7TlDtywLU2c6/
         MJCZmNKA3eEPvAM0K68GZRxSnvNNB8B6b7wxs+Je9di2mQfXt7e5fiUbUWV0I2QNB3uF
         a9PA==
X-Gm-Message-State: ACrzQf2j9m6qsbpNHFisCQuBp+tuH33Pp2xQGJ3ikAwx1aRZZgw2rngJ
        yTNS9mJ52+vBJv0hH2SKTr7YNnbzGQDlKN1Umpk=
X-Google-Smtp-Source: AMsMyM5wvu1PJdUuru30Taq7t+4LZkeExiWJp6I1Xynb8XRsfgieIvgggIfNmFUQkE0s2+ZLKo0S8g98WdxVUxqqGho=
X-Received: by 2002:a1f:988c:0:b0:3aa:cf0a:e0f7 with SMTP id
 a134-20020a1f988c000000b003aacf0ae0f7mr27367057vke.24.1666885099359; Thu, 27
 Oct 2022 08:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220912052852.1123868-1-jim.cromie@gmail.com>
 <Yy7/6oTBW2lqVSK1@kroah.com> <Y1Fyuh12g/gt3Izn@intel.com> <87a65pfsbq.fsf@intel.com>
 <c1807585-f6c8-c05d-bc20-c6a540e59814@akamai.com>
In-Reply-To: <c1807585-f6c8-c05d-bc20-c6a540e59814@akamai.com>
From:   jim.cromie@gmail.com
Date:   Thu, 27 Oct 2022 09:37:52 -0600
Message-ID: <CAJfuBxxWVBxL29sXS3XoE5Es9HTbVyFUi9bQFYNupJAERffAew@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH v7 0/9] dyndbg: drm.debug adaptation
To:     Jason Baron <jbaron@akamai.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
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

On Thu, Oct 27, 2022 at 9:08 AM Jason Baron <jbaron@akamai.com> wrote:
>
>
>
> On 10/21/22 05:18, Jani Nikula wrote:
> > On Thu, 20 Oct 2022, Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel=
.com> wrote:
> >> On Sat, Sep 24, 2022 at 03:02:34PM +0200, Greg KH wrote:
> >>> On Sun, Sep 11, 2022 at 11:28:43PM -0600, Jim Cromie wrote:
> >>>> hi Greg, Dan, Jason, DRM-folk,
> >>>>
> >>>> heres follow-up to V6:
> >>>>   rebased on driver-core/driver-core-next for -v6 applied bits (than=
ks)
> >>>>   rework drm_debug_enabled{_raw,_instrumented,} per Dan.
> >>>>
> >>>> It excludes:
> >>>>   nouveau parts (immature)
> >>>>   tracefs parts (I missed --to=3DSteve on v6)
> >>>>   split _ddebug_site and de-duplicate experiment (way unready)
> >>>>
> >>>> IOW, its the remaining commits of V6 on which Dan gave his Reviewed-=
by.
> >>>>
> >>>> If these are good to apply, I'll rebase and repost the rest separate=
ly.
> >>>
> >>> All now queued up, thanks.
> >>
> >> This stuff broke i915 debugs. When I first load i915 no debug prints a=
re
> >> produced. If I then go fiddle around in /sys/module/drm/parameters/deb=
ug
> >> the debug prints start to suddenly work.
> >
> > Wait what? I always assumed the default behaviour would stay the same,
> > which is usually how we roll. It's a regression in my books. We've got =
a
> > CI farm that's not very helpful in terms of dmesg logging right now
> > because of this.
> >
> > BR,
> > Jani.
> >
> >
>
> That doesn't sound good - so you are saying that prior to this change som=
e
> of the drm debugs were default enabled. But now you have to manually enab=
le
> them?
>
> Thanks,
>
> -Jason


Im just seeing this now.
Any new details ?

I didnt knowingly change something, but since its apparently happening,
heres a 1st WAG at a possible cause

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

    reverting yields a nominal data and text shrink:

       text    data     bss     dec     hex filename
     462583   36604   54592 553779   87333 /kernel/drivers/gpu/drm/drm.ko
     462515   36532   54592 553639   872a7 -dirty/kernel/drivers/gpu/drm/dr=
m.ko

    Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
    Link: https://lore.kernel.org/r/20220912052852.1123868-9-jim.cromie@gma=
il.com
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
