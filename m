Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B93469EA4A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 23:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjBUWiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 17:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjBUWiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 17:38:09 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432613346B
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 14:37:47 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id p6so3223047pga.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 14:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677019049;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6fvqDtryouPcYlHwJfeJHum4nYUiKG4ut7+B4xp9D+Q=;
        b=P/ZDLMvF95ku1mCXIEXE7cOE1Rl1c/A/AWCWBhHV1n3FFdGKvggt6PjwHG1gdZaS6N
         Fap7TEGSZDDRrif568v+9vCG5oaTQ2gsTa7FhYwCCmZprjJ9QXhJDXCi346EhAA4V1P0
         OVPzlCUiiOyC7UY/iHIBaMlftugxmMHGV0WW0iidMledA8fDdfKTh/DdNXwugiflQyf0
         tu5Io9OShNTLtDjwOJBvsFSwF9kXi1oIrCjuyZwAfLJS9lMmEnwMk8cpd/JnEK9PTiCZ
         QSRXnRi/NXWgmTuIbWJyPttKQ/ic4p6zeor/rlgJf7oUjE4jfE7RhGW7CMdZDhVsoVCn
         afYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677019049;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6fvqDtryouPcYlHwJfeJHum4nYUiKG4ut7+B4xp9D+Q=;
        b=oln9qS9WUTh48o/T05f3sqkVdaXb7JDpsx2wxLo0kNlDUbSPTwAqgDnYH4Un/SS+ed
         5JTb1ojpAQYdHWd/6lIssiGfSuI4cTJjSB1Gzd5HsJRyExboZuEs9Iyy1n/HZWzNxMWv
         RoRhMCHhP75kbk6LgMD+yA/dTdyoh3efwZJw40oWkrll4KpMRIA/Iw/LUW6iUqTkdEiz
         hCw0A3k439r9SWkSAdOhGmHHlrY8fLZTtocDTEhCcva3Pv1ptcqvloQSRQVHK0rL7HHf
         8EMtKvqRt1mtilbXo2+NlpUSjBHR7FSm7uPFHdJDJ/Cqec19dxdcHAkwQshJFhuoDUTZ
         DL9g==
X-Gm-Message-State: AO0yUKUln1fLbx5x4J3r0WTJEJ4N12Gr6ofpOJTLspLVtzMfKCSNQlp/
        N/8rrQbys+yENx5wjtlszQEOa7brltagg3pimXnRBddM9SIKcTZECdo=
X-Google-Smtp-Source: AK7set8ZWfw+9Ev8gH39GguvyI6i7fJJCHbdUGp0DdLaD6pWfM7zxiU0B1WF/c6gsBb+6mh+xKtCKCI9jkajanm4Tc4=
X-Received: by 2002:a62:3103:0:b0:5a8:4dea:7015 with SMTP id
 x3-20020a623103000000b005a84dea7015mr961942pfx.36.1677019048457; Tue, 21 Feb
 2023 14:37:28 -0800 (PST)
MIME-Version: 1.0
References: <CGME20230218083300eucas1p28c7c584877b8914a3b88904690be82f6@eucas1p2.samsung.com>
 <20230218083252.2044423-1-saravanak@google.com> <e3814c81-c74d-7087-e87d-12dcb49e6444@samsung.com>
In-Reply-To: <e3814c81-c74d-7087-e87d-12dcb49e6444@samsung.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 21 Feb 2023 14:36:52 -0800
Message-ID: <CAGETcx-UcVnDw-FJAPeA1mLpPno4OE3AAv4WsfP852zOdKqPCw@mail.gmail.com>
Subject: Re: [RFC v1 0/4] Simplify regulator supply resolution code by
 offloading to driver core
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Tony Lindgren <tony@atomide.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Luca Weiss <luca.weiss@fairphone.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 1:02 AM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Hi Saravana,
>
> On 18.02.2023 09:32, Saravana Kannan wrote:
> > Hi Mark/Liam,
> >
> > This series is just an RFC to see if you agree with where this is going.
> > Please point out bugs, but don't bother with a proper code review.
> >
> > The high level idea is to not reimplement what driver core can already
> > handle for us and use it to do some of the work. Instead of trying to
> > resolve supplies from all different code paths and bits and pieces of
> > the tree, we just build it from the root to the leaves by using deferred
> > probing to sequence things in the right order.
> >
> > The last patch is the main one. Rest of them are just setting up for it.
> >
> > I believe there's room for further simplification but this is what I
> > could whip up as a quick first draft that shows the high level idea.
> > I'll probably need some help with getting a better understanding of why
> > things are done in a specific order in regulator_register() before I
> > could attempt simplifying things further.
> >
> > Ideally, regulator_register() would just have DT parsing, init data
> > struct sanity checks and adding the regulator device and then we move
> > everything else to into the probe function that's guaranteed to run only
> > after the supply has been resolved/ready to resolve.
> >
> > fw_devlink/device links should further optimize the flow and also allow
> > us to simplify some of the guarantees and address some of the existing
> > FIXMEs. But this patch series is NOT dependent on fw_devlink or device
> > links.
> >
> > Any thoughts on where this is going?
> >
> > I've tested this on one hardware I have and it works and nothing is
> > broken. But the regulator tree in my hardware isn't that complicated or
> > deep. The regulators are also added mostly in the right order (due to
> > existing fw_devlink). So if you agree with the idea, the next step is to
> > ask people to give it a test.
> >
> > Also, it's based on driver-core-next since that's what I had synced up
> > and had a working baseline. I'll rebase it on the regulator tree when I
> > go from RFC -> PATCH.
>
> I've applied this patchset on top of linux next-20230220 and gave it a
> try on my test farm, as it revealed a few issues related to regulator
> initialization in the past. It looks that handling of some corner cases
> is missing, because this patchset introduced a regression on Samsung
> Snow/Peach-Pit/Peach-Pi Chromebooks, as well as Hardkernel's Odroid-M1
> board. It looks that the issue is common - PHY devices don't probe
> properly. This is an output from Odroid-M1 board
> (arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts):
>
> # cat /sys/kernel/debug/devices_deferred 2>/dev/null
> fd8c0000.usb    platform: wait for supplier host-port
> fe830000.phy
> fe8a0000.usb2phy        rockchip-usb2phy: failed to create phy
> fe8b0000.usb2phy        rockchip-usb2phy: failed to create phy
> 3c0800000.pcie  rockchip-dw-pcie: failed to get vpcie3v3 regulator
> fcc00000.usb    platform: wait for supplier otg-port
> fd000000.usb    platform: wait for supplier host-port
> fd800000.usb    platform: wait for supplier otg-port
> fd840000.usb    platform: wait for supplier otg-port
> fd880000.usb    platform: wait for supplier host-port
> fe820000.phy
>
> If you need any additional tests on the mentioned boards, let me know.

Thanks for testing it Marek! I don't want people to spend more time
testing this before I hear Mark/Liam's thoughts. So, let's hold off
for now.

I took a peek at the dts and the logs above. If you go into
/sys/bus/regulator/devices/, I'd expect all of them to have probed
(they'll have a "driver" symlink in their folder). Or at least the
regulator tree used by the phys.

My first guess is that deferred probe handling might be broken
somewhere in the USB/phy framework where they aren't able to handle
regulator_get() returning -EPROBE_DEFER. Looks like my patch is
delaying some reglator_get() from passing. I'll look closer into
avoiding this after Mark/Liam approve the general idea behind this
patch.

-Saravana

>
>
> > Thanks,
> > Saravana
> >
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > Cc: Bjorn Andersson <andersson@kernel.org>
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Doug Anderson <dianders@chromium.org>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: Luca Weiss <luca.weiss@fairphone.com>
> >
> > Saravana Kannan (4):
> >    regulator: core: Add regulator devices to bus instead of class
> >    regulator: core: Add sysfs class backward compatibility
> >    regulator: core: Probe regulator devices
> >    regulator: core: Move regulator supply resolving to the probe function
> >
> >   drivers/regulator/core.c         | 102 +++++++++++++++++++------------
> >   drivers/regulator/internal.h     |   2 +-
> >   drivers/regulator/of_regulator.c |   2 +-
> >   3 files changed, 64 insertions(+), 42 deletions(-)
> >
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>
