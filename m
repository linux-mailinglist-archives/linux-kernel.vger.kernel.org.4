Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA3F69730A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 02:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbjBOBDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 20:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbjBOBDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 20:03:42 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251AF25BA3;
        Tue, 14 Feb 2023 17:03:38 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1676423017;
        bh=m4Mck/JTL5jieC/dSKQKpIQPgEjWz3XW6vNEwwtuGL4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=uEIyxsNajDOTQrHiiwLmdBsnTFY6EQ7lEsJHyNQyHsQYfQ4lgL6drmOVdnBBEiXtj
         KQ+rfeT2UiL5h5S8yuimquzQUhpbAteo+QtbI2tRNJFEVdlYgBKUcgREnVGBVF3fSC
         AEnNiFOdQEgLlEECZ98xcIFwcdDA6yN5gY4wo600=
Date:   Wed, 15 Feb 2023 01:03:34 +0000
Subject: [PATCH 1/4] HID: steelseries: explicitly include linux/leds.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230215-power_supply-leds-hid-v1-1-35b6f1dcee8a@weissschuh.net>
References: <20230215-power_supply-leds-hid-v1-0-35b6f1dcee8a@weissschuh.net>
In-Reply-To: <20230215-power_supply-leds-hid-v1-0-35b6f1dcee8a@weissschuh.net>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676423014; l=591;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=m4Mck/JTL5jieC/dSKQKpIQPgEjWz3XW6vNEwwtuGL4=;
 b=QRh0biAyvuEEU2uJXPJ1klXWhkaWYi6SqEigcOZWBHO2Q7OXzo7VyfxDOLumL9AIWa1J+h95t
 QovHvDU9M0XBC/3qjR2lmr6q+gu0ZObIIsmzo249VQLJ4w9BtIDD72b
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
 drivers/hid/hid-steelseries.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-steelseries.c b/drivers/hid/hid-steelseries.c
index 37353c41cba7..aae3afc4107a 100644
--- a/drivers/hid/hid-steelseries.c
+++ b/drivers/hid/hid-steelseries.c
@@ -11,6 +11,7 @@
 #include <linux/device.h>
 #include <linux/hid.h>
 #include <linux/module.h>
+#include <linux/leds.h>
 
 #include "hid-ids.h"
 

-- 
2.39.2

