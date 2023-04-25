Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3B76EE18A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 14:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbjDYMCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 08:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233847AbjDYMCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 08:02:14 -0400
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12621422A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 05:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
        t=1682424128; bh=p43EnmmsQia7Y1cgEBWwoa6zY7RRnA2ygt6iTspjyd4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=NnlAAF8rNqM0VksgnA2Cc56DNQtNIUVceOIx0bEl1oHOylLpLCKhgWFJTp6RZRRQa
         i2ccAQ2q6++U5sFtyII2+eK6DJisy76M2zk5WuzKeRIkAm/FcCrZc6Ghd7QrOblWlh
         PyaPdM+sCfTu9M5wBDT66tjo9et5mq6ak+9H8/zc=
Received: from cyy-pc.lan ([2001:da8:c800:d084:c65a:644a:13d7:e72c])
        by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
        id 1235043; Tue, 25 Apr 2023 20:00:18 +0800
X-QQ-mid: xmsmtpt1682424049tf65iqzzs
Message-ID: <tencent_63090269FF399AE30AC774848C344EF2F10A@qq.com>
X-QQ-XMAILINFO: NvKyM24IHTKSOqe+sr6OEQ57/ThXcPLq5VD3q+dGSn5yIkMkB7VppuyNJMiU8O
         pWHzDZ9DJw99Bc9SEQVzt5pBGqmXWnJfsZIgyS6xuHd7ZmgL+/E7F/yIRN7CT9ApSdNa8UqF02Yn
         DDY0V1GBBR3Exbgtx+ZOt1Qpzvqhg9oIcznPdTdRQI/uQa97jytKU1qL/MHDkvypY7DOiGDaJfGi
         /4dsNB6R1z6gAt012/3LMDQpzTcWYRuO6kkHOO0eqg2hcddONQGB/8jsJ7UQx+elTXacngTCVkcj
         LckuheeHpNgpK8PtuesIzurLkSb18uAKbrzKylAPdJACO+ppeiJtuNmqLghjEWcJ3DgPcgLkHiZd
         X0slA9GkbrZe2wxOuzFOc6u9s4QzF/TWwYfEcSqiXeuSY33PNFZQSNHGyVheDxqOzmM82A3tE7E2
         eRhujD88xJ75COduzRRoxGMqrdQiKbZomj7tuwJx56jQSgGMNDDBmYSeDg9H2DmmpbhhvXrWcSja
         8Auwh4gX3G/uvtZn6Yj+qgobxCNDpZYjho+spTwH6hGCJICULtnJfR43Hhjt5S0bw2l4FZA/09jo
         DIQwKoCriskY7/nXT7Lyd4Q2YWhPYAj99Z11LxmoJ6ZG7DUebvx0PTpZErP+5PJ/tJye28KgNxMq
         MPacw+IjQoEEUd/rG3u75nl3PqwLUWaZ+Ja291IQkXNgVpH/d1Evl6518TqfE5e7rYBR1JATz+UV
         4A5CVeKRSq+A+AjmNSE8t+A+B3AdQT9OG1enDQ+bo/9L+AlwfNkH3bBmATgNBNmclt0BiBBiiP3S
         YgFG6Q9uufIN5fGjvuSo8FcnILsMSPeX8jB6EiUrzMoOucNR02jI61zCSTBwY9umsRu/Kb7FVUTL
         I9EMRtbdBHVffZsJiJswSu0XXqudrjlpbGqP3YaY3plpgVbFyIS3toCt4txfxXhwpa3gAAy/t3xQ
         Euvfjr+BMQH5KSXIT74WaTldFWnSrA6fpEVXaz+F9rwUVbIhOtarZCcBabSUDMj0pVLzThilW55G
         kW49Rbibw55h+MB8Gfg+iLMB985QI6mvyQtpwZwQ==
From:   Yangyu Chen <cyy@cyyself.name>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Wende Tan <twd2.me@gmail.com>, Soha Jin <soha@lohu.info>,
        Hongren Zheng <i@zenithal.me>, Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH 1/2] riscv: allow case-insensitive ISA string parsing
Date:   Tue, 25 Apr 2023 20:00:15 +0800
X-OQ-MSGID: <20230425120016.187010-2-cyy@cyyself.name>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230425120016.187010-1-cyy@cyyself.name>
References: <20230425120016.187010-1-cyy@cyyself.name>
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

According to RISC-V ISA specification, the ISA naming strings are case
insensitive. The kernel docs require the riscv,isa string must be all
lowercase to simplify parsing currently. However, this limitation is not
consistent with RISC-V ISA Spec.

This patch modifies the ISA string parser in the kernel to support
case-insensitive ISA string parsing. It replaces `strncmp` with
`strncasecmp`, replaces `islower` with `isalpha`, and wraps the
dereferenced char in the parser with `tolower`.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 arch/riscv/kernel/cpu.c        |  6 ++++--
 arch/riscv/kernel/cpufeature.c | 20 ++++++++++----------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 8400f0cc9704..531c76079b73 100644
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
@@ -228,7 +229,8 @@ static void print_isa(struct seq_file *f, const char *isa)
 
 	seq_puts(f, "isa\t\t: ");
 	/* Print the rv[64/32] part */
-	seq_write(f, isa, 4);
+	for (i = 0; i < 4; i++)
+		seq_putc(f, tolower(isa[i]));
 	for (i = 0; i < sizeof(base_riscv_exts); i++) {
 		if (__riscv_isa_extension_available(NULL, base_riscv_exts[i] - 'a'))
 			/* Print only enabled the base ISA extensions */
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 59d58ee0f68d..c01dd144addc 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -120,10 +120,10 @@ void __init riscv_fill_hwcap(void)
 
 		temp = isa;
 #if IS_ENABLED(CONFIG_32BIT)
-		if (!strncmp(isa, "rv32", 4))
+		if (!strncasecmp(isa, "rv32", 4))
 			isa += 4;
 #elif IS_ENABLED(CONFIG_64BIT)
-		if (!strncmp(isa, "rv64", 4))
+		if (!strncasecmp(isa, "rv64", 4))
 			isa += 4;
 #endif
 		/* The riscv,isa DT property must start with rv64 or rv32 */
@@ -135,7 +135,7 @@ void __init riscv_fill_hwcap(void)
 			const char *ext_end = isa;
 			bool ext_long = false, ext_err = false;
 
-			switch (*ext) {
+			switch (tolower(*ext)) {
 			case 's':
 				/**
 				 * Workaround for invalid single-letter 's' & 'u'(QEMU).
@@ -143,7 +143,7 @@ void __init riscv_fill_hwcap(void)
 				 * not valid ISA extensions. It works until multi-letter
 				 * extension starting with "Su" appears.
 				 */
-				if (ext[-1] != '_' && ext[1] == 'u') {
+				if (ext[-1] != '_' && tolower(ext[1]) == 'u') {
 					++isa;
 					ext_err = true;
 					break;
@@ -154,7 +154,7 @@ void __init riscv_fill_hwcap(void)
 				ext_long = true;
 				/* Multi-letter extension must be delimited */
 				for (; *isa && *isa != '_'; ++isa)
-					if (unlikely(!islower(*isa)
+					if (unlikely(!isalpha(*isa)
 						     && !isdigit(*isa)))
 						ext_err = true;
 				/* Parse backwards */
@@ -166,7 +166,7 @@ void __init riscv_fill_hwcap(void)
 				/* Skip the minor version */
 				while (isdigit(*--ext_end))
 					;
-				if (ext_end[0] != 'p'
+				if (tolower(ext_end[0]) != 'p'
 				    || !isdigit(ext_end[-1])) {
 					/* Advance it to offset the pre-decrement */
 					++ext_end;
@@ -178,7 +178,7 @@ void __init riscv_fill_hwcap(void)
 				++ext_end;
 				break;
 			default:
-				if (unlikely(!islower(*ext))) {
+				if (unlikely(!isalpha(*ext))) {
 					ext_err = true;
 					break;
 				}
@@ -188,7 +188,7 @@ void __init riscv_fill_hwcap(void)
 				/* Skip the minor version */
 				while (isdigit(*++isa))
 					;
-				if (*isa != 'p')
+				if (tolower(*isa) != 'p')
 					break;
 				if (!isdigit(*++isa)) {
 					--isa;
@@ -205,7 +205,7 @@ void __init riscv_fill_hwcap(void)
 #define SET_ISA_EXT_MAP(name, bit)						\
 			do {							\
 				if ((ext_end - ext == sizeof(name) - 1) &&	\
-				     !memcmp(ext, name, sizeof(name) - 1) &&	\
+				     !strncasecmp(ext, name, sizeof(name) - 1) &&	\
 				     riscv_isa_extension_check(bit))		\
 					set_bit(bit, this_isa);			\
 			} while (false)						\
@@ -213,7 +213,7 @@ void __init riscv_fill_hwcap(void)
 			if (unlikely(ext_err))
 				continue;
 			if (!ext_long) {
-				int nr = *ext - 'a';
+				int nr = tolower(*ext) - 'a';
 
 				if (riscv_isa_extension_check(nr)) {
 					this_hwcap |= isa2hwcap[nr];
-- 
2.40.0

