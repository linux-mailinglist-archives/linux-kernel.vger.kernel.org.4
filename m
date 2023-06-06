Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9C772448F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 15:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236800AbjFFNhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 09:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbjFFNhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:37:36 -0400
X-Greylist: delayed 82 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 06 Jun 2023 06:37:34 PDT
Received: from mail02.habana.ai (habanamailrelay.habana.ai [213.57.90.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD94E6E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 06:37:33 -0700 (PDT)
Received: internal info suppressed
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=habana.ai; s=default;
        t=1686058421; bh=ZlUQIjrfo6sd/b8GvBBxqDWsgyZOfL/4y2cvenY74yk=;
        h=From:To:Cc:Subject:Date:From;
        b=TSryi3AATgNL45nEQrZVmjqnYDsTHsc2uLFw+qfNK5zrLNIIp+nWodFu08hCy7fim
         eUg7eC3M+570/znNvk+dAx5QZjbTuL06SB9D3UY+639nN5ZtAzubP69EfqZBHL3SPD
         4GqKUAOdx5zZd8I5XC6ZFfCYUYsqD/WP8PiQB2GkmOrh53ouJDPnYC947Hw4qvXRJ0
         m1D8bl4SnDgeB8K73Xz6aMF6LHJIhAMClSAyOrGUZs828RSt0defI90HnI7YJ74kTO
         DdEvgwzqoka1xIosslfpYTsvBBxi7sMpLImmMlx1yKnd5Jb8DYobNoIePD/pPgCpnT
         xFz2M+w2MA1Nw==
Received: from mhaimovski-vm-u20.habana-labs.com (localhost [127.0.0.1])
        by mhaimovski-vm-u20.habana-labs.com (8.15.2/8.15.2/Debian-18) with ESMTPS id 356DZcfH197384
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 6 Jun 2023 16:35:38 +0300
Received: (from mhaimovski@localhost)
        by mhaimovski-vm-u20.habana-labs.com (8.15.2/8.15.2/Submit) id 356DZbpV197382;
        Tue, 6 Jun 2023 16:35:37 +0300
From:   Moti Haimovski <mhaimovski@habana.ai>
To:     gregkh@linuxfoundation.org, david.m.ertman@intel.com
Cc:     ogabbay@kernel.org, linux-kernel@vger.kernel.org,
        Moti Haimovski <mhaimovski@habana.ai>
Subject: [PATCH v1] make AUXILIARY_BUS config selection clearer
Date:   Tue,  6 Jun 2023 16:35:28 +0300
Message-Id: <20230606133528.197335-1-mhaimovski@habana.ai>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a display string and a help section to the config AUXILIARY_BUS
section under the "Generic Driver Options" menu in order to make its
selection clearer.

Signed-off-by: Moti Haimovski <mhaimovski@habana.ai>
---
 drivers/base/Kconfig | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 6f04b831a5c0..e1caac1d9a58 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -2,7 +2,16 @@
 menu "Generic Driver Options"
 
 config AUXILIARY_BUS
-	bool
+	bool "Support for auxiliary bus"
+	help
+	  The auxiliary bus driver provides a way to export an interface
+	  for another subsystem to drive, implement a common intersection
+	  of functionality or split a function into child-devices
+	  representing sub-domains of functionality where each auxiliary
+	  device represents a part of its parent functionality (usually)
+	  driven by another driver.
+
+	  If unsure, say Y.
 
 config UEVENT_HELPER
 	bool "Support for uevent helper"
-- 
2.25.1

