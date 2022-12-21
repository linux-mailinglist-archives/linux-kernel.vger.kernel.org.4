Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E25652BEF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 04:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbiLUDuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 22:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiLUDuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 22:50:08 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DA1BE6;
        Tue, 20 Dec 2022 19:50:07 -0800 (PST)
From:   Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1671594605;
        bh=vm8LMVsbwRZQxgihhWF8na4eZeHZD1RVft5RuFXZE+c=;
        h=From:Date:Subject:To:Cc:From;
        b=PYir1pHBLyivz5JXOkNmuNwSywDHvABj4NSGsP+boTCMvDWEJ92L4Tj/1Zl+W9317
         nm6C0b6z+93LS8zAz4v/rSxCfa5S9VzHulxMTgSQ4rL2HknI15EC90f8iJK4vi5VuI
         ry9X9pu0ehjaeMByRUUma1uM6z8RxBZP6wEjK7Es=
Date:   Wed, 21 Dec 2022 03:49:59 +0000
Subject: [PATCH] platform/x86: asus-nb-wmi: Add alternate mapping for KEY_CAMERA
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-Id: <20221216-asus-key-v1-1-45da124119a3@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAGeComMC/w2LQQqAIBAAvyJ7biE3SOg3altKYuBiENLf28McB
 mYGCLfMApsZ0PjJku+qYicDMfl6MuZdHWgmsmRX9NIFL34xLOFQIrFzoHnwwhiarzHpUHsp3/cD
 l+zOXV8AAAA=
To:     Corentin Chary <corentin.chary@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.11.0-dev-e429b
X-Developer-Signature: v=1; a=ed25519-sha256; t=1671594602; l=1123;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=vm8LMVsbwRZQxgihhWF8na4eZeHZD1RVft5RuFXZE+c=;
 b=09P9ObfPmPrh6SciSdjxoGA+sQ4g3LcPnn8Q2oW1VdDbgqHqnOqjFjbiei8ugHVInOCyi//h/voI
 EWUFoJQLAEsXBzzKAIuAsGOveNezNS3N4wc9VhFHeYYOvYomuWuR
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This keycode is emitted on a Asus VivoBook E410MAB with firmware
E410MAB.304.

The physical key has a strikken-through camera printed on it.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/platform/x86/asus-nb-wmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index c685a705b73d..8ee5d108e9e0 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -544,6 +544,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
 	{ KE_KEY, 0x7D, { KEY_BLUETOOTH } }, /* Bluetooth Enable */
 	{ KE_KEY, 0x7E, { KEY_BLUETOOTH } }, /* Bluetooth Disable */
 	{ KE_KEY, 0x82, { KEY_CAMERA } },
+	{ KE_KEY, 0x85, { KEY_CAMERA } },
 	{ KE_KEY, 0x86, { KEY_PROG1 } }, /* MyASUS Key */
 	{ KE_KEY, 0x88, { KEY_RFKILL  } }, /* Radio Toggle Key */
 	{ KE_KEY, 0x8A, { KEY_PROG1 } }, /* Color enhancement mode */

---
base-commit: b6bb9676f2165d518b35ba3bea5f1fcfc0d969bf
change-id: 20221216-asus-key-b3bfb3bc2e77

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>
