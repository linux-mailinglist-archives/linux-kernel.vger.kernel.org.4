Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42F25E5AFB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 07:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiIVFsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 01:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiIVFrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 01:47:53 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19607B440E
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 22:47:51 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 0FC623200A1A;
        Thu, 22 Sep 2022 01:47:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 22 Sep 2022 01:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1663825668; x=1663912068; bh=Uq
        jCW3qPBJkpy6ChCD9FJVMBBqKF8phiOGscINT6xB0=; b=dZRNitQI2aetBfKvpa
        qTSXiJOSCa38zRkjxJE7qkICjlv+38VuhY/E9skWqJ5ikbXls2e5OyBrR21P0/Vv
        yGzMhHLA6CH9kNym0aYydBa0w6J7dyU0kl++3QxdekvAtmgieitEyreyxh4NCCwl
        noytZ+NpLMMcSDPhXZnQpUdC41DJmSyg1nNewR59P3uIY3BX8cjhaYrwmePHM56V
        TUy8e6+TDVrsQX7BNit+u1yIBrf87QQtUIpiHy4ZBbbTp2IchdramdAMYJFQ8xeY
        rNps6qMHq9QNbfqn1TtupFeR/knKF3xVAFvidzeyWDoPPjAEdMk+CJ8VNLGPnzwa
        KuqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1663825668; x=1663912068; bh=UqjCW3qPBJkpy
        6ChCD9FJVMBBqKF8phiOGscINT6xB0=; b=PsJgMrr27dcYOsBK1FLrzsHmHdrNv
        0EGKdXYrmHeJi/oA41c9NBX9uS3l+FbgkI9hz7DdLHc+P8AjUIyEJozjOMTcM2sh
        Dze3u5fN7pye1lzdzXsNJBA0yoS+t5ZHA8eYKSpN1+LPdOvMLAoOKneLocNe7sRG
        DIprfs4gVoqb8fxM+vaG7qCKIq2MoYrjcGK8zTVpoZtn9QabjL1V07PmffgRTbAv
        XC/90VvXX+RbKIxhifMzJIcKffZj3GbbpmSCg4SWqH4jd3VPxamLRokAjXUC3nJV
        PtTKJfWFHqdyh9P5TKe3FSdlcd51pRKx8S9aqqhKyzyzAPg2HPPnFTxHQ==
X-ME-Sender: <xms:A_crY6W08ldBV5P5QlrrCGK_Sl8u4mS2wd33qgBWkh6dtHigoGZ6Uw>
    <xme:A_crY2lEtWYqOJkLc01T-dpnXkKPzps2SAeIyq9ZZgboKDVGXTlZgCs2WTPdakbE2
    LdmAyZnW_Gx3Ys1-w>
X-ME-Received: <xmr:A_crY-bO0KwfbA3d1i13w-oHD3ZirM3peCS9j8z_bayRXu9jQpJW8s37NIvz1VvDeAlvSAyd3QiSSw8hytLOs42R0q-pyePxXXgCDzvF171og2gjtkRBHBhYpj9xzHCSf5VD7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeefvddgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:A_crYxUotqNy2JLCt4vMNYtN2guiShbkUByk44FTgLqIokIrF4J0xQ>
    <xmx:A_crY0mzMcId4Mx6pChUkQgmzS1qoP5Gkz-yrWOpc0DE5Pk77GNubg>
    <xmx:A_crY2eIb2wiZNHdjimOamgqpq_NqE4UykUs87LlUqajI8bwXV5UGA>
    <xmx:BPcrYymXR3UPUhEKE8V59CoXTRsc2V-0qdd2EXt_Qcko18RLB-FIPw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Sep 2022 01:47:46 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Cc:     Samuel Holland <samuel@sholland.org>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        Tong Tiangen <tongtiangen@huawei.com>
Subject: [PATCH 2/2] riscv: Move cast inside kernel_mapping_[pv]a_to_[vp]a
Date:   Thu, 22 Sep 2022 00:47:42 -0500
Message-Id: <20220922054743.30159-2-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220922054743.30159-1-samuel@sholland.org>
References: <20220922054743.30159-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before commit 44c922572952 ("RISC-V: enable XIP"), these macros cast
their argument to unsigned long. That commit moved the cast after an
assignment to an unsigned long variable, rendering it ineffectual.
Move the cast back, so we can remove the cast at each call site.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 arch/riscv/errata/thead/errata.c |  4 ++--
 arch/riscv/include/asm/page.h    | 18 +++++++++---------
 arch/riscv/mm/init.c             | 16 ++++++++--------
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
index 83174f13783e..38c2c6b0f6b8 100644
--- a/arch/riscv/errata/thead/errata.c
+++ b/arch/riscv/errata/thead/errata.c
@@ -76,8 +76,8 @@ void __init_or_module thead_errata_patch_func(struct alt_entry *begin, struct al
 		if (cpu_req_errata & tmp) {
 			/* On vm-alternatives, the mmu isn't running yet */
 			if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
-				memcpy((void *)kernel_mapping_va_to_pa((unsigned long)alt->old_ptr),
-				       (void *)kernel_mapping_va_to_pa((unsigned long)alt->alt_ptr),
+				memcpy((void *)kernel_mapping_va_to_pa(alt->old_ptr),
+				       (void *)kernel_mapping_va_to_pa(alt->alt_ptr),
 				       alt->alt_len);
 			else
 				patch_text_nosync(alt->old_ptr, alt->alt_ptr, alt->alt_len);
diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index ac70b0fd9a9a..9f432c1b5289 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -123,20 +123,20 @@ extern phys_addr_t phys_ram_base;
 	((x) >= PAGE_OFFSET && (!IS_ENABLED(CONFIG_64BIT) || (x) < PAGE_OFFSET + KERN_VIRT_SIZE))
 
 #define linear_mapping_pa_to_va(x)	((void *)((unsigned long)(x) + kernel_map.va_pa_offset))
-#define kernel_mapping_pa_to_va(y)	({						\
-	unsigned long _y = y;								\
-	(IS_ENABLED(CONFIG_XIP_KERNEL) && _y < phys_ram_base) ?					\
-		(void *)((unsigned long)(_y) + kernel_map.va_kernel_xip_pa_offset) :		\
-		(void *)((unsigned long)(_y) + kernel_map.va_kernel_pa_offset + XIP_OFFSET);	\
+#define kernel_mapping_pa_to_va(y)	({					\
+	unsigned long _y = (unsigned long)(y);					\
+	(IS_ENABLED(CONFIG_XIP_KERNEL) && _y < phys_ram_base) ?			\
+		(void *)(_y + kernel_map.va_kernel_xip_pa_offset) :		\
+		(void *)(_y + kernel_map.va_kernel_pa_offset + XIP_OFFSET);	\
 	})
 #define __pa_to_va_nodebug(x)		linear_mapping_pa_to_va(x)
 
 #define linear_mapping_va_to_pa(x)	((unsigned long)(x) - kernel_map.va_pa_offset)
 #define kernel_mapping_va_to_pa(y) ({						\
-	unsigned long _y = y;							\
-	(IS_ENABLED(CONFIG_XIP_KERNEL) && _y < kernel_map.virt_addr + XIP_OFFSET) ?	\
-		((unsigned long)(_y) - kernel_map.va_kernel_xip_pa_offset) :		\
-		((unsigned long)(_y) - kernel_map.va_kernel_pa_offset - XIP_OFFSET);	\
+	unsigned long _y = (unsigned long)(y);					\
+	(IS_ENABLED(CONFIG_XIP_KERNEL) && _y < kernel_map.virt_addr + XIP_OFFSET) ? \
+		(_y - kernel_map.va_kernel_xip_pa_offset) :			\
+		(_y - kernel_map.va_kernel_pa_offset - XIP_OFFSET);		\
 	})
 
 #define __va_to_pa_nodebug(x)	({						\
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index b56a0a75533f..7d59516ce6b3 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -927,15 +927,15 @@ static void __init pt_ops_set_early(void)
  */
 static void __init pt_ops_set_fixmap(void)
 {
-	pt_ops.alloc_pte = kernel_mapping_pa_to_va((uintptr_t)alloc_pte_fixmap);
-	pt_ops.get_pte_virt = kernel_mapping_pa_to_va((uintptr_t)get_pte_virt_fixmap);
+	pt_ops.alloc_pte = kernel_mapping_pa_to_va(alloc_pte_fixmap);
+	pt_ops.get_pte_virt = kernel_mapping_pa_to_va(get_pte_virt_fixmap);
 #ifndef __PAGETABLE_PMD_FOLDED
-	pt_ops.alloc_pmd = kernel_mapping_pa_to_va((uintptr_t)alloc_pmd_fixmap);
-	pt_ops.get_pmd_virt = kernel_mapping_pa_to_va((uintptr_t)get_pmd_virt_fixmap);
-	pt_ops.alloc_pud = kernel_mapping_pa_to_va((uintptr_t)alloc_pud_fixmap);
-	pt_ops.get_pud_virt = kernel_mapping_pa_to_va((uintptr_t)get_pud_virt_fixmap);
-	pt_ops.alloc_p4d = kernel_mapping_pa_to_va((uintptr_t)alloc_p4d_fixmap);
-	pt_ops.get_p4d_virt = kernel_mapping_pa_to_va((uintptr_t)get_p4d_virt_fixmap);
+	pt_ops.alloc_pmd = kernel_mapping_pa_to_va(alloc_pmd_fixmap);
+	pt_ops.get_pmd_virt = kernel_mapping_pa_to_va(get_pmd_virt_fixmap);
+	pt_ops.alloc_pud = kernel_mapping_pa_to_va(alloc_pud_fixmap);
+	pt_ops.get_pud_virt = kernel_mapping_pa_to_va(get_pud_virt_fixmap);
+	pt_ops.alloc_p4d = kernel_mapping_pa_to_va(alloc_p4d_fixmap);
+	pt_ops.get_p4d_virt = kernel_mapping_pa_to_va(get_p4d_virt_fixmap);
 #endif
 }
 
-- 
2.35.1

