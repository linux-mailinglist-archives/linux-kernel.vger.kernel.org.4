Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930D966D587
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 06:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235235AbjAQFPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 00:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234078AbjAQFPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 00:15:38 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9175A233EF;
        Mon, 16 Jan 2023 21:15:36 -0800 (PST)
From:   Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1673932533;
        bh=AQvIfe3qx9w8jhuaSJEUblMK8k+oTyUQUYnmrHAawCQ=;
        h=From:Date:Subject:To:Cc:From;
        b=Z/sL4YMi+swo+fGn5xvQnFqeOSZve4GWk72qMkzD/6L32g4qJ1jjlE0MOwi5aLEPX
         buP4XnIq+RiwPbv05hTGVjxnPpH2Z0SLjvSvAF+FOK4fuzAKIVpNzrmSKKwqYmwJfO
         e1zCTErpOGkkTW9OOCFAVSUml1J9MB09BgEzIQKI=
Date:   Tue, 17 Jan 2023 05:15:25 +0000
Subject: [PATCH] kernel/.gitignore: ignore temporary kheaders_data directory
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-Id: <20230117-kernel-kheaders-gitignore-v1-1-2a3a070efd0d@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAO0uxmMC/x2NywqDMBBFf0Vm3YFEq4K/UrrIY0wGw1gmthTEf
 2/o8lw495xQSZkqLN0JSh+uvEsDe+sgZCeJkGNj6E0/GGtn3EiFCm6ZXCStmPjgJLsSribOw32c
 gp88NN+7SujVScjtQd6ltPGltPL3H3w8r+sHqBM0/YAAAAA=
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.11.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673932531; l=732;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=AQvIfe3qx9w8jhuaSJEUblMK8k+oTyUQUYnmrHAawCQ=;
 b=HHjLXj+5ptdigrisekpl4xX0XfrGEw1+VTrv+3nb5z8j7E/w4NIkHzubj9mxDkEz1lZ7+AuPaqx7
 A5gP/E16Bx0NroQ8VHJRRvAM2K/rC51F7YB9WuFbMAY/UyyAxmm6
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

If the kheaders archive generation is interrupted then this directory
may be left. Ignore it, it will be deleted by the next run of
kernel/gen_kheaders.sh.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 kernel/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/.gitignore b/kernel/.gitignore
index c6b299a6b786..57ab1d703763 100644
--- a/kernel/.gitignore
+++ b/kernel/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 /config_data
 /kheaders.md5
+/kheaders_data.tar.xz.tmp/

---
base-commit: d532dd102151cc69fcd00b13e5a9689b23c0c8d9
change-id: 20230117-kernel-kheaders-gitignore-f0d73456cb6b

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>
