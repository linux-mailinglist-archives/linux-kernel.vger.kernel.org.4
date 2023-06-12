Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1547372BD21
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbjFLJyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbjFLJx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:53:29 -0400
X-Greylist: delayed 123053 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 12 Jun 2023 02:38:06 PDT
Received: from out203-205-251-59.mail.qq.com (out203-205-251-59.mail.qq.com [203.205.251.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4CD46BE
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1686562683;
        bh=s6XBGJLFDIA4i1XdtLnkKdSXoeV5/zfMkKiTPC68IaU=;
        h=From:To:Cc:Subject:Date;
        b=PIcws3IVLjS6vd7yr8lLVTf5q7B4awTJCZg+R3Hjq9QfJkICQRbz3fOdnLK4Pm1EW
         5gehc2/OJ4cRP8aEqookz/cojD5FTCn09gqDc+ZsWLNHi65386Mj8u2djODCG2rT7s
         5OktNaWSJsxHpIjQkzNjwzZprCkSVzOHS5q2AC+4=
Received: from localhost ([101.224.149.128])
        by newxmesmtplogicsvrszb1-0.qq.com (NewEsmtp) with SMTP
        id 981AAA17; Mon, 12 Jun 2023 17:38:01 +0800
X-QQ-mid: xmsmtpt1686562681tjmlmxqn2
Message-ID: <tencent_97F6C19BAF7C99B22BB1199FE16B266C2B07@qq.com>
X-QQ-XMAILINFO: NojR6Ao/DkEDhsybSq2JeQyE0+0bI18FwXwaK3SWz5OdqeG6o9vE1E6fMXzdAG
         WtfYjUyEkGG2kZ14Ux4Ds+SAYYn3tA1jK2J2Th6oBcNFRMAYe4U3wKZthLKYN4TmIDxtoCUxCqFQ
         obBnH5kBhUuuHfCwAuw7cMhcX4rPLEXMn+VIZ2RXvrkxQZjICrpFh+w7HDqGMZ/tRqC9JzPwZPla
         bPTAva+duFdFKI6+aeYjyl/91pzeXkvo3zuORq1Dz2wHPACu2TNLL4G+bufjNTLMsSwApZa5DSwU
         jexK2Di8dtTTX6dQKvQJfg0n3FYYTNbUrlwUFKQNfMDyQJo8STar2kXJbDxswORVqfVxbc2zqUv0
         Hel+gqFlMPc7VrlHM0i2fdTBgECgMbi379AzR7eeQcZ5lk4R1mch4Fg5azoEHgnZiOK6TePQGOXX
         +XEUDFThdMXNetyYVzMGkxu/wRUQU4zqwzwKn6Hag2U+DzgEsaF08jmRZ8jL1MdWgmXaOQaA6KU8
         ANZwnHTQYrvCIb182YEHPbodDy1Yl0IDDXr4mkWZf1C7s4x8Z+0VMXLN3rmFWxoPPcf+iBchIVyi
         KDYEHw/QUUwEKHdkXeWQORhD2mmPeNEE6vf/JYyPQYk95Xg+8kn+PuUAfMSXP2iXLCAEO5H1CihT
         WJ0U8xRD1tQ3lTs12+8eFXaDZA2zjWBMCljsZ+XK/aqsNrWzN7evmi2IECGcTTSfIb86iTgwFun6
         cJ3rGimBxn06eCA2mejs1gbp2w3XkyzrnBoT6shwjAXadEsxujsgkFHCXXYBGyIsFMwNEsViz7Yo
         8kD9uf33+Xrdcf/E0yIka1HcJw8VGRrNho9wznheKJF6z4QPClH4jRuW9yUrCeaqabb5bbZtnPkR
         mynX81zfGRW1MFKyjDwHPG31p/31+ogQxlLHmh4kZNz3OJyg8kbdsRwcEfgwqyAHUvmQcQ0ofEbV
         SQsv7aKXwdzUKbu5ylek+vtn570fIo
X-QQ-XMAILREADINFO: ONta/cS8wke6NG0jKFLbKjU=
From:   Woody Zhang <woodylab@foxmail.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Woody Zhang <woodylab@foxmail.com>
Subject: [PATCH v2] riscv: move memblock_allow_resize() after linear mapping is ready
Date:   Mon, 12 Jun 2023 17:37:38 +0800
X-OQ-MSGID: <20230612093738.1793433-1-woodylab@foxmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The initial memblock metadata is accessed from kernel image mapping. The
regions arrays need to "reallocated" from memblock and accessed through
linear mapping to cover more memblock regions. So the resizing should
not be allowed until linear mapping is ready. Note that there are
memblock allocations when building linear mapping.

This patch is similar to 24cc61d8cb5a ("arm64: memblock: don't permit
memblock resizing until linear mapping is up").

Fixes: 671f9a3e2e24 ("RISC-V: Setup initial page tables in two stages")
Signed-off-by: Woody Zhang <woodylab@foxmail.com>
---
Changes in v2:
 - Refine commit log

---
 arch/riscv/mm/init.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 4fa420faa780..57874f89dce2 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -267,7 +267,6 @@ static void __init setup_bootmem(void)
 	dma_contiguous_reserve(dma32_phys_limit);
 	if (IS_ENABLED(CONFIG_64BIT))
 		hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
-	memblock_allow_resize();
 }
 
 #ifdef CONFIG_MMU
@@ -1284,6 +1283,9 @@ static void __init setup_vm_final(void)
 	csr_write(CSR_SATP, PFN_DOWN(__pa_symbol(swapper_pg_dir)) | satp_mode);
 	local_flush_tlb_all();
 
+	/* Depend on that Linear Mapping is ready */
+	memblock_allow_resize();
+
 	pt_ops_set_late();
 }
 #else
-- 
2.39.2

