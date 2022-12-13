Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753ED64B95C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 17:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236006AbiLMQOQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 13 Dec 2022 11:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236008AbiLMQOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 11:14:12 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371061CFCC;
        Tue, 13 Dec 2022 08:14:10 -0800 (PST)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 5469260002;
        Tue, 13 Dec 2022 16:14:07 +0000 (UTC)
Message-ID: <6b5e878265958fb0201178fc3c1d75ef06c826ec.camel@hadess.net>
Subject: Re: [Regression] Logitech BT mouse unusable after commit
 532223c8ac57 (still in 6.1-rc8)
From:   Bastien Nocera <hadess@hadess.net>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Filipe =?ISO-8859-1?Q?La=EDns?= <lains@riseup.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Date:   Tue, 13 Dec 2022 17:14:06 +0100
In-Reply-To: <b356b5684cc631513c0498f18d7c185b77416f85.camel@hadess.net>
References: <2262737.ElGaqSPkdT@kreacher>
         <1df12728a2e788788fd387588bac62023e123d16.camel@hadess.net>
         <2145955.irdbgypaU6@kreacher>
         <CAJZ5v0ic+pm+NWD8g4O2MwQEvi+xuB-W9Wpd6c1RhprhoxuK1g@mail.gmail.com>
         <8281ddcc16cc950f9cde4b196cf208adcc798319.camel@hadess.net>
         <CAJZ5v0gjAGZFS6ap+NAbsi96hq7y9MRGE0h_A-n6xfB1CMs=2g@mail.gmail.com>
         <cd8b2a2160f5d36d1b73bc0567cd0f6e7e5751c4.camel@hadess.net>
         <CAJZ5v0gRm1NG=QuDFDFdcZgTu7Q0Z3cW3fwGg09sD+3BBV8E1A@mail.gmail.com>
         <91367d07a72ecb2065faebe974c54ebd966e0d59.camel@hadess.net>
         <CAJZ5v0ghW2DdC0quVQ-+Oad7bR95Pyp4Uhd9=XUYk9SQrXKj5w@mail.gmail.com>
         <b356b5684cc631513c0498f18d7c185b77416f85.camel@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-12-08 at 16:20 +0100, Bastien Nocera wrote:
> On Wed, 2022-12-07 at 18:44 +0100, Rafael J. Wysocki wrote:
> > On Wed, Dec 7, 2022 at 6:19 PM Bastien Nocera <hadess@hadess.net>
> > wrote:
> > > 
> > > On Wed, 2022-12-07 at 12:07 +0100, Rafael J. Wysocki wrote:
> > > > # hidpp-list-features /dev/hidraw1
> > > > Bluetooth Mouse M336/M337/M535 (046d:b016) is a HID++ 4.5
> > > > device
> > > > Feature 0x01: [0x0001] Feature set
> > > > Feature 0x02: [0x0003] Device FW version
> > > > Feature 0x03: [0x0005] Device name
> > > > Feature 0x04: [0x0020] Reset
> > > > Feature 0x05: [0x1e00] Enable hidden features (hidden)
> > > > Feature 0x06: [0x1800] Generic Test (hidden, internal)
> > > > Feature 0x07: [0x1000] Battery status
> > > > Feature 0x08: [0x1b04] Reprog controls v4
> > > > Feature 0x09: [0x2100] Vertical scrolling
> > > > Feature 0x0a: [0x2200] Mouse pointer
> > > > Feature 0x0b: [0x2205] Pointer speed
> > > > Feature 0x0c: [0x18b1] ? (hidden, internal)
> > > > Feature 0x0d: [0x2121] Hi-res wheel
> > > > Feature 0x0e: [0x1f03] ? (hidden, internal)
> > > 
> > > Would you be able to enable debugging for the hid subsystem to
> > > get
> > > some
> > > debug data when getting the version from the device fails?
> > 
> > I guess I could, but I think that the device is just quirky.
> > 
> > At least the BT layer appears to think that it is connected.
> > 
> > Anyway, what exactly do you need?
> > 
> > > I can't see any problems in there that wouldn't also have
> > > impacted
> > > all
> > > the other Logitech Bluetooth devices listed in the support
> > > devices
> > > list.
> > > 
> > > If the problem is a timeout, maybe we should lower the timeouts
> > > we
> > > currently have (5*HZ = 5 seconds, right?), so we can retry 5
> > > times
> > > one
> > > second instead.
> > 
> > No, it doesn't take 5 sec to get a response from it.  It rather
> > looks
> > like __hidpp_send_report() returns an error.
> 
> Adding "debug" on the kernel command-line should be enough to get
> debug
> out of hidpp_send_message_sync():
> https://stackoverflow.com/a/63682160
> 
> Either that or turn all the dbg_hid() into hid_err() if you're going
> to
> be compiling the kernel.
> 
> We're mainly interested in the error code from the device, as that's
> what I'm guessing is caused the error to propagate.

Can you also check whether you had:
https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git/commit/?id=8b7e58409b1813c58eea542d9f3b8db35b4ac1f7
in your git tree?

Would be great to know whether that commit helps at all.

Cheers

> > > Still, as I mentioned earlier, I can't reproduce the problem on
> > > another
> > > Bluetooth Classic device...
> 

