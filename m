Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C276C773F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 06:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbjCXFZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 01:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjCXFZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 01:25:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4194D1B548;
        Thu, 23 Mar 2023 22:24:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9638B822EC;
        Fri, 24 Mar 2023 05:24:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CB7C433A8;
        Fri, 24 Mar 2023 05:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679635451;
        bh=48PfBQrOo+QXja0Ye9RmxtH0qozaHFJkPGyXBVJ0K/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lQYVNtyW8kXyKp3WvuD38oW21w+WkkH215Y0MiUI49Y8eunz18neW0TYGpXTyqIwC
         XqFLx8+8KVgwS7YuprL35tsEcnIzjccalORzzxRDu0xqNm8Lg6qUpMBSV+wnqYH+BG
         7fVis7yLRCfwYfIGELFjWraVoK1URjTvD6qYpEyDURrJzHfXGxQSmFtgV6lkeLJQj3
         r9Q4srnlhyk6xgE8ueeU8JMnkcJholgdIrCRj7ZIMGsnzofOtELVm5WufcrZRRjtXC
         oymkdt48Gt4cjk9V6imqujHbS0ITqoYxY+5mFS1SktxcncGLDgZMXlKBtZAgEYnZ0y
         p4y+AlGsBG2aw==
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
Subject: [PATCH v2 11/14] sh: reword ARCH_FORCE_MAX_ORDER prompt and help text
Date:   Fri, 24 Mar 2023 08:22:30 +0300
Message-Id: <20230324052233.2654090-12-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230324052233.2654090-1-rppt@kernel.org>
References: <20230324052233.2654090-1-rppt@kernel.org>
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
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/sh/mm/Kconfig | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/sh/mm/Kconfig b/arch/sh/mm/Kconfig
index 40271090bd7d..fb15ba1052ba 100644
--- a/arch/sh/mm/Kconfig
+++ b/arch/sh/mm/Kconfig
@@ -19,8 +19,7 @@ config PAGE_OFFSET
 	default "0x00000000"
 
 config ARCH_FORCE_MAX_ORDER
-	int "Maximum zone order"
-	range 8 63 if PAGE_SIZE_16KB
+	int "Order of maximal physically contiguous allocations"
 	default "8" if PAGE_SIZE_16KB
 	range 6 63 if PAGE_SIZE_64KB
 	default "6" if PAGE_SIZE_64KB
@@ -28,16 +27,18 @@ config ARCH_FORCE_MAX_ORDER
 	default "13" if !MMU
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
 
 	  The page size is not necessarily 4KB. Keep this in mind when
 	  choosing a value for this option.
 
+	  Don't change if unsure.
+
 config MEMORY_START
 	hex "Physical memory start address"
 	default "0x08000000"
-- 
2.35.1

