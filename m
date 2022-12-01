Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4AF63F9EF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 22:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiLAVgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 16:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbiLAVgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 16:36:46 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BE4C3591
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 13:36:45 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id h16so2710697qtu.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 13:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=quISd2pvnqmw/9o3WvzMsMR0W9P1ncFjwjxtR6uCSwc=;
        b=Tsuz+a1y7dxwXx0w+7ppxovTf/QgqSilAje86IwDPKGmK9k6yZmBA8duaBYj7V8F4P
         QvzKrzA32dGkk3LlNOPgpK3qsFFMCZh5+iMix2N0HwM5YJqIYxwoRhioDi1dr3fXIGvn
         8sYlJ4PQLj/QsdfFN74H8i2QKJJOnvg8d3iG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=quISd2pvnqmw/9o3WvzMsMR0W9P1ncFjwjxtR6uCSwc=;
        b=y094zIgs7PSk4rB0PP/QF/g5i3gDzpigcljW6c+qhbHdE1NNuAlFkmYkGxwRqkBBnY
         hb61uqYlS8nQJoj0+ATJ9oqx32sBD3UrWnXVpV8TUlf+kPg/45UAdrv6iP7iAKvmvxrP
         EpsYwq2ktBCTainMRv05W0O2Hbos96BPX64dEKaYlgd6fk8Db5s3cdKDu12Je9YQEJk7
         I6PDBRk9+24ABO3mZJ9T52/dbAxRyfCVt43KgHttz7Tg40siNk0sVb5xWmve+OYACeaQ
         BSQg1P8+jW12oZ2C5g0aVs9xBVkQ3DrIZkZFuung9E9tvz9IAlTwJzl0CjoGpB8tpq5h
         s9ZQ==
X-Gm-Message-State: ANoB5pkpel0rbUsbmaSUBpSGxl2567Bz/1vlefikVpyod1g4huZ65dhx
        dvn6Q4dm5xednO/5/wVd0XmdEHdVrKYBpBVWo8PHoQ==
X-Google-Smtp-Source: AA0mqf5han2nODM1TVLqeIK1N63h/oWnWVnwyyUnaPkAUSrRFLX2YZBCX6cW18RsykD2s9X5bkAaSL3JHHPueJy019w=
X-Received: by 2002:a37:f509:0:b0:6fb:ff0f:e7e0 with SMTP id
 l9-20020a37f509000000b006fbff0fe7e0mr17496799qkk.747.1669930604365; Thu, 01
 Dec 2022 13:36:44 -0800 (PST)
MIME-Version: 1.0
References: <20221130231936.1666390-1-wonchung@google.com> <CACeCKad16bs_f6bLthTAoEL28tPvf1S10WDeM7ugeaS9g7R25w@mail.gmail.com>
 <CANLzEksD=dKgPuCUD74b3YQKCApbZKO_t7Q=tyNKONvAOQ89hw@mail.gmail.com>
In-Reply-To: <CANLzEksD=dKgPuCUD74b3YQKCApbZKO_t7Q=tyNKONvAOQ89hw@mail.gmail.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Thu, 1 Dec 2022 13:36:33 -0800
Message-ID: <CACeCKad7RGVPGdrd9WNpRhn3n99R5TG9zFJpCrMj7CDLK18rMA@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: Create new USB driver for RGB keyboard
 in ChromeOS devices
To:     Benson Leung <bleung@chromium.org>
Cc:     Won Chung <wonchung@google.com>, linux-kernel@vger.kernel.org,
        chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Benson,

On Thu, Dec 1, 2022 at 1:00 PM Benson Leung <bleung@chromium.org> wrote:
>
> Hi Prashant,
>
>
> On Thu, Dec 1, 2022 at 12:10 PM Prashant Malani <pmalani@chromium.org> wrote:
> >
> > Hi Won,
> >
> > On Wed, Nov 30, 2022 at 3:19 PM Won Chung <wonchung@google.com> wrote:
> > >
> > > Without any driver bound to RGB keyboard, it may not be suspended
> > > properly, preventing USB xHCI to be suspended and causing power drain.
> > > Create new USB driver for RGB keyboard so that it can be suspended
> > > properly.
> >
> > This seems like overkill. Can't you set this from USB's sysfs nodes
> > like power/control [1] ?
> >
> > [1] https://www.kernel.org/doc/html/latest/driver-api/usb/power-management.html#the-user-interface-for-dynamic-pm
> >
> >
> > Best regards,
> >
> > -Prashant
>
> We're seeing some behavior where a bound driver is needed in order for
> this USB device to properly enter suspend state. Just manipulating the
> power/control and other sysfs nodes for this usb device when there's
> no driver in the kernel doesn't seem to affect the device's ability to
> drop into a usb low power state.

That seems like an issue with the device then, which should be debugged
from the device side and/or its interaction with the USB subsystem.

>
> Also, I synced with Won about this offline, but the primary concern is
> not this prism usb device runtime suspending, it's actually it's
> ability to enter suspend state during system suspend. Right now, this
> internal usb device is keeping the whole system from entering lower
> S0iX states because it's not sleeping. This driver patch doesn't
> address that yet, but I'd like Won to dig down and see if he can get
> it suspending at suspend time too.

Auto-suspend / dynamic PM should take care of that FWIU (but I may be mistaken).
