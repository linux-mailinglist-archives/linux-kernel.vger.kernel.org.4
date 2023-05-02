Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5326F3CB7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 06:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbjEBE2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 00:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbjEBE2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 00:28:54 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F5F273A;
        Mon,  1 May 2023 21:28:50 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1683001728;
        bh=qFEajWvVlStRcKllCItBDHDpRzStSprf9+KoOJV74tA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=PM+IzfIt5/Z2JTAhnSub3LQITSndz4ruxbPKfwrIFZ7az2Bp0KLnzt6RLUznuMU7k
         NlFW+t+LCfEuYJCOo7UdXkNXpPKw9md+feY4pBnwJIo1Za1bFXgk5mYohPVbC0dwQJ
         I+trX8tC524rxT9j0ImOOsj1KriZNWRIVKp+YrNA=
Date:   Tue, 02 May 2023 06:28:44 +0200
Subject: [PATCH v2 1/2] HID: lg4ff: explicitly include linux/leds.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230212-include-power_supply-leds-v2-1-e9910a3f5837@weissschuh.net>
References: <20230212-include-power_supply-leds-v2-0-e9910a3f5837@weissschuh.net>
In-Reply-To: <20230212-include-power_supply-leds-v2-0-e9910a3f5837@weissschuh.net>
To:     Sebastian Reichel <sre@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, kernel test robot <lkp@intel.com>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1683001727; l=714;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=qFEajWvVlStRcKllCItBDHDpRzStSprf9+KoOJV74tA=;
 b=YdHBbqFXjpQWMH67rf1otRSXNwuxB4SQ0KuepjxAIZMcH3bNVcaxs2Sg7kLD0ZUEtrDGFsGbX
 8nYgxhwkz/RDHA52ziJiCIZ5kCogsQviBCw+UQ/ShkS+Gb+dPxVQ4rJ
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

Instead of relying on an accidental, transitive inclusion of linux/leds.h
use it directly.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202304301551.baBXvI9d-lkp@intel.com/
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/hid/hid-lg4ff.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index e3fcf1353fb3..d55d04c140b9 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -15,6 +15,7 @@
 #include <linux/input.h>
 #include <linux/usb.h>
 #include <linux/hid.h>
+#include <linux/leds.h>
 
 #include "usbhid/usbhid.h"
 #include "hid-lg.h"

-- 
2.40.1

