Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8550271608D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbjE3MxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjE3Mw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:52:59 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DD5E69;
        Tue, 30 May 2023 05:52:25 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5147a478c38so6616820a12.0;
        Tue, 30 May 2023 05:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685451142; x=1688043142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6JUo1zqQxsrbPT3snUxLp6lPe2DoZoEm6bZ9a8lA3Q=;
        b=KuvcLQBISLdFT4LdyieRSqFJccb1L1IHt2dr2o3Fqn0moonRSnTh3eSnAYyCJKz2Eb
         CbagAt1x0ZHittThxsIfrK84dS8PinXNg5lA2BMliMQVQdhmwAbs9ejbJLDuafMxo6Wn
         j23sRmZy3FwVqpiyM9zJRSzaRsw4uAF10PudJk7vvnD24KAeAXxgy1ze8WN/7ktvYdui
         s8QcgkSPkQ8oStgWAhmLedOUX6Bw0qj3HV+QVU3JTDX3YpY+dswTJz7MT2uAt2A/NLzI
         Q57WURwIr/+kvSWXaSJSHBELNh1BjYu08lfkwCloHR8zooO+QIkvdhks8njgT2iGGQLG
         Psdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685451142; x=1688043142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s6JUo1zqQxsrbPT3snUxLp6lPe2DoZoEm6bZ9a8lA3Q=;
        b=ML4LWIT6kegjnUd79PKoVWrfgCAYHMNIs9eYYKx1zX/WCs+LD15IAY7dJ95+9ekw8z
         VVmLj0rt8VnEWBAZljyqtd8IEAM6QE14QmfiV8kPn747BKp8bKCXrUcRN2z1NZyfhBBz
         giloUdT7Z1hbaGHzkb/48D4JhOWX5CAKZ16PSoFp61s0cpNJX0TgJ5UmzM3npATLnrMA
         ra2nxZ36I5NyFe0XOaWPf/+ztPRFuNPDM4WWuNTu2N+GkHDYyUKB3v/E5sQW7i6XHMLy
         ibdJDCUOfjJL3E9+duU1yIx2e1NlFquLdsqPHgMcuRavb6Ge7CBlZhEynXiM8jx84hag
         /gfQ==
X-Gm-Message-State: AC+VfDyfKLgvqDgDelANcWG0Mbk2Pj0nhzIIongopyVM/mJFm3e7XpH2
        Pn4yIvr0J9y/SAXzOk+Gxjth2qz+933hWlihAjk=
X-Google-Smtp-Source: ACHHUZ4O7s8Yz1sFhni9i89kWz6Lhkqr06JWBzPB22KPr9DbIAZukT4HHpHXsAxPcv7gDDnrK6GvYHcn4JQZ8JesUho=
X-Received: by 2002:a17:907:3f9c:b0:94f:3b07:a708 with SMTP id
 hr28-20020a1709073f9c00b0094f3b07a708mr2960147ejc.29.1685451142345; Tue, 30
 May 2023 05:52:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230529233025.22932-1-stuart.a.hayhurst@gmail.com> <468317007b2bcbcce28778f9a1d3ae0426563522.camel@hadess.net>
In-Reply-To: <468317007b2bcbcce28778f9a1d3ae0426563522.camel@hadess.net>
From:   Stuart <stuart.a.hayhurst@gmail.com>
Date:   Tue, 30 May 2023 13:52:11 +0100
Message-ID: <CALTg27=5QMusk07L0DM6GKKV2hd6da--L-vnWxE64-O=LKOwRw@mail.gmail.com>
Subject: Re: [PATCH 1/1] HID: logitech-hidpp: Add USB and Bluetooth IDs for
 the Logitech G915 TKL Keyboard
To:     Bastien Nocera <hadess@hadess.net>
Cc:     jikos@kernel.org, =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@riseup.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using https://github.com/cvuchener/hidpp, the keyboard now seems to
report the following:
Logitech G915 TKL LIGHTSPEED Wireless RGB Mechanical Gaming Keyboard
(046d:c343) is a HID++ 4.2 device
Feature 0x01: [0x0001] Feature set
Feature 0x02: [0x0003] Device FW version
Feature 0x03: [0x0005] Device name
Feature 0x04: [0x1d4b] Wireless device status
Feature 0x05: [0x0020] Reset
Feature 0x06: [0x1001] Battery voltage
Feature 0x07: [0x1814] Change host
Feature 0x08: [0x1815] Hosts info
Feature 0x09: [0x8071] RGB Effects
Feature 0x0a: [0x8081] Per-key lighting v2
Feature 0x0b: [0x1b04] Reprog controls v4
Feature 0x0c: [0x1bc0] Persistent remappable action
Feature 0x0d: [0x4100] Encryption
Feature 0x0e: [0x4522] Disable keys by usage
Feature 0x0f: [0x4540] Keyboard layout 2
Feature 0x10: [0x8010] G-key
Feature 0x11: [0x8020] M-keys
Feature 0x12: [0x8030] MR
Feature 0x13: [0x8040] Brightness control
Feature 0x14: [0x8100] Onboard profiles
Feature 0x15: [0x8060] Report rate
Feature 0x16: [0x00c2] DFUcontrol 3
Feature 0x17: [0x00d0] DFU
Feature 0x18: [0x1802] Device reset (hidden, internal)
Feature 0x19: [0x1803] ? (hidden, internal)
Feature 0x1a: [0x1806] Configurable device properties (hidden, internal)
Feature 0x1b: [0x1813] ? (hidden, internal)
Feature 0x1c: [0x1805] OOBState (hidden, internal)
Feature 0x1d: [0x1830] ? (hidden, internal)
Feature 0x1e: [0x1890] ? (hidden, internal)
Feature 0x1f: [0x1891] ? (hidden, internal)
Feature 0x20: [0x18a1] ? (hidden, internal)
Feature 0x21: [0x1e00] Enable hidden features (hidden)
Feature 0x22: [0x1eb0] ? (hidden, internal)
Feature 0x23: [0x1861] ? (hidden, internal)
Feature 0x24: [0x18b0] ? (hidden, internal)


On Tue, May 30, 2023 at 9:36=E2=80=AFAM Bastien Nocera <hadess@hadess.net> =
wrote:
>
> On Tue, 2023-05-30 at 00:30 +0100, Stuart Hayhurst wrote:
> > From: stuarthayhurst <stuart.a.hayhurst@gmail.com>
> >
> > Adds the USB and Bluetooth IDs for the Logitech G915 TKL keyboard
>
> Which functionality gets enabled by that addition, battery reporting,
> something else?
>
> >
> > ---
> >  drivers/hid/hid-logitech-hidpp.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-
> > logitech-hidpp.c
> > index b2cd7527de19..28761272afe5 100644
> > --- a/drivers/hid/hid-logitech-hidpp.c
> > +++ b/drivers/hid/hid-logitech-hidpp.c
> > @@ -4403,6 +4403,8 @@ static const struct hid_device_id
> > hidpp_devices[] =3D {
> >           HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC086) },
> >         { /* Logitech G903 Hero Gaming Mouse over USB */
> >           HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC091) },
> > +       { /* Logitech G915 TKL Keyboard over USB */
> > +         HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC343) },
> >         { /* Logitech G920 Wheel over USB */
> >           HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
> > USB_DEVICE_ID_LOGITECH_G920_WHEEL),
> >                 .driver_data =3D HIDPP_QUIRK_CLASS_G920 |
> > HIDPP_QUIRK_FORCE_OUTPUT_REPORTS},
> > @@ -4418,6 +4420,8 @@ static const struct hid_device_id
> > hidpp_devices[] =3D {
> >         { /* MX5500 keyboard over Bluetooth */
> >           HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb30b),
> >           .driver_data =3D HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS },
> > +       { /* Logitech G915 TKL keyboard over Bluetooth */
> > +         HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb35f) },
> >         { /* M-RCQ142 V470 Cordless Laser Mouse over Bluetooth */
> >           HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb008) },
> >         { /* MX Master mouse over Bluetooth */
>
