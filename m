Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C7D612B46
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 16:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiJ3PlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 11:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJ3PlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 11:41:17 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43B8B2;
        Sun, 30 Oct 2022 08:41:16 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1322d768ba7so11333140fac.5;
        Sun, 30 Oct 2022 08:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/MTFfhzetCC3xXz8zMuwlhQvQgzdRQHLg9ZcPquOqc=;
        b=cvPQ5FM4rEkKDFrCj07zfDVmYUD1Z4H/LmWcJN/w4TtqCv2Oxh7G0AheHeKW7J9gp5
         UrMC84Z2mleOieI2lR09Z5Dhq/BwGkuKTdkJTGTdncpWO108QwSfEPnKRRSf8020Vyhe
         2e7PrFuC+wR7RnxNfgxSxxRMhgeS8hKAKNJDJ+vb64u/YZfRXqDwQb0wF+1MYVk9HHQF
         Uj/VNfxvJp+Kv3pztMAK1RcXSlmruuLJ9oKCjav4IwUHPOgfmwQw4wYPcg+0M/x6+q/u
         jVEH860uBTQbdAE8QOjMystvxahd/RGP/A2/i7iSJ3C+4SiDwsrCLxhJAh2Sr9SsWhdI
         A7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7/MTFfhzetCC3xXz8zMuwlhQvQgzdRQHLg9ZcPquOqc=;
        b=jcnZRMxzBWs5fnRPACfd73yCjpUtW4ReuC1Ieg5k7x09P0QUNQYNJO7U1W5CML9N6h
         MGNPgEA2FYWg6L+YGmdVwP78ibJ69hPBMIh8XyA7LIUZiwpMKsPhtstoxDcIHjzomSzk
         fuC2KaDjYuE4J2L0mtKTi1et1CRoLpuGV2XP/mkiUC/obCDkulpJQmvMxpWr17JgZJzp
         NPWwQIWyubnPKWgADLWaLr3dHznsCglRa32KyUc9nlD04FyEQmTlse6pzlz3Xmj82sku
         2rS0bkwwj362lBDot0EWe+HU5OmJjZ+6MuursSHqKambMBw0CsUe7UZkt/Pj0mzKotV+
         6GpA==
X-Gm-Message-State: ACrzQf1oRkV0RfOMYetIqstoQrA0Ces37wu7c8rSPe5STP0lU7IhoPoq
        Y108N5t+wXOyaE+jBaopdciKduycwuo=
X-Google-Smtp-Source: AMsMyM4GvujwxBtV/JDV9fbBfRjwLg7PZB5tE8tkdTr4nIAK+HciDSPz0Ng4DdNQhqZYb+EwPhCMIA==
X-Received: by 2002:a05:6870:970e:b0:13c:5da4:aeb0 with SMTP id n14-20020a056870970e00b0013c5da4aeb0mr10368775oaq.27.1667144475726;
        Sun, 30 Oct 2022 08:41:15 -0700 (PDT)
Received: from localhost.localdomain ([190.186.46.211])
        by smtp.googlemail.com with ESMTPSA id l6-20020a4a2706000000b0047537233dfasm1542867oof.21.2022.10.30.08.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 08:41:15 -0700 (PDT)
From:   Henry Castro <hcvcastro@gmail.com>
To:     thunderbird2k@gmail.com
Cc:     Henry Castro <hcvcastro@gmail.com>, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drivers: hid: warn feature report 0x81
Date:   Sun, 30 Oct 2022 11:40:58 -0400
Message-Id: <20221030154058.10964-1-hcvcastro@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221006145308.4393-1-hcvcastro@gmail.com>
References: <20221006145308.4393-1-hcvcastro@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately, my PS DualShock 4, does not support
the feature 0x81 to get the MAC address. Instead,
fallback feature report 0x12, so I can
use DS4 to play Retroarch :)

Signed-off-by: Henry Castro <hcvcastro@gmail.com>
---

What do you think about patching the existing driver to
fix with the feature 0x12 to obtain the MAC address,
meanwhile  the new driver is released?

 drivers/hid/hid-sony.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index c10513efe677..ee364bef81a7 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -506,6 +506,8 @@ struct motion_output_report_02 {
 #define DS4_FEATURE_REPORT_0x05_SIZE 41
 #define DS4_FEATURE_REPORT_0x81_SIZE 7
 #define DS4_FEATURE_REPORT_0xA3_SIZE 49
+#define DS4_FEATURE_REPORT_PAIRING_INFO 0x12
+#define DS4_FEATURE_REPORT_PAIRING_INFO_SIZE 16
 #define DS4_INPUT_REPORT_0x11_SIZE 78
 #define DS4_OUTPUT_REPORT_0x05_SIZE 32
 #define DS4_OUTPUT_REPORT_0x11_SIZE 78
@@ -1259,7 +1261,7 @@ static void nsg_mrxu_parse_report(struct sony_sc *sc, u8 *rd, int size)
 	 *   the touch-related data starts at offset 2.
 	 * For the first byte, bit 0 is set when touchpad button is pressed.
 	 * Bit 2 is set when a touch is active and the drag (Fn) key is pressed.
-	 * This drag key is mapped to BTN_LEFT.  It is operational only when a
+	 * This drag key is mapped to BTN_LEFT.  It is operational only when a
 	 *   touch point is active.
 	 * Bit 4 is set when only the first touch point is active.
 	 * Bit 6 is set when only the second touch point is active.
@@ -1532,13 +1534,13 @@ static int sony_register_touchpad(struct sony_sc *sc, int touch_count,
 	input_set_abs_params(sc->touchpad, ABS_MT_POSITION_Y, 0, h, 0, 0);

 	if (touch_major > 0) {
-		input_set_abs_params(sc->touchpad, ABS_MT_TOUCH_MAJOR,
+		input_set_abs_params(sc->touchpad, ABS_MT_TOUCH_MAJOR,
 			0, touch_major, 0, 0);
 		if (touch_minor > 0)
-			input_set_abs_params(sc->touchpad, ABS_MT_TOUCH_MINOR,
+			input_set_abs_params(sc->touchpad, ABS_MT_TOUCH_MINOR,
 				0, touch_minor, 0, 0);
 		if (orientation > 0)
-			input_set_abs_params(sc->touchpad, ABS_MT_ORIENTATION,
+			input_set_abs_params(sc->touchpad, ABS_MT_ORIENTATION,
 				0, orientation, 0, 0);
 	}

@@ -2627,7 +2629,8 @@ static int sony_check_add(struct sony_sc *sc)
 			return 0;
 		}
 	} else if (sc->quirks & (DUALSHOCK4_CONTROLLER_USB | DUALSHOCK4_DONGLE)) {
-		buf = kmalloc(DS4_FEATURE_REPORT_0x81_SIZE, GFP_KERNEL);
+		buf = kzalloc(DS4_FEATURE_REPORT_PAIRING_INFO_SIZE, GFP_KERNEL);
+
 		if (!buf)
 			return -ENOMEM;

@@ -2641,9 +2644,17 @@ static int sony_check_add(struct sony_sc *sc)
 				HID_REQ_GET_REPORT);

 		if (ret != DS4_FEATURE_REPORT_0x81_SIZE) {
-			hid_err(sc->hdev, "failed to retrieve feature report 0x81 with the DualShock 4 MAC address\n");
-			ret = ret < 0 ? ret : -EINVAL;
-			goto out_free;
+			hid_warn(sc->hdev, "failed to retrieve feature report 0x81 with the DualShock 4 MAC address\n");
+
+			ret = hid_hw_raw_request(sc->hdev, DS4_FEATURE_REPORT_PAIRING_INFO,
+						 buf, DS4_FEATURE_REPORT_PAIRING_INFO_SIZE,
+						 HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
+
+			if (ret != DS4_FEATURE_REPORT_PAIRING_INFO_SIZE) {
+				hid_err(sc->hdev, "Failed to retrieve DualShock4 pairing info:%d\n",
+					ret);
+				goto out_free;
+			}
 		}

 		memcpy(sc->mac_address, &buf[1], sizeof(sc->mac_address));
--
2.20.1

