Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFFB690D8D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 16:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbjBIPuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 10:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbjBIPtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 10:49:42 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C96AD24;
        Thu,  9 Feb 2023 07:49:28 -0800 (PST)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id E022A240002;
        Thu,  9 Feb 2023 15:49:24 +0000 (UTC)
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: [PATCH v3 2/2] HID: logitech-hidpp: Add myself to authors
Date:   Thu,  9 Feb 2023 16:49:16 +0100
Message-Id: <20230209154916.462158-2-hadess@hadess.net>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230209154916.462158-1-hadess@hadess.net>
References: <20230209154916.462158-1-hadess@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As discussed with HID maintainer Benjamin Tissoires, add myself to the
authors list and MAINTAINERS file.

Signed-off-by: Bastien Nocera <hadess@hadess.net>
---
Updated MAINTAINERS file too.

 MAINTAINERS                      | 7 +++++++
 drivers/hid/hid-logitech-hidpp.c | 1 +
 2 files changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fb1471cb5ed3..327679567645 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9217,6 +9217,13 @@ L:	linux-input@vger.kernel.org
 S:	Maintained
 F:	drivers/hid/hid-logitech-*
 
+HID++ LOGITECH DRIVERS
+R:	Filipe Laíns <lains@riseup.net>
+R:	Bastien Nocera <hadess@hadess.net>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	drivers/hid/hid-logitech-hidpp.c
+
 HID PLAYSTATION DRIVER
 M:	Roderick Colenbrander <roderick.colenbrander@sony.com>
 L:	linux-input@vger.kernel.org
diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index ff427d7a0fa0..61bad7a50ec7 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -30,6 +30,7 @@
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Benjamin Tissoires <benjamin.tissoires@gmail.com>");
 MODULE_AUTHOR("Nestor Lopez Casado <nlopezcasad@logitech.com>");
+MODULE_AUTHOR("Bastien Nocera <hadess@hadess.net>");
 
 static bool disable_tap_to_click;
 module_param(disable_tap_to_click, bool, 0644);
-- 
2.39.1

