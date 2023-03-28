Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018516CC068
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbjC1NPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbjC1NPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:15:00 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE88FB74B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 06:14:53 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sendonly@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 8717B4249A;
        Tue, 28 Mar 2023 13:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1680009292; bh=WRbEluBIEV7jHnCWK701TbH9lXJAyLcM/aZGlX67/Kg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=hXjfxzmy+bjJP1Fpfh00OxQbjMxbWQlrxsqL63NpIge5jgXFjTRR5wNPyCSeQBcSk
         wkCjGkpT/0FFpnN9lbfu8Je2zpxtZ0Cdqo4P2ABY/gj3R41LFUJVPELVLWUF6pgzYJ
         QqKCycYHxvU+wk4BP7mZDWUeZFmSfZlw6IQgqqPpWkYLWc/+w4k1HBP1JcdtkYD1cU
         Fd8NZmGT4dnuSf2Djb5LPI+vLPAuFaq/QKfmWifiLSkveMz24pmrIzMqxwleDr6tUF
         jpiUPKv4HZTLGUWsB8SrB9RJfrrwb5Mpe6c980+SSR7rQIerk8ZWshPhil9vABVU4B
         iK3Rp26CRo4Rw==
From:   Hector Martin <marcan@marcan.st>
Date:   Tue, 28 Mar 2023 22:14:18 +0900
Subject: [PATCH 5/5] soc: apple: mailbox: Rename config symbol to
 APPLE_MAILBOX
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230328-soc-mailbox-v1-5-3953814532fd@marcan.st>
References: <20230328-soc-mailbox-v1-0-3953814532fd@marcan.st>
In-Reply-To: <20230328-soc-mailbox-v1-0-3953814532fd@marcan.st>
To:     Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Janne Grunau <j@jannau.net>
Cc:     linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1768; i=marcan@marcan.st;
 h=from:subject:message-id; bh=WRbEluBIEV7jHnCWK701TbH9lXJAyLcM/aZGlX67/Kg=;
 b=owGbwMvMwCEm+yP4NEe/cRLjabUkhhSlFzb2Ledid97V2H582/tdDi4XleJzH76YsEH+hFKuc
 HugRn5ERykLgxgHg6yYIkvjid5T3Z7Tz6mrpkyHmcPKBDKEgYtTACZy2YThn73sX8ktsz/XCmyL
 WLRiB2/gbKXa6rBd2ucu9+iUh5VG6TMyfJUXW3JaM3k523sF5f0FttfTaqM3fpMyzqpVT/4WtmA
 jPwA=
X-Developer-Key: i=marcan@marcan.st; a=openpgp;
 fpr=FC18F00317968B7BE86201CBE22A629A4C515DD5
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the original owner of APPLE_MAILBOX removed, let's rename the new
APPLE_MBOX to the old name. This avoids .config churn for downstream
users, and leaves us with an identical config symbol and module name as
before.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/soc/apple/Kconfig  | 5 ++---
 drivers/soc/apple/Makefile | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/apple/Kconfig b/drivers/soc/apple/Kconfig
index d0e29bbd8c6f..c5203c388bf4 100644
--- a/drivers/soc/apple/Kconfig
+++ b/drivers/soc/apple/Kconfig
@@ -17,11 +17,10 @@ config APPLE_PMGR_PWRSTATE
 	  controls for SoC devices. This driver manages them through the
 	  generic power domain framework, and also provides reset support.
 
-config APPLE_MBOX
+config APPLE_MAILBOX
 	tristate "Apple SoC mailboxes"
 	depends on PM
 	depends on ARCH_APPLE || (64BIT && COMPILE_TEST)
-	depends on !APPLE_MAILBOX
 	default ARCH_APPLE
 	help
 	  Apple SoCs have various co-processors required for certain
@@ -33,7 +32,7 @@ config APPLE_MBOX
 
 config APPLE_RTKIT
 	tristate "Apple RTKit co-processor IPC protocol"
-	depends on APPLE_MBOX
+	depends on APPLE_MAILBOX
 	depends on ARCH_APPLE || COMPILE_TEST
 	default ARCH_APPLE
 	help
diff --git a/drivers/soc/apple/Makefile b/drivers/soc/apple/Makefile
index e52edf6a73da..20feee6f3943 100644
--- a/drivers/soc/apple/Makefile
+++ b/drivers/soc/apple/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_APPLE_PMGR_PWRSTATE)	+= apple-pmgr-pwrstate.o
 
-obj-$(CONFIG_APPLE_MBOX) += apple-mailbox.o
+obj-$(CONFIG_APPLE_MAILBOX) += apple-mailbox.o
 apple-mailbox-y = mailbox.o
 
 obj-$(CONFIG_APPLE_RTKIT) += apple-rtkit.o

-- 
2.40.0

