Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690206F1A7C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 16:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjD1O3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 10:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjD1O3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 10:29:42 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FE91BEE;
        Fri, 28 Apr 2023 07:29:40 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-5476a2780a0so4595054eaf.3;
        Fri, 28 Apr 2023 07:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682692180; x=1685284180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYzqB28RMSFODBuTMB/KY5cl7Tjsfy3OkCWgNjZ6ZLE=;
        b=kh97gIflH3BI4ERsMSHvjFc0yOO2bt2fLm/uIbDsDrqqCu8s1sBxd1qDVEdBRIXaVx
         iL5RpT2zMNzyg+NFwLpVdMi4AybUyNQoR4/KTIyCNQ6rbL1F0DeQ5KmZHZmRbVrbxMMI
         EVvL2F+CnVM44ANsh30EStkooMTY3pgBJcPpfXLKde2v/nu6v57pykRxydjH1nTW2/FA
         TfRXpk1QRjR02exKoXYK2MUCINulVfTlZ+sUo+7AckhEWV6lOlDp77IYs7xS8lGE0Ir4
         PzdyIuMruilIAnr8RxZgmYIczOd6F8olt3vtZ53rzCG7Ai88S1HDJjafAmDY7EMzhuzg
         t0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682692180; x=1685284180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lYzqB28RMSFODBuTMB/KY5cl7Tjsfy3OkCWgNjZ6ZLE=;
        b=MWmUCjKe7xfzVYh1vNOYIdjUgz3AD5meYKS1aNgGxs9CA1N9HdDvHyxszFZI6dbDfj
         PgNY5HOy2reKj5sIXjsgOvOttcsb3dTC+/LmfUr1l8Y+IQ8T64Ka/27ZD8j/9VJlE0b/
         TgWGI6bllc+unwodaF4ONDdHe0Ch/olwkkhw8DCbjvx8reMF/Vr3TIRR/VSolxQ3mLuf
         U7Xc2mt202AmarOYFbWrswZ02nZCAuyeTyGITu5hmceD6e5+7FZZGhQxRt9E1YlK+r6t
         h00kosi3HMa1A06hKwO8SJ7eoLQ4wda4rH/yXtd4kqdaAbioBuWBoIpcuYzznPmS/nBQ
         S8Lw==
X-Gm-Message-State: AC+VfDznPb+X3KBwEPuk8P4i/GA2MVfYVz+SlButIJJPizB0DXy2n18J
        tA8QOy1PouqisWsB1/m2vnwzBrplJ05nep8ath0=
X-Google-Smtp-Source: ACHHUZ5KCaCwW1hvzW8OWPVzp040UD7tuDkE/lZ6cadmhT2Hjv5r9AbIl/f2DmSYTc/uRNg/F3c8gxInAbFvh4+1rRI=
X-Received: by 2002:a05:6808:5da:b0:38e:e0c3:5cce with SMTP id
 d26-20020a05680805da00b0038ee0c35ccemr2440343oij.18.1682692180051; Fri, 28
 Apr 2023 07:29:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230427175340.1280952-1-robdclark@gmail.com> <20230427175340.1280952-2-robdclark@gmail.com>
 <0be60cda-6b8b-5844-c4fe-b711e7279cc7@amd.com>
In-Reply-To: <0be60cda-6b8b-5844-c4fe-b711e7279cc7@amd.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Fri, 28 Apr 2023 07:29:28 -0700
Message-ID: <CAF6AEGtd=fP1_JnD6-V7U_ZNnD1VG-rZean6mNDTLHsqZJdeYw@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] drm/docs: Fix usage stats typos
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Christopher Healy <healych@amazon.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 1:50=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 27.04.23 um 19:53 schrieb Rob Clark:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Fix a couple missing ':'s.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Since this is a pretty clear fix I suggest to get this pushed to reduce
> the number of patches in the set.

Thanks, this is fine by me if someone wants to push it for me.  Note
that the later .rst updates in this series depend on this so if/when
they are merged it probably should be the same tree

BR,
-R

> Christian.
>
> > ---
> >   Documentation/gpu/drm-usage-stats.rst | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/gpu/drm-usage-stats.rst b/Documentation/gpu/=
drm-usage-stats.rst
> > index b46327356e80..72d069e5dacb 100644
> > --- a/Documentation/gpu/drm-usage-stats.rst
> > +++ b/Documentation/gpu/drm-usage-stats.rst
> > @@ -105,7 +105,7 @@ object belong to this client, in the respective mem=
ory region.
> >   Default unit shall be bytes with optional unit specifiers of 'KiB' or=
 'MiB'
> >   indicating kibi- or mebi-bytes.
> >
> > -- drm-cycles-<str> <uint>
> > +- drm-cycles-<str>: <uint>
> >
> >   Engine identifier string must be the same as the one specified in the
> >   drm-engine-<str> tag and shall contain the number of busy cycles for =
the given
> > @@ -117,7 +117,7 @@ larger value within a reasonable period. Upon obser=
ving a value lower than what
> >   was previously read, userspace is expected to stay with that larger p=
revious
> >   value until a monotonic update is seen.
> >
> > -- drm-maxfreq-<str> <uint> [Hz|MHz|KHz]
> > +- drm-maxfreq-<str>: <uint> [Hz|MHz|KHz]
> >
> >   Engine identifier string must be the same as the one specified in the
> >   drm-engine-<str> tag and shall contain the maximum frequency for the =
given
>
