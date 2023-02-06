Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5B668C9BC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 23:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjBFWqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 17:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjBFWp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 17:45:58 -0500
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A27930292;
        Mon,  6 Feb 2023 14:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1675723555; bh=GIC3tTL/tf2O2wwjbxfda9MuiAPNhorCginPDgE6TtY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=SV8dbsPhdygHy+0aIW90ORwH3to022FtJ/WADg9gLH2FR2QaPft4PAnmZg6PRd1Zp
         68tKSKhFCsZonqXRDbucB/MePeyzoi7eHpqjAzXaq5DgnOzZ51BBCz2P1sDBIyRtNT
         fN+CtQaI3ZgSLbA8Mc0uLMmuiK0LoKduksLYGgRniOnjtJlsnA/j8R+pffMGUsBoiz
         W0ezCTGMz6WRUiFFEUGxr38XwFLaVnAdWKP/xEa/tJsLq8YSr2DZeAaP+AJpNGgzc9
         72nmII0Z3uXiyuhX9SjJju+cyNyJCotdoci7hdMnGJXUdEamznCTiIFTbs+O2pyyeL
         uQcjE2Cn8UREA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from luka-spectre.fritz.box ([77.180.149.249]) by smtp.web.de
 (mrweb105 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MoecF-1onPe40NDt-00ozYg; Mon, 06 Feb 2023 23:33:13 +0100
From:   Luka Guzenko <l.guzenko@web.de>
To:     benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luka Guzenko <l.guzenko@web.de>
Subject: [PATCH] HID: Ignore battery for ELAN touchscreen on HP ENVY X360 13-ar0xxx
Date:   Mon,  6 Feb 2023 23:32:18 +0100
Message-Id: <20230206223218.165134-1-l.guzenko@web.de>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+UbsIwvatb2wLqWu1Rrcz0XkEx6L4z6oOodzzuGRKYoLgDYy/ER
 fc0jIfgyKPmAtUN2D8TB89rFZFMZJiZ6nUKmHJVveK6vF5M/N23RpnIFEXDGZIs3ISxwF++
 H4EF7ZaIeleqjXUmnPMV2GJIxhjWMGjSQdfcvXgs26iWbG+2hbnRgeBFT2C9MUjCQR7Gcfm
 zwvWlrqNdOQVfmRM6cMNw==
UI-OutboundReport: notjunk:1;M01:P0:rSkds/jlVMU=;Rkg2RXNxWMOK2XDOTnCk2arOY7M
 BbU/A+uxiJmW/kGKUBNptV79KrhJz06pQue65vh2Soe5wZ1AN8pcmVHXlG7iGVuddSzHPiZTE
 3ZehcBweR49yffgJFl+4EMGDGDFL20qcaBRCOHISl1cYOagpiCh5rz88e0yT9fX2KhIChxRmm
 RaOskY85edIztlJ9I2ujMEBoIitLiUuXQnTpBY8C3o4Vy/C4oD+Iw/Yr1znqKuhM8VXgp/ciK
 go86rm8GJJts+rIEYIaAjMNEjEo7n15i+Q6YRUlWoMaeq0LkOhCsOwsLYADDvxoqR9e9i01xx
 aN0CVBEWX4677tYtt9j0dzZ+vpNWdfOyJv5iVcxuKWLHwwCUBt00ggrYY5b2gD+w5moMCTODC
 WvkEflz9apcoFtL3/9SQtphB/lFkcBUZAHzQ2NLLKCTERFbEsw7QAlz704L7OVShepwHluU2/
 FhdNu7zVcG26Me6jDRqPxrqE2bzWvUxHaylJmrJcHT6CitlZ3orX7fWlot9luajYxKSNRvCFd
 hF2AmD+CcqH4nCLAXwVB3t63OCgRRoNIcI7lg9UEft2Fdg2EUidsVXhT47FtHO4fGr4bs+mX2
 ylGeUK2msUl+RwmUQvNWWu3TAbx7nhmB6HMPUOSTWSJ0EoEB89XSjibEGoIcpg/WiB+JomR9L
 roBtxJdzKwrFUJbsfgHf20HPdOLqR6X2up8v1D7iaAFmzUSjj5EYDxfqhJG/G3jBisjJd1SWO
 /goTlinmMRQB6SW6JGSdNCiaZfso/X7Njeot+aTtGMvHU8NUPpA1TW7vZ/JUASmvFW2QvU1nb
 V9FMRavwyJMoGUCg31KN6W0czGUtCi9O0DYr7uVn/rL6mmXlWeEQ7MBw9jSUufpgcJlC8jRcF
 HQ8kiQltmPpRTXgzAsDW3BljwSGa2UcedpzyYGQyS8Vzjw1rsFm/aLwLW+RSTTXMx/UgHrdYD
 QyHpYrLiQJtMqBaTBQ3qniQ3OXQ=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ignore the reported battery level of the built-in touchscreen to suppress
battery warnings when a stylus is used. The device ID was added and the
battery ignore quirk was enabled.

Signed-off-by: Luka Guzenko <l.guzenko@web.de>
=2D--
 drivers/hid/hid-ids.h   | 1 +
 drivers/hid/hid-input.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 0f8c11842a3a..ea6cd7dfa459 100644
=2D-- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -409,6 +409,7 @@
 #define USB_DEVICE_ID_TOSHIBA_CLICK_L9W	0x0401
 #define USB_DEVICE_ID_HP_X2		0x074d
 #define USB_DEVICE_ID_HP_X2_10_COVER	0x0755
+#define I2C_DEVICE_ID_HP_ENVY_X360_13_AR0XXX	0x23B9
 #define I2C_DEVICE_ID_HP_ENVY_X360_15	0x2d05
 #define I2C_DEVICE_ID_HP_ENVY_X360_15T_DR100	0x29CF
 #define I2C_DEVICE_ID_HP_ENVY_X360_EU0009NV	0x2CF9
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 9b59e436df0a..8dc090d9f2d6 100644
=2D-- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -376,6 +376,8 @@ static const struct hid_device_id hid_battery_quirks[]=
 =3D {
 	  HID_BATTERY_QUIRK_IGNORE },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UGEE, USB_DEVICE_ID_UGEE_XPPEN_TABLET_DEC=
O_L),
 	  HID_BATTERY_QUIRK_AVOID_QUERY },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_HP_ENVY_X360_13_AR0XX=
X),
+	  HID_BATTERY_QUIRK_IGNORE },
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_HP_ENVY_X360_15),
 	  HID_BATTERY_QUIRK_IGNORE },
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_HP_ENVY_X360_15T_DR10=
0),
=2D-
2.39.1

