Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC08E644767
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 16:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235045AbiLFPEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 10:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbiLFPE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 10:04:28 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7932FC1B;
        Tue,  6 Dec 2022 06:58:16 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id d31926fc1cae3eed; Tue, 6 Dec 2022 15:58:12 +0100
Received: from kreacher.localnet (unknown [213.134.163.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id D5840940A67;
        Tue,  6 Dec 2022 15:58:11 +0100 (CET)
Authentication-Results: v370.home.net.pl; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: v370.home.net.pl; spf=fail smtp.mailfrom=rjwysocki.net
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>
Cc:     Filipe =?ISO-8859-1?Q?La=EDns?= <lains@riseup.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Subject: [Regression] Logitech BT mouse unusable after commit 532223c8ac57 (still in 6.1-rc8)
Date:   Tue, 06 Dec 2022 15:58:11 +0100
Message-ID: <2262737.ElGaqSPkdT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.163.187
X-CLIENT-HOSTNAME: 213.134.163.187
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrudeigdejtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeffffffkefgheehffelteeiveeffeevhfelteejvddvieejjeelvdeiheeuveeuffenucfkphepvddufedrudefgedrudeifedrudekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrdduieefrddukeejpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeekpdhrtghpthhtohepjhhikhhosheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgruggvshhssehhrgguvghsshdrnhgvthdprhgtphhtthhopehlrghinhhssehrihhsvghuphdrnhgvthdprhgtphhtthhopegsvghnjhgrmhhinhdrthhishhsohhirhgvshesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqihhnphhuthesvhhgvghrrdhkvghr
 nhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgvghhrvghsshhiohhnsheslhgvvghmhhhuihhsrdhinhhfoh
X-DCC--Metrics: v370.home.net.pl 1024; Body=8 Fuz1=8 Fuz2=8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bastien, Jiri,

Commit 532223c8ac57 ("HID: logitech-hidpp: Enable HID++ for all the Logitech
Bluetooth devices") caused my Logitech Bluetooth mouse to become unusable.

Appended is the change I need to make it work again (note that adding the
device ID to unhandled_hidpp_devices[] doesn't help, so there must be some
significant enough difference in how the two cases are handled in the stack).

Here's what I get in the log without the patch below:

[   36.710574] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[   36.710592] Bluetooth: HIDP socket layer initialized
[   36.724644] hid-generic 0005:046D:B016.0001: unknown main item tag 0x0
[   36.725860] input: Bluetooth Mouse M336/M337/M535 Mouse as /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-7:1.0/bluetooth/hci0/hci0:1/0005:046D:B016.0001/input/input14
[   36.728036] input: Bluetooth Mouse M336/M337/M535 Consumer Control as /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-7:1.0/bluetooth/hci0/hci0:1/0005:046D:B016.0001/input/input15
[   36.728823] input: Bluetooth Mouse M336/M337/M535 Keyboard as /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-7:1.0/bluetooth/hci0/hci0:1/0005:046D:B016.0001/input/input18
[   36.731550] hid-generic 0005:046D:B016.0001: input,hidraw0: BLUETOOTH HID v12.03 Mouse [Bluetooth Mouse M336/M337/M535] on 9c:b6:d0:96:8e:c8
[   36.833039] logitech-hidpp-device 0005:046D:B016.0001: unknown main item tag 0x0
[   36.999064] logitech-hidpp-device 0005:046D:B016.0001: Device not connected

and here's what I get with it:

[   43.642546] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[   43.642559] Bluetooth: HIDP socket layer initialized
[   43.652898] hid-generic 0005:046D:B016.0001: unknown main item tag 0x0
[   43.653833] input: Bluetooth Mouse M336/M337/M535 Mouse as /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-7:1.0/bluetooth/hci0/hci0:1/0005:046D:B016.0001/input/input14
[   43.655025] input: Bluetooth Mouse M336/M337/M535 Consumer Control as /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-7:1.0/bluetooth/hci0/hci0:1/0005:046D:B016.0001/input/input15
[   43.655400] input: Bluetooth Mouse M336/M337/M535 Keyboard as /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-7:1.0/bluetooth/hci0/hci0:1/0005:046D:B016.0001/input/input18
[   43.657521] hid-generic 0005:046D:B016.0001: input,hidraw0: BLUETOOTH HID v12.03 Mouse [Bluetooth Mouse M336/M337/M535] on 9c:b6:d0:96:8e:c8

The only difference seems to be that in the former case the logitech-hidpp
driver tries to bind to the device, but I guess that is expected.  However,
when the device ID is added to unhandled_hidpp_devices[], the messages look
exactly like in the "good" case, but the mouse still doesn't work.

Thanks,
Rafael


---
 drivers/hid/hid-logitech-hidpp.c |    3 ---
 1 file changed, 3 deletions(-)

Index: linux-pm/drivers/hid/hid-logitech-hidpp.c
===================================================================
--- linux-pm.orig/drivers/hid/hid-logitech-hidpp.c
+++ linux-pm/drivers/hid/hid-logitech-hidpp.c
@@ -4367,9 +4367,6 @@ static const struct hid_device_id hidpp_
 	{ /* MX5500 keyboard over Bluetooth */
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb30b),
 	  .driver_data = HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS },
-
-	{ /* And try to enable HID++ for all the Logitech Bluetooth devices */
-	  HID_DEVICE(BUS_BLUETOOTH, HID_GROUP_ANY, USB_VENDOR_ID_LOGITECH, HID_ANY_ID) },
 	{}
 };
 



