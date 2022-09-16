Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30A85BA368
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 02:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiIPADe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 20:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiIPADb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 20:03:31 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9ECB52E53
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 17:03:29 -0700 (PDT)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2FCD13F179
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 00:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1663286608;
        bh=XEszTMy4BSHlQ6vsVLVwlRpHC94G5PPukl5GrIlhufc=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=op9ioO+/qKLFb+pdwjCY1/mLvhPhFGplNYUVYFc+ogDvc7gJlDvdj2/W7iOkH/f8o
         VyS+kt6DM+YaC9x3se7tUwaV51sb3VAne2RcFfhA8OKGVc64u8DqcKqiB/N521+GBt
         uvhiAwmRMHIk0TLA24E8GT+OrMKEBBb11mwg1/L4QsH4fun/QeEjvq05zJEpHeHiSA
         QG9XqYjP27CjNpKJpHrfX4iPCh6OsfHW63SJIMVdp5R7eAU5WI9nDWfx6Hwu2fb8WM
         aU8MPMLfWl+rmAXc3uFX84NykAs5cGtNl2Q0Twdwa4PDu2N0wsbKzVNAWT3pX+HLAs
         CueWE+Fq2BNIg==
Received: by mail-wm1-f70.google.com with SMTP id h133-20020a1c218b000000b003b3263d477eso10311954wmh.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 17:03:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=XEszTMy4BSHlQ6vsVLVwlRpHC94G5PPukl5GrIlhufc=;
        b=r5EZTdcxopZg+d7cXJJnNWhMM2FWtP4y1M0BG4gtk7M1BeCknkSEJsWFoWVaq/HY1O
         BLW7uJhJEyjT6D0LSBgTmAxyJ2JxbUWynu6tdwwM8PjzWBDAB6C/9Lm8br7kkU9d0AZh
         LtkagygIuFKofliuAqOcoSHcCXmI6PF/zptf5u836oP0TtS6tjhEpC24F/nTVb9KivTn
         +ejXK4WE1zICwTZbSYKVppfEjGw8rABNervtU7DVh+DNplFicpmqS/nAFmLA0jhEV6Pe
         Bm2v2StRABxSjyziSWxQtiqfPHT2SfBCcBkV6BwEb0ibwHSz+sYOEzh6paPlGQmiXrXy
         edaA==
X-Gm-Message-State: ACgBeo0O6nzfKvRqrG4lXRRTsU5lEQupJXuOUC2q2LYxTxK0ql11pbsF
        j0FtqAQsgxn2PqwhW6ijSeBLHa+WiTmOpXCwZyPkgqjm1Pn0597brcjec3Zmq9a2RLrUxO0VNm+
        IpUBge0P0f/k8USZzzRYNQZUu2ItKxojqRi3FnFngnMcGLYMv0ErHwlALIw==
X-Received: by 2002:a05:600c:1e20:b0:3b4:86e4:6857 with SMTP id ay32-20020a05600c1e2000b003b486e46857mr8494592wmb.167.1663286607768;
        Thu, 15 Sep 2022 17:03:27 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7juhqsS6LzVQTpv3uXvCGHlwMXNamNlOnD9rBc/A7aqL4qDPZQ+zmIBT6G25WHWodqDyB1pZ/RgkioU/6K/10=
X-Received: by 2002:a05:600c:1e20:b0:3b4:86e4:6857 with SMTP id
 ay32-20020a05600c1e2000b003b486e46857mr8494570wmb.167.1663286607472; Thu, 15
 Sep 2022 17:03:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220913062042.1977790-1-kai.heng.feng@canonical.com>
 <20220913062042.1977790-2-kai.heng.feng@canonical.com> <44e3e1be-363b-f19b-4907-6990d2f5b24c@collabora.com>
In-Reply-To: <44e3e1be-363b-f19b-4907-6990d2f5b24c@collabora.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 16 Sep 2022 08:03:16 +0800
Message-ID: <CAAd53p5gYAP4X4AFBf9kGnwFaREucUn2J20U0nw9zjv+nh+=Cw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] PM: ACPI: reboot: Reinstate S5 for reboot
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     rafael.j.wysocki@intel.com, lenb@kernel.org,
        Josef Bacik <josef@toxicpanda.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 11:17 PM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 9/13/22 09:20, Kai-Heng Feng wrote:
> > Commit d60cd06331a3 ("PM: ACPI: reboot: Use S5 for reboot") caused Dell
> > PowerEdge r440 hangs at reboot.
> >
> > The issue is fixed by commit 2ca1c94ce0b6 ("tg3: Disable tg3 device on
> > system reboot to avoid triggering AER"), so use the new sysoff API to
> > reinstate S5 for reboot on ACPI-based systems.
> >
> > Cc: Josef Bacik <josef@toxicpanda.com>
> > Suggested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> > v3:
> >  - Use new API to invoke ACPI S5.
> >
> > v2:
> >  - Use do_kernel_power_off_prepare() instead.
> >
> >  drivers/acpi/sleep.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> > index ad4b2987b3d6e..dce5460902eed 100644
> > --- a/drivers/acpi/sleep.c
> > +++ b/drivers/acpi/sleep.c
> > @@ -1088,6 +1088,10 @@ int __init acpi_sleep_init(void)
> >               register_sys_off_handler(SYS_OFF_MODE_POWER_OFF,
> >                                        SYS_OFF_PRIO_FIRMWARE,
> >                                        acpi_power_off, NULL);
> > +
> > +             register_sys_off_handler(SYS_OFF_MODE_RESTART_PREPARE,
> > +                                      SYS_OFF_PRIO_FIRMWARE,
> > +                                      acpi_power_off_prepare, NULL);
>
> Maybe you could add a small comment to the code explaining why
> acpi_power_off_prepare is used for restarting?

Will do.

>
> Is it safe to use S5 on restart for all devices in general?

S5 should be used, but it may expose some driver bugs like the one
mentioned in the commit message.

Kai-Heng

>
> --
> Best regards,
> Dmitry
>
