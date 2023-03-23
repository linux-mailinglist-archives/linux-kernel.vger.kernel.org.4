Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C0F6C6330
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 10:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjCWJW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 05:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjCWJWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 05:22:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315493C3B;
        Thu, 23 Mar 2023 02:22:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A397B8201C;
        Thu, 23 Mar 2023 09:22:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 259A5C433A8;
        Thu, 23 Mar 2023 09:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679563341;
        bh=dcp30wp/Hf38sazwKthrJJR/hJsAXPYg2a1DhIjhRsY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jhevsx6FrKz/DSKyWa48ul+Br2Qq/2CdJ5Nno3oUdRcLCIk7t1cB69NdAiT1tyn5H
         Lhz9wXdd5uW6MFyeM+B3h0u5ydPTvK6l7CwpgHyUk3OAlG9W2UODv0/MJDEe3oHJOX
         /m2zMnBtkTaffkchF+6L07TdZQwBCPludGH8NHdSFGMYkW0A/qG31dPbgSSEevOGTB
         mnSJ77OEHBhaBpfgDQgrtyP3mOg3IRf23662ZNu2bRdqFbjyKhfTPTIRFNBR2BggXZ
         Y0Ifi3DaCS8c1NsQKYmG++xjhZAcZPCDklL+uk+NpDJszMuDUHYYaoRUcujltm1mXh
         pEp5mnhql9Qpg==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guo Ren <guoren@kernel.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Rapoport <rppt@kernel.org>, Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Zi Yan <ziy@nvidia.com>, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mm@kvack.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org
Subject: [PATCH 01/14] arm: reword ARCH_FORCE_MAX_ORDER prompt and help text
Date:   Thu, 23 Mar 2023 11:21:43 +0200
Message-Id: <20230323092156.2545741-2-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230323092156.2545741-1-rppt@kernel.org>
References: <20230323092156.2545741-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

The prompt and help text of ARCH_FORCE_MAX_ORDER are not even close to
describe this configuration option.

Update both to actually describe what this option does.

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/arm/Kconfig | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 929e646e84b9..0b15384c62e6 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1354,17 +1354,19 @@ config ARM_MODULE_PLTS
 	  configurations. If unsure, say y.
 
 config ARCH_FORCE_MAX_ORDER
-	int "Maximum zone order"
+	int "Order of maximal physically contiguous allocations"
 	default "11" if SOC_AM33XX
 	default "8" if SA1111
 	default "10"
 	help
-	  The kernel memory allocator divides physically contiguous memory
-	  blocks into "zones", where each zone is a power of two number of
-	  pages.  This option selects the largest power of two that the kernel
-	  keeps in the memory allocator.  If you need to allocate very large
-	  blocks of physically contiguous memory, then you may need to
-	  increase this value.
+	  The kernel page allocator limits the size of maximal physically
+	  contiguous allocations. The limit is called MAX_ORDER and it
+	  defines the maximal power of two of number of pages that can be
+	  allocated as a single contiguous block. This option allows
+	  overriding the default setting when ability to allocate very
+	  large blocks of physically contiguous memory is required.
+
+	  Don't change if unsure.
 
 config ALIGNMENT_TRAP
 	def_bool CPU_CP15_MMU
-- 
2.35.1

