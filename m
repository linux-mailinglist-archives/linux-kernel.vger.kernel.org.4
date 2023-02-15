Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE2069730B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 02:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbjBOBD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 20:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbjBOBDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 20:03:44 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253412CC42;
        Tue, 14 Feb 2023 17:03:38 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1676423017;
        bh=WLP/pGbieAiiW5bafuL21pEgA43jp4przTaPDhRdgPM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=e7TkhNQlnMiZrwBs/tXyXeudvUxNM4a5B7v7gz3ZzD66MY0V2wldYc5kfPz5EbuZy
         1JcAPqkV2x+5yG6GRzINV/3Z8OWZYBUI0MpElhl++6SqJWmd+j30X0siAFRgf3bdO8
         4he1I4t9KbYRzkvKZ7vXudXG1ntnAMJjcvEe07ZQ=
Date:   Wed, 15 Feb 2023 01:03:37 +0000
Subject: [PATCH 4/4] HID: apple: explicitly include linux/leds.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230215-power_supply-leds-hid-v1-4-35b6f1dcee8a@weissschuh.net>
References: <20230215-power_supply-leds-hid-v1-0-35b6f1dcee8a@weissschuh.net>
In-Reply-To: <20230215-power_supply-leds-hid-v1-0-35b6f1dcee8a@weissschuh.net>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676423014; l=561;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=WLP/pGbieAiiW5bafuL21pEgA43jp4przTaPDhRdgPM=;
 b=1QAMP6c9wXrTPPDdlgmyQXrsAdDmZY44VQ6ACWqRbWvH4w5+73MKFPmJJMmPen/ATOijm0356
 RASOYkUxqVqC7Nk/rCuq93CJOGi3tMSHZFOSKCh6svoxiv8cGsmwnmJ
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of relying on an accidental, transitive inclusion of linux/leds.h
use it directly.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/hid/hid-apple.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 1ccab8aa326c..c5b45cd1e44d 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 #include <linux/timer.h>
 #include <linux/string.h>
+#include <linux/leds.h>
 
 #include "hid-ids.h"
 

-- 
2.39.2

