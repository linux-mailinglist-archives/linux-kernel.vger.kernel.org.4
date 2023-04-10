Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98AD56DCB43
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 21:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjDJTBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 15:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjDJTBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 15:01:32 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563B610DA;
        Mon, 10 Apr 2023 12:01:31 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id i10-20020a4ad68a000000b0053b8aa32089so843651oot.5;
        Mon, 10 Apr 2023 12:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681153290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YA1oDxKqPlucgkchnpNsPOW/R7uhWJLrBrmfaiPq5Zo=;
        b=HRgQGtTHNz/Pgr7l5cwUq9OicczD7PlbbLDbbtiWuqLZqJ2pOmwGe91v9Ks+1kg8n/
         G1oIoHGkGYLU5+lgeYBVsysWTSZj2m08a77H9d/oDYbqzv/cWMo4V387+oRifE4CCWZV
         rnvide6GUZiPtrdzpQBHgoSly4L7GY219XW9O06QfBrlfvu7NFq8yTAFfVRg13qLRIsV
         4Am6lw9U1VsFkRltK04Um90m8RIZYf/347GUc3pFsJitahPPGhElGVbjzRPMP96eHY+m
         8apOGTuUyhNUS9x/yThOd6Qep4XdCnbtI096DoYlRTGTeXzllJSR8AiEu0a10/4Pkif2
         6NtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681153290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YA1oDxKqPlucgkchnpNsPOW/R7uhWJLrBrmfaiPq5Zo=;
        b=oFT6sNF0E2eWRzZGZl4H1f8J30PQ4s+YzRjgMUbzUuG5F3wpxoVwFEY8jzxgF06fHv
         MgXkyldxA04Ys/R39ZeeWLW/NagjgPEapTRT1S6YfOP9sDx8oz85emYmAyg8aWAgx1vZ
         MS/RQ9EKYoENughhhz2PZvzpjlMau9zEhrO2rnf8OjU6jFS7VnPecYFcFlPAFttTUzNS
         SrXc2Okr5+90n9RqUNkqTRJjBhLUI2fdlj8NJ1owfSul0S6NLc7M36t6cMtMQJ2hYVXB
         ZipDWeM7zOVQNLOmdXQJzjIekI3C3FVOdXr4A+kGvhg7/LbAmG3N4U0fhXDBF1aDm9qq
         kOFA==
X-Gm-Message-State: AAQBX9cqfuU7CC4P0PNizOol50EcZ0rjgpajJ4sSP0FfnKX3bpJ6ccYc
        z6Q9eIqNoDCQy0lSPeLQkkW22IBJ4xplrlprDN0=
X-Google-Smtp-Source: AKy350Y+BZTSG4+KMyMj+jH5Xa47NJsPPHVKNdIX3bHK8JgZanUHLbm/3toXbUIzP5woyR3GYsRv8hPNs7jOZr0Zzns=
X-Received: by 2002:a4a:4248:0:b0:541:c42f:2f04 with SMTP id
 i8-20020a4a4248000000b00541c42f2f04mr2203237ooj.1.1681153290350; Mon, 10 Apr
 2023 12:01:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230406215917.1475704-1-robdclark@gmail.com> <20230406215917.1475704-2-robdclark@gmail.com>
 <CACvgo50nOw-82pc2mEbydWH3=RDXuOKwnBnjmOhV-UYcbjRKQA@mail.gmail.com>
In-Reply-To: <CACvgo50nOw-82pc2mEbydWH3=RDXuOKwnBnjmOhV-UYcbjRKQA@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 10 Apr 2023 12:01:18 -0700
Message-ID: <CAF6AEGuesqsWQEsEOwriaNC_1TkWoJ-d=mrrUgV9CoPXMftJVQ@mail.gmail.com>
Subject: Re: [RFC 1/2] drm: Add fdinfo memory stats
To:     Emil Velikov <emil.l.velikov@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-arm-msm@vger.kernel.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Christopher Healy <healych@amazon.com>,
        open list <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 8, 2023 at 5:20=E2=80=AFAM Emil Velikov <emil.l.velikov@gmail.c=
om> wrote:
>
> Hey Rob,
>
> On Thu, 6 Apr 2023 at 22:59, Rob Clark <robdclark@gmail.com> wrote:
>
> > +- drm-purgeable-memory: <uint> [KiB|MiB]
> > +
> > +The total size of buffers that are purgable.
>
> s/purgable/purgeable/
>
>
> > +static void print_size(struct drm_printer *p, const char *stat, size_t=
 sz)
> > +{
> > +       const char *units[] =3D {"B", "KiB", "MiB", "GiB"};
>
> The documentation says:
>
> > Default unit shall be bytes with optional unit specifiers of 'KiB' or '=
MiB'
> > indicating kibi- or mebi-bytes.
>
> So I would drop the B and/or update the documentation to mention B && GiB=
.
>
> > +       unsigned u;
> > +
> > +       for (u =3D 0; u < ARRAY_SIZE(units) - 1; u++) {
> > +               if (sz < SZ_1K)
> > +                       break;
> > +               sz /=3D SZ_1K;
>
> IIRC size_t can be 64bit, so we should probably use do_div() here.
>
> > +       }
> > +
> > +       drm_printf(p, "%s:\t%lu %s\n", stat, sz, units[u]);
> > +}
> > +
> > +/**
> > + * drm_print_memory_stats - Helper to print standard fdinfo memory sta=
ts
> > + * @file: the DRM file
> > + * @p: the printer to print output to
> > + * @status: callback to get driver tracked object status
> > + *
> > + * Helper to iterate over GEM objects with a handle allocated in the s=
pecified
> > + * file.  The optional status callback can return additional object st=
ate which
>
> s/return additional/return an additional/

"an" reads funny to me, as the state is plural (bitmask).. but agreed
on the other things

> > + * determines which stats the object is counted against.  The callback=
 is called
> > + * under table_lock.  Racing against object status change is "harmless=
", and the
> > + * callback can expect to not race against object destroy.
>
> s/destroy/destruction/
>
> > + */
> > +void drm_print_memory_stats(struct drm_file *file, struct drm_printer =
*p,
> > +                           enum drm_gem_object_status (*status)(struct=
 drm_gem_object *))
> > +{
>
> > +               if (s & DRM_GEM_OBJECT_RESIDENT) {
> > +                       size.resident +=3D obj->size;
> > +                       s &=3D ~DRM_GEM_OBJECT_PURGEABLE;
>
> Is MSM capable of marking the object as both purgeable and resident or
> is this to catch other drivers? Should we add a note to the
> documentation above - resident memory cannot be purgeable

It is just to simplify drivers so they don't have to repeat this
logic.  Ie. an object can be marked purgeable while it is still active
(so it will be eventually purgeable when it becomes idle).  Likewise
it doesn't make sense to count an object that has already been purged
(is no longer resident) as purgeable.

BR,
-R

> > +               }
> > +
> > +               if (s & DRM_GEM_OBJECT_ACTIVE) {
> > +                       size.active +=3D obj->size;
> > +                       s &=3D ~DRM_GEM_OBJECT_PURGEABLE;
>
> Ditto.
>
> With the above nits, the patch is:
> Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
>
> HTH
> Emil
