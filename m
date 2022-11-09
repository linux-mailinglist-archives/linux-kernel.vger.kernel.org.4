Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030E462248F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 08:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiKIHWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 02:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiKIHWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 02:22:38 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34591D658
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 23:22:36 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id fz10so9956545qtb.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 23:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EA4gK75UEv7H68JgXPxHNB0fDjmSTaahOFdjo3XrFNA=;
        b=g3l5uvyAvcAJvLdmk27RhvDggwIp0i4mpHA/5oGRdOk8dIqPnK10UtRDF3VF6a/HDv
         8n8QVq7TfTxz5eDCoTeARxhY+OOopb8sA1iJES6/XJs0df3Mo1Zi2dpUoEIhUZaZYM8P
         fr+gcQkDlWxXtm1dyGddsvP6lPISBFMtzx1hV8VqFED0sJoosNw/f3URUv2UCp4WHlyd
         raC7J5PNcgYp07SusQWOMS+7Slih5X9Ls6k6qum/6tNp5mRhi/Kfwh6CBNIjgQc1bYey
         nnHcBdKMP10EaGiNqY4M4LPOf+AhydaWSPpApsgILduFC2aRAdA4nEZBDSCKvZhRcdCR
         Aorw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EA4gK75UEv7H68JgXPxHNB0fDjmSTaahOFdjo3XrFNA=;
        b=5sORK0iHW0pvYxMJInb618PfeIBWUycMKm4ITDCyVI6UlADlmskY1c5x9ekR2vEQ+V
         Qm5H1QynLC7hN6j4a7DhavazEDx4SDgAyR0gazPpWimeTW3Z3HNgGCwZkEGwn8QsGmVn
         1kvZOLywNO2goU4zs50HrbuRlATUzuagxCgv1TBLwl8gj99VrfEX/QoR+EKhRiW7ir2h
         Oj9BkpwTcLXzrDcK3jrO3o9QGarGr5KzK9JkhFrhuOPyO2Dv8jfeIinFUP0MPQpVvl1L
         XV5lSNhc9tMtF9PUd7LO1Fi5UmPmyPxSN1JNAm6nFyqw7NApu3Qx23C3i4XOZdOxKr6J
         OFmg==
X-Gm-Message-State: ANoB5pkIIE4xkk/5nLyju6nsoo+HU21LnG5NfKzIG0fEFeEyr6h4UkcO
        vnU7xtGK2CRMy4IPO5ZRaqONicNo6rk/eDUhXuU=
X-Google-Smtp-Source: AA0mqf6Bq8H/a3oW2aQP8DBJuI2chSLhNJPP2yxLmIgM74bfU6Pjkdnd+5hWjTC1pyJUbXghNArbOOXfk94hIxvDdgA=
X-Received: by 2002:a05:622a:1c1:b0:3a5:8416:690d with SMTP id
 t1-20020a05622a01c100b003a58416690dmr12974134qtw.61.1667978555763; Tue, 08
 Nov 2022 23:22:35 -0800 (PST)
MIME-Version: 1.0
References: <CAFCwf13uLj=P6u6FAcY8M5qAXoaBdb+Ha-TYj0j2FAZnFAPFYg@mail.gmail.com>
 <CAFCwf12yRUG4593ozJMEwaaJBKyWqXTTCjef9O_fzWdQBxVrtw@mail.gmail.com>
 <Y2kAcCu4z2LUMN7u@nvidia.com> <CAFCwf10K-dTu455QfOK8i6thismY-FUN2Rws830EGiqOcGWFgA@mail.gmail.com>
 <Y2kDzPswkKyZyRpS@nvidia.com> <CAFCwf10A=-bj2nR8WasNxyQQ07D24Je04tzKxqv2X_XnA0BUSQ@mail.gmail.com>
 <Y2kRvyR8VrZrO/1H@nvidia.com> <CAFCwf12E4K7bpLcDvTtG1mKxoy1JnchXGCKDvcKAayCFvGWXXQ@mail.gmail.com>
 <Y2kyvswuCsO0x1/2@nvidia.com> <CAPM=9twxu3v4voSukrkror1BrajShRLY9CFxYWpL2rwK7fMiKQ@mail.gmail.com>
 <Y2pLYxW8p0QeiV+3@nvidia.com>
In-Reply-To: <Y2pLYxW8p0QeiV+3@nvidia.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Wed, 9 Nov 2022 17:22:23 +1000
Message-ID: <CAPM=9ty6oX9wp7XD6qgZxaXs8HRAtVioWAO-_GSr3Lf0m4NXtA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/3] drivers/accel: define kconfig and register a
 new major
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Oded Gabbay <ogabbay@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel@ffwll.ch>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        John Hubbard <jhubbard@nvidia.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Jiho Chu <jiho.chu@samsung.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>,
        stanislaw.gruszka@intel.com
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

On Tue, 8 Nov 2022 at 22:28, Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Tue, Nov 08, 2022 at 06:33:23AM +1000, Dave Airlie wrote:
>
> > At plumbers we decided a direction, I think the direction is good, if
> > there is refactoring to be done, I'd rather it was done in tree with a
> > clear direction.
> >
> > Coming in now and saying we should go down a different path isn't
> > really helpful. We need to get rolling on this, we have drivers that
> > want to land somewhere now, which means we need to just get a
> > framework in place, leveraging drm code is the way to do it.
>
> It is not a different path, at plumbers we decided accel should try to
> re-use parts of DRM that make sense. I think that should be done by
> making those DRM parts into libraries that can be re-used, not by
> trying to twist DRM into something weird.

There isn't much twisting here, the thing is this is just the code for sharing,
there isn't going to be mountains more. This code gives accel drivers access
to a lot of things. Refactoring it out will take a year or so, and I don't think
buys us anything.

>
> If this thing needs special major/minor numbers, it's own class, its
> own debufs, sysfs, etc, then it should not be abusing the DRM struct
> device infrastructure to create that very basic kernel infrastructure.
>
> Somehow we ended up with the worst of both worlds. If you want to to
> be DRM then it should just be DRM and we shouldn't see all this core
> infrastructue code for debugfs/sysfs/cdevs/etc in thes patches at all.

We can refactor this out even clearer in the long run if it needs to,
but you are overly focusing on the small picture of these patches and
not the larger sharing this enables.

At this point I'm going to be merging close to what we have here, so
we can move forward with getting some drivers lined up.

Dave.
