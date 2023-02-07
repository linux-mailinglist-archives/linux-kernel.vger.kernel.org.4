Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A3568E2B4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 22:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjBGVQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 16:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjBGVQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 16:16:01 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E6C37555;
        Tue,  7 Feb 2023 13:16:00 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id j1so10457962pjd.0;
        Tue, 07 Feb 2023 13:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TAcU8WxhB+WVoNrLiEKubw7Fb6wa6bNM3w1NxWFiTsM=;
        b=AjUdYU/mpefYpxPczmxS+Nyv9tTQPLG964qAkyvowIFxkA7I2gX3DaFVS8SAhRk7f/
         rt5KoYbcpn4e1yXwaGWU2MkaEtVUQ0PgU82jYFNN+ab05lmG7bi19MS5J6Ppf2m0Qu/y
         XohIOZrSBhd2bPmL7oeS1LWDxqp6YaOr/f9E7/OOOl4dg3O6NlYbQNp7NKQHtrzSG47Y
         0xEyhhGWN1dGUOEm6illHzA+JUNtGLjvpSkeDUzlvoiBjUW6yomCuv3W9KdP65xZlzfH
         Frdw7xuMdcDHMxgifCsAvb3KVdxD567aHGGkNZbghgc6MOV0+/Hwo1AJJjZ4sPChvpnd
         iETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TAcU8WxhB+WVoNrLiEKubw7Fb6wa6bNM3w1NxWFiTsM=;
        b=iIOHs8waqsDPRNCFshMend2x8ZSozH5UW1DvOZ2tK+Qbrmu3COGzCUR1ha/XyzL9zE
         tw2k8ai7PRPGD5xTeii0iwvzdO3POnJJG/FmTEhSI9UnfmpmMeAnljkkMeDWRDhAcEM/
         63y3V79k6SLpDDWv1FZYtk/CVY7OJuN/SFGmqUHn+LJeeVjplLB/Ld30AXyi8ils6LCi
         d5lPVDwrC341xLPymEU/bgW3zgMV867ZT7kTTvuu8PQz92MqWQ/N5ySa/nlkbnOXfi1T
         2euZYGnG3oJVpuPhJ5zuMcnHAOw6QAfdgmkZFf1CT26TRj91+lqT4gUNAdTIevt17L+e
         qCyg==
X-Gm-Message-State: AO0yUKVeLvyqzEiRiVWTGM9zAc2GkjWQ8raGkCVSELG/5iT4Epew/Sna
        QgrKDk6JcW+unMuxDpizYx0=
X-Google-Smtp-Source: AK7set9ICv0SA9LRgto4cra9cn6LR7OltxE5zF0MkjSF0FztPWH9CqZq6pocQovbNr89DEYJfpgi9g==
X-Received: by 2002:a17:90b:3b8a:b0:230:86d2:5832 with SMTP id pc10-20020a17090b3b8a00b0023086d25832mr5613362pjb.2.1675804559452;
        Tue, 07 Feb 2023 13:15:59 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:c930:81ab:3aec:b9cb])
        by smtp.gmail.com with ESMTPSA id w10-20020a17090a5e0a00b002262dd8a39bsm11779971pjf.49.2023.02.07.13.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 13:15:58 -0800 (PST)
Date:   Tue, 7 Feb 2023 13:15:55 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Allen Ballway <ballway@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Alistair Francis <alistair@alistair23.me>,
        Guenter Roeck <groeck@chromium.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] HID: retain initial quirks set up when creating HID devices
Message-ID: <Y+K/i4kj0WER1Hl0@google.com>
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
devices, we want to pass and retain some querks (axis inversion, etc).
The source of such quirks may be device tree, or DMI data, or something
else not readily available to the HID core itself and therefore cannot
be reconstructed easily. To allow this introduce "initial_quirks" field
in hid_device structure and use it when determining the final set of
quirks.

This fixes problem with i2c-hid setting up device-tree sourced quirks
too late and losing them on device rebind, and also allows to sever the
tie between hid-code and i2c-hid when applying DMI-based quirks.

Fixes: b60d3c803d76 ("HID: i2c-hid-of: Expose the touchscreen-inverted properties")
Fixes: a2f416bf062a ("HID: multitouch: Add quirks for flipped axes")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

Compiled only, not tested on hardware.

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
