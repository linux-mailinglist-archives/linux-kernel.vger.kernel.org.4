Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDCE645C69
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 15:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiLGOYU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 7 Dec 2022 09:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiLGOYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 09:24:19 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176A2655F;
        Wed,  7 Dec 2022 06:24:16 -0800 (PST)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 32E3A24000B;
        Wed,  7 Dec 2022 14:24:12 +0000 (UTC)
Message-ID: <8c28a60ede7b568352141d2aae2952d2923234a7.camel@hadess.net>
Subject: Re: [PATCH v1 2/2] HID: logitech-hidpp: Add Bluetooth Mouse
 M336/M337/M535 to unhandled_hidpp_devices[]
From:   Bastien Nocera <hadess@hadess.net>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Filipe =?ISO-8859-1?Q?La=EDns?= <lains@riseup.net>,
        linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Date:   Wed, 07 Dec 2022 15:24:12 +0100
In-Reply-To: <f0ccee0d2f85099c146ee682b25d30c832155fa3.camel@hadess.net>
References: <2262737.ElGaqSPkdT@kreacher> <5647715.DvuYhMxLoT@kreacher>
         <2283816.ElGaqSPkdT@kreacher>
         <e7eb0e0c9aea30c0e3205b2f3d96b74a52283b40.camel@hadess.net>
         <CAJZ5v0ibpzoBLXKiqzciYv1Htks0=4+4_XGLvpH7MCyFoYJiDg@mail.gmail.com>
         <CAO-hwJL7n7HFk4MTKvLcvBPSLDwm9pHqLaZvmuwvSNDVWUF76g@mail.gmail.com>
         <nycvar.YFH.7.76.2212071117420.6045@cbobk.fhfr.pm>
         <f0ccee0d2f85099c146ee682b25d30c832155fa3.camel@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-12-07 at 13:43 +0100, Bastien Nocera wrote:
> On Wed, 2022-12-07 at 11:19 +0100, Jiri Kosina wrote:
> > On Wed, 7 Dec 2022, Benjamin Tissoires wrote:
> > 
> > > Agree, but OTOH, Rafael, your mouse is not brand new AFAICT, so I
> > > am 
> > > worried that you won't be the only one complaining we just killed
> > > their 
> > > mouse. So I think the even wiser solution would be to delay (and
> > > so
> > > revert in 6.1 or 6.2) the 2 patches that enable hid++ on all
> > > logitech 
> > > mice (8544c812e43ab7bdf40458411b83987b8cba924d and 
> > > 532223c8ac57605a10e46dc0ab23dcf01c9acb43).
> > 
> > If we were not at -rc8 timeframe, I'd be in favor to coming up with
> > proper 
> > fix still for 6.1. But as things currently are, let's just revert
> > those 
> > and reschedule them with proper fix for 6.2+.
> 
> Has anyone seen any other reports?
> 
> Because, honestly, seeing work that adds support for dozens of
> devices
> getting tossed out at the last minute based on a single report with
> no
> opportunity to fix the problem is really frustrating.

FWIW, I went out to buy a Logitech device that uses Bluetooth Classic,
the only one I could find in 2 different shops among dozens of Logitech
devices, tested it, and it worked correctly.

Dec 07 15:17:49 classic kernel: logitech-hidpp-device 0005:046D:B342.000C: unknown main item tag 0x0
Dec 07 15:17:49 classic kernel: logitech-hidpp-device 0005:046D:B342.000C: HID++ 4.5 device connected.
Dec 07 15:17:50 classic kernel: input: Logitech Bluetooth Multi-Device Keyboard K380 as /devices/pci0000:00/0000:00:14.0/usb1/1-9/1-9:1.0/bluetooth/hci0/hci0:256/0005:046D:B342.000C/input/input36
Dec 07 15:17:50 classic kernel: logitech-hidpp-device 0005:046D:B342.000C: input,hidraw5: BLUETOOTH HID v42.01 Keyboard [Logitech Bluetooth Multi-Device Keyboard K380] on 8c:c6:81:15:0c:6f

$ sudo ./_build/src/tools/hidpp-list-features /dev/hidraw5 
Logitech Bluetooth Multi-Device Keyboard K380 (046d:b342) is a HID++ 4.5 device
Feature 0x01: [0x0001] Feature set
Feature 0x02: [0x0003] Device FW version
Feature 0x03: [0x0005] Device name
Feature 0x04: [0x0007] Device Friendly Name
Feature 0x05: [0x0020] Reset
Feature 0x06: [0x1000] Battery status
Feature 0x07: [0x1814] Change host
Feature 0x08: [0x1815] Hosts info
Feature 0x09: [0x1b04] Reprog controls v4
Feature 0x0a: [0x1e00] Enable hidden features (hidden)
Feature 0x0b: [0x40a2] New fn inversion
Feature 0x0c: [0x4220] Lock key state
Feature 0x0d: [0x4521] Keyboard disable
Feature 0x0e: [0x4531] Multiplatform

