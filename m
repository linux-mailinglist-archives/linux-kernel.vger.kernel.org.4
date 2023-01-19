Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1120B673AB0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 14:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjASNsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 08:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjASNsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 08:48:07 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8751B7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 05:47:55 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id e202so2488783ybh.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 05:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PSMpJcgB4/iWUNMRjULR1MuJgnZtYsNt64IxI/yg8y8=;
        b=eDVBeDp6HGMjUZ+KWIDom7Mh6Xqh62t/zpEx0yeX5zBGVXqKMMBK3817KAy67sh9Nu
         iLrH3wQEBzIwDR3pmWTeIW05HXE+IdMRth3fUg4NvViFR/tFTcPVuryHoWor1ecMPQyf
         IDuB5L5zwaIWMsEShLu285cRaoBklCKi/qxmw4JF/aYQVqyJFpX3yo0XryH/NmmnXnLx
         uzSjlPJi0ZlGcz4VezPnDnTedMDXRFquanUoDqjeUEp+4LTx0fpqaZncSfsK5p4D85KL
         ss20MK9rSaAgE7ODMwm7GbuSixRglGKENvSUegJqF9jVd7xzpFTAsnIr/GOrrnrHHR4H
         p6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PSMpJcgB4/iWUNMRjULR1MuJgnZtYsNt64IxI/yg8y8=;
        b=B6T4gIV2YQaPYnUhdW4OHF7A2MI8GxZirl0C0AyblQAISex2kal7nN4KwuznQmn2Be
         s8Dv6jfeIAIM/IIdii389Js0wLPrvPcKrWHr0JCOdGqEJYa80X6rWbHFbMixqj4XE5+f
         BhZ9K9r3XEJL7RWpfGUC46tQtrCQn30zk2ShH/LBHRWsYr61QBSW8ZqLSG6w2DqPKvae
         tjEIzCdIg93D859DzQIwAMztQiSIFxoM0wdCrTYDEdklDkbSuUpaG8tVh0v1Kb9JNTIs
         aNI3BT2f9jQcM+kA3A1GGmGv+v76kYCUueL3MpbfgkFLD2rK7ACmLIdC773+e+HXWmaK
         AGYA==
X-Gm-Message-State: AFqh2kq9DVlel7vB41sBX5BS413gBZ6iG4rVjR4lH5O7DzeTaHW0xkm5
        oZIaAsMIKUF+icB9Oh8xfc5qRVmXG1bz9ufGMPTD1Q==
X-Google-Smtp-Source: AMrXdXtrMjpr+dkPCI15Z1YrTq3vEIqG9HQKNS7sllyosNcJ1sz9FAEKCEyXXbIAukoxGI1iBD0VmTuYLITNqakQYJY=
X-Received: by 2002:a25:d1d0:0:b0:6f8:c792:bde9 with SMTP id
 i199-20020a25d1d0000000b006f8c792bde9mr1371077ybg.614.1674136074295; Thu, 19
 Jan 2023 05:47:54 -0800 (PST)
MIME-Version: 1.0
References: <20230118115810.21979-1-umang.jain@ideasonboard.com>
 <b1a26368-3753-0d32-434b-e220dd9c06b4@i2se.com> <CAMEGJJ1=dix7gWvV3Jxef-M-ExFZRTASQCr+6sn_dGsEQ=deYQ@mail.gmail.com>
 <Y8lHqd9FlxiXTLuW@kroah.com>
In-Reply-To: <Y8lHqd9FlxiXTLuW@kroah.com>
From:   Phil Elwell <phil@raspberrypi.com>
Date:   Thu, 19 Jan 2023 13:47:44 +0000
Message-ID: <CAMEGJJ1oZ9XFw0609PrEABAgDwvapbc3hG4hJ=vBekUOepdiWw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] Drop custom logging
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Umang Jain <umang.jain@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jan 2023 at 13:37, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jan 19, 2023 at 01:31:12PM +0000, Phil Elwell wrote:
> > Hi all,
> >
> >
> > On Wed, 18 Jan 2023 at 17:55, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> > >
> > > Hi Umang,
> > >
> > > [add Phil]
> > >
> > > Am 18.01.23 um 12:58 schrieb Umang Jain:
> > > > Drop custom logging from the vchiq interface.
> > > > Mostly of them are replaced with dev_dbg and friends
> > > > and/or pr_info and friends.
> > > >
> > > > The debugfs log levels (in 4/4) are mapped to kernel
> > > > logs levels (coming from include/linux/kern_levels.h)
> > > > Would like some thoughts on it as I am not sure (hence
> > > > marking this is RFC)
> > > >
> > > >  From drivers/staging/vc04_services/interface/TODO:
> > > >
> > > > """
> > > > * Cleanup logging mechanism
> > > >
> > > > The driver should probably be using the standard kernel logging mechanisms
> > > > such as dev_info, dev_dbg, and friends.
> > >
> > > i don't have any experience with vchiq logging/debug. So i'm not sure if
> > > it's acceptable to lose the second log level dimension (like
> > > vchiq_arm_log_level) completely. Complex drivers like brcmfmac have a
> > > debug mask to avoid log spamming [1]. Maybe this is a compromise.
> > >
> > > Btw some loglevel locations has already been messed up during
> > > refactoring :-(
> > >
> > > [1] - drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.h
> > >
> > > > """
> > > >
> > > > Umang Jain (4):
> > > >    staging: vc04_services: vchiq_core: Drop custom logging
> > > >    staging: vc04_services: vchiq_arm: Drop custom logging
> > > >    staging: vc04_services: Drop custom logging
> > > >    staging: vc04_services: Drop remnants of custom logging
> > > >
> > > >   .../interface/vchiq_arm/vchiq_arm.c           | 151 +++---
> > > >   .../interface/vchiq_arm/vchiq_connected.c     |   5 +-
> > > >   .../interface/vchiq_arm/vchiq_core.c          | 479 ++++++++----------
> > > >   .../interface/vchiq_arm/vchiq_core.h          |  39 --
> > > >   .../interface/vchiq_arm/vchiq_debugfs.c       |  26 +-
> > > >   .../interface/vchiq_arm/vchiq_dev.c           |  78 ++-
> > > >   6 files changed, 329 insertions(+), 449 deletions(-)
> > > >
> >
> > Thanks for the nudge - this patch set hasn't yet made its way through
> > the sluggish rpi-kernel moderation.
> >
> > I understand the desire to remove the custom logging. I don't welcome
> > the loss of flexibility that comes with such a strategy
>
> What "loss of flexibility"?  You now have access to the full dynamic
> debugging facilities that all of the rest of the kernel has.  What is
> lacking?

Perhaps I've missed something, either in this patch set or the kernel
as a whole, but how is one supposed to set different logging levels on
different facilities within a driver/module, or even for the module as
a whole? I don't consider anything that requires reference to
individual lines in the source code to be a suitable replacement,
clever though it is.

> > , but I'm not
> > going to argue about it. What's harder to understand is the state that
> > this patchset leaves VCHIQ logging in. From what I can see, the
> > per-service logging control has gone, but the code still contains
> > macros that hint at something useful. Similarly, the debugfs support
> > is completely vestigial, giving the appearance of control while
> > actually achieving nothing.
>
> The debugfs files should also be removed if they don't do anything
> anymore.
>
> thanks,
>
> greg k-h
