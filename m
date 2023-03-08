Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B3A6B1016
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 18:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjCHRUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 12:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjCHRTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 12:19:25 -0500
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD702822B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 09:18:06 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:614d:21b0:703:d0f9])
        by michel.telenet-ops.be with bizsmtp
        id VtH92900B3mNwr406tH9re; Wed, 08 Mar 2023 18:17:09 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pZxP0-00BGGd-WD;
        Wed, 08 Mar 2023 18:17:09 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pZxPZ-00FoRp-3z;
        Wed, 08 Mar 2023 18:17:09 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] iommu: Spelling s/cpmxchg64/cmpxchg64/
Date:   Wed,  8 Mar 2023 18:17:08 +0100
Message-Id: <eab156858147249d44463662eb9192202c39ab9f.1678295792.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix misspellings of "cmpxchg64"

Fixes: d286a58bc8f4d5cf ("iommu: Tidy up io-pgtable dependencies")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
---
 drivers/iommu/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 889c7efd050bc89f..c4928514e5e2a5ca 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -33,7 +33,7 @@ config IOMMU_IO_PGTABLE_LPAE
 	bool "ARMv7/v8 Long Descriptor Format"
 	select IOMMU_IO_PGTABLE
 	depends on ARM || ARM64 || COMPILE_TEST
-	depends on !GENERIC_ATOMIC64	# for cpmxchg64()
+	depends on !GENERIC_ATOMIC64	# for cmpxchg64()
 	help
 	  Enable support for the ARM long descriptor pagetable format.
 	  This allocator supports 4K/2M/1G, 16K/32M and 64K/512M page
@@ -72,7 +72,7 @@ config IOMMU_IO_PGTABLE_DART
 	bool "Apple DART Formats"
 	select IOMMU_IO_PGTABLE
 	depends on ARM64 || COMPILE_TEST
-	depends on !GENERIC_ATOMIC64	# for cpmxchg64()
+	depends on !GENERIC_ATOMIC64	# for cmpxchg64()
 	help
 	  Enable support for the Apple DART pagetable formats. These include
 	  the t8020 and t6000/t8110 DART formats used in Apple M1/M2 family
-- 
2.34.1

