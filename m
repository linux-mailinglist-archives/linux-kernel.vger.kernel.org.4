Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6435D6C34B4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 15:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbjCUOtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 10:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjCUOtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:49:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE254233;
        Tue, 21 Mar 2023 07:48:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D220961A14;
        Tue, 21 Mar 2023 14:48:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33AC7C433D2;
        Tue, 21 Mar 2023 14:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679410136;
        bh=nOjYuAtAJ+oJ6PX1M32a+RGsf1VV5zJ6P60y95eKQno=;
        h=From:To:Cc:Subject:Date:From;
        b=FveJqLJsTdxUlszzf27XECWvgGDeLI5jOdIJ0+/wTO6aegPJt5W28xY0tRgVhkjTA
         3VbZySNbS7txvPmXnf9gPtH8ZMw+oF7xysW7+C1WiXl5f+7BCUv9ZNL1dTjD0MBpfu
         uaHWL0333MUd3rKfIwuUHwED3B8qbUHWT/kITg0Gs7J/SdmuNF5q7SJc/MJVoSaIOM
         oJ3xr3ucSsoZ7h1hfp9nRbXsA50rQETKS4aByEelOqjV6pD551jz+4SXJdkZtINE45
         Xsm4AZ0l2F5VBbLBQcmbicE52ckHwOpwJq36oDJo/6Ylk40xhIiR6atv9JBxRctlKo
         yh6bN2fJZEheA==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Doug Berger <opendmb@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 01/14] mips: fix comment about pgtable_init()
Date:   Tue, 21 Mar 2023 16:48:41 +0200
Message-Id: <20230321144842.2401182-1-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

Comment about fixrange_init() says that its called from pgtable_init()
while the actual caller is pagetabe_init().

Update comment to match the code.

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 arch/mips/include/asm/fixmap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/fixmap.h b/arch/mips/include/asm/fixmap.h
index beea14761cef..b037718d7e8b 100644
--- a/arch/mips/include/asm/fixmap.h
+++ b/arch/mips/include/asm/fixmap.h
@@ -70,7 +70,7 @@ enum fixed_addresses {
 #include <asm-generic/fixmap.h>
 
 /*
- * Called from pgtable_init()
+ * Called from pagetable_init()
  */
 extern void fixrange_init(unsigned long start, unsigned long end,
 	pgd_t *pgd_base);
-- 
2.35.1

