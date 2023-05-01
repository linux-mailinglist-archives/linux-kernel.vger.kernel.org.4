Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBFE6F3378
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 18:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbjEAQS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 12:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjEAQSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 12:18:53 -0400
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4736E128
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 09:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
        t=1682957928; bh=qjJiyzBNBbUlf4yh42f8z12rbSe6xROgU/PEvKYl9WY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=zsdYFVH+eXgM1V4khs9DxIP/19Uscz+GnMj7CB+thDkHHFGvqKw8GfY51znpeFG7k
         OxM68HAlGswGg7sdFARFPqP8R3ZyT3U6PWkhEv3m1t7HeFTHRbS2OjyxGs1LAcAAhI
         ej3f3s4sqlyY15OW28iHYFA+wTwZIaxLjYK6/uP0=
Received: from cyy-pc.lan ([2001:da8:c800:d084:c65a:644a:13d7:e72c])
        by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
        id 4A78EECC; Tue, 02 May 2023 00:18:39 +0800
X-QQ-mid: xmsmtpt1682957919tn47q1wz9
Message-ID: <tencent_B30EED51C7235CA1988890E5C658BE35C107@qq.com>
X-QQ-XMAILINFO: MmpliBmRb3iCy16tAaa39EEOagJjQ/rnxcLb/w1MiUhusue37gubn/ccZAhw6G
         roM8215nTTF3jNos8LmPBjZW0CUOzczJMEAx30b5eg1B9mFyJAkBxz8c/QH3qPkz3vZbUDrUb4mI
         qtp5jjj4V+Fl30GJmSaWo4p+Ip4nkaGvrWd9+NhSbIeYR3157oy8kOTAr9Y/Xc70PTU3tMlcUd5v
         U90AcX/zwxWIPS6+DyWPaovc7D6GoJSh1N9AULZpfutwGS9mYMMqlydWY0y5Hg3Iew8WzdOUrJBM
         nlaMjwGuXng93ZQ0fx3omZkVy4F5D/nxvZfDWY+PbnTbeibCwcoImujyW9/0Il72/1aAdi5IOLcX
         6WNNpPk1ezubO/bvLQte1+iqX+ajJycr+b4649ZCrkBi1W/PlxYWmlPuJzwyypNDu/5j2W4zRGLC
         J6h90ijjtsEfm9WSxNd9Ae7+oAzuBUFJW0T0P59n9qpqosvJJ/CdDSen09wPOLH/ffmqa2Ctbjg+
         x8olpSk2ndGcwjkHE5MPI63jPdi81k+tU7TYjR5iowMota7xdQGOBGYnZgQ76owSJGKKRy3XTLrN
         44mtvMg7GyCb79bUKYSYFgdp7Ebbu+igBLCjdGpRBbrQiiOGGRtVBQq/0+NP4orBIka6XDkQ8OEB
         5itRtcTNHUmSmCQeOVBDbQO5mlDLQOamciQYpnTRThh9/FL5fzNEuvtCgxw2E5WBGBKjBINOBysy
         V0HReKhIFa0EECUoQ5aStcL2CRRr6mN08ITB5F7TobII4dM8u2Vbtul/8fnIB+F6sEQiGNrl2FDi
         3k5jJY3NtL+8PJAPfpBfr6kboIMbJ2XvFgOguqHZeC7Er7B7N86naNOznEAdTNorPD8P3g41EWE9
         jJ0fJ4myt3jhRTSFrXHjlCsmJcmBM4jGk3hhy4P0ssPoWc898LrPB1JL8OS7t8OS1u0VV8AN9YJa
         aaIMDyiyWfkF1JvRmjFAf7EAxZKP7oz188IIA2gLNSOWujrMbVPdDQrheoW9OMSF+91vRC4Eg=
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
        Hongren Zheng <i@zenithal.me>, Yangyu Chen <cyy@cyyself.name>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 1/2] riscv: allow case-insensitive ISA string parsing
Date:   Tue,  2 May 2023 00:17:38 +0800
X-OQ-MSGID: <20230501161739.152403-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <tencent_E6911C8D71F5624E432A1AFDF86804C3B509@qq.com>
References: <tencent_E6911C8D71F5624E432A1AFDF86804C3B509@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
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

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 arch/riscv/kernel/cpu.c        |  3 ++-
 arch/riscv/kernel/cpufeature.c | 35 +++++++++++++++++-----------------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 3df38052dcbd..f4dadbfecd04 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/cpu.h>
+#include <linux/ctype.h>
 #include <linux/init.h>
 #include <linux/seq_file.h>
 #include <linux/of.h>
@@ -42,7 +43,7 @@ int riscv_of_processor_hartid(struct device_node *node, unsigned long *hart)
 		pr_warn("CPU with hartid=%lu has no \"riscv,isa\" property\n", *hart);
 		return -ENODEV;
 	}
-	if (isa[0] != 'r' || isa[1] != 'v') {
+	if (tolower(isa[0]) != 'r' || tolower(isa[1]) != 'v') {
 		pr_warn("CPU with hartid=%lu has an invalid ISA of \"%s\"\n", *hart, isa);
 		return -ENODEV;
 	}
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 52585e088873..af2b468642a4 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -126,13 +126,10 @@ void __init riscv_fill_hwcap(void)
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
@@ -156,13 +153,15 @@ void __init riscv_fill_hwcap(void)
 					break;
 				}
 				fallthrough;
+			case 'S':
 			case 'x':
+			case 'X':
 			case 'z':
+			case 'Z':
 				ext_long = true;
 				/* Multi-letter extension must be delimited */
 				for (; *isa && *isa != '_'; ++isa)
-					if (unlikely(!islower(*isa)
-						     && !isdigit(*isa)))
+					if (unlikely(!isalnum(*isa)))
 						ext_err = true;
 				/* Parse backwards */
 				ext_end = isa;
@@ -173,7 +172,7 @@ void __init riscv_fill_hwcap(void)
 				/* Skip the minor version */
 				while (isdigit(*--ext_end))
 					;
-				if (ext_end[0] != 'p'
+				if (tolower(ext_end[0]) != 'p'
 				    || !isdigit(ext_end[-1])) {
 					/* Advance it to offset the pre-decrement */
 					++ext_end;
@@ -185,7 +184,7 @@ void __init riscv_fill_hwcap(void)
 				++ext_end;
 				break;
 			default:
-				if (unlikely(!islower(*ext))) {
+				if (unlikely(!isalpha(*ext))) {
 					ext_err = true;
 					break;
 				}
@@ -195,7 +194,7 @@ void __init riscv_fill_hwcap(void)
 				/* Skip the minor version */
 				while (isdigit(*++isa))
 					;
-				if (*isa != 'p')
+				if (tolower(*isa) != 'p')
 					break;
 				if (!isdigit(*++isa)) {
 					--isa;
@@ -209,18 +208,18 @@ void __init riscv_fill_hwcap(void)
 			if (*isa != '_')
 				--isa;
 
-#define SET_ISA_EXT_MAP(name, bit)						\
-			do {							\
-				if ((ext_end - ext == sizeof(name) - 1) &&	\
-				     !memcmp(ext, name, sizeof(name) - 1) &&	\
-				     riscv_isa_extension_check(bit))		\
-					set_bit(bit, this_isa);			\
-			} while (false)						\
+#define SET_ISA_EXT_MAP(name, bit)							\
+			do {								\
+				if ((ext_end - ext == sizeof(name) - 1) &&		\
+				     !strncasecmp(ext, name, sizeof(name) - 1) &&	\
+				     riscv_isa_extension_check(bit))			\
+					set_bit(bit, this_isa);				\
+			} while (false)							\
 
 			if (unlikely(ext_err))
 				continue;
 			if (!ext_long) {
-				int nr = *ext - 'a';
+				int nr = tolower(*ext) - 'a';
 
 				if (riscv_isa_extension_check(nr)) {
 					this_hwcap |= isa2hwcap[nr];
-- 
2.40.1

