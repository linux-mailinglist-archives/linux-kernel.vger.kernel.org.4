Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7178D6211A6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 13:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbiKHM7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 07:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234270AbiKHM7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 07:59:40 -0500
X-Greylist: delayed 302 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Nov 2022 04:59:38 PST
Received: from mail27.static.mailgun.info (mail27.static.mailgun.info [104.130.122.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B142F665
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 04:59:38 -0800 (PST)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=cyborgize.sg; q=dns/txt;
 s=mailo; t=1667912376; x=1667998776; h=Content-Transfer-Encoding:
 MIME-Version: Message-Id: Date: Subject: Subject: Cc: To: To: From:
 From: Sender: Sender; bh=8C+1x60cHFx8ptFT5ukscAXzWUX6EHT+wW21yOvpskE=;
 b=WnviotCdkUr2QVr2I8Mj69Jq2pnJyNJh8b3wgWb5Lg+dMlXWjVXvE1GvI30aasuYCq8P+DyR
 RbgRq0bP96VNb0jzPwdCn7tnvgIGiaG2fTBhKc+Tc3tj9CCGXXgBaigxRBD9fP+APSTypZ48
 4ILdkSsLwye8hR7bWveDHEib7Ps=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyIzM2MzYiIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCI1Nzg5NGMiXQ==
Received: from cyberarch.. (bb220-255-210-219.singnet.com.sg
 [220.255.210.219]) by 62d140420ffc with SMTP id 636a518ad4231954e23ed2d2;
 Tue, 08 Nov 2022 12:54:34 GMT
Sender: linux-bluetooth@cyborgize.sg
From:   Raman Varabets <linux-bluetooth@cyborgize.sg>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Raman Varabets <linux-bluetooth@cyborgize.sg>
Subject: [PATCH] Bluetooth: btusb: Add Realtek 8761BUV support ID 0x2B89:0x8761
Date:   Tue,  8 Nov 2022 20:54:13 +0800
Message-Id: <20221108125413.216254-1-linux-bluetooth@cyborgize.sg>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Identifies as "Realtek Bluetooth Radio";
used in UGREEN CM390 (P/N 80889).

Device description at /sys/kernel/debug/usb/devices:

T:  Bus=01 Lev=02 Prnt=02 Port=01 Cnt=01 Dev#=  7 Spd=12   MxCh= 0
D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=2b89 ProdID=8761 Rev= 2.00
S:  Manufacturer=Realtek
S:  Product=Bluetooth Radio
S:  SerialNumber=00E04C239987
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms

Signed-off-by: Raman Varabets <linux-bluetooth@cyborgize.sg>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 271963805a38..20dc422378b8 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -543,6 +543,8 @@ static const struct usb_device_id blacklist_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x7392, 0xc611), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x2b89, 0x8761), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Additional Realtek 8821AE Bluetooth devices */
 	{ USB_DEVICE(0x0b05, 0x17dc), .driver_info = BTUSB_REALTEK },

base-commit: b1a2cd50c0357f243b7435a732b4e62ba3157a2e
-- 
2.38.1

