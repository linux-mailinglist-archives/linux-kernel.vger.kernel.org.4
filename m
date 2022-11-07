Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3030C61FF96
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 21:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbiKGUdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 15:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbiKGUdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 15:33:38 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AB6286C4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 12:33:36 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id g10so7922838qkl.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 12:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tQ12e4GxkKyFcKEY5nkb37j7G30vKsrEMR9/r8hrDJ0=;
        b=qOA73a9Bu14wWQY9g3t4J1/QCrXaAC0kVgEP7vGn7s/hrSLZK1U5lSJdfg2csQ6fAK
         WwKqBdSf89jpNfxi2VzukRNviRsgtuVPSIMhup7OeZHHqpG5OSPrl0DXf4dSSli7uiim
         1ggrG3Hq8LIxqvz5HH/ip0y8FBKwNlk3dMGK1cun8A4sMzX7BcASPDkxk6Hv40GJeJKZ
         DOcJVRMK545RBtSxA+LQdBLupe342yB1UI515gfRhUBaglQQy2nwZvBfUqR91ayy8M3G
         Tu5CcIwxmd643GZbxFCoCcwmyLvUtWsgpSCNRPmH9VR8qa7ZtAhGUPAO7GhyZU8nkYmk
         ctpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tQ12e4GxkKyFcKEY5nkb37j7G30vKsrEMR9/r8hrDJ0=;
        b=VNcaUp3rx75JmOidsB56NXJTz4ZunyxGHP8aUIOE6NePNdzCW5FcjPJrJ6d/ZdhoRx
         g5k6m9RYgsrDIxr1JWy5HZ2nPWtG9nXkEYwYmee9qMr2LOVoRPkb8r7sk/lL1hgLjKpf
         385nydCdWwJWmsXd0nTbjJRW2Cer5KMJZEYk1P8I7H0y8SofrU9BCxizc+dNVSiVtsq6
         iRUuJdRsDov6s9Kx2aNgHr6+1gMBSHfVZARvjqnrmvIJW6v4P8mAjrk5nRNyEOvTh4Ks
         c+J8Hw5gI9SRBxy4/EnkAs0cDXoc2kqLvVs6wS7XekkzIwa8be1GFAOtZLFeKdxVdEO8
         6MOA==
X-Gm-Message-State: ACrzQf0nWS6ka5wyeEFb8f212TVLa7M99lAr3QTSS/Ar9Fnrb0opPRfw
        fbwTmzat1apzMQtyOSizds5Md6Z+E+C0FHIUEn0=
X-Google-Smtp-Source: AMsMyM6W0Bmt/046gPuBut+yT3A+X2p6Q2Q0RhxhI78tSZHtV+jn2n9Nhb0DbPX1ACdKiqOWowMD95Cq0zllpC3GhtI=
X-Received: by 2002:a05:620a:1009:b0:6fa:1245:ce4 with SMTP id
 z9-20020a05620a100900b006fa12450ce4mr37596615qkj.483.1667853215067; Mon, 07
 Nov 2022 12:33:35 -0800 (PST)
MIME-Version: 1.0
References: <20221102203405.1797491-2-ogabbay@kernel.org> <Y2MMCIe5wND2XPqE@kroah.com>
 <CAFCwf13uLj=P6u6FAcY8M5qAXoaBdb+Ha-TYj0j2FAZnFAPFYg@mail.gmail.com>
 <CAFCwf12yRUG4593ozJMEwaaJBKyWqXTTCjef9O_fzWdQBxVrtw@mail.gmail.com>
 <Y2kAcCu4z2LUMN7u@nvidia.com> <CAFCwf10K-dTu455QfOK8i6thismY-FUN2Rws830EGiqOcGWFgA@mail.gmail.com>
 <Y2kDzPswkKyZyRpS@nvidia.com> <CAFCwf10A=-bj2nR8WasNxyQQ07D24Je04tzKxqv2X_XnA0BUSQ@mail.gmail.com>
 <Y2kRvyR8VrZrO/1H@nvidia.com> <CAFCwf12E4K7bpLcDvTtG1mKxoy1JnchXGCKDvcKAayCFvGWXXQ@mail.gmail.com>
 <Y2kyvswuCsO0x1/2@nvidia.com>
In-Reply-To: <Y2kyvswuCsO0x1/2@nvidia.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Tue, 8 Nov 2022 06:33:23 +1000
Message-ID: <CAPM=9twxu3v4voSukrkror1BrajShRLY9CFxYWpL2rwK7fMiKQ@mail.gmail.com>
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

> > >
> > > "drm_minor" is not necessary anymore. Strictly managing minor numbers
> > > lost its value years ago when /dev/ was reorganized. Just use
> > > dynamic minors fully.
> > drm minor is not just about handling minor numbers. It contains the
> > entire code to manage devices that register with drm framework (e.g.
> > supply callbacks to file operations), manage their lifecycle,
> > resources (e.g. automatic free of resources on release), sysfs,
> > debugfs, etc.
>
> This is why you are having such troubles, this is already good library
> code. You don't need DRM to wrapper debugfs APIs, for instance. We
> have devm, though maybe it is not a good idea, etc
>
> Greg already pointed out the sysfs was not being done correctly
> anyhow.
>
> I don't think DRM is improving on these core kernel services. Just use
> the normal stuff directly.

At plumbers we decided a direction, I think the direction is good, if
there is refactoring to be done, I'd rather it was done in tree with a
clear direction.

Coming in now and saying we should go down a different path isn't
really helpful. We need to get rolling on this, we have drivers that
want to land somewhere now, which means we need to just get a
framework in place, leveraging drm code is the way to do it.

There is no need to an "accel" module, what does that even buy you,
the idea is to have an accel subsystem that allows drivers to use drm
features, not an accel subsystem that refactors drm features, that
would take years. There are already drivers for this subsystem wanting
to use GEM, and I don't think holding them up for a year to refactor
something that we don't have a clear reason or goal behind
refactoring.

If there is a problem with the drm subsystem interactions with the
kernel standard implementations then let's go fix that and accel will
also get fixed, but there's no reason to start going down that road at
the same time as introducing accel.

Also with the idr/xarray stuff, this isn't the patchset to be
introducing a bunch of new and divergent work, if this patchset
identifies deficiencies then let's document them and work on them in
parallel instead of blocking the initial landing in favour of some
future refactors with no in-tree users.

Dave.
