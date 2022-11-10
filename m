Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4E1624C14
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 21:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbiKJUmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 15:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiKJUmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 15:42:37 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7C11FFAB;
        Thu, 10 Nov 2022 12:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1668112944; bh=rmo4JVfDog5xAigKtgT2UyaJyCUuTBirPqF3UvRgNGg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=CTWPiCTt3OfjxbfwCSChhbmwC2q3vratLIC88YKuhQO3hfyufij8BkkeWbgFbdq5a
         IebRXydGJafemUr3/VZwtdWAovcja29DG/kKS3IO+gzZiDlh9BfgMGrV0JzwbI7vab
         h02frJfFTOiQVp9BdubJC7ZYchjb2R/oWVvcNruALUSpy6jsmLCx7Iqry9vbjSiHHW
         itxxFu7IzSKyj/jYw4R4VGQaU49rpiKWz/OLFrgcRevFhw1lxuL5nkz2pM5nqPc9yv
         1ohG2hpUHaszYXQ1GA7zm8wjZ1hEY8YEj16ri45vN0tS/DV2qTrP7l1BC6LQVccThL
         SFJnQ2yPyttUA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from 9300.fritz.box ([93.221.18.29]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mnaof-1pIMa53f0P-00jZKG; Thu, 10
 Nov 2022 21:42:24 +0100
From:   Andreas Bergmeier <abergmeier@gmx.net>
To:     lains@riseup.net, jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] HID: Print specific timeout error in probe
Date:   Thu, 10 Nov 2022 21:41:31 +0100
Message-Id: <20221110204131.1354704-1-abergmeier@gmx.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ky7vsQJgKylO0bQBYoz3/sjTpGST/K5TWHtrBgRZcoKfPj1gLJH
 68CEczY+P6P94vvacNTilBDE/vvbcT3kLJIGrpP8evMQvBFaGxldkmrEWd6nTgMBoN1sFHu
 bpB95ghCy9sfVdzzZGWDFdlK+vOK3gPaydQRbLMb8YLMhl2BpAH7Dr1UNThpCHwIKnCAjqw
 mX/phraZ7SVTumGfKMuVA==
UI-OutboundReport: notjunk:1;M01:P0:i2UKcw+gaCs=;t78I8V9fmboyWMGDlx9vsU+K31a
 S3M9Be8Yb+2TdSOcSBWfn8v5+6diXT9gU2NmKOqmv9aV9op7n7TGur/6PR/ocfaAQtL0WOsbJ
 NYy+0O0okyAOVpluXRr04584Lm4Y1KT8u71x5bdEZqPiguAk/MEOcMvNHT4AsvdRwMbtX4qH7
 lWZ6wvOAJPmwaTKtNpauM/zkIpHXz08bbR/ZsA95UjjMCUWH4/Izrs3ocX47s3/q9s3Uj8uKR
 zlkCamP6rwTJUKAhnM5NX1nYj4NhpWIE0HyDx14dq97sH1RNUlnqxrMHK6cBg4fZsI/KaURhF
 TGmhtJTFx6FJFQX6vEyhpL1ZYXqLmOV0YajtAcOyYbI4mm1F9Yox9PNsIeADHIOWw5+iSlNFc
 LEkGuBKoYxy8LYhGjg6uTrdejXp8w6kerfSuwndVWYQ43ZFHjn0mTJfyHoM4X4J+xgPPpkxUG
 Ewey20U81ci4CXeU1l5yolTMN4FBDf+JjbNU4/IIGw90ElhrIoMeVVMh+Ygqz8VYIGcbt5nm+
 6TOMvH3WXQQfxRtojXGfRJosTTqfYYH1bcXTHs2xAcyhqiYOGAOWg+AOxWmhVZVutzN1JwIVb
 zrGcfWVGuABwkjD9oJfPR8gBWQ4ocmuJ6xjvHv8ZSC4coLPQLuEG5Cqeb7kJ4xpDGel+iUFuA
 UihUAMxrFoV55PG+cNwA0Babfl38TaXXSexwDC6p7kVMQ/Yag3rr+yLBePM9SP9393f/cdgJt
 kAgLNP+ErqymNvDuIWNjMCnLvZMGfQwm874vGpw55HuuEMkftqQru/c8qGv04pHQbEfeEn1wI
 cCbPe6MX4uOEBpArA82HNRIBmAg0JKuwpRJ47hJcJjZq8fPJ7nJOPmlTBCs0ZUu55Jx7PeQNf
 ugsTfK8LQXgEuXva4t9CKfeQLq93yeQcvQvRcNDAc+04yFAGFYdwrHT0KVqHHOoIO4yICm9Gf
 rYlhQg==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When -ETIMEOUT gets reported ensure that the error message mentiones
timeout.

Signed-off-by: Andreas Bergmeier <abergmeier@gmx.net>
=2D--
 drivers/hid/hid-logitech-hidpp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-h=
idpp.c
index 20ae7f73ef08..a0c148a8df6c 100644
=2D-- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4438,12 +4438,16 @@ static int hidpp_probe(struct hid_device *hdev, co=
nst struct hid_device_id *id)
 	if (hidpp->quirks & HIDPP_QUIRK_UNIFYING)
 		hidpp_unifying_init(hidpp);

-	connected =3D hidpp_root_get_protocol_version(hidpp) =3D=3D 0;
+	ret =3D hidpp_root_get_protocol_version(hidpp);
+	connected =3D ret =3D=3D 0;
 	atomic_set(&hidpp->connected, connected);
 	if (!(hidpp->quirks & HIDPP_QUIRK_UNIFYING)) {
 		if (!connected) {
+			if (ret =3D=3D -ETIMEDOUT)
+				hid_err(hdev, "Device connection timed out");
+			else
+				hid_err(hdev, "Device not connected");
 			ret =3D -ENODEV;
-			hid_err(hdev, "Device not connected");
 			goto hid_hw_init_fail;
 		}

=2D-
2.34.1

