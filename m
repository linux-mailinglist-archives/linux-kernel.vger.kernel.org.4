Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E7A71FA11
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 08:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbjFBG1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 02:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbjFBG0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 02:26:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A796E4C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 23:26:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48E6C1042;
        Thu,  1 Jun 2023 23:27:09 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.41.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 123003F67D;
        Thu,  1 Jun 2023 23:26:19 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, broonie@kernel.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>, kvmarm@lists.linux.dev,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 04/14] arm64/sysreg: Rename TRBSR_EL1 fields per auto-gen tools format
Date:   Fri,  2 Jun 2023 11:55:42 +0530
Message-Id: <20230602062552.565992-5-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230602062552.565992-1-anshuman.khandual@arm.com>
References: <20230602062552.565992-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This renames TRBSR_EL1 register fields per auto-gen tools format without
causing any functional change in the TRBE driver.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: kvmarm@lists.linux.dev
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/sysreg.h              | 26 ++++++++++----------
 drivers/hwtracing/coresight/coresight-trbe.c | 12 ++++-----
 drivers/hwtracing/coresight/coresight-trbe.h | 16 ++++++------
 3 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 9b2d1c6faf13..af9e93ca1905 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -258,19 +258,19 @@
 #define TRBPTR_EL1_PTR_SHIFT		0
 #define TRBBASER_EL1_BASE_MASK		GENMASK_ULL(63, 12)
 #define TRBBASER_EL1_BASE_SHIFT		12
-#define TRBSR_EC_MASK			GENMASK(5, 0)
-#define TRBSR_EC_SHIFT			26
-#define TRBSR_IRQ			BIT(22)
-#define TRBSR_TRG			BIT(21)
-#define TRBSR_WRAP			BIT(20)
-#define TRBSR_ABORT			BIT(18)
-#define TRBSR_STOP			BIT(17)
-#define TRBSR_MSS_MASK			GENMASK(15, 0)
-#define TRBSR_MSS_SHIFT			0
-#define TRBSR_BSC_MASK			GENMASK(5, 0)
-#define TRBSR_BSC_SHIFT			0
-#define TRBSR_FSC_MASK			GENMASK(5, 0)
-#define TRBSR_FSC_SHIFT			0
+#define TRBSR_EL1_EC_MASK		GENMASK(31, 26)
+#define TRBSR_EL1_EC_SHIFT		26
+#define TRBSR_EL1_IRQ			BIT(22)
+#define TRBSR_EL1_TRG			BIT(21)
+#define TRBSR_EL1_WRAP			BIT(20)
+#define TRBSR_EL1_EA			BIT(18)
+#define TRBSR_EL1_S			BIT(17)
+#define TRBSR_EL1_MSS_MASK		GENMASK(15, 0)
+#define TRBSR_EL1_MSS_SHIFT		0
+#define TRBSR_EL1_BSC_MASK		GENMASK(5, 0)
+#define TRBSR_EL1_BSC_SHIFT		0
+#define TRBSR_EL1_FSC_MASK		GENMASK(5, 0)
+#define TRBSR_EL1_FSC_SHIFT		0
 #define TRBMAR_SHARE_MASK		GENMASK(1, 0)
 #define TRBMAR_SHARE_SHIFT		8
 #define TRBMAR_OUTER_MASK		GENMASK(3, 0)
diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 1d9d141c62e9..1bab91ce8e95 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -582,12 +582,12 @@ static void clr_trbe_status(void)
 	u64 trbsr = read_sysreg_s(SYS_TRBSR_EL1);
 
 	WARN_ON(is_trbe_enabled());
-	trbsr &= ~TRBSR_IRQ;
-	trbsr &= ~TRBSR_TRG;
-	trbsr &= ~TRBSR_WRAP;
-	trbsr &= ~(TRBSR_EC_MASK << TRBSR_EC_SHIFT);
-	trbsr &= ~(TRBSR_BSC_MASK << TRBSR_BSC_SHIFT);
-	trbsr &= ~TRBSR_STOP;
+	trbsr &= ~TRBSR_EL1_IRQ;
+	trbsr &= ~TRBSR_EL1_TRG;
+	trbsr &= ~TRBSR_EL1_WRAP;
+	trbsr &= ~TRBSR_EL1_EC_MASK;
+	trbsr &= ~TRBSR_EL1_BSC_MASK;
+	trbsr &= ~TRBSR_EL1_S;
 	write_sysreg_s(trbsr, SYS_TRBSR_EL1);
 }
 
diff --git a/drivers/hwtracing/coresight/coresight-trbe.h b/drivers/hwtracing/coresight/coresight-trbe.h
index 0b73d9d10aa8..3743d9085355 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.h
+++ b/drivers/hwtracing/coresight/coresight-trbe.h
@@ -39,7 +39,7 @@ static inline bool is_trbe_enabled(void)
 
 static inline int get_trbe_ec(u64 trbsr)
 {
-	return (trbsr >> TRBSR_EC_SHIFT) & TRBSR_EC_MASK;
+	return (trbsr & TRBSR_EL1_EC_MASK) >> TRBSR_EL1_EC_SHIFT;
 }
 
 #define TRBE_BSC_NOT_STOPPED 0
@@ -48,40 +48,40 @@ static inline int get_trbe_ec(u64 trbsr)
 
 static inline int get_trbe_bsc(u64 trbsr)
 {
-	return (trbsr >> TRBSR_BSC_SHIFT) & TRBSR_BSC_MASK;
+	return (trbsr & TRBSR_EL1_BSC_MASK) >> TRBSR_EL1_BSC_SHIFT;
 }
 
 static inline void clr_trbe_irq(void)
 {
 	u64 trbsr = read_sysreg_s(SYS_TRBSR_EL1);
 
-	trbsr &= ~TRBSR_IRQ;
+	trbsr &= ~TRBSR_EL1_IRQ;
 	write_sysreg_s(trbsr, SYS_TRBSR_EL1);
 }
 
 static inline bool is_trbe_irq(u64 trbsr)
 {
-	return trbsr & TRBSR_IRQ;
+	return trbsr & TRBSR_EL1_IRQ;
 }
 
 static inline bool is_trbe_trg(u64 trbsr)
 {
-	return trbsr & TRBSR_TRG;
+	return trbsr & TRBSR_EL1_TRG;
 }
 
 static inline bool is_trbe_wrap(u64 trbsr)
 {
-	return trbsr & TRBSR_WRAP;
+	return trbsr & TRBSR_EL1_WRAP;
 }
 
 static inline bool is_trbe_abort(u64 trbsr)
 {
-	return trbsr & TRBSR_ABORT;
+	return trbsr & TRBSR_EL1_EA;
 }
 
 static inline bool is_trbe_running(u64 trbsr)
 {
-	return !(trbsr & TRBSR_STOP);
+	return !(trbsr & TRBSR_EL1_S);
 }
 
 #define TRBE_TRIG_MODE_STOP		0
-- 
2.25.1

