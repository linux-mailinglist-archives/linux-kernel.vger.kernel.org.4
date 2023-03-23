Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7E96C633E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 10:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbjCWJXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 05:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbjCWJWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 05:22:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D8120A10;
        Thu, 23 Mar 2023 02:22:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9F3F62566;
        Thu, 23 Mar 2023 09:22:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB03C433A8;
        Thu, 23 Mar 2023 09:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679563356;
        bh=YegLTyBTgABVrk8X6Ho+iz90BqWsK5lqi1pUx+eF0sU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hwVWgNUmpqudVX5t/F4T7eVjm0xHfzWtg7vXKXM2ECqAoid0i5uuM9texyHvlOPEV
         lyJia9wrDlW0JFd9lMjQOEx8W0T5jd1+TJG7CJma6/ByrozwfR3fEJ+mMDIlvNLzwV
         4q5Lcyirnh53qgBO9ZpI9gkUUf+3fLcNPWxiuxAjR4abA+WGhiQ4cIT1SEY/45ykKB
         w2YMBaN6+8xqLRjCoGCUnCSqFJWz3rgKIrF+qrDiwAa5EbSopDjo2gimc/UR44IViU
         W04N0UqyO8l9zfjlSz5/GrT+ylQg8hLZO0SHJ0FWxnUAaLATArJJIMkA+D/WKft8PF
         c7ZFGS6pkh14g==
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
Subject: [PATCH 03/14] arm64: reword ARCH_FORCE_MAX_ORDER prompt and help text
Date:   Thu, 23 Mar 2023 11:21:45 +0200
Message-Id: <20230323092156.2545741-4-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230323092156.2545741-1-rppt@kernel.org>
References: <20230323092156.2545741-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
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
 arch/arm64/Kconfig | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index bab6483e4317..75af4c329224 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1487,24 +1487,24 @@ config XEN
 # 16K |       27          |      14      |       13        |         11         |
 # 64K |       29          |      16      |       13        |         13         |
 config ARCH_FORCE_MAX_ORDER
-	int "Maximum zone order" if ARM64_4K_PAGES || ARM64_16K_PAGES
+	int "Order of maximal physically contiguous allocations" if ARM64_4K_PAGES || ARM64_16K_PAGES
 	default "13" if ARM64_64K_PAGES
 	default "11" if ARM64_16K_PAGES
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
 
-	  We make sure that we can allocate up to a HugePage size for each configuration.
-	  Hence we have :
-		MAX_ORDER = PMD_SHIFT - PAGE_SHIFT  => PAGE_SHIFT - 3
+	  The maximal size of allocation cannot exceed the size of the
+	  section, so the value of MAX_ORDER should satisfy
 
-	  However for 4K, we choose a higher default value, 10 as opposed to 9, giving us
-	  4M allocations matching the default size used by generic code.
+	    MAX_ORDER + PAGE_SHIFT <= SECTION_SIZE_BITS
+
+	  Don't change if unsure.
 
 config UNMAP_KERNEL_AT_EL0
 	bool "Unmap kernel when running in userspace (aka \"KAISER\")" if EXPERT
@@ -2298,4 +2298,3 @@ endmenu # "CPU Power Management"
 source "drivers/acpi/Kconfig"
 
 source "arch/arm64/kvm/Kconfig"
-
-- 
2.35.1

