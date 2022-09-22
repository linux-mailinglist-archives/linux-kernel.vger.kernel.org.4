Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C495E5B1F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 08:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiIVGKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 02:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiIVGKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 02:10:01 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C714577EB2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 23:10:00 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id E12DE5C013E;
        Thu, 22 Sep 2022 02:09:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 22 Sep 2022 02:09:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1663826999; x=1663913399; bh=4YJKnNXQtpUjI3Su6aVM4KgAl
        uGM+04lJqhM6atDCbU=; b=hXzwm9+pAbKhMJfsKdF8S1znhZzDuNklA8oMjLvaS
        TiMsb2MoSaH/aYZljM1BJG5h7WGGeZnj1rMPbAegz0RePzow37QH9UbojnacukP7
        gI6Su762xLbs8YsAwEiL6jNfFgX9yDnNjWj+VT1VGnEzMdYvH/19mVcK3rElZXLf
        o+hlXUomOoNMh14EcC4fFrZ6qwKh2y7ejBLMHxecUmqdPgXUudptUBYTTdcvrW7h
        7bezy3MQyc+Y7eWFteyAluhgl3ukRDCDcRNkCH4/MowR+dx2XqZEksaKdIO0Higx
        9itj3fUmhsx+RTgD4rnU5XoUAgHWcZkHEXSMPElUIFBgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1663826999; x=1663913399; bh=4YJKnNXQtpUjI3Su6aVM4KgAluGM+04lJqh
        M6atDCbU=; b=d8yVJY90xOtlxh5jKZn9VPtW8gAl3TH6wciASRedB8NvOy9SQG1
        GQVcuQGhUsPKcL2QJjE2nRWv72hCtTWDv70bYzfyuPoEN5obKmp2S3b6muNEUMXY
        qT0kJsCdNvWm9ABs3dS5PGtC2lraHOQIX590JCG9p+7j3DLoeSmFhYmeziFxe2dQ
        3M/kv8/yVD9mrS3t5PUCtt8qJUXJCnOZjilbLgclRRgZhYV16TLsFUstP0bdQQ51
        ZZzAmLr4+xmLa1/twHg+gvp5zR+JduFc0MfwHhayzqRNFIXSh0NsbjQcrl7TSe7f
        go5+uCn661XuZBpZ0Iw8wb50Kb39vral6jw==
X-ME-Sender: <xms:N_wrY5Ms1qrjrd5YApI4ENdMio90CiVQZQ1CLlhhQGjr_ux7cr43_g>
    <xme:N_wrY78otwIwf2wCIXj6W2YcQQ00xg5k6V2K7wIqlLKk3R8jF-Uv3OQcd96PKb3S9
    jhc4kOGs_OwJ1-6pg>
X-ME-Received: <xmr:N_wrY4RLDOCC1GJvoMC1d5Z9X71YKeipGkEF4i3u9PeQk60bkfVcfzb7iyBQJ7uXc0ORTYix6nS3KzpBgMarbpx5KNyUyO0pZMaXaHz2qER8AFb7LPVc6PUOhZcNdYK0TAchzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeefvddguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeekveelhfejueelleetvdejvdeffeetgeelheeujeffhefgffefkeeh
    hffhkeekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:N_wrY1srqMvVqxi4PNyxw76LYcEp7tJWs3QORl-7rlcg0MeScY33Mg>
    <xmx:N_wrYxf8tetzt6-I7LPR8EIrpogolmjp-4Fr59APuyutecTr6vvmHA>
    <xmx:N_wrYx2cE7VLg2kedOUNYSGWIfZwB56Jkf3gafOjb9uX2SzkHmoQSg>
    <xmx:N_wrYyXC_68cRu8qOTzM3XsTXzw8suBXOL8BJmMPFg80XFuG-TRUCw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Sep 2022 02:09:59 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Cc:     Samuel Holland <samuel@sholland.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@rivosinc.com>, Dao Lu <daolu@rivosinc.com>,
        Guo Ren <guoren@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: Fix build with CONFIG_CC_OPTIMIZE_FOR_SIZE=y
Date:   Thu, 22 Sep 2022 01:09:58 -0500
Message-Id: <20220922060958.44203-1-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 8eb060e10185 ("arch/riscv: add Zihintpause support") broke
building with CONFIG_CC_OPTIMIZE_FOR_SIZE enabled (gcc 11.1.0):

  CC      arch/riscv/kernel/vdso/vgettimeofday.o
In file included from <command-line>:
./arch/riscv/include/asm/jump_label.h: In function 'cpu_relax':
././include/linux/compiler_types.h:285:33: warning: 'asm' operand 0 probably does not match constraints
  285 | #define asm_volatile_goto(x...) asm goto(x)
      |                                 ^~~
./arch/riscv/include/asm/jump_label.h:41:9: note: in expansion of macro 'asm_volatile_goto'
   41 |         asm_volatile_goto(
      |         ^~~~~~~~~~~~~~~~~
././include/linux/compiler_types.h:285:33: error: impossible constraint in 'asm'
  285 | #define asm_volatile_goto(x...) asm goto(x)
      |                                 ^~~
./arch/riscv/include/asm/jump_label.h:41:9: note: in expansion of macro 'asm_volatile_goto'
   41 |         asm_volatile_goto(
      |         ^~~~~~~~~~~~~~~~~
make[1]: *** [scripts/Makefile.build:249: arch/riscv/kernel/vdso/vgettimeofday.o] Error 1
make: *** [arch/riscv/Makefile:128: vdso_prepare] Error 2

Having a static branch in cpu_relax() is problematic because that
function is widely inlined, including in some quite complex functions
like in the VDSO. A quick measurement shows this static branch is
responsible by itself for around 40% of the jump table.

Drop the static branch, which ends up being the same number of
instructions anyway. If Zihintpause is supported, we trade the nop from
the static branch for a div. If Zihintpause is unsupported, we trade the
jump from the static branch for (what gets interpreted as) a nop.

Fixes: 8eb060e10185 ("arch/riscv: add Zihintpause support")
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 arch/riscv/include/asm/hwcap.h          |  3 ---
 arch/riscv/include/asm/vdso/processor.h | 25 ++++++++++---------------
 2 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 6f59ec64175e..b21d46e68386 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -68,7 +68,6 @@ enum riscv_isa_ext_id {
  */
 enum riscv_isa_ext_key {
 	RISCV_ISA_EXT_KEY_FPU,		/* For 'F' and 'D' */
-	RISCV_ISA_EXT_KEY_ZIHINTPAUSE,
 	RISCV_ISA_EXT_KEY_MAX,
 };
 
@@ -88,8 +87,6 @@ static __always_inline int riscv_isa_ext2key(int num)
 		return RISCV_ISA_EXT_KEY_FPU;
 	case RISCV_ISA_EXT_d:
 		return RISCV_ISA_EXT_KEY_FPU;
-	case RISCV_ISA_EXT_ZIHINTPAUSE:
-		return RISCV_ISA_EXT_KEY_ZIHINTPAUSE;
 	default:
 		return -EINVAL;
 	}
diff --git a/arch/riscv/include/asm/vdso/processor.h b/arch/riscv/include/asm/vdso/processor.h
index 1e4f8b4aef79..789bdb8211a2 100644
--- a/arch/riscv/include/asm/vdso/processor.h
+++ b/arch/riscv/include/asm/vdso/processor.h
@@ -4,30 +4,25 @@
 
 #ifndef __ASSEMBLY__
 
-#include <linux/jump_label.h>
 #include <asm/barrier.h>
-#include <asm/hwcap.h>
 
 static inline void cpu_relax(void)
 {
-	if (!static_branch_likely(&riscv_isa_ext_keys[RISCV_ISA_EXT_KEY_ZIHINTPAUSE])) {
 #ifdef __riscv_muldiv
-		int dummy;
-		/* In lieu of a halt instruction, induce a long-latency stall. */
-		__asm__ __volatile__ ("div %0, %0, zero" : "=r" (dummy));
+	int dummy;
+	/* In lieu of a halt instruction, induce a long-latency stall. */
+	__asm__ __volatile__ ("div %0, %0, zero" : "=r" (dummy));
 #endif
-	} else {
-		/*
-		 * Reduce instruction retirement.
-		 * This assumes the PC changes.
-		 */
+	/*
+	 * Reduce instruction retirement.
+	 * This assumes the PC changes.
+	 */
 #ifdef __riscv_zihintpause
-		__asm__ __volatile__ ("pause");
+	__asm__ __volatile__ ("pause");
 #else
-		/* Encoding of the pause instruction */
-		__asm__ __volatile__ (".4byte 0x100000F");
+	/* Encoding of the pause instruction */
+	__asm__ __volatile__ (".4byte 0x100000F");
 #endif
-	}
 	barrier();
 }
 
-- 
2.35.1

