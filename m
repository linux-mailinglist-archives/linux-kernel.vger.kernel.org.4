Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E69A5B5F37
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 19:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiILRYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 13:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiILRX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 13:23:57 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A5B3F328
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 10:23:56 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id a41so1993199edf.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 10:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=uW3AM/UZ8qCMKh2ox+FP5lC7oxltagZaytrj/l/iJk0=;
        b=EIJIney81duJTq4k/HKTJsz7r/F/XGIzapuP7y35cKvvcSBmQ5C6Z8PlcYag4mWbCv
         gNu7V71PNXcB/Lmxdp8rESySJMW0m/D8lEV6rUJhlh2kRfEoTyQelCU1wM/VyBvLV6Vt
         QBTxsska86glADjhjc03qVyNpoVlXtWsZ9HOSJoHoVCOl1rmzUunW9PI+2ki/HBz1a3D
         DVyvREcWu4LeDaTaPcqYj9/4A1wlQicNiaYL+VH5qliA3IIc/AR2EkL26Kyjf8GWXMdR
         g9eg2EjjdJ4mPYvGEzlhJF+WfmZYyfUmZNKwpNmly6e8B6gUVT9QKUyRe3Td81HqAqXZ
         VxmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=uW3AM/UZ8qCMKh2ox+FP5lC7oxltagZaytrj/l/iJk0=;
        b=71oVrSPcki72P3i44MsClCAPkQVtOCjV2Lp0oynm4frI5Kxxoq9DoD90yCQJpIKU5J
         wZM6funDja541nJ2BJmzVwX7cLg7pW5DkVlqJ2ZbeKAE9CDjKJdz4NxXQtcGViSfOCet
         fvKSI1FZTeH66kJnoxIeffNTsG/FlXgNp7Gw4/0kiHQ0aBwsfSpIEsswJ6nwJ8ffkfg2
         4VlD4PZi0JycEGAw6h4phuQ6rsI8tH1DjAq+yyaeMMm4wlNuoX6I48Xxkl/6yazEiSzi
         mXR4uuPa3SLNpT+eOYdMdXMWsHzJvszNkpi+g+OSrztiDBre47r77P8773Y5Ifqc5ZW6
         6Wvw==
X-Gm-Message-State: ACgBeo2EuLFcEHXHCRHQMhlbtl59eFH5CDfBFvqQvPsc4abuj0xrJaAy
        uJkgGP/SWZXfa6BcNef1dejFjuzGgNXoj2Yq0EaCm5m4IwI=
X-Google-Smtp-Source: AA6agR5ae8kTiyd2Jqu3e3JcOa0dYa2dK3GIvhXWxHODvtgvuDSGpqsDP3DEM4FERBLv4IPO1jmr5JnUr6JvmsADYu0=
X-Received: by 2002:aa7:cb92:0:b0:443:98d6:20da with SMTP id
 r18-20020aa7cb92000000b0044398d620damr22772932edt.399.1663003435009; Mon, 12
 Sep 2022 10:23:55 -0700 (PDT)
MIME-Version: 1.0
References: <YuqDMLF2AQyj4+N1@kroah.com>
In-Reply-To: <YuqDMLF2AQyj4+N1@kroah.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Mon, 12 Sep 2022 10:23:42 -0700
Message-ID: <CAOesGMivEZmYb7Z8C1ic=r0oeNeXBh61LYu28B1g9d_qZVOjyA@mail.gmail.com>
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

Hi,

On Wed, Aug 3, 2022 at 7:16 AM Greg KH <gregkh@linuxfoundation.org> wrote:

> Saravana Kannan (11):
>       PM: domains: Delete usage of driver_deferred_probe_check_state()
>       pinctrl: devicetree: Delete usage of driver_deferred_probe_check_state()
>       net: mdio: Delete usage of driver_deferred_probe_check_state()
>       driver core: Add wait_for_init_devices_probe helper function
>       net: ipconfig: Relax fw_devlink if we need to mount a network rootfs
>       Revert "driver core: Set default deferred_probe_timeout back to 0."
>       driver core: Set fw_devlink.strict=1 by default
>       iommu/of: Delete usage of driver_deferred_probe_check_state()
>       driver core: Delete driver_deferred_probe_check_state()
>       driver core: fw_devlink: Allow firmware to mark devices as best effort
>       of: base: Avoid console probe delay when fw_devlink.strict=1

The last patch in this list regresses my HoneyComb LX2K (ironically
the machine I do maintainer work on). It stops PCIe from probing, but
without a single message indicating why.

The reason seems to be that the iommu-maps property doesn't get
patched up by my (older) u-boot, and thus isn't a valid reference.
System works fine without IOMMU, which is how I've ran it for a couple
of years.

It's also extremely hard to diagnose out of the box because there are
*no error messages*. And there were no warnings leading up to this
strict enforcement.

This "feature" seems to have been done backwards. The checks should
have been running (and not skipped due to the "optional" flag), but
also not causing errors, just warnings. That would have given users a
chance to know that this is something that needs to be fixed.

And when you flip the switch, at least report what failed so that
people don't need to spend a whole night bisecting kernels, please.

Greg, mind reverting just the last one? If I hit this, I presume
others would too.


-Olof
