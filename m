Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C4E697308
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 02:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbjBOBDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 20:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBOBDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 20:03:42 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2493D25B98;
        Tue, 14 Feb 2023 17:03:38 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1676423017;
        bh=QSEi72eS8D+vdc6SJvnTOOZ4a6yNzxJG6IsdhOBtBik=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=ruptiwcXPb+I/rhw/dQOykMzrFMNm3y3g3Be9L8Q/wNKgoLSJBE9O5NwaiBDGJssD
         9l6fnbwYx7+FwvWxsfWUfhjJH3DfZOVWnd6oFZdKIK/jcscQqkSGCFBn6WZ2zVS7J0
         bASp+m4VmuWjrbn3+NYjO85CG9YF+DZcMs34IJxo=
Date:   Wed, 15 Feb 2023 01:03:35 +0000
Subject: [PATCH 2/4] HID: lg-g15: explicitly include linux/leds.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230215-power_supply-leds-hid-v1-2-35b6f1dcee8a@weissschuh.net>
References: <20230215-power_supply-leds-hid-v1-0-35b6f1dcee8a@weissschuh.net>
In-Reply-To: <20230215-power_supply-leds-hid-v1-0-35b6f1dcee8a@weissschuh.net>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676423014; l=593;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=QSEi72eS8D+vdc6SJvnTOOZ4a6yNzxJG6IsdhOBtBik=;
 b=tpkYpRJdcMg6+RB6OCyyAY756/tHbXtVNBvpAcdob0EDMlWmFPvp7f83j80U1/BQca8LhYDro
 hpFBpRUUcdlC2Wn2l3RYOkCFCmwUwTXcvTCPuRNTdLFeVZx5sHJWW1o
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
 drivers/hid/hid-lg-g15.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-lg-g15.c b/drivers/hid/hid-lg-g15.c
index c8f82bcbf1ab..acbec1dcf196 100644
--- a/drivers/hid/hid-lg-g15.c
+++ b/drivers/hid/hid-lg-g15.c
@@ -7,6 +7,7 @@
 
 #include <linux/device.h>
 #include <linux/hid.h>
+#include <linux/leds.h>
 #include <linux/module.h>
 #include <linux/random.h>
 #include <linux/sched.h>

-- 
2.39.2

