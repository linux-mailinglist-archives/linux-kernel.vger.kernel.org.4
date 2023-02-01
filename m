Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2FF685C8C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 02:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjBABPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 20:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjBABPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 20:15:08 -0500
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020082E82A;
        Tue, 31 Jan 2023 17:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1675214102; bh=DqekhiSJm1T8wnRWgxaRj/AIyfp4gkNM2suDsJHedPQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=CNEHieuqAx4PysftJ4B8Jg52ktIDTr8sLgVwQ+rv6QuHwI7w6u084e+EXVhgAEfAT
         2Wewpmp3RrNVoYFqDMAXGgJwRx2R7SBcDOkkziSQyrovRK7QeHO0OFLf3vJOopOHbK
         DsHeSaZvnXsv4UjKIUurWfxAShlNfjPmYqs/eBEdoTcyKDiLGG1mfSzjm9PriIA4sl
         eiaYWG3SDnmLYQhXkYrpdxrh46owk4rM95LI3cEji20scVRcDqiE3cA0FxxVbw8r1j
         IwWI6FvFOGGGAVxR3ZdlaDNubKVRofuZmBbDyfuXG5JG0Guq9ZxxJ09OPpvU3b86/H
         WgkhG3i5d1Btw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from luka-spectre.fritz.box ([77.189.113.187]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MYLmq-1pAOgO2LoI-00VR14; Wed, 01 Feb 2023 02:15:02 +0100
From:   Luka Guzenko <l.guzenko@web.de>
To:     benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luka Guzenko <l.guzenko@web.de>
Subject: [PATCH v2] HID: Ignore battery for ELAN touchscreen 29DF on HP
Date:   Wed,  1 Feb 2023 02:14:37 +0100
Message-Id: <20230201011437.33330-1-l.guzenko@web.de>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tF3phlFBStpC5YhXGcwUe6ABAGGfWxeWHVa2p3ElhF5sQsny7kO
 kEvFNTRl7BfBR/L53xgsVSIm+tXoQxRQXTChOce8tIsJelM0VBQowfn/Y4ldJmHaoM/5Ewf
 wzsew48aXK9Sc/q4f3g6YrmCrcxNY9mvyXhgLVA7+PiEqj3cLItqwQkiNdSIc/PPMpJg5Yb
 cqoNHm8dyKVHWzveeRjqw==
UI-OutboundReport: notjunk:1;M01:P0:RfFrLgyRLIQ=;7H19azSMDjvJvalM8c7ruIsjvOT
 uwr+KJeihIgqitS+Gw/BtEOqELVT95jPinfYYp2IPE31waswaGrRpA0Ac4ZLhDZEpW1M1J/a+
 2IkYkvdV9MLvZcV5l/OI567piWAWpmQ6PZa/dWrBzrT1p2YEur0Prjv/mTgpk650elMI7PLda
 WzPu+37I+S4z4z0DMwBFwXlyIyv+DqgbKrwe83W/tSoy3wICHChbk8du0Zbdqq/2OPG9sp8CI
 yVYlo2eB78Z/Vpj2v/4/An5HwNZjn68DGF9Rl5oHXcHbRl3g5JyTc0a91H5Rcc6ed7WmpvFhn
 FwkQm/38AMIClFgVInXHnpiI9kmcfrKhIJyAjNTXxlpeKEgwxuWLCh0KVLRzYlJYzJfnGFOZ4
 Cbcy5KKOEgDFIMSvTsPUm4+AXGj16m4EMDXkzWBIFcA050xjg2oUx427v8M5/HC8eIlGReQGM
 VSaE60KFw57PPy3Z/nvwyqyAiGLZRO2Iat1av8iTqvnzhpOtug/HVDBZwdJmJeUVk7tTrKkg8
 huXGOIMK2JlQm1XVFPUA4ZsjpSPLhwbbvyJd4KFDoENbHp7w5YjqAtIapbyFmlrBqoTthFd6d
 QJTTJWs8AsLM12jynUhotFroidP7IMMeA/uQ5rmATGHHThtqWGMLYxUbU14lFfDhtQ6wIqYOG
 +Ep++xEJF4DGoZMm8FFemb3P7OigQEtYwQiXrH52QVXCmJxlwnzWyWndrC7lUouL+0NGSqzaw
 Bu62e52To+CqLhzGDHtxXqg2ydJluKbrRDiVbFnJuEqm8mXGwy09WXkpRDNrFWkqrtaXYZpeR
 JmGwZ13q8R47qY0rpo8duGTJkTBvXQP10qzwp64w6E4J5TKyN+LZ+Mi7yjrkX170hNqfEFyRV
 ZTqImTaJTbKXmif5Sg2/Lx+XP8T4mjDmyd3kx/1lu2mo4iuX4IrvpJayBJh2HnzYwrW/AojTb
 9Uk7gbjs23Q9yGgBHse7nJ43gY0=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The touchscreen reports a battery status of 0% and jumps to 1% when a
stylus is used. The device ID was added and the battery ignore quirk was
enabled for it.

Signed-off-by: Luka Guzenko <l.guzenko@web.de>
=2D--
V1 -> V2: linux-hardware.org suggests that this touchscreen is present in =
all
	  devices of the Spectre x360 13-aw0xxx family. Renamed Device_ID
 drivers/hid/hid-ids.h   | 1 +
 drivers/hid/hid-input.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 82713ef3aaa6..78f4846e5711 100644
=2D-- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -414,6 +414,7 @@
 #define I2C_DEVICE_ID_HP_ENVY_X360_15T_DR100	0x29CF
 #define I2C_DEVICE_ID_HP_ENVY_X360_EU0009NV	0x2CF9
 #define I2C_DEVICE_ID_HP_SPECTRE_X360_15	0x2817
+#define I2C_DEVICE_ID_HP_SPECTRE_X360_13_AW0XXX    0x29DF
 #define USB_DEVICE_ID_ASUS_UX550VE_TOUCHSCREEN	0x2544
 #define USB_DEVICE_ID_ASUS_UX550_TOUCHSCREEN	0x2706
 #define I2C_DEVICE_ID_SURFACE_GO_TOUCHSCREEN	0x261A
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 9b59e436df0a..27f17fafce58 100644
=2D-- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -384,6 +384,8 @@ static const struct hid_device_id hid_battery_quirks[]=
 =3D {
 	  HID_BATTERY_QUIRK_IGNORE },
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_HP_SPECTRE_X360_15),
 	  HID_BATTERY_QUIRK_IGNORE },
+	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_HP_SPECTRE_X360_13_AW=
0XXX),
+	  HID_BATTERY_QUIRK_IGNORE },
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_SURFACE_GO_TOUCHSCREE=
N),
 	  HID_BATTERY_QUIRK_IGNORE },
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_SURFACE_GO2_TOUCHSCRE=
EN),
=2D-
2.39.1

