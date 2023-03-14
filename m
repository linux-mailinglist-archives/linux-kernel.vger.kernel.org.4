Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA3F6B8DA4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 09:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjCNIkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 04:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjCNIkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 04:40:35 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DB66583;
        Tue, 14 Mar 2023 01:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1678783205; i=l.guzenko@web.de;
        bh=Ctk/zl6GMWowK4nKMV2F8aNscA/SpH4/y3AJ82A4BlI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=NmdRDov8yeUCL8oEgu9AakPkJS6BhMHRwd7PP8fRUctaTvRWKCqCqt8K8dNA3xvOo
         pCQqJj084kg4Hf2AlwW83Pnuc12c/ozZZiyv2Gp1vX1r3xH+2SzWgUVVYOY8IiOXwX
         4unor0N8witnQGMkS7j7moaTqkEuWhNDvnj3Vp7sWEdqWm97HchpyQh7vcXThfQdLw
         WoCwVjSwDw1F8od0ZYbscBbuUgib4Vn42xC6zMKkMBqjsETnymyB9QjoReNT8M1jW6
         52Pwrw4NkhE7sJRYkKReeMf8J91Ul7+N3mjnlO9V3u09XbbWSmJKc1BCndwK6wcZA+
         4DgurSvutROKA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from luka-spectre.d.ethz.ch ([195.176.112.245]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MgiXQ-1qAEUi3hT2-00h6Gj; Tue, 14 Mar 2023 09:40:04 +0100
From:   Luka Guzenko <l.guzenko@web.de>
To:     benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luka Guzenko <l.guzenko@web.de>
Subject: [PATCH] HID: Ignore battery for ELAN touchscreen on HP ENVY X360 13-ar0xxx
Date:   Tue, 14 Mar 2023 09:39:35 +0100
Message-Id: <20230314083935.13331-1-l.guzenko@web.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:e44qeSup14mtbtiDyAvqhJ3+As5aZVD8b+7B2cy2pSKITXgi2du
 XCoA1zTn2dxj2PuWinkO0nMoYsUlHe8HjbvVkeQUxhcmcA/G0cJQKxdBEcbg1np2fKIoL8D
 ifuQnggukwg5JaM3r4gVDzyZ8ZxDO0p41FrVXRd8tifDjkOSu41L/a7eOOgH2RHOX8c2n1A
 iCk1ZASsaeiNh5yTyXbhg==
UI-OutboundReport: notjunk:1;M01:P0:gd0s568P7qw=;xZ+6DBij06NM6R5vTo4LWpq8Qhz
 kV5gKkdG2A7cJ9Lz8hMoK4asi4NAqpiDEMS3gDQO6+rMjGTigEiFC2YavnoVo8Qw6LDYngAtg
 CHUqo7l0uVselZz5IEa6Tdtn1Vn6lhtJn3IpgBitZaKlBU/NfuGxmlmp5SCAfjDLW0w24My2u
 VFw0hY1IRvh+LSg/tPwu0+q09CfnbSlU9Lw2blHx8YWkH3OpQU1t7GBCPldj7Gu/DS5OXIzPF
 /3v9Y5jM4eWV/UMZrlr+hyC2K9T7CCQC0DfAe7a+f2NOW4SrN2b2WBIgBHmBDrrzSC18fxBOW
 BnZObquntBX5Hz05cy60L6zGYAcIAiF7IfxM8B4BgUNQqgH5wAE0ERU8nAWVNhpXaVgD/bi9j
 HEtDUqTg4q+zgWt71OZnbK75anVD5EuEOoQHHQU/o55cdHK3rEetcHlin0/qcKM+J7GGyL5Kl
 rU3PCieYQkiEuWD+mpFIJeyRu4UZ0JfL9zr4FuZ7WDSdipvKIxZo+vZj36vY1iZVR0i2dLXmG
 MJ3V1Gy5AWksg+r3Dscfk6hkYNfHnR32TImd2ynsegaCs6uzWE2b/eoErBr18sLyzhNEDb2WG
 Svy1Gw5gp66e9bJMGdHA7O6jRp3qiuproJ9qX0vZl4DhFt+m/qaEwEPybibt903jVpJKyrzsq
 +/dVW4cvwQ3wf3kn0qYRhJ6LQqkhzZ7xJ4+GXkjqg5lKqNPCSMlURTpjAcqJ9pgyQyOeKR/Ue
 ppW4RrBLMBh3bwFqDXEi8UG+d4gawuq1HGRBG3TbgQXJ+6XNYLRUJMenLj9MMi5x68zcE6wGA
 vByr4CI1sj1mAx+1OYUb1mBh+ZIQhVsGm1Nic3kQ+H6ZaXrJiBVr6XzdPExJRNCWft3TjNTdU
 n4rVfaiDThMl7A4bbiBNJxZE7M5TJsLiedm0Wdl/mOc48rrjxVp/aVfjmE9+EnsfForz8R29M
 XNejO59qur3WmO5HKa/9M1286Ic=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
index 63545cd307e5..b76462881cea 100644
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
index 7fc967964dd8..9639479600f4 100644
=2D-- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -382,6 +382,8 @@ static const struct hid_device_id hid_battery_quirks[]=
 =3D {
 	  HID_BATTERY_QUIRK_AVOID_QUERY },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UGEE, USB_DEVICE_ID_UGEE_XPPEN_TABLET_DEC=
O_PRO_SW),
 	  HID_BATTERY_QUIRK_AVOID_QUERY },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_HP_ENVY_X360_13_AR0XX=
X),
+	  HID_BATTERY_QUIRK_IGNORE },
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_HP_ENVY_X360_15),
 	  HID_BATTERY_QUIRK_IGNORE },
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_HP_ENVY_X360_15T_DR10=
0),
=2D-
2.39.2

