Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2916AD6B2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 06:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjCGFLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 00:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjCGFLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 00:11:23 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF711532B2
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 21:11:21 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id x14so11305341vso.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 21:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678165881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gOhaj5GaMc2x+mrmGWMEhuFpIiJwp+9KbBPK8wKJme0=;
        b=e8hl3EEyt4DxXdBBzVFW2YX2FyQYl9J+LekJuNwUxMSMgfHz1/PC6VHwQaqSjPptvA
         hC6OxQYaAMCK/02ReFmgVpiSqDHZllJAk8tARaYERGqJYpTjgPO7Mxeho+eE7DwSxWJc
         9c3PmbapBNNOSq1Mk/pa/LBHS8hUK8bgqok9GortNdTzQ4yKAAUR9wjpWk56k0r2PwTt
         aA1OEvu6hcZuiaZLjAXIFP9FLCOVmm7S7gZS68oKQsM5vfqnIGKF+REHleRitJPf15zw
         OX28lAlMkqsvROV4gFvy4NR8j60I1YRcLiwMj5He81BDPV13Q60l9poBJMHothtS0q4O
         HBag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678165881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gOhaj5GaMc2x+mrmGWMEhuFpIiJwp+9KbBPK8wKJme0=;
        b=IfyVwC8RIJPEdFhkWY/ovhlXJ91lWsEEAjGgiQRcTkMpz7vAKa1Ylz7MrOSloCC+D5
         H//QFhboj/yEA/q8UgIpVLslkNbRVOUmv9m66Gb6V1NUdW3OlSKWKr6uBZUeqs8W5mHX
         eti1Fan5+Rr3bh6cKdswJOFsoxdW2JIjRBfjTgRTqVxTHOd0Cu28k9iFOsjN7J17j1m2
         W6xBTcxiT9/iyI0KBdfJWc5S8EFURPaS/uQ8wUwDJyb6sHRsqPXEBaP8f1sGE3HdZ/qk
         7+g+c++HbMQP4bifAg1KCLisMKqUD+YwanZbO616c0U4fhmTpHNFxX5azDfQhrXwPsNS
         OmpQ==
X-Gm-Message-State: AO0yUKWJqlh/FagnLiNdmxWmZS7bBET38X8BhsSyHDcOSkWlZPWocqIF
        Sk570afxWIsg6GLnjZZtPVdou5V9xG94iUXDbJw=
X-Google-Smtp-Source: AK7set/W/A+me1jNyqWc9vH8ucYNaNO688tI9JJgzbjVx6tkIj8x0Jl/Ni8mowOOIOX3Uuu3Dn7pyPGaxtgEYlgRtxI=
X-Received: by 2002:a67:e94c:0:b0:421:c4a7:872b with SMTP id
 p12-20020a67e94c000000b00421c4a7872bmr6603337vso.6.1678165880965; Mon, 06 Mar
 2023 21:11:20 -0800 (PST)
MIME-Version: 1.0
References: <20220904214134.408619-1-jim.cromie@gmail.com> <20220904214134.408619-33-jim.cromie@gmail.com>
 <CAOZdJXXHGW1iceWgB47wSUhG_hYA48JWtOPRrVRnL-EvRCxhBA@mail.gmail.com>
In-Reply-To: <CAOZdJXXHGW1iceWgB47wSUhG_hYA48JWtOPRrVRnL-EvRCxhBA@mail.gmail.com>
From:   jim.cromie@gmail.com
Date:   Mon, 6 Mar 2023 22:10:54 -0700
Message-ID: <CAJfuBxy=QKPfR=OEW5ZoUz9_9MWotJnu3CKWknuhGDNOCf7Whw@mail.gmail.com>
Subject: Re: [PATCH v6 32/57] nouveau: adapt NV_DEBUG, NV_ATOMIC to use DRM.debug
To:     Timur Tabi <timur@kernel.org>
Cc:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        daniel.vetter@ffwll.ch, linux@rasmusvillemoes.dk,
        seanpaul@chromium.org, joe@perches.com,
        Luis Chamberlain <mcgrof@kernel.org>
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

On Mon, Mar 6, 2023 at 11:50=E2=80=AFAM Timur Tabi <timur@kernel.org> wrote=
:
>
> On Sun, Sep 4, 2022 at 4:48 PM Jim Cromie <jim.cromie@gmail.com> wrote:
> >
> > These 2 macros used drm_debug_enabled() on DRM_UT_{DRIVER,ATOMIC}
> > respectively, replace those with drm_dbg_##cat invocations.
> >
> > this results in new class'd prdbg callsites:
> >
> > :#> grep nouveau /proc/dynamic_debug/control | grep class | wc
> >     116    1130   15584
> > :#> grep nouveau /proc/dynamic_debug/control | grep class | grep DRIVER=
 | wc
> >      74     704    9709
> > :#> grep nouveau /proc/dynamic_debug/control | grep class | grep ATOMIC=
 | wc
> >      31     307    4237
> > :#> grep nouveau /proc/dynamic_debug/control | grep class | grep KMS | =
wc
> >      11     119    1638
> >
> > the KMS entries are due to existing uses of drm_dbg_kms().
> >
> > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
>
> Has this patch set been forgotten?  It was posted six months ago and
> there's no sign that it was picked up.

Not forgotten, but chicken-egg problems with initializing prdbgs/drm-dbgs
in drm.ko & dependent drivers pushed it down in priority.
I have a fix for them, which needs Jasons "lets use notifier-chain" patches=
,
which is now in Luis' modules-next.

After that fix lands, I can revisit this one.

> The changes to drm_debug_enabled have impacted NV_DEBUG and NV_ATOMIC
> and something needs to be fixed.  I posted a simpler patch a few weeks
> ago, but maybe Jim's is better.

I couldnt find it on lore, can you post a link ?

But I do recall something about chatty logs, caused by

#define drm_debug_enabled_instrumented(category)                        \
        ({                                                              \
                pr_debug("todo: is this frequent enough to optimize ?\n"); =
\
                drm_debug_enabled_raw(category);                        \
        })

If thats the case, it does seem to be frequent enough to silence.

Before you do so, could you turn on the "mfl" flags,
and count occurrences of each callsite ?

echo module nouveau +mfl > /proc/dynamic_debug/control

the numbers and duration of enablement would inform any optimization,
including those available in the subject patchset.

thanks,
Jim
