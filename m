Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDEC5B5F46
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 19:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiILR0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 13:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiILRZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 13:25:39 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42775167F3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 10:24:59 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id e17so13854049edc.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 10:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=AHtX5h+DfEA27aqSh/ELGbqK2YdawVOH4W5snYR7xOs=;
        b=xlJUv0meAEmvC9PPM4jDBoR/HB4n1KeR5uyYPNQa01ClR6ktEctx2cD0R5RySrC9Nq
         HhkHHDuqnqESzpyUTabiTCxMYdQTsENaiStVRDaT1nlNLbJj78V2PnBYgwmivLEJQNPq
         vEjE2BXrlOFKX985XL9+4I4OrZSr1WhA/ZvdcPrkbWg2cyV6BA3cIF2FXtI0jsyWGzHk
         TvLaYpvkM6kxQmfZ2sZa8pX/61zcFzpfyFkUYXRBsRvceeznO7+J1vSJQuveX6AqOzwo
         5qy0XUv8f1DEgIhBEoluNtm8ADyHuA9yYB21eZ9YeGgvuRnTbrt1X0P1ndXPpsKqvn4z
         2TBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=AHtX5h+DfEA27aqSh/ELGbqK2YdawVOH4W5snYR7xOs=;
        b=15wQFDTRSb5yvX1AdAEUxu7tMg0XVnS9QMiZrkeaHtAOVPNDmUjfSTMHJQq74/w9Ln
         dHHpZuwrDEO4Kqg3wQvTR6zdcNJQcWwFG6j9PfOH+rvIxITenK8lxPHuobbkrXJTbx2u
         zHI3NeoVHYM/cbp7h1CXhhyOuN6qOLBz3zf6IBVG6QiyDiLEeG9HwPQOUdP45pYr/nK8
         JQWn1GxmceggQNAwmFrol/yTTC1Thjbt+W0cuPon9AJShvi2IAgovJ35A5KeSSBBnRpz
         hmFdJPBDIkWmchroSmHq6jjlY843cQKNq22c77QHrHHzs04KScX14OLryAvna+ZBn1SV
         FMeA==
X-Gm-Message-State: ACgBeo165UQlQkTuxc9mWqcyTF+HGvaqhGIvFoGBFReVM20CWEivp5ns
        XoJc/01VnJLtS6s6hPVXi+besm4nXNWKbxhWKBTKTw==
X-Google-Smtp-Source: AA6agR7CrcUI1xpuy4kMVk9bs8H5s27bWLom1SHCI8OrZ6ZpjPyOzwFyqslxba2Z/+f5i309IW1e24j8Hh2UWZJNLiU=
X-Received: by 2002:a05:6402:40c2:b0:44f:963d:1ab4 with SMTP id
 z2-20020a05640240c200b0044f963d1ab4mr19547196edb.319.1663003494932; Mon, 12
 Sep 2022 10:24:54 -0700 (PDT)
MIME-Version: 1.0
References: <YuqDMLF2AQyj4+N1@kroah.com> <CAOesGMivEZmYb7Z8C1ic=r0oeNeXBh61LYu28B1g9d_qZVOjyA@mail.gmail.com>
In-Reply-To: <CAOesGMivEZmYb7Z8C1ic=r0oeNeXBh61LYu28B1g9d_qZVOjyA@mail.gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Mon, 12 Sep 2022 10:24:43 -0700
Message-ID: <CAOesGMgKM9gU9qNEiLb==pE_u-W7HTGd0s75CL38u6Eve2Uchg@mail.gmail.com>
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

On Mon, Sep 12, 2022 at 10:23 AM Olof Johansson <olof@lixom.net> wrote:
>
> Hi,
>
> On Wed, Aug 3, 2022 at 7:16 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> > Saravana Kannan (11):
> >       PM: domains: Delete usage of driver_deferred_probe_check_state()
> >       pinctrl: devicetree: Delete usage of driver_deferred_probe_check_state()
> >       net: mdio: Delete usage of driver_deferred_probe_check_state()
> >       driver core: Add wait_for_init_devices_probe helper function
> >       net: ipconfig: Relax fw_devlink if we need to mount a network rootfs
> >       Revert "driver core: Set default deferred_probe_timeout back to 0."
> >       driver core: Set fw_devlink.strict=1 by default
> >       iommu/of: Delete usage of driver_deferred_probe_check_state()
> >       driver core: Delete driver_deferred_probe_check_state()
> >       driver core: fw_devlink: Allow firmware to mark devices as best effort
> >       of: base: Avoid console probe delay when fw_devlink.strict=1
>
> The last patch in this list regresses my HoneyComb LX2K (ironically
> the machine I do maintainer work on). It stops PCIe from probing, but
> without a single message indicating why.
>
> The reason seems to be that the iommu-maps property doesn't get
> patched up by my (older) u-boot, and thus isn't a valid reference.
> System works fine without IOMMU, which is how I've ran it for a couple
> of years.
>
> It's also extremely hard to diagnose out of the box because there are
> *no error messages*. And there were no warnings leading up to this
> strict enforcement.
>
> This "feature" seems to have been done backwards. The checks should
> have been running (and not skipped due to the "optional" flag), but
> also not causing errors, just warnings. That would have given users a
> chance to know that this is something that needs to be fixed.
>
> And when you flip the switch, at least report what failed so that
> people don't need to spend a whole night bisecting kernels, please.
>
> Greg, mind reverting just the last one? If I hit this, I presume
> others would too.

Apologies, wrong patch pointed out. The culprit is "driver core: Set
fw_devlink.strict=1 by default", 71066545b48e42.


-Olof
