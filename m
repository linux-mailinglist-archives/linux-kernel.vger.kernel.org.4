Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC997161E3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbjE3Nat convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 30 May 2023 09:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbjE3Nap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:30:45 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FD5F0;
        Tue, 30 May 2023 06:30:22 -0700 (PDT)
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2D94940002;
        Tue, 30 May 2023 13:30:18 +0000 (UTC)
Message-ID: <f395a434756b7f35336b541cdbdb61ef5b6fe0b1.camel@hadess.net>
Subject: Re: [PATCH 1/1] HID: logitech-hidpp: Add USB and Bluetooth IDs for
 the Logitech G915 TKL Keyboard
From:   Bastien Nocera <hadess@hadess.net>
To:     Stuart <stuart.a.hayhurst@gmail.com>
Cc:     jikos@kernel.org,
        Filipe =?ISO-8859-1?Q?La=EDns?= <lains@riseup.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 30 May 2023 15:30:18 +0200
In-Reply-To: <CALTg27=2SeJmn9nka_JddSQv5NYFsz1qNLkR+q+j8-oMrnskiQ@mail.gmail.com>
References: <20230529233025.22932-1-stuart.a.hayhurst@gmail.com>
         <468317007b2bcbcce28778f9a1d3ae0426563522.camel@hadess.net>
         <CALTg27=2SeJmn9nka_JddSQv5NYFsz1qNLkR+q+j8-oMrnskiQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.0 (3.48.0-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-05-30 at 13:49 +0100, Stuart wrote:
> Using https://github.com/cvuchener/hidpp, the keyboard now seems to
> report the following:

While the list of all the feature it supports is interesting, it seems
that the only thing this adds on top of hid-generic is the battery
reporting. Can you please verify that that's the fact and add this
information to the commit message?

Cheers

> Logitech G915 TKL LIGHTSPEED Wireless RGB Mechanical Gaming Keyboard
> (046d:c343) is a HID++ 4.2 device
> Feature 0x01: [0x0001] Feature set
> Feature 0x02: [0x0003] Device FW version
> Feature 0x03: [0x0005] Device name
> Feature 0x04: [0x1d4b] Wireless device status
> Feature 0x05: [0x0020] Reset
> Feature 0x06: [0x1001] Battery voltage
> Feature 0x07: [0x1814] Change host
> Feature 0x08: [0x1815] Hosts info
> Feature 0x09: [0x8071] RGB Effects
> Feature 0x0a: [0x8081] Per-key lighting v2
> Feature 0x0b: [0x1b04] Reprog controls v4
> Feature 0x0c: [0x1bc0] Persistent remappable action
> Feature 0x0d: [0x4100] Encryption
> Feature 0x0e: [0x4522] Disable keys by usage
> Feature 0x0f: [0x4540] Keyboard layout 2
> Feature 0x10: [0x8010] G-key
> Feature 0x11: [0x8020] M-keys
> Feature 0x12: [0x8030] MR
> Feature 0x13: [0x8040] Brightness control
> Feature 0x14: [0x8100] Onboard profiles
> Feature 0x15: [0x8060] Report rate
> Feature 0x16: [0x00c2] DFUcontrol 3
> Feature 0x17: [0x00d0] DFU
> Feature 0x18: [0x1802] Device reset (hidden, internal)
> Feature 0x19: [0x1803] ? (hidden, internal)
> Feature 0x1a: [0x1806] Configurable device properties (hidden,
> internal)
> Feature 0x1b: [0x1813] ? (hidden, internal)
> Feature 0x1c: [0x1805] OOBState (hidden, internal)
> Feature 0x1d: [0x1830] ? (hidden, internal)
> Feature 0x1e: [0x1890] ? (hidden, internal)
> Feature 0x1f: [0x1891] ? (hidden, internal)
> Feature 0x20: [0x18a1] ? (hidden, internal)
> Feature 0x21: [0x1e00] Enable hidden features (hidden)
> Feature 0x22: [0x1eb0] ? (hidden, internal)
> Feature 0x23: [0x1861] ? (hidden, internal)
> Feature 0x24: [0x18b0] ? (hidden, internal)
> 
> On Tue, May 30, 2023 at 9:36 AM Bastien Nocera <hadess@hadess.net>
> wrote:
> > On Tue, 2023-05-30 at 00:30 +0100, Stuart Hayhurst wrote:
> > > From: stuarthayhurst <stuart.a.hayhurst@gmail.com>
> > > 
> > > Adds the USB and Bluetooth IDs for the Logitech G915 TKL keyboard
> > 
> > Which functionality gets enabled by that addition, battery
> > reporting,
> > something else?
> > 
> > > 
> > > ---
> > >  drivers/hid/hid-logitech-hidpp.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-
> > > logitech-hidpp.c
> > > index b2cd7527de19..28761272afe5 100644
> > > --- a/drivers/hid/hid-logitech-hidpp.c
> > > +++ b/drivers/hid/hid-logitech-hidpp.c
> > > @@ -4403,6 +4403,8 @@ static const struct hid_device_id
> > > hidpp_devices[] = {
> > >           HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC086) },
> > >         { /* Logitech G903 Hero Gaming Mouse over USB */
> > >           HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC091) },
> > > +       { /* Logitech G915 TKL Keyboard over USB */
> > > +         HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC343) },
> > >         { /* Logitech G920 Wheel over USB */
> > >           HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
> > > USB_DEVICE_ID_LOGITECH_G920_WHEEL),
> > >                 .driver_data = HIDPP_QUIRK_CLASS_G920 |
> > > HIDPP_QUIRK_FORCE_OUTPUT_REPORTS},
> > > @@ -4418,6 +4420,8 @@ static const struct hid_device_id
> > > hidpp_devices[] = {
> > >         { /* MX5500 keyboard over Bluetooth */
> > >           HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb30b),
> > >           .driver_data = HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS
> > > },
> > > +       { /* Logitech G915 TKL keyboard over Bluetooth */
> > > +         HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb35f) },
> > >         { /* M-RCQ142 V470 Cordless Laser Mouse over Bluetooth */
> > >           HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb008) },
> > >         { /* MX Master mouse over Bluetooth */
> > 

