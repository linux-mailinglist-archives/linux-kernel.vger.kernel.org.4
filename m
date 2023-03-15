Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB3A6BB5D5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 15:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbjCOOVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 10:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjCOOVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:21:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72FE67031;
        Wed, 15 Mar 2023 07:21:29 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 97BB0219BD;
        Wed, 15 Mar 2023 14:21:28 +0000 (UTC)
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 7E6D92C141;
        Wed, 15 Mar 2023 14:21:28 +0000 (UTC)
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: sibyte: Replace BCM1125H with SB1250 option
Date:   Wed, 15 Mar 2023 15:21:24 +0100
Message-Id: <20230315142124.110732-1-tsbogend@alpha.franken.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_FAIL,SPF_HELO_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SIBYTE_BCM1125H is identical to SIBYTE_SB1250, so remove one of them.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 arch/mips/Kconfig        |  2 +-
 arch/mips/sibyte/Kconfig | 11 -----------
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 277daaab1b0d..e1e67b1eae3e 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -808,7 +808,7 @@ config SIBYTE_CRHONE
 config SIBYTE_RHONE
 	bool "Sibyte BCM91125E-Rhone"
 	select BOOT_ELF32
-	select SIBYTE_BCM1125H
+	select SIBYTE_SB1250
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_SB1
 	select SYS_SUPPORTS_BIG_ENDIAN
diff --git a/arch/mips/sibyte/Kconfig b/arch/mips/sibyte/Kconfig
index c4596d49edf1..5fb92fe84149 100644
--- a/arch/mips/sibyte/Kconfig
+++ b/arch/mips/sibyte/Kconfig
@@ -20,17 +20,6 @@ config SIBYTE_BCM1125
 	select SIBYTE_HAS_ZBUS_PROFILING
 	select SIBYTE_SB1xxx_SOC
 
-config SIBYTE_BCM1125H
-	bool
-	select CEVT_SB1250
-	select CSRC_SB1250
-	select HAVE_PCI
-	select IRQ_MIPS_CPU
-	select SIBYTE_BCM112X
-	select SIBYTE_ENABLE_LDT_IF_PCI
-	select SIBYTE_HAS_ZBUS_PROFILING
-	select SIBYTE_SB1xxx_SOC
-
 config SIBYTE_BCM112X
 	bool
 	select CEVT_SB1250
-- 
2.35.3

