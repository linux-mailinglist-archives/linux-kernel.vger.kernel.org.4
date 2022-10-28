Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28F7611A07
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 20:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbiJ1STE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 14:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiJ1SS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 14:18:58 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB49242C97;
        Fri, 28 Oct 2022 11:18:57 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id a14so7663414wru.5;
        Fri, 28 Oct 2022 11:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wk6jEeL2FJMT7QFBpNdVHSXdYHOZhd8dBCHaaIJ9Iqs=;
        b=hU/d1nOZcswggKceAULiPGWjpiYLRniLG3Qn4GmGUQs/SbLo5bjRbjwcbL55XUxm8v
         lzy3UbOsLSMALs0xfOKk7HNZdo2c48nVIZTkX4j34HEQJSB2KhoWmT3Ts6gAyu7BBHMA
         d00Xx/SnTQegby8JSfZiD5OoLNmLUICUBBPWrlDUJJxkhKuh8fd1u/LPR74Os2foYwEQ
         ec5G+2F4nBbI5ZzL6B4wfUeyse+7A/EXIl4myHO3nh4jFdgKDRL5on4YXhNd/TxKErlo
         Og9yaD3MkYGmM3uVaz2c14HJOfKDBh1CepBVnQjYXNhAl8vCT5eJyvU4b5FOzimQ4Mfz
         aqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wk6jEeL2FJMT7QFBpNdVHSXdYHOZhd8dBCHaaIJ9Iqs=;
        b=69oKrq4xm++9IUrps2U8sR1hvX8423VVpyIUkxxvO//AfDpbiI0DrkhGSiPXt+RRHy
         /ZuhViD0uHdcR6Wkw1rDmeSf9PPs6Q20Kom5TiPi/Nlkp18g/KTI+t2RlU9H+GY1xTIG
         WpDjH+PkwtYT6Ub80Oj2G50Jp5YOHPdClVCFHse5Oi+f4f+6Mn98fesclz1ChsUEnLLG
         BJ2sdizbzioB/w4bgFfvaGaFcXqh88MiLHLzCez26iNPVEaKmY8jkEJwkivDtPNvIq4/
         WJGw0/NLCDR8vNeEUGvFC8zhCRExtzGTVXi2nion0RuFtL2pKd4OfkyWzvq+hNJ6Egyv
         FCDA==
X-Gm-Message-State: ACrzQf1mZJjWc64WUII7KCRY24Hwy7F5HiM3x3TLFV2Yn5SbOx6/FMC/
        P/NActwglLj3p9Twdp0+hJ4=
X-Google-Smtp-Source: AMsMyM4nCAX80BoU5LB6CsztYrtv35BuVGI3RSBEJC5NgWoUsQr1+K4hXcJeOJbokkUj4dZv6cF24g==
X-Received: by 2002:a5d:47c7:0:b0:236:64a4:6d5a with SMTP id o7-20020a5d47c7000000b0023664a46d5amr390515wrc.666.1666981135442;
        Fri, 28 Oct 2022 11:18:55 -0700 (PDT)
Received: from localhost.localdomain ([94.73.35.109])
        by smtp.gmail.com with ESMTPSA id iv9-20020a05600c548900b003cf483ee8e0sm8689221wmb.24.2022.10.28.11.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 11:18:54 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, rydberg@bitmath.org,
        chad@redpilled.dev, davidgow@google.com,
        linux-input@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 1/1] HID: input: map battery system charging
Date:   Fri, 28 Oct 2022 20:18:49 +0200
Message-Id: <20221028181849.23157-2-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221028181849.23157-1-jose.exposito89@gmail.com>
References: <20221028181849.23157-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HID descriptors with Battery System (0x85) Charging (0x44) usage are
ignored and POWER_SUPPLY_STATUS_DISCHARGING is always reported to user
space, even when the device is charging.

Map this usage and when it is reported set the right charging status.

In addition, add KUnit tests to make sure that the charging status is
correctly set and reported. They can be run with the usual command:

    $ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/hid

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/.kunitconfig     |  1 +
 drivers/hid/Kconfig          |  1 +
 drivers/hid/hid-input-test.c | 80 ++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-input.c      | 36 +++++++++++++++-
 include/linux/hid.h          |  2 +
 5 files changed, 118 insertions(+), 2 deletions(-)
 create mode 100644 drivers/hid/hid-input-test.c

diff --git a/drivers/hid/.kunitconfig b/drivers/hid/.kunitconfig
index 04daeff5c970..675a8209c7ae 100644
--- a/drivers/hid/.kunitconfig
+++ b/drivers/hid/.kunitconfig
@@ -1,5 +1,6 @@
 CONFIG_KUNIT=y
 CONFIG_USB=y
 CONFIG_USB_HID=y
+CONFIG_HID_BATTERY_STRENGTH=y
 CONFIG_HID_UCLOGIC=y
 CONFIG_HID_KUNIT_TEST=y
diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 185a077d59cd..644b4913d4d8 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -1263,6 +1263,7 @@ config HID_MCP2221
 config HID_KUNIT_TEST
 	tristate "KUnit tests for HID" if !KUNIT_ALL_TESTS
 	depends on KUNIT=y
+	depends on HID_BATTERY_STRENGTH
 	depends on HID_UCLOGIC
 	default KUNIT_ALL_TESTS
 	help
diff --git a/drivers/hid/hid-input-test.c b/drivers/hid/hid-input-test.c
new file mode 100644
index 000000000000..77c2d45ac62a
--- /dev/null
+++ b/drivers/hid/hid-input-test.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  HID to Linux Input mapping
+ *
+ *  Copyright (c) 2022 José Expósito <jose.exposito89@gmail.com>
+ */
+
+#include <kunit/test.h>
+
+static void hid_test_input_set_battery_charge_status(struct kunit *test)
+{
+	struct hid_device *dev;
+	bool handled;
+
+	dev = kunit_kzalloc(test, sizeof(*dev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	handled = hidinput_set_battery_charge_status(dev, HID_DG_HEIGHT, 0);
+	KUNIT_EXPECT_FALSE(test, handled);
+	KUNIT_EXPECT_EQ(test, dev->battery_charge_status, POWER_SUPPLY_STATUS_UNKNOWN);
+
+	handled = hidinput_set_battery_charge_status(dev, HID_BAT_CHARGING, 0);
+	KUNIT_EXPECT_TRUE(test, handled);
+	KUNIT_EXPECT_EQ(test, dev->battery_charge_status, POWER_SUPPLY_STATUS_DISCHARGING);
+
+	handled = hidinput_set_battery_charge_status(dev, HID_BAT_CHARGING, 1);
+	KUNIT_EXPECT_TRUE(test, handled);
+	KUNIT_EXPECT_EQ(test, dev->battery_charge_status, POWER_SUPPLY_STATUS_CHARGING);
+}
+
+static void hid_test_input_get_battery_property(struct kunit *test)
+{
+	struct power_supply *psy;
+	struct hid_device *dev;
+	union power_supply_propval val;
+	int ret;
+
+	dev = kunit_kzalloc(test, sizeof(*dev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+	dev->battery_avoid_query = true;
+
+	psy = kunit_kzalloc(test, sizeof(*psy), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, psy);
+	psy->drv_data = dev;
+
+	dev->battery_status = HID_BATTERY_UNKNOWN;
+	dev->battery_charge_status = POWER_SUPPLY_STATUS_CHARGING;
+	ret = hidinput_get_battery_property(psy, POWER_SUPPLY_PROP_STATUS, &val);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, val.intval, POWER_SUPPLY_STATUS_UNKNOWN);
+
+	dev->battery_status = HID_BATTERY_REPORTED;
+	dev->battery_charge_status = POWER_SUPPLY_STATUS_CHARGING;
+	ret = hidinput_get_battery_property(psy, POWER_SUPPLY_PROP_STATUS, &val);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, val.intval, POWER_SUPPLY_STATUS_CHARGING);
+
+	dev->battery_status = HID_BATTERY_REPORTED;
+	dev->battery_charge_status = POWER_SUPPLY_STATUS_DISCHARGING;
+	ret = hidinput_get_battery_property(psy, POWER_SUPPLY_PROP_STATUS, &val);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, val.intval, POWER_SUPPLY_STATUS_DISCHARGING);
+}
+
+static struct kunit_case hid_input_tests[] = {
+	KUNIT_CASE(hid_test_input_set_battery_charge_status),
+	KUNIT_CASE(hid_test_input_get_battery_property),
+	{ }
+};
+
+static struct kunit_suite hid_input_test_suite = {
+	.name = "hid_input",
+	.test_cases = hid_input_tests,
+};
+
+kunit_test_suite(hid_input_test_suite);
+
+MODULE_DESCRIPTION("HID input KUnit tests");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("José Expósito <jose.exposito89@gmail.com>");
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 859aeb07542e..587112e9efe2 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -477,7 +477,7 @@ static int hidinput_get_battery_property(struct power_supply *psy,
 		if (dev->battery_status == HID_BATTERY_UNKNOWN)
 			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
 		else
-			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+			val->intval = dev->battery_charge_status;
 		break;
 
 	case POWER_SUPPLY_PROP_SCOPE:
@@ -545,6 +545,7 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 	dev->battery_max = max;
 	dev->battery_report_type = report_type;
 	dev->battery_report_id = field->report->id;
+	dev->battery_charge_status = POWER_SUPPLY_STATUS_DISCHARGING;
 
 	/*
 	 * Stylus is normally not connected to the device and thus we
@@ -608,6 +609,20 @@ static void hidinput_update_battery(struct hid_device *dev, int value)
 		power_supply_changed(dev->battery);
 	}
 }
+
+static bool hidinput_set_battery_charge_status(struct hid_device *dev,
+					       unsigned int usage, int value)
+{
+	switch (usage) {
+	case HID_BAT_CHARGING:
+		dev->battery_charge_status = value ?
+					     POWER_SUPPLY_STATUS_CHARGING :
+					     POWER_SUPPLY_STATUS_DISCHARGING;
+		return true;
+	}
+
+	return false;
+}
 #else  /* !CONFIG_HID_BATTERY_STRENGTH */
 static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 				  struct hid_field *field, bool is_percentage)
@@ -622,6 +637,12 @@ static void hidinput_cleanup_battery(struct hid_device *dev)
 static void hidinput_update_battery(struct hid_device *dev, int value)
 {
 }
+
+static bool hidinput_set_battery_charge_status(struct hid_device *dev,
+					       unsigned int usage, int value)
+{
+	return false;
+}
 #endif	/* CONFIG_HID_BATTERY_STRENGTH */
 
 static bool hidinput_field_in_collection(struct hid_device *device, struct hid_field *field,
@@ -1208,6 +1229,9 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 			hidinput_setup_battery(device, HID_INPUT_REPORT, field, true);
 			usage->type = EV_PWR;
 			return;
+		case HID_BAT_CHARGING:
+			usage->type = EV_PWR;
+			return;
 		}
 		goto unknown;
 
@@ -1450,7 +1474,11 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
 		return;
 
 	if (usage->type == EV_PWR) {
-		hidinput_update_battery(hid, value);
+		bool handled = hidinput_set_battery_charge_status(hid, usage->hid, value);
+
+		if (!handled)
+			hidinput_update_battery(hid, value);
+
 		return;
 	}
 
@@ -2306,3 +2334,7 @@ void hidinput_disconnect(struct hid_device *hid)
 	cancel_work_sync(&hid->led_work);
 }
 EXPORT_SYMBOL_GPL(hidinput_disconnect);
+
+#ifdef CONFIG_HID_KUNIT_TEST
+#include "hid-input-test.c"
+#endif
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 8677ae38599e..1eb5408599cd 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -312,6 +312,7 @@ struct hid_item {
 #define HID_DG_LATENCYMODE	0x000d0060
 
 #define HID_BAT_ABSOLUTESTATEOFCHARGE	0x00850065
+#define HID_BAT_CHARGING		0x00850044
 
 #define HID_VD_ASUS_CUSTOM_MEDIA_KEYS	0xff310076
 
@@ -611,6 +612,7 @@ struct hid_device {							/* device report descriptor */
 	__s32 battery_max;
 	__s32 battery_report_type;
 	__s32 battery_report_id;
+	__s32 battery_charge_status;
 	enum hid_battery_status battery_status;
 	bool battery_avoid_query;
 	ktime_t battery_ratelimit_time;
-- 
2.25.1

