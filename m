Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0517317A8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344313AbjFOLoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344230AbjFOLnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:43:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851AB3AA9;
        Thu, 15 Jun 2023 04:40:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F9F861B8D;
        Thu, 15 Jun 2023 11:39:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD075C433CB;
        Thu, 15 Jun 2023 11:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686829185;
        bh=n83YZv8wLuLtFKpdKE8JIDNngMwK+FjRX1OMW/pqegI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kMvYWO1W2aKZH6y3ekAx+JdfSwOEKZ4YjfmbcDslTMGHtHRL7iLnFj+dBCHLgjm6d
         BDuZpeNliiOMP0uizBKEGKSEn+0t6ftET1t7KdCjebaYW/HDNWQl6m1TqBQ7WA2+VI
         3++T1XwCQDBbOWLETfXDMVwy9g+m7aayX2HrvXg10RcbFVQ8fMddeUPETSOZZFPPgW
         aLsTFamXRH4zGs7j6cUF1FkI6mIzi5CH+4LNq4UX+1OvcO+9dI904vfA420BjAlUhs
         tn5tdyS7Fj57HJNKmPO5C/ArC/O+JgHW6YbGXMo80NSr9w+21S92/7FUrr/ETIAKSC
         9uObFxZxlQqJQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sung-Chi Li <lschyi@chromium.org>, Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <sashal@kernel.org>, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 3/8] HID: google: add jewel USB id
Date:   Thu, 15 Jun 2023 07:39:33 -0400
Message-Id: <20230615113938.649627-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230615113938.649627-1-sashal@kernel.org>
References: <20230615113938.649627-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.247
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
index b6947d7573473..2ebad3ed4e3af 100644
--- a/drivers/hid/hid-google-hammer.c
+++ b/drivers/hid/hid-google-hammer.c
@@ -473,6 +473,8 @@ static const struct hid_device_id hammer_devices[] = {
 		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_EEL) },
 	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
 		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_HAMMER) },
+	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
+		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_JEWEL) },
 	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
 		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_MAGNEMITE) },
 	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index b883423a89c5d..479516bbb61bf 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -490,6 +490,7 @@
 #define USB_DEVICE_ID_GOOGLE_MOONBALL	0x5044
 #define USB_DEVICE_ID_GOOGLE_DON	0x5050
 #define USB_DEVICE_ID_GOOGLE_EEL	0x5057
+#define USB_DEVICE_ID_GOOGLE_JEWEL	0x5061
 
 #define USB_VENDOR_ID_GOTOP		0x08f2
 #define USB_DEVICE_ID_SUPER_Q2		0x007f
-- 
2.39.2

