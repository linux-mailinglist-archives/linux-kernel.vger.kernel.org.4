Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F116456C8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 10:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiLGJrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 04:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiLGJra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 04:47:30 -0500
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB838140F7;
        Wed,  7 Dec 2022 01:47:29 -0800 (PST)
Received: by mail-qv1-f48.google.com with SMTP id c14so12306402qvq.0;
        Wed, 07 Dec 2022 01:47:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GsGrbThrtxtMJ84GvLOA4rnIxBqoItSrS0phUYvneA0=;
        b=JcIeU63c5fRCA5Kx5yZmDbahtGGxyYXbBJoGLrmrAB2Eo08TSgkrvpXfDHxwLqSZxd
         U4+VcC/BcRq4X29G0ElCnaqgEaPVlmgkE37h+TypiDNXc5oBfoGF545RfCS9OdO2x6zG
         +P+/y7+rXqtw4sT2g7/Xp6zyAYvcW92XdVJSEM7HpFvLAmwTFVjoBUdiSX1IuctOiX2T
         kUg/hmpCQnfFrxwhHPhh9bEK/t31yAniP3HH1RGhQgG96cQbMy/IfMQjSu4GGzNq2okR
         wgm6F2+cCVDknwoZXeLHI3P7HotPpnf+yCRNJK5aWTDaFIIe5UyJk6J8O90rFhNJwkm5
         90DQ==
X-Gm-Message-State: ANoB5pk5RI6jYmaBoFyQcKPCgSUN0cW1yT7NTUyAUgkKBPSOQqbi2QN6
        yD1lYWr0N4dsjvsQOND+H3cX0TPDYv9MZT2H4UA=
X-Google-Smtp-Source: AA0mqf6aQiHVh2t+AbPgqM9has7p+3ewqE0sjrB14lnK7fxyohsHeD6HP23hGCVxQEnoP9Yj9UM7dHuIc8n9Tm0i60g=
X-Received: by 2002:ad4:534b:0:b0:4b1:8429:a8a7 with SMTP id
 v11-20020ad4534b000000b004b18429a8a7mr64626603qvs.52.1670406448847; Wed, 07
 Dec 2022 01:47:28 -0800 (PST)
MIME-Version: 1.0
References: <2262737.ElGaqSPkdT@kreacher> <5647715.DvuYhMxLoT@kreacher>
 <2283816.ElGaqSPkdT@kreacher> <e7eb0e0c9aea30c0e3205b2f3d96b74a52283b40.camel@hadess.net>
In-Reply-To: <e7eb0e0c9aea30c0e3205b2f3d96b74a52283b40.camel@hadess.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 7 Dec 2022 10:47:17 +0100
Message-ID: <CAJZ5v0ibpzoBLXKiqzciYv1Htks0=4+4_XGLvpH7MCyFoYJiDg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] HID: logitech-hidpp: Add Bluetooth Mouse
 M336/M337/M535 to unhandled_hidpp_devices[]
To:     Bastien Nocera <hadess@hadess.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jiri Kosina <jikos@kernel.org>,
        =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@riseup.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 7, 2022 at 10:29 AM Bastien Nocera <hadess@hadess.net> wrote:
>
> On Wed, 2022-12-07 at 10:12 +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Evidently, Logitech Bluetooth Mouse M336/M337/M535 (0xb016) does not
> > work when HID++ is enabled for it,
>
> This needs the output of the hidpp-list-features tool mentioned earlier
> in the thread so we can avoid words like "evidently" and provide
> concrete proof.

Well, so point me to a binary of this, please.

> But why is it needed in this case?

Because it doesn't work otherwise.

> We purposefully try to avoid blanket
> blocklists. The lack of HID++ can be probed, so the device should work
> just as it used to (if the fallback code works).

No, because the hid-generic driver has no way to check that the probe
function of your driver fails for this particular device.  The probing
of hid-generic will fail so long as the device matches the device ID
list of any specific HID driver.  With patch [1/2] from this series
applied this is unless that specific driver has a ->match() callback
rejecting the given device.

You'd need a list of drivers that have been tried and failed somewhere
for that and AFAICS no such list is present in the code.

So a minimum fix for 6.1 that actually works for me is to add the
non-working device to the blocklist.  More sophisticated stuff can be
done later.

> We should only list devices that need special handling, and the ones
> that don't work once HID++ was probed unsuccessfully.
>
> >  so add it to the list of devices
> > that are not handled by logitech-hidpp.
> >
> > Fixes: 532223c8ac57 ("HID: logitech-hidpp: Enable HID++ for all the
> > Logitech Bluetooth devices")
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/hid/hid-logitech-hidpp.c |    1 +
> >  1 file changed, 1 insertion(+)
> >
> > Index: linux-pm/drivers/hid/hid-logitech-hidpp.c
> > ===================================================================
> > --- linux-pm.orig/drivers/hid/hid-logitech-hidpp.c
> > +++ linux-pm/drivers/hid/hid-logitech-hidpp.c
> > @@ -4274,6 +4274,7 @@ static const struct hid_device_id unhand
> >         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
> > USB_DEVICE_ID_LOGITECH_HARMONY_PS3) },
> >         /* Handled in hid-generic */
> >         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
> > USB_DEVICE_ID_LOGITECH_DINOVO_EDGE_KBD) },
> > +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb016) },
> >         {}
> >  };
