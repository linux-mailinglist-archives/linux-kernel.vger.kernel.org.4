Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731806D2B7C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 00:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbjCaWp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 18:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbjCaWp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 18:45:56 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EFC40C4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 15:45:55 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id mp3-20020a17090b190300b0023fcc8ce113so26955675pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 15:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680302755;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FT3VTUjo7B8Z6a6Co0FRAvEldOp0goywye0iYEBwxqQ=;
        b=bymzRAbBGTzOVh8y2mzeeRerq3UIiF4kZE079arFHGmT9TIO75k6aqXL8nUbrDPK/5
         aqzUCQO3aFP3ohy6F4Y/RVzpJljEtT9hgu3PYKtF6KwT0EB/t29v3WSGxu130p0tAP9+
         dgOg094CfB3dOx3wRIYpGwe1PTLE1exXzBF98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680302755;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FT3VTUjo7B8Z6a6Co0FRAvEldOp0goywye0iYEBwxqQ=;
        b=MHJUOwJMSSQJeYpAYWC7p5hnVmApwJK1zwYlEC+C48K/vpOAY5dOJj3C+5QLrA79uK
         eulc07zB+PXzXPYwKLKJS7qZK6fkP14cn7ZA2wzl4c/4HfvdJCUc+rRspyESzQdS8+KJ
         /p54Tx6tQKNHuEPAg0PRT1afK+nIse5z185tINAspL5D5exofM2x930V8L2MOVpDI3Tf
         JsNUh+N0i6UrHdHpahFEA1O8tPjQL1R7Ua9hnhneot80Hj20QiYqTnvoclTPXoGWPuDj
         KPCuXPUdDMP4fOatqPdXo+/ArAwVoNEXFGagZDAr0dXiWhSHJ6xlkPQLDssbh0oNQGOr
         an5Q==
X-Gm-Message-State: AAQBX9d4ASNiT16kQjNBEd88cLjXCFlPWAjShqIEQsBLCVUJ0pFXxzHW
        FX84PMj4Lpmtuxu+E7HEUi8uDQ==
X-Google-Smtp-Source: AKy350bGaWt/BjzawxlujTsu+UdC93Q73IN15yVjk8iKLVcxpk0Kzb92ZCHHJsqTzHeW3KM5XN1gqQ==
X-Received: by 2002:a05:6a20:4a30:b0:df:4e86:9c99 with SMTP id fr48-20020a056a204a3000b000df4e869c99mr19610716pzb.55.1680302754782;
        Fri, 31 Mar 2023 15:45:54 -0700 (PDT)
Received: from torsha.c.googlers.com.com (209.148.168.34.bc.googleusercontent.com. [34.168.148.209])
        by smtp.gmail.com with ESMTPSA id j11-20020aa7800b000000b005895f9657ebsm2289216pfi.70.2023.03.31.15.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 15:45:54 -0700 (PDT)
From:   Torsha Banerjee <torsha@chromium.org>
X-Google-Original-From: Torsha Banerjee <torsha@google.com>
To:     u-boot@lists.denx.de
Cc:     Jing <jingyliang@chromium.org>, Sean <seobrien@chromum.org>,
        Jora Jacobi <jora@google.com>,
        Harry Cutts <hcutts@chromium.org>,
        Torsha Banerjee <torsha@google.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Series-to: LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 31 Mar 2023 22:45:36 +0000
Message-Id: <20230331224536.1685149-1-torsha@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jora Jacobi <jora@google.com>

Restore missing cursor for digitizer devices

A previously committed patch to remove cursors for HID Digitizer-Pen
devices also removed the cursors for some tablets which have incorrect HID
descriptors. These devices should enumerate with Usage ID "Digitizer"
instead of Usage ID "Pen".

Patch which introduced the issue: commit 8473a93d1ba5
("HID: input: Set INPUT_PROP_-property for HID_UP_DIGITIZERS")

Changes-
Add HID quirk HID_QUIRK_DEVICE_IS_DIGITIZER
Quirk will force INPUT_PROP_POINTER for HID Digitizers
Apply quirk to Huion tablets
Apply quirk to UGEE/XP-Pen tablets based on device ID

Tested with Huion H640P and H430P. Connected the digitizer to the
Chromebook and confirmed with a drawing program that the cursor appears and
moves when the digitizer's stylus is hovering over the surface of the
digitizer.

Signed-off-by: Jora Jacobi <jora@google.com>
Reviewed-by: Harry Cutts <hcutts@chromium.org>
Signed-off-by: Torsha Banerjee <torsha@google.com>
---

 drivers/hid/hid-input.c  | 3 ++-
 drivers/hid/hid-quirks.c | 9 +++++++++
 include/linux/hid.h      | 1 +
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 7fc967964dd8..f0c67baddc8d 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -927,7 +927,8 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		break;
 
 	case HID_UP_DIGITIZER:
-		if ((field->application & 0xff) == 0x01) /* Digitizer */
+		if (((field->application & 0xff) == 0x01) ||
+			(device->quirks & HID_QUIRK_DEVICE_IS_DIGITIZER)) /* Digitizer */
 			__set_bit(INPUT_PROP_POINTER, input->propbit);
 		else if ((field->application & 0xff) == 0x02) /* Pen */
 			__set_bit(INPUT_PROP_DIRECT, input->propbit);
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 66e64350f138..094fe4c4f3b3 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -102,6 +102,8 @@ static const struct hid_device_id hid_quirks[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE_0941), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE_0641), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE_1f4a), HID_QUIRK_ALWAYS_POLL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_HUION, USB_DEVICE_ID_HUION_HS64), HID_QUIRK_DEVICE_IS_DIGITIZER },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_HUION, USB_DEVICE_ID_HUION_TABLET), HID_QUIRK_DEVICE_IS_DIGITIZER },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_IDEACOM, USB_DEVICE_ID_IDEACOM_IDC6680), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_INNOMEDIA, USB_DEVICE_ID_INNEX_GENESIS_ATARI), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_EASYPEN_M610X), HID_QUIRK_MULTI_INPUT },
@@ -1298,6 +1300,13 @@ unsigned long hid_lookup_quirk(const struct hid_device *hdev)
 		quirks = hid_gets_squirk(hdev);
 	mutex_unlock(&dquirks_lock);
 
+	/*
+	 * UGEE/XP-Pen HID Pen devices which have 0x0-0x9 as the low nibble
+	 * of the device ID are actually digitizers, not HID Pen devices
+	 */
+	if (hdev->vendor == USB_VENDOR_ID_UGEE && (hdev->product & 0x0F) <= 0x09)
+		quirks |= HID_QUIRK_DEVICE_IS_DIGITIZER;
+
 	return quirks;
 }
 EXPORT_SYMBOL_GPL(hid_lookup_quirk);
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 1ea8c7a3570b..1653359002b3 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -354,6 +354,7 @@ struct hid_item {
 #define HID_QUIRK_INPUT_PER_APP			BIT(11)
 #define HID_QUIRK_X_INVERT			BIT(12)
 #define HID_QUIRK_Y_INVERT			BIT(13)
+#define HID_QUIRK_DEVICE_IS_DIGITIZER           BIT(14)
 #define HID_QUIRK_SKIP_OUTPUT_REPORTS		BIT(16)
 #define HID_QUIRK_SKIP_OUTPUT_REPORT_ID		BIT(17)
 #define HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP	BIT(18)
-- 
2.40.0.348.gf938b09366-goog

