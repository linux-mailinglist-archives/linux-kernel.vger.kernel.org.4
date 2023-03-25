Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED53E6C8B8E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 07:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbjCYGLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 02:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbjCYGK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 02:10:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770261A49B;
        Fri, 24 Mar 2023 23:10:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17F83B82705;
        Sat, 25 Mar 2023 06:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34961C433D2;
        Sat, 25 Mar 2023 06:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679724618;
        bh=4Z2NWXBqkUcDOlecQgNIdEoHt3g4ySgJpa9xjP+8bWw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cQswqzYqOHsod0pqf6YFh66X/QrCAVr2YAwri/xOv3fttReIoM0QmyS0CNc7O8lfw
         iB9IiXk9UZF2X7g4y03lD7rt8tiPSQdbx5vzhgyUTdNKn7t6zEZLPPpuy8u+jYk1nB
         hreHJFycD54YdiEhqQ0HBvllQcOEdNGWjMTQ5lqG4aqa8u1V5zh0ltg8TIX82CILYd
         KQbZsSzZ3Xm5Sb7cQZr7wWsFV8B62+pKIVwZu8KuYKbvE4cZWx4VrFjgdd89Ru6LQi
         UFM2jB+uXudse6JjEI6YlpzMkLOP6KzIGAnNOl9YGWIzctd70MNq5ZFVUi6oq06Lts
         mKW75qDo8MgkQ==
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
Subject: [PATCH v3 13/14] sparc: reword ARCH_FORCE_MAX_ORDER prompt and help text
Date:   Sat, 25 Mar 2023 09:08:27 +0300
Message-Id: <20230325060828.2662773-14-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230325060828.2662773-1-rppt@kernel.org>
References: <20230325060828.2662773-1-rppt@kernel.org>
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

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
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

