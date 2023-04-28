Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E99B6F1A4F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 16:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346073AbjD1OQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 10:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345870AbjD1OQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 10:16:31 -0400
Received: from out203-205-251-60.mail.qq.com (out203-205-251-60.mail.qq.com [203.205.251.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB784EEE
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 07:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
        t=1682691382; bh=IzugUJb7/4phjX3Y0sEr22Y1Y7HtJJRn5Ka8RNsPSqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=HvFVTjhgOA2jCesYNl8nXKUG759nQjeUyubHk8SCTMkGFzlR1qLSNagBbhSwrxvuf
         60AnCakn/SYVVAxNmRjuSs6zrCHkWncWavZ31e3Q18ReQK8Wb360HYxwfPUK4VF7Xw
         URp698ujHj3257XwgcFr8SQlebyTwipYw5QVnAGw=
Received: from cyy-pc.lan ([2001:da8:c800:d084:c65a:644a:13d7:e72c])
        by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
        id 4029CE99; Fri, 28 Apr 2023 22:16:02 +0800
X-QQ-mid: xmsmtpt1682691367tols93pky
Message-ID: <tencent_BC90DDC6093E3E41246D3EC73F5CAB189007@qq.com>
X-QQ-XMAILINFO: OOWntbL6xj16iQ7PhPGnOnEfLWtZacxQviXVXFDf2ZiQ+X+Se+ma44Hrt0ch3D
         mXTjFs6dNjNSwD1D3DyEYb68Vkj/bU3cT/7B25W+8V8ZYEQEl1QPVzdfLzWjwEYiy0Yr0EXldbdR
         WgJRb+ln2Xs3Iwk6liVaj0bf+bcc3YSg5TBk47cFvHmw6GIJOl4w8LYFkmflbm7AGyO1c86NIhB0
         9AIr1eUJxAWFi+JKNgMpXP53P/FPrVZuLoSqgMLQBsUHTMMLWRyr+rIvAat7j2wVL+zxTLbkcBcx
         jCJBJzmahz9kBasaTrkVOcJ+lBk2FSZE2QSXUVoSqVvgjMuacNFX7ap8Ge/xlPpjtLCMXMVZMH7H
         3fBHWTpDowHtwOBRVx7oCPD1oSfM0SLVvRtDjakcxQe7uAytBdJbnUKz+vPzhw0ZXBdpAvY4I80u
         KystQ1rPCj891ikjuGlA2pN7fmaKsuULC8SxM1ksYa1WoxT3XnOSdAzeF3OnGwyCBwelHsBjRqj6
         TgIBzzoDwkoDfwq0LTMvyKIKcIFJ6IGA1AX7EqvISqplNzEs1aWAhMP/Lf+Q2RVMCYQWaXOMUcxU
         RKrwcVmBzqazWg9AfnNHCEM1bKXVyudwN/f1w67z0PlCFxARfz8/l9OIY/QLoly8kgyOihZaKPSN
         nX1221/ugcDUQkD6OahkNgWjtc/qROYDiq+bo2E9h86uKnKLVqqQjnL78Zla1v8feS7Om7yotv/5
         3gTRKLNxDvRNZwemwkiM2s+rnPnT8rM6xl5U6hRrlU+zxPadim5Qlqu+0l/LicRF909kZMa0IK/N
         TlAYzYjcyZ0AZ9gl2oE5z/HILUKm/M+DfORrXFlomMmISHETVaQ3GAbqV0RVGMfjGSvs/97wYvgY
         YtNbJR4T5W/96cESl3ZapV1LFHPEQ60oAe8pew0co3DleZZkMbE0OCLaetU44iuxijCjvp/QA2G0
         vKFJ2tkr+lsOnHbSJiyyeCl/4UY00h2A8A62qdRdoNWUlmgDPMgkRnGA2qafR2
From:   Yangyu Chen <cyy@cyyself.name>
To:     Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Jones <ajones@ventanamicro.com>,
        Wende Tan <twd2.me@gmail.com>, Soha Jin <soha@lohu.info>,
        Hongren Zheng <i@zenithal.me>, Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH v2 1/2] riscv: allow case-insensitive ISA string parsing
Date:   Fri, 28 Apr 2023 22:16:00 +0800
X-OQ-MSGID: <20230428141601.678489-2-cyy@cyyself.name>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230428141601.678489-1-cyy@cyyself.name>
References: <20230428141601.678489-1-cyy@cyyself.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to RISC-V Hart Capabilities Table (RHCT) description in UEFI
Forum ECR, the format of the ISA string is defined in the RISC-V
unprivileged specification which is case-insensitive. However, the
current ISA string parser in the kernel does not support ISA strings
with uppercase letters.

This patch modifies the ISA string parser in the kernel to support
case-insensitive ISA string parsing.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 arch/riscv/kernel/cpu.c        |  3 ++-
 arch/riscv/kernel/cpufeature.c | 25 ++++++++++++-------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 8400f0cc9704..52b92a267121 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/cpu.h>
+#include <linux/ctype.h>
 #include <linux/init.h>
 #include <linux/seq_file.h>
 #include <linux/of.h>
@@ -41,7 +42,7 @@ int riscv_of_processor_hartid(struct device_node *node, unsigned long *hart)
 		pr_warn("CPU with hartid=%lu has no \"riscv,isa\" property\n", *hart);
 		return -ENODEV;
 	}
-	if (isa[0] != 'r' || isa[1] != 'v') {
+	if (tolower(isa[0]) != 'r' || tolower(isa[1]) != 'v') {
 		pr_warn("CPU with hartid=%lu has an invalid ISA of \"%s\"\n", *hart, isa);
 		return -ENODEV;
 	}
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 59d58ee0f68d..d1991c12e546 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -119,13 +119,10 @@ void __init riscv_fill_hwcap(void)
 		}
 
 		temp = isa;
-#if IS_ENABLED(CONFIG_32BIT)
-		if (!strncmp(isa, "rv32", 4))
+		if (IS_ENABLED(CONFIG_32BIT) && !strncasecmp(isa, "rv32", 4))
 			isa += 4;
-#elif IS_ENABLED(CONFIG_64BIT)
-		if (!strncmp(isa, "rv64", 4))
+		else if (IS_ENABLED(CONFIG_64BIT) && !strncasecmp(isa, "rv64", 4))
 			isa += 4;
-#endif
 		/* The riscv,isa DT property must start with rv64 or rv32 */
 		if (temp == isa)
 			continue;
@@ -136,6 +133,7 @@ void __init riscv_fill_hwcap(void)
 			bool ext_long = false, ext_err = false;
 
 			switch (*ext) {
+			case 'S':
 			case 's':
 				/**
 				 * Workaround for invalid single-letter 's' & 'u'(QEMU).
@@ -143,19 +141,20 @@ void __init riscv_fill_hwcap(void)
 				 * not valid ISA extensions. It works until multi-letter
 				 * extension starting with "Su" appears.
 				 */
-				if (ext[-1] != '_' && ext[1] == 'u') {
+				if (ext[-1] != '_' && tolower(ext[1]) == 'u') {
 					++isa;
 					ext_err = true;
 					break;
 				}
 				fallthrough;
+			case 'X':
 			case 'x':
+			case 'Z':
 			case 'z':
 				ext_long = true;
 				/* Multi-letter extension must be delimited */
 				for (; *isa && *isa != '_'; ++isa)
-					if (unlikely(!islower(*isa)
-						     && !isdigit(*isa)))
+					if (unlikely(!isalnum(*isa)))
 						ext_err = true;
 				/* Parse backwards */
 				ext_end = isa;
@@ -166,7 +165,7 @@ void __init riscv_fill_hwcap(void)
 				/* Skip the minor version */
 				while (isdigit(*--ext_end))
 					;
-				if (ext_end[0] != 'p'
+				if (tolower(ext_end[0]) != 'p'
 				    || !isdigit(ext_end[-1])) {
 					/* Advance it to offset the pre-decrement */
 					++ext_end;
@@ -178,7 +177,7 @@ void __init riscv_fill_hwcap(void)
 				++ext_end;
 				break;
 			default:
-				if (unlikely(!islower(*ext))) {
+				if (unlikely(!isalpha(*ext))) {
 					ext_err = true;
 					break;
 				}
@@ -188,7 +187,7 @@ void __init riscv_fill_hwcap(void)
 				/* Skip the minor version */
 				while (isdigit(*++isa))
 					;
-				if (*isa != 'p')
+				if (tolower(*isa) != 'p')
 					break;
 				if (!isdigit(*++isa)) {
 					--isa;
@@ -205,7 +204,7 @@ void __init riscv_fill_hwcap(void)
 #define SET_ISA_EXT_MAP(name, bit)						\
 			do {							\
 				if ((ext_end - ext == sizeof(name) - 1) &&	\
-				     !memcmp(ext, name, sizeof(name) - 1) &&	\
+				     !strncasecmp(ext, name, sizeof(name) - 1) &&	\
 				     riscv_isa_extension_check(bit))		\
 					set_bit(bit, this_isa);			\
 			} while (false)						\
@@ -213,7 +212,7 @@ void __init riscv_fill_hwcap(void)
 			if (unlikely(ext_err))
 				continue;
 			if (!ext_long) {
-				int nr = *ext - 'a';
+				int nr = tolower(*ext) - 'a';
 
 				if (riscv_isa_extension_check(nr)) {
 					this_hwcap |= isa2hwcap[nr];
-- 
2.40.0

