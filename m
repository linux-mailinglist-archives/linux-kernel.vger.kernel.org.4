Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEEC676051
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 23:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjATWnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 17:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjATWni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 17:43:38 -0500
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFEA13DF7;
        Fri, 20 Jan 2023 14:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1674254604; bh=SmK4fdjCc+5+gIx3b4Eq/5hJTyyAOSXxn2Irl+5x9sQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=rbWwDpsoaA9989HeUv8NI0B38u35ZqWZEbTUE4jON1fFxqsrYsLMMVEg8KSBgNGUs
         wNisqI2vHvqdS/FCYk70XhjPKc0emCd3spjJ+lMu5Xvzu6JSyWWSxmTmAqNTzo5lRl
         +h3os2BZAa35HBTcYX6M9LoHZvobIagXrZQOVmyIBd5J9APkN9cugULTa8nf9PCVUE
         kqCcgtzmEXMNjInMMrMqqFlf3hk64jlOG0N/NJbBkxljgLpPbOrHO4LpsIAImycW4V
         hMsPI1nMsqDDuZx/WMuRMPjKNDyxN/sQbIcAvbTcqUGP9uj92Ej6fScpCuYCgvZoKx
         Ub4sPEQyJ493Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from luka-spectre.fritz.box ([77.182.131.156]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1N8n4G-1ogAU42qsY-015sFO; Fri, 20 Jan 2023 23:38:14 +0100
From:   Luka Guzenko <l.guzenko@web.de>
To:     jikos@kernel.org
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luka Guzenko <l.guzenko@web.de>
Subject: [PATCH] HID: Ignore battery for ELAN touchscreen 29DF on HP 
Date:   Fri, 20 Jan 2023 23:37:41 +0100
Message-Id: <20230120223741.3007-1-l.guzenko@web.de>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XHSDTG/Z83oXdh/P7+KCto1i2A1FPHqUwt4R7sQRZr9zP6M0smE
 +duC7xldbCGIZLf4H4hBvG3SPFrO0XsYblTc08kw+ytZylUrVTTrJ3fVvfHZvPUGXv+dFM+
 tT2hAfAAmfUz3aiD1sZ2hHZZXwLlJP7AXfPa0lBtc936SmMYICzrCHIrj9rSkvLVH/pZn+s
 Ra8XW82cxWbpwXmxoDKkg==
UI-OutboundReport: notjunk:1;M01:P0:7OmScQ0ZIoI=;qa+lcBfvBh2BVktoVTfJTom3f5l
 /kTUcjmDjm/EkVgjfD/ZOI+7xuTPp9WmBn48ASEbA76ZmObSLCiFilL042Jt1kncMU3TqV3of
 iEZ1ySA/rHvPEJrR3fPu8ZZrfszS076b7bjRLQFftoFbIg0tzfK/VxeFpCxsrOxa2TDcRZJ/a
 HKx4J+GY6zrTBehOwLH2iIWSUzI5NXmjAAk6EDjzwU6dqj3bSU+vxEIN2J85TCgi2o2nUPCTI
 tP2gLMyjrA7zhH7CoiWN1TikNK3Z7/QiZJN2niH4vTqkoTEc9F4mvVJXUfH/iX53i/MfIITAA
 6zD9Z+ot+3o1qwxh5GkZvSawC6TbbLRHJnsw3L/hAhccBDYejx701326e/ctozUEmU0YZKd3V
 xSvzHkxof0zt6RQm/g8LIcGnXzfncaAs5+10dF3Hhn0cahJi2xm3jGzWh4ZR2hzQmKj0J64D2
 UgGLaRuuexvB3PVTfwA8traXAeVAAk3koC35Tp5Xl8VoyaEv1BuDnafJBL6LUv4qKHZJ1md9+
 ZKe0fI+a2mFi+KT4waCvDSa2W4/msCa3frcPjTOAuhad7sWgRYS+vMI6IOlpUXworrxd+Iypi
 heFChKTG8geItuG/KzzZc2MxX5nb4WlXuQwB/wWBh4YicT43eMt4SBD9zY/OZFUDAUG6F3b1K
 pQ7dU44iw7fS13984Esq5nIm5GyN4n5FQ8bWKd9QF3eiZxB5045bxd6CteUtlFSjRwCo9z4sn
 plqNagVry9bjKUsHCV6aUlf8h/RxqDbBIU8y1u6+NHHPedHps1LUcieu4iX43KU6/utWW16RW
 wy1rlzeyNeTGGC1iKcAPdTWNZCK9/i0O9ZDFOLbgIBEvN+dWpJxSI3BfWgRGrnUqNDB3Yqijp
 t0f2FgUKIWTiFW4Eeh8f+BVa2PByUR/fSywIDYTkJgqF5Z2/lzGEcrSIAoH5E9i4NAJqqsZdu
 v5ugP8k0bYu19Gr3IpbCg7VyD8c=
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
+#define I2C_DEVICE_ID_HP_SPECTRE_X360_13_AW0020NG  0x29DF
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
0020NG),
+	  HID_BATTERY_QUIRK_IGNORE },
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_SURFACE_GO_TOUCHSCREE=
N),
 	  HID_BATTERY_QUIRK_IGNORE },
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_SURFACE_GO2_TOUCHSCRE=
EN),
=2D-
2.39.1

