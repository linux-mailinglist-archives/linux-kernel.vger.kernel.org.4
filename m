Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8FA5B781C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 19:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbiIMRiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 13:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbiIMRh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 13:37:56 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF5665557
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 09:28:41 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id lz22so28832010ejb.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 09:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=dqfDDt++wd3GzkJu7/rH2NUyW4xMIcqqDJ6iLNC291s=;
        b=MEim9D3xOue14jR/Jav6bQLoZi/hNv97yMe8hqfzvPzc9lQAfsx2Zldry2NXcUbKxT
         /csasHK5KWlUXQAoqovKKkX2mks4iPUgvPkRYuFhZvN9tgd+BbyBQlNoYRO64IILlGaa
         iOkKHn2BIsp33oxArNDx9ZgvjwS7iEZi/V1/JNM9uF7pH4ujynTaDtK+FLailmDNe5RL
         Zch+ys2WnGEcCsPAcmPbPgFzQoioYhHAVsSD/UWuoL6i0g3zbYzuHlOqfCdpgKxDRwl2
         imUO++qhtU7LBoXETJI9c15zGiOvYHQ88EFThaI+OkUlp2b4PIhhMfhvlBrM4h+KvFB8
         cOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=dqfDDt++wd3GzkJu7/rH2NUyW4xMIcqqDJ6iLNC291s=;
        b=tcjFoBiNUqc7QKTBhmW3wdZGtfGlDIM5eJGpHe5ZseRaPDZiGEIww7WzYbc9g0gLIi
         TPVigrjnVZJ9eXZ91alDvRkSF1hEZc6TKyThnJf3GcseGvXH+5C3zG7gvfnAil0R952p
         O4Am/tQta/VaG99S2HZg8r5zQxRHbUumL1cORPwe+hz9etfq5pf/VGc//WpjZn5iCOF8
         HSC46h86A/B+BWiXXst0UZHGXDqkn1ov4tZHLmUo+cJimcT8H2eHWxtmkKtRA2++aZxy
         SVkmCvFo08jKXAGSmkPeon0IBRprwPSirczL+yYZGgt52NPKsfMwB/nQImmHqhKukuCo
         i1sA==
X-Gm-Message-State: ACgBeo2RKv6DS5DZurs1F2hsX/UbQf1B46TOpdjLPpgEFe9XeBFy13uA
        BlktNn57FaI4UAV6JSWQYY4z+g3W6Wj/N4wghNiRwg==
X-Google-Smtp-Source: AA6agR5yM1bjKeeAHvCSktnAT6mnMkbq12RID7XquhX+ko1fNb/oSjoWD/MnTUKF+F1U1V3XtSvugn9aiIx0aMEHN9s=
X-Received: by 2002:a17:907:a0c7:b0:77f:a9d2:9be2 with SMTP id
 hw7-20020a170907a0c700b0077fa9d29be2mr4317058ejc.352.1663086519833; Tue, 13
 Sep 2022 09:28:39 -0700 (PDT)
MIME-Version: 1.0
References: <YuqDMLF2AQyj4+N1@kroah.com> <CAOesGMivEZmYb7Z8C1ic=r0oeNeXBh61LYu28B1g9d_qZVOjyA@mail.gmail.com>
 <CAOesGMgKM9gU9qNEiLb==pE_u-W7HTGd0s75CL38u6Eve2Uchg@mail.gmail.com> <YyCequVJnV3p0Cpw@kroah.com>
In-Reply-To: <YyCequVJnV3p0Cpw@kroah.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Tue, 13 Sep 2022 09:28:27 -0700
Message-ID: <CAOesGMjQHhTUMBGHQcME4JBkZCof2NEQ4gaM1GWFgH40+LN9AQ@mail.gmail.com>
Subject: Re: [GIT PULL] Driver core changes for 6.0-rc1
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 8:15 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Sep 12, 2022 at 10:24:43AM -0700, Olof Johansson wrote:
> > On Mon, Sep 12, 2022 at 10:23 AM Olof Johansson <olof@lixom.net> wrote:
> > >
> > > Hi,
> > >
> > > On Wed, Aug 3, 2022 at 7:16 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > > Saravana Kannan (11):
> > > >       PM: domains: Delete usage of driver_deferred_probe_check_state()
> > > >       pinctrl: devicetree: Delete usage of driver_deferred_probe_check_state()
> > > >       net: mdio: Delete usage of driver_deferred_probe_check_state()
> > > >       driver core: Add wait_for_init_devices_probe helper function
> > > >       net: ipconfig: Relax fw_devlink if we need to mount a network rootfs
> > > >       Revert "driver core: Set default deferred_probe_timeout back to 0."
> > > >       driver core: Set fw_devlink.strict=1 by default
> > > >       iommu/of: Delete usage of driver_deferred_probe_check_state()
> > > >       driver core: Delete driver_deferred_probe_check_state()
> > > >       driver core: fw_devlink: Allow firmware to mark devices as best effort
> > > >       of: base: Avoid console probe delay when fw_devlink.strict=1
> > >
> > > The last patch in this list regresses my HoneyComb LX2K (ironically
> > > the machine I do maintainer work on). It stops PCIe from probing, but
> > > without a single message indicating why.
> > >
> > > The reason seems to be that the iommu-maps property doesn't get
> > > patched up by my (older) u-boot, and thus isn't a valid reference.
> > > System works fine without IOMMU, which is how I've ran it for a couple
> > > of years.
> > >
> > > It's also extremely hard to diagnose out of the box because there are
> > > *no error messages*. And there were no warnings leading up to this
> > > strict enforcement.
> > >
> > > This "feature" seems to have been done backwards. The checks should
> > > have been running (and not skipped due to the "optional" flag), but
> > > also not causing errors, just warnings. That would have given users a
> > > chance to know that this is something that needs to be fixed.
> > >
> > > And when you flip the switch, at least report what failed so that
> > > people don't need to spend a whole night bisecting kernels, please.
> > >
> > > Greg, mind reverting just the last one? If I hit this, I presume
> > > others would too.
> >
> > Apologies, wrong patch pointed out. The culprit is "driver core: Set
> > fw_devlink.strict=1 by default", 71066545b48e42.
>
> Is this still an issue in -rc5?  A number of patches in the above series
> was just reverted and hopefully should have resolved the issue you are
> seeing.

Unfortunately, I discovered this regression with -rc5 in the first
place, so it's still there.


-Olof
