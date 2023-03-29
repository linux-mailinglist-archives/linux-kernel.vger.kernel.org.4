Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7345E6CEEB0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 18:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjC2QGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 12:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjC2QGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 12:06:33 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826F47ABC
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 09:05:37 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id h8so65401041ede.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 09:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680105889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nB7oKbT3cEdZv982N1zBkd0Ryl/IpZ2NkMoXbgDn468=;
        b=jxMA6QM9la8UP4NqAnSEAXBd+bAl2GXvlYv5NFdKYrKlh+kGEwWtlUpuQWVAl3uyWd
         3PqQx+TZ/aiOQmO/z+LZKF5BwE2kcbBbznmL9Yw+P690izJ45nhpv3cOyxpSHB6Wz0Pz
         ls5gi2P9/bYG3SfjL2LQ8arhCq5h8CocCIqT4pfnW9eaMNyG0/UES1Er6JQTd/aMoXMB
         fZFCTDzx/4NglskDdcFWUl5om7f195XfWtvwQWLS3oL9FvVzVc+h8t/hO2dI83Rs94ZL
         rUFIF4JbvUAco68oEsHEN1qXKmxno5kNX3KyI6BBGT+zbNCibIq3buiaNCsh7/d6Q4X4
         GmZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680105889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nB7oKbT3cEdZv982N1zBkd0Ryl/IpZ2NkMoXbgDn468=;
        b=s0ue+a2nF6bBmq+cG390T2fLVRgpug2+c15k1OQdnKvTDeCum958lBRLHTQvQiN6Fb
         60P0DRstW7tXQAvbQ/40z5daWJ1QRD/99RramnEtHwi5XxjEoFA9hN8Pv5PtWKavi96V
         J73tAjemADWMHTWtjBX2BYaejfkweeI4D2oOxmWrkIwdgIOOlOg2TifgxFCZdTEyk0If
         7qZaTD76dV1s1inLV/4/byC7TxF54/BO9HJBmSSwvCmFc6PULFqN46JtjWr6TDK4hEb6
         NEfZ1uo3iyECBwa619X7nIuYEJCfTE7r/DdhWjzcEshDrCcOM3Ct7uByFt7xX/I+JoNI
         I2Ww==
X-Gm-Message-State: AAQBX9dBz6ZJhUG2GdVdOJPvZkBHfJU4IBZKo/xErDQt/jLzvwm8XbmR
        vrU3w4i5yLIb04Nuj3XvdumPBvHKuJBjQiLqvGc=
X-Google-Smtp-Source: AKy350bERxif8R3/uq/8EtdDLtAHn6Xnhc/4ON9Mo1pql2b9GTT5tWBy0miS8RMnafwNn3Tr9VnUepwup+Iz6uiyzp4=
X-Received: by 2002:a50:9fef:0:b0:4fc:2096:b15c with SMTP id
 c102-20020a509fef000000b004fc2096b15cmr10258255edf.1.1680105889227; Wed, 29
 Mar 2023 09:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230328-soc-mailbox-v1-0-3953814532fd@marcan.st>
In-Reply-To: <20230328-soc-mailbox-v1-0-3953814532fd@marcan.st>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Wed, 29 Mar 2023 11:04:37 -0500
Message-ID: <CABb+yY2=B2p5JhZiBE_mZLe3y16EUgVsUHK62LnRgaKa1-ptLg@mail.gmail.com>
Subject: Re: [PATCH 0/5] mailbox: apple: Move driver into soc/apple and stop
 using the subsystem
To:     Hector Martin <marcan@marcan.st>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Janne Grunau <j@jannau.net>, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org
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

On Tue, Mar 28, 2023 at 8:14=E2=80=AFAM Hector Martin <marcan@marcan.st> wr=
ote:
>
> Once upon a time, Apple machines had some mailbox hardware, and we had
> to write a driver for it. And since it was a mailbox, it felt natural to
> use the Linux mailbox subsystem.
>
> More than a year later, it has become evident that was not the right
> decision.
>
> Linux driver class subsystems generally exist for a few purposes:
> 1. To allow mixing and matching generic producers and consumers.
> 2. To implement common code that is likely to be shared across drivers,
>    and do so correctly so correct code only has to be written once.
> 3. To force drivers into a "correct" design, such that driver authors
>    avoid common pitfalls.
>
The Mailbox subsystem is meant to serve (2) and possibly (3).
We never aimed for (1), we can't... because the firmware on the remote
end is also a part of "local hardware" -- keeping every bit of
hardware the same, if just the f/w changes you may have to change the
linux side driver.


> The mailbox subsystem does not do any of the above for us:
> 1. Mailbox hardware is not generic; "mailbox" is a vague idea, not a
>    standard for communication.
>
There _can not_ be a standard mailbox implementation without a
specification -- which doesn't exist.

>  Almost all mailbox consumers are tied to
>    one or a few producers. There is practically no mixing and matching
>    possible. We have one (1) consumer subsystem (RTKit) talking to one
>    (1) mailbox driver (apple-mailbox). We might have a second consumer
>    in the future (SEP), but there will still be no useful
>    combinatronics with other drivers.
>
Sorry I don't follow what you expect.

> 2. The mailbox subsystem implements a bunch of common code for queuing,
>    but we don't need that because our hardware has hardware queues. It
>    also implements a bunch of common code for supporting multiple
>    channels, but we don't need that because our hardware only has one
>    channel (it has "endpoints" but those are just tags that are part of
>    the message).
>
In note-1, you complain it is not standard/flexible enough, and here
its support for features, that you don't need, become a problem?


> On top of this, the mailbox subsystem makes design
>    decisions unsuitable for our use case. Its queuing implementation
>    has a fixed queue size and fails sends when full instead of pushing
>    back by blocking, which is completely unsuitable for high-traffic
>    mailboxes with hard reliability requirements, such as ours. We've
>    also run into multiple issues around using mailbox in an atomic
>    context (required for SMC reboot/shutdown requests).
>
I don't think you ever shared the issues you were struggling with.
Not to mean there can be no limitation but I knew a platform that ran
a virtual block-device and custom filesystem over the mailbox, and it
was good for a camera product that needs high bandwidth image
transfer.


> 3. Mailbox doesn't really do much for us as far as driver design.
>    If anything, it has been forcing us to add extra workarounds for the
>    impedance mismatches between the subsystem core and the hardware.
>    Other drivers already are inconsistent in how they use the mailbox
>    core, because the documentation is unclear on various details.
>
Again, would have helped to know the issues and details you feel missing.


> This series offers:
>
> - A modest reduction in overall code size (-27 net lines excluding #1).
> - Fixes a pile of bugs related to using the mailbox subsystem and its
>   quirks and limitations (race conditions when messages are already in
>   the queue on startup, atomic issues, the list goes on).
> - Adds runtime-PM support.
> - Adds support for the FIFOs in the mailbox hardware, improving
>   performance.
> - Simplifies code by removing extraneous memory allocations (the
>   mailbox subsystem requires consumers to pass pointers to messages,
>   instead of inlining them, even though messages are usually only one or
>   two registers in size) and the requisite cleanup/freeing in the
>   completion path.
>
> In addition, it paves the way for future Apple-specific mailbox
> optimizations, such as adding the ability to de-duplicate message sends
> if the same message is already known to be in the FIFO (which can be
> done by keeping a rolling history of recently sent messages). This is
> useful for doorbell-style messages, which are redundant to send more
> than once if not yet processed.
>
> Apple Silicon platforms use these mailboxes pervasively, including as
> part of the GPU submission hot path. On top of that, bad interactions
> with firmware coprocessors can cause immediate lockups or crashes with
> no recovery possible but a reboot. Our requirements for reliability and
> performance are probably much higher than the average mailbox user, and
> we'd much rather not have a bunch of common code getting in the way of
> performance profiling and future optimization. It doesn't make much
> sense for the mailbox subsystem either, since solving these issues would
> require major refactoring that is unlikely to provide significant
> benefit to most other users.
>
> So let's just call usage of the mailbox subsystem a failed experiment,
> and move the driver into soc/apple, where we can control the API and can
> add whatever peculiarities we need for our mailboxes. Farewell, mailbox.
>
> There are no changes to the DT bindings. This driver has been shipping
> in Asahi stable kernel packages for a week, with no regressions
> reported by any users.
>
> As an additional non-kernel-related benefit, this introduces a direct
> module dependency between consumers and the mailbox producer. This, in
> turn, is in the critical path for the NVMe driver on these platforms.
> Prior to this series, we had to have custom initramfs hooks to add
> apple-mailbox to distro initramfses, and accidentally removing these
> hooks would result in a completely unbootable system (there is no way
> for standard initramfs machinery to detect soft consumer/producer
> relationships like this, they usually just go looking for block device
> modules and their direct dependencies). We still need the initramfs
> hooks for other things, but with this change, completely removing all
> Apple-related initramfs hooks will at least result in a *bootable*
> system so you can fix the problem. This has already bit several users,
> and it also means many more distros have a chance of working out of the
> box (enough to let you install extra stuff) on these platforms, instead
> of having a hard requirement that *every single distro* fix up their
> initramfs generation in order to even boot/install on these platforms at
> all.
>
> Jassi: Ideally I'd like to get an ack on this and merge it all through
> asahi-soc, so we don't have to play things patch-by-patch across
> multiple merge cycles to avoid potentially broken intermediate states.
>
Instead of every platform implementing their own message queuing and
handling mechanism and parsing producer-comsumer links from the DT,
there is a reusable code in drivers/mailbox.   Which does seem
inadequate if one comes looking for a "standard/generic" mailbox
implementation (again, which can not exist).

And there is a reason the reduction in code with this patchset is
meager -- you anyway have to implement your platform specific stuff.
But if redoing mailbox overall saves you complexity, I am ok with it.

cheers.
