Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB4C68E41B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 00:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjBGXDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 18:03:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjBGXDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 18:03:38 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAFE1D90E;
        Tue,  7 Feb 2023 15:03:36 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id 203so11877105pfx.6;
        Tue, 07 Feb 2023 15:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mKRyLs14cQMLkdQlb1k9GTQd3JA97HIjZ/46MwZ+z08=;
        b=Js/HNexDSwOKgRBcmYiuHgQCRxp8/HlVnCuGxHWIUi9YAXcklBawiUgPzAJ1XHFhf1
         XeOA6jrBLKXLHd5xUiqpz2G6d3YYYvc0m0Kl0QRF3s+wDWkcd4xdVenO7EFf1V7jHWJa
         7mO6FpXCD2hmzhqp0kt5jTGzOLEcdioFtof51Qdmj/icKjukD3ThgYJM0Z8yNR1EMbRL
         xJ/gdRQ3YLtCa8oz3N3V+67WZfd6c2rHc7LWPQfOc1YL49yOMbLz3gSF7xhV73JcM2Gl
         ha9n+6nUZnNrhwmYfw6vWWWMSfocijWxgV0giTs1YC8Qa8GgNZTuhxfk/3QcXyDfxnDd
         qHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mKRyLs14cQMLkdQlb1k9GTQd3JA97HIjZ/46MwZ+z08=;
        b=5UmqVNLsOcxbEnXQymAdJ71H5tV4YLRihdFm9/Phbty9IzZiq0cMuL+zXeRkGjCUus
         EdXKAyU1cXqZxDb5WXxPo7bF7caV5p27U4KfPz6bvh+dZ2sf+8LGIQTTQhbSFtXRPu75
         BH2UzsMPhOXiCKQ2bfMXdyOPWuqQ1LjgPzXd0ONK/3pAaNa4tB8EPezaxCq/4PHiqgYr
         kPRDT1kpdTeF4sexi6e5JRbKRNELtNTSA+rov/ruY7NDqrJvQqogspcDzLXicEyKipGT
         H2eI8Csn4TDKuvBp7IQqS/cWZQ781GF7nUe+8oG2ND49lbTG6r/oWCcFZGLL2Rn85np+
         wfDQ==
X-Gm-Message-State: AO0yUKWLs8KEXRcnogFZh7JvZzS5IYXSqIf5O/NEYRtIN8X9BMLq5ptQ
        ynQgdcKujVxdnOHrozs4X3M=
X-Google-Smtp-Source: AK7set8HPr4JHDvwWO6Wuy0bMS2wszHrJPMyBH1MxEmU9ElP0BS5OCyXQOYHimhySgzzXYjBt5KiGw==
X-Received: by 2002:aa7:9603:0:b0:57f:c170:dc6 with SMTP id q3-20020aa79603000000b0057fc1700dc6mr4815885pfg.14.1675811016365;
        Tue, 07 Feb 2023 15:03:36 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:c930:81ab:3aec:b9cb])
        by smtp.gmail.com with ESMTPSA id a22-20020a62bd16000000b00580a0bb411fsm1913537pff.174.2023.02.07.15.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 15:03:35 -0800 (PST)
Date:   Tue, 7 Feb 2023 15:03:30 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Guenter Roeck <groeck@chromium.org>,
        Allen Ballway <ballway@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Alistair Francis <alistair@alistair23.me>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] HID: retain initial quirks set up when creating HID
 devices
Message-ID: <Y+LYwu3Zs13hdVDy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In certain circumstances, such as when creating I2C-connected HID
devices, we want to pass and retain some quirks (axis inversion, etc).
The source of such quirks may be device tree, or DMI data, or something
else not readily available to the HID core itself and therefore cannot
be reconstructed easily. To allow this, introduce "initial_quirks" field
in hid_device structure and use it when determining the final set of
quirks.

This fixes the problem with i2c-hid setting up device-tree sourced
quirks too late and losing them on device rebind, and also allows to
sever the tie between hid-code and i2c-hid when applying DMI-based
quirks.

Fixes: b60d3c803d76 ("HID: i2c-hid-of: Expose the touchscreen-inverted properties")
Fixes: a2f416bf062a ("HID: multitouch: Add quirks for flipped axes")
Reviewed-by: Guenter Roeck <groeck@chromium.org>
Tested-by: Allen Ballway <ballway@chromium.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

v2:
- corrected spelling/grammar in the commit message per Guenter
- added reviewed-by/tested-by tags


 drivers/hid/hid-quirks.c                 | 8 +-------
 drivers/hid/i2c-hid/i2c-hid-core.c       | 6 ++++--
 drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c | 1 -
 include/linux/hid.h                      | 1 +
 4 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 30e35f79def4..66e64350f138 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -19,7 +19,6 @@
 #include <linux/input/elan-i2c-ids.h>
 
 #include "hid-ids.h"
-#include "i2c-hid/i2c-hid.h"
 
 /*
  * Alphabetically sorted by vendor then product.
@@ -1238,7 +1237,7 @@ EXPORT_SYMBOL_GPL(hid_quirks_exit);
 static unsigned long hid_gets_squirk(const struct hid_device *hdev)
 {
 	const struct hid_device_id *bl_entry;
-	unsigned long quirks = 0;
+	unsigned long quirks = hdev->initial_quirks;
 
 	if (hid_match_id(hdev, hid_ignore_list))
 		quirks |= HID_QUIRK_IGNORE;
@@ -1299,11 +1298,6 @@ unsigned long hid_lookup_quirk(const struct hid_device *hdev)
 		quirks = hid_gets_squirk(hdev);
 	mutex_unlock(&dquirks_lock);
 
-	/* Get quirks specific to I2C devices */
-	if (IS_ENABLED(CONFIG_I2C_DMI_CORE) && IS_ENABLED(CONFIG_DMI) &&
-	    hdev->bus == BUS_I2C)
-		quirks |= i2c_hid_get_dmi_quirks(hdev->vendor, hdev->product);
-
 	return quirks;
 }
 EXPORT_SYMBOL_GPL(hid_lookup_quirk);
diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 0ab8f47a84e9..efbba0465eef 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -1025,6 +1025,10 @@ int i2c_hid_core_probe(struct i2c_client *client, struct i2chid_ops *ops,
 	hid->vendor = le16_to_cpu(ihid->hdesc.wVendorID);
 	hid->product = le16_to_cpu(ihid->hdesc.wProductID);
 
+	hid->initial_quirks = quirks;
+	hid->initial_quirks |= i2c_hid_get_dmi_quirks(hid->vendor,
+						      hid->product);
+
 	snprintf(hid->name, sizeof(hid->name), "%s %04X:%04X",
 		 client->name, (u16)hid->vendor, (u16)hid->product);
 	strscpy(hid->phys, dev_name(&client->dev), sizeof(hid->phys));
@@ -1038,8 +1042,6 @@ int i2c_hid_core_probe(struct i2c_client *client, struct i2chid_ops *ops,
 		goto err_mem_free;
 	}
 
-	hid->quirks |= quirks;
-
 	return 0;
 
 err_mem_free:
diff --git a/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c b/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
index 554a7dc28536..210f17c3a0be 100644
--- a/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
+++ b/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
@@ -492,4 +492,3 @@ u32 i2c_hid_get_dmi_quirks(const u16 vendor, const u16 product)
 
 	return quirks;
 }
-EXPORT_SYMBOL_GPL(i2c_hid_get_dmi_quirks);
diff --git a/include/linux/hid.h b/include/linux/hid.h
index daaac4d7f370..56dac09c99d9 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -622,6 +622,7 @@ struct hid_device {							/* device report descriptor */
 	unsigned long status;						/* see STAT flags above */
 	unsigned claimed;						/* Claimed by hidinput, hiddev? */
 	unsigned quirks;						/* Various quirks the device can pull on us */
+	unsigned initial_quirks;					/* Initial set of quirks supplied when creating device */
 	bool io_started;						/* If IO has started */
 
 	struct list_head inputs;					/* The list of inputs */
-- 
2.39.1.519.gcb327c4b5f-goog


-- 
Dmitry
