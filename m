Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6DF609B2E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 09:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiJXHU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 03:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiJXHUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 03:20:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A3B167D7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 00:20:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF5B561036
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 07:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64FF6C433B5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 07:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666596020;
        bh=Ty9NkDJERk08rww6GWq0fv6JMZmjA9hkVm/1UTl6Gew=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=soqKKgIavXRhZ62v8koldR2f0U/tPr0CABp32vpxSlg6ct7kFsnJAPq3QCgK1kqvB
         MfxxSqO5E/C2Iy8fnf1d5VLTjSgELqca6fy+mfKH12YIK7VoHtBJ06LErJ6GmYxo0p
         LqHByjU05gCnWf+JyfowGoVSU6sO+87IZ1k+MPAD7PB3vb1mg8NETVZm2zDSpUb5pQ
         17X3kKHscLx83fm1GtQqq7f/Q89OzWSvllIjNb9THemBlK2bFCpwh+Sti4E0klVi1s
         J38ZYW54812l4J39xsMgVrtJfNlk2s8+b2aTQcupKA6l4rAVsshi9YbFEP/hwmOpqS
         1I0xgORQrgwtQ==
Received: by mail-ed1-f50.google.com with SMTP id z97so27773517ede.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 00:20:20 -0700 (PDT)
X-Gm-Message-State: ACrzQf3ktvxkBSD/EJ4n+rm8sCjqpx4OBD2ilHdRah9Ay82nOMxliS+T
        6yudQtvmBXYSxyOA2TbblvexDws9V9p24IUl4fQ=
X-Google-Smtp-Source: AMsMyM4TqziqZFrPulpnYOMDfvg5oeGxMZ+ThBB4Hrbl8U9QezIK7K/8pKnOjFAowp0Rgwci0DgtpbzSguFKiCXw6sM=
X-Received: by 2002:a17:907:3205:b0:770:8554:c4ee with SMTP id
 xg5-20020a170907320500b007708554c4eemr26613904ejb.39.1666596018653; Mon, 24
 Oct 2022 00:20:18 -0700 (PDT)
MIME-Version: 1.0
References: <20221022214622.18042-1-ogabbay@kernel.org> <20221022214622.18042-2-ogabbay@kernel.org>
 <Y1U2Sy3hHmYfveaD@kroah.com>
In-Reply-To: <Y1U2Sy3hHmYfveaD@kroah.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Mon, 24 Oct 2022 10:19:52 +0300
X-Gmail-Original-Message-ID: <CAFCwf11RLTsd2bfc3SoKVKDthVPJ9tbiYjsKPnkTfjFp5djeSg@mail.gmail.com>
Message-ID: <CAFCwf11RLTsd2bfc3SoKVKDthVPJ9tbiYjsKPnkTfjFp5djeSg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] drivers/accel: add new kconfig and update MAINTAINERS
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Jason Gunthorpe <jgg@nvidia.com>,
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
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 23, 2022 at 3:40 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sun, Oct 23, 2022 at 12:46:20AM +0300, Oded Gabbay wrote:
> > Add a new Kconfig for the accel subsystem. The Kconfig currently
> > contains only the basic CONFIG_ACCEL option that will be used to
> > decide whether to compile the accel registration code as part of the
> > drm core functionality.
> >
> > I have taken the liberty to appropriate the dri-devel mailing list and
> > the dri-devel IRC channel for the accel subsystem.
> >
> > Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
> > ---
> >  MAINTAINERS           |  8 ++++++++
> >  drivers/Kconfig       |  2 ++
> >  drivers/accel/Kconfig | 24 ++++++++++++++++++++++++
>
> YOu never use drivers/accel/ again in this patch series, was that
> intentional?
Yes, because I didn't plan for accel to have any core code at this stage.
But according to your other comments, this will probably change
(unless someone thinks otherwise).
Oded
>
> thanks,
>
> greg k-h
