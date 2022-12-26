Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7FB6562B7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 13:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbiLZMzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 07:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbiLZMzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 07:55:14 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3B4DFA;
        Mon, 26 Dec 2022 04:55:13 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so10358210wma.1;
        Mon, 26 Dec 2022 04:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDV3yiQCxKjyRe2BrkxUA/BaPPKeET1PmW5WU9GrEbA=;
        b=MykWob17+SbSKC0pAldTsUb+7xQUqC3wmR0SL+dhB7zb//Oww6JMFYF8zBkRxd61HX
         6uT4NloCG4Zr0MlmFqD8Om2eG0QhPywaj9Wyjmcw36JhgQVAw7BYVivqNuDmKKXy/Vye
         IFYTL67Z+bIj5XucAoIEpp0K9kJr2sGUXm4RLT+CedVVQlijReIxOzmQDpzWBS/Qdhau
         CgR2/qIxrsKALtYQCKW/bZMGtKPDD3Ntt+3mRyPWRRhay54mF+lFmyRj0OFcsZsfrBMS
         NZ0Te/jMe99bii0j2rGaEs9CUSoBgBeI5RNvtBYcXy12+8Ih0ZRoV/u9zg2c3sNSe4m5
         AnoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vDV3yiQCxKjyRe2BrkxUA/BaPPKeET1PmW5WU9GrEbA=;
        b=jeIH3VEGufV6rR+TmkHlJ0eBXQezntKj1VlDtmyBWvPCMgSEp9+mfmPYZpCOeK/mJB
         pJV1h5xp+Q/+e55zobdD9bcl2cdPBGXp6JidmhlBsB+/BkoWpXRAuGpLtyKpRlo64p9R
         rDxZomI3FUbXyucfyMk0UtMYrLViU0c2CIMD6GQ28KfnpLo37D4RGFoHjG/xk7BmL3fG
         cgxVMfQnXkVH9SHLKDBr6Zc/ZVhZFgLIyA/oZNdvPhEdO8B1JPltA+3953nux7IboiV7
         5IuKE7Sf67IfFw9JR4s46BgeSO+RNfJ/w/8PQzHZFRuj1QNkkcAOrZkdN56nUQv/v2tH
         kg3Q==
X-Gm-Message-State: AFqh2ko9h/5twbpReoMdiXLWipxcdyR5y/g0E232ZVw2VTTYk+mKEzNK
        zS4SoNzMQGr//fEOM9Q0EKg=
X-Google-Smtp-Source: AMrXdXvOxRHMoY5rOCAfbA/SHhChNSZRgBF8g556h3qzWnvIWK1HgD9IwRO/VNHdQRS+04QDYFrjIg==
X-Received: by 2002:a7b:cb56:0:b0:3d2:3be4:2d9a with SMTP id v22-20020a7bcb56000000b003d23be42d9amr12942179wmj.20.1672059311613;
        Mon, 26 Dec 2022 04:55:11 -0800 (PST)
Received: from localhost.localdomain ([94.73.32.212])
        by smtp.gmail.com with ESMTPSA id y24-20020a05600c365800b003cf894dbc4fsm13684497wmq.25.2022.12.26.04.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 04:55:11 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        Mia Kanashi <chad@redpilled.dev>,
        Andreas Grosse <andig.mail@t-online.de>
Subject: [PATCH 4/6] HID: uclogic: Handle wireless device reconnection
Date:   Mon, 26 Dec 2022 13:54:52 +0100
Message-Id: <20221226125454.16106-5-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221226125454.16106-1-jose.exposito89@gmail.com>
References: <20221226125454.16106-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UGEEv2 tablets with battery can be connected using a USB cable or a USB
Bluetooth dongle.

When the Bluetooth dongle is used, the connection to that tablet can be
lost because the tablet is out of the range of the receiver or because
it was switched off using the switch placed in the back of the tablet's
frame.

After losing connection, the tablet is able to reconnect automatically
and its firmware sends a special packet indicating that the device was
reconnected. In response to this packet, the tablet needs to receive the
same array of magic data it expects on probe to enable its interfaces.

This patch implements a generic mechanism to hook raw events and
schedule a work to perform any custom action.

Tested-by: Mia Kanashi <chad@redpilled.dev>
Tested-by: Andreas Grosse <andig.mail@t-online.de>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-core-test.c   | 105 ++++++++++++++++++++++++++
 drivers/hid/hid-uclogic-core.c        |  35 +++++++++
 drivers/hid/hid-uclogic-params-test.c |  16 ++++
 drivers/hid/hid-uclogic-params.c      |  99 ++++++++++++++++++++++++
 drivers/hid/hid-uclogic-params.h      |  16 ++++
 5 files changed, 271 insertions(+)
 create mode 100644 drivers/hid/hid-uclogic-core-test.c

diff --git a/drivers/hid/hid-uclogic-core-test.c b/drivers/hid/hid-uclogic-core-test.c
new file mode 100644
index 000000000000..2bb916226a38
--- /dev/null
+++ b/drivers/hid/hid-uclogic-core-test.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/*
+ *  HID driver for UC-Logic devices not fully compliant with HID standard
+ *
+ *  Copyright (c) 2022 José Expósito <jose.exposito89@gmail.com>
+ */
+
+#include <kunit/test.h>
+#include "./hid-uclogic-params.h"
+
+#define MAX_EVENT_SIZE 12
+
+struct uclogic_raw_event_hook_test {
+	u8 event[MAX_EVENT_SIZE];
+	size_t size;
+	bool expected;
+};
+
+static struct uclogic_raw_event_hook_test hook_events[] = {
+	{
+		.event = { 0xA1, 0xB2, 0xC3, 0xD4 },
+		.size = 4,
+	},
+	{
+		.event = { 0x1F, 0x2E, 0x3D, 0x4C, 0x5B, 0x6A },
+		.size = 6,
+	},
+};
+
+static struct uclogic_raw_event_hook_test test_events[] = {
+	{
+		.event = { 0xA1, 0xB2, 0xC3, 0xD4 },
+		.size = 4,
+		.expected = true,
+	},
+	{
+		.event = { 0x1F, 0x2E, 0x3D, 0x4C, 0x5B, 0x6A },
+		.size = 6,
+		.expected = true,
+	},
+	{
+		.event = { 0xA1, 0xB2, 0xC3 },
+		.size = 3,
+		.expected = false,
+	},
+	{
+		.event = { 0xA1, 0xB2, 0xC3, 0xD4, 0x00 },
+		.size = 5,
+		.expected = false,
+	},
+	{
+		.event = { 0x2E, 0x3D, 0x4C, 0x5B, 0x6A, 0x1F },
+		.size = 6,
+		.expected = false,
+	},
+};
+
+static void hid_test_uclogic_exec_event_hook_test(struct kunit *test)
+{
+	struct uclogic_params p = {0, };
+	struct uclogic_raw_event_hook *filter;
+	bool res;
+	int n;
+
+	/* Initialize the list of events to hook */
+	p.event_hooks = kunit_kzalloc(test, sizeof(*p.event_hooks), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p.event_hooks);
+	INIT_LIST_HEAD(&p.event_hooks->list);
+
+	for (n = 0; n < ARRAY_SIZE(hook_events); n++) {
+		filter = kunit_kzalloc(test, sizeof(*filter), GFP_KERNEL);
+		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filter);
+
+		filter->size = hook_events[n].size;
+		filter->event = kunit_kzalloc(test, filter->size, GFP_KERNEL);
+		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filter->event);
+		memcpy(filter->event, &hook_events[n].event[0], filter->size);
+
+		list_add_tail(&filter->list, &p.event_hooks->list);
+	}
+
+	/* Test uclogic_exec_event_hook() */
+	for (n = 0; n < ARRAY_SIZE(test_events); n++) {
+		res = uclogic_exec_event_hook(&p, &test_events[n].event[0],
+					      test_events[n].size);
+		KUNIT_ASSERT_EQ(test, res, test_events[n].expected);
+	}
+}
+
+static struct kunit_case hid_uclogic_core_test_cases[] = {
+	KUNIT_CASE(hid_test_uclogic_exec_event_hook_test),
+	{}
+};
+
+static struct kunit_suite hid_uclogic_core_test_suite = {
+	.name = "hid_uclogic_core_test",
+	.test_cases = hid_uclogic_core_test_cases,
+};
+
+kunit_test_suite(hid_uclogic_core_test_suite);
+
+MODULE_DESCRIPTION("KUnit tests for the UC-Logic driver");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("José Expósito <jose.exposito89@gmail.com>");
diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index 7a5480b6f046..9ddb17ad0d04 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -249,6 +249,34 @@ static int uclogic_resume(struct hid_device *hdev)
 }
 #endif
 
+/**
+ * uclogic_exec_event_hook - if the received event is hooked schedules the
+ * associated work.
+ *
+ * @p:		Tablet interface report parameters.
+ * @event:	Raw event.
+ * @size:	The size of event.
+ *
+ * Returns:
+ *	Whether the event was hooked or not.
+ */
+static bool uclogic_exec_event_hook(struct uclogic_params *p, u8 *event, int size)
+{
+	struct uclogic_raw_event_hook *curr;
+
+	if (!p->event_hooks)
+		return false;
+
+	list_for_each_entry(curr, &p->event_hooks->list, list) {
+		if (curr->size == size && memcmp(curr->event, event, size) == 0) {
+			schedule_work(&curr->work);
+			return true;
+		}
+	}
+
+	return false;
+}
+
 /**
  * uclogic_raw_event_pen - handle raw pen events (pen HID reports).
  *
@@ -407,6 +435,9 @@ static int uclogic_raw_event(struct hid_device *hdev,
 	if (report->type != HID_INPUT_REPORT)
 		return 0;
 
+	if (uclogic_exec_event_hook(params, data, size))
+		return 0;
+
 	while (true) {
 		/* Tweak pen reports, if necessary */
 		if ((report_id == params->pen.id) && (size >= 2)) {
@@ -536,3 +567,7 @@ module_hid_driver(uclogic_driver);
 MODULE_AUTHOR("Martin Rusko");
 MODULE_AUTHOR("Nikolai Kondrashov");
 MODULE_LICENSE("GPL");
+
+#ifdef CONFIG_HID_KUNIT_TEST
+#include "hid-uclogic-core-test.c"
+#endif
diff --git a/drivers/hid/hid-uclogic-params-test.c b/drivers/hid/hid-uclogic-params-test.c
index bfa7ccb7d1e8..678f50cbb160 100644
--- a/drivers/hid/hid-uclogic-params-test.c
+++ b/drivers/hid/hid-uclogic-params-test.c
@@ -174,9 +174,25 @@ static void hid_test_uclogic_parse_ugee_v2_desc(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, params->frame_type, frame_type);
 }
 
+static void hid_test_uclogic_params_cleanup_event_hooks(struct kunit *test)
+{
+	int res, n;
+	struct uclogic_params p = {0, };
+
+	res = uclogic_params_ugee_v2_init_event_hooks(NULL, &p);
+	KUNIT_ASSERT_EQ(test, res, 0);
+
+	/* Check that the function can be called repeatedly */
+	for (n = 0; n < 4; n++) {
+		uclogic_params_cleanup_event_hooks(&p);
+		KUNIT_EXPECT_PTR_EQ(test, p.event_hooks, NULL);
+	}
+}
+
 static struct kunit_case hid_uclogic_params_test_cases[] = {
 	KUNIT_CASE_PARAM(hid_test_uclogic_parse_ugee_v2_desc,
 			 uclogic_parse_ugee_v2_desc_gen_params),
+	KUNIT_CASE(hid_test_uclogic_params_cleanup_event_hooks),
 	{}
 };
 
diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index b6a515973942..86702c994c57 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -615,6 +615,31 @@ static int uclogic_params_frame_init_v1(struct uclogic_params_frame *frame,
 	return rc;
 }
 
+/**
+ * uclogic_params_cleanup_event_hooks - free resources used by the list of raw
+ * event hooks.
+ * Can be called repeatedly.
+ *
+ * @params: Input parameters to cleanup. Cannot be NULL.
+ */
+static void uclogic_params_cleanup_event_hooks(struct uclogic_params *params)
+{
+	struct uclogic_raw_event_hook *curr, *n;
+
+	if (!params || !params->event_hooks)
+		return;
+
+	list_for_each_entry_safe(curr, n, &params->event_hooks->list, list) {
+		cancel_work_sync(&curr->work);
+		list_del(&curr->list);
+		kfree(curr->event);
+		kfree(curr);
+	}
+
+	kfree(params->event_hooks);
+	params->event_hooks = NULL;
+}
+
 /**
  * uclogic_params_cleanup - free resources used by struct uclogic_params
  * (tablet interface's parameters).
@@ -631,6 +656,7 @@ void uclogic_params_cleanup(struct uclogic_params *params)
 		for (i = 0; i < ARRAY_SIZE(params->frame_list); i++)
 			uclogic_params_frame_cleanup(&params->frame_list[i]);
 
+		uclogic_params_cleanup_event_hooks(params);
 		memset(params, 0, sizeof(*params));
 	}
 }
@@ -1280,6 +1306,72 @@ static int uclogic_params_ugee_v2_init_battery(struct hid_device *hdev,
 	return rc;
 }
 
+/**
+ * uclogic_params_ugee_v2_reconnect_work() - When a wireless tablet looses
+ * connection to the USB dongle and reconnects, either because of its physical
+ * distance or because it was switches off and on using the frame's switch,
+ * uclogic_probe_interface() needs to be called again to enable the tablet.
+ *
+ * @work: The work that triggered this function.
+ */
+static void uclogic_params_ugee_v2_reconnect_work(struct work_struct *work)
+{
+	struct uclogic_raw_event_hook *event_hook;
+
+	event_hook = container_of(work, struct uclogic_raw_event_hook, work);
+	uclogic_probe_interface(event_hook->hdev, uclogic_ugee_v2_probe_arr,
+				uclogic_ugee_v2_probe_size,
+				uclogic_ugee_v2_probe_endpoint);
+}
+
+/**
+ * uclogic_params_ugee_v2_init_event_hooks() - initialize the list of events
+ * to be hooked for UGEE v2 devices.
+ * @hdev:	The HID device of the tablet interface to initialize and get
+ *		parameters from.
+ * @p:		Parameters to fill in, cannot be NULL.
+ *
+ * Returns:
+ *	Zero, if successful. A negative errno code on error.
+ */
+static int uclogic_params_ugee_v2_init_event_hooks(struct hid_device *hdev,
+						   struct uclogic_params *p)
+{
+	struct uclogic_raw_event_hook *event_hook;
+	__u8 reconnect_event[] = {
+		/* Event received on wireless tablet reconnection */
+		0x02, 0xF8, 0x02, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+	};
+
+	if (!p)
+		return -EINVAL;
+
+	/* The reconnection event is only received if the tablet has battery */
+	if (!uclogic_params_ugee_v2_has_battery(hdev))
+		return 0;
+
+	p->event_hooks = kzalloc(sizeof(*p->event_hooks), GFP_KERNEL);
+	if (!p->event_hooks)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&p->event_hooks->list);
+
+	event_hook = kzalloc(sizeof(*event_hook), GFP_KERNEL);
+	if (!event_hook)
+		return -ENOMEM;
+
+	INIT_WORK(&event_hook->work, uclogic_params_ugee_v2_reconnect_work);
+	event_hook->hdev = hdev;
+	event_hook->size = ARRAY_SIZE(reconnect_event);
+	event_hook->event = kmemdup(reconnect_event, event_hook->size, GFP_KERNEL);
+	if (!event_hook->event)
+		return -ENOMEM;
+
+	list_add_tail(&event_hook->list, &p->event_hooks->list);
+
+	return 0;
+}
+
 /**
  * uclogic_params_ugee_v2_init() - initialize a UGEE graphics tablets by
  * discovering their parameters.
@@ -1416,6 +1508,13 @@ static int uclogic_params_ugee_v2_init(struct uclogic_params *params,
 		}
 	}
 
+	/* Create a list of raw events to be ignored */
+	rc = uclogic_params_ugee_v2_init_event_hooks(hdev, &p);
+	if (rc) {
+		hid_err(hdev, "error initializing event hook list: %d\n", rc);
+		goto cleanup;
+	}
+
 output:
 	/* Output parameters */
 	memcpy(params, &p, sizeof(*params));
diff --git a/drivers/hid/hid-uclogic-params.h b/drivers/hid/hid-uclogic-params.h
index b0e7f3807939..d6ffadb2f601 100644
--- a/drivers/hid/hid-uclogic-params.h
+++ b/drivers/hid/hid-uclogic-params.h
@@ -18,6 +18,7 @@
 
 #include <linux/usb.h>
 #include <linux/hid.h>
+#include <linux/list.h>
 
 #define UCLOGIC_MOUSE_FRAME_QUIRK	BIT(0)
 #define UCLOGIC_BATTERY_QUIRK		BIT(1)
@@ -176,6 +177,17 @@ struct uclogic_params_frame {
 	unsigned int bitmap_dial_byte;
 };
 
+/*
+ * List of works to be performed when a certain raw event is received.
+ */
+struct uclogic_raw_event_hook {
+	struct hid_device *hdev;
+	__u8 *event;
+	size_t size;
+	struct work_struct work;
+	struct list_head list;
+};
+
 /*
  * Tablet interface report parameters.
  *
@@ -216,6 +228,10 @@ struct uclogic_params {
 	 * parts. Only valid, if "invalid" is false.
 	 */
 	struct uclogic_params_frame frame_list[3];
+	/*
+	 * List of event hooks.
+	 */
+	struct uclogic_raw_event_hook *event_hooks;
 };
 
 /* Driver data */
-- 
2.38.1

