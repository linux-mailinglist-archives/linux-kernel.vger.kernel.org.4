Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98ACB6F3CB9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 06:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbjEBE3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 00:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbjEBE2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 00:28:54 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABB130E1;
        Mon,  1 May 2023 21:28:50 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1683001728;
        bh=FVAGAMsfB/9ZOt6WpZqigpx8Wc9v/TnjxkE0rIT4oYg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=ZLOya9fvHRuaat03BDMkgYsFnOPbirmWjk4hywCGkEwnCc+RmvVn5ituZmP0zvVFP
         N2dx9gAXShdTnEXRH51uDOhWsYtAr+a0WUJIf6FbkBddShpdbl4dPgcF5QZwaEwS2T
         D35k0NlIO9Cf3MC+bP2nsGo5BYOylDE5dovvRtSg=
Date:   Tue, 02 May 2023 06:28:45 +0200
Subject: [PATCH v2 2/2] power: supply: remove unneeded include of
 linux/leds.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230212-include-power_supply-leds-v2-2-e9910a3f5837@weissschuh.net>
References: <20230212-include-power_supply-leds-v2-0-e9910a3f5837@weissschuh.net>
In-Reply-To: <20230212-include-power_supply-leds-v2-0-e9910a3f5837@weissschuh.net>
To:     Sebastian Reichel <sre@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1683001727; l=808;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=FVAGAMsfB/9ZOt6WpZqigpx8Wc9v/TnjxkE0rIT4oYg=;
 b=YqdN6JIcUaOMAjZobPUyAAMZ1rz+dTe5E3M8l8cZttXp67ba/cbVYIoo4CbjtZ/UEfrACldSP
 veABqKbSV+oD9SL95GIGWtGZtxeAxeSJU7bv4SGpdNle6X6qb5Zfdo5
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of including the full linux/leds.h header file a single
forward-declaration is enough.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/linux/power_supply.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index a427f13c757f..dc5e17e8c919 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -14,10 +14,11 @@
 
 #include <linux/device.h>
 #include <linux/workqueue.h>
-#include <linux/leds.h>
 #include <linux/spinlock.h>
 #include <linux/notifier.h>
 
+struct led_trigger;
+
 /*
  * All voltages, currents, charges, energies, time and temperatures in uV,
  * µA, µAh, µWh, seconds and tenths of degree Celsius unless otherwise

-- 
2.40.1

