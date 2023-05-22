Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E303C70C333
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 18:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbjEVQXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 12:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbjEVQXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 12:23:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A96F4
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 09:23:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BD1462018
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 16:23:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE98C433A1;
        Mon, 22 May 2023 16:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684772579;
        bh=CbUz/yoL9PyMSTqsbEC82EZry/1wdlsepwx6fDSgjrY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=bToiEcu0XHJRGSZDIG9qg2M0S+uaKB7rLa6MAcB9huIBJf0mtmUlJ5xUcRW0cV1HO
         EP7cIAMwNiCRtYB+O/cd0yOrgfsuj9AvH6srqd4Lga0xdgoojtmCLcRf8m+siFhn3O
         DTa0gF+ZAFc0j2Rve5Al6elICn3sJKz3lTZUc4X+4ePlxquBkxbFARhfpRruqglYow
         dd0WrAztZd373eMd5mnhUlzAihvzh1d2ysU3s5Kizr+v59PTifjE05KQ2k7M1rwQ3e
         xIpB+Amyx8tNlbKmxbIyHOm7UAG2WLOKmiKAz+YKtr0qsalgV9wtfZFl0H6rHJ++8P
         RcWpiYxxmIpOg==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 22 May 2023 17:22:43 +0100
Subject: [PATCH 4/5] arm64/sysreg: Standardise naming of bitfield constants
 in OSL[AS]R_EL1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230419-arm64-syreg-gen-v1-4-936cd769cb9e@kernel.org>
References: <20230419-arm64-syreg-gen-v1-0-936cd769cb9e@kernel.org>
In-Reply-To: <20230419-arm64-syreg-gen-v1-0-936cd769cb9e@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-bfdf5
X-Developer-Signature: v=1; a=openpgp-sha256; l=3462; i=broonie@kernel.org;
 h=from:subject:message-id; bh=CbUz/yoL9PyMSTqsbEC82EZry/1wdlsepwx6fDSgjrY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBka5bWSbm537iErZkk8Xr8ZgULfL2Xb94AV4jb1wRM
 zEBp0XKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZGuW1gAKCRAk1otyXVSH0HyhB/
 9Bo7sZXLklp6xHD7EhcM1apRk517eVTUbCt4PPAb5ng28+IiHaLcmt2Dsx8JOpYT7iS9xvtiM2qLKz
 7yEEUh4uNXOb3ooFqdubs1dzLBvNy/3jQTZzwzqm+BwMkUMQTtmQg81B99j61lkyJHETRfEPiPmDAL
 7fTrLW43BoRCbUJe4hp+6D4K3ZO/qta6SdBVfTU2Hz3CAl5OexaF+MMw1WgQCkYDaqfGxuhP0oVXUy
 cKNbABwcFjQ/YQ80g2CK7gMwFL0mWVwpo2wde+di9YxbluhMLIIKmwlNMJ4PsVHB2Uq4j45zIHQVJK
 jWPvX07eAvb2BfuV5MBTV9a2e1EcsI
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our standard scheme for naming the constants for bitfields in system
registers includes _ELx in the name but not the SYS_, update the
constants for OSL[AS]R_EL1 to follow this convention.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h |  2 +-
 arch/arm64/include/asm/sysreg.h   | 10 +++++-----
 arch/arm64/kvm/sys_regs.c         | 10 +++++-----
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index bcd774d74f34..cde4ad590f8c 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -996,7 +996,7 @@ void kvm_arm_clear_debug(struct kvm_vcpu *vcpu);
 void kvm_arm_reset_debug_ptr(struct kvm_vcpu *vcpu);
 
 #define kvm_vcpu_os_lock_enabled(vcpu)		\
-	(!!(__vcpu_sys_reg(vcpu, OSLSR_EL1) & SYS_OSLSR_OSLK))
+	(!!(__vcpu_sys_reg(vcpu, OSLSR_EL1) & OSLSR_EL1_OSLK))
 
 int kvm_arm_vcpu_arch_set_attr(struct kvm_vcpu *vcpu,
 			       struct kvm_device_attr *attr);
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 4ecae92b56b5..09de958e79ed 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -141,13 +141,13 @@
 #define SYS_MDRAR_EL1			sys_reg(2, 0, 1, 0, 0)
 
 #define SYS_OSLAR_EL1			sys_reg(2, 0, 1, 0, 4)
-#define SYS_OSLAR_OSLK			BIT(0)
+#define OSLAR_EL1_OSLK			BIT(0)
 
 #define SYS_OSLSR_EL1			sys_reg(2, 0, 1, 1, 4)
-#define SYS_OSLSR_OSLM_MASK		(BIT(3) | BIT(0))
-#define SYS_OSLSR_OSLM_NI		0
-#define SYS_OSLSR_OSLM_IMPLEMENTED	BIT(3)
-#define SYS_OSLSR_OSLK			BIT(1)
+#define OSLSR_EL1_OSLM_MASK		(BIT(3) | BIT(0))
+#define OSLSR_EL1_OSLM_NI		0
+#define OSLSR_EL1_OSLM_IMPLEMENTED	BIT(3)
+#define OSLSR_EL1_OSLK			BIT(1)
 
 #define SYS_OSDLR_EL1			sys_reg(2, 0, 1, 3, 4)
 #define SYS_DBGPRCR_EL1			sys_reg(2, 0, 1, 4, 4)
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 53749d3a0996..8a5160a90d3c 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -388,9 +388,9 @@ static bool trap_oslar_el1(struct kvm_vcpu *vcpu,
 		return read_from_write_only(vcpu, p, r);
 
 	/* Forward the OSLK bit to OSLSR */
-	oslsr = __vcpu_sys_reg(vcpu, OSLSR_EL1) & ~SYS_OSLSR_OSLK;
-	if (p->regval & SYS_OSLAR_OSLK)
-		oslsr |= SYS_OSLSR_OSLK;
+	oslsr = __vcpu_sys_reg(vcpu, OSLSR_EL1) & ~OSLSR_EL1_OSLK;
+	if (p->regval & OSLAR_EL1_OSLK)
+		oslsr |= OSLSR_EL1_OSLK;
 
 	__vcpu_sys_reg(vcpu, OSLSR_EL1) = oslsr;
 	return true;
@@ -414,7 +414,7 @@ static int set_oslsr_el1(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
 	 * The only modifiable bit is the OSLK bit. Refuse the write if
 	 * userspace attempts to change any other bit in the register.
 	 */
-	if ((val ^ rd->val) & ~SYS_OSLSR_OSLK)
+	if ((val ^ rd->val) & ~OSLSR_EL1_OSLK)
 		return -EINVAL;
 
 	__vcpu_sys_reg(vcpu, rd->reg) = val;
@@ -1760,7 +1760,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_MDRAR_EL1), trap_raz_wi },
 	{ SYS_DESC(SYS_OSLAR_EL1), trap_oslar_el1 },
 	{ SYS_DESC(SYS_OSLSR_EL1), trap_oslsr_el1, reset_val, OSLSR_EL1,
-		SYS_OSLSR_OSLM_IMPLEMENTED, .set_user = set_oslsr_el1, },
+		OSLSR_EL1_OSLM_IMPLEMENTED, .set_user = set_oslsr_el1, },
 	{ SYS_DESC(SYS_OSDLR_EL1), trap_raz_wi },
 	{ SYS_DESC(SYS_DBGPRCR_EL1), trap_raz_wi },
 	{ SYS_DESC(SYS_DBGCLAIMSET_EL1), trap_raz_wi },

-- 
2.30.2

