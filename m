Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3826DFC6F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 19:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjDLROY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 13:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjDLROU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 13:14:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1829A7AAA
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 10:14:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94255637B6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 17:14:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA54C4339C;
        Wed, 12 Apr 2023 17:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681319646;
        bh=0Hr13Ki+m63iSYR2fR5Lo1Ctqag6JX+98ae54h0hx9Q=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Y8kTpk+BcIZO4CmmWbEmdJMmXmVkXRdOE69Vo6t7o1zl301lR9i1IMq1CyKVDKsFX
         BwG482i+G6lJzDCMSvhk5gjT1srL5lTSDUqWGsQbKFCDxnKRnhigMTW1ej3z/ZfW2d
         JO8Zs2RQou/egLPXyqoeNFrvsU0MO72qTGmRDudnMuoUQZBFW2A7MjZOBRWDvDqrCL
         HDDWzSsqoTPyf/IJa2Ll2+9iSEskGgLcliolOMVob4MiG/VuaFd5mINDjZrJHcJsIC
         NNN+04S5JdFfE18rpqYpO+Yw1T3uA6uIMBxNhvYvhnAEjOK30GxtL7HoaZw++Lbimj
         bNf8YtkqyQK8w==
From:   Mark Brown <broonie@kernel.org>
Date:   Wed, 12 Apr 2023 18:13:30 +0100
Subject: [PATCH v2 2/3] arm64/cpufeature: Consistently use symbolic
 constants for min_field_value
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230303-arm64-cpufeature-helpers-v2-2-4c8f28a6f203@kernel.org>
References: <20230303-arm64-cpufeature-helpers-v2-0-4c8f28a6f203@kernel.org>
In-Reply-To: <20230303-arm64-cpufeature-helpers-v2-0-4c8f28a6f203@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-00303
X-Developer-Signature: v=1; a=openpgp-sha256; l=5978; i=broonie@kernel.org;
 h=from:subject:message-id; bh=0Hr13Ki+m63iSYR2fR5Lo1Ctqag6JX+98ae54h0hx9Q=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkNubXWzrulp6TD+KBufG9eIvD3FPBnKClVp5pns/X
 ZQWSGcuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZDbm1wAKCRAk1otyXVSH0EQFB/
 4kDPKxVRw872FOLTD5WBVxZNsCbrMLKnEt9uF2BinOBNy6NeUeIbYkgREMJEMLTJtK/3HH2l4V3hR9
 84e6ff1P4kAwEeHguNKAcseMc9mZlDW1sLuOBbP4LdO7XVLOkEnCD9ek71ARtno1PtDG96MYuTRHj8
 fkPb8nA19reqYdsQxy/ZQFaAfHfqvPIW7mBa/u49REdyXP1pmAAV2cKkmlaUV5QT4t/XB+bs3t91yi
 Fzpy43CEcsW84CErkgQfTSFZbDf9sH6vF96N5WyyP/F4GmC2G5wvsN95nSQd/Yss/T0nQdeD7i/rBg
 5z6pc9pYu8MBqB63BjxKk8XAuqBOaT
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A number of the cpufeatures use raw numbers for the minimum field values
specified rather than symbolic constants. In preparation for the use of
helper macros replace all these with the appropriate constants.

No change in the generated binary.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/cpufeature.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 77862b7c8908..1002ac437e8b 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2217,7 +2217,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.field_pos = ID_AA64PFR0_EL1_GIC_SHIFT,
 		.field_width = 4,
 		.sign = FTR_UNSIGNED,
-		.min_field_value = 1,
+		.min_field_value = ID_AA64PFR0_EL1_GIC_IMP,
 	},
 	{
 		.desc = "Enhanced Counter Virtualization",
@@ -2228,7 +2228,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.field_pos = ID_AA64MMFR0_EL1_ECV_SHIFT,
 		.field_width = 4,
 		.sign = FTR_UNSIGNED,
-		.min_field_value = 1,
+		.min_field_value = ID_AA64MMFR0_EL1_ECV_IMP,
 	},
 #ifdef CONFIG_ARM64_PAN
 	{
@@ -2240,7 +2240,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.field_pos = ID_AA64MMFR1_EL1_PAN_SHIFT,
 		.field_width = 4,
 		.sign = FTR_UNSIGNED,
-		.min_field_value = 1,
+		.min_field_value = ID_AA64MMFR1_EL1_PAN_IMP,
 		.cpu_enable = cpu_enable_pan,
 	},
 #endif /* CONFIG_ARM64_PAN */
@@ -2254,7 +2254,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.field_pos = ID_AA64MMFR1_EL1_PAN_SHIFT,
 		.field_width = 4,
 		.sign = FTR_UNSIGNED,
-		.min_field_value = 3,
+		.min_field_value = ID_AA64MMFR1_EL1_PAN_PAN3,
 	},
 #endif /* CONFIG_ARM64_EPAN */
 #ifdef CONFIG_ARM64_LSE_ATOMICS
@@ -2267,7 +2267,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.field_pos = ID_AA64ISAR0_EL1_ATOMIC_SHIFT,
 		.field_width = 4,
 		.sign = FTR_UNSIGNED,
-		.min_field_value = 2,
+		.min_field_value = ID_AA64ISAR0_EL1_ATOMIC_IMP,
 	},
 #endif /* CONFIG_ARM64_LSE_ATOMICS */
 	{
@@ -2335,7 +2335,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.sys_reg = SYS_ID_AA64PFR0_EL1,
 		.field_pos = ID_AA64PFR0_EL1_CSV3_SHIFT,
 		.field_width = 4,
-		.min_field_value = 1,
+		.min_field_value = ID_AA64PFR0_EL1_CSV3_IMP,
 		.matches = unmap_kernel_at_el0,
 		.cpu_enable = kpti_install_ng_mappings,
 	},
@@ -2355,7 +2355,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.sys_reg = SYS_ID_AA64ISAR1_EL1,
 		.field_pos = ID_AA64ISAR1_EL1_DPB_SHIFT,
 		.field_width = 4,
-		.min_field_value = 1,
+		.min_field_value = ID_AA64ISAR1_EL1_DPB_IMP,
 	},
 	{
 		.desc = "Data cache clean to Point of Deep Persistence",
@@ -2366,7 +2366,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.sign = FTR_UNSIGNED,
 		.field_pos = ID_AA64ISAR1_EL1_DPB_SHIFT,
 		.field_width = 4,
-		.min_field_value = 2,
+		.min_field_value = ID_AA64ISAR1_EL1_DPB_DPB2,
 	},
 #endif
 #ifdef CONFIG_ARM64_SVE
@@ -2437,7 +2437,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.sign = FTR_UNSIGNED,
 		.field_pos = ID_AA64MMFR2_EL1_FWB_SHIFT,
 		.field_width = 4,
-		.min_field_value = 1,
+		.min_field_value = ID_AA64MMFR2_EL1_FWB_IMP,
 		.matches = has_cpuid_feature,
 	},
 	{
@@ -2448,7 +2448,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.sign = FTR_UNSIGNED,
 		.field_pos = ID_AA64MMFR2_EL1_TTL_SHIFT,
 		.field_width = 4,
-		.min_field_value = 1,
+		.min_field_value = ID_AA64MMFR2_EL1_TTL_IMP,
 		.matches = has_cpuid_feature,
 	},
 	{
@@ -2478,7 +2478,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.sign = FTR_UNSIGNED,
 		.field_pos = ID_AA64MMFR1_EL1_HAFDBS_SHIFT,
 		.field_width = 4,
-		.min_field_value = 2,
+		.min_field_value = ID_AA64MMFR1_EL1_HAFDBS_DBM,
 		.matches = has_hw_dbm,
 		.cpu_enable = cpu_enable_hw_dbm,
 	},
@@ -2491,7 +2491,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.sys_reg = SYS_ID_AA64ISAR0_EL1,
 		.field_pos = ID_AA64ISAR0_EL1_CRC32_SHIFT,
 		.field_width = 4,
-		.min_field_value = 1,
+		.min_field_value = ID_AA64ISAR0_EL1_CRC32_IMP,
 	},
 	{
 		.desc = "Speculative Store Bypassing Safe (SSBS)",
@@ -2514,7 +2514,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.sign = FTR_UNSIGNED,
 		.field_pos = ID_AA64MMFR2_EL1_CnP_SHIFT,
 		.field_width = 4,
-		.min_field_value = 1,
+		.min_field_value = ID_AA64MMFR2_EL1_CnP_IMP,
 		.cpu_enable = cpu_enable_cnp,
 	},
 #endif
@@ -2527,7 +2527,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.field_pos = ID_AA64ISAR1_EL1_SB_SHIFT,
 		.field_width = 4,
 		.sign = FTR_UNSIGNED,
-		.min_field_value = 1,
+		.min_field_value = ID_AA64ISAR1_EL1_SB_IMP,
 	},
 #ifdef CONFIG_ARM64_PTR_AUTH
 	{
@@ -2636,7 +2636,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.field_width = 4,
 		.field_pos = ID_AA64MMFR2_EL1_E0PD_SHIFT,
 		.matches = has_cpuid_feature,
-		.min_field_value = 1,
+		.min_field_value = ID_AA64MMFR2_EL1_E0PD_IMP,
 		.cpu_enable = cpu_enable_e0pd,
 	},
 #endif
@@ -2649,7 +2649,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.field_pos = ID_AA64ISAR0_EL1_RNDR_SHIFT,
 		.field_width = 4,
 		.sign = FTR_UNSIGNED,
-		.min_field_value = 1,
+		.min_field_value = ID_AA64ISAR0_EL1_RNDR_IMP,
 	},
 #ifdef CONFIG_ARM64_BTI
 	{
@@ -2703,7 +2703,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.field_pos = ID_AA64ISAR1_EL1_LRCPC_SHIFT,
 		.field_width = 4,
 		.matches = has_cpuid_feature,
-		.min_field_value = 1,
+		.min_field_value = ID_AA64ISAR1_EL1_LRCPC_IMP,
 	},
 #ifdef CONFIG_ARM64_SME
 	{

-- 
2.30.2

