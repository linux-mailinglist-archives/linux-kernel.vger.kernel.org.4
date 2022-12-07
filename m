Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05A4645702
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 11:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiLGKAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 05:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiLGKAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 05:00:44 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD813E0B4;
        Wed,  7 Dec 2022 02:00:41 -0800 (PST)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 971DA100018;
        Wed,  7 Dec 2022 10:00:33 +0000 (UTC)
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: [PATCH] HID: logitech-hidpp: Add constants for HID++ 2.0 error codes
Date:   Wed,  7 Dec 2022 11:00:33 +0100
Message-Id: <20221207100033.64095-1-hadess@hadess.net>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add constants for HID++ 2.0 error codes listed in "Protocol HID++2.0
essential features" chapter, page 3, in
logitech_hidpp_2.0_specification_draft_2012-06-04.pdf

Signed-off-by: Bastien Nocera <hadess@hadess.net>
---
 drivers/hid/hid-logitech-hidpp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 71a9c258a20b..4c327969545f 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -225,6 +225,16 @@ struct hidpp_device {
 #define HIDPP_ERROR_INVALID_PARAM_VALUE		0x0b
 #define HIDPP_ERROR_WRONG_PIN_CODE		0x0c
 /* HID++ 2.0 error codes */
+#define HIDPP20_ERROR_NO_ERROR			0x00
+#define HIDPP20_ERROR_UNKNOWN			0x01
+#define HIDPP20_ERROR_INVALID_ARGS		0x02
+#define HIDPP20_ERROR_OUT_OF_RANGE		0x03
+#define HIDPP20_ERROR_HW_ERROR			0x04
+#define HIDPP20_ERROR_LOGITECH_INTERNAL		0x05
+#define HIDPP20_ERROR_INVALID_FEATURE_INDEX	0x06
+#define HIDPP20_ERROR_INVALID_FUNCTION_ID	0x07
+#define HIDPP20_ERROR_BUSY			0x08
+#define HIDPP20_ERROR_UNSUPPORTED		0x09
 #define HIDPP20_ERROR				0xff
 
 static void hidpp_connect_event(struct hidpp_device *hidpp_dev);
-- 
2.38.1

