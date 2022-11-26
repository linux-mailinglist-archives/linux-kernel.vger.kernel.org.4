Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1945639413
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 07:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiKZGJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 01:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiKZGJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 01:09:26 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CCF2F02D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 22:09:25 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 479DE5C00DD;
        Sat, 26 Nov 2022 01:09:25 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 26 Nov 2022 01:09:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1669442965; x=1669529365; bh=09
        Mg6EEBRTEKmXamOwdaq9np8wWtNcmlu/wFj129aKE=; b=JuIs6MYmkW8cPwn0MG
        08LGEF8qd/wseB8sUcBwcA2au8V3H2nr4FboYvj36m9UPh5h0mxCPhqZ9Eg8MSKj
        iCzP2Rnz4T2npkC7O0FhOIvhe2XUOsIyfPAU43IxHgwiuc8bMGdFmgw9yd21/FEW
        AHF2zPkCqol18NI47HLKvPs24l9Ak+PzV5MARyg7chnvbKNm5WVWWupJQLOr5cLZ
        eFncCPORXt2Eibw9cLboVV4msouFUmrzVTkR+EhMRUtzDqZ6hXiIh5hfn78xE7sA
        jui0LJtc6Eg/u+dQILurZQxaJtvgqJUzg5hqZqamUP0GesRniwmYj2gtCiVIjxTx
        ztlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1669442965; x=1669529365; bh=09Mg6EEBRTEKm
        XamOwdaq9np8wWtNcmlu/wFj129aKE=; b=LM0sSvA6v18nkF0en0CFPKqdDcT+L
        GIQsqJ8ZELFGTzRsjlwkOw4DzL49hGPn3MgOP6hrWQP3Z+C171bTSa8yeGg1JyUL
        PRYvCDeMc0XpMobdAtIfEeRQkd0gmfNn0Wq+gA6EzaAgtcmUZUUjQyl60ObBhL2D
        1BUcpAv55MQx2NwbQo3991MGY2GTOGKAoTsGqK6oVEGmSO4u1t0XRTsQx/rCrLgj
        K3cmlbv0yMgZx7IaIfxeGRfsE9EczHu+jHDVacdW0GrABwdgzpkkEcCeo9RJPlyv
        Vv9Bd/xzqt6WXiLvL8MeeiSQWPP8pYMkFJRw68mhS6KFlCCCzhOf6s1Cg==
X-ME-Sender: <xms:k62BY9UsZubETwLOwIPhBkzATVKozPW4vv7iUl_SnpVTdQc9YfAMlg>
    <xme:k62BY9mQGjjFe5Ypj9-DdffWWDAG0at37PoiBDOfOmXpCL-g7oTFcHIdI6rfVrZ-D
    nPeY9Epj0kdo0ZjpA>
X-ME-Received: <xmr:k62BY5b63m6AzsCi-4lzLg8_g-QmNc47fy54dpJmZSETzKEXZWFra8y5hye1cqud7Kydxy5cN_TWhXiKHkPZKA0lIOoNjsf6JyJSOqMTEYq5-IMWAy6g0O6cyfiYKY7vt0k_NQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrieeigdeltdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:k62BYwXiPuVA4owDxsU8798tuCUUDm_BySUSv3NmZRBSbCkeG9WfKA>
    <xmx:k62BY3l-tgncVAm97DeMiOQLw8wQXgrkBPLHokfs2yjJFw5icu288Q>
    <xmx:k62BY9crxx47zP6Oyq0ZyZMN2jmLvkW_PYn6CeKp_4fUb-DSQCRBHw>
    <xmx:la2BYxkcSFxoOP4kJ_HV34ZsQmYX2tWGE570had09vuiOr4eoTCWvA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 26 Nov 2022 01:09:22 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Cc:     Samuel Holland <samuel@sholland.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Helge Deller <deller@gmx.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>
Subject: [PATCH v2 2/2] riscv: Move cast inside kernel_mapping_[pv]a_to_[vp]a
Date:   Sat, 26 Nov 2022 00:09:20 -0600
Message-Id: <20221126060920.65009-2-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221126060920.65009-1-samuel@sholland.org>
References: <20221126060920.65009-1-samuel@sholland.org>
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

Reviewed-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v1)

 arch/riscv/include/asm/page.h | 18 +++++++++---------
 arch/riscv/mm/init.c          | 16 ++++++++--------
 2 files changed, 17 insertions(+), 17 deletions(-)

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
index 50a1b6edd491..dc1ddfa6dedc 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -926,15 +926,15 @@ static void __init pt_ops_set_early(void)
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
2.37.4

