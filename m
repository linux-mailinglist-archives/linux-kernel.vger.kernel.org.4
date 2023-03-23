Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1446C6380
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 10:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjCWJ1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 05:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjCWJ02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 05:26:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24541E1DF;
        Thu, 23 Mar 2023 02:23:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E71C362566;
        Thu, 23 Mar 2023 09:23:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57854C433A0;
        Thu, 23 Mar 2023 09:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679563432;
        bh=h6B+59Tw/wfggMAxASThb2CqM8SDBv67+wW2LDMN9Jw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bXT7tVFQRhfcw151cmushy4biLsPbWo6PzWcZLPclsdZZu0AHI/gHXPCin5Sg9iiA
         2jk1L0YVy7Qe/xDRPG5nOHZxPuEwCxatggeE5zw2R5dQXNP451ThM1w/k3c6D25V2O
         N+fe/J9ocQzrTj5ZRLDbYNoj8L7Fg7BoJUvOHZovfKRiaVzD97DUE5sICsn6MFA/LY
         pi2Jmg0MAtEvLy9L7TPVXS9dEOiqkceSsUxLk5XOUJZY6EZeficShFvwWbnG3PVgeZ
         ReZTduniWcIdQc0MmOkZSG5un3YfSersJkiDN7rNBFhp80ssYVvFAzH/URVEBtzC7R
         bB6ljs+LiityQ==
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
Subject: [PATCH 13/14] sparc: reword ARCH_FORCE_MAX_ORDER prompt and help text
Date:   Thu, 23 Mar 2023 11:21:55 +0200
Message-Id: <20230323092156.2545741-14-rppt@kernel.org>
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
 arch/sparc/Kconfig | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index e3242bf5a8df..959e43a1aaca 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -270,15 +270,17 @@ config ARCH_SPARSEMEM_DEFAULT
 	def_bool y if SPARC64
 
 config ARCH_FORCE_MAX_ORDER
-	int "Maximum zone order"
+	int "Order of maximal physically contiguous allocations"
 	default "12"
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
 
 if SPARC64 || COMPILE_TEST
 source "kernel/power/Kconfig"
-- 
2.35.1

