Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290AB731763
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344216AbjFOLma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344170AbjFOLld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:41:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619DE30F5;
        Thu, 15 Jun 2023 04:39:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41F2063950;
        Thu, 15 Jun 2023 11:39:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A4FC433B9;
        Thu, 15 Jun 2023 11:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686829164;
        bh=VVofVxA3Anvxu9aejpMx+OBYQtO/IM75AGXO9CrcelQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mTomHAjbDq+AEOYhIMh59Vao1eKlmHQnt/onsfbthH9VMUA+49AyjVNy5v28/LG1F
         5VjTTNeXhirbRcZWF6jGIpCzt4yQdGpKLz+DHWOvqLOjFzIX2RLi1W31ynh4h7xaOR
         P2FShk1AWxbRWvZINLcgBRaLHQdhFauuBWY8RM367V7+a135OyguZ/W52cNPQt4Sdd
         vCKr9muQFSEf48zHNbEoF/7Vxghl6es0wBMs0f9nAqOw6QDM3Qvcfw2P4ht8dsCtL8
         Kxau5jn3ouKXG9Sxb6X7INsPO45x/wih6RjmyyHmN4321MikJOv6NBeODpOQFcoVb9
         GxorIOPoih/BQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sung-Chi Li <lschyi@chromium.org>, Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <sashal@kernel.org>, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 3/9] HID: google: add jewel USB id
Date:   Thu, 15 Jun 2023 07:39:11 -0400
Message-Id: <20230615113917.649505-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230615113917.649505-1-sashal@kernel.org>
References: <20230615113917.649505-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.184
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sung-Chi Li <lschyi@chromium.org>

[ Upstream commit ed84c4517a5bc536e8572a01dfa11bc22a280d06 ]

Add 1 additional hammer-like device.

Signed-off-by: Sung-Chi Li <lschyi@chromium.org>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-google-hammer.c | 2 ++
 drivers/hid/hid-ids.h           | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
index 0476301983964..2f4c5b45d4096 100644
--- a/drivers/hid/hid-google-hammer.c
+++ b/drivers/hid/hid-google-hammer.c
@@ -532,6 +532,8 @@ static const struct hid_device_id hammer_devices[] = {
 		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_EEL) },
 	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
 		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_HAMMER) },
+	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
+		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_JEWEL) },
 	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
 		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_MAGNEMITE) },
 	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 1d1306a6004e6..2b658d820b800 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -491,6 +491,7 @@
 #define USB_DEVICE_ID_GOOGLE_MOONBALL	0x5044
 #define USB_DEVICE_ID_GOOGLE_DON	0x5050
 #define USB_DEVICE_ID_GOOGLE_EEL	0x5057
+#define USB_DEVICE_ID_GOOGLE_JEWEL	0x5061
 
 #define USB_VENDOR_ID_GOTOP		0x08f2
 #define USB_DEVICE_ID_SUPER_Q2		0x007f
-- 
2.39.2

