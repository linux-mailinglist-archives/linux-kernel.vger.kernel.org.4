Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B8C71FA0C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 08:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbjFBG0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 02:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbjFBG0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 02:26:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 50336EB
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 23:26:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BDDF1063;
        Thu,  1 Jun 2023 23:26:55 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.41.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0D2DB3F67D;
        Thu,  1 Jun 2023 23:26:05 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, broonie@kernel.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>, kvmarm@lists.linux.dev,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 01/14] arm64/sysreg: Rename TRBLIMITR_EL1 fields per auto-gen tools format
Date:   Fri,  2 Jun 2023 11:55:39 +0530
Message-Id: <20230602062552.565992-2-anshuman.khandual@arm.com>
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

This renames TRBLIMITR_EL1 register fields per auto-gen tools format
without causing any functional change in the TRBE driver.

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
 arch/arm64/include/asm/sysreg.h              | 16 +++++++--------
 arch/arm64/kvm/hyp/nvhe/debug-sr.c           |  2 +-
 drivers/hwtracing/coresight/coresight-trbe.c | 21 ++++++++++----------
 drivers/hwtracing/coresight/coresight-trbe.h |  7 ++++---
 4 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index e72d9aaab6b1..b2b67ae7525b 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -246,14 +246,14 @@
 #define SYS_TRBTRG_EL1			sys_reg(3, 0, 9, 11, 6)
 #define SYS_TRBIDR_EL1			sys_reg(3, 0, 9, 11, 7)
 
-#define TRBLIMITR_LIMIT_MASK		GENMASK_ULL(51, 0)
-#define TRBLIMITR_LIMIT_SHIFT		12
-#define TRBLIMITR_NVM			BIT(5)
-#define TRBLIMITR_TRIG_MODE_MASK	GENMASK(1, 0)
-#define TRBLIMITR_TRIG_MODE_SHIFT	3
-#define TRBLIMITR_FILL_MODE_MASK	GENMASK(1, 0)
-#define TRBLIMITR_FILL_MODE_SHIFT	1
-#define TRBLIMITR_ENABLE		BIT(0)
+#define TRBLIMITR_EL1_LIMIT_MASK	GENMASK_ULL(63, 12)
+#define TRBLIMITR_EL1_LIMIT_SHIFT	12
+#define TRBLIMITR_EL1_nVM		BIT(5)
+#define TRBLIMITR_EL1_TM_MASK		GENMASK(4, 3)
+#define TRBLIMITR_EL1_TM_SHIFT		3
+#define TRBLIMITR_EL1_FM_MASK		GENMASK(2, 1)
+#define TRBLIMITR_EL1_FM_SHIFT		1
+#define TRBLIMITR_EL1_E			BIT(0)
 #define TRBPTR_PTR_MASK			GENMASK_ULL(63, 0)
 #define TRBPTR_PTR_SHIFT		0
 #define TRBBASER_BASE_MASK		GENMASK_ULL(51, 0)
diff --git a/arch/arm64/kvm/hyp/nvhe/debug-sr.c b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
index d756b939f296..4558c02eb352 100644
--- a/arch/arm64/kvm/hyp/nvhe/debug-sr.c
+++ b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
@@ -56,7 +56,7 @@ static void __debug_save_trace(u64 *trfcr_el1)
 	*trfcr_el1 = 0;
 
 	/* Check if the TRBE is enabled */
-	if (!(read_sysreg_s(SYS_TRBLIMITR_EL1) & TRBLIMITR_ENABLE))
+	if (!(read_sysreg_s(SYS_TRBLIMITR_EL1) & TRBLIMITR_EL1_E))
 		return;
 	/*
 	 * Prohibit trace generation while we are in guest.
diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 1fc4fd79a1c6..1d9d141c62e9 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -218,7 +218,7 @@ static inline void set_trbe_enabled(struct trbe_cpudata *cpudata, u64 trblimitr)
 	 * Enable the TRBE without clearing LIMITPTR which
 	 * might be required for fetching the buffer limits.
 	 */
-	trblimitr |= TRBLIMITR_ENABLE;
+	trblimitr |= TRBLIMITR_EL1_E;
 	write_sysreg_s(trblimitr, SYS_TRBLIMITR_EL1);
 
 	/* Synchronize the TRBE enable event */
@@ -236,7 +236,7 @@ static inline void set_trbe_disabled(struct trbe_cpudata *cpudata)
 	 * Disable the TRBE without clearing LIMITPTR which
 	 * might be required for fetching the buffer limits.
 	 */
-	trblimitr &= ~TRBLIMITR_ENABLE;
+	trblimitr &= ~TRBLIMITR_EL1_E;
 	write_sysreg_s(trblimitr, SYS_TRBLIMITR_EL1);
 
 	if (trbe_needs_drain_after_disable(cpudata))
@@ -596,13 +596,13 @@ static void set_trbe_limit_pointer_enabled(struct trbe_buf *buf)
 	u64 trblimitr = read_sysreg_s(SYS_TRBLIMITR_EL1);
 	unsigned long addr = buf->trbe_limit;
 
-	WARN_ON(!IS_ALIGNED(addr, (1UL << TRBLIMITR_LIMIT_SHIFT)));
+	WARN_ON(!IS_ALIGNED(addr, (1UL << TRBLIMITR_EL1_LIMIT_SHIFT)));
 	WARN_ON(!IS_ALIGNED(addr, PAGE_SIZE));
 
-	trblimitr &= ~TRBLIMITR_NVM;
-	trblimitr &= ~(TRBLIMITR_FILL_MODE_MASK << TRBLIMITR_FILL_MODE_SHIFT);
-	trblimitr &= ~(TRBLIMITR_TRIG_MODE_MASK << TRBLIMITR_TRIG_MODE_SHIFT);
-	trblimitr &= ~(TRBLIMITR_LIMIT_MASK << TRBLIMITR_LIMIT_SHIFT);
+	trblimitr &= ~TRBLIMITR_EL1_nVM;
+	trblimitr &= ~TRBLIMITR_EL1_FM_MASK;
+	trblimitr &= ~TRBLIMITR_EL1_TM_MASK;
+	trblimitr &= ~TRBLIMITR_EL1_LIMIT_MASK;
 
 	/*
 	 * Fill trace buffer mode is used here while configuring the
@@ -613,14 +613,15 @@ static void set_trbe_limit_pointer_enabled(struct trbe_buf *buf)
 	 * trace data in the interrupt handler, before reconfiguring
 	 * the TRBE.
 	 */
-	trblimitr |= (TRBE_FILL_MODE_FILL & TRBLIMITR_FILL_MODE_MASK) << TRBLIMITR_FILL_MODE_SHIFT;
+	trblimitr |= (TRBLIMITR_EL1_FM_FILL << TRBLIMITR_EL1_FM_SHIFT) &
+		     TRBLIMITR_EL1_FM_MASK;
 
 	/*
 	 * Trigger mode is not used here while configuring the TRBE for
 	 * the trace capture. Hence just keep this in the ignore mode.
 	 */
-	trblimitr |= (TRBE_TRIG_MODE_IGNORE & TRBLIMITR_TRIG_MODE_MASK) <<
-		      TRBLIMITR_TRIG_MODE_SHIFT;
+	trblimitr |= (TRBLIMITR_EL1_TM_IGNR << TRBLIMITR_EL1_TM_SHIFT) &
+		     TRBLIMITR_EL1_TM_MASK;
 	trblimitr |= (addr & PAGE_MASK);
 	set_trbe_enabled(buf->cpudata, trblimitr);
 }
diff --git a/drivers/hwtracing/coresight/coresight-trbe.h b/drivers/hwtracing/coresight/coresight-trbe.h
index 98ff1b17ad07..8ea7079d60bb 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.h
+++ b/drivers/hwtracing/coresight/coresight-trbe.h
@@ -30,7 +30,7 @@ static inline bool is_trbe_enabled(void)
 {
 	u64 trblimitr = read_sysreg_s(SYS_TRBLIMITR_EL1);
 
-	return trblimitr & TRBLIMITR_ENABLE;
+	return trblimitr & TRBLIMITR_EL1_E;
 }
 
 #define TRBE_EC_OTHERS		0
@@ -86,8 +86,9 @@ static inline bool is_trbe_running(u64 trbsr)
 
 #define TRBE_TRIG_MODE_STOP		0
 #define TRBE_TRIG_MODE_IRQ		1
-#define TRBE_TRIG_MODE_IGNORE		3
+#define TRBLIMITR_EL1_TM_IGNR		3
 
+#define TRBLIMITR_EL1_FM_FILL		0
 #define TRBE_FILL_MODE_FILL		0
 #define TRBE_FILL_MODE_WRAP		1
 #define TRBE_FILL_MODE_CIRCULAR_BUFFER	3
@@ -121,7 +122,7 @@ static inline void set_trbe_write_pointer(unsigned long addr)
 static inline unsigned long get_trbe_limit_pointer(void)
 {
 	u64 trblimitr = read_sysreg_s(SYS_TRBLIMITR_EL1);
-	unsigned long addr = trblimitr & (TRBLIMITR_LIMIT_MASK << TRBLIMITR_LIMIT_SHIFT);
+	unsigned long addr = trblimitr & TRBLIMITR_EL1_LIMIT_MASK;
 
 	WARN_ON(!IS_ALIGNED(addr, PAGE_SIZE));
 	return addr;
-- 
2.25.1

