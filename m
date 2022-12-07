Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76B7645725
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 11:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiLGKIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 05:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiLGKH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 05:07:58 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD90FD32;
        Wed,  7 Dec 2022 02:07:57 -0800 (PST)
Received: by mail-qt1-f182.google.com with SMTP id y15so15778354qtv.5;
        Wed, 07 Dec 2022 02:07:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TEMqtnr8yIPKdQ8rnHIb74MSIknwWc2/8CuDmZ72dmM=;
        b=aAcPmxMoQbhWlPK6YHDroP5G9mFDXisLTzNAJdKUCvCSKZuu6L6R8KewW3jQa61KqL
         oTaJEv67hQFnHObSpmB+qktU5eSPq03Pb6Q0pveg9Eq5j1qfFITB46bQ62GT42IxfmHG
         C6sP6GsBzNaExfjIIT/zhJIJiJCr/yjrOCsRLzmcEtLM3Hp2w36rqdgkwfH+mUEwhnas
         3umLvu3X8rf35P/XUeDt4SP1outF/8Hb0BHrOxvNyIQI/5Xyi5/36TuWhgTNpOKRzcH3
         1C+xisyFZHOvlcA0c+9pkRWtuHTWJR5+idQ+jwG+lq54gTnsa4nVEnHOZZzyHz+JDYqd
         uKog==
X-Gm-Message-State: ANoB5pkTjQjNYOxuCvk165ZFri6nCJhBaCyhDccuelShIOlh/ajA+ig2
        z4hhoj0KgpxlkQgu9KtYvB7AxFgU4sJMxoZjQ50=
X-Google-Smtp-Source: AA0mqf6v3AK3qCOxYiQzm1YdzeqTMIebZHJAquSyG7WYAzzXQvegAx3VWMfOUHNf4RwGINEHSvA8EaUHiz/pe0gFq1Y=
X-Received: by 2002:ac8:7dcb:0:b0:3a6:8dd0:4712 with SMTP id
 c11-20020ac87dcb000000b003a68dd04712mr27484817qte.411.1670407676616; Wed, 07
 Dec 2022 02:07:56 -0800 (PST)
MIME-Version: 1.0
References: <2262737.ElGaqSPkdT@kreacher> <1df12728a2e788788fd387588bac62023e123d16.camel@hadess.net>
 <2145955.irdbgypaU6@kreacher> <CAJZ5v0ic+pm+NWD8g4O2MwQEvi+xuB-W9Wpd6c1RhprhoxuK1g@mail.gmail.com>
 <8281ddcc16cc950f9cde4b196cf208adcc798319.camel@hadess.net>
In-Reply-To: <8281ddcc16cc950f9cde4b196cf208adcc798319.camel@hadess.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 7 Dec 2022 11:07:44 +0100
Message-ID: <CAJZ5v0gjAGZFS6ap+NAbsi96hq7y9MRGE0h_A-n6xfB1CMs=2g@mail.gmail.com>
Subject: Re: [Regression] Logitech BT mouse unusable after commit 532223c8ac57
 (still in 6.1-rc8)
To:     Bastien Nocera <hadess@hadess.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@riseup.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 7, 2022 at 10:59 AM Bastien Nocera <hadess@hadess.net> wrote:
>
> On Wed, 2022-12-07 at 10:36 +0100, Rafael J. Wysocki wrote:
> > On Wed, Dec 7, 2022 at 10:16 AM Rafael J. Wysocki <rjw@rjwysocki.net>
> > wrote:
> > >
> > > On Wednesday, December 7, 2022 10:04:43 AM CET Bastien Nocera
> > > wrote:
> > > > On Tue, 2022-12-06 at 15:58 +0100, Rafael J. Wysocki wrote:
> > > > > Bastien, Jiri,
> > > > >
> > > > > Commit 532223c8ac57 ("HID: logitech-hidpp: Enable HID++ for all
> > > > > the
> > > > > Logitech
> > > > > Bluetooth devices") caused my Logitech Bluetooth mouse to
> > > > > become
> > > > > unusable.
> > > > >
> > > > > Appended is the change I need to make it work again (note that
> > > > > adding
> > > > > the
> > > > > device ID to unhandled_hidpp_devices[] doesn't help, so there
> > > > > must be
> > > > > some
> > > > > significant enough difference in how the two cases are handled
> > > > > in the
> > > > > stack).
> > > > >
> > > > > Here's what I get in the log without the patch below:
> > > > >
> > > > > [   36.710574] Bluetooth: HIDP (Human Interface Emulation) ver
> > > > > 1.2
> > > > > [   36.710592] Bluetooth: HIDP socket layer initialized
> > > > > [   36.724644] hid-generic 0005:046D:B016.0001: unknown main
> > > > > item tag
> > > > > 0x0
> > > > > [   36.725860] input: Bluetooth Mouse M336/M337/M535 Mouse as
> > > > > /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-
> > > > > 7:1.0/bluetooth/hci0/hci0:1/0005:046D:B016.0001/input/input14
> > > > > [   36.728036] input: Bluetooth Mouse M336/M337/M535 Consumer
> > > > > Control
> > > > > as /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-
> > > > > 7:1.0/bluetooth/hci0/hci0:1/0005:046D:B016.0001/input/input15
> > > > > [   36.728823] input: Bluetooth Mouse M336/M337/M535 Keyboard
> > > > > as
> > > > > /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-
> > > > > 7:1.0/bluetooth/hci0/hci0:1/0005:046D:B016.0001/input/input18
> > > > > [   36.731550] hid-generic 0005:046D:B016.0001: input,hidraw0:
> > > > > BLUETOOTH HID v12.03 Mouse [Bluetooth Mouse M336/M337/M535] on
> > > > > 9c:b6:d0:96:8e:c8
> > > > > [   36.833039] logitech-hidpp-device 0005:046D:B016.0001:
> > > > > unknown
> > > > > main item tag 0x0
> > > > > [   36.999064] logitech-hidpp-device 0005:046D:B016.0001:
> > > > > Device not
> > > > > connected
> > > > >
> > > > > and here's what I get with it:
> > > > >
> > > > > [   43.642546] Bluetooth: HIDP (Human Interface Emulation) ver
> > > > > 1.2
> > > > > [   43.642559] Bluetooth: HIDP socket layer initialized
> > > > > [   43.652898] hid-generic 0005:046D:B016.0001: unknown main
> > > > > item tag
> > > > > 0x0
> > > > > [   43.653833] input: Bluetooth Mouse M336/M337/M535 Mouse as
> > > > > /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-
> > > > > 7:1.0/bluetooth/hci0/hci0:1/0005:046D:B016.0001/input/input14
> > > > > [   43.655025] input: Bluetooth Mouse M336/M337/M535 Consumer
> > > > > Control
> > > > > as /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-
> > > > > 7:1.0/bluetooth/hci0/hci0:1/0005:046D:B016.0001/input/input15
> > > > > [   43.655400] input: Bluetooth Mouse M336/M337/M535 Keyboard
> > > > > as
> > > > > /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-
> > > > > 7:1.0/bluetooth/hci0/hci0:1/0005:046D:B016.0001/input/input18
> > > > > [   43.657521] hid-generic 0005:046D:B016.0001: input,hidraw0:
> > > > > BLUETOOTH HID v12.03 Mouse [Bluetooth Mouse M336/M337/M535] on
> > > > > 9c:b6:d0:96:8e:c8
> > > > >
> > > > > The only difference seems to be that in the former case the
> > > > > logitech-
> > > > > hidpp
> > > > > driver tries to bind to the device, but I guess that is
> > > > > expected.
> > > >
> > > > There really shouldn't be that much difference between the 2
> > > > paths,
> > > > except that hid-logitech-hidpp.c will check that the device
> > > > supports
> > > > HID++ in its report descriptors, and then start talking to it to
> > > > check
> > > > whether it's connected.
> > > >
> > > > Maybe the device doesn't support HID++?
> > >
> > > Quite possibly.
> > >
> > > > Can you try running src/tools/hidpp-list-features from
> > > > https://github.com/cvuchener/hidpp on the hidraw device for the
> > > > mouse?
> > >
> > > OK, I'll do that.
> >
> > Well, I would if I had a binary.
> >
> > Otherwise, I have cmake 3.17 which apparently is too old, sorry.
>
> Revert 308f240585380dd0af4d9f5bbec5eb01e103deca and it will just
> require 3.12.

OK

It says:

/dev/hidraw0 (device 0): Bluetooth Mouse M336/M337/M535 (046d:b016) HID++ 4.5

> Or use Solaar from your distribution or one of the prebuilt packages
> (https://github.com/pwr-Solaar/Solaar/#prebuilt-packages):
> solaar -D /dev/hidrawX show
