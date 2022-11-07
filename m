Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F188A61FF6F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 21:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbiKGUSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 15:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbiKGUSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 15:18:37 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54C314D15
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 12:18:34 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id c15so7557797qtw.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 12:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NhhjPI8PeKyeQTLHpd35qfaAH6UqB+dSFDo9Mc6Wxkw=;
        b=mIXKOpX5fM3HKKeOe493jDQzWp5+uLEewv3FgLRoOMLOB0cb+gILRzKR4sNN7USvTY
         CPmBTY8MZUUeZItAf24N+CY4tuvRP+cF2f2DdNuu1YaQBZ5RneyXJMXB7kIAmdQokGAn
         8uQ65uDwe2SALzNfqJNYiA1Qc4kJkzkZI2R4FqjijZIbBVKxc0gW9EpppldIQ1RGmqhQ
         Fq2AQYevgCzTcsjZTs4AWCarga+hiCH/ek5Ad4sCkvoFckm9MIvqOGPz2LJac3zvs5MI
         ntCF5cUIAFJGjXQ85bT/8GRpM+3tZoKQDg2BYFVVwOKPB3MNN2uCtOQTWGdX4XvQcU73
         Mg8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NhhjPI8PeKyeQTLHpd35qfaAH6UqB+dSFDo9Mc6Wxkw=;
        b=CRJQK5JQ8hD8u1gF2fUiyRpZQ2lDvLHdBi805H+ToOBUoCh2sBw3rv4NKOy11Ay2oC
         ao7e6t1p/H9JeOWfAsoiUYHYbfgZ7ILan9IBtwArTbEjD+4sMLfITXLFjawnLKy1yTvD
         6q2TGMjJ+v/mhGMYtGu/xR4+uZal71du5ivE7Dzx6WAJCEBqTVJoggRRXB0tJJ+tM0YC
         HUMRT0KmRkuIKOiPxypWKBeE5DwsOb3JcN5zF5w+W22qnIkadwOx+8QoHEuW96s95g7s
         2ZkbcXuzYSTWVqWSQ2X12dtZEZ3LKjPzwQmOynT/Hp16VTjMALQNrfgOSMh+8ySEpDSf
         GyuQ==
X-Gm-Message-State: ANoB5pkErVSjjTry4pY9D2wx6BWrC6uc4cHKXQxkx6UoG+eXJ/AHEtlx
        VuJiDVmlSZ5jmDFIdfuoNJzYxf5wnoaCvaaXaH8=
X-Google-Smtp-Source: AA0mqf7jOU63BklyhiJ1pUeKEtHV4hBzufzAPnYS2tHwuQ4GGbGmAjvVk/B4zJOlJvMXb8FwUwvp2AUuo1DiMMpqHMs=
X-Received: by 2002:a05:622a:1c1:b0:3a5:8416:690d with SMTP id
 t1-20020a05622a01c100b003a58416690dmr6991039qtw.61.1667852313679; Mon, 07 Nov
 2022 12:18:33 -0800 (PST)
MIME-Version: 1.0
References: <20221102203405.1797491-1-ogabbay@kernel.org> <20221102203405.1797491-2-ogabbay@kernel.org>
 <Y2MMCIe5wND2XPqE@kroah.com> <CAFCwf13uLj=P6u6FAcY8M5qAXoaBdb+Ha-TYj0j2FAZnFAPFYg@mail.gmail.com>
 <CAFCwf12yRUG4593ozJMEwaaJBKyWqXTTCjef9O_fzWdQBxVrtw@mail.gmail.com>
 <Y2kAcCu4z2LUMN7u@nvidia.com> <CAFCwf10K-dTu455QfOK8i6thismY-FUN2Rws830EGiqOcGWFgA@mail.gmail.com>
 <Y2kDzPswkKyZyRpS@nvidia.com>
In-Reply-To: <Y2kDzPswkKyZyRpS@nvidia.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Tue, 8 Nov 2022 06:18:21 +1000
Message-ID: <CAPM=9tyP6mfEDzZ9wUdJc_0YTNk2HyvB62qF74ZkiYfdOx3opw@mail.gmail.com>
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

On Mon, 7 Nov 2022 at 23:10, Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Mon, Nov 07, 2022 at 03:01:08PM +0200, Oded Gabbay wrote:
> > I don't agree with your statement that it should be "a layer over top of DRM".
> > Anything on top of DRM is a device driver.
> > Accel is not a device driver, it is a new type of drm minor / drm driver.
>
> Yeah, I still think this is not the right way, you are getting almost
> nothing from DRM and making everything more complicated in the
> process.

You are looking at the small picture that is these patches, there are
just infrastructure to start the process of merging drivers and
reusing other parts of the drm code.

We aren't going to ever get anywhere if we start splitting code out of
drm just in case, we get this stuff rolling in the tree and if we have
a pressing need to refactor it out into separate libraries later then
we can address that from a more educated place, instead of just
throwing huge refactors around before we have any code to even use
them.
>
> IMHO this is much better, because accel has very little need of DRM to
> manage a struct device/cdev in the first place.

Right now it doesn't, but when drivers start leveraging the other code
it will reuse a lot more code.

I'm not going to spend too much time entertaining this, devm vs drmm
memory etc are real problems drm has already identified if not
completely solved.

Dave.
