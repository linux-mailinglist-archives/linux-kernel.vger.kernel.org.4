Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED0B68E215
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 21:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjBGUoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 15:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjBGUoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 15:44:19 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22236A5C0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 12:44:18 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-526f0b3d8d9so144997777b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 12:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jWFC63SFa0NEc04b7LNBtIqeFtJCBIQD+K/SNTi845Q=;
        b=fVPo5IU7vrw2G79Uns9xhh+yX9RWHZEDAnlyQPITgooDlQZ9qF5SdKL1M2wiznu9xc
         b44kQvrFlOGvGypWo+MsswqGQkWPqX6sMDbXcj8t+sPm/bkWylhyFysNH5FLlpkoCEDk
         qJZDeC+lfR/4bABJegb3VItk8eyv6uOR0j7xWf/OmJYPKXK2Kv05xC6lQ3XvbP4YMgLD
         1MGUa9ZUB5ekyTSbwzI1oswsSgDXkKd2a/jcsm/9bfZK/+UJmQYZmr5Ze6QRZcpuN6Rr
         BkMPCPw7uMz8hYQzMu0Y5Wva0ODgEvceIqCdOM5UNwGZ1MkEeoLhmYACKReML7fr8YGW
         8bsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jWFC63SFa0NEc04b7LNBtIqeFtJCBIQD+K/SNTi845Q=;
        b=rvzfwUthB//bFJtzisuOlWJqw7Ed2/p1chefs7x+Bg0a52+AKWXmWGI21kTrcmrEnj
         3hTbhNHpHaLcYkEWJVlX7lZ/XNgHK9wK/fO402btiLuz9wr6nPgbQeggkAbcuszZcp0n
         3usz0FNQkv3qW9I893/ghjg41rvwUnyiDi62a33SGk4CfC9Ue5He6OBFZXLlPSf0uQG/
         VkKYs9NzEwhuwkc4LFSh6HkJuYtyxtgHqKu3sDJv9TlCk61LcCcpL1dLS6eM96nyt39l
         tSm64cpiiZWU01qK35dduURVZLNqDAwoxA7yn/LayhAMFkEbg4knTRprZpGPDPQ90+aN
         LkBA==
X-Gm-Message-State: AO0yUKVlBncFGaCeHhmGC1fJFpgVkgcvr+itH9GrzlXvJ+wfni7PxEZP
        JWk5ZuXY1cB5HmnqMCMPY7LNKa/hxCb7wzAQMZp0pbJjWNBNnA==
X-Google-Smtp-Source: AK7set8z9ZcIO81WbXWw7jnMiKbg0cEX46ErTgpJNTE5P5o5u6Fuf6duLayicU/xxbYIfhFR8y4wokCmDLqUjRjSULE=
X-Received: by 2002:a0d:cb07:0:b0:529:a614:4d9f with SMTP id
 n7-20020a0dcb07000000b00529a6144d9fmr419015ywd.144.1675802657339; Tue, 07 Feb
 2023 12:44:17 -0800 (PST)
MIME-Version: 1.0
References: <20230206183143.75274-2-mauro.lima@eclypsium.com>
 <20230207135254.2465816-1-michael@walle.cc> <Y+JaKF4FZQKqeGs7@black.fi.intel.com>
 <8797addc6c063b867b94cce352191aab@walle.cc> <Y+JkArdW747OtMO9@black.fi.intel.com>
In-Reply-To: <Y+JkArdW747OtMO9@black.fi.intel.com>
From:   Mauro Lima <mauro.lima@eclypsium.com>
Date:   Tue, 7 Feb 2023 17:44:06 -0300
Message-ID: <CAArk9MMC=xq3HetGG-F8OQk4J6=b5rNpoPfou0e5T8w4fpDFnQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] spi: intel: Remove DANGEROUS tag from pci driver
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Michael Walle <michael@walle.cc>, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
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

Hi all,

On Tue, Feb 7, 2023 at 2:25 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi,
>
> On Tue, Feb 07, 2023 at 03:11:26PM +0100, Michael Walle wrote:
> > Hi Mika,
> >
> > Am 2023-02-07 15:03, schrieb Mika Westerberg:
> > > On Tue, Feb 07, 2023 at 02:52:54PM +0100, Michael Walle wrote:
> > > > > Modern CPUs exposes this controller as PCI device that only uses
> > > > > hardware sequencing capabilities which is safer than software
> > > > > sequencing.
> > > > > Leave the platform driver as *DANGEROUS* and update help text since
> > > > > most of these controllers are using software sequencing.
> > > >
> > > > Out of curiosity, what is hardware sequencing? Maybe this should
> > > > be explained a bit more in the Kconfig help text. Looks like the
> > > > dangerous was there because you can update the bios and that
> > > > could eventually lead to a bricked mainboard. So hardware
> > > > sequencing helps there? how?
> > >
> > > Hardware sequencing means the controller exposes just a bunch of "high
> > > level" operations to the software.
> >
> > Ok, I figured it would have been something to do with the SPI driver
> > just supporting these high level ops. But even with that background
> > it was hard to connect that to the "hardware sequencing". The help
> > text should be somewhat understandable to the user/distro people/whoever,
> > right? So I'd suggest to explain that a bit more in detail, or don't
> > use the term hardware sequencing at all. I'm not sure.
>
> I agree it should be made more understandable for the distro folks. At
> least add some explanation why it is OK to select this.
I agree with this.
> Mauro, can you do that in the next version?
Sure thing.
> > > Such as read, write, erase and so on
> > > but does not allow running the actual "low level" SPI-NOR opcodes.
> > > Software sequencing on the other hand allows running pretty much any
> > > opcode and this is what caused problems for certain Lenovo laptops few
> > > years back that then resulted adding DANGEROUS to the Kconfig.
> >
> > That information should go into the commit message.
>
> +1
Sorry about this, still learning :)

Thanks all for your comments and time.
